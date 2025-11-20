#pragma once

#include <complex>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "to_string.hpp"

namespace tao {
template <typename T>
class FortranArray1D;

template <typename T, std::size_t N>
class FortranArrayND;

template <typename T>
using FortranArray2D = FortranArrayND<T, 2>;

template <typename T>
using FortranArray3D = FortranArrayND<T, 3>;

template <
    typename ProxyType,
    void* (*AllocFunc)(int, size_t*),
    void (*DeallocFunc)(void*, int)>
class FortranTypeArray1D;
class FortranCharArray1D;

} // namespace tao

namespace tao {

using std::to_string;

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

  std::string to_string() const {
    using ::std::to_string;
    using ::tao::to_string;

    std::ostringstream oss;
    oss << "[";
    for (size_t i = 0; i < size(); ++i) {
      if (i > 0)
        oss << ", ";
      oss << to_string((*this)[i]);
    }
    oss << "]";
    return oss.str();
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

template <
    typename ProxyType,
    void* (*AllocFunc)(int, size_t*) = nullptr,
    void (*DeallocFunc)(void*, int) = nullptr>
class FortranTypeArray1D {
 private:
  void* data_;
  int size_;
  int lower_bound_;
  int upper_bound_;
  bool valid_;
  size_t element_size_;
  bool owned_; // New: tracks if we own the memory

 public:
  // Constructor for non-owned arrays (existing usage)
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
        element_size_(element_size),
        owned_(false) {}

  // Default constructor for invalid arrays
  FortranTypeArray1D()
      : data_(nullptr),
        size_(0),
        lower_bound_(0),
        upper_bound_(-1),
        valid_(false),
        element_size_(0),
        owned_(false) {}

  // Static factory method for allocating owned arrays
  static FortranTypeArray1D allocate(int size, int lower_bound = 1) {
    static_assert(
        AllocFunc != nullptr && DeallocFunc != nullptr,
        "AllocFunc and DeallocFunc must be provided to allocate owned arrays");

    if (size < 0) {
      throw std::invalid_argument("Array size must be non-negative");
    }

    size_t element_size = 0;
    void* data = AllocFunc(size, &element_size);

    if (!data) {
      throw std::runtime_error("Failed to allocate Fortran array");
    }

    FortranTypeArray1D array;
    array.data_ = data;
    array.size_ = size;
    array.lower_bound_ = lower_bound;
    array.upper_bound_ = lower_bound + size - 1;
    array.valid_ = true;
    array.element_size_ = element_size;
    array.owned_ = true;

    return array;
  }

  // Destructor
  ~FortranTypeArray1D() {
    if (owned_ && data_ != nullptr && DeallocFunc != nullptr) {
      DeallocFunc(data_, size_);
      data_ = nullptr;
      owned_ = false;
    }
  }

  // Delete copy constructor and copy assignment for owned arrays
  FortranTypeArray1D(const FortranTypeArray1D& other) {
    if (other.owned_) {
      throw std::runtime_error(
          "Cannot copy an owned FortranTypeArray1D. Use move semantics or "
          "create a non-owning view.");
    }
    // Copy non-owned arrays
    data_ = other.data_;
    size_ = other.size_;
    lower_bound_ = other.lower_bound_;
    upper_bound_ = other.upper_bound_;
    valid_ = other.valid_;
    element_size_ = other.element_size_;
    owned_ = false;
  }

  FortranTypeArray1D& operator=(const FortranTypeArray1D& other) {
    if (this != &other) {
      if (other.owned_) {
        throw std::runtime_error(
            "Cannot copy an owned FortranTypeArray1D. Use move semantics.");
      }
      // Clean up if we own memory
      if (owned_ && data_ != nullptr && DeallocFunc != nullptr) {
        DeallocFunc(data_, size_);
      }
      // Copy non-owned arrays
      data_ = other.data_;
      size_ = other.size_;
      lower_bound_ = other.lower_bound_;
      upper_bound_ = other.upper_bound_;
      valid_ = other.valid_;
      element_size_ = other.element_size_;
      owned_ = false;
    }
    return *this;
  }

  // Move constructor
  FortranTypeArray1D(FortranTypeArray1D&& other) noexcept
      : data_(other.data_),
        size_(other.size_),
        lower_bound_(other.lower_bound_),
        upper_bound_(other.upper_bound_),
        valid_(other.valid_),
        element_size_(other.element_size_),
        owned_(other.owned_) {
    // Invalidate the source
    other.data_ = nullptr;
    other.size_ = 0;
    other.valid_ = false;
    other.owned_ = false;
  }

  // Move assignment
  FortranTypeArray1D& operator=(FortranTypeArray1D&& other) noexcept {
    if (this != &other) {
      // Clean up our own resources
      if (owned_ && data_ != nullptr && DeallocFunc != nullptr) {
        DeallocFunc(data_, size_);
      }

      // Take ownership of other's resources
      data_ = other.data_;
      size_ = other.size_;
      lower_bound_ = other.lower_bound_;
      upper_bound_ = other.upper_bound_;
      valid_ = other.valid_;
      element_size_ = other.element_size_;
      owned_ = other.owned_;

      // Invalidate the source
      other.data_ = nullptr;
      other.size_ = 0;
      other.valid_ = false;
      other.owned_ = false;
    }
    return *this;
  }

  // Create a non-owning view of this array
  FortranTypeArray1D as_view() const {
    return FortranTypeArray1D(
        data_, size_, lower_bound_, upper_bound_, valid_, element_size_);
  }

  // Check if this array owns its memory
  bool is_owned() const {
    return owned_;
  }

 private:
  // Helper to get pointer to element i (0-based indexing into data_)
  void* get_element_ptr(int i) const {
    // For contiguous arrays: data_ is void*, compute offset
    return static_cast<char*>(data_) + (i * element_size_);
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
  void* get_fortran_ptr() const {
    return data_;
  }

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

  // Iterator classes remain the same...
  class iterator {
   private:
    const FortranTypeArray1D* array_;
    int index_;

   public:
    iterator(const FortranTypeArray1D* array, int index)
        : array_(array), index_(index) {}

    ProxyType operator*() {
      if (index_ >= array_->size_) {
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

template <typename ProxyType, std::size_t N>
class FortranTypeArrayND {
 private:
  void* data_; // Base pointer
  std::array<int, N> sizes_; // Extents per dimension (C-style counts)
  std::array<int, N> lower_bounds_; // Fortran lower bounds
  std::array<int, N> upper_bounds_; // Fortran upper bounds
  std::array<size_t, N> strides_; // Strides (multipliers for linear index)
  bool valid_;
  size_t element_size_; // Only for contiguous block mode

  // Compute linear index for Fortran indexing (with bounds)
  template <typename... Indices>
  size_t linear_index_fortran(Indices... indices) const {
    static_assert(sizeof...(indices) == N, "Wrong number of indices");
    std::array<int, N> idx{indices...};
    size_t lin = 0;
    for (std::size_t d = 0; d < N; ++d) {
      lin += static_cast<size_t>(idx[d] - lower_bounds_[d]) * strides_[d];
    }
    return lin;
  }

  // Compute linear index for C-style (0-based) indexing
  template <typename... Indices>
  size_t linear_index_c(Indices... indices) const {
    static_assert(sizeof...(indices) == N, "Wrong number of indices");
    std::array<int, N> idx{indices...};
    size_t lin = 0;
    for (std::size_t d = 0; d < N; ++d) {
      lin += static_cast<size_t>(idx[d]) * strides_[d];
    }
    return lin;
  }

  template <typename... Indices>
  void check_fortran_bounds(Indices... indices) const {
    static_assert(sizeof...(indices) == N, "Wrong number of indices");
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    std::array<int, N> idx{indices...};
    for (std::size_t d = 0; d < N; ++d) {
      if (idx[d] < lower_bounds_[d] || idx[d] > upper_bounds_[d]) {
        throw std::out_of_range(
            "Fortran index dim " + std::to_string(d + 1) +
            " out of bounds: " + std::to_string(idx[d]) + " not in [" +
            std::to_string(lower_bounds_[d]) + "," +
            std::to_string(upper_bounds_[d]) + "]");
      }
    }
  }

  template <typename... Indices>
  void check_c_bounds(Indices... indices) const {
    static_assert(sizeof...(indices) == N, "Wrong number of indices");
    if (!valid_)
      throw std::runtime_error("Array not allocated");
    std::array<int, N> idx{indices...};
    for (std::size_t d = 0; d < N; ++d) {
      if (idx[d] < 0 || idx[d] >= sizes_[d]) {
        throw std::out_of_range(
            "C index dim " + std::to_string(d + 1) +
            " out of bounds: " + std::to_string(idx[d]) + " not in [0," +
            std::to_string(sizes_[d] - 1) + "]");
      }
    }
  }

  // Get raw element pointer given linear index (already bounds-adjusted)
  void* element_ptr_from_linear(size_t lin) const {
    return static_cast<char*>(data_) + lin * element_size_;
  }

 public:
  // Contiguous struct-array constructor
  FortranTypeArrayND(
      void* struct_array,
      const std::array<int, N>& sizes,
      const std::array<int, N>& lower_bounds,
      const std::array<int, N>& upper_bounds,
      const std::array<size_t, N>& strides,
      bool valid,
      size_t element_size)
      : data_(struct_array),
        sizes_(sizes),
        lower_bounds_(lower_bounds),
        upper_bounds_(upper_bounds),
        strides_(strides),
        valid_(valid),
        element_size_(element_size) {}

  // Default invalid
  FortranTypeArrayND() : data_(nullptr), valid_(false), element_size_(0) {
    sizes_.fill(0);
    lower_bounds_.fill(0);
    upper_bounds_.fill(-1);
    strides_.fill(0);
  }

  // Fortran-style indexing
  template <typename... Indices>
  ProxyType operator()(Indices... indices) {
    check_fortran_bounds(indices...);
    size_t lin = linear_index_fortran(indices...);
    return ProxyType(element_ptr_from_linear(lin));
  }

  template <typename... Indices>
  const ProxyType operator()(Indices... indices) const {
    check_fortran_bounds(indices...);
    size_t lin = linear_index_fortran(indices...);
    return ProxyType(element_ptr_from_linear(lin));
  }

  // C-style indexing
  template <typename... Indices>
  ProxyType at(Indices... indices) {
    check_c_bounds(indices...);
    size_t lin = linear_index_c(indices...);
    return ProxyType(element_ptr_from_linear(lin));
  }

  template <typename... Indices>
  const ProxyType at(Indices... indices) const {
    check_c_bounds(indices...);
    size_t lin = linear_index_c(indices...);
    return ProxyType(element_ptr_from_linear(lin));
  }

  // Fortran safe alias
  template <typename... Indices>
  ProxyType at_fortran(Indices... indices) {
    return operator()(indices...);
  }
  template <typename... Indices>
  const ProxyType at_fortran(Indices... indices) const {
    return operator()(indices...);
  }

  // Raw element pointer (C-style indices)
  template <typename... Indices>
  void* element_ptr(Indices... indices) {
    check_c_bounds(indices...);
    size_t lin = linear_index_c(indices...);
    return element_ptr_from_linear(lin);
  }

  template <typename... Indices>
  const void* element_ptr(Indices... indices) const {
    check_c_bounds(indices...);
    size_t lin = linear_index_c(indices...);
    return element_ptr_from_linear(lin);
  }

  bool is_valid() const {
    return valid_;
  }
  size_t element_size() const {
    return element_size_;
  }

  const std::array<int, N>& sizes() const {
    return sizes_;
  }
  int size(int dim) const {
    if (dim < 1 || dim > static_cast<int>(N))
      throw std::out_of_range("Invalid dimension: " + std::to_string(dim));
    return sizes_[dim - 1];
  }

  std::array<std::pair<int, int>, N> bounds() const {
    std::array<std::pair<int, int>, N> b;
    for (std::size_t i = 0; i < N; ++i)
      b[i] = {lower_bounds_[i], upper_bounds_[i]};
    return b;
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

  const std::array<size_t, N>& strides() const {
    return strides_;
  }

  void* data() {
    return valid_ ? data_ : nullptr;
  }
  const void* data() const {
    return valid_ ? data_ : nullptr;
  }

  bool empty() const {
    if (!valid_)
      return true;
    for (int s : sizes_)
      if (s == 0)
        return true;
    return false;
  }

  // Total number of logical elements
  size_t total_size() const {
    size_t t = 1;
    for (int s : sizes_)
      t *= static_cast<size_t>(s);
    return t;
  }

  // Flat vector of ProxyType (copies proxy handles, not underlying data)
  std::vector<ProxyType> to_flat_vector() const {
    std::vector<ProxyType> out;
    if (!valid_)
      return out;
    out.reserve(total_size());

    // Enumerate C-style indices lexicographically
    std::array<int, N> idx;
    idx.fill(0);

    while (true) {
      size_t lin = 0;
      for (std::size_t d = 0; d < N; ++d)
        lin += static_cast<size_t>(idx[d]) * strides_[d];
      out.emplace_back(element_ptr_from_linear(lin));

      // Increment multi-index
      std::size_t dim = N;
      while (dim > 0) {
        --dim;
        if (++idx[dim] < sizes_[dim]) {
          break;
        } else {
          idx[dim] = 0;
        }
      }
      if (dim == 0 && idx[0] == 0) {
        // Completed last rollover
        break;
      }
    }
    return out;
  }

  // Iterator (flat) over all elements
  class iterator {
   private:
    const FortranTypeArrayND* parent_;
    size_t lin_; // linear element counter (0 .. total_size())
   public:
    using iterator_category = std::forward_iterator_tag;
    using value_type = ProxyType;
    using difference_type = std::ptrdiff_t;
    using reference = ProxyType;
    using pointer = void; // not providing pointer semantics

    iterator(const FortranTypeArrayND* p, size_t lin) : parent_(p), lin_(lin) {}

    reference operator*() {
      if (!parent_->valid_)
        throw std::runtime_error("Array not allocated");
      if (lin_ >= parent_->total_size())
        throw std::runtime_error("Iterator dereferenced at end");
      // Convert flat counter to actual linear index using strides.
      // For C-style iteration we treat idx in 0..sizes[d]-1
      size_t stride_index = 0;
      {
        size_t remaining = lin_;
        for (std::size_t d = 0; d < N; ++d) {
          size_t block = parent_->strides_[d];
          // Compute coordinate in dimension d by dividing by stride, adjusting for next dims.
          // Because strides_ is arbitrary (passed in), we cannot recover multi-index
          // generically unless strides form a standard linearization. To remain
          // consistent with prior design, we treat lin_ as already aligned with strides
          // simply by summing individual contributions; here we just use lin_ directly.
          // Assumption: linear iteration sequentially visits elements matching lin_
          // usage with pointer array or contiguous block.
          // So stride_index = lin_ (direct).
          stride_index = lin_;
        }
      }
      return ProxyType(parent_->element_ptr_from_linear(stride_index));
    }

    iterator& operator++() {
      ++lin_;
      return *this;
    }
    iterator operator++(int) {
      iterator tmp = *this;
      ++lin_;
      return tmp;
    }

    bool operator==(const iterator& other) const {
      return parent_ == other.parent_ && lin_ == other.lin_;
    }
    bool operator!=(const iterator& other) const {
      return !(*this == other);
    }
  };

  class const_iterator {
   private:
    const FortranTypeArrayND* parent_;
    size_t lin_;

   public:
    using iterator_category = std::forward_iterator_tag;
    using value_type = ProxyType;
    using difference_type = std::ptrdiff_t;
    using reference = ProxyType;
    using pointer = void;

    const_iterator(const FortranTypeArrayND* p, size_t lin)
        : parent_(p), lin_(lin) {}

    reference operator*() const {
      if (!parent_->valid_)
        throw std::runtime_error("Array not allocated");
      if (lin_ >= parent_->total_size())
        throw std::runtime_error("Iterator dereferenced at end");
      size_t stride_index = lin_; // same assumption as in iterator
      return ProxyType(parent_->element_ptr_from_linear(stride_index));
    }

    const_iterator& operator++() {
      ++lin_;
      return *this;
    }
    const_iterator operator++(int) {
      const_iterator tmp = *this;
      ++lin_;
      return tmp;
    }

    bool operator==(const const_iterator& other) const {
      return parent_ == other.parent_ && lin_ == other.lin_;
    }
    bool operator!=(const const_iterator& other) const {
      return !(*this == other);
    }
  };

  iterator begin() {
    return valid_ ? iterator(this, 0) : iterator(this, 0);
  }
  iterator end() {
    return iterator(this, total_size());
  }
  const_iterator begin() const {
    return valid_ ? const_iterator(this, 0) : const_iterator(this, 0);
  }
  const_iterator end() const {
    return const_iterator(this, total_size());
  }
  const_iterator cbegin() const {
    return begin();
  }
  const_iterator cend() const {
    return end();
  }
};

// Convenience aliases
template <typename ProxyType>
using FortranTypeArray2D = FortranTypeArrayND<ProxyType, 2>;

template <typename ProxyType>
using FortranTypeArray3D = FortranTypeArrayND<ProxyType, 3>;

std::string to_string(const tao::FortranCharArray1D& arr);

template <typename T>
std::string to_string(const tao::FortranArray1D<T>& arr) {
  return arr.to_string();
}
template <typename T>
std::string to_string(const tao::FortranArray2D<T>& arr) {
  return std::string("todo");
}
template <typename T>
std::string to_string(const tao::FortranArray3D<T>& arr) {
  return std::string("todo");
}
template <typename T, std::size_t N>
std::string to_string(const tao::FortranTypeArrayND<T, N>& arr) {
  using ::std::to_string;
  using ::tao::to_string;

  std::ostringstream oss;
  oss << "[";
  oss << "(todo fortran type array n-dimensional)";
  oss << "]";
  return oss.str();
}
template <typename T, auto Alloc, auto Dealloc>
std::string to_string(const tao::FortranTypeArray1D<T, Alloc, Dealloc>& arr) {
  using ::std::to_string;
  using ::tao::to_string;

  std::ostringstream oss;
  oss << "[";
  for (size_t i = 0; i < arr.size(); ++i) {
    if (i > 0)
      oss << ", ";
    oss << to_string(arr[i]);
  }
  oss << "]";
  return oss.str();
}

template <typename T, auto Alloc, auto Dealloc>
std::string to_string(
    const std::optional<tao::FortranTypeArray1D<T, Alloc, Dealloc>>& arr) {
  if (arr.has_value()) {
    return to_string(arr.value());
  }
  return "[]";
}

template std::string to_string(
    const tao::FortranArray1D<std::complex<double>>&);

class BmadProxyHelpers {
 public:
  // -------------------------------------------------------------------------
  // 1D Array Helper
  // -------------------------------------------------------------------------
  template <typename T, typename Func>
  static FortranArray1D<T> get_array_1d(const void* ptr, Func getter_func) {
    T* data_ptr = nullptr;
    int bounds[2]; // index 0=lower, 1=upper
    bool is_allocated = false;

    // Call the generated C-bound Fortran routine
    getter_func(ptr, &data_ptr, bounds, &is_allocated);

    int size = (is_allocated) ? (bounds[1] - bounds[0] + 1) : 0;
    return FortranArray1D<T>(
        data_ptr, size, bounds[0], bounds[1], is_allocated);
  }

  // -------------------------------------------------------------------------
  // 2D Array Helper
  // -------------------------------------------------------------------------
  template <typename T, typename Func>
  static FortranArray2D<T> get_array_2d(const void* ptr, Func getter_func) {
    T* data_ptr = nullptr;
    int bounds[4]; // dim1_low, dim1_up, dim2_low, dim2_up
    int strides[2];
    bool is_allocated = false;

    getter_func(ptr, &data_ptr, bounds, strides, &is_allocated);

    int dim1_size = (is_allocated) ? (bounds[1] - bounds[0] + 1) : 0;
    int dim2_size = (is_allocated) ? (bounds[3] - bounds[2] + 1) : 0;

    return FortranArray2D<T>(
        data_ptr,
        dim1_size,
        bounds[0],
        bounds[1],
        dim2_size,
        bounds[2],
        bounds[3],
        strides[0],
        strides[1],
        is_allocated);
  }

  // -------------------------------------------------------------------------
  // 3D Array Helper
  // -------------------------------------------------------------------------
  template <typename T, typename Func>
  static FortranArray3D<T> get_array_3d(const void* ptr, Func getter_func) {
    T* data_ptr = nullptr;
    int bounds[6]; // dim1_low, dim1_up, ... dim3_up
    int strides[3];
    bool is_allocated = false;

    getter_func(ptr, &data_ptr, bounds, strides, &is_allocated);

    int dim1_size = (is_allocated) ? (bounds[1] - bounds[0] + 1) : 0;
    int dim2_size = (is_allocated) ? (bounds[3] - bounds[2] + 1) : 0;
    int dim3_size = (is_allocated) ? (bounds[5] - bounds[4] + 1) : 0;

    return FortranArray3D<T>(
        data_ptr,
        dim1_size,
        bounds[0],
        bounds[1],
        dim2_size,
        bounds[2],
        bounds[3],
        dim3_size,
        bounds[4],
        bounds[5],
        strides[0],
        strides[1],
        strides[2],
        is_allocated);
  }

  // -------------------------------------------------------------------------
  // Helper for 1D array of character strings
  // -------------------------------------------------------------------------
  template <typename Func>
  static FortranCharArray1D get_char_array_1d(
      const void* ptr,
      Func getter_func) {
    char* data_ptr = nullptr;
    int bounds[2];
    int str_len = 0;
    bool is_allocated = false;

    getter_func(ptr, &data_ptr, bounds, &str_len, &is_allocated);

    int size = (is_allocated) ? (bounds[1] - bounds[0] + 1) : 0;
    return FortranCharArray1D(
        data_ptr, size, bounds[0], bounds[1], str_len, is_allocated);
  }
  // -------------------------------------------------------------------------
  // Character Scalar Helper
  // -------------------------------------------------------------------------
  template <typename Func>
  static std::string get_string(const void* ptr, Func getter_func) {
    char* data_ptr = nullptr;
    int str_len = 0;
    bool is_allocated = false;

    // Call Fortran
    getter_func(ptr, &data_ptr, &str_len, &is_allocated);

    if (is_allocated && data_ptr && str_len > 0) {
      return std::string(data_ptr, static_cast<size_t>(str_len));
    }
    return std::string(); // Empty string if not allocated/associated
  }
  // -------------------------------------------------------------------------
  // Derived Type Array Helpers
  // -------------------------------------------------------------------------
  template <typename ArrayT, typename Func>
  static ArrayT get_type_array_1d(const void* ptr, Func getter_func) {
    void* data_ptr = nullptr;
    int bounds[2] = {0, 0};
    bool is_allocated = false;
    size_t element_size = 0;

    // Call the C-bound Fortran interface
    getter_func(ptr, &data_ptr, bounds, &is_allocated, &element_size);

    int size = (is_allocated) ? (bounds[1] - bounds[0] + 1) : 0;

    // Invoke the non-owning constructor of the specific array type
    return ArrayT(
        data_ptr, // void* struct_array
        size, // int size
        bounds[0], // int lower
        bounds[1], // int upper
        is_allocated, // bool valid
        element_size // size_t element_size
    );
  }
  // -------------------------------------------------------------------------
  // Derived Type 2D Helper (Targeting FortranTypeArrayND<T, 2>)
  // -------------------------------------------------------------------------
  template <typename ArrayT, typename Func>
  static ArrayT get_type_array_2d(const void* ptr, Func getter_func) {
    // 1. Marshall Output from Fortran C-Interface
    void* data_ptr = nullptr;
    int bounds[4]; // dim1_L, dim1_U, dim2_L, dim2_U
    int strides_in[2];
    bool is_allocated = false;
    size_t element_size = 0;

    getter_func(
        ptr, &data_ptr, bounds, strides_in, &is_allocated, &element_size);

    // 2. Compute Derived Dimensions
    //    (Ensure 0 size if not allocated to avoid garbage data in std::array)
    int d1_sz = is_allocated ? (bounds[1] - bounds[0] + 1) : 0;
    int d2_sz = is_allocated ? (bounds[3] - bounds[2] + 1) : 0;

    // 3. Construct std::arrays for the FortranTypeArrayND constructor
    //    Note: We must explicitly cast strides from int (Fortran) to size_t (C++)
    std::array<int, 2> sizes = {d1_sz, d2_sz};
    std::array<int, 2> lowers = {bounds[0], bounds[2]};
    std::array<int, 2> uppers = {bounds[1], bounds[3]};
    std::array<size_t, 2> strides = {
        static_cast<size_t>(strides_in[0]), static_cast<size_t>(strides_in[1])};

    // 4. Invoke Constructor
    //    (ArrayT = FortranTypeArrayND<ProxyType, 2>)
    return ArrayT(
        data_ptr, sizes, lowers, uppers, strides, is_allocated, element_size);
  }

  // -------------------------------------------------------------------------
  // Derived Type 3D Helper (Targeting FortranTypeArrayND<T, 3>)
  // -------------------------------------------------------------------------
  template <typename ArrayT, typename Func>
  static ArrayT get_type_array_3d(const void* ptr, Func getter_func) {
    void* data_ptr = nullptr;
    int bounds[6]; // d1L, d1U, ... d3U
    int strides_in[3];
    bool is_allocated = false;
    size_t element_size = 0;

    getter_func(
        ptr, &data_ptr, bounds, strides_in, &is_allocated, &element_size);

    int d1_sz = is_allocated ? (bounds[1] - bounds[0] + 1) : 0;
    int d2_sz = is_allocated ? (bounds[3] - bounds[2] + 1) : 0;
    int d3_sz = is_allocated ? (bounds[5] - bounds[4] + 1) : 0;

    std::array<int, 3> sizes = {d1_sz, d2_sz, d3_sz};
    std::array<int, 3> lowers = {bounds[0], bounds[2], bounds[4]};
    std::array<int, 3> uppers = {bounds[1], bounds[3], bounds[5]};
    std::array<size_t, 3> strides = {
        static_cast<size_t>(strides_in[0]),
        static_cast<size_t>(strides_in[1]),
        static_cast<size_t>(strides_in[2])};

    return ArrayT(
        data_ptr, sizes, lowers, uppers, strides, is_allocated, element_size);
  }
};
} // namespace tao
