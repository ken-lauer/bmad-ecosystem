#ifndef CONVERTER_TEMPLATES

#include "bmad_std_typedef.h"
#include <complex>
#include <string>
#include <vector>

//---------------------------------------------------------------------------

using std::vector;

template <typename T, std::size_t DIM1>
void operator<<(Bmad::FixedArray1D<T, DIM1> &arr, const T *ptr) {
  for (auto i = 0; i < DIM1; i++) {
    arr[i] = ptr[i];
  }
}

template <class T, std::size_t DIM1, std::size_t DIM2>
void operator<<(Bmad::FixedArray2D<T, DIM1, DIM2> &arr, const T *ptr) {
  for (auto i = 0; i < DIM1; i++) {
    for (auto j = 0; j < DIM2; j++) {
      arr[i][j] = ptr[i * DIM2 + j];
    }
  }
}
template <class T, std::size_t DIM1, std::size_t DIM2, std::size_t DIM3>
void operator<<(Bmad::FixedArray3D<T, DIM1, DIM2, DIM3> &arr, const T *ptr) {
  for (auto i = 0; i < DIM1; i++) {
    for (auto j = 0; j < DIM2; j++) {
      for (auto k = 0; k < DIM3; k++) {
        arr[i][j][k] = ptr[i * DIM2 * DIM3 + j * DIM2 + k];
      }
    }
  }
}

template <typename T>
void operator<<(Bmad::VariableArray1D<T> &arr, const T *ptr) {
  auto DIM1 = arr.size();
  for (auto i = 0; i < DIM1; i++) {
    arr[i] = ptr[i];
  }
}

template <class T>
void operator<<(Bmad::VariableArray2D<T> &mat, const T *ptr) {
  auto DIM1 = mat.size();
  if (DIM1 > 0) {
    auto DIM2 = mat[0].size();
    for (auto i = 0; i < DIM1; i++) {
      for (auto j = 0; j < DIM2; j++) {
        mat[i][j] = ptr[i * DIM2 + j];
      }
    }
  }
}

template <class T>
void operator<<(Bmad::VariableArray3D<T> &tensor, const T *ptr) {
  auto DIM1 = tensor.size();
  if (DIM1 == 0)
    return;
  auto DIM2 = tensor[0].size();
  auto DIM3 = tensor[0][0].size();
  for (auto i = 0; i < DIM1; i++) {
    for (auto j = 0; j < DIM2; j++) {
      for (auto k = 0; k < DIM3; k++) {
        tensor[i][j][k] = ptr[i * DIM2 * DIM3 + j * DIM3 + k];
      }
    }
  }
}

template <class T> void operator<<(vector<T> &arr1, const vector<T> &arr2) {
  auto n1 = arr1.size(), DIM2 = arr2.size();
  if (n1 != DIM2)
    arr1.resize(DIM2);
  arr1 = arr2;
}

template <class T>
void operator<<(vector<vector<T>> &mat1, const vector<vector<T>> &mat2) {
  auto n1_1 = mat1.size(), n2_1 = mat2.size();
  auto n1_2 = 0, n2_2 = 0;
  if (n1_1 > 0)
    n1_2 = mat1[0].size();
  if (n2_1 > 0)
    n2_2 = mat2[0].size();
  if (n1_1 != n2_1)
    mat1.resize(n2_1);
  if (n1_2 != n2_2) {
    for (auto i = 0; i < n1_1; i++)
      mat1[i].resize(n2_2);
  }
  mat1 = mat2;
}

template <class T>
void matrix_to_vec(const Bmad::VariableArray2D<T> &mat, T *vec) {
  auto n1 = mat.size();
  if (n1 == 0)
    return;
  auto DIM2 = mat[0].size();
  for (auto i = 0; i < n1; i++) {
    for (auto j = 0; j < DIM2; j++) {
      vec[i * DIM2 + j] = mat[i][j];
    }
  }
}

template <class T>
void tensor_to_vec(const Bmad::VariableArray3D<T> &tensor, T *vec) {
  auto n1 = tensor.size();
  if (n1 == 0)
    return;
  auto DIM2 = tensor[0].size();
  auto DIM3 = tensor[0][0].size();
  for (auto i = 0; i < n1; i++) {
    for (auto j = 0; j < DIM2; j++) {
      for (auto k = 0; k < DIM3; k++) {
        vec[i * DIM2 * DIM3 + j * DIM3 + k] = tensor[i][j][k];
      }
    }
  }
}
template <class T, std::size_t DIM1, std::size_t DIM2>
void matrix_to_vec(const Bmad::FixedArray2D<T, DIM1, DIM2> &mat, T *vec) {
  for (auto i = 0; i < DIM1; i++) {
    for (auto j = 0; j < DIM2; j++) {
      vec[i * DIM2 + j] = mat[i][j];
    }
  }
}

template <class T, std::size_t DIM1, std::size_t DIM2, std::size_t DIM3>
void tensor_to_vec(const Bmad::FixedArray3D<T, DIM1, DIM2, DIM3> &tensor,
                   T *vec) {
  for (auto i = 0; i < DIM1; i++) {
    for (auto j = 0; j < DIM2; j++) {
      for (auto k = 0; k < DIM3; k++) {
        vec[i * DIM2 * DIM3 + j * DIM3 + k] = tensor[i][j][k];
      }
    }
  }
}

//---------------------------------------------------------------------------
// Instantiate instances for conversion from array to C++ structure.

// template void operator<<(&, Bmad::c_Bool *);
// template void operator<<(Bmad::Bool_MATRIX &, Bmad::c_Bool *);
//
// template void operator<<(&, Bmad::c_Real *);
// template void operator<<(Bmad::Real_MATRIX &, Bmad::c_Real *);
// template void operator<<(Bmad::Real_TENSOR &, Bmad::c_Real *);
//
// template void operator<<(&, Bmad::c_Complex *);
// template void operator<<(Bmad::Complex_MATRIX &, Bmad::c_Complex *);
// template void operator<<(Bmad::Complex_TENSOR &, Bmad::c_Complex *);
//
// template void operator<<(&, Bmad::c_Int *);
// template void operator<<(Bmad::Int_MATRIX &, Bmad::c_Int *);
// template void operator<<(Bmad::Int_TENSOR &, Bmad::c_Int *);

//---------------------------------------------------------------------------
// Instantiate instances for transfer

// template void operator<<(Bmad::Real_ARRAY &, const Bmad::Real_ARRAY &);
// template void operator<<(Bmad::Real_MATRIX &, const Bmad::Real_MATRIX &);
// template void operator<<(Bmad::Real_TENSOR &, const Bmad::Real_TENSOR &);
//
// template void operator<<(Bmad::Complex_ARRAY &, const Bmad::Complex_ARRAY &);
// template void operator<<(Bmad::Complex_MATRIX &, const Bmad::Complex_MATRIX
// &); template void operator<<(Bmad::Complex_TENSOR &, const
// Bmad::Complex_TENSOR &);
//
// template void operator<<(Bmad::Int_ARRAY &, const Bmad::Int_ARRAY &);
// template void operator<<(Bmad::Int_MATRIX &, const Bmad::Int_MATRIX &);
// template void operator<<(Bmad::Int_TENSOR &, const Bmad::Int_TENSOR &);

//---------------------------------------------------------------------------

// template void matrix_to_vec(const Bmad::Bool_MATRIX &, Bmad::Bool *);
// template void matrix_to_vec(const Bmad::Complex_MATRIX &, Bmad::Complex *);
// template void matrix_to_vec(const Bmad::Real_MATRIX &, Bmad::Real *);
// template void matrix_to_vec(const Bmad::Int_MATRIX &, Bmad::Int *);
//
// template void tensor_to_vec(const Bmad::Complex_TENSOR &, Bmad::Complex *);
// template void tensor_to_vec(const Bmad::Real_TENSOR &, Bmad::Real *);
// template void tensor_to_vec(const Bmad::Int_TENSOR &, Bmad::Int *);

#define CONVERTER_TEMPLATES
#endif
