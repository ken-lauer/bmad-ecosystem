#pragma once

#include <iostream>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

namespace tao {

template <typename T>
class FortranArray1D {
 private:
  T* data_;
  int size_;
  int lower_bound_;
  int upper_bound_;
  bool valid_;

  void check_fortran_bounds(int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < lower_bound_ || i > upper_bound_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [" +
          std::to_string(lower_bound_) + "," + std::to_string(upper_bound_) +
          "]");
    }
  }

  void check_c_bounds(int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
  }

 public:
  FortranArray1D(T* data, int size, int lower, int upper, bool valid)
      : data_(data),
        size_(size),
        lower_bound_(lower),
        upper_bound_(upper),
        valid_(valid) {}

  FortranArray1D()
      : data_(nullptr),
        size_(0),
        lower_bound_(0),
        upper_bound_(-1),
        valid_(false) {}

  T& operator()(int i) {
    check_fortran_bounds(i);
    return data_[i - lower_bound_];
  }

  const T& operator()(int i) const {
    check_fortran_bounds(i);
    return data_[i - lower_bound_];
  }

  T& operator[](int i) {
    check_c_bounds(i);
    return data_[i];
  }

  const T& operator[](int i) const {
    check_c_bounds(i);
    return data_[i];
  }

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

  T* data() {
    return valid_ ? data_ : nullptr;
  }
  const T* data() const {
    return valid_ ? data_ : nullptr;
  }

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

  std::vector<T> to_vector() const {
    if (!valid_)
      return std::vector<T>();
    return std::vector<T>(data_, data_ + size_);
  }

  bool empty() const {
    return !valid_ || size_ == 0;
  }
};

template <typename T, std::size_t N>
class FortranArrayND {
 private:
  T* data_;
  std::array<int, N> sizes_;
  std::array<int, N> lower_bounds_;
  std::array<int, N> upper_bounds_;
  std::array<int, N> strides_;
  bool valid_;

  template <typename... Indices>
  int linear_index(Indices... indices) const {
    static_assert(sizeof...(indices) == N, "Wrong number of indices");
    std::array<int, N> idx_array{indices...};
    int index = 0;
    for (std::size_t i = 0; i < N; ++i) {
      index += (idx_array[i] - lower_bounds_[i]) * strides_[i];
    }
    return index;
  }

  template <typename... Indices>
  int linear_index_c(Indices... indices) const {
    static_assert(sizeof...(indices) == N, "Wrong number of indices");
    std::array<int, N> idx_array{indices...};
    int index = 0;
    for (std::size_t i = 0; i < N; ++i) {
      index += idx_array[i] * strides_[i];
    }
    return index;
  }

  template <typename... Indices>
  void check_fortran_bounds(Indices... indices) const {
    static_assert(sizeof...(indices) == N, "Wrong number of indices");
    if (!valid_)
      throw std::runtime_error("Array not allocated");

    std::array<int, N> idx_array{indices...};
    for (std::size_t i = 0; i < N; ++i) {
      if (idx_array[i] < lower_bounds_[i] || idx_array[i] > upper_bounds_[i]) {
        throw std::out_of_range(
            "Array dim" + std::to_string(i + 1) +
            " index out of bounds: " + std::to_string(idx_array[i]) +
            " not in [" + std::to_string(lower_bounds_[i]) + "," +
            std::to_string(upper_bounds_[i]) + "]");
      }
    }
  }

  template <typename... Indices>
  void check_c_bounds(Indices... indices) const {
    static_assert(sizeof...(indices) == N, "Wrong number of indices");
    if (!valid_)
      throw std::runtime_error("Array not allocated");

    std::array<int, N> idx_array{indices...};
    for (std::size_t i = 0; i < N; ++i) {
      if (idx_array[i] < 0 || idx_array[i] >= sizes_[i]) {
        throw std::out_of_range(
            "Array dim" + std::to_string(i + 1) +
            " index out of bounds: " + std::to_string(idx_array[i]) +
            " not in [0," + std::to_string(sizes_[i] - 1) + "]");
      }
    }
  }

 public:
  // Constructor with arrays
  FortranArrayND(
      T* data,
      const std::array<int, N>& sizes,
      const std::array<int, N>& lower_bounds,
      const std::array<int, N>& upper_bounds,
      const std::array<int, N>& strides,
      bool valid)
      : data_(data),
        sizes_(sizes),
        lower_bounds_(lower_bounds),
        upper_bounds_(upper_bounds),
        strides_(strides),
        valid_(valid) {}

  // Variadic constructor for easier initialization
  template <typename... Args>
  FortranArrayND(T* data, Args... args) : data_(data), valid_(true) {
    // Expect: size1, lower1, upper1, size2, lower2, upper2, ..., stride1, stride2, ..., valid
    // Total args: 3*N + N + 1 = 4*N + 1
    static_assert(sizeof...(args) == 4 * N + 1, "Invalid number of arguments");

    std::array<int, 4 * N + 1> arg_array{args...};

    for (std::size_t i = 0; i < N; ++i) {
      sizes_[i] = arg_array[i * 3];
      lower_bounds_[i] = arg_array[i * 3 + 1];
      upper_bounds_[i] = arg_array[i * 3 + 2];
    }

    for (std::size_t i = 0; i < N; ++i) {
      strides_[i] = arg_array[3 * N + i];
    }

    valid_ = static_cast<bool>(arg_array[4 * N]);
  }

  // Default constructor for invalid arrays
  FortranArrayND() : data_(nullptr), valid_(false) {
    sizes_.fill(0);
    lower_bounds_.fill(0);
    upper_bounds_.fill(-1);
    strides_.fill(0);
  }

  // Fortran-style indexing (using bounds)
  template <typename... Indices>
  T& operator()(Indices... indices) {
    check_fortran_bounds(indices...);
    return data_[linear_index(indices...)];
  }

  template <typename... Indices>
  const T& operator()(Indices... indices) const {
    check_fortran_bounds(indices...);
    return data_[linear_index(indices...)];
  }

  // C-style indexing (0-based)
  template <typename... Indices>
  T& at(Indices... indices) {
    check_c_bounds(indices...);
    return data_[linear_index_c(indices...)];
  }

  template <typename... Indices>
  const T& at(Indices... indices) const {
    check_c_bounds(indices...);
    return data_[linear_index_c(indices...)];
  }

  // Safe Fortran-style access
  template <typename... Indices>
  T& at_fortran(Indices... indices) {
    return operator()(indices...);
  }

  template <typename... Indices>
  const T& at_fortran(Indices... indices) const {
    return operator()(indices...);
  }

  bool is_valid() const {
    return valid_;
  }

  const std::array<int, N>& size() const {
    return sizes_;
  }

  int size(int dim) const {
    if (dim < 1 || dim > static_cast<int>(N))
      throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
    return sizes_[dim - 1];
  }

  std::array<std::pair<int, int>, N> bounds() const {
    std::array<std::pair<int, int>, N> result;
    for (std::size_t i = 0; i < N; ++i) {
      result[i] = {lower_bounds_[i], upper_bounds_[i]};
    }
    return result;
  }

  std::pair<int, int> bounds(int dim) const {
    if (dim < 1 || dim > static_cast<int>(N))
      throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
    return {lower_bounds_[dim - 1], upper_bounds_[dim - 1]};
  }

  int lower_bound(int dim) const {
    if (dim < 1 || dim > static_cast<int>(N))
      throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
    return lower_bounds_[dim - 1];
  }

  int upper_bound(int dim) const {
    if (dim < 1 || dim > static_cast<int>(N))
      throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
    return upper_bounds_[dim - 1];
  }

  const std::array<int, N>& strides() const {
    return strides_;
  }

  T* data() {
    return valid_ ? data_ : nullptr;
  }

  const T* data() const {
    return valid_ ? data_ : nullptr;
  }

  // Convert to flat std::vector (copies data)
  std::vector<T> to_flat_vector() const {
    if (!valid_)
      return std::vector<T>();

    int total_size = 1;
    for (std::size_t i = 0; i < N; ++i) {
      total_size *= sizes_[i];
    }

    std::vector<T> result;
    result.reserve(total_size);

    // Generate all index combinations recursively
    std::array<int, N> indices;
    indices.fill(0);
    copy_elements_recursive(result, indices, 0);

    return result;
  }

  bool empty() const {
    if (!valid_)
      return true;
    for (std::size_t i = 0; i < N; ++i) {
      if (sizes_[i] == 0)
        return true;
    }
    return false;
  }

  constexpr std::size_t rank() const {
    return N;
  }

 private:
  void copy_elements_recursive(
      std::vector<T>& result,
      std::array<int, N>& indices,
      std::size_t dim) const {
    if (dim == N) {
      int index = 0;
      for (std::size_t i = 0; i < N; ++i) {
        index += indices[i] * strides_[i];
      }
      result.push_back(data_[index]);
      return;
    }

    for (int i = 0; i < sizes_[dim]; ++i) {
      indices[dim] = i;
      copy_elements_recursive(result, indices, dim + 1);
    }
  }
};

// Type aliases for convenience
template <typename T>
using FortranArray2D = FortranArrayND<T, 2>;

template <typename T>
using FortranArray3D = FortranArrayND<T, 3>;

class FortranCharArray1D {
 private:
  char* data_;
  int size_;
  int lower_bound_;
  int upper_bound_;
  int str_len_;
  bool valid_;

  void check_fortran_bounds(int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < lower_bound_ || i > upper_bound_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [" +
          std::to_string(lower_bound_) + "," + std::to_string(upper_bound_) +
          "]");
    }
  }

  void check_c_bounds(int i) const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
  }

  // Helper to convert Fortran string (space-padded) to C++ string (trimmed)
  std::string fortran_to_cpp_string(const char* str, int len) const {
    // Find the last non-space character
    int end = len - 1;
    while (end >= 0 && (str[end] == ' ' || str[end] == '\0')) {
      --end;
    }
    return std::string(str, end + 1);
  }

  // Helper to copy C++ string to Fortran string (space-padded)
  void cpp_to_fortran_string(char* dest, const std::string& src, int len)
      const {
    int copy_len = std::min(static_cast<int>(src.length()), len);
    std::memcpy(dest, src.c_str(), copy_len);
    // Pad with spaces
    for (int i = copy_len; i < len; ++i) {
      dest[i] = ' ';
    }
  }

 public:
  FortranCharArray1D(
      char* data,
      int size,
      int lower_bound,
      int upper_bound,
      int str_len,
      bool valid)
      : data_(data),
        size_(size),
        lower_bound_(lower_bound),
        upper_bound_(upper_bound),
        str_len_(str_len),
        valid_(valid) {}

  // Default constructor for invalid arrays
  FortranCharArray1D()
      : data_(nullptr),
        size_(0),
        lower_bound_(0),
        upper_bound_(-1),
        str_len_(0),
        valid_(false) {}

  // Proxy class for string element access
  class StringProxy {
   private:
    char* data_;
    int str_len_;
    FortranCharArray1D* parent_;

   public:
    StringProxy(char* data, int str_len, FortranCharArray1D* parent)
        : data_(data), str_len_(str_len), parent_(parent) {}

    // Implicit conversion to std::string (trimmed)
    operator std::string() const {
      return parent_->fortran_to_cpp_string(data_, str_len_);
    }

    // Assignment from std::string
    StringProxy& operator=(const std::string& str) {
      parent_->cpp_to_fortran_string(data_, str, str_len_);
      return *this;
    }

    // Assignment from C string
    StringProxy& operator=(const char* str) {
      return operator=(std::string(str));
    }

    // Get raw pointer to character data
    char* data() {
      return data_;
    }

    const char* data() const {
      return data_;
    }

    // Get length of string storage
    int length() const {
      return str_len_;
    }

    // Get as std::string (trimmed)
    std::string str() const {
      return parent_->fortran_to_cpp_string(data_, str_len_);
    }

    // Copy assignment from another proxy
    StringProxy& operator=(const StringProxy& other) {
      if (this != &other) {
        int copy_len = std::min(str_len_, other.str_len_);
        std::memcpy(data_, other.data_, copy_len);
        // Pad if necessary
        for (int i = copy_len; i < str_len_; ++i) {
          data_[i] = ' ';
        }
      }
      return *this;
    }

    // Access individual characters
    char& operator[](int pos) {
      if (pos < 0 || pos >= str_len_) {
        throw std::out_of_range(
            "Character position out of bounds: " + std::to_string(pos));
      }
      return data_[pos];
    }

    const char& operator[](int pos) const {
      if (pos < 0 || pos >= str_len_) {
        throw std::out_of_range(
            "Character position out of bounds: " + std::to_string(pos));
      }
      return data_[pos];
    }

    // Comparison operators
    bool operator==(const std::string& other) const {
      return str() == other;
    }

    bool operator!=(const std::string& other) const {
      return str() != other;
    }

    bool operator==(const char* other) const {
      return str() == std::string(other);
    }

    bool operator!=(const char* other) const {
      return str() != std::string(other);
    }
  };

  // Const proxy for read-only access
  class ConstStringProxy {
   private:
    const char* data_;
    int str_len_;
    const FortranCharArray1D* parent_;

   public:
    ConstStringProxy(
        const char* data,
        int str_len,
        const FortranCharArray1D* parent)
        : data_(data), str_len_(str_len), parent_(parent) {}

    // Implicit conversion to std::string (trimmed)
    operator std::string() const {
      return parent_->fortran_to_cpp_string(data_, str_len_);
    }

    // Get raw pointer to character data
    const char* data() const {
      return data_;
    }

    // Get length of string storage
    int length() const {
      return str_len_;
    }

    // Get as std::string (trimmed)
    std::string str() const {
      return parent_->fortran_to_cpp_string(data_, str_len_);
    }

    // Access individual characters
    const char& operator[](int pos) const {
      if (pos < 0 || pos >= str_len_) {
        throw std::out_of_range(
            "Character position out of bounds: " + std::to_string(pos));
      }
      return data_[pos];
    }

    // Comparison operators
    bool operator==(const std::string& other) const {
      return str() == other;
    }

    bool operator!=(const std::string& other) const {
      return str() != other;
    }

    bool operator==(const char* other) const {
      return str() == std::string(other);
    }

    bool operator!=(const char* other) const {
      return str() != std::string(other);
    }
  };

  // Fortran-style indexing (using bounds) - returns proxy
  StringProxy operator()(int i) {
    check_fortran_bounds(i);
    return StringProxy(data_ + (i - lower_bound_) * str_len_, str_len_, this);
  }

  ConstStringProxy operator()(int i) const {
    check_fortran_bounds(i);
    return ConstStringProxy(
        data_ + (i - lower_bound_) * str_len_, str_len_, this);
  }

  // C-style indexing (0-based) - returns proxy
  StringProxy operator[](int i) {
    check_c_bounds(i);
    return StringProxy(data_ + i * str_len_, str_len_, this);
  }

  ConstStringProxy operator[](int i) const {
    check_c_bounds(i);
    return ConstStringProxy(data_ + i * str_len_, str_len_, this);
  }

  // Safe access methods
  StringProxy at(int i) {
    return operator[](i);
  }

  ConstStringProxy at(int i) const {
    return operator[](i);
  }

  StringProxy at_fortran(int i) {
    return operator()(i);
  }

  ConstStringProxy at_fortran(int i) const {
    return operator()(i);
  }

  // Get string at index as std::string (trimmed)
  std::string get_string(int i) const {
    check_fortran_bounds(i);
    return fortran_to_cpp_string(
        data_ + (i - lower_bound_) * str_len_, str_len_);
  }

  std::string get_string_c(int i) const {
    check_c_bounds(i);
    return fortran_to_cpp_string(data_ + i * str_len_, str_len_);
  }

  // Set string at index from std::string
  void set_string(int i, const std::string& str) {
    check_fortran_bounds(i);
    cpp_to_fortran_string(data_ + (i - lower_bound_) * str_len_, str, str_len_);
  }

  void set_string_c(int i, const std::string& str) {
    check_c_bounds(i);
    cpp_to_fortran_string(data_ + i * str_len_, str, str_len_);
  }

  // Accessors
  bool is_valid() const {
    return valid_;
  }

  int size() const {
    return size_;
  }

  int string_length() const {
    return str_len_;
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

  char* data() {
    return valid_ ? data_ : nullptr;
  }

  const char* data() const {
    return valid_ ? data_ : nullptr;
  }

  // Get raw pointer to specific string
  char* data(int i) {
    check_fortran_bounds(i);
    return data_ + (i - lower_bound_) * str_len_;
  }

  const char* data(int i) const {
    check_fortran_bounds(i);
    return data_ + (i - lower_bound_) * str_len_;
  }

  // Convert to vector of strings (trimmed)
  std::vector<std::string> to_vector() const {
    if (!valid_)
      return std::vector<std::string>();

    std::vector<std::string> result;
    result.reserve(size_);
    for (int i = 0; i < size_; ++i) {
      result.push_back(fortran_to_cpp_string(data_ + i * str_len_, str_len_));
    }
    return result;
  }

  bool empty() const {
    return !valid_ || size_ == 0;
  }

  // Iterator support for range-based for loops
  class Iterator {
   private:
    FortranCharArray1D* parent_;
    int index_;

   public:
    using iterator_category = std::forward_iterator_tag;
    using value_type = StringProxy;
    using difference_type = std::ptrdiff_t;
    using pointer = StringProxy*;
    using reference = StringProxy;

    Iterator(FortranCharArray1D* parent, int index)
        : parent_(parent), index_(index) {}

    reference operator*() {
      return (*parent_)[index_];
    }

    Iterator& operator++() {
      ++index_;
      return *this;
    }

    Iterator operator++(int) {
      Iterator tmp = *this;
      ++index_;
      return tmp;
    }

    bool operator==(const Iterator& other) const {
      return parent_ == other.parent_ && index_ == other.index_;
    }

    bool operator!=(const Iterator& other) const {
      return !(*this == other);
    }
  };

  class ConstIterator {
   private:
    const FortranCharArray1D* parent_;
    int index_;

   public:
    using iterator_category = std::forward_iterator_tag;
    using value_type = ConstStringProxy;
    using difference_type = std::ptrdiff_t;
    using pointer = ConstStringProxy*;
    using reference = ConstStringProxy;

    ConstIterator(const FortranCharArray1D* parent, int index)
        : parent_(parent), index_(index) {}

    reference operator*() const {
      return (*parent_)[index_];
    }

    ConstIterator& operator++() {
      ++index_;
      return *this;
    }

    ConstIterator operator++(int) {
      ConstIterator tmp = *this;
      ++index_;
      return tmp;
    }

    bool operator==(const ConstIterator& other) const {
      return parent_ == other.parent_ && index_ == other.index_;
    }

    bool operator!=(const ConstIterator& other) const {
      return !(*this == other);
    }
  };

  Iterator begin() {
    return valid_ ? Iterator(this, 0) : Iterator(this, 0);
  }

  Iterator end() {
    return valid_ ? Iterator(this, size_) : Iterator(this, 0);
  }

  ConstIterator begin() const {
    return valid_ ? ConstIterator(this, 0) : ConstIterator(this, 0);
  }

  ConstIterator end() const {
    return valid_ ? ConstIterator(this, size_) : ConstIterator(this, 0);
  }

  ConstIterator cbegin() const {
    return begin();
  }

  ConstIterator cend() const {
    return end();
  }
};

template <typename ProxyType>
class FortranTypeArray1D {
 private:
  void*
      data_; // Base pointer (could point to array of pointers OR array of structs)
  int size_;
  int lower_bound_;
  int upper_bound_;
  bool valid_;
  bool
      is_pointer_array_; // true for pointer arrays, false for contiguous struct arrays
  size_t
      element_size_; // size of each element (only used for contiguous arrays)

 public:
  // Constructor for pointer arrays (like cartesian_map)
  FortranTypeArray1D(
      void** pointer_array,
      int size,
      int lower,
      int upper,
      bool valid)
      : data_(pointer_array),
        size_(size),
        lower_bound_(lower),
        upper_bound_(upper),
        valid_(valid),
        is_pointer_array_(true),
        element_size_(0) {}

  // Constructor for contiguous struct arrays (like m_u_layout, taylor)
  FortranTypeArray1D(
      void* struct_array,
      int size,
      int lower,
      int upper,
      bool valid,
      size_t element_size)
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

  void check_validity() const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
  }

  void check_fortran_bounds(int i) const {
    if (i < lower_bound_ || i > upper_bound_) {
      throw std::out_of_range(
          "Fortran array index out of bounds: " + std::to_string(i) +
          " not in [" + std::to_string(lower_bound_) + "," +
          std::to_string(upper_bound_) + "]");
    }
  }

  void check_c_bounds(int i) const {
    if (i < 0 || i >= size_) {
      throw std::out_of_range(
          "Array index out of bounds: " + std::to_string(i) + " not in [0," +
          std::to_string(size_ - 1) + "]");
    }
  }

 public:
  // Fortran-style indexing (using bounds) - returns Proxy object
  ProxyType operator()(int i) {
    check_validity();
    check_fortran_bounds(i);
    return ProxyType(get_element_ptr(i - lower_bound_));
  }

  const ProxyType operator()(int i) const {
    check_validity();
    check_fortran_bounds(i);
    return ProxyType(get_element_ptr(i - lower_bound_));
  }

  // C-style indexing (0-based)
  ProxyType operator[](int i) {
    check_validity();
    check_c_bounds(i);
    return ProxyType(get_element_ptr(i));
  }

  const ProxyType operator[](int i) const {
    check_validity();
    check_c_bounds(i);
    return ProxyType(get_element_ptr(i));
  }

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

  void* data() {
    return valid_ ? data_ : nullptr;
  }
  const void* data() const {
    return valid_ ? data_ : nullptr;
  }

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

  class iterator {
   private:
    const FortranTypeArray1D* array_;
    int index_;

   public:
    iterator(const FortranTypeArray1D* array, int index)
        : array_(array), index_(index) {}

    ProxyType operator*() {
      if (index_ >= array_->size_) {
        // This should never happen in correct usage, but pybind11 might try it
        throw std::runtime_error("Iterator dereferenced at end position");
      }
      if (!array_->valid_) {
        throw std::runtime_error("Array not allocated");
      }
      return ProxyType(array_->get_element_ptr(index_));
    }

    iterator& operator++() {
      ++index_;
      return *this;
    }

    iterator operator++(int) {
      iterator tmp = *this;
      ++index_;
      return tmp;
    }

    bool operator==(const iterator& other) const {
      return array_ == other.array_ && index_ == other.index_;
    }

    bool operator!=(const iterator& other) const {
      return !(*this == other);
    }
  };

  class const_iterator {
   private:
    const FortranTypeArray1D* array_;
    int index_;

   public:
    const_iterator(const FortranTypeArray1D* array, int index)
        : array_(array), index_(index) {}

    const ProxyType operator*() const {
      if (index_ >= array_->size_) {
        throw std::runtime_error("Iterator dereferenced at end position");
      }
      if (!array_->valid_) {
        throw std::runtime_error("Array not allocated");
      }
      return ProxyType(array_->get_element_ptr(index_));
    }

    const_iterator& operator++() {
      ++index_;
      return *this;
    }

    const_iterator operator++(int) {
      const_iterator tmp = *this;
      ++index_;
      return tmp;
    }

    bool operator==(const const_iterator& other) const {
      return array_ == other.array_ && index_ == other.index_;
    }

    bool operator!=(const const_iterator& other) const {
      return !(*this == other);
    }
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

  bool empty() const {
    return !valid_ || size_ == 0;
  }
};

template <typename ProxyType>
class FortranTypeArray2D {
 private:
  void* data_;
  int size1_, size2_;
  int lower_bound1_, upper_bound1_;
  int lower_bound2_, upper_bound2_;
  size_t stride1_, stride2_;
  bool valid_;
  bool is_pointer_array_;
  size_t element_size_;

  void* get_element_ptr(int i, int j) const {
    if (is_pointer_array_) {
      return static_cast<void**>(data_)[i * stride1_ + j * stride2_];
    } else {
      return static_cast<char*>(data_) +
          (i * stride1_ + j * stride2_) * element_size_;
    }
  }

  void check_validity() const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
  }

  void check_fortran_bounds(int i, int j) const {
    if (i < lower_bound1_ || i > upper_bound1_ || j < lower_bound2_ ||
        j > upper_bound2_) {
      throw std::out_of_range(
          "Fortran array index out of bounds: (" + std::to_string(i) + "," +
          std::to_string(j) + ") not in [" + std::to_string(lower_bound1_) +
          "," + std::to_string(upper_bound1_) + "]x[" +
          std::to_string(lower_bound2_) + "," + std::to_string(upper_bound2_) +
          "]");
    }
  }

  void check_c_bounds(int i, int j) const {
    if (i < 0 || i >= size1_ || j < 0 || j >= size2_) {
      throw std::out_of_range(
          "Array index out of bounds: (" + std::to_string(i) + "," +
          std::to_string(j) + ") not in [0," + std::to_string(size1_ - 1) +
          "]x[0," + std::to_string(size2_ - 1) + "]");
    }
  }

 public:
  FortranTypeArray2D(
      void** pointer_array,
      int size1,
      int lower1,
      int upper1,
      int size2,
      int lower2,
      int upper2,
      size_t stride1,
      size_t stride2,
      bool valid)
      : data_(pointer_array),
        size1_(size1),
        size2_(size2),
        lower_bound1_(lower1),
        upper_bound1_(upper1),
        lower_bound2_(lower2),
        upper_bound2_(upper2),
        stride1_(stride1),
        stride2_(stride2),
        valid_(valid),
        is_pointer_array_(true),
        element_size_(0) {}

  FortranTypeArray2D(
      void* struct_array,
      int size1,
      int lower1,
      int upper1,
      int size2,
      int lower2,
      int upper2,
      size_t stride1,
      size_t stride2,
      bool valid,
      size_t element_size)
      : data_(struct_array),
        size1_(size1),
        size2_(size2),
        lower_bound1_(lower1),
        upper_bound1_(upper1),
        lower_bound2_(lower2),
        upper_bound2_(upper2),
        stride1_(stride1),
        stride2_(stride2),
        valid_(valid),
        is_pointer_array_(false),
        element_size_(element_size) {}

  FortranTypeArray2D()
      : data_(nullptr),
        size1_(0),
        size2_(0),
        lower_bound1_(0),
        upper_bound1_(-1),
        lower_bound2_(0),
        upper_bound2_(-1),
        stride1_(0),
        stride2_(0),
        valid_(false),
        is_pointer_array_(false),
        element_size_(0) {}

  ProxyType operator()(int i, int j) {
    check_validity();
    check_fortran_bounds(i, j);
    return ProxyType(get_element_ptr(i - lower_bound1_, j - lower_bound2_));
  }

  const ProxyType operator()(int i, int j) const {
    check_validity();
    check_fortran_bounds(i, j);
    return ProxyType(get_element_ptr(i - lower_bound1_, j - lower_bound2_));
  }

  ProxyType at(int i, int j) {
    check_validity();
    check_c_bounds(i, j);
    return ProxyType(get_element_ptr(i, j));
  }

  const ProxyType at(int i, int j) const {
    check_validity();
    check_c_bounds(i, j);
    return ProxyType(get_element_ptr(i, j));
  }

  ProxyType at_fortran(int i, int j) {
    return operator()(i, j);
  }

  const ProxyType at_fortran(int i, int j) const {
    return operator()(i, j);
  }

  bool is_valid() const {
    return valid_;
  }
  int size1() const {
    return size1_;
  }
  int size2() const {
    return size2_;
  }
  std::pair<int, int> bounds1() const {
    return {lower_bound1_, upper_bound1_};
  }
  std::pair<int, int> bounds2() const {
    return {lower_bound2_, upper_bound2_};
  }
  int lower_bound1() const {
    return lower_bound1_;
  }
  int upper_bound1() const {
    return upper_bound1_;
  }
  int lower_bound2() const {
    return lower_bound2_;
  }
  int upper_bound2() const {
    return upper_bound2_;
  }
  size_t stride1() const {
    return stride1_;
  }
  size_t stride2() const {
    return stride2_;
  }
  bool is_pointer_array() const {
    return is_pointer_array_;
  }
  size_t element_size() const {
    return element_size_;
  }
  void* data() {
    return valid_ ? data_ : nullptr;
  }
  const void* data() const {
    return valid_ ? data_ : nullptr;
  }
  bool empty() const {
    return !valid_ || size1_ == 0 || size2_ == 0;
  }

  void* element_ptr(int i, int j) {
    check_validity();
    check_c_bounds(i, j);
    return get_element_ptr(i, j);
  }

  const void* element_ptr(int i, int j) const {
    check_validity();
    check_c_bounds(i, j);
    return get_element_ptr(i, j);
  }

  std::vector<std::vector<ProxyType>> to_vector() const {
    if (!valid_)
      return std::vector<std::vector<ProxyType>>();

    std::vector<std::vector<ProxyType>> result;
    result.reserve(size1_);
    for (int i = 0; i < size1_; ++i) {
      std::vector<ProxyType> row;
      row.reserve(size2_);
      for (int j = 0; j < size2_; ++j) {
        row.emplace_back(get_element_ptr(i, j));
      }
      result.push_back(std::move(row));
    }
    return result;
  }
};

template <typename ProxyType>
class FortranTypeArray3D {
 private:
  void* data_;
  int size1_, size2_, size3_;
  int lower_bound1_, upper_bound1_;
  int lower_bound2_, upper_bound2_;
  int lower_bound3_, upper_bound3_;
  size_t stride1_, stride2_, stride3_;
  bool valid_;
  bool is_pointer_array_;
  size_t element_size_;

  void* get_element_ptr(int i, int j, int k) const {
    if (is_pointer_array_) {
      return static_cast<void**>(
          data_)[i * stride1_ + j * stride2_ + k * stride3_];
    } else {
      return static_cast<char*>(data_) +
          (i * stride1_ + j * stride2_ + k * stride3_) * element_size_;
    }
  }

  void check_validity() const {
    if (!valid_)
      throw std::runtime_error("Array not allocated");
  }

  void check_fortran_bounds(int i, int j, int k) const {
    if (i < lower_bound1_ || i > upper_bound1_ || j < lower_bound2_ ||
        j > upper_bound2_ || k < lower_bound3_ || k > upper_bound3_) {
      throw std::out_of_range(
          "Fortran array index out of bounds: (" + std::to_string(i) + "," +
          std::to_string(j) + "," + std::to_string(k) + ") not in [" +
          std::to_string(lower_bound1_) + "," + std::to_string(upper_bound1_) +
          "]x[" + std::to_string(lower_bound2_) + "," +
          std::to_string(upper_bound2_) + "]x[" +
          std::to_string(lower_bound3_) + "," + std::to_string(upper_bound3_) +
          "]");
    }
  }

  void check_c_bounds(int i, int j, int k) const {
    if (i < 0 || i >= size1_ || j < 0 || j >= size2_ || k < 0 || k >= size3_) {
      throw std::out_of_range(
          "Array index out of bounds: (" + std::to_string(i) + "," +
          std::to_string(j) + "," + std::to_string(k) + ") not in [0," +
          std::to_string(size1_ - 1) + "]x[0," + std::to_string(size2_ - 1) +
          "]x[0," + std::to_string(size3_ - 1) + "]");
    }
  }

 public:
  FortranTypeArray3D(
      void** pointer_array,
      int size1,
      int lower1,
      int upper1,
      int size2,
      int lower2,
      int upper2,
      int size3,
      int lower3,
      int upper3,
      size_t stride1,
      size_t stride2,
      size_t stride3,
      bool valid)
      : data_(pointer_array),
        size1_(size1),
        size2_(size2),
        size3_(size3),
        lower_bound1_(lower1),
        upper_bound1_(upper1),
        lower_bound2_(lower2),
        upper_bound2_(upper2),
        lower_bound3_(lower3),
        upper_bound3_(upper3),
        stride1_(stride1),
        stride2_(stride2),
        stride3_(stride3),
        valid_(valid),
        is_pointer_array_(true),
        element_size_(0) {}

  FortranTypeArray3D(
      void* struct_array,
      int size1,
      int lower1,
      int upper1,
      int size2,
      int lower2,
      int upper2,
      int size3,
      int lower3,
      int upper3,
      size_t stride1,
      size_t stride2,
      size_t stride3,
      bool valid,
      size_t element_size)
      : data_(struct_array),
        size1_(size1),
        size2_(size2),
        size3_(size3),
        lower_bound1_(lower1),
        upper_bound1_(upper1),
        lower_bound2_(lower2),
        upper_bound2_(upper2),
        lower_bound3_(lower3),
        upper_bound3_(upper3),
        stride1_(stride1),
        stride2_(stride2),
        stride3_(stride3),
        valid_(valid),
        is_pointer_array_(false),
        element_size_(element_size) {}

  FortranTypeArray3D()
      : data_(nullptr),
        size1_(0),
        size2_(0),
        size3_(0),
        lower_bound1_(0),
        upper_bound1_(-1),
        lower_bound2_(0),
        upper_bound2_(-1),
        lower_bound3_(0),
        upper_bound3_(-1),
        stride1_(0),
        stride2_(0),
        stride3_(0),
        valid_(false),
        is_pointer_array_(false),
        element_size_(0) {}

  ProxyType operator()(int i, int j, int k) {
    check_validity();
    check_fortran_bounds(i, j, k);
    return ProxyType(get_element_ptr(
        i - lower_bound1_, j - lower_bound2_, k - lower_bound3_));
  }

  const ProxyType operator()(int i, int j, int k) const {
    check_validity();
    check_fortran_bounds(i, j, k);
    return ProxyType(get_element_ptr(
        i - lower_bound1_, j - lower_bound2_, k - lower_bound3_));
  }

  ProxyType at(int i, int j, int k) {
    check_validity();
    check_c_bounds(i, j, k);
    return ProxyType(get_element_ptr(i, j, k));
  }

  const ProxyType at(int i, int j, int k) const {
    check_validity();
    check_c_bounds(i, j, k);
    return ProxyType(get_element_ptr(i, j, k));
  }

  ProxyType at_fortran(int i, int j, int k) {
    return operator()(i, j, k);
  }

  const ProxyType at_fortran(int i, int j, int k) const {
    return operator()(i, j, k);
  }

  bool is_valid() const {
    return valid_;
  }
  int size1() const {
    return size1_;
  }
  int size2() const {
    return size2_;
  }
  int size3() const {
    return size3_;
  }
  std::pair<int, int> bounds1() const {
    return {lower_bound1_, upper_bound1_};
  }
  std::pair<int, int> bounds2() const {
    return {lower_bound2_, upper_bound2_};
  }
  std::pair<int, int> bounds3() const {
    return {lower_bound3_, upper_bound3_};
  }
  int lower_bound1() const {
    return lower_bound1_;
  }
  int upper_bound1() const {
    return upper_bound1_;
  }
  int lower_bound2() const {
    return lower_bound2_;
  }
  int upper_bound2() const {
    return upper_bound2_;
  }
  int lower_bound3() const {
    return lower_bound3_;
  }
  int upper_bound3() const {
    return upper_bound3_;
  }
  size_t stride1() const {
    return stride1_;
  }
  size_t stride2() const {
    return stride2_;
  }
  size_t stride3() const {
    return stride3_;
  }
  bool is_pointer_array() const {
    return is_pointer_array_;
  }
  size_t element_size() const {
    return element_size_;
  }
  void* data() {
    return valid_ ? data_ : nullptr;
  }
  const void* data() const {
    return valid_ ? data_ : nullptr;
  }
  bool empty() const {
    return !valid_ || size1_ == 0 || size2_ == 0 || size3_ == 0;
  }

  void* element_ptr(int i, int j, int k) {
    check_validity();
    check_c_bounds(i, j, k);
    return get_element_ptr(i, j, k);
  }

  const void* element_ptr(int i, int j, int k) const {
    check_validity();
    check_c_bounds(i, j, k);
    return get_element_ptr(i, j, k);
  }

  std::vector<std::vector<std::vector<ProxyType>>> to_vector() const {
    if (!valid_)
      return std::vector<std::vector<std::vector<ProxyType>>>();

    std::vector<std::vector<std::vector<ProxyType>>> result;
    result.reserve(size1_);
    for (int i = 0; i < size1_; ++i) {
      std::vector<std::vector<ProxyType>> plane;
      plane.reserve(size2_);
      for (int j = 0; j < size2_; ++j) {
        std::vector<ProxyType> row;
        row.reserve(size3_);
        for (int k = 0; k < size3_; ++k) {
          row.emplace_back(get_element_ptr(i, j, k));
        }
        plane.push_back(std::move(row));
      }
      result.push_back(std::move(plane));
    }
    return result;
  }
};
} // namespace tao
