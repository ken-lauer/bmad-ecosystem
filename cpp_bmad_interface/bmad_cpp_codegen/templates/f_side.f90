! vi: syntax=fortran
! See README.md for details about this file. **It is not intended to be compilable code!**
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine to_c (Fp, C) bind(c)
!
! Routine to convert a Bmad {s_name}_struct to a C++ CPP_{s_name} structure
!
! Input:
!   Fp -- type(c_ptr), value :: Input Bmad structure.
!
! Output:
!   C -- type(c_ptr), value :: Output C++ struct.
!-

!!!! section:to_c
!!!! type:0D_NOT_character
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  character(c_char) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  call c_f_pointer (Fp, F)
  call to_c2 (C, 
  !!!! begin:to_c2_call
  trim(F%NAME) // c_null_char
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_NOT_logical
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  logical(c_bool) :: z_NAME
  !!!! end:to_c2_type_and_name
  call c_f_pointer (Fp, F)
  call to_c2 (C, 
  !!!! begin:to_c2_call
  c_logic(F%NAME)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_NOT_complex
!!!! type:0D_NOT_integer
!!!! type:0D_NOT_integer8
!!!! type:0D_NOT_real
subroutine to_c (Fp, C) bind(C)
  !!!! case:0D_NOT_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME
  !!!! case:0D_NOT_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME
  !!!! case:0D_NOT_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME
  !!!! case:0D_NOT_real:to_c2_type_and_name
  real(c_double) :: z_NAME
  call c_f_pointer (Fp, F)
  call to_c2 (C, 
  !!!! begin:to_c2_call
  F%NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_NOT_real16
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  real(c_double) :: z_NAME
  !!!! end:to_c2_type_and_name
  call c_f_pointer (Fp, F)
  call to_c2 (C, 

  ! NOTE/TODO: precision loss - quad to double!
  !!!! begin:to_c2_call
  real(F%NAME, 8)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_NOT_size
!!!! type:1D_NOT_size
!!!! type:2D_NOT_size
!!!! type:3D_NOT_size
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  integer(c_int), value :: NAME
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  integer(c_int) :: NAME
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  call to_c2 (C, 
  !!!! begin:to_c2_call
  NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_NOT_type
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_c2_type_and_name
  call c_f_pointer (Fp, F)
  call to_c2 (C, 
  !!!! begin:to_c2_call
  c_loc(F%NAME)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_ALLOC_character
!!!! type:0D_PTR_character
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  character(c_char) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  character(STR_LEN+1), target :: f_NAME
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  n_NAME = 0
  if (associated_or_allocated(F%NAME)) then
    n_NAME = 1
    f_NAME = trim(F%NAME) // c_null_char
  endif
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  f_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_ALLOC_logical
!!!! type:0D_PTR_logical
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  logical(c_bool) :: z_NAME
  !!!! end:to_c2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  n_NAME = 0
  if (associated_or_allocated(F%NAME)) n_NAME = 1
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  fscalar2scalar(F%NAME, n_NAME)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_ALLOC_complex
!!!! type:0D_ALLOC_integer
!!!! type:0D_ALLOC_integer8
!!!! type:0D_ALLOC_real
!!!! type:0D_ALLOC_size
!!!! type:0D_PTR_complex
!!!! type:0D_PTR_integer
!!!! type:0D_PTR_integer8
!!!! type:0D_PTR_real
!!!! type:0D_PTR_size
subroutine to_c (Fp, C) bind(C)
  !!!! case:0D_ALLOC_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME
  !!!! case:0D_ALLOC_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME
  !!!! case:0D_ALLOC_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME
  !!!! case:0D_ALLOC_real:to_c2_type_and_name
  real(c_double) :: z_NAME
  !!!! case:0D_ALLOC_size:to_c2_type_and_name
  integer(c_int), value :: z_NAME
  !!!! case:0D_PTR_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME
  !!!! case:0D_PTR_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME
  !!!! case:0D_PTR_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME
  !!!! case:0D_PTR_real:to_c2_type_and_name
  real(c_double) :: z_NAME
  !!!! case:0D_PTR_size:to_c2_type_and_name
  integer(c_int), value :: z_NAME
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  n_NAME = 0
  if (associated_or_allocated(F%NAME)) n_NAME = 1
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  F%NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:0D_ALLOC_type
!!!! type:0D_PTR_type
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_c2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  n_NAME = 0
  if (associated_or_allocated(F%NAME)) n_NAME = 1
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  c_loc(F%NAME)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:1D_NOT_character
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  type(c_ptr) :: z_NAME(DIM1)
  character(STR_LEN+1), target :: a_NAME(DIM1)
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1
  a_NAME(jd1) = trim(F%NAME(jd1+lb1)) // c_null_char
  z_NAME(jd1) = c_loc(a_NAME(jd1))
  enddo
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  z_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:1D_NOT_complex
!!!! type:1D_NOT_integer
!!!! type:1D_NOT_integer8
!!!! type:1D_NOT_logical
!!!! type:1D_NOT_real
subroutine to_c (Fp, C) bind(C)
  !!!! case:1D_NOT_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:1D_NOT_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:1D_NOT_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:1D_NOT_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:1D_NOT_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  call c_f_pointer (Fp, F)
  call to_c2 (C, 
  !!!! begin:to_c2_call
  fvec2vec(F%NAME, DIM1)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:1D_NOT_type
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  type(c_ptr) :: z_NAME(DIM1)
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1
  z_NAME(jd1) = c_loc(F%NAME(jd1+lb1))
  enddo
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  z_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:1D_ALLOC_character
!!!! type:1D_PTR_character
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  type(c_ptr), allocatable :: z_NAME(:)
  character(STR_LEN+1), allocatable, target :: a_NAME(:)
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  n1_NAME = 0
  if (associated_or_allocated(F%NAME)) then
    n1_NAME = size(F%NAME); lb1 = lbound(F%NAME, 1) - 1
    allocate (a_NAME(n1_NAME))
    allocate (z_NAME(n1_NAME))
    do jd1 = 1, n1_NAME
    a_NAME(jd1) = trim(F%NAME(jd1+lb1)) // c_null_char
    z_NAME(jd1) = c_loc(a_NAME(jd1))
    enddo
  endif
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  z_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:1D_ALLOC_complex
!!!! type:1D_ALLOC_integer
!!!! type:1D_ALLOC_integer8
!!!! type:1D_ALLOC_logical
!!!! type:1D_ALLOC_real
!!!! type:1D_ALLOC_size
!!!! type:1D_PTR_complex
!!!! type:1D_PTR_integer
!!!! type:1D_PTR_integer8
!!!! type:1D_PTR_logical
!!!! type:1D_PTR_real
!!!! type:1D_PTR_size
subroutine to_c (Fp, C) bind(C)
  !!!! case:1D_ALLOC_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:1D_ALLOC_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:1D_ALLOC_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:1D_ALLOC_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:1D_ALLOC_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  !!!! case:1D_ALLOC_size:to_c2_type_and_name
  integer(c_int), value :: z_NAME(*)
  !!!! case:1D_PTR_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:1D_PTR_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:1D_PTR_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:1D_PTR_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:1D_PTR_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  !!!! case:1D_PTR_size:to_c2_type_and_name
  integer(c_int), value :: z_NAME(*)
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  n1_NAME = 0
  if (associated_or_allocated(F%NAME)) then
    n1_NAME = size(F%NAME, 1)
  endif
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  fvec2vec(F%NAME, n1_NAME)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:1D_ALLOC_type
!!!! type:1D_PTR_type
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  type(c_ptr), allocatable :: z_NAME(:)
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  n1_NAME = 0
  if (associated_or_allocated(F%NAME)) then
    n1_NAME = size(F%NAME)
    lb1 = lbound(F%NAME, 1) - 1
    allocate (z_NAME(n1_NAME))
    do jd1 = 1, n1_NAME
      z_NAME(jd1) = c_loc(F%NAME(jd1+lb1))
    enddo
  endif
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  z_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:2D_NOT_complex
!!!! type:2D_NOT_integer
!!!! type:2D_NOT_integer8
!!!! type:2D_NOT_logical
!!!! type:2D_NOT_real
subroutine to_c (Fp, C) bind(C)
  !!!! case:2D_NOT_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:2D_NOT_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:2D_NOT_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:2D_NOT_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:2D_NOT_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  call c_f_pointer (Fp, F)
  call to_c2 (C, 
  !!!! begin:to_c2_call
  mat2vec(F%NAME, DIM2)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:2D_NOT_type
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  type(c_ptr) :: z_NAME(DIM1*DIM2)
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1
  do jd2 = 1, size(F%NAME,2); lb2 = lbound(F%NAME,2) - 1
  z_NAME(DIM2*(jd1-1) + jd2) = c_loc(F%NAME(jd1+lb1,jd2+lb2))
  enddo; enddo
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  z_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:2D_ALLOC_complex
!!!! type:2D_ALLOC_integer
!!!! type:2D_ALLOC_integer8
!!!! type:2D_ALLOC_logical
!!!! type:2D_ALLOC_real
!!!! type:2D_ALLOC_size
!!!! type:2D_PTR_complex
!!!! type:2D_PTR_integer
!!!! type:2D_PTR_integer8
!!!! type:2D_PTR_logical
!!!! type:2D_PTR_real
!!!! type:2D_PTR_size
subroutine to_c (Fp, C) bind(C)
  !!!! case:2D_ALLOC_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:2D_ALLOC_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:2D_ALLOC_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:2D_ALLOC_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:2D_ALLOC_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  !!!! case:2D_ALLOC_size:to_c2_type_and_name
  integer(c_int), value :: z_NAME(*)
  !!!! case:2D_PTR_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:2D_PTR_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:2D_PTR_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:2D_PTR_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:2D_PTR_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  !!!! case:2D_PTR_size:to_c2_type_and_name
  integer(c_int), value :: z_NAME(*)
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  if (associated_or_allocated(F%NAME)) then
    n1_NAME = size(F%NAME, 1)
    n2_NAME = size(F%NAME, 2)
  else
    n1_NAME = 0; n2_NAME = 0
  endif
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  mat2vec(F%NAME, n1_NAME*n2_NAME)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:2D_ALLOC_type
!!!! type:2D_PTR_type
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  type(c_ptr), allocatable :: z_NAME(:)
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  if (associated_or_allocated(F%NAME)) then
    n1_NAME = size(F%NAME, 1); lb1 = lbound(F%NAME, 1) - 1
    n2_NAME = size(F%NAME, 2); lb2 = lbound(F%NAME, 2) - 1
    allocate (z_NAME(n1_NAME * n2_NAME))
    do jd1 = 1, n1_NAME; do jd2 = 1, n2_NAME
    z_NAME(n2_NAME*(jd1-1) + jd2) = c_loc(F%NAME(jd1+lb1, jd2+lb2))
    enddo;  enddo
  else
    n1_NAME = 0; n2_NAME = 0
  endif
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  z_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:3D_NOT_complex
!!!! type:3D_NOT_integer
!!!! type:3D_NOT_integer8
!!!! type:3D_NOT_logical
!!!! type:3D_NOT_real
subroutine to_c (Fp, C) bind(C)
  !!!! case:3D_NOT_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:3D_NOT_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:3D_NOT_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:3D_NOT_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:3D_NOT_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  call c_f_pointer (Fp, F)
  call to_c2 (C, 
  !!!! begin:to_c2_call
  tensor2vec(F%NAME, DIM3)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:3D_NOT_type
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  type(c_ptr) :: z_NAME(DIM1*DIM2*DIM3)
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1
  do jd2 = 1, size(F%NAME,2); lb2 = lbound(F%NAME,2) - 1
  do jd3 = 1, size(F%NAME,3); lb3 = lbound(F%NAME,3) - 1
  z_NAME(DIM3*DIM2*(jd1-1) + DIM3*(jd2-1) + jd3) = c_loc(F%NAME(jd1+lb1,jd2+lb2,jd3+lb3))
  enddo; enddo; enddo
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  z_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:3D_ALLOC_complex
!!!! type:3D_ALLOC_integer
!!!! type:3D_ALLOC_integer8
!!!! type:3D_ALLOC_logical
!!!! type:3D_ALLOC_real
!!!! type:3D_ALLOC_size
!!!! type:3D_PTR_complex
!!!! type:3D_PTR_integer
!!!! type:3D_PTR_integer8
!!!! type:3D_PTR_logical
!!!! type:3D_PTR_real
!!!! type:3D_PTR_size
subroutine to_c (Fp, C) bind(C)
  !!!! case:3D_ALLOC_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:3D_ALLOC_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:3D_ALLOC_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:3D_ALLOC_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:3D_ALLOC_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  !!!! case:3D_ALLOC_size:to_c2_type_and_name
  integer(c_int), value :: z_NAME(*)
  !!!! case:3D_PTR_complex:to_c2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:3D_PTR_integer:to_c2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:3D_PTR_integer8:to_c2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:3D_PTR_logical:to_c2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:3D_PTR_real:to_c2_type_and_name
  real(c_double) :: z_NAME(*)
  !!!! case:3D_PTR_size:to_c2_type_and_name
  integer(c_int), value :: z_NAME(*)
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  if (associated_or_allocated(F%NAME)) then
    n1_NAME = size(F%NAME, 1)
    n2_NAME = size(F%NAME, 2)
    n3_NAME = size(F%NAME, 3)
  else
    n1_NAME = 0; n2_NAME = 0; n3_NAME = 0
  endif
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  tensor2vec(F%NAME, n1_NAME*n2_NAME*n3_NAME)
  !!!! end:to_c2_call
  )
end subroutine to_c

!!!! section:to_c
!!!! type:3D_ALLOC_type
!!!! type:3D_PTR_type
subroutine to_c (Fp, C) bind(C)
  !!!! begin:to_c2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_c2_type_and_name
  !!!! begin:to_c_var
  type(c_ptr), allocatable :: z_NAME(:)
  !!!! end:to_c_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_c_trans
  if (associated_or_allocated(F%NAME)) then
    n1_NAME = size(F%NAME, 1); lb1 = lbound(F%NAME, 1) - 1
    n2_NAME = size(F%NAME, 2); lb2 = lbound(F%NAME, 2) - 1
    n3_NAME = size(F%NAME, 3); lb3 = lbound(F%NAME, 3) - 1
    allocate (z_NAME(n1_NAME * n2_NAME * n3_NAME))
    do jd1 = 1, n1_NAME; do jd2 = 1, n2_NAME; do jd3 = 1, n3_NAME
    z_NAME(n3_NAME*n2_NAME*(jd1-1) + n3_NAME*(jd2-1) + jd3) = c_loc(F%NAME(jd1+lb1, jd2+lb2, jd3+lb3))
    enddo;  enddo; enddo
  else
    n1_NAME = 0; n2_NAME = 0; n3_NAME = 0
  endif
  !!!! end:to_c_trans
  call to_c2 (C, 
  !!!! begin:to_c2_call
  z_NAME
  !!!! end:to_c2_call
  )
end subroutine to_c


! vi: syntax=fortran
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine {s_name}_to_f2 (Fp, ...etc...) bind(c)
!
! Routine used in converting a C++ CPP_{s_name} structure to a Bmad {s_name}_struct structure.
! This routine is called by {s_name}_to_c and is not meant to be called directly.
!
! Input:
!   ...etc... -- Components of the structure. See the {s_name}_to_f2 code for more details.
!
! Output:
!   Fp -- type(c_ptr), value :: Bmad {s_name}_struct structure.
!-
    
!!!! section:to_f2
!!!! type:0D_NOT_character
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  character(c_char) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  call to_f_str(z_NAME, F%NAME)
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_NOT_logical
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  logical(c_bool) :: z_NAME
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  F%NAME = f_logic(z_NAME)
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_NOT_complex
!!!! type:0D_NOT_integer
!!!! type:0D_NOT_integer8
!!!! type:0D_NOT_real
!!!! type:0D_NOT_real16
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! case:0D_NOT_complex:to_f2_type_and_name
  complex(c_double_complex) :: z_NAME
  !!!! case:0D_NOT_integer:to_f2_type_and_name
  integer(c_int) :: z_NAME
  !!!! case:0D_NOT_integer8:to_f2_type_and_name
  integer(c_long) :: z_NAME
  !!!! case:0D_NOT_real:to_f2_type_and_name
  real(c_double) :: z_NAME
  !!!! case:0D_NOT_real16:to_f2_type_and_name
  real(c_double) :: z_NAME
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  F%NAME = z_NAME
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_NOT_size
!!!! type:1D_NOT_size
!!!! type:2D_NOT_size
!!!! type:3D_NOT_size
subroutine to_f2 (C, NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  integer(c_int), value :: NAME
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_NOT_type
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  call KIND_to_f(z_NAME, c_loc(F%NAME))
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_ALLOC_character
!!!! type:0D_PTR_character
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  character(c_char) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME)
    call to_f_str(z_NAME, F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_ALLOC_complex
!!!! type:0D_PTR_complex
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  complex(c_double_complex), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    call c_f_pointer (z_NAME, f_NAME)
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME)
    F%NAME = f_NAME
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_ALLOC_integer
!!!! type:0D_PTR_integer
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    call c_f_pointer (z_NAME, f_NAME)
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME)
    F%NAME = f_NAME
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_ALLOC_integer8
!!!! type:0D_PTR_integer8
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_long), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    call c_f_pointer (z_NAME, f_NAME)
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME)
    F%NAME = f_NAME
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_ALLOC_logical
!!!! type:0D_PTR_logical
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  logical(c_bool), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    call c_f_pointer (z_NAME, f_NAME)
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME)
    F%NAME = f_logic(f_NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_ALLOC_real
!!!! type:0D_PTR_real
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  real(c_double), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  if (n_NAME > 0) then
    call c_f_pointer (z_NAME, f_NAME)
    allocate(F%NAME)
    F%NAME = f_NAME
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_ALLOC_size
!!!! type:0D_PTR_size
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), value, pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    call c_f_pointer (z_NAME, f_NAME)
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME)
    F%NAME = f_NAME
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:0D_ALLOC_type
!!!! type:0D_PTR_type
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  type(KIND_struct), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME)
    call KIND_to_f (z_NAME, c_loc(F%NAME))
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_NOT_character
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  character(c_char), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1
  call c_f_pointer (z_NAME(jd1), f_NAME)
  call to_f_str(f_NAME, F%NAME(jd1+lb1))
  enddo
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_NOT_logical
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  call vec2fvec (z_NAME, F%NAME)
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_NOT_complex
!!!! type:1D_NOT_integer
!!!! type:1D_NOT_integer8
!!!! type:1D_NOT_real
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! case:1D_NOT_complex:to_f2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:1D_NOT_integer:to_f2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:1D_NOT_integer8:to_f2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:1D_NOT_real:to_f2_type_and_name
  real(c_double) :: z_NAME(*)
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  F%NAME = z_NAME(1:DIM1)
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_NOT_type
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1
  call KIND_to_f(z_NAME(jd1), c_loc(F%NAME(jd1+lb1)))
  enddo
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_ALLOC_character
!!!! type:1D_PTR_character
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  character(c_char), pointer :: f_NAME
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n1_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    if (associated_or_allocated(F%NAME)) then
      if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
      if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
    endif
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(LBOUND:n1_NAME+LBOUND-1))
    do jd1 = 1, n1_NAME
    call c_f_pointer (z_NAME(jd1), f_NAME)
    call to_f_str(f_NAME, F%NAME(jd1+LBOUND-1))
    enddo
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_ALLOC_complex
!!!! type:1D_PTR_complex
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  complex(c_double_complex), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME))
    F%NAME = f_NAME(1:n1_NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_ALLOC_integer
!!!! type:1D_PTR_integer
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME))
    F%NAME = f_NAME(1:n1_NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_ALLOC_integer8
!!!! type:1D_PTR_integer8
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_long), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME))
    F%NAME = f_NAME(1:n1_NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_ALLOC_logical
!!!! type:1D_PTR_logical
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  logical(c_bool), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME))
    call vec2fvec (f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_ALLOC_real
!!!! type:1D_PTR_real
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  real(c_double), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME))
    F%NAME = f_NAME(1:n1_NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_ALLOC_size
!!!! type:1D_PTR_size
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), value, pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME))
    F%NAME = f_NAME(1:n1_NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:1D_ALLOC_type
!!!! type:1D_PTR_type
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n1_NAME == 0) then
    if (associated_or_allocated(F%NAME)) then
      deallocate(F%NAME)
    endif
  else
    if (associated_or_allocated(F%NAME)) then
      if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
      if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
    endif
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(LBOUND:n1_NAME+LBOUND-1))
    do jd1 = 1, n1_NAME
      call KIND_to_f (z_NAME(jd1), c_loc(F%NAME(jd1+LBOUND-1)))
    enddo
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_NOT_complex
!!!! type:2D_NOT_integer
!!!! type:2D_NOT_integer8
!!!! type:2D_NOT_logical
!!!! type:2D_NOT_real
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! case:2D_NOT_complex:to_f2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:2D_NOT_integer:to_f2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:2D_NOT_integer8:to_f2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:2D_NOT_logical:to_f2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:2D_NOT_real:to_f2_type_and_name
  real(c_double) :: z_NAME(*)
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  call vec2mat(z_NAME, F%NAME)
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_NOT_type
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1
  do jd2 = 1, size(F%NAME,2); lb2 = lbound(F%NAME,2) - 1
  call KIND_to_f(z_NAME(DIM2*(jd1-1) + jd2), c_loc(F%NAME(jd1+lb1,jd2+lb2)))
  enddo; enddo
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_ALLOC_complex
!!!! type:2D_PTR_complex
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  complex(c_double_complex), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME))
    call vec2mat(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_ALLOC_integer
!!!! type:2D_PTR_integer
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME))
    call vec2mat(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_ALLOC_integer8
!!!! type:2D_PTR_integer8
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_long), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME))
    call vec2mat(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_ALLOC_logical
!!!! type:2D_PTR_logical
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  logical(c_bool), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME))
    call vec2mat(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_ALLOC_real
!!!! type:2D_PTR_real
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  real(c_double), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME))
    call vec2mat(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_ALLOC_size
!!!! type:2D_PTR_size
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), value, pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME))
    call vec2mat(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:2D_ALLOC_type
!!!! type:2D_PTR_type
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n1_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    if (associated_or_allocated(F%NAME)) then
      if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME])) deallocate(F%NAME)
      if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
    endif
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(LBOUND:n1_NAME+LBOUND-1, LBOUND:n2_NAME+LBOUND-1))
    do jd1 = 1, n1_NAME
      do jd2 = 1, n2_NAME
        call KIND_to_f (z_NAME(n2_NAME*(jd1-1) + jd2), c_loc(F%NAME(jd1+LBOUND-1,jd2+LBOUND-1)))
      enddo
    enddo
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_NOT_complex
!!!! type:3D_NOT_integer
!!!! type:3D_NOT_integer8
!!!! type:3D_NOT_logical
!!!! type:3D_NOT_real
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! case:3D_NOT_complex:to_f2_type_and_name
  complex(c_double_complex) :: z_NAME(*)
  !!!! case:3D_NOT_integer:to_f2_type_and_name
  integer(c_int) :: z_NAME(*)
  !!!! case:3D_NOT_integer8:to_f2_type_and_name
  integer(c_long) :: z_NAME(*)
  !!!! case:3D_NOT_logical:to_f2_type_and_name
  logical(c_bool) :: z_NAME(*)
  !!!! case:3D_NOT_real:to_f2_type_and_name
  real(c_double) :: z_NAME(*)
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  call vec2tensor(z_NAME, F%NAME)
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_NOT_type
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1
  do jd2 = 1, size(F%NAME,2); lb2 = lbound(F%NAME,2) - 1
  do jd3 = 1, size(F%NAME,3); lb3 = lbound(F%NAME,3) - 1
  call KIND_to_f(z_NAME(DIM3*DIM2*(jd1-1) + DIM3*(jd2-1) + jd3), c_loc(F%NAME(jd1+lb1,jd2+lb2,jd3+lb3)))
  enddo; enddo; enddo
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_ALLOC_complex
!!!! type:3D_PTR_complex
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  complex(c_double_complex), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME, n3_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME*n3_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME, n3_NAME))
    call vec2tensor(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_ALLOC_integer
!!!! type:3D_PTR_integer
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME, n3_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME*n3_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME, n3_NAME))
    call vec2tensor(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_ALLOC_integer8
!!!! type:3D_PTR_integer8
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_long), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME, n3_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME*n3_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME, n3_NAME))
    call vec2tensor(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_ALLOC_logical
!!!! type:3D_PTR_logical
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  logical(c_bool), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME, n3_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME*n3_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME, n3_NAME))
    call vec2tensor(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_ALLOC_real
!!!! type:3D_PTR_real
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  real(c_double), pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME, n3_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME*n3_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME, n3_NAME))
    call vec2tensor(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_ALLOC_size
!!!! type:3D_PTR_size
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr), value :: z_NAME
  !!!! end:to_f2_type_and_name
  !!!! begin:to_f2_var
  integer(c_int), value, pointer :: f_NAME(:)
  !!!! end:to_f2_var
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (associated_or_allocated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME, n3_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (n1_NAME /= 0) then
    call c_f_pointer (z_NAME, f_NAME, [n1_NAME*n2_NAME*n3_NAME])
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(n1_NAME, n2_NAME, n3_NAME))
    call vec2tensor(f_NAME, F%NAME)
  else
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

!!!! section:to_f2
!!!! type:3D_ALLOC_type
!!!! type:3D_PTR_type
subroutine to_f2 (C, z_NAME) bind(c)
  !!!! begin:to_f2_type_and_name
  type(c_ptr) :: z_NAME(*)
  !!!! end:to_f2_type_and_name
  call c_f_pointer (Fp, F)
  !!!! begin:to_f2_trans
  if (n1_NAME == 0) then
    if (associated_or_allocated(F%NAME)) deallocate(F%NAME)
  else
    if (associated_or_allocated(F%NAME)) then
      if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME, n3_NAME])) deallocate(F%NAME)
      if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
    endif
    if (.not. associated_or_allocated(F%NAME)) allocate(F%NAME(LBOUND:n1_NAME+LBOUND-1, LBOUND:n2_NAME+LBOUND-1, LBOUND:n3_NAME+LBOUND-1))
    do jd1 = 1, n1_NAME;  do jd2 = 1, n2_NAME;  do jd3 = 1, n3_NAME
    call KIND_to_f (z_NAME(n3_NAME*n2_NAME*(jd1-1) + n3_NAME*(jd2-1) + jd3), c_loc(F%NAME(jd1+LBOUND-1,jd2+LBOUND-1,jd3+LBOUND-1)))
    enddo;  enddo;  enddo
  endif
  !!!! end:to_f2_trans
end subroutine to_f2

subroutine EQUALITY_TEST ()
!!!! section:equality_test
!!!! type:0D_ALLOC_logical
!!!! type:0D_PTR_logical
!!!! begin:equality_test
is_eq = is_eq .and. (associated_or_allocated(f1%NAME) .eqv. associated_or_allocated(f2%NAME))
if (.not. is_eq) return
if (associated_or_allocated(f1%NAME)) is_eq = (f1%NAME .eqv. f2%NAME)
!!!! end:equality_test

!!!! section:equality_test
!!!! type:0D_ALLOC_character
!!!! type:0D_ALLOC_complex
!!!! type:0D_ALLOC_integer
!!!! type:0D_ALLOC_integer8
!!!! type:0D_ALLOC_real
!!!! type:0D_ALLOC_size
!!!! type:0D_ALLOC_type
!!!! type:0D_PTR_character
!!!! type:0D_PTR_complex
!!!! type:0D_PTR_integer
!!!! type:0D_PTR_integer8
!!!! type:0D_PTR_real
!!!! type:0D_PTR_size
!!!! type:0D_PTR_type
!!!! begin:equality_test
is_eq = is_eq .and. (associated_or_allocated(f1%NAME) .eqv. associated_or_allocated(f2%NAME))
if (.not. is_eq) return
if (associated_or_allocated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)
!!!! end:equality_test

!!!! section:equality_test
!!!! type:1D_ALLOC_logical
!!!! type:1D_PTR_logical
!!!! type:2D_ALLOC_logical
!!!! type:2D_PTR_logical
!!!! type:3D_ALLOC_logical
!!!! type:3D_PTR_logical
!!!! begin:equality_test
is_eq = is_eq .and. (associated_or_allocated(f1%NAME) .eqv. associated_or_allocated(f2%NAME))
if (.not. is_eq) return
if (associated_or_allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))
if (.not. is_eq) return
if (associated_or_allocated(f1%NAME)) is_eq = all(f1%NAME .eqv. f2%NAME)
!!!! end:equality_test

!!!! section:equality_test
!!!! type:1D_ALLOC_character
!!!! type:1D_ALLOC_complex
!!!! type:1D_ALLOC_integer
!!!! type:1D_ALLOC_integer8
!!!! type:1D_ALLOC_real
!!!! type:1D_ALLOC_size
!!!! type:1D_ALLOC_type
!!!! type:1D_PTR_character
!!!! type:1D_PTR_complex
!!!! type:1D_PTR_integer
!!!! type:1D_PTR_integer8
!!!! type:1D_PTR_real
!!!! type:1D_PTR_size
!!!! type:1D_PTR_type
!!!! type:2D_ALLOC_complex
!!!! type:2D_ALLOC_integer
!!!! type:2D_ALLOC_integer8
!!!! type:2D_ALLOC_real
!!!! type:2D_ALLOC_size
!!!! type:2D_ALLOC_type
!!!! type:2D_PTR_complex
!!!! type:2D_PTR_integer
!!!! type:2D_PTR_integer8
!!!! type:2D_PTR_real
!!!! type:2D_PTR_size
!!!! type:2D_PTR_type
!!!! type:3D_ALLOC_complex
!!!! type:3D_ALLOC_integer
!!!! type:3D_ALLOC_integer8
!!!! type:3D_ALLOC_real
!!!! type:3D_ALLOC_size
!!!! type:3D_ALLOC_type
!!!! type:3D_PTR_complex
!!!! type:3D_PTR_integer
!!!! type:3D_PTR_integer8
!!!! type:3D_PTR_real
!!!! type:3D_PTR_size
!!!! type:3D_PTR_type
!!!! begin:equality_test
is_eq = is_eq .and. (associated_or_allocated(f1%NAME) .eqv. associated_or_allocated(f2%NAME))
if (.not. is_eq) return
if (associated_or_allocated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))
if (.not. is_eq) return
if (associated_or_allocated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)
!!!! end:equality_test

!!!! section:equality_test
!!!! type:0D_NOT_logical
!!!! begin:equality_test
is_eq = is_eq .and. (f1%NAME .eqv. f2%NAME)
!!!! end:equality_test

!!!! section:equality_test
!!!! type:0D_NOT_character
!!!! type:0D_NOT_complex
!!!! type:0D_NOT_integer
!!!! type:0D_NOT_integer8
!!!! type:0D_NOT_real
!!!! type:0D_NOT_real16
!!!! type:0D_NOT_type
!!!! begin:equality_test
is_eq = is_eq .and. (f1%NAME == f2%NAME)
!!!! end:equality_test

!!!! section:equality_test
!!!! type:1D_NOT_logical
!!!! type:2D_NOT_logical
!!!! type:3D_NOT_logical
!!!! begin:equality_test
is_eq = is_eq .and. all(f1%NAME .eqv. f2%NAME)
!!!! end:equality_test

!!!! section:equality_test
!!!! type:0D_NOT_size
!!!! type:1D_NOT_character
!!!! type:1D_NOT_complex
!!!! type:1D_NOT_integer
!!!! type:1D_NOT_integer8
!!!! type:1D_NOT_real
!!!! type:1D_NOT_size
!!!! type:1D_NOT_type
!!!! type:2D_NOT_complex
!!!! type:2D_NOT_integer
!!!! type:2D_NOT_integer8
!!!! type:2D_NOT_real
!!!! type:2D_NOT_size
!!!! type:2D_NOT_type
!!!! type:3D_NOT_complex
!!!! type:3D_NOT_integer
!!!! type:3D_NOT_integer8
!!!! type:3D_NOT_real
!!!! type:3D_NOT_size
!!!! type:3D_NOT_type
!!!! begin:equality_test
is_eq = is_eq .and. all(f1%NAME == f2%NAME)
!!!! end:equality_test

end subroutine
