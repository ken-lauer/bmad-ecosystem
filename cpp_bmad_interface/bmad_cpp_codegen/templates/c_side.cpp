
// vi: syntax=cpp
//
// See README.md for details about this file. **It is not intended to be
// compilable code!**

#include <cstddef>
#include "include/bmad_std_typedef.h"

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
  //// case:0D_NOT_size:to_f2_arg
  c_Int
  //// case:0D_NOT_type:to_f2_arg
  const CPP_KIND&
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
      //// case:0D_NOT_character:to_f2_call
      C.NAME.c_str(),
      //// case:0D_NOT_complex:to_f2_call
      C.NAME,
      //// case:0D_NOT_integer:to_f2_call
      C.NAME,
      //// case:0D_NOT_integer8:to_f2_call
      C.NAME,
      //// case:0D_NOT_logical:to_f2_call
      C.NAME,
      //// case:0D_NOT_real:to_f2_call
      C.NAME,
      //// case:0D_NOT_size:to_f2_call
      NAME,
      //// case:0D_NOT_type:to_f2_call
      C.NAME,
      //// case:1D_NOT_complex:to_f2_call
      &C.NAME[0],
      //// case:1D_NOT_integer:to_f2_call
      &C.NAME[0],
      //// case:1D_NOT_integer8:to_f2_call
      &C.NAME[0],
      //// case:1D_NOT_logical:to_f2_call
      &C.NAME[0],
      //// case:1D_NOT_real:to_f2_call
      &C.NAME[0],
      //// case:1D_NOT_size:to_f2_call
      NAME,
      //// case:2D_NOT_size:to_f2_call
      NAME,
      //// case:3D_NOT_size:to_f2_call
      NAME,
      //// end special cases
  );
}

//// section:to_f
//// type:0D_ALLOC_character
//// type:0D_PTR_character
void to_f__variant_1(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n_NAME = 0;
  const char* z_NAME = nullptr;
  if (C.NAME) {
    z_NAME = C.NAME->c_str();
    n_NAME = 1;
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_Char
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
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
  //// begin:to_f_setup
  auto n_NAME = C.NAME ? 1 : 0;
  //// end:to_f_setup

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
  const CPP_KIND&
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
  const CPP_KIND*

  // to_f2_call

  //// case:0D_ALLOC_complex:to_f2_call
  C.NAME,
  //// case:0D_ALLOC_integer:to_f2_call
  C.NAME,
  //// case:0D_ALLOC_integer8:to_f2_call
  C.NAME,
  //// case:0D_ALLOC_logical:to_f2_call
  C.NAME,
  //// case:0D_ALLOC_real:to_f2_call
  C.NAME,
  //// case:0D_ALLOC_type:to_f2_call
  *C.NAME,
  //// case:0D_PTR_complex:to_f2_call
  (C.NAME ? &C.NAME.value() : nullptr),
  //// case:0D_PTR_integer:to_f2_call
  (C.NAME ? &C.NAME.value() : nullptr),
  //// case:0D_PTR_integer8:to_f2_call
  (C.NAME ? &C.NAME.value() : nullptr),
  //// case:0D_PTR_logical:to_f2_call
  (C.NAME ? &C.NAME.value() : nullptr),
  //// case:0D_PTR_real:to_f2_call
  (C.NAME ? &C.NAME.value() : nullptr),
  //// case:0D_PTR_type:to_f2_call
  (C.NAME ? &C.NAME.value() : nullptr),
  //// end special cases
  */
  );
}

//// section:to_f
//// type:1D_NOT_character
void to_f__variant_3(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  c_Char z_NAME[DIM1];
  for (size_t i{0}; i < DIM1; i++) {
    z_NAME[i] = C.NAME[i].c_str();
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_Char*
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );
}

//// section:to_f
//// type:1D_NOT_type
void to_f__variant_4(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  const CPP_KIND* z_NAME[DIM1];
  for (int i = 0; i < DIM1; i++) {
    z_NAME[i] = &C.NAME[i];
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );
}

//// section:to_f
//// type:1D_ALLOC_character
//// type:1D_PTR_character
void to_f__variant_5(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n1_NAME{C.NAME.size()};
  c_Char* z_NAME = nullptr;
  if (n1_NAME != 0) {
    z_NAME = new c_Char[n1_NAME];
    for (size_t i{0}; i < n1_NAME; i++)
      z_NAME[i] = C.NAME[i].c_str();
  }
  //// end:to_f_setup

  to_f2(
      F, /*
        //// begin:to_f2_arg
        c_Char*
        //// end:to_f2_arg
        */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME)
    delete[] z_NAME;
  //// end:to_f_cleanup
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
  //// begin:to_f_setup
  size_t n1_NAME = C.NAME.size();
  c_CTYPEArr z_NAME = nullptr;
  if (n1_NAME > 0) {
    z_NAME = &C.NAME[0];
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_CTYPEArr
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );
}

//// section:to_f
//// type:1D_ALLOC_type
//// type:1D_PTR_type
void to_f__variant_11(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n1_NAME = C.NAME.size();
  const CPP_KIND** z_NAME = nullptr;
  if (n1_NAME != 0) {
    z_NAME = new const CPP_KIND*[n1_NAME];
    for (size_t i{0}; i < n1_NAME; i++)
      z_NAME[i] = &C.NAME[i];
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME)
    delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:2D_NOT_complex
//// type:2D_NOT_integer
//// type:2D_NOT_integer8
//// type:2D_NOT_logical
//// type:2D_NOT_real
void to_f__variant_16(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  CTYPE z_NAME[DIM1 * DIM2];
  matrix_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_CTYPEArr
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );
}

//// section:to_f
//// type:2D_NOT_type
void to_f__variant_17(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  const CPP_KIND* z_NAME[DIM1 * DIM2];
  for (size_t i{0}; i < DIM1; i++)
    for (size_t j{0}; j < DIM2; j++) {
      auto m = DIM2 * i + j;
      z_NAME[m] = &C.NAME[i][j];
    }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );
}
//// section:to_f
//// type:3D_NOT_type
void to_f__variant_17a(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  const CPP_KIND* z_NAME[DIM1 * DIM2 * DIM3];
  for (size_t i{0}; i < DIM1; i++) {
    for (size_t j{0}; j < DIM2; j++) {
      for (size_t k{0}; k < DIM3; k++) {
        auto m = DIM3 * DIM2 * i + DIM3 * j + k;
        z_NAME[m] = &C.NAME[i][j][k];
      }
    }
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
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
  //// begin:to_f_setup
  size_t n1_NAME{C.NAME.size()};
  size_t n2_NAME{size_t{0}};
  CTYPE* z_NAME = nullptr;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new CTYPE[n1_NAME * n2_NAME];
    matrix_to_vec(C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_CTYPEArr
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME)
    delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:2D_ALLOC_type
//// type:2D_PTR_type
void to_f__variant_23(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n1_NAME{C.NAME.size()};
  size_t n2_NAME{size_t{0}};
  const CPP_KIND** z_NAME{nullptr};
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new const CPP_KIND*[n1_NAME * n2_NAME];
    for (size_t i{0}; i < n1_NAME; i++) {
      for (size_t j{0}; j < n2_NAME; j++) {
        z_NAME[i * n2_NAME + j] = &C.NAME[i][j];
      }
    }
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME)
    delete[] z_NAME;
  //// end:to_f_cleanup
}
//// section:to_f
//// type:3D_ALLOC_type
//// type:3D_PTR_type
void to_f__variant_23a(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n1_NAME{C.NAME.size()};
  size_t n2_NAME{size_t{0}};
  size_t n3_NAME{size_t{0}};
  const CPP_KIND** z_NAME{nullptr};
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new const CPP_KIND*[n1_NAME * n2_NAME * n3_NAME];
    for (size_t i{0}; i < n1_NAME; i++) {
      for (size_t j{0}; j < n2_NAME; j++) {
        for (size_t k{0}; k < n3_NAME; k++) {
          auto m = n3_NAME * n2_NAME * i + n3_NAME * j + k;
          z_NAME[m] = &C.NAME[i][j][k];
        }
      }
    }
  }
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME)
    delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:3D_NOT_integer8
//// type:3D_NOT_logical
//// type:3D_NOT_real
//// type:3D_NOT_integer
//// type:3D_NOT_complex
void to_f__variant_26(const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  CTYPE z_NAME[DIM1 * DIM2 * DIM3];
  tensor_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(
      F, /*
  //// begin:to_f2_arg
  c_CTYPEArr
  //// end:to_f2_arg
  */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
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
  //// begin:to_f_setup
  size_t n1_NAME{C.NAME.size()};
  size_t n2_NAME{size_t{0}};
  size_t n3_NAME{size_t{0}};
  Real* z_NAME{nullptr};
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new CTYPE[n1_NAME * n2_NAME * n3_NAME];
    tensor_to_vec(C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(
      F, /*
        //// begin:to_f2_arg
        c_CTYPEArr
        //// end:to_f2_arg
        */
      //// begin:to_f2_call
      z_NAME
      //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME)
    delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_c2
//// type:0D_NOT_complex
//// type:0D_NOT_integer
//// type:0D_NOT_integer8
//// type:0D_NOT_logical
//// type:0D_NOT_real
//// type:0D_NOT_size
//// type:1D_NOT_size
//// type:2D_NOT_size
//// type:3D_NOT_size
void to_c2__variant_0(
    STRUCT_CPP_CLASS& C,
    //// case:0D_NOT_complex:to_c2_arg
    c_Complex& z_NAME,
    //// case:0D_NOT_integer:to_c2_arg
    c_Int& z_NAME,
    //// case:0D_NOT_integer8:to_c2_arg
    c_Int8& z_NAME,
    //// case:0D_NOT_logical:to_c2_arg
    c_Bool& z_NAME,
    //// case:0D_NOT_real:to_c2_arg
    c_Real& z_NAME,
    //// case:0D_NOT_size:to_c2_arg
    c_Int NAME,
    //// case:1D_NOT_size:to_c2_arg
    c_Int NAME,
    //// case:2D_NOT_size:to_c2_arg
    c_Int NAME,
    //// case:3D_NOT_size:to_c2_arg
    c_Int NAME,
    //// end special cases
) {
  //// begin:to_c2_set
  C.NAME = z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_character
void to_c2__variant_0(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_Char z_NAME,
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME = std::string{z_NAME};
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_type
void to_c2__variant_1(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    const Opaque_KIND_class* z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  KIND_to_c(z_NAME, C.NAME);
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_character
//// type:0D_PTR_character
void to_c2__variant_2(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_Char z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME.reset();
  } else {
    C.NAME.emplace(std::string{z_NAME});
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_complex
//// type:0D_PTR_complex
void to_c2__variant_3(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_ComplexArr z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME.reset();
  } else {
    C.NAME.emplace(*z_NAME);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_integer
//// type:0D_PTR_integer
void to_c2__variant_4(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_IntArr z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME.reset();
  } else {
    C.NAME.emplace(*z_NAME);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_integer8
//// type:0D_PTR_integer8
void to_c2__variant_5(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_Int8Arr z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME.reset();
  } else {
    C.NAME.emplace(*z_NAME);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_logical
//// type:0D_PTR_logical
void to_c2__variant_6(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_BoolArr z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME.reset();
  } else {
    C.NAME.emplace(*z_NAME);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_real
//// type:0D_PTR_real
void to_c2__variant_7(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_RealArr z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME.reset();
  } else {
    C.NAME.emplace(*z_NAME);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_type
//// type:0D_PTR_type
void to_c2__variant_8(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    Opaque_KIND_class* z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME.reset();
  } else {
    C.NAME.emplace();
    KIND_to_c(z_NAME, C.NAME.value());
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_character
void to_c2__variant_9(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_Char* z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  for (size_t i{0}; i < C.NAME.size(); i++)
    C.NAME[i] = z_NAME[i];
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_complex
//// type:1D_NOT_integer
//// type:1D_NOT_integer8
//// type:1D_NOT_logical
//// type:1D_NOT_real
//// type:2D_NOT_complex
//// type:2D_NOT_integer
//// type:2D_NOT_integer8
//// type:2D_NOT_logical
//// type:2D_NOT_real
//// type:3D_NOT_complex
//// type:3D_NOT_integer
//// type:3D_NOT_integer8
//// type:3D_NOT_logical
//// type:3D_NOT_real
void to_c2__variant_10(
    STRUCT_CPP_CLASS& C,
    //// case:1D_NOT_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:1D_NOT_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:1D_NOT_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:1D_NOT_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:1D_NOT_real:to_c2_arg
    c_RealArr z_NAME,
    //// case:2D_NOT_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:2D_NOT_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:2D_NOT_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:2D_NOT_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:2D_NOT_real:to_c2_arg
    c_RealArr z_NAME,
    //// case:3D_NOT_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:3D_NOT_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:3D_NOT_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:3D_NOT_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:3D_NOT_real:to_c2_arg
    c_RealArr z_NAME,
    //// end special cases
) {
  //// begin:to_c2_set
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_type
void to_c2__variant_11(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    const Opaque_KIND_class** z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  for (size_t i{0}; i < C.NAME.size(); i++) {
    KIND_to_c(z_NAME[i], C.NAME[i]);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_character
//// type:1D_PTR_character
void to_c2__variant_12(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    c_Char* z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i{0}; i < n1_NAME; i++)
    C.NAME[i] = z_NAME[i];
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_complex
//// type:1D_ALLOC_integer
//// type:1D_ALLOC_integer8
//// type:1D_ALLOC_logical
//// type:1D_ALLOC_real
//// type:1D_PTR_complex
//// type:1D_PTR_integer
//// type:1D_PTR_integer8
//// type:1D_PTR_logical
//// type:1D_PTR_real
void to_c2__variant_13(
    STRUCT_CPP_CLASS& C,
    //// case:1D_ALLOC_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:1D_ALLOC_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:1D_ALLOC_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:1D_ALLOC_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:1D_ALLOC_real:to_c2_arg
    c_RealArr z_NAME,
    //// case:1D_PTR_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:1D_PTR_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:1D_PTR_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:1D_PTR_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:1D_PTR_real:to_c2_arg
    c_RealArr z_NAME,
    //// end special cases
) {
  //// begin:to_c2_set

  C.NAME.resize(n1_NAME);
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_type
//// type:1D_PTR_type
void to_c2__variant_14(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    Opaque_KIND_class** z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i{0}; i < n1_NAME; i++) {
    KIND_to_c(z_NAME[i], C.NAME[i]);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_NOT_type
void to_c2__variant_15(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    const Opaque_KIND_class** z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  for (size_t i{0}; i < C.NAME.size(); i++)
    for (size_t j{0}; j < C.NAME[0].size(); j++) {
      auto m = DIM2 * i + j;
      KIND_to_c(z_NAME[m], *C.NAME[i][j]);
    }
  //// end:to_c2_set
}

//// section:to_c2
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
void to_c2__variant_16(
    STRUCT_CPP_CLASS& C,
    //// case:2D_ALLOC_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:2D_ALLOC_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:2D_ALLOC_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:2D_ALLOC_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:2D_ALLOC_real:to_c2_arg
    c_RealArr z_NAME,
    //// case:2D_PTR_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:2D_PTR_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:2D_PTR_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:2D_PTR_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:2D_PTR_real:to_c2_arg
    c_RealArr z_NAME,
    //// end special cases
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i{0}; i < n1_NAME; i++)
    C.NAME[i].resize(n2_NAME);
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_ALLOC_type
//// type:2D_PTR_type
void to_c2__variant_17(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    Opaque_KIND_class** z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i{0}; i < n1_NAME; i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j{0}; j < n2_NAME; j++) {
      auto& item = C.NAME[i][j];
      KIND_to_c(z_NAME[n2_NAME * i + j], item);
    }
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_NOT_type
void to_c2__variant_18(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    const Opaque_KIND_class** z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set
  for (size_t i{0}; i < C.NAME.size(); i++)
    for (size_t j{0}; j < C.NAME[0].size(); j++)
      for (size_t k{0}; k < C.NAME[0][0].size(); k++) {
        auto m = DIM3 * DIM2 * i + DIM3 * j + k;
        KIND_to_c(z_NAME[m], C.NAME[i][j][k]);
      }
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_ALLOC_complex
//// type:3D_ALLOC_integer
//// type:3D_ALLOC_integer8
//// type:3D_ALLOC_logical
//// type:3D_ALLOC_real
//// type:3D_PTR_complex
//// type:3D_PTR_integer
//// type:3D_PTR_integer8
//// type:3D_PTR_logical
//// type:3D_PTR_real
void to_c2__variant_19(
    STRUCT_CPP_CLASS& C,
    //// case:3D_ALLOC_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:3D_ALLOC_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:3D_ALLOC_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:3D_ALLOC_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:3D_ALLOC_real:to_c2_arg
    c_RealArr z_NAME,
    //// case:3D_PTR_complex:to_c2_arg
    c_ComplexArr z_NAME,
    //// case:3D_PTR_integer:to_c2_arg
    c_IntArr z_NAME,
    //// case:3D_PTR_integer8:to_c2_arg
    c_Int8Arr z_NAME,
    //// case:3D_PTR_logical:to_c2_arg
    c_BoolArr z_NAME,
    //// case:3D_PTR_real:to_c2_arg
    c_RealArr z_NAME,
    //// end special cases
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i{0}; i < C.NAME.size(); i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j{0}; j < C.NAME[0].size(); j++)
      C.NAME[i][j].resize(n3_NAME);
  }
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_ALLOC_type
//// type:3D_PTR_type
void to_c2__variant_20(
    STRUCT_CPP_CLASS& C,
    //// begin:to_c2_arg
    Opaque_KIND_class** z_NAME
    //// end:to_c2_arg
) {
  //// begin:to_c2_set

  C.NAME.resize(n1_NAME);
  for (size_t i{0}; i < n1_NAME; i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j{0}; j < n2_NAME; j++) {
      C.NAME[i][j].resize(n3_NAME);
      for (size_t k{0}; k < n3_NAME; k++) {
        KIND_to_c(
            z_NAME[n3_NAME * n2_NAME * i + n3_NAME * j + k], C.NAME[i][j][k]);
      }
    }
  }
  //// end:to_c2_set
}

void EQUALITY_TEST(STRUCT_CPP_CLASS& C) {
  /*
    //// section:equality_test
    //// type:0D_ALLOC_character
    //// type:0D_ALLOC_complex
    //// type:0D_ALLOC_integer
    //// type:0D_ALLOC_integer8
    //// type:0D_ALLOC_logical
    //// type:0D_ALLOC_real
    //// type:0D_ALLOC_type
    //// type:0D_PTR_character
    //// type:0D_PTR_complex
    //// type:0D_PTR_integer
    //// type:0D_PTR_integer8
    //// type:0D_PTR_logical
    //// type:0D_PTR_real
    //// type:0D_PTR_type
    //// begin:equality_test
    is_eq = is_eq && (x.NAME.has_value() == y.NAME.has_value());
    if (!is_eq) return false;
    if (x.NAME) is_eq = (*x.NAME == *y.NAME);
    //// end:equality_test

    //// section:equality_test
    //// type:0D_NOT_character
    //// type:0D_NOT_complex
    //// type:0D_NOT_integer
    //// type:0D_NOT_integer8
    //// type:0D_NOT_logical
    //// type:0D_NOT_real
    //// type:0D_NOT_size
    //// type:0D_NOT_type
    //// type:1D_NOT_size
    //// type:2D_NOT_size
    //// type:3D_NOT_size
    //// begin:equality_test
    is_eq = is_eq && (x.NAME == y.NAME);
    //// end:equality_test

    //// section:equality_test
    //// type:1D_ALLOC_character
    //// type:1D_ALLOC_complex
    //// type:1D_ALLOC_integer
    //// type:1D_ALLOC_integer8
    //// type:1D_ALLOC_logical
    //// type:1D_ALLOC_real
    //// type:1D_ALLOC_type
    //// type:1D_NOT_character
    //// type:1D_NOT_complex
    //// type:1D_NOT_integer
    //// type:1D_NOT_integer8
    //// type:1D_NOT_logical
    //// type:1D_NOT_real
    //// type:1D_NOT_type
    //// type:1D_PTR_character
    //// type:1D_PTR_complex
    //// type:1D_PTR_integer
    //// type:1D_PTR_integer8
    //// type:1D_PTR_logical
    //// type:1D_PTR_real
    //// type:1D_PTR_type
    //// type:2D_ALLOC_complex
    //// type:2D_ALLOC_integer
    //// type:2D_ALLOC_integer8
    //// type:2D_ALLOC_logical
    //// type:2D_ALLOC_real
    //// type:2D_ALLOC_type
    //// type:2D_NOT_complex
    //// type:2D_NOT_integer
    //// type:2D_NOT_integer8
    //// type:2D_NOT_logical
    //// type:2D_NOT_real
    //// type:2D_NOT_type
    //// type:2D_PTR_complex
    //// type:2D_PTR_integer
    //// type:2D_PTR_integer8
    //// type:2D_PTR_logical
    //// type:2D_PTR_real
    //// type:2D_PTR_type
    //// type:3D_ALLOC_complex
    //// type:3D_ALLOC_integer
    //// type:3D_ALLOC_integer8
    //// type:3D_ALLOC_logical
    //// type:3D_ALLOC_real
    //// type:3D_ALLOC_type
    //// type:3D_NOT_complex
    //// type:3D_NOT_integer
    //// type:3D_NOT_integer8
    //// type:3D_NOT_logical
    //// type:3D_NOT_real
    //// type:3D_NOT_type
    //// type:3D_PTR_complex
    //// type:3D_PTR_integer
    //// type:3D_PTR_integer8
    //// type:3D_PTR_logical
    //// type:3D_PTR_real
    //// type:3D_PTR_type
    //// begin:equality_test
    is_eq = is_eq && is_all_equal(x.NAME, y.NAME);
    //// end:equality_test

  */
}
void TEST_PAT(STRUCT_CPP_CLASS& C) {
  //// section:test_pat
  //// type:0D_NOT_character
  //// begin:test_value
  rhs;
  //// end:test_value
  //// begin:test_pat
  C.NAME.resize(STR_LEN);
  for (size_t i{0}; i < C.NAME.size(); i++) {
    int rhs = 101 + i + ARGIDX + offset;
    C.NAME[i] = 'a' + rhs % 26;
  }
  //// end:test_pat

  //// section:test_pat
  //// type:1D_NOT_complex
  //// type:1D_NOT_integer
  //// type:1D_NOT_integer8
  //// type:1D_NOT_logical
  //// type:1D_NOT_real
  //// case:1D_NOT_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:1D_NOT_integer:test_value
  rhs;
  //// case:1D_NOT_integer8:test_value
  rhs;
  //// case:1D_NOT_logical:test_value
  (rhs % 2 == 0);
  //// case:1D_NOT_real:test_value
  rhs;
  //// begin:test_pat
  for (size_t i{0}; i < C.NAME.size(); i++) {
    int rhs = 101 + i + ARGIDX + offset;
    C.NAME[i] = TEST_VALUE;
  }
  //// end:test_pat

  //// section:test_pat
  //// type:1D_NOT_type
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  for (size_t i{0}; i < C.NAME.size(); i++) {
    int rhs = 101 + i + ARGIDX + offset;
    set_CPP_KIND_test_pattern(C.NAME[i], ix_patt + i + 1);
  }
  //// end:test_pat

  //// section:test_pat
  //// type:2D_NOT_complex
  //// type:2D_NOT_integer
  //// type:2D_NOT_integer8
  //// type:2D_NOT_logical
  //// type:2D_NOT_real
  //// case:2D_NOT_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:2D_NOT_integer:test_value
  rhs;
  //// case:2D_NOT_integer8:test_value
  rhs;
  //// case:2D_NOT_logical:test_value
  (rhs % 2 == 0);
  //// case:2D_NOT_real:test_value
  rhs;
  //// begin:test_pat
  for (size_t i{0}; i < C.NAME.size(); i++)
    for (size_t j{0}; j < C.NAME[0].size(); j++) {
      int rhs = 101 + i + 10 * (j + 1) + ARGIDX + offset;
      C.NAME[i][j] = TEST_VALUE;
    }
  //// end:test_pat

  //// section:test_pat
  //// type:2D_NOT_type
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  for (size_t i{0}; i < C.NAME.size(); i++)
    for (size_t j{0}; j < C.NAME[0].size(); j++) {
      int rhs = 101 + i + 10 * (j + 1) + ARGIDX + offset;
      set_CPP_KIND_test_pattern(*C.NAME[i][j], ix_patt + i + 1 + 10 * (j + 1));
    }
  //// end:test_pat

  //// section:test_pat
  //// type:3D_NOT_complex
  //// type:3D_NOT_integer
  //// type:3D_NOT_integer8
  //// type:3D_NOT_logical
  //// type:3D_NOT_real
  //// case:3D_NOT_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:3D_NOT_integer:test_value
  rhs;
  //// case:3D_NOT_integer8:test_value
  rhs;
  //// case:3D_NOT_logical:test_value
  (rhs % 2 == 0);
  //// case:3D_NOT_real:test_value
  rhs;
  //// begin:test_pat
  for (size_t i{0}; i < C.NAME.size(); i++)
    for (size_t j{0}; j < C.NAME[0].size(); j++)
      for (size_t k{0}; k < C.NAME[0][0].size(); k++) {
        int rhs = 101 + i + 10 * (j + 1) + 100 * (k + 1) + ARGIDX + offset;
        C.NAME[i][j][k] = TEST_VALUE;
      }
  //// end:test_pat

  //// section:test_pat
  //// type:3D_NOT_type
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  for (size_t i{0}; i < C.NAME.size(); i++)
    for (size_t j{0}; j < C.NAME[0].size(); j++)
      for (size_t k{0}; k < C.NAME[0][0].size(); k++) {
        int rhs = 101 + i + 10 * (j + 1) + 100 * (k + 1) + ARGIDX + offset;
        set_CPP_KIND_test_pattern(
            C.NAME[i][j][k], ix_patt + i + 1 + 10 * (j + 1) + 100 * (k + 1));
      }
  //// end:test_pat

  //// section:test_pat
  //// type:1D_NOT_character
  //// begin:test_value
  rhs;
  //// end:test_value
  //// begin:test_pat
  for (size_t i{0}; i < C.NAME.size(); i++) {
    C.NAME[i].resize(STR_LEN);
    for (size_t j{0}; j < C.NAME[i].size(); j++) {
      C.NAME[i][j] = 'a' + (101 + i + 10 * (j + 1) + ARGIDX + offset) % 26;
    }
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_logical
  //// type:0D_PTR_logical
  //// begin:test_value
  (rhs % 2 == 0);
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.reset();
  } else {
    rhs = ARGIDX + offset;
    C.NAME.emplace(TEST_VALUE);
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_type
  //// type:0D_PTR_type
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.reset();
  } else {
    C.NAME.emplace();
    set_CPP_KIND_test_pattern(C.NAME.value(), ix_patt);
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_complex
  //// type:0D_PTR_complex
  //// begin:test_value
  Complex(rhs, 100 + rhs);
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.reset();
  } else {
    rhs = ARGIDX + offset;
    C.NAME.emplace(TEST_VALUE);
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_integer8
  //// type:0D_PTR_integer8
  //// begin:test_value
  rhs;
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.reset();
  } else {
    rhs = ARGIDX + offset;
    C.NAME.emplace(TEST_VALUE);
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_integer
  //// type:0D_PTR_integer
  //// begin:test_value
  rhs;
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.reset();
  } else {
    rhs = ARGIDX + offset;
    C.NAME.emplace(TEST_VALUE);
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_real
  //// type:0D_PTR_real
  //// begin:test_value
  rhs;
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.reset();
  } else {
    rhs = ARGIDX + offset;
    C.NAME.emplace(TEST_VALUE);
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_character
  //// type:0D_PTR_character
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.reset();
  } else {
    auto str = std::string(STR_LEN, ' ');
    for (size_t i{0}; i < STR_LEN; i++) {
      str[i] = 'a' + (101 + i + ARGIDX + offset) % 26;
    }
    C.NAME.emplace(str);
  }
  //// end:test_pat

  //// section:test_pat
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
  //// case:2D_ALLOC_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:2D_ALLOC_integer:test_value
  rhs;
  //// case:2D_ALLOC_integer8:test_value
  rhs;
  //// case:2D_ALLOC_logical:test_value
  (rhs % 2 == 0);
  //// case:2D_ALLOC_real:test_value
  rhs;
  //// case:2D_PTR_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:2D_PTR_integer:test_value
  rhs;
  //// case:2D_PTR_integer8:test_value
  rhs;
  //// case:2D_PTR_logical:test_value
  (rhs % 2 == 0);
  //// case:2D_PTR_real:test_value
  rhs;
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.resize(0);
  } else {
    C.NAME.resize(3);
    for (size_t i{0}; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);
      for (size_t j{0}; j < C.NAME[0].size(); j++) {
        int rhs = 101 + i + 10 * (j + 1) + ARGIDX + offset;
        C.NAME[i][j] = TEST_VALUE;
      }
    }
  }
  //// end:test_pat

  //// section:test_pat
  //// type:1D_ALLOC_complex
  //// type:1D_ALLOC_integer
  //// type:1D_ALLOC_integer8
  //// type:1D_ALLOC_logical
  //// type:1D_ALLOC_real
  //// type:1D_PTR_complex
  //// type:1D_PTR_integer
  //// type:1D_PTR_integer8
  //// type:1D_PTR_logical
  //// type:1D_PTR_real
  //// case:1D_ALLOC_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:1D_ALLOC_integer:test_value
  rhs;
  //// case:1D_ALLOC_integer8:test_value
  rhs;
  //// case:1D_ALLOC_logical:test_value
  (rhs % 2 == 0);
  //// case:1D_ALLOC_real:test_value
  rhs;
  //// case:1D_PTR_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:1D_PTR_integer:test_value
  rhs;
  //// case:1D_PTR_integer8:test_value
  rhs;
  //// case:1D_PTR_logical:test_value
  (rhs % 2 == 0);
  //// case:1D_PTR_real:test_value
  rhs;
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.resize(0);
  } else {
    C.NAME.resize(3);
    for (size_t i{0}; i < C.NAME.size(); i++) {
      int rhs = 101 + i + ARGIDX + offset;
      C.NAME[i] = TEST_VALUE;
    }
  }
  //// end:test_pat

  //// section:test_pat
  //// type:1D_ALLOC_type
  //// type:1D_PTR_type
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.resize(0);
  } else {
    C.NAME.resize(3);
    for (size_t i{0}; i < C.NAME.size(); i++) {
      set_CPP_KIND_test_pattern(C.NAME[i], ix_patt + i + 1);
    }
  }
  //// end:test_pat

  //// section:test_pat
  //// type:2D_ALLOC_type
  //// type:2D_PTR_type
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.resize(0);
  } else {
    C.NAME.resize(3);
    for (size_t i{0}; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);
      for (size_t j{0}; j < C.NAME[0].size(); j++) {
        auto& item = C.NAME[i][j];
        set_CPP_KIND_test_pattern(item, ix_patt + i + 2 * j + 3);
      }
    }
  }
  //// end:test_pat

  //// section:test_pat
  //// type:3D_ALLOC_type
  //// type:3D_PTR_type
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.resize(0);
  } else {
    C.NAME.resize(3);
    for (size_t i{0}; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);
      for (size_t j{0}; j < C.NAME[0].size(); j++) {
        C.NAME[i][j].resize(1);
        for (size_t k{0}; k < C.NAME[0][0].size(); k++) {
          set_CPP_KIND_test_pattern(
              C.NAME[i][j][k], ix_patt + i + 2 * j + 3 * k + 6);
        }
      }
    }
  }
  //// end:test_pat

  //// section:test_pat
  //// type:3D_ALLOC_complex
  //// type:3D_ALLOC_integer
  //// type:3D_ALLOC_integer8
  //// type:3D_ALLOC_logical
  //// type:3D_ALLOC_real
  //// type:3D_PTR_complex
  //// type:3D_PTR_integer
  //// type:3D_PTR_integer8
  //// type:3D_PTR_logical
  //// type:3D_PTR_real
  //// case:3D_ALLOC_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:3D_ALLOC_integer:test_value
  rhs;
  //// case:3D_ALLOC_integer8:test_value
  rhs;
  //// case:3D_ALLOC_logical:test_value
  (rhs % 2 == 0);
  //// case:3D_ALLOC_real:test_value
  rhs;
  //// case:3D_PTR_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:3D_PTR_integer:test_value
  rhs;
  //// case:3D_PTR_integer8:test_value
  rhs;
  //// case:3D_PTR_logical:test_value
  (rhs % 2 == 0);
  //// case:3D_PTR_real:test_value
  rhs;
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.resize(0);
  } else {
    C.NAME.resize(3);
    for (size_t i{0}; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);
      for (size_t j{0}; j < C.NAME[0].size(); j++) {
        C.NAME[i][j].resize(1);
        for (size_t k{0}; k < C.NAME[0][0].size(); k++) {
          auto rhs = 101 + i + 10 * (j + 1) + 100 * (k + 1) + ARGIDX + offset;
          C.NAME[i][j][k] = TEST_VALUE;
        }
      }
    }
  }
  //// end:test_pat

  //// section:test_pat
  //// type:1D_ALLOC_character
  //// type:1D_PTR_character
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3) {
    C.NAME.resize(0);
  } else {
    C.NAME.resize(3);
    for (size_t i{0}; i < C.NAME.size(); i++) {
      C.NAME[i].resize(STR_LEN);
      for (size_t j{0}; j < C.NAME[0].size(); j++) {
        C.NAME[i][j] = 'a' + (101 + i + 10 * (j + 1) + ARGIDX + offset) % 26;
      }
    }
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_NOT_complex
  //// type:0D_NOT_integer
  //// type:0D_NOT_integer8
  //// type:0D_NOT_logical
  //// type:0D_NOT_real
  //// type:0D_NOT_size
  //// type:1D_NOT_size
  //// type:2D_NOT_size
  //// type:3D_NOT_size
  //// case:0D_NOT_complex:test_value
  Complex(rhs, 100 + rhs);
  //// case:0D_NOT_integer:test_value
  rhs;
  //// case:0D_NOT_integer8:test_value
  rhs;
  //// case:0D_NOT_logical:test_value
  (rhs % 2 == 0);
  //// case:0D_NOT_real:test_value
  rhs;
  //// case:0D_NOT_size:test_value
  rhs;
  //// case:1D_NOT_size:test_value
  rhs;
  //// case:2D_NOT_size:test_value
  rhs;
  //// case:3D_NOT_size:test_value
  rhs;
  //// begin:test_pat
  rhs = ARGIDX + offset;
  C.NAME = TEST_VALUE;
  //// end:test_pat

  //// section:test_pat
  //// type:0D_NOT_type
  //// begin:test_value

  //// end:test_value
  //// begin:test_pat
  set_CPP_KIND_test_pattern(C.NAME, ix_patt);
  //// end:test_pat
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
    CPP_KIND
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
    FixedArray1D<CPP_KIND, DIM1>
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
    //// begin:c_class
    Real
    //// end:c_class

    //// section:c_class
    //// type:2D_NOT_type
    //// begin:c_class
    FixedArray2D<CPP_KIND, DIM1, DIM2>
    //// end:c_class

    //// section:c_class
    //// type:3D_NOT_type
    //// begin:c_class
    FixedArray3D<CPP_KIND, DIM1, DIM2, DIM3>
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
    VariableArray1D<CPP_KIND>
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
    VariableArray2D<CPP_KIND>
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
    VariableArray3D<CPP_KIND>
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
    //// type:0D_PTR_type
    //// begin:c_class
    std::optional<CPP_KIND>
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
void CLASS_INITIALIZER(STRUCT_CPP_CLASS& C) {
  /*
    //// section:class_initializer
    //// type:0D_NOT_type
    //// type:1D_ALLOC_character
    //// type:1D_ALLOC_complex
    //// type:1D_ALLOC_integer
    //// type:1D_ALLOC_integer8
    //// type:1D_ALLOC_logical
    //// type:1D_ALLOC_real
    //// type:1D_ALLOC_type
    //// type:1D_NOT_type
    //// type:1D_PTR_character
    //// type:1D_PTR_complex
    //// type:1D_PTR_integer
    //// type:1D_PTR_integer8
    //// type:1D_PTR_logical
    //// type:1D_PTR_real
    //// type:1D_PTR_type
    //// type:2D_ALLOC_complex
    //// type:2D_ALLOC_integer
    //// type:2D_ALLOC_integer8
    //// type:2D_ALLOC_logical
    //// type:2D_ALLOC_real
    //// type:2D_ALLOC_type
    //// type:2D_NOT_complex
    //// type:2D_NOT_integer
    //// type:2D_NOT_integer8
    //// type:2D_NOT_logical
    //// type:2D_NOT_real
    //// type:2D_NOT_type
    //// type:2D_PTR_complex
    //// type:2D_PTR_integer
    //// type:2D_PTR_integer8
    //// type:2D_PTR_logical
    //// type:2D_PTR_real
    //// type:2D_PTR_type
    //// type:3D_ALLOC_complex
    //// type:3D_ALLOC_integer
    //// type:3D_ALLOC_integer8
    //// type:3D_ALLOC_logical
    //// type:3D_ALLOC_real
    //// type:3D_ALLOC_type
    //// type:3D_NOT_complex
    //// type:3D_NOT_integer
    //// type:3D_NOT_integer8
    //// type:3D_NOT_logical
    //// type:3D_NOT_real
    //// type:3D_NOT_type
    //// type:3D_PTR_complex
    //// type:3D_PTR_integer
    //// type:3D_PTR_integer8
    //// type:3D_PTR_logical
    //// type:3D_PTR_real
    //// type:3D_PTR_type
    //// begin:class_initializer
    //// end:class_initializer

    //// section:class_initializer
    //// type:0D_ALLOC_character
    //// type:0D_ALLOC_complex
    //// type:0D_ALLOC_integer
    //// type:0D_ALLOC_integer8
    //// type:0D_ALLOC_logical
    //// type:0D_ALLOC_real
    //// type:0D_ALLOC_type
    //// type:0D_PTR_character
    //// type:0D_PTR_complex
    //// type:0D_PTR_integer
    //// type:0D_PTR_integer8
    //// type:0D_PTR_logical
    //// type:0D_PTR_real
    //// type:0D_PTR_type
    //// begin:class_initializer
    //// end:class_initializer

    //// section:class_initializer
    //// type:0D_NOT_character
    //// type:0D_NOT_complex
    //// type:0D_NOT_integer
    //// type:0D_NOT_integer8
    //// type:0D_NOT_logical
    //// type:0D_NOT_real
    //// type:0D_NOT_size
    //// type:1D_NOT_character
    //// type:1D_NOT_complex
    //// type:1D_NOT_integer
    //// type:1D_NOT_integer8
    //// type:1D_NOT_logical
    //// type:1D_NOT_real
    //// type:1D_NOT_size
    //// type:2D_NOT_size
    //// type:3D_NOT_size
    //// begin:class_initializer
    VALUE
    //// end:class_initializer

  */
}
void CONSTRUCT_VALUE(STRUCT_CPP_CLASS& C) {
  /*
    //// section:construct_value
    //// type:0D_ALLOC_character
    //// type:0D_ALLOC_type
    //// type:0D_NOT_type
    //// type:0D_PTR_character
    //// type:0D_PTR_type
    //// type:1D_ALLOC_character
    //// type:1D_ALLOC_type
    //// type:1D_NOT_type
    //// type:1D_PTR_character
    //// type:1D_PTR_type
    //// type:2D_ALLOC_type
    //// type:2D_NOT_type
    //// type:2D_PTR_type
    //// type:3D_ALLOC_type
    //// type:3D_NOT_type
    //// type:3D_PTR_type
    //// begin:construct_value
    //// end:construct_value

    //// section:construct_value
    //// type:0D_ALLOC_integer
    //// type:0D_ALLOC_integer8
    //// type:0D_NOT_character
    //// type:0D_NOT_integer
    //// type:0D_NOT_integer8
    //// type:0D_NOT_size
    //// type:0D_PTR_integer
    //// type:0D_PTR_integer8
    //// type:1D_ALLOC_integer
    //// type:1D_ALLOC_integer8
    //// type:1D_NOT_character
    //// type:1D_NOT_integer
    //// type:1D_NOT_integer8
    //// type:1D_NOT_size
    //// type:1D_PTR_integer
    //// type:1D_PTR_integer8
    //// type:2D_ALLOC_integer
    //// type:2D_ALLOC_integer8
    //// type:2D_NOT_integer
    //// type:2D_NOT_integer8
    //// type:2D_NOT_size
    //// type:2D_PTR_integer
    //// type:2D_PTR_integer8
    //// type:3D_ALLOC_integer
    //// type:3D_ALLOC_integer8
    //// type:3D_NOT_integer
    //// type:3D_NOT_integer8
    //// type:3D_NOT_size
    //// type:3D_PTR_integer
    //// type:3D_PTR_integer8
    //// begin:construct_value
    0
    //// end:construct_value

    //// section:construct_value
    //// type:0D_ALLOC_complex
    //// type:0D_ALLOC_real
    //// type:0D_NOT_complex
    //// type:0D_NOT_real
    //// type:0D_PTR_complex
    //// type:0D_PTR_real
    //// type:1D_ALLOC_complex
    //// type:1D_ALLOC_real
    //// type:1D_NOT_complex
    //// type:1D_NOT_real
    //// type:1D_PTR_complex
    //// type:1D_PTR_real
    //// type:2D_ALLOC_complex
    //// type:2D_ALLOC_real
    //// type:2D_NOT_complex
    //// type:2D_NOT_real
    //// type:2D_PTR_complex
    //// type:2D_PTR_real
    //// type:3D_ALLOC_complex
    //// type:3D_ALLOC_real
    //// type:3D_NOT_complex
    //// type:3D_NOT_real
    //// type:3D_PTR_complex
    //// type:3D_PTR_real
    //// begin:construct_value
    0.0
    //// end:construct_value

    //// section:construct_value
    //// type:0D_ALLOC_logical
    //// type:0D_NOT_logical
    //// type:0D_PTR_logical
    //// type:1D_ALLOC_logical
    //// type:1D_NOT_logical
    //// type:1D_PTR_logical
    //// type:2D_ALLOC_logical
    //// type:2D_NOT_logical
    //// type:2D_PTR_logical
    //// type:3D_ALLOC_logical
    //// type:3D_NOT_logical
    //// type:3D_PTR_logical
    //// begin:construct_value
    false
    //// end:construct_value

  */
}

void custom_constructors() {
  //// section:custom_constructors
  //// begin:ele_struct%ix_ele.construct_value
  -1;
  //// end:ele_struct%ix_ele.construct_value
  //// begin:ele_struct%slave_status.construct_value
  Bmad::FREE;
  //// end:ele_struct%slave_status.construct_value
  //// begin:ele_struct%ix2_slave.construct_value
  -1;
  //// end:ele_struct%ix2_slave.construct_value
  //// begin:ele_struct%lord_status.construct_value
  Bmad::NOT_A_LORD;
  //// end:ele_struct%lord_status.construct_value
  //// begin:ele_struct%ic2_lord.construct_value
  -1;
  //// end:ele_struct%ic2_lord.construct_value
  //// begin:ele_struct%mat6_calc_method.construct_value
  Bmad::BMAD_STANDARD;
  //// end:ele_struct%mat6_calc_method.construct_value
  //// begin:ele_struct%tracking_method.construct_value
  Bmad::BMAD_STANDARD;
  //// end:ele_struct%tracking_method.construct_value
  //// begin:ele_struct%spin_tracking_method.construct_value
  Bmad::BMAD_STANDARD;
  //// end:ele_struct%spin_tracking_method.construct_value
  //// begin:ele_struct%field_calc.construct_value
  Bmad::BMAD_STANDARD;
  //// end:ele_struct%field_calc.construct_value
  //// begin:ele_struct%ptc_integration_type.construct_value
  Bmad::MATRIX_KICK;
  //// end:ele_struct%ptc_integration_type.construct_value
  //// begin:ele_struct%aperture_at.construct_value
  Bmad::DOWNSTREAM_END;
  //// end:ele_struct%aperture_at.construct_value
  //// begin:ele_struct%aperture_type.construct_value
  Bmad::RECTANGULAR;
  //// end:ele_struct%aperture_type.construct_value
  //// begin:ele_struct%multipoles_on.construct_value
  true;
  //// end:ele_struct%multipoles_on.construct_value
  //// begin:ele_struct%scale_multipoles.construct_value
  true;
  //// end:ele_struct%scale_multipoles.construct_value
  //// begin:ele_struct%map_with_offsets.construct_value
  true;
  //// end:ele_struct%map_with_offsets.construct_value
  //// begin:ele_struct%is_on.construct_value
  true;
  //// end:ele_struct%is_on.construct_value
  //// begin:ele_struct%csr_calc_on.construct_value
  true;
  //// end:ele_struct%csr_calc_on.construct_value
  //// begin:ele_struct%orientation.construct_value
  1;
  //// end:ele_struct%orientation.construct_value
  //// begin:aperture_param_struct%max_angle.construct_value
  Bmad::PI;
  //// end:aperture_param_struct%max_angle.construct_value
  //// begin:bmad_common_struct%space_charge_mesh_size.construct_value
  32, 3;
  //// end:bmad_common_struct%space_charge_mesh_size.construct_value
}

void ele_struct_fixes() {
  //// section:ele_struct

  //// begin:ele_struct%.c_constructor_arg_list
  const int key_ = 0;
  //// end:ele_struct%.c_constructor_arg_list
  //// begin:ele_struct%.c_extra_methods
  void class_init(const int key_) {
    key = key_;

    if (key == Bmad::LCAVITY) {
      value[Bmad::COUPLER_AT] = Bmad::DOWNSTREAM_END;
      value[Bmad::FIELD_AUTOSCALE] = 1;
      value[Bmad::N_CELL] = 1;
    }

    if (key == Bmad::RFCAVITY) {
      value[Bmad::COUPLER_AT] = Bmad::DOWNSTREAM_END;
      value[Bmad::FIELD_AUTOSCALE] = 1;
      value[Bmad::N_CELL] = 1;
    }

    if (key == Bmad::RBEND || key == Bmad::SBEND) {
      value[Bmad::FRINGE_AT] = Bmad::BOTH_ENDS;
      value[Bmad::FRINGE_TYPE] = Bmad::BASIC_BEND;
      value[Bmad::PTC_FIELD_GEOMETRY] = Bmad::SECTOR;
    }
  }
  //// end:ele_struct%.c_extra_methods
  //// begin:ele_struct%.c_constructor_body
  // Special constructor for ele_struct
  class_init(key);
  // End special constructor for ele_struct

  //// end:ele_struct%.c_constructor_body

  // ** ele_struct%value customization **

  //// begin:ele_struct%value.to_c2_set
  // (custom - off-by-one ele attribs)
  C.NAME[0] = 0;
  for (unsigned int i = 1; i < Bmad::NUM_ELE_ATTRIB + 1; i++) {
    C.NAME[i] = z_NAME[i - 1];
  }
  //// end:ele_struct%value.to_c2_set

  //// begin:ele_struct%value.test_pat
  // (custom - off-by-one ele attribs)
  C.NAME[0] = 0;
  for (unsigned int i = 1; i < Bmad::NUM_ELE_ATTRIB + 1; i++) {
    int rhs = 100 + i + ARGIDX + offset;
    C.NAME[i] = rhs;
  }
  //// end:ele_struct%value.test_pat

  // ** ele_struct%old_value customization **

  //// begin:ele_struct%old_value.to_c2_set
  // (custom - off-by-one ele attribs)
  C.NAME[0] = 0;
  for (unsigned int i = 1; i < Bmad::NUM_ELE_ATTRIB + 1; i++) {
    C.NAME[i] = z_NAME[i - 1];
  }
  //// end:ele_struct%old_value.to_c2_set

  //// begin:ele_struct%old_value.test_pat
  // (custom - off-by-one ele attribs)
  C.NAME[0] = 0;
  for (unsigned int i = 1; i < Bmad::NUM_ELE_ATTRIB + 1; i++) {
    int rhs = 100 + i + ARGIDX + offset;
    C.NAME[i] = rhs;
  }
  //// end:ele_struct%old_value.test_pat

  //// begin:ele_struct%lord.c_class
  std::optional<CPP_ele_reference>;
  //// end:ele_struct%lord.c_class

  //// begin:ele_struct%lord.to_f2_arg
  const CPP_ele_reference*;
  //// end:ele_struct%lord.to_f2_arg

  //// begin:ele_struct%lord.to_f2_call
  (C.lord.has_value() ? &C.lord.value() : nullptr);
  //// end:ele_struct%lord.to_f2_call

  //// begin:ele_struct%lord.to_c2_set
  // NOTE: The parameter z_n_lord is set before n_lord
  if (n_lord == 0) {
    C.lord.reset();
  } else {
    C.lord.emplace();
    ele_reference_to_c(
        // TODO
        (const Opaque_ele_reference_class*)z_lord,
        C.lord.value());
  }
  //// end:ele_struct%lord.to_c2_set

  //// begin:ele_struct%lord.test_pat
  if (ix_patt < 3) {
    C.NAME.reset();
  } else {
    C.NAME.emplace();
    C.NAME->ix_branch = 0;
    C.NAME->ix_ele = 0;
  }
  //// end:ele_struct%lord.test_pat

  //// begin:ele_struct%n_lord.test_pat
  if (ix_patt < 3) {
    C.NAME = 0;
  } else {
    C.NAME = 1;
  }
  //// end:ele_struct%n_lord.test_pat
}

void lat_struct_fixes() {
  //// section:lat_struct_fixes
  //// begin:lat_struct%use_name.test_pat
  C.use_name = "TEST-LATTICE-FROM-TEST-SUITE";
  // magic string to opt-out of lattice finalization
  //// end:lat_struct%use_name.test_pat
}
// void branch_struct_fixes() {
//   //// section:branch_struct_fixes
//   //// begin:ele_struct%lord.test_pat
//   if (ix_patt < 3) {
//     C.NAME.reset();
//   } else {
//     C.NAME.emplace();
//     C.NAME->ix_branch = 0;
//     C.NAME->ix_ele = 0;
//   }
//   //// end:ele_struct%lord.test_pat
// }
