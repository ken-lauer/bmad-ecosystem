#pragma once

#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

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

  bool empty() const {
    return !valid_ || dim1_size_ == 0 || dim2_size_ == 0;
  }
};
} // namespace tao
