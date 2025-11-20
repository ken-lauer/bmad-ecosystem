#include "to_string.hpp"
#include "fortran_arrays.hpp"

namespace tao {
string to_string(const tao::FortranCharArray1D& arr) {
  auto vec = arr.to_vector();
  if (vec.empty())
    return "[]";

  std::ostringstream oss;
  oss << "[";
  auto it = vec.begin();
  oss << "'" << *it << "'";
  for (++it; it != vec.end(); ++it) {
    oss << ", '" << *it << "'";
  }
  oss << "]";
  return oss.str();
}

} // namespace std
