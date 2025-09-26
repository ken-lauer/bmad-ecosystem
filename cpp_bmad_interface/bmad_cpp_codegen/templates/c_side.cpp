// vi: syntax=cpp
//
// See README.md for details about this file. **It is not intended to be
// compilable code!**

#include <cstddef>
#include "include/bmad_std_typedef.h"

#define DIM1 0
#define DIM2 0
#define DIM3 0

class OpaqueClass {};
class CppClass {
 public:
  void** NAME;
};

//// section:to_f
//// type:0D_NOT_character
//// type:0D_NOT_complex
//// type:0D_NOT_integer
//// type:0D_NOT_integer8
//// type:0D_NOT_logical
//// type:0D_NOT_real
//// type:0D_NOT_real16
//// type:0D_NOT_size
//// type:0D_NOT_type
//// type:1D_NOT_complex
//// type:1D_NOT_integer
//// type:1D_NOT_integer8
//// type:1D_NOT_logical
//// type:1D_NOT_real
//// type:1D_NOT_size
//// type:2D_NOT_size
//// type:3D_NOT_size
void to_f__variant_0(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// case:0D_NOT_character:to_f2_arg
  c_Char
  //// case:0D_NOT_complex:to_f2_arg
  c_Complex&
  //// case:0D_NOT_integer:to_f2_arg
  c_Int&
  //// case:0D_NOT_integer8:to_f2_arg
  c_Int8&
  //// case:0D_NOT_logical:to_f2_arg
  c_Bool&
  //// case:0D_NOT_real:to_f2_arg
  c_Real&
  //// case:0D_NOT_real16:to_f2_arg
  c_Real&
  //// case:0D_NOT_size:to_f2_arg
  c_Int
  //// case:0D_NOT_type:to_f2_arg
  void *
  //// case:1D_NOT_complex:to_f2_arg
  c_ComplexArr
  //// case:1D_NOT_integer:to_f2_arg
  c_IntArr
  //// case:1D_NOT_integer8:to_f2_arg
  c_Int8Arr
  //// case:1D_NOT_logical:to_f2_arg
  c_BoolArr
  //// case:1D_NOT_real:to_f2_arg
  c_RealArr
  //// case:1D_NOT_size:to_f2_arg
  c_Int
  //// case:2D_NOT_size:to_f2_arg
  c_Int
  //// case:3D_NOT_size:to_f2_arg
  c_Int
  */
  );
}

//// section:to_f
//// type:0D_ALLOC_character
//// type:0D_PTR_character
void to_f__variant_1(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_Char
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:0D_ALLOC_complex
//// type:0D_ALLOC_integer
//// type:0D_ALLOC_integer8
//// type:0D_ALLOC_logical
//// type:0D_ALLOC_real
//// type:0D_ALLOC_type
//// type:0D_PTR_complex
//// type:0D_PTR_integer
//// type:0D_PTR_integer8
//// type:0D_PTR_logical
//// type:0D_PTR_real
//// type:0D_PTR_type
void to_f__variant_2(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// case:0D_ALLOC_complex:to_f2_arg
  c_ComplexArr
  //// case:0D_ALLOC_integer:to_f2_arg
  c_IntArr
  //// case:0D_ALLOC_integer8:to_f2_arg
  c_Int8Arr
  //// case:0D_ALLOC_logical:to_f2_arg
  c_BoolArr
  //// case:0D_ALLOC_real:to_f2_arg
  c_RealArr
  //// case:0D_ALLOC_type:to_f2_arg
  void*
  //// case:0D_PTR_complex:to_f2_arg
  c_ComplexArr
  //// case:0D_PTR_integer:to_f2_arg
  c_IntArr
  //// case:0D_PTR_integer8:to_f2_arg
  c_Int8Arr
  //// case:0D_PTR_logical:to_f2_arg
  c_BoolArr
  //// case:0D_PTR_real:to_f2_arg
  c_RealArr
  //// case:0D_PTR_type:to_f2_arg
  void *

  */
  );
}

//// section:to_f
//// type:1D_NOT_character
void to_f__variant_3(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_Char*
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:1D_NOT_type
void to_f__variant_4(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  void*
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:1D_ALLOC_character
//// type:1D_PTR_character
void to_f__variant_5(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
        //// begin:to_f2_arg
        c_Char*
        //// end:to_f2_arg
        */
  );
}

//// section:to_f
//// type:1D_ALLOC_complex
//// type:1D_PTR_complex
//// type:1D_ALLOC_integer
//// type:1D_PTR_integer
//// type:1D_ALLOC_integer8
//// type:1D_PTR_integer8
//// type:1D_ALLOC_logical
//// type:1D_PTR_logical
//// type:1D_ALLOC_real
//// type:1D_PTR_real
void to_f__variant_10(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_CTYPEArr
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:1D_ALLOC_type
//// type:1D_PTR_type
void to_f__variant_11(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  const PROXYCLS**
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:2D_NOT_complex
//// type:2D_NOT_integer
//// type:2D_NOT_integer8
//// type:2D_NOT_logical
//// type:2D_NOT_real
void to_f__variant_16(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_CTYPEArr
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:2D_NOT_type
void to_f__variant_17(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  const PROXYCLS**
  //// end:to_f2_arg
  */
  );
}
//// section:to_f
//// type:3D_NOT_type
void to_f__variant_17a(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  const PROXYCLS**
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:2D_ALLOC_complex
//// type:2D_ALLOC_integer
//// type:2D_ALLOC_integer8
//// type:2D_ALLOC_logical
//// type:2D_ALLOC_real
//// type:2D_PTR_complex
//// type:2D_PTR_integer
//// type:2D_PTR_integer8
//// type:2D_PTR_logical
//// type:2D_PTR_real
void to_f__variant_22(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_CTYPEArr
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:2D_ALLOC_type
//// type:2D_PTR_type
void to_f__variant_23(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  const PROXYCLS**
  //// end:to_f2_arg
  */
  );
}
//// section:to_f
//// type:3D_ALLOC_type
//// type:3D_PTR_type
void to_f__variant_23a(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  const PROXYCLS**
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:3D_NOT_integer8
//// type:3D_NOT_logical
//// type:3D_NOT_real
//// type:3D_NOT_integer
//// type:3D_NOT_complex
void to_f__variant_26(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_CTYPEArr
  //// end:to_f2_arg
  */
  );
}

//// section:to_f
//// type:3D_ALLOC_complex
//// type:3D_PTR_complex
//// type:3D_ALLOC_integer
//// type:3D_PTR_integer
//// type:3D_ALLOC_integer8
//// type:3D_PTR_integer8
//// type:3D_ALLOC_real
//// type:3D_PTR_real
//// type:3D_ALLOC_logical
//// type:3D_PTR_logical
void to_f__variant_34(const CppClass& C, OpaqueClass* F) {
  to_f2(
      F, /*
        //// begin:to_f2_arg
        c_CTYPEArr
        //// end:to_f2_arg
        */
  );
}

void C_CLASS(STRUCT_CPP_CLASS& C) {
  /*
    //// section:c_class
    //// type:0D_NOT_size
    //// type:1D_NOT_size
    //// type:2D_NOT_size
    //// type:3D_NOT_size
    //// begin:c_class
    //// end:c_class

    //// section:c_class
    //// type:0D_NOT_logical
    //// begin:c_class
    Bool
    //// end:c_class

    //// section:c_class
    //// type:0D_NOT_type
    //// begin:c_class
    PROXYCLS
    //// end:c_class

    //// section:c_class
    //// type:0D_NOT_complex
    //// begin:c_class
    Complex
    //// end:c_class

    //// section:c_class
    //// type:1D_NOT_logical
    //// begin:c_class
    FixedArray1D<Bool, DIM1>
    //// end:c_class

    //// section:c_class
    //// type:1D_NOT_type
    //// begin:c_class
    FixedArray1D<PROXYCLS, DIM1>
    //// end:c_class

    //// section:c_class
    //// type:1D_NOT_complex
    //// begin:c_class
    FixedArray1D<Complex, DIM1>
    //// end:c_class

    //// section:c_class
    //// type:1D_NOT_integer
    //// begin:c_class
    FixedArray1D<Int, DIM1>
    //// end:c_class

    //// section:c_class
    //// type:1D_NOT_integer8
    //// begin:c_class
    FixedArray1D<Int8, DIM1>
    //// end:c_class

    //// section:c_class
    //// type:1D_NOT_real
    //// begin:c_class
    FixedArray1D<Real, DIM1>
    //// end:c_class

    //// section:c_class
    //// type:1D_NOT_character
    //// begin:c_class
    FixedArray1D<string, DIM1>
    //// end:c_class

    //// section:c_class
    //// type:2D_NOT_logical
    //// begin:c_class
    FixedArray2D<Bool, DIM1, DIM2>
    //// end:c_class

    //// section:c_class
    //// type:2D_NOT_complex
    //// begin:c_class
    FixedArray2D<Complex, DIM1, DIM2>
    //// end:c_class

    //// section:c_class
    //// type:2D_NOT_integer
    //// begin:c_class
    FixedArray2D<Int, DIM1, DIM2>
    //// end:c_class

    //// section:c_class
    //// type:2D_NOT_integer8
    //// begin:c_class
    FixedArray2D<Int8, DIM1, DIM2>
    //// end:c_class

    //// section:c_class
    //// type:2D_NOT_real
    //// begin:c_class
    FixedArray2D<Real, DIM1, DIM2>
    //// end:c_class

    //// section:c_class
    //// type:3D_NOT_logical
    //// begin:c_class
    FixedArray3D<Bool, DIM1, DIM2, DIM3>
    //// end:c_class

    //// section:c_class
    //// type:3D_NOT_complex
    //// begin:c_class
    FixedArray3D<Complex, DIM1, DIM2, DIM3>
    //// end:c_class

    //// section:c_class
    //// type:3D_NOT_integer
    //// begin:c_class
    FixedArray3D<Int, DIM1, DIM2, DIM3>
    //// end:c_class

    //// section:c_class
    //// type:3D_NOT_integer8
    //// begin:c_class
    FixedArray3D<Int8, DIM1, DIM2, DIM3>
    //// end:c_class

    //// section:c_class
    //// type:3D_NOT_real
    //// begin:c_class
    FixedArray3D<Real, DIM1, DIM2, DIM3>
    //// end:c_class

    //// section:c_class
    //// type:0D_NOT_integer
    //// begin:c_class
    Int
    //// end:c_class

    //// section:c_class
    //// type:0D_NOT_integer8
    //// begin:c_class
    Int8
    //// end:c_class

    //// section:c_class
    //// type:0D_NOT_real
    //// type:0D_NOT_real16
    //// begin:c_class
    Real
    //// end:c_class

    //// section:c_class
    //// type:2D_NOT_type
    //// begin:c_class
    FixedArray2D<PROXYCLS, DIM1, DIM2>
    //// end:c_class

    //// section:c_class
    //// type:3D_NOT_type
    //// begin:c_class
    FixedArray3D<PROXYCLS, DIM1, DIM2, DIM3>
    //// end:c_class

    //// section:c_class
    //// type:1D_ALLOC_logical
    //// type:1D_PTR_logical
    //// begin:c_class
    VariableArray1D<Bool>
    //// end:c_class

    //// section:c_class
    //// type:1D_ALLOC_type
    //// type:1D_PTR_type
    //// begin:c_class
    VariableArray1D<PROXYCLS>
    //// end:c_class

    //// section:c_class
    //// type:1D_ALLOC_complex
    //// type:1D_PTR_complex
    //// begin:c_class
    VariableArray1D<Complex>
    //// end:c_class

    //// section:c_class
    //// type:1D_ALLOC_integer8
    //// type:1D_PTR_integer8
    //// begin:c_class
    VariableArray1D<Int8>
    //// end:c_class

    //// section:c_class
    //// type:1D_ALLOC_integer
    //// type:1D_PTR_integer
    //// begin:c_class
    VariableArray1D<Int>
    //// end:c_class

    //// section:c_class
    //// type:1D_ALLOC_real
    //// type:1D_PTR_real
    //// begin:c_class
    VariableArray1D<Real>
    //// end:c_class

    //// section:c_class
    //// type:1D_ALLOC_character
    //// type:1D_PTR_character
    //// begin:c_class
    VariableArray1D<string>
    //// end:c_class

    //// section:c_class
    //// type:2D_ALLOC_logical
    //// type:2D_PTR_logical
    //// begin:c_class
    VariableArray2D<Bool>
    //// end:c_class

    //// section:c_class
    //// type:2D_ALLOC_type
    //// type:2D_PTR_type
    //// begin:c_class
    VariableArray2D<PROXYCLS>
    //// end:c_class

    //// section:c_class
    //// type:2D_ALLOC_complex
    //// type:2D_PTR_complex
    //// begin:c_class
    VariableArray2D<Complex>
    //// end:c_class

    //// section:c_class
    //// type:2D_ALLOC_integer8
    //// type:2D_PTR_integer8
    //// begin:c_class
    VariableArray2D<Int8>
    //// end:c_class

    //// section:c_class
    //// type:2D_ALLOC_integer
    //// type:2D_PTR_integer
    //// begin:c_class
    VariableArray2D<Int>
    //// end:c_class

    //// section:c_class
    //// type:2D_ALLOC_real
    //// type:2D_PTR_real
    //// begin:c_class
    VariableArray2D<Real>
    //// end:c_class

    //// section:c_class
    //// type:3D_ALLOC_logical
    //// type:3D_PTR_logical
    //// begin:c_class
    VariableArray3D<Bool>
    //// end:c_class

    //// section:c_class
    //// type:3D_ALLOC_type
    //// type:3D_PTR_type
    //// begin:c_class
    VariableArray3D<PROXYCLS>
    //// end:c_class

    //// section:c_class
    //// type:3D_ALLOC_complex
    //// type:3D_PTR_complex
    //// begin:c_class
    VariableArray3D<Complex>
    //// end:c_class

    //// section:c_class
    //// type:3D_ALLOC_integer8
    //// type:3D_PTR_integer8
    //// begin:c_class
    VariableArray3D<Int8>
    //// end:c_class

    //// section:c_class
    //// type:3D_ALLOC_integer
    //// type:3D_PTR_integer
    //// begin:c_class
    VariableArray3D<Int>
    //// end:c_class

    //// section:c_class
    //// type:3D_ALLOC_real
    //// type:3D_PTR_real
    //// begin:c_class
    VariableArray3D<Real>
    //// end:c_class

    //// section:c_class
    //// type:0D_ALLOC_logical
    //// type:0D_PTR_logical
    //// begin:c_class
    std::optional<Bool>
    //// end:c_class

    //// section:c_class
    //// type:0D_ALLOC_type
    //// begin:c_class
    std::optional<PROXYCLS>
    //// end:c_class

    //// section:c_class
    //// type:0D_PTR_type
    //// begin:c_class
    std::optional<PROXYCLS>
    //// end:c_class

    //// section:c_class
    //// type:0D_ALLOC_complex
    //// type:0D_PTR_complex
    //// begin:c_class
    std::optional<Complex>
    //// end:c_class

    //// section:c_class
    //// type:0D_ALLOC_integer8
    //// type:0D_PTR_integer8
    //// begin:c_class
    std::optional<Int8>
    //// end:c_class

    //// section:c_class
    //// type:0D_ALLOC_integer
    //// type:0D_PTR_integer
    //// begin:c_class
    std::optional<Int>
    //// end:c_class

    //// section:c_class
    //// type:0D_ALLOC_real
    //// type:0D_PTR_real
    //// begin:c_class
    std::optional<Real>
    //// end:c_class

    //// section:c_class
    //// type:0D_ALLOC_character
    //// type:0D_PTR_character
    //// begin:c_class
    std::optional<string>
    //// end:c_class

    //// section:c_class
    //// type:0D_NOT_character
    //// begin:c_class
    string
    //// end:c_class

  */
}
