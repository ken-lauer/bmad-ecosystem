module test_struct_defs

use bmad, only: rp, dp

type wake_lr_struct
  integer(8) :: aaa
  integer :: bbb
  character(200) :: file = ''
  real(rp) :: t_ref = 0             ! time reference value for computing the wake amplitude.
                                    !  This is used to prevent value overflow with long trains.
  real(rp) :: freq_spread = 0       ! Random frequency spread of long range modes.
end type


type wake_struct
  type (wake_lr_struct) :: sr = wake_lr_struct(0, 0, '', 0, 0)
end type

type all_encompassing_struct
  ! Real(rp)
  real(rp) real_rp_0d
  real(rp) :: real_rp_1d(3)
  real(rp) :: real_rp_2d(3, 4)
  real(rp) :: real_rp_3d(3, 4, 5)

  real(rp), pointer :: real_rp_0d_ptr
  real(rp), pointer :: real_rp_1d_ptr(:)
  real(rp), pointer :: real_rp_2d_ptr(:,:)
  real(rp), pointer :: real_rp_3d_ptr(:,:,:)

  real(rp), allocatable :: real_rp_1d_alloc(:)
  real(rp), allocatable :: real_rp_2d_alloc(:,:)
  real(rp), allocatable :: real_rp_3d_alloc(:,:,:)

  ! Real(dp)
  real(dp) real_dp_0d
  real(dp) :: real_dp_1d(3)
  real(dp) :: real_dp_2d(3, 4)
  real(dp) :: real_dp_3d(3, 4, 5)

  real(dp), pointer :: real_dp_0d_ptr
  real(dp), pointer :: real_dp_1d_ptr(:)
  real(dp), pointer :: real_dp_2d_ptr(:,:)
  real(dp), pointer :: real_dp_3d_ptr(:,:,:)

  real(dp), allocatable :: real_dp_1d_alloc(:)
  real(dp), allocatable :: real_dp_2d_alloc(:,:)
  real(dp), allocatable :: real_dp_3d_alloc(:,:,:)

  ! complex(dp)
  complex(dp) complex_dp_0d
  complex(dp) :: complex_dp_1d(3)
  complex(dp) :: complex_dp_2d(3, 4)
  complex(dp) :: complex_dp_3d(3, 4, 5)

  complex(dp), pointer :: complex_dp_0d_ptr
  complex(dp), pointer :: complex_dp_1d_ptr(:)
  complex(dp), pointer :: complex_dp_2d_ptr(:,:)
  complex(dp), pointer :: complex_dp_3d_ptr(:,:,:)

  complex(dp), allocatable :: complex_dp_1d_alloc(:)
  complex(dp), allocatable :: complex_dp_2d_alloc(:,:)
  complex(dp), allocatable :: complex_dp_3d_alloc(:,:,:)

  ! Integer
  integer int_0d
  integer :: int_1d(3)
  integer :: int_2d(3, 4)
  integer :: int_3d(3, 4, 5)

  integer, pointer :: int_0d_ptr
  integer, pointer :: int_1d_ptr(:)
  integer, pointer :: int_2d_ptr(:,:)
  integer, pointer :: int_3d_ptr(:,:,:)

  integer, allocatable :: int_1d_alloc(:)
  integer, allocatable :: int_2d_alloc(:,:)
  integer, allocatable :: int_3d_alloc(:,:,:)

  ! Integer8
  integer(8) int8_0d
  integer(8) :: int8_1d(3)
  integer(8) :: int8_2d(3, 4)
  integer(8) :: int8_3d(3, 4, 5)

  integer(8), pointer :: int8_0d_ptr
  integer(8), pointer :: int8_1d_ptr(:)
  integer(8), pointer :: int8_2d_ptr(:,:)
  integer(8), pointer :: int8_3d_ptr(:,:,:)

  integer(8), allocatable :: int8_1d_alloc(:)
  integer(8), allocatable :: int8_2d_alloc(:,:)
  integer(8), allocatable :: int8_3d_alloc(:,:,:)

  ! logical
  logical logical_0d
  logical :: logical_1d(3)
  logical :: logical_2d(3, 4)
  logical :: logical_3d(3, 4, 5)

  logical, pointer :: logical_0d_ptr
  ! logical, pointer :: logical_1d_ptr(:)
  ! logical, pointer :: logical_2d_ptr(:,:)
  ! logical, pointer :: logical_3d_ptr(:,:,:)

  ! logical, allocatable :: logical_1d_alloc(:)
  ! logical, allocatable :: logical_2d_alloc(:,:)
  ! logical, allocatable :: logical_3d_alloc(:,:,:)

  ! type
  type(wake_lr_struct) type_0d
  type(wake_lr_struct) :: type_1d(3)
  type(wake_lr_struct) :: type_2d(3, 4)
  type(wake_lr_struct) :: type_3d(3, 4, 5)

  type(wake_lr_struct), pointer :: type_0d_ptr
  type(wake_lr_struct), pointer :: type_1d_ptr(:)
  type(wake_lr_struct), pointer :: type_2d_ptr(:,:)
  type(wake_lr_struct), pointer :: type_3d_ptr(:,:,:)

  type(wake_lr_struct), allocatable :: type_1d_alloc(:)
  type(wake_lr_struct), allocatable :: type_2d_alloc(:,:)
  type(wake_lr_struct), allocatable :: type_3d_alloc(:,:,:)

end type

end module
