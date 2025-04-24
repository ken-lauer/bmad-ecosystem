
// vi: syntax=cpp
//
#include <cstddef>
#include "include/bmad_std_typedef.h"

class OpaqueClass {};
class CppClass {
public:
  void **NAME;
};

//// section:to_f
//// type:0D_NOT_character
void to_f__variant_a (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Char
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME.c_str()
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_NOT_complex
void to_f__variant_b (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Complex&
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_NOT_integer
void to_f__variant_c (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int&
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_NOT_integer8
void to_f__variant_d (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int8&
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_NOT_logical
void to_f__variant_e (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Bool&
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_NOT_real
void to_f__variant_f (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Real&
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_NOT_size
//// type:1D_NOT_size
//// type:2D_NOT_size
//// type:3D_NOT_size
void to_f__variant_g (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  Int
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_NOT_type
void to_f__variant_h (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  const CPP_KIND&
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_ALLOC_character
//// type:0D_PTR_character
void to_f__variant_i (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n_NAME = 0;
  const char* z_NAME = nullptr;
  if (C.NAME != NULL) {
    z_NAME = C.NAME->c_str();
    n_NAME = 1;
  }
  //// end:to_f_setup

  to_f2(F, /*
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
//// type:0D_PTR_complex
void to_f__variant_j (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n_NAME = 0; if (C.NAME != nullptr) n_NAME = 1;
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_ComplexArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME.get()
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_ALLOC_integer
//// type:0D_PTR_integer
void to_f__variant_k (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n_NAME = 0; if (C.NAME != nullptr) n_NAME = 1;
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_IntArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME.get()
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_ALLOC_integer8
//// type:0D_PTR_integer8
void to_f__variant_l (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n_NAME = 0; if (C.NAME != nullptr) n_NAME = 1;
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int8Arr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME.get()
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_ALLOC_logical
//// type:0D_PTR_logical
void to_f__variant_m (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n_NAME = 0; if (C.NAME != nullptr) n_NAME = 1;
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_BoolArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME.get()
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_ALLOC_real
//// type:0D_PTR_real
void to_f__variant_n (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n_NAME = 0; if (C.NAME != nullptr) n_NAME = 1;
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_RealArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  C.NAME.get()
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:0D_ALLOC_type
//// type:0D_PTR_type
void to_f__variant_o (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  size_t n_NAME = 0; if (C.NAME != nullptr) n_NAME = 1;
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  const CPP_KIND&
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  *C.NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_NOT_character
void to_f__variant_p (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  c_Char z_NAME[DIM1];
  for (auto i{0}; i < DIM1; i++) {z_NAME[i] = C.NAME[i].c_str();}
  //// end:to_f_setup

  to_f2(F, /*
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
//// type:1D_NOT_complex
void to_f__variant_q (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_ComplexArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  &C.NAME[0]
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_NOT_integer
void to_f__variant_r (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_IntArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  &C.NAME[0]
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_NOT_integer8
void to_f__variant_s (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int8Arr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  &C.NAME[0]
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_NOT_logical
void to_f__variant_t (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_BoolArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  &C.NAME[0]
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_NOT_real
void to_f__variant_u (const CppClass& C, OpaqueClass* F) {

  to_f2(F, /*
  //// begin:to_f2_arg
  c_RealArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  &C.NAME[0]
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_NOT_type
void to_f__variant_v (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  const CPP_KIND* z_NAME[DIM1];
  for (int i = 0; i < DIM1; i++) {z_NAME[i] = &C.NAME[i];}
  //// end:to_f_setup

  to_f2(F, /*
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
void to_f__variant_w (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME{ C.NAME.size() };
  c_Char* z_NAME = nullptr;
  if (n1_NAME != 0) {
    z_NAME = new c_Char[n1_NAME];
    for (auto i{0}; i < n1_NAME; i++) z_NAME[i] = C.NAME[i].c_str();
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Char*
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:1D_ALLOC_complex
//// type:1D_PTR_complex
void to_f__variant_x (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME = C.NAME.size();
  c_ComplexArr z_NAME = nullptr;
  if (n1_NAME > 0) {
    z_NAME = &C.NAME[0];
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_ComplexArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_ALLOC_integer
//// type:1D_PTR_integer
void to_f__variant_y (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME = C.NAME.size();
  c_IntArr z_NAME = nullptr;
  if (n1_NAME > 0) {
    z_NAME = &C.NAME[0];
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_IntArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_ALLOC_integer8
//// type:1D_PTR_integer8
void to_f__variant_z (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME = C.NAME.size();
  c_Int8Arr z_NAME = nullptr;
  if (n1_NAME > 0) {
    z_NAME = &C.NAME[0];
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int8Arr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_ALLOC_logical
//// type:1D_PTR_logical
void to_f__variant_A (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME = C.NAME.size();
  c_BoolArr z_NAME = nullptr;
  if (n1_NAME > 0) {
    z_NAME = &C.NAME[0];
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_BoolArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:1D_ALLOC_real
//// type:1D_PTR_real
void to_f__variant_B (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME = C.NAME.size();
  c_RealArr z_NAME = nullptr;
  if (n1_NAME > 0) {
    z_NAME = &C.NAME[0];
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_RealArr
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
void to_f__variant_C (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME = C.NAME.size();
  const CPP_KIND** z_NAME = nullptr;
  if (n1_NAME != 0) {
    z_NAME = new const CPP_KIND*[n1_NAME];
    for (auto i{0}; i < n1_NAME; i++) z_NAME[i] = &C.NAME[i];
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:2D_NOT_complex
void to_f__variant_D (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Complex z_NAME[DIM1*DIM2]; matrix_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_ComplexArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:2D_NOT_integer
void to_f__variant_E (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Int z_NAME[DIM1*DIM2]; matrix_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_IntArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:2D_NOT_integer8
void to_f__variant_F (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Int8 z_NAME[DIM1*DIM2]; matrix_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int8Arr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:2D_NOT_logical
void to_f__variant_G (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Bool z_NAME[DIM1*DIM2]; matrix_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_BoolArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:2D_NOT_real
void to_f__variant_H (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Real z_NAME[DIM1*DIM2]; matrix_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_RealArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:2D_NOT_type
void to_f__variant_I (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  const CPP_KIND* z_NAME[DIM1*DIM2];
  for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)
    {auto m = DIM2*i + j; z_NAME[m] = C.NAME[i][j].get();}
  //// end:to_f_setup

  to_f2(F, /*
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
//// type:2D_PTR_complex
void to_f__variant_J (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  Complex* z_NAME = nullptr;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new Complex [n1_NAME*n2_NAME];
    matrix_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_ComplexArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:2D_ALLOC_integer
//// type:2D_PTR_integer
void to_f__variant_K (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  Int* z_NAME = nullptr;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new Int [n1_NAME*n2_NAME];
    matrix_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_IntArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:2D_ALLOC_integer8
//// type:2D_PTR_integer8
void to_f__variant_L (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  Int8* z_NAME = nullptr;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new Int8 [n1_NAME*n2_NAME];
    matrix_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int8Arr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:2D_ALLOC_logical
//// type:2D_PTR_logical
void to_f__variant_M (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  Bool* z_NAME = nullptr;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new Bool [n1_NAME*n2_NAME];
    matrix_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_BoolArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:2D_ALLOC_real
//// type:2D_PTR_real
void to_f__variant_N (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  Real* z_NAME = nullptr;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new Real [n1_NAME*n2_NAME];
    matrix_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_RealArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:2D_ALLOC_type
//// type:2D_PTR_type
void to_f__variant_O (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  const CPP_KIND** z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new const CPP_KIND* [n1_NAME*n2_NAME];
    for (auto i{0}; i < n1_NAME; i++) {
      for (auto j{0}; j < n2_NAME; j++) {
        z_NAME[i*n2_NAME + j] = &C.NAME[i][j];
      }
    }
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:3D_NOT_complex
void to_f__variant_P (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Complex z_NAME[DIM1*DIM2*DIM3]; tensor_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_ComplexArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:3D_NOT_integer
void to_f__variant_Q (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Int z_NAME[DIM1*DIM2*DIM3]; tensor_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_IntArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:3D_NOT_integer8
void to_f__variant_R (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Int8 z_NAME[DIM1*DIM2*DIM3]; tensor_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int8Arr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:3D_NOT_logical
void to_f__variant_S (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Bool z_NAME[DIM1*DIM2*DIM3]; tensor_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_BoolArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:3D_NOT_real
void to_f__variant_T (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  Real z_NAME[DIM1*DIM2*DIM3]; tensor_to_vec(C.NAME, z_NAME);
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_RealArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

}

//// section:to_f
//// type:3D_NOT_type
void to_f__variant_U (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  const CPP_KIND* z_NAME[DIM1*DIM2*DIM3];
  for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)   for (size_t k = 0; k < C.NAME[0][0].size(); k++)
    {auto m = DIM3*DIM2*i + DIM3*j + k; z_NAME[m] = C.NAME[i][j][k].get();}
  //// end:to_f_setup

  to_f2(F, /*
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
//// type:3D_ALLOC_complex
//// type:3D_PTR_complex
void to_f__variant_V (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  auto n3_NAME { std::size_t{0} };
  Complex* z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new Complex [C.NAME.size()*C.NAME[0].size()*C.NAME[0][0].size()];
    tensor_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_ComplexArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:3D_ALLOC_integer
//// type:3D_PTR_integer
void to_f__variant_W (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  auto n3_NAME { std::size_t{0} };
  Int* z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new Int [C.NAME.size()*C.NAME[0].size()*C.NAME[0][0].size()];
    tensor_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_IntArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:3D_ALLOC_integer8
//// type:3D_PTR_integer8
void to_f__variant_X (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  auto n3_NAME { std::size_t{0} };
  Int8* z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new Int8 [C.NAME.size()*C.NAME[0].size()*C.NAME[0][0].size()];
    tensor_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_Int8Arr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:3D_ALLOC_logical
//// type:3D_PTR_logical
void to_f__variant_Y (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  auto n3_NAME { std::size_t{0} };
  Bool* z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new Bool [C.NAME.size()*C.NAME[0].size()*C.NAME[0][0].size()];
    tensor_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_BoolArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:3D_ALLOC_real
//// type:3D_PTR_real
void to_f__variant_Z (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  auto n3_NAME { std::size_t{0} };
  Real* z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new Real [C.NAME.size()*C.NAME[0].size()*C.NAME[0][0].size()];
    tensor_to_vec (C.NAME, z_NAME);
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  c_RealArr
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_f
//// type:3D_ALLOC_type
//// type:3D_PTR_type
void to_f__variant_a (const CppClass& C, OpaqueClass* F) {
  //// begin:to_f_setup
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  auto n3_NAME { std::size_t{0} };
  const CPP_KIND** z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new const CPP_KIND* [n1_NAME*n2_NAME*n3_NAME];
    for (auto i{0}; i < n1_NAME; i++) {
      for (auto j{0}; j < n2_NAME; j++) {
        for (auto k{0}; k < n3_NAME; k++) {
          z_NAME[i*n2_NAME*n3_NAME + j*n3_NAME + k] = &C.NAME[i][j][k];
        }
      }
    }
  }
  //// end:to_f_setup

  to_f2(F, /*
  //// begin:to_f2_arg
  const CPP_KIND**
  //// end:to_f2_arg
  */
  //// begin:to_f2_call
  z_NAME
  //// end:to_f2_call
  );

  //// begin:to_f_cleanup
  if (z_NAME) delete[] z_NAME;
  //// end:to_f_cleanup
}

//// section:to_c2
//// type:0D_NOT_character
void to_c2__variant_a (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Char z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME = z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_complex
void to_c2__variant_b (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Complex& z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME = z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_integer
void to_c2__variant_c (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Int& z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME = z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_integer8
void to_c2__variant_d (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Int8& z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME = z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_logical
void to_c2__variant_e (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Bool& z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME = z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_real
void to_c2__variant_f (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Real& z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME = z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_size
//// type:1D_NOT_size
//// type:2D_NOT_size
//// type:3D_NOT_size
void to_c2__variant_g (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  Int NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME = z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_NOT_type
void to_c2__variant_h (STRUCT_CPP_CLASS& C,
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
void to_c2__variant_i (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Char z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME = nullptr;
  }
  else {
    C.NAME = make_shared<string>(z_NAME);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_complex
//// type:0D_PTR_complex
void to_c2__variant_j (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_ComplexArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME = nullptr;
  } else {
    C.NAME = make_shared<Complex>();
    *C.NAME = *z_NAME;
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_integer
//// type:0D_PTR_integer
void to_c2__variant_k (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_IntArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME = nullptr;
  } else {
    C.NAME = make_shared<Int>();
    *C.NAME = *z_NAME;
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_integer8
//// type:0D_PTR_integer8
void to_c2__variant_l (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Int8Arr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME = nullptr;
  } else {
    C.NAME = make_shared<Int8>();
    *C.NAME = *z_NAME;
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_logical
//// type:0D_PTR_logical
void to_c2__variant_m (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_BoolArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME = nullptr;
  } else {
    C.NAME = make_shared<Bool>();
    *C.NAME = *z_NAME;
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_real
//// type:0D_PTR_real
void to_c2__variant_n (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_RealArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME = nullptr;
  } else {
    C.NAME = make_shared<Real>();
    *C.NAME = *z_NAME;
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:0D_ALLOC_type
//// type:0D_PTR_type
void to_c2__variant_o (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  Opaque_KIND_class* z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  if (n_NAME == 0) {
    C.NAME = nullptr;
  } else {
    C.NAME = make_shared<CPP_KIND>();
    KIND_to_c(z_NAME, *C.NAME);
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_character
void to_c2__variant_p (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Char* z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  for (size_t i = 0; i < C.NAME.size(); i++) C.NAME[i] = z_NAME[i];
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_complex
//// type:2D_NOT_complex
//// type:3D_NOT_complex
void to_c2__variant_q (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_ComplexArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_integer
//// type:2D_NOT_integer
//// type:3D_NOT_integer
void to_c2__variant_r (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_IntArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_integer8
//// type:2D_NOT_integer8
//// type:3D_NOT_integer8
void to_c2__variant_s (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Int8Arr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_logical
//// type:2D_NOT_logical
//// type:3D_NOT_logical
void to_c2__variant_t (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_BoolArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_real
//// type:2D_NOT_real
//// type:3D_NOT_real
void to_c2__variant_u (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_RealArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_NOT_type
void to_c2__variant_v (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  const Opaque_KIND_class** z_NAME
  //// end:to_c2_arg
) {
//// begin:to_c2_set
for (size_t i = 0; i < C.NAME.size(); i++)
{ KIND_to_c(z_NAME[i], C.NAME[i]); }
//// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_character
//// type:1D_PTR_character
void to_c2__variant_w (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Char* z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) C.NAME[i] = z_NAME[i];
  //// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_complex
//// type:1D_PTR_complex
void to_c2__variant_x (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_ComplexArr z_NAME
  //// end:to_c2_arg
) {
//// begin:to_c2_set

  C.NAME.resize(n1_NAME);
  C.NAME << z_NAME;
//// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_integer
//// type:1D_PTR_integer
void to_c2__variant_y (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_IntArr z_NAME
  //// end:to_c2_arg
) {
//// begin:to_c2_set

  C.NAME.resize(n1_NAME);
  C.NAME << z_NAME;
//// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_integer8
//// type:1D_PTR_integer8
void to_c2__variant_z (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Int8Arr z_NAME
  //// end:to_c2_arg
) {
//// begin:to_c2_set

  C.NAME.resize(n1_NAME);
  C.NAME << z_NAME;
//// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_logical
//// type:1D_PTR_logical
void to_c2__variant_A (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_BoolArr z_NAME
  //// end:to_c2_arg
) {
//// begin:to_c2_set

  C.NAME.resize(n1_NAME);
  C.NAME << z_NAME;
//// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_real
//// type:1D_PTR_real
void to_c2__variant_B (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_RealArr z_NAME
  //// end:to_c2_arg
) {
//// begin:to_c2_set

  C.NAME.resize(n1_NAME);
  C.NAME << z_NAME;
//// end:to_c2_set
}

//// section:to_c2
//// type:1D_ALLOC_type
//// type:1D_PTR_type
void to_c2__variant_C (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  Opaque_KIND_class** z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) { KIND_to_c(z_NAME[i], C.NAME[i]); }
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_NOT_type
void to_c2__variant_D (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  const Opaque_KIND_class** z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)
    {auto m = DIM2*i + j; KIND_to_c(z_NAME[m], *C.NAME[i][j].get());}
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_ALLOC_complex
//// type:2D_PTR_complex
void to_c2__variant_E (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_ComplexArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) C.NAME[i].resize(n2_NAME);
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_ALLOC_integer
//// type:2D_PTR_integer
void to_c2__variant_F (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_IntArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) C.NAME[i].resize(n2_NAME);
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_ALLOC_integer8
//// type:2D_PTR_integer8
void to_c2__variant_G (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Int8Arr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) C.NAME[i].resize(n2_NAME);
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_ALLOC_logical
//// type:2D_PTR_logical
void to_c2__variant_H (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_BoolArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) C.NAME[i].resize(n2_NAME);
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_ALLOC_real
//// type:2D_PTR_real
void to_c2__variant_I (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_RealArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) C.NAME[i].resize(n2_NAME);
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:2D_ALLOC_type
//// type:2D_PTR_type
void to_c2__variant_J (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  Opaque_KIND_class** z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) {
    C.NAME[i].resize(n2_NAME);
    for (auto j{0}; j < n2_NAME; j++) {
        auto &item = C.NAME[i][j];
        KIND_to_c(z_NAME[n2_NAME*i+j], item);
    }
  }
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_NOT_type
void to_c2__variant_K (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  const Opaque_KIND_class** z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)   for (size_t k = 0; k < C.NAME[0][0].size(); k++)
    {auto m = DIM3*DIM2*i + DIM3*j + k; KIND_to_c(z_NAME[m], *C.NAME[i][j][k].get());}
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_ALLOC_complex
//// type:3D_PTR_complex
void to_c2__variant_L (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_ComplexArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i = 0; i < C.NAME.size(); i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j = 0; j < C.NAME[0].size(); j++)
      C.NAME[i][j].resize(n3_NAME);
  }
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_ALLOC_integer
//// type:3D_PTR_integer
void to_c2__variant_M (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_IntArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i = 0; i < C.NAME.size(); i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j = 0; j < C.NAME[0].size(); j++)
      C.NAME[i][j].resize(n3_NAME);
  }
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_ALLOC_integer8
//// type:3D_PTR_integer8
void to_c2__variant_N (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_Int8Arr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i = 0; i < C.NAME.size(); i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j = 0; j < C.NAME[0].size(); j++)
      C.NAME[i][j].resize(n3_NAME);
  }
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_ALLOC_logical
//// type:3D_PTR_logical
void to_c2__variant_O (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_BoolArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i = 0; i < C.NAME.size(); i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j = 0; j < C.NAME[0].size(); j++)
      C.NAME[i][j].resize(n3_NAME);
  }
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_ALLOC_real
//// type:3D_PTR_real
void to_c2__variant_P (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  c_RealArr z_NAME
  //// end:to_c2_arg
) {
  //// begin:to_c2_set
  C.NAME.resize(n1_NAME);
  for (size_t i = 0; i < C.NAME.size(); i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j = 0; j < C.NAME[0].size(); j++)
      C.NAME[i][j].resize(n3_NAME);
  }
  C.NAME << z_NAME;
  //// end:to_c2_set
}

//// section:to_c2
//// type:3D_ALLOC_type
//// type:3D_PTR_type
void to_c2__variant_Q (STRUCT_CPP_CLASS& C,
  //// begin:to_c2_arg
  Opaque_KIND_class** z_NAME
  //// end:to_c2_arg
) {
//// begin:to_c2_set

  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) {
    C.NAME[i].resize(n2_NAME);
    for (auto j{0}; j < n2_NAME; j++) {
      C.NAME[i][j].resize(n3_NAME);
      for (auto k{0}; k < n3_NAME; k++) {
        // C.NAME[i][j][k] = make_shared<CPP_KIND>();
        KIND_to_c(z_NAME[n3_NAME*n2_NAME*i+n3_NAME*j+k], C.NAME[i][j][k]);
    } } }
//// end:to_c2_set
}

void EQUALITY_TEST (STRUCT_CPP_CLASS& C) {
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
  is_eq = is_eq && ((x.NAME == NULL) == (y.NAME == NULL));
  if (!is_eq) return false;
  if (x.NAME != NULL) is_eq = (*x.NAME == *y.NAME);
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
void TEST_PAT (STRUCT_CPP_CLASS& C) {
/*
  //// section:test_pat
  //// type:0D_NOT_character
  //// begin:test_value
  rhs
  //// end:test_value
  //// begin:test_pat
  C.NAME.resize(STR_LEN);
  for (size_t i = 0; i < C.NAME.size(); i++)
    {int rhs = 101 + i + ARGIDX + offset; C.NAME[i] = TEST_VALUE;}
  //// end:test_pat

  //// section:test_pat
  //// type:1D_NOT_complex
  //// type:1D_NOT_integer
  //// type:1D_NOT_integer8
  //// type:1D_NOT_logical
  //// type:1D_NOT_real
  //// case:1D_NOT_complex:test_value
  Complex(rhs, 100+rhs)
  //// case:1D_NOT_integer:test_value
  rhs
  //// case:1D_NOT_integer8:test_value
  rhs
  //// case:1D_NOT_logical:test_value
  (rhs % 2 == 0)
  //// case:1D_NOT_real:test_value
  rhs
  //// begin:test_pat
  for (size_t i = 0; i < C.NAME.size(); i++)
    {int rhs = 101 + i + ARGIDX + offset; C.NAME[i] = TEST_VALUE;}
  //// end:test_pat

  //// section:test_pat
  //// type:1D_NOT_type
  //// begin:test_value
  
  //// end:test_value
  //// begin:test_pat
  for (size_t i = 0; i < C.NAME.size(); i++)
    {int rhs = 101 + i + ARGIDX + offset; set_CPP_KIND_test_pattern(C.NAME[i], ix_patt+i+1);}
  //// end:test_pat

  //// section:test_pat
  //// type:2D_NOT_complex
  //// type:2D_NOT_integer
  //// type:2D_NOT_integer8
  //// type:2D_NOT_logical
  //// type:2D_NOT_real
  //// case:2D_NOT_complex:test_value
  Complex(rhs, 100+rhs)
  //// case:2D_NOT_integer:test_value
  rhs
  //// case:2D_NOT_integer8:test_value
  rhs
  //// case:2D_NOT_logical:test_value
  (rhs % 2 == 0)
  //// case:2D_NOT_real:test_value
  rhs
  //// begin:test_pat
  for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)
    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.NAME[i][j] = TEST_VALUE;}
  //// end:test_pat

  //// section:test_pat
  //// type:2D_NOT_type
  //// begin:test_value
  
  //// end:test_value
  //// begin:test_pat
  for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)
    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; set_CPP_KIND_test_pattern(*C.NAME[i][j], ix_patt+i+1+10*(j+1));}
  //// end:test_pat

  //// section:test_pat
  //// type:3D_NOT_complex
  //// type:3D_NOT_integer
  //// type:3D_NOT_integer8
  //// type:3D_NOT_logical
  //// type:3D_NOT_real
  //// case:3D_NOT_complex:test_value
  Complex(rhs, 100+rhs)
  //// case:3D_NOT_integer:test_value
  rhs
  //// case:3D_NOT_integer8:test_value
  rhs
  //// case:3D_NOT_logical:test_value
  (rhs % 2 == 0)
  //// case:3D_NOT_real:test_value
  rhs
  //// begin:test_pat
  for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)   for (size_t k = 0; k < C.NAME[0][0].size(); k++)
    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; C.NAME[i][j][k] = TEST_VALUE;}
  //// end:test_pat

  //// section:test_pat
  //// type:3D_NOT_type
  //// begin:test_value
  
  //// end:test_value
  //// begin:test_pat
  for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)   for (size_t k = 0; k < C.NAME[0][0].size(); k++)
    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; set_CPP_KIND_test_pattern(*C.NAME[i][j][k], ix_patt+i+1+10*(j+1)+100*(k+1));}
  //// end:test_pat

  //// section:test_pat
  //// type:1D_NOT_character
  //// begin:test_value
  rhs
  //// end:test_value
  //// begin:test_pat
  for (size_t i = 0; i < C.NAME.size(); i++) {
    C.NAME[i].resize(STR_LEN);
    for (size_t j = 0; j < C.NAME[i].size(); j++)
      {C.NAME[i][j] = 'a' + (101 + i + 10*(j+1) + ARGIDX + offset) % 26;}
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_logical
  //// type:0D_PTR_logical
  //// begin:test_value
  (rhs % 2 == 0)
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME = nullptr;
  else {
    C.NAME = make_shared<Bool>();
    rhs = ARGIDX + offset; (*C.NAME) = TEST_VALUE;
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_type
  //// type:0D_PTR_type
  //// begin:test_value
  
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME = nullptr;
  else {
    C.NAME = make_shared<CPP_KIND>();
    set_CPP_KIND_test_pattern((*C.NAME), ix_patt);
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_complex
  //// type:0D_PTR_complex
  //// begin:test_value
  Complex(rhs, 100+rhs)
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME = nullptr;
  else {
    C.NAME = make_shared<Complex>();
    rhs = ARGIDX + offset; (*C.NAME) = TEST_VALUE;
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_integer8
  //// type:0D_PTR_integer8
  //// begin:test_value
  rhs
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME = nullptr;
  else {
    C.NAME = make_shared<Int8>();
    rhs = ARGIDX + offset; (*C.NAME) = TEST_VALUE;
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_integer
  //// type:0D_PTR_integer
  //// begin:test_value
  rhs
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME = nullptr;
  else {
    C.NAME = make_shared<Int>();
    rhs = ARGIDX + offset; (*C.NAME) = TEST_VALUE;
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_real
  //// type:0D_PTR_real
  //// begin:test_value
  rhs
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME = nullptr;
  else {
    C.NAME = make_shared<Real>();
    rhs = ARGIDX + offset; (*C.NAME) = TEST_VALUE;
  }
  //// end:test_pat

  //// section:test_pat
  //// type:0D_ALLOC_character
  //// type:0D_PTR_character
  //// begin:test_value
  
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME = nullptr;
  else {
    C.NAME = make_shared<string>(STR_LEN, ' ');
    for (size_t i = 0; i < C.NAME->size(); i++) {
      (*C.NAME)[i] = 'a' + (101 + i + ARGIDX + offset) % 26; }
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
  Complex(rhs, 100+rhs)
  //// case:2D_ALLOC_integer:test_value
  rhs
  //// case:2D_ALLOC_integer8:test_value
  rhs
  //// case:2D_ALLOC_logical:test_value
  (rhs % 2 == 0)
  //// case:2D_ALLOC_real:test_value
  rhs
  //// case:2D_PTR_complex:test_value
  Complex(rhs, 100+rhs)
  //// case:2D_PTR_integer:test_value
  rhs
  //// case:2D_PTR_integer8:test_value
  rhs
  //// case:2D_PTR_logical:test_value
  (rhs % 2 == 0)
  //// case:2D_PTR_real:test_value
  rhs
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++)
      C.NAME[i].resize(2);
    for (size_t i = 0; i < C.NAME.size(); i++)  for (size_t j = 0; j < C.NAME[0].size(); j++)
      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.NAME[i][j] = TEST_VALUE;}  }
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
  Complex(rhs, 100+rhs)
  //// case:1D_ALLOC_integer:test_value
  rhs
  //// case:1D_ALLOC_integer8:test_value
  rhs
  //// case:1D_ALLOC_logical:test_value
  (rhs % 2 == 0)
  //// case:1D_ALLOC_real:test_value
  rhs
  //// case:1D_PTR_complex:test_value
  Complex(rhs, 100+rhs)
  //// case:1D_PTR_integer:test_value
  rhs
  //// case:1D_PTR_integer8:test_value
  rhs
  //// case:1D_PTR_logical:test_value
  (rhs % 2 == 0)
  //// case:1D_PTR_real:test_value
  rhs
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++)
      {int rhs = 101 + i + ARGIDX + offset; C.NAME[i] = TEST_VALUE;}  }
  //// end:test_pat

  //// section:test_pat
  //// type:1D_ALLOC_type
  //// type:1D_PTR_type
  //// begin:test_value
  
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++)  {set_CPP_KIND_test_pattern(C.NAME[i], ix_patt+i+1);}
  }
  //// end:test_pat

  //// section:test_pat
  //// type:2D_ALLOC_type
  //// type:2D_PTR_type
  //// begin:test_value
  
  //// end:test_value
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);

      for (size_t j = 0; j < C.NAME[0].size(); j++) {
        auto &item = C.NAME[i][j];
        set_CPP_KIND_test_pattern(item, ix_patt+i+2*j+3);
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
  if (ix_patt < 3)
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);
      for (size_t j = 0; j < C.NAME[0].size(); j++) {
        C.NAME[i][j].resize(1);
        for (size_t k = 0; k < C.NAME[0][0].size(); k++) {
          // C.NAME[i][j][k] = make_shared<CPP_KIND>();
          set_CPP_KIND_test_pattern(C.NAME[i][j][k], ix_patt+i+2*j+3*k+6);
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
  Complex(rhs, 100+rhs)
  //// case:3D_ALLOC_integer:test_value
  rhs
  //// case:3D_ALLOC_integer8:test_value
  rhs
  //// case:3D_ALLOC_logical:test_value
  (rhs % 2 == 0)
  //// case:3D_ALLOC_real:test_value
  rhs
  //// case:3D_PTR_complex:test_value
  Complex(rhs, 100+rhs)
  //// case:3D_PTR_integer:test_value
  rhs
  //// case:3D_PTR_integer8:test_value
  rhs
  //// case:3D_PTR_logical:test_value
  (rhs % 2 == 0)
  //// case:3D_PTR_real:test_value
  rhs
  //// begin:test_pat
  if (ix_patt < 3)
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);
      for (size_t j = 0; j < C.NAME[0].size(); j++) {
        C.NAME[i][j].resize(1);
        for (size_t k = 0; k < C.NAME[0][0].size(); k++) {
          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;
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
  if (ix_patt < 3)
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++){
      C.NAME[i].resize(STR_LEN);
      for (size_t j = 0; j < C.NAME[0].size(); j++) {
        C.NAME[i][j] = 'a' + (101 + i + 10*(j+1) + ARGIDX + offset) % 26;
    } }
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
  Complex(rhs, 100+rhs)
  //// case:0D_NOT_integer:test_value
  rhs
  //// case:0D_NOT_integer8:test_value
  rhs
  //// case:0D_NOT_logical:test_value
  (rhs % 2 == 0)
  //// case:0D_NOT_real:test_value
  rhs
  //// case:0D_NOT_size:test_value
  rhs
  //// case:1D_NOT_size:test_value
  rhs
  //// case:2D_NOT_size:test_value
  rhs
  //// case:3D_NOT_size:test_value
  rhs
  //// begin:test_pat
  rhs = ARGIDX + offset; C.NAME = TEST_VALUE;
  //// end:test_pat

  //// section:test_pat
  //// type:0D_NOT_type
  //// begin:test_value
  
  //// end:test_value
  //// begin:test_pat
  set_CPP_KIND_test_pattern(C.NAME, ix_patt);
  //// end:test_pat

*/
}
void C_CLASS (STRUCT_CPP_CLASS& C) {
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
  SharedVector2D<CPP_KIND>
  //// end:c_class

  //// section:c_class
  //// type:3D_NOT_type
  //// begin:c_class
  SharedVector3D<CPP_KIND>
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
  shared_ptr<Bool>
  //// end:c_class

  //// section:c_class
  //// type:0D_ALLOC_type
  //// type:0D_PTR_type
  //// begin:c_class
  shared_ptr<CPP_KIND>
  //// end:c_class

  //// section:c_class
  //// type:0D_ALLOC_complex
  //// type:0D_PTR_complex
  //// begin:c_class
  shared_ptr<Complex>
  //// end:c_class

  //// section:c_class
  //// type:0D_ALLOC_integer8
  //// type:0D_PTR_integer8
  //// begin:c_class
  shared_ptr<Int8>
  //// end:c_class

  //// section:c_class
  //// type:0D_ALLOC_integer
  //// type:0D_PTR_integer
  //// begin:c_class
  shared_ptr<Int>
  //// end:c_class

  //// section:c_class
  //// type:0D_ALLOC_real
  //// type:0D_PTR_real
  //// begin:c_class
  shared_ptr<Real>
  //// end:c_class

  //// section:c_class
  //// type:0D_ALLOC_character
  //// type:0D_PTR_character
  //// begin:c_class
  shared_ptr<string>
  //// end:c_class

  //// section:c_class
  //// type:0D_NOT_character
  //// begin:c_class
  string
  //// end:c_class

*/
}
void CLASS_INITIALIZER (STRUCT_CPP_CLASS& C) {
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
  nullptr
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
  { VALUE }
  //// end:class_initializer

*/
}
void CONSTRUCT_VALUE (STRUCT_CPP_CLASS& C) {
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
