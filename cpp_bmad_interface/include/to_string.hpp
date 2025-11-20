#pragma once
#include <complex>
#include <iostream>
#include <sstream>
#include <string>

namespace tao {
using std::complex;
using std::string;
using std::to_string;

template <typename T>
string to_string(const complex<T>&);

template <typename T>
string to_string(const complex<T>& c) {
  std::ostringstream oss;
  oss << c.real();
  if (c.imag() >= 0) {
    oss << "+";
  }
  oss << c.imag() << "i";
  return oss.str();
}

template <typename T>
std::string to_string(const std::optional<T>& opt) {
  if (opt.has_value()) {
    return to_string(opt.value());
  }
  return "nullopt";
}

template <typename T>
std::string to_string(const T* opt) {
  if (opt) {
    return to_string(*opt);
  }
  return "nullptr";
}

template string to_string(const complex<double>&);

} // namespace tao
