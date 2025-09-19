#pragma once

#include "cpp_bmad_classes.h"
#include "fortran_arrays.hpp"
#include "tao_proxies.hpp"

#include <complex>
#include <iterator>
#include <memory>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

extern "C" {
// Forward declarations for Fortran interface
// ${c_forward_declarations}

// Global functions (index-based, only for initial access)
int tao_get_n_universes();
void* tao_c_get_universe_ptr(int ix_uni);
void* tao_c_get_tao_lattice_ptr(int ix_uni, int ix_lat);
void* tao_c_get_lattice_ptr(int ix_uni, int ix_lat);
void* tao_c_get_branch_ptr(int ix_uni, int ix_lat, int ix_branch);
void* tao_c_get_element_ptr(int ix_uni, int ix_lat, int ix_branch, int ix_ele);

// Pointer-based functions (efficient access using C pointers)
int tao_lat_get_n_branches(void* lat_ptr);
void* tao_lat_get_branch_ptr(void* lat_ptr, int ix_branch);
int tao_branch_get_n_elements(void* branch_ptr);
void* tao_branch_get_element_ptr(void* branch_ptr, int ix_ele);
}

namespace tao {

// Lattice type enumeration
enum class LatticeType : int { MODEL = 1, DESIGN = 2, BASE = 3 };

// Exception classes
class TaoException : public std::runtime_error {
 public:
  explicit TaoException(const std::string& message)
      : std::runtime_error(message) {}
};

class InvalidIndexException : public TaoException {
 public:
  InvalidIndexException(const std::string& index_type, int index, int max_value)
      : TaoException(
            "Invalid " + index_type + " index " + std::to_string(index) +
            " (valid range: 0-" + std::to_string(max_value - 1) + ")") {}
};

class NullPointerException : public TaoException {
 public:
  NullPointerException(const std::string& context)
      : TaoException("Null pointer encountered in " + context) {}
};

// Forward declarations
class TaoUniverseProxy;
class LatticeProxy;
class BranchProxy;
class EleProxy;
// ${class_forward_declarations}

// Non-Tao proxy classes that directly reference Fortran memory
class EleProxy {
 private:
  void* fortran_ptr_;

  void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit EleProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("EleProxy constructor");
    }
  }

  std::shared_ptr<CPP_ele> deepcopy() const {
    auto ele = std::make_shared<CPP_ele>();
    ele_to_c(static_cast<Opaque_ele_class*>(fortran_ptr_), *ele);
    return ele;
  }

  // ${ele_struct_class_body}
};

class BranchProxy {
 private:
  void* fortran_ptr_;

  void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BranchProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  EleProxy get_element(int ix_ele) const {
    int n_elements = tao_branch_get_n_elements(fortran_ptr_);
    if (n_elements < 0) {
      throw TaoException("Failed to get number of elements from branch");
    }
    if (ix_ele < 0 || ix_ele >= n_elements) {
      throw InvalidIndexException("element", ix_ele, n_elements);
    }

    void* ele_ptr = tao_branch_get_element_ptr(fortran_ptr_, ix_ele);
    if (!ele_ptr) {
      throw NullPointerException(
          "get_element for index " + std::to_string(ix_ele));
    }
    return EleProxy(ele_ptr);
  }

  int get_n_elements() const {
    int n = tao_branch_get_n_elements(fortran_ptr_);
    if (n < 0) {
      throw TaoException("Failed to get number of elements from branch");
    }
    return n;
  }

  // ${branch_struct_class_body}
};

class LatticeProxy {
 private:
  void* fortran_ptr_;

  void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LatticeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("LatticeProxy constructor");
    }
  }

  BranchProxy get_branch(int ix_branch) const {
    int n_branches = tao_lat_get_n_branches(fortran_ptr_);
    if (n_branches < 0) {
      throw TaoException("Failed to get number of branches from lattice");
    }
    if (ix_branch < 0 || ix_branch >= n_branches) {
      throw InvalidIndexException("branch", ix_branch, n_branches);
    }

    void* branch_ptr = tao_lat_get_branch_ptr(fortran_ptr_, ix_branch);
    if (!branch_ptr) {
      throw NullPointerException(
          "get_branch for index " + std::to_string(ix_branch));
    }
    return BranchProxy(branch_ptr);
  }

  int get_n_branches() const {
    int n = tao_lat_get_n_branches(fortran_ptr_);
    if (n < 0) {
      throw TaoException("Failed to get number of branches from lattice");
    }
    return n;
  }

  // ${lat_struct_class_body}
};

// ${other_proxy_classes}

// Tao proxy classes for navigating the hierarchy
// TaoElementIndexProxy does not map onto a specific Tao struct
// TaoUniverseProxy maps onto tao_universe_struct
class TaoElementIndexProxy {
 private:
  int ix_uni_, ix_lat_, ix_branch_, ix_ele_;

  // void* get_fortran_ptr_() const {
  //   return fortran_ptr_;
  // }

 public:
  TaoElementIndexProxy(
      int ix_uni,
      LatticeType lattice_type,
      int ix_branch,
      int ix_ele)
      : ix_uni_(ix_uni),
        ix_lat_(static_cast<int>(lattice_type)),
        ix_branch_(ix_branch),
        ix_ele_(ix_ele) {}

  EleProxy operator*() const {
    void* ele_ptr =
        tao_c_get_element_ptr(ix_uni_, ix_lat_, ix_branch_, ix_ele_);
    if (!ele_ptr) {
      throw NullPointerException(
          "TaoElementIndexProxy dereference for ix_uni=" +
          std::to_string(ix_uni_) + " ix_lat=" + std::to_string(ix_lat_) +
          " ix_branch=" + std::to_string(ix_branch_) +
          " ix_ele=" + std::to_string(ix_ele_) + "");
    }
    return EleProxy(ele_ptr);
  }

  std::unique_ptr<EleProxy> operator->() const {
    return std::make_unique<EleProxy>(**this);
  }
};

class TaoBranchIndexProxy {
 private:
  int ix_uni_, ix_lat_, ix_branch_;

 public:
  TaoBranchIndexProxy(int ix_uni, LatticeType lattice_type, int ix_branch)
      : ix_uni_(ix_uni),
        ix_lat_(static_cast<int>(lattice_type)),
        ix_branch_(ix_branch) {}

  BranchProxy operator*() const {
    void* branch_ptr = tao_c_get_branch_ptr(ix_uni_, ix_lat_, ix_branch_);
    if (!branch_ptr) {
      throw NullPointerException(
          "TaoBranchIndexProxy dereference for [" + std::to_string(ix_uni_) +
          "," + std::to_string(ix_lat_) + "," + std::to_string(ix_branch_) +
          "]");
    }
    return BranchProxy(branch_ptr);
  }

  std::unique_ptr<BranchProxy> operator->() const {
    return std::make_unique<BranchProxy>(**this);
  }

  TaoElementIndexProxy get_element(int ix_ele) const {
    return TaoElementIndexProxy(
        ix_uni_, static_cast<LatticeType>(ix_lat_), ix_branch_, ix_ele);
  }
};

class TaoLatticeIndexProxy {
 private:
  int ix_uni_, ix_lat_;

  void* get_fortran_ptr_() const {
    void* lat_ptr = tao_c_get_tao_lattice_ptr(ix_uni_, ix_lat_);
    if (!lat_ptr) {
      throw NullPointerException(
          "TaoLatticeIndexProxy dereference for [" + std::to_string(ix_uni_) +
          "," + std::to_string(ix_lat_) + "]");
    }
    return lat_ptr;
  }

 public:
  TaoLatticeIndexProxy(int ix_uni, LatticeType lattice_type)
      : ix_uni_(ix_uni), ix_lat_(static_cast<int>(lattice_type)) {}

  TaoBranchIndexProxy get_branch(int ix_branch) const {
    return TaoBranchIndexProxy(
        ix_uni_, static_cast<LatticeType>(ix_lat_), ix_branch);
  }

  TaoLatticeProxy operator*() const {
    void* lat_ptr = tao_c_get_lattice_ptr(ix_uni_, ix_lat_);
    if (!lat_ptr) {
      throw NullPointerException(
          "TaoLatticeProxy dereference for [" + std::to_string(ix_uni_) + "," +
          std::to_string(ix_lat_) + "]");
    }
    return TaoLatticeProxy(lat_ptr);
  }
  std::unique_ptr<TaoLatticeProxy> operator->() const {
    return std::make_unique<TaoLatticeProxy>(**this);
  }
};

class TaoUniverseIndexProxy {
 private:
  int ix_uni_;

  void* get_fortran_ptr_() const {
    void* uni_ptr = tao_c_get_universe_ptr(ix_uni_);
    if (!uni_ptr) {
      throw NullPointerException(
          "TaoUniverseIndexProxy dereference for universe " +
          std::to_string(ix_uni_));
    }
    return uni_ptr;
  }

 public:
  explicit TaoUniverseIndexProxy(int ix_uni) : ix_uni_(ix_uni) {}

  TaoUniverseProxy operator*() const;
  std::unique_ptr<TaoUniverseProxy> operator->() const {
    return std::make_unique<TaoUniverseProxy>(**this);
  }

  TaoLatticeIndexProxy get_lattice(LatticeType lattice_type) const {
    return TaoLatticeIndexProxy(ix_uni_, lattice_type);
  }
};

} // namespace tao
