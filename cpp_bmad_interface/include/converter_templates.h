#ifndef CONVERTER_TEMPLATES
#define CONVERTER_TEMPLATES

#include "bmad_std_typedef.h"
#include <complex>
#include <string>
#include <vector>

//---------------------------------------------------------------------------

using std::size_t;
using std::vector;

template <typename T, size_t DIM1>
void operator<<(Bmad::FixedArray1D<T, DIM1> &arr, const T *ptr) {
  for (size_t i = 0; i < DIM1; i++) {
    arr[i] = ptr[i];
  }
}

template <class T, size_t DIM1, std::size_t DIM2>
void operator<<(Bmad::FixedArray2D<T, DIM1, DIM2> &arr, const T *ptr) {
  for (size_t i = 0; i < DIM1; i++) {
    for (size_t j = 0; j < DIM2; j++) {
      arr[i][j] = ptr[i * DIM2 + j];
    }
  }
}
template <class T, size_t DIM1, std::size_t DIM2, std::size_t DIM3>
void operator<<(Bmad::FixedArray3D<T, DIM1, DIM2, DIM3> &arr, const T *ptr) {
  for (size_t i = 0; i < DIM1; i++) {
    for (size_t j = 0; j < DIM2; j++) {
      for (size_t k = 0; k < DIM3; k++) {
        arr[i][j][k] = ptr[i * DIM2 * DIM3 + j * DIM2 + k];
      }
    }
  }
}

template <typename T>
void operator<<(Bmad::VariableArray1D<T> &arr, const T *ptr) {
  auto DIM1 = arr.size();
  for (size_t i = 0; i < DIM1; i++) {
    arr[i] = ptr[i];
  }
}

template <class T>
void operator<<(Bmad::VariableArray2D<T> &mat, const T *ptr) {
  auto DIM1 = mat.size();
  if (DIM1 > 0) {
    auto DIM2 = mat[0].size();
    for (size_t i = 0; i < DIM1; i++) {
      for (size_t j = 0; j < DIM2; j++) {
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
  for (size_t i = 0; i < DIM1; i++) {
    for (size_t j = 0; j < DIM2; j++) {
      for (size_t k = 0; k < DIM3; k++) {
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
    for (size_t i = 0; i < n1_1; i++)
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
  for (size_t i = 0; i < n1; i++) {
    for (size_t j = 0; j < DIM2; j++) {
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
  for (size_t i = 0; i < n1; i++) {
    for (size_t j = 0; j < DIM2; j++) {
      for (size_t k = 0; k < DIM3; k++) {
        vec[i * DIM2 * DIM3 + j * DIM3 + k] = tensor[i][j][k];
      }
    }
  }
}
template <class T, size_t DIM1, std::size_t DIM2>
void matrix_to_vec(const Bmad::FixedArray2D<T, DIM1, DIM2> &mat, T *vec) {
  for (size_t i = 0; i < DIM1; i++) {
    for (size_t j = 0; j < DIM2; j++) {
      vec[i * DIM2 + j] = mat[i][j];
    }
  }
}

template <class T, size_t DIM1, std::size_t DIM2, std::size_t DIM3>
void tensor_to_vec(const Bmad::FixedArray3D<T, DIM1, DIM2, DIM3> &tensor,
                   T *vec) {
  for (size_t i = 0; i < DIM1; i++) {
    for (size_t j = 0; j < DIM2; j++) {
      for (size_t k = 0; k < DIM3; k++) {
        vec[i * DIM2 * DIM3 + j * DIM3 + k] = tensor[i][j][k];
      }
    }
  }
}

template <typename T, size_t DIM1>
std::ostream &operator<<(std::ostream &os,
                         const Bmad::FixedArray1D<T, DIM1> &obj) {
  for (size_t i = 0; i < DIM1; ++i) {
    os << obj[i];
    if (i < DIM1 - 1) {
      os << ", ";
    }
  }
  return os;
}

template <typename T, size_t DIM1, std::size_t DIM2>
std::ostream &operator<<(std::ostream &os,
                         const Bmad::FixedArray2D<T, DIM1, DIM2> &obj) {
  for (size_t i = 0; i < DIM1; ++i) {
    for (size_t j = 0; j < DIM2; ++j) {
      os << "(" << i << "," << j << ")=" << obj[i][j];
      if (j < DIM2 - 1) {
        os << ", ";
      }
    }
  }
  return os;
}

template <typename T, size_t DIM1, std::size_t DIM2, std::size_t DIM3>
std::ostream &operator<<(std::ostream &os,
                         const Bmad::FixedArray3D<T, DIM1, DIM2, DIM3> &obj) {
  for (size_t i = 0; i < DIM1; ++i) {
    for (size_t j = 0; j < DIM2; ++j) {
      for (size_t k = 0; k < DIM3; ++k) {
        os << "(" << i << "," << j << "," << k << ")=" << obj[i][j][k];
        if (k < DIM2 - 1) {
          os << ", ";
        }
      }
    }
  }
  return os;
}

template <typename T>
std::ostream &operator<<(std::ostream &os,
                         const Bmad::VariableArray1D<T> &obj) {
  os << "[";
  for (size_t i = 0; i < obj.size(); ++i) {
    os << obj[i];
    if (i < obj.size() - 1) {
      os << ", ";
    }
  }
  os << "]";
  return os;
}

template <typename T>
std::ostream &operator<<(std::ostream &os,
                         const Bmad::VariableArray2D<T> &obj) {
  os << "[";
  for (size_t i = 0; i < obj.size(); ++i) {
    os << obj[i];
    if (i < obj.size() - 1) {
      os << "\n";
    }
  }
  os << "]";
  return os;
}

template <typename T>
std::ostream &operator<<(std::ostream &os,
                         const Bmad::VariableArray3D<T> &obj) {
  os << "[";
  for (size_t i = 0; i < obj.size(); ++i) {
    os << obj[i];
    if (i < obj.size() - 1) {
      os << "\n";
    }
  }
  os << "]";
  return os;
}
#endif
