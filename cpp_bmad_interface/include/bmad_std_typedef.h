#include <memory>
#include <vector>

#ifndef BMAD_STD_TYPEDEF

using std::vector;
using std::string;
using std::complex;

namespace Bmad {

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

  template<typename T>
  using Array = std::vector<T>;
  template<typename T>
  using Matrix  = std::vector<Array<T>>;
  template<typename T>
  using Tensor  = std::vector<Matrix<T>>;

  // Back-compat:
  // ARRAY: 1D
  using Bool_ARRAY = Array<bool>;
  using Complex_ARRAY = Array<Complex>;
  using Real_ARRAY = Array<double>;
  using Int_ARRAY = Array<int>;
  using String_ARRAY = Array<string>;

  // MATRIX: 2D
  using Bool_MATRIX = Matrix<Bool>;
  using Complex_MATRIX = Matrix<Complex>;
  using Real_MATRIX = Matrix<Real>;
  using Int_MATRIX = Matrix<Int>;

  // TENSOR: 3D
  using Bool_TENSOR = Tensor<Bool>;
  using Complex_TENSOR = Tensor<Complex>;
  using Real_TENSOR = Tensor<Real>;
  using Int_TENSOR = Tensor<Int>;

  template<typename T>
  using SharedArray = std::vector<std::shared_ptr<T>>;
  template<typename T>
  using SharedMatrix  = std::vector<SharedArray<T>>;
  template<typename T>
  using SharedTensor  = std::vector<SharedMatrix<T>>;

}

#define BMAD_STD_TYPEDEF
#endif
