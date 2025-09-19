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

template <typename ProxyType>
class FortranTypeArray1D {
 private:
  void* data_;           // Base pointer (could point to array of pointers OR array of structs)
  int size_;
  int lower_bound_;
  int upper_bound_;
  bool valid_;
  bool is_pointer_array_; // true for pointer arrays, false for contiguous struct arrays
  size_t element_size_;   // size of each element (only used for contiguous arrays)

 public:
  // Constructor for pointer arrays (like cartesian_map)
  FortranTypeArray1D(void** pointer_array, int size, int lower, int upper, bool valid)
      : data_(pointer_array),
        size_(size),
        lower_bound_(lower),
        upper_bound_(upper),
        valid_(valid),
        is_pointer_array_(true),
        element_size_(0) {}

  // Constructor for contiguous struct arrays (like m_u_layout, taylor)
  FortranTypeArray1D(void* struct_array, int size, int lower, int upper, bool valid, size_t element_size)
      : data_(struct_array),
        size_(size),
        lower_bound_(lower),
        upper_bound_(upper),
        valid_(valid),
        is_pointer_array_(false),
        element_size_(element_size) {}

  // Default constructor for invalid arrays
  FortranTypeArray1D()
      : data_(nullptr),
        size_(0),
        lower_bound_(0),
        upper_bound_(-1),
        valid_(false),
        is_pointer_array_(false),
        element_size_(0) {}

 private:
  // Helper to get pointer to element i (0-based indexing into data_)
  void* get_element_ptr(int i) const {
    if (is_pointer_array_) {
      // For pointer arrays: data_ is void**, return the i-th pointer
      return static_cast<void**>(data_)[i];
    } else {
      // For contiguous arrays: data_ is void*, compute offset
      return static_cast<char*>(data_) + (i * element_size_);
    }
  }

 public:
  // Fortran-style indexing (using bounds) - returns Proxy object
  ProxyType operator()(int i) {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < lower_bound_ || i > upper_bound_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [" +
          std::to_string(lower_bound_) + "," + std::to_string(upper_bound_) +
          "]");
    }
    return ProxyType(get_element_ptr(i - lower_bound_));
  }

  const ProxyType operator()(int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < lower_bound_ || i > upper_bound_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [" +
          std::to_string(lower_bound_) + "," + std::to_string(upper_bound_) +
          "]");
    }
    return ProxyType(get_element_ptr(i - lower_bound_));
  }

  // C-style indexing (0-based)
  ProxyType operator[](int i) {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
    return ProxyType(get_element_ptr(i));
  }

  const ProxyType operator[](int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
    return ProxyType(get_element_ptr(i));
  }

  // Safe access methods
  ProxyType at(int i) {
    return operator[](i);
  }
  const ProxyType at(int i) const {
    return operator[](i);
  }

  ProxyType at_fortran(int i) {
    return operator()(i);
  }
  const ProxyType at_fortran(int i) const {
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
  bool is_pointer_array() const {
    return is_pointer_array_;
  }
  size_t element_size() const {
    return element_size_;
  }

  // Raw data access
  void* data() {
    return valid_ ? data_ : nullptr;
  }
  const void* data() const {
    return valid_ ? data_ : nullptr;
  }

  // Get pointer to specific element
  void* element_ptr(int i) {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
    return get_element_ptr(i);
  }

  const void* element_ptr(int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
    return get_element_ptr(i);
  }

  // Iterator support
  class iterator {
   private:
    const FortranTypeArray1D* array_;
    int index_;
   public:
    iterator(const FortranTypeArray1D* array, int index) : array_(array), index_(index) {}
    ProxyType operator*() { return ProxyType(array_->get_element_ptr(index_)); }
    iterator& operator++() { ++index_; return *this; }
    iterator operator++(int) { iterator tmp = *this; ++index_; return tmp; }
    bool operator==(const iterator& other) const { return index_ == other.index_; }
    bool operator!=(const iterator& other) const { return index_ != other.index_; }
  };

  class const_iterator {
   private:
    const FortranTypeArray1D* array_;
    int index_;
   public:
    const_iterator(const FortranTypeArray1D* array, int index) : array_(array), index_(index) {}
    const ProxyType operator*() const { return ProxyType(array_->get_element_ptr(index_)); }
    const_iterator& operator++() { ++index_; return *this; }
    const_iterator operator++(int) { const_iterator tmp = *this; ++index_; return tmp; }
    bool operator==(const const_iterator& other) const { return index_ == other.index_; }
    bool operator!=(const const_iterator& other) const { return index_ != other.index_; }
  };

  iterator begin() {
    return valid_ ? iterator(this, 0) : iterator(this, size_);
  }
  iterator end() {
    return iterator(this, size_);
  }
  const_iterator begin() const {
    return valid_ ? const_iterator(this, 0) : const_iterator(this, size_);
  }
  const_iterator end() const {
    return const_iterator(this, size_);
  }
  const_iterator cbegin() const {
    return begin();
  }
  const_iterator cend() const {
    return end();
  }

  // Convert to std::vector of Proxy objects
  std::vector<ProxyType> to_vector() const {
    if (!valid_)
      return std::vector<ProxyType>();
    
    std::vector<ProxyType> result;
    result.reserve(size_);
    for (int i = 0; i < size_; ++i) {
      result.emplace_back(get_element_ptr(i));
    }
    return result;
  }

  // Empty check
  bool empty() const {
    return !valid_ || size_ == 0;
  }
};
} // namespace tao
