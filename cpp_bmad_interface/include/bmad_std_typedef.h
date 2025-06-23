#include <array>
#include <complex>
#include <memory>
#include <optional>
#include <vector>

#ifndef BMAD_STD_TYPEDEF

using std::array;
using std::complex;
using std::string;
using std::vector;

namespace Bmad {

// Believe it or not, this is not in C++ until C++20:
constexpr double pi = 3.14159265358979323846;

using Bool = bool;
using Complex = complex<double>;
using Real = double;
using Int = int;
using Int8 = long int;
using Char = char*;

using c_Bool = const bool;
using c_Complex = const Complex;
using c_Real = const double;
using c_Int = const int;
using c_Int8 = const long int;
using c_String = const string;
using c_Char = const char*;

using c_BoolArr = const bool*;
using c_ComplexArr = const Complex*;
using c_RealArr = const double*;
using c_IntArr = const int*;
using c_Int8Arr = const long int*;

template <typename T, std::size_t DIM1>
using FixedArray1D = std::array<T, DIM1>;
template <typename T, std::size_t DIM1, std::size_t DIM2>
using FixedArray2D = std::array<std::array<T, DIM2>, DIM1>;
template <typename T, std::size_t DIM1, std::size_t DIM2, std::size_t DIM3>
using FixedArray3D = std::array<std::array<std::array<T, DIM3>, DIM2>, DIM1>;

template <typename T>
using VariableArray1D = std::vector<T>;
template <typename T>
using VariableArray2D = std::vector<VariableArray1D<T>>;
template <typename T>
using VariableArray3D = std::vector<VariableArray2D<T>>;

template <typename T>
using SharedVector1D = std::vector<std::shared_ptr<T>>;
template <typename T>
using SharedVector2D = std::vector<SharedVector1D<T>>;
template <typename T>
using SharedVector3D = std::vector<SharedVector2D<T>>;

template <typename T>
using optional_ref = std::optional<std::reference_wrapper<T>>;

} // namespace Bmad

#define BMAD_STD_TYPEDEF
#endif
