#ifndef CONVERTER_TEMPLATES

#include <string>
#include <vector>
#include <complex>
#include "bmad_std_typedef.h"

//---------------------------------------------------------------------------

using std::vector;

template <class T> void operator<< (vector<T>& arr, const T* ptr) {
  unsigned int n = arr.size();
  for (unsigned int i = 0; i < n; i++) arr[i] = ptr[i];
}

template <class T> void operator<< (vector< vector<T> >& mat, const T* ptr) {
  unsigned int n1 = mat.size();
  if (n1 == 0) return;
  unsigned int n2 = mat[0].size();
  for (unsigned int i = 0; i < n1; i++) {
    for (unsigned int j = 0; j < n2; j++) {
      mat[i][j] = ptr[i*n2+j];
    }
  }
}

template <class T> void operator<< (vector< vector< vector<T> > >& tensor, const T* ptr) {
  unsigned int n1 = tensor.size();
  if (n1 == 0) return;
  unsigned int n2 = tensor[0].size();
  unsigned int n3 = tensor[0][0].size();
  for (unsigned int i = 0; i < n1; i++) {
    for (unsigned int j = 0; j < n2; j++) {
      for (unsigned int k = 0; k < n3; k++) {
        tensor[i][j][k] = ptr[i*n2*n3 + j*n3 + k];
      }
    }
  }
}

template <class T> void operator<< (vector<T>& arr1, const vector<T>& arr2) {
  unsigned int n1 = arr1.size(), n2 = arr2.size();
  if (n1 != n2) arr1.resize(n2);
  arr1 = arr2;
}

template <class T> void operator<< (vector< vector<T> >& mat1, 
                              const vector< vector<T> >& mat2) {
  unsigned int n1_1 = mat1.size(), n2_1 = mat2.size();
  unsigned int n1_2 = 0, n2_2 = 0;
  if (n1_1 > 0) n1_2 = mat1[0].size();
  if (n2_1 > 0) n2_2 = mat2[0].size();
  if (n1_1 != n2_1) mat1.resize(n2_1);
  if (n1_2 != n2_2) {for (unsigned int i = 0; i < n1_1; i++) mat1[i].resize(n2_2);}
  mat1 = mat2;
}

template <class T> void matrix_to_vec (const vector< vector<T> >& mat, T* vec) {
  unsigned int n1 = mat.size();
  if (n1 == 0) return;
  unsigned int n2 = mat[0].size();
  for (unsigned int i = 0; i < n1; i++) {
    for (unsigned int j = 0; j < n2; j++) {
      vec[i*n2+j] = mat[i][j];
    }
  }
}

template <class T> void tensor_to_vec (const vector< vector< vector<T> > >& tensor, T* vec) {
  unsigned int n1 = tensor.size();
  if (n1 == 0) return;
  unsigned int n2 = tensor[0].size();
  unsigned int n3 = tensor[0][0].size();
  for (unsigned int i = 0; i < n1; i++) {
    for (unsigned int j = 0; j < n2; j++) {
      for (unsigned int k = 0; k < n3; k++) {
        vec[i*n2*n3 + j*n3 + k] = tensor[i][j][k];
      }
    }
  }
}

//---------------------------------------------------------------------------
// Instantiate instances for conversion from array to C++ structure.

template void operator<< (Bmad::Bool_ARRAY&,  Bmad::c_Bool*);
template void operator<< (Bmad::Bool_MATRIX&, Bmad::c_Bool*);

template void operator<< (Bmad::Real_ARRAY&,  Bmad::c_Real*);
template void operator<< (Bmad::Real_MATRIX&, Bmad::c_Real*);
template void operator<< (Bmad::Real_TENSOR&, Bmad::c_Real*);

template void operator<< (Bmad::Complex_ARRAY&,  Bmad::c_Complex*);
template void operator<< (Bmad::Complex_MATRIX&, Bmad::c_Complex*);
template void operator<< (Bmad::Complex_TENSOR&, Bmad::c_Complex*);

template void operator<< (Bmad::Int_ARRAY&,  Bmad::c_Int*);
template void operator<< (Bmad::Int_MATRIX&, Bmad::c_Int*);
template void operator<< (Bmad::Int_TENSOR&, Bmad::c_Int*);

//---------------------------------------------------------------------------
// Instantiate instances for transfer

template void operator<< (Bmad::Real_ARRAY&,  const Bmad::Real_ARRAY&);
template void operator<< (Bmad::Real_MATRIX&, const Bmad::Real_MATRIX&);
template void operator<< (Bmad::Real_TENSOR&, const Bmad::Real_TENSOR&);

template void operator<< (Bmad::Complex_ARRAY&,  const Bmad::Complex_ARRAY&);
template void operator<< (Bmad::Complex_MATRIX&, const Bmad::Complex_MATRIX&);
template void operator<< (Bmad::Complex_TENSOR&, const Bmad::Complex_TENSOR&);

template void operator<< (Bmad::Int_ARRAY&,  const Bmad::Int_ARRAY&);
template void operator<< (Bmad::Int_MATRIX&, const Bmad::Int_MATRIX&);
template void operator<< (Bmad::Int_TENSOR&, const Bmad::Int_TENSOR&);

//---------------------------------------------------------------------------

template void matrix_to_vec (const Bmad::Bool_MATRIX&,     Bmad::Bool*);
template void matrix_to_vec (const Bmad::Complex_MATRIX&,  Bmad::Complex*);
template void matrix_to_vec (const Bmad::Real_MATRIX&,     Bmad::Real*);
template void matrix_to_vec (const Bmad::Int_MATRIX&,      Bmad::Int*);

template void tensor_to_vec (const Bmad::Complex_TENSOR&,  Bmad::Complex*);
template void tensor_to_vec (const Bmad::Real_TENSOR&,     Bmad::Real*);
template void tensor_to_vec (const Bmad::Int_TENSOR&,      Bmad::Int*);

#define CONVERTER_TEMPLATES
#endif
