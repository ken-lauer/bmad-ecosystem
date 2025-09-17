#pragma once

#include "tao_proxies.hpp"

#include <iterator>
#include <memory>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

// Forward declarations for Fortran interface
extern "C" {
// ${forward_declarations}

// Global functions (index-based, only for initial access)
int tao_get_n_universes();
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

// Template wrapper for 1D arrays
template <typename T>
class FortranArray1D {
 private:
  T* data_;
  int size_;
  int lower_bound_;
  int upper_bound_;
  bool valid_;

 public:
  // Constructor
  FortranArray1D(T* data, int size, int lower, int upper, bool valid)
      : data_(data),
        size_(size),
        lower_bound_(lower),
        upper_bound_(upper),
        valid_(valid) {}

  // Default constructor for invalid arrays
  FortranArray1D()
      : data_(nullptr),
        size_(0),
        lower_bound_(0),
        upper_bound_(-1),
        valid_(false) {}

  // Fortran-style indexing (using bounds)
  T& operator()(int i) {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < lower_bound_ || i > upper_bound_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [" +
          std::to_string(lower_bound_) + "," + std::to_string(upper_bound_) +
          "]");
    }
    return data_[i - lower_bound_];
  }

  const T& operator()(int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < lower_bound_ || i > upper_bound_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [" +
          std::to_string(lower_bound_) + "," + std::to_string(upper_bound_) +
          "]");
    }
    return data_[i - lower_bound_];
  }

  // C-style indexing (0-based)
  T& operator[](int i) {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
    return data_[i];
  }

  const T& operator[](int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
    return data_[i];
  }

  // Safe access methods
  T& at(int i) {
    return operator[](i);
  }
  const T& at(int i) const {
    return operator[](i);
  }

  T& at_fortran(int i) {
    return operator()(i);
  }
  const T& at_fortran(int i) const {
    return operator()(i);
  }

  // Array properties
  bool is_valid() const {
    return valid_;
  }
  int size() const {
    return size_;
  }
  std::pair<int, int> bounds() const {
    return {lower_bound_, upper_bound_};
  }
  int lower_bound() const {
    return lower_bound_;
  }
  int upper_bound() const {
    return upper_bound_;
  }

  // Raw data access
  T* data() {
    return valid_ ? data_ : nullptr;
  }
  const T* data() const {
    return valid_ ? data_ : nullptr;
  }

  // Iterator support for C++ range-based loops
  T* begin() {
    return valid_ ? data_ : nullptr;
  }
  T* end() {
    return valid_ ? data_ + size_ : nullptr;
  }
  const T* begin() const {
    return valid_ ? data_ : nullptr;
  }
  const T* end() const {
    return valid_ ? data_ + size_ : nullptr;
  }
  const T* cbegin() const {
    return begin();
  }
  const T* cend() const {
    return end();
  }

  // Convert to std::vector (copies data)
  std::vector<T> to_vector() const {
    if (!valid_)
      return std::vector<T>();
    return std::vector<T>(data_, data_ + size_);
  }

  // Empty check
  bool empty() const {
    return !valid_ || size_ == 0;
  }
};

// Template wrapper for 2D arrays
template <typename T>
class FortranArray2D {
 private:
  T* data_;
  int dim1_size_, dim1_lower_, dim1_upper_;
  int dim2_size_, dim2_lower_, dim2_upper_;
  int stride1_, stride2_;
  bool valid_;

  // Helper to compute linear index
  int linear_index(int i, int j) const {
    return (i - dim1_lower_) * stride1_ + (j - dim2_lower_) * stride2_;
  }

 public:
  // Constructor
  FortranArray2D(
      T* data,
      int dim1_size,
      int dim1_lower,
      int dim1_upper,
      int dim2_size,
      int dim2_lower,
      int dim2_upper,
      int stride1,
      int stride2,
      bool valid)
      : data_(data),
        dim1_size_(dim1_size),
        dim1_lower_(dim1_lower),
        dim1_upper_(dim1_upper),
        dim2_size_(dim2_size),
        dim2_lower_(dim2_lower),
        dim2_upper_(dim2_upper),
        stride1_(stride1),
        stride2_(stride2),
        valid_(valid) {}

  // Default constructor for invalid arrays
  FortranArray2D()
      : data_(nullptr),
        dim1_size_(0),
        dim1_lower_(0),
        dim1_upper_(-1),
        dim2_size_(0),
        dim2_lower_(0),
        dim2_upper_(-1),
        stride1_(0),
        stride2_(0),
        valid_(false) {}

  // Fortran-style indexing (using bounds)
  T& operator()(int i, int j) {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < dim1_lower_ || i > dim1_upper_) {
      throw std::out_of_range(
          "Array dim1 index out of bounds: " + std::to_string(i) + " not in [" +
          std::to_string(dim1_lower_) + "," + std::to_string(dim1_upper_) +
          "]");
    }
    if (j < dim2_lower_ || j > dim2_upper_) {
      throw std::out_of_range(
          "Array dim2 index out of bounds: " + std::to_string(j) + " not in [" +
          std::to_string(dim2_lower_) + "," + std::to_string(dim2_upper_) +
          "]");
    }
    return data_[linear_index(i, j)];
  }

  const T& operator()(int i, int j) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < dim1_lower_ || i > dim1_upper_) {
      throw std::out_of_range(
          "Array dim1 index out of bounds: " + std::to_string(i) + " not in [" +
          std::to_string(dim1_lower_) + "," + std::to_string(dim1_upper_) +
          "]");
    }
    if (j < dim2_lower_ || j > dim2_upper_) {
      throw std::out_of_range(
          "Array dim2 index out of bounds: " + std::to_string(j) + " not in [" +
          std::to_string(dim2_lower_) + "," + std::to_string(dim2_upper_) +
          "]");
    }
    return data_[linear_index(i, j)];
  }

  // C-style indexing (0-based) - treats as row-major
  T& at(int i, int j) {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= dim1_size_) {
      throw std::out_of_range(
          "Array dim1 index out of bounds: " + std::to_string(i) +
          " not in [0," + std::to_string(dim1_size_ - 1) + "]");
    }
    if (j < 0 || j >= dim2_size_) {
      throw std::out_of_range(
          "Array dim2 index out of bounds: " + std::to_string(j) +
          " not in [0," + std::to_string(dim2_size_ - 1) + "]");
    }
    return data_[i * stride1_ + j * stride2_];
  }

  const T& at(int i, int j) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= dim1_size_) {
      throw std::out_of_range(
          "Array dim1 index out of bounds: " + std::to_string(i) +
          " not in [0," + std::to_string(dim1_size_ - 1) + "]");
    }
    if (j < 0 || j >= dim2_size_) {
      throw std::out_of_range(
          "Array dim2 index out of bounds: " + std::to_string(j) +
          " not in [0," + std::to_string(dim2_size_ - 1) + "]");
    }
    return data_[i * stride1_ + j * stride2_];
  }

  // Safe Fortran-style access
  T& at_fortran(int i, int j) {
    return operator()(i, j);
  }
  const T& at_fortran(int i, int j) const {
    return operator()(i, j);
  }

  // Array properties
  bool is_valid() const {
    return valid_;
  }
  std::pair<int, int> size() const {
    return {dim1_size_, dim2_size_};
  }
  int size(int dim) const {
    if (dim == 1)
      return dim1_size_;
    if (dim == 2)
      return dim2_size_;
    throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
  }

  std::pair<std::pair<int, int>, std::pair<int, int>> bounds() const {
    return {{dim1_lower_, dim1_upper_}, {dim2_lower_, dim2_upper_}};
  }
  std::pair<int, int> bounds(int dim) const {
    if (dim == 1)
      return {dim1_lower_, dim1_upper_};
    if (dim == 2)
      return {dim2_lower_, dim2_upper_};
    throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
  }

  int lower_bound(int dim) const {
    if (dim == 1)
      return dim1_lower_;
    if (dim == 2)
      return dim2_lower_;
    throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
  }

  int upper_bound(int dim) const {
    if (dim == 1)
      return dim1_upper_;
    if (dim == 2)
      return dim2_upper_;
    throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
  }

  std::pair<int, int> strides() const {
    return {stride1_, stride2_};
  }

  // Raw data access
  T* data() {
    return valid_ ? data_ : nullptr;
  }
  const T* data() const {
    return valid_ ? data_ : nullptr;
  }

  // Convert to std::vector of std::vectors (copies data, row-major)
  std::vector<std::vector<T>> to_vector() const {
    if (!valid_)
      return std::vector<std::vector<T>>();

    std::vector<std::vector<T>> result(dim1_size_, std::vector<T>(dim2_size_));
    for (int i = 0; i < dim1_size_; ++i) {
      for (int j = 0; j < dim2_size_; ++j) {
        result[i][j] = data_[i * stride1_ + j * stride2_];
      }
    }
    return result;
  }

  // Convert to flat std::vector (copies data)
  std::vector<T> to_flat_vector() const {
    if (!valid_)
      return std::vector<T>();

    std::vector<T> result;
    result.reserve(dim1_size_ * dim2_size_);
    for (int i = 0; i < dim1_size_; ++i) {
      for (int j = 0; j < dim2_size_; ++j) {
        result.push_back(data_[i * stride1_ + j * stride2_]);
      }
    }
    return result;
  }

  // Empty check
  bool empty() const {
    return !valid_ || dim1_size_ == 0 || dim2_size_ == 0;
  }
};

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
class UniverseProxy;
class LatticeProxy;
class BranchProxy;
class ElementProxy;

// Non-Tao proxy classes that directly reference Fortran memory
class ElementProxy {
 private:
  void* fortran_ptr_;

 public:
  explicit ElementProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("ElementProxy constructor");
    }
  }

  void* get_fortran_ptr() const {
    return fortran_ptr_;
  }

  // ${ele_struct_class_body}
};

class BranchProxy {
 private:
  void* fortran_ptr_;

 public:
  explicit BranchProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  void* get_fortran_ptr() const {
    return fortran_ptr_;
  }

  ElementProxy get_element(int ix_ele) const {
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
    return ElementProxy(ele_ptr);
  }

  int get_n_elements() const {
    int n = tao_branch_get_n_elements(fortran_ptr_);
    if (n < 0) {
      throw TaoException("Failed to get number of elements from branch");
    }
    return n;
  }
};

class LatticeProxy {
 private:
  void* fortran_ptr_;

 public:
  explicit LatticeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("LatticeProxy constructor");
    }
  }

  void* get_fortran_ptr() const {
    return fortran_ptr_;
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
};

class UniverseProxy {
 private:
  int ix_uni_;

 public:
  explicit UniverseProxy(int ix_uni) : ix_uni_(ix_uni) {
    int n_universes = tao_get_n_universes();
    if (ix_uni < 0 || ix_uni >= n_universes) {
      throw InvalidIndexException("universe", ix_uni, n_universes);
    }
  }

  LatticeProxy get_lattice(LatticeType lattice_type) const {
    void* lat_ptr =
        tao_c_get_lattice_ptr(ix_uni_, static_cast<int>(lattice_type));
    if (!lat_ptr) {
      throw NullPointerException(
          "get_lattice for universe " + std::to_string(ix_uni_));
    }
    return LatticeProxy(lat_ptr);
  }

  int get_universe_index() const {
    return ix_uni_;
  }
};

// Tao proxy classes for navigating the hierarchy
class TaoElementProxy {
 private:
  int ix_uni_, ix_lat_, ix_branch_, ix_ele_;

 public:
  TaoElementProxy(
      int ix_uni,
      LatticeType lattice_type,
      int ix_branch,
      int ix_ele)
      : ix_uni_(ix_uni),
        ix_lat_(static_cast<int>(lattice_type)),
        ix_branch_(ix_branch),
        ix_ele_(ix_ele) {}

  ElementProxy operator*() const {
    void* ele_ptr =
        tao_c_get_element_ptr(ix_uni_, ix_lat_, ix_branch_, ix_ele_);
    if (!ele_ptr) {
      throw NullPointerException(
          "TaoElementProxy dereference for ix_uni=" + std::to_string(ix_uni_) +
          " ix_lat=" + std::to_string(ix_lat_) +
          " ix_branch=" + std::to_string(ix_branch_) +
          " ix_ele=" + std::to_string(ix_ele_) + "");
    }
    return ElementProxy(ele_ptr);
  }

  std::unique_ptr<ElementProxy> operator->() const {
    return std::make_unique<ElementProxy>(**this);
  }
};

class TaoBranchProxy {
 private:
  int ix_uni_, ix_lat_, ix_branch_;

 public:
  TaoBranchProxy(int ix_uni, LatticeType lattice_type, int ix_branch)
      : ix_uni_(ix_uni),
        ix_lat_(static_cast<int>(lattice_type)),
        ix_branch_(ix_branch) {}

  BranchProxy operator*() const {
    void* branch_ptr = tao_c_get_branch_ptr(ix_uni_, ix_lat_, ix_branch_);
    if (!branch_ptr) {
      throw NullPointerException(
          "TaoBranchProxy dereference for [" + std::to_string(ix_uni_) + "," +
          std::to_string(ix_lat_) + "," + std::to_string(ix_branch_) + "]");
    }
    return BranchProxy(branch_ptr);
  }

  std::unique_ptr<BranchProxy> operator->() const {
    return std::make_unique<BranchProxy>(**this);
  }

  TaoElementProxy get_element(int ix_ele) const {
    return TaoElementProxy(
        ix_uni_, static_cast<LatticeType>(ix_lat_), ix_branch_, ix_ele);
  }
};

class TaoLatticeProxy {
 private:
  int ix_uni_, ix_lat_;

 public:
  TaoLatticeProxy(int ix_uni, LatticeType lattice_type)
      : ix_uni_(ix_uni), ix_lat_(static_cast<int>(lattice_type)) {}

  LatticeProxy operator*() const {
    void* lat_ptr = tao_c_get_lattice_ptr(ix_uni_, ix_lat_);
    if (!lat_ptr) {
      throw NullPointerException(
          "TaoLatticeProxy dereference for [" + std::to_string(ix_uni_) + "," +
          std::to_string(ix_lat_) + "]");
    }
    return LatticeProxy(lat_ptr);
  }

  std::unique_ptr<LatticeProxy> operator->() const {
    return std::make_unique<LatticeProxy>(**this);
  }

  TaoBranchProxy get_branch(int ix_branch) const {
    return TaoBranchProxy(
        ix_uni_, static_cast<LatticeType>(ix_lat_), ix_branch);
  }
};

class TaoUniverseProxy {
 private:
  int ix_uni_;

 public:
  explicit TaoUniverseProxy(int ix_uni) : ix_uni_(ix_uni) {}

  UniverseProxy operator*() const {
    return UniverseProxy(ix_uni_);
  }

  std::unique_ptr<UniverseProxy> operator->() const {
    return std::make_unique<UniverseProxy>(**this);
  }

  TaoLatticeProxy get_lattice(LatticeType lattice_type) const {
    return TaoLatticeProxy(ix_uni_, lattice_type);
  }
};

} // namespace tao
