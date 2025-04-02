#ifndef BMAD_STD_TYPEDEF

using namespace std;

typedef bool               Bool;
typedef complex<double>    Complex;
typedef double             Real;
typedef int                Int;
typedef long int           Int8;
typedef char*              Char;

typedef const bool               c_Bool;
typedef const Complex            c_Complex;
typedef const double             c_Real;
typedef const int                c_Int;
typedef const long int           c_Int8;
typedef const string             c_String;
typedef const char*              c_Char;

typedef const bool*              c_BoolArr;
typedef const Complex*           c_ComplexArr;
typedef const double*            c_RealArr;
typedef const int*               c_IntArr;
typedef const long int*          c_Int8Arr;

// ARRAY: 1D
typedef vector<bool>           Bool_ARRAY;
typedef vector<Complex>        Complex_ARRAY;
typedef vector<double>         Real_ARRAY;
typedef vector<int>            Int_ARRAY;
typedef vector<string>         String_ARRAY;

// MATRIX: 2D
typedef vector<Bool_ARRAY>     Bool_MATRIX;
typedef vector<Complex_ARRAY>  Complex_MATRIX;
typedef vector<Real_ARRAY>     Real_MATRIX;
typedef vector<Int_ARRAY>      Int_MATRIX;

// TENSOR: 3D
typedef vector<Bool_MATRIX>      Bool_TENSOR;
typedef vector<Complex_MATRIX>   Complex_TENSOR;
typedef vector<Real_MATRIX>      Real_TENSOR;
typedef vector<Int_MATRIX>       Int_TENSOR;

#define BMAD_STD_TYPEDEF
#endif
