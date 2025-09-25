#pragma once

#include <array>
#include <iostream>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string_view>
#include <type_traits>
#include <utility>

namespace tao {
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

// Forward declaration for traits
template <typename T>
struct FortranTraits {
  static void* allocate();
  static void deallocate(void* ptr) noexcept;
  static void copy(const void* src, void* dst);
  static constexpr std::string_view type_name() {
    return "Unknown";
  }
};

// SFINAE helper to check if traits are properly specialized
template <typename T, typename = void>
struct has_fortran_traits : std::false_type {};

template <typename T>
struct has_fortran_traits<
    T,
    std::void_t<
        decltype(FortranTraits<T>::allocate()),
        decltype(FortranTraits<T>::deallocate(std::declval<void*>())),
        decltype(FortranTraits<
                 T>::copy(std::declval<const void*>(), std::declval<void*>()))>>
    : std::true_type {};

template <typename T>
inline constexpr bool has_fortran_traits_v = has_fortran_traits<T>::value;

template <typename T>
class FortranProxy {
  static_assert(
      has_fortran_traits_v<T>,
      "Type T must have specialized FortranTraits");

 protected:
  void* fortran_ptr_;
  bool owns_memory_;

 public:
  // Default constructor with guaranteed initialization
  FortranProxy()
      : fortran_ptr_(FortranTraits<T>::allocate()), owns_memory_(true) {
    if (!fortran_ptr_) {
      throw std::bad_alloc();
    }
  }

  // Constructor for proxy with optional ownership transfer
  explicit FortranProxy(void* ptr, bool take_ownership = false)
      : fortran_ptr_(ptr), owns_memory_(take_ownership) {
    if (!ptr) {
      throw NullPointerException(std::string(FortranTraits<T>::type_name()));
    }
  }

  // Copy constructor with exception safety
  FortranProxy(const FortranProxy& other)
      : fortran_ptr_(FortranTraits<T>::allocate()), owns_memory_(true) {
    if (!fortran_ptr_) {
      throw std::bad_alloc();
    }
    FortranTraits<T>::copy(other.fortran_ptr_, fortran_ptr_);
  }

  // Move constructor - noexcept guaranteed
  FortranProxy(FortranProxy&& other) noexcept
      : fortran_ptr_(std::exchange(other.fortran_ptr_, nullptr)),
        owns_memory_(other.owns_memory_) {
    other.owns_memory_ = false;
  }

  FortranProxy& operator=(const FortranProxy& other) {
    if (this != &other) {
      FortranProxy temp(other);
      *this = std::move(temp);
    }
    return *this;
  }

  FortranProxy& operator=(FortranProxy&& other) noexcept {
    if (this != &other) {
      cleanup();
      fortran_ptr_ = std::exchange(other.fortran_ptr_, nullptr);
      owns_memory_ = other.owns_memory_;
      other.owns_memory_ = false;
    }
    return *this;
  }

  ~FortranProxy() {
    cleanup();
  }

  // TODO: pointer-to-a-pointer for fortran-side `type(c_ptr), value`
  void* get_fortran_ptr() const noexcept {
    return fortran_ptr_;
  }

  bool owns_memory() const noexcept {
    return owns_memory_;
  }

  bool is_valid() const noexcept {
    return fortran_ptr_ != nullptr;
  }

  // Create independent copy
  T clone() const {
    return T(static_cast<const T&>(*this)); // Cast to derived type first
  }

 private:
  void cleanup() noexcept {
    if (fortran_ptr_ && owns_memory_) {
      FortranTraits<T>::deallocate(fortran_ptr_);
    }
    fortran_ptr_ = nullptr;
    owns_memory_ = false;
  }
};

// Factory functions
template <typename T>
auto make_fortran_owned() {
  return T{};
}

template <typename T>
auto make_fortran_proxy(void* ptr) {
  return T{ptr, false};
}

template <typename T>
auto make_fortran_owned_copy(void* ptr) {
  return T{ptr, true};
}

} // namespace tao
