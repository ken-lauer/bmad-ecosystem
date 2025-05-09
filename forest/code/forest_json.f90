module forest_json
use json_module
use json_string_utilities, only: integer_to_string
use json_kinds, only: CK
contains
subroutine complex_to_json (input, json_root, depth, max_depth)
  use precision_constants, only: dp
  implicit none
  type(json_core) :: json
  type (complex(dp)), intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  call json%create_array(json_root, '')
  call json%create_real(json_val, real(input), '')
  call json%add(json_root, json_val)
  call json%create_real(json_val, aimag(input), '')
  call json%add(json_root, json_val)
end subroutine complex_to_json
subroutine ab_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: ab_list
  implicit none
  type(json_core) :: json
  type (ab_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'integer n_m(2)'
  call json%create_array(json_list1, 'n_m')
  do i1 = lbound(input%n_m, 1), ubound(input%n_m, 1)
    call json%create_integer(json_val, input%n_m(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'complex(dp) b(nmul_max,nmul_max)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%b, 2), ubound(input%b, 2)
    call json%create_array(json_list1, 'b')
    do i1 = lbound(input%b, 1), ubound(input%b, 1)
      call complex_to_json(input%b(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'complex(dp) E(nmul_max,nmul_max)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%E, 2), ubound(input%E, 2)
    call json%create_array(json_list1, 'e')
    do i1 = lbound(input%E, 1), ubound(input%E, 1)
      call complex_to_json(input%E(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp) dz_t_te(3*nmul_max+3)'
  call json%create_array(json_list1, 'dz_t_te')
  do i1 = lbound(input%dz_t_te, 1), ubound(input%dz_t_te, 1)
    call json%create_real(json_val, input%dz_t_te(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) scale_angc_xc_vc_dc_hc(6)'
  call json%create_array(json_list1, 'scale_angc_xc_vc_dc_hc')
  do i1 = lbound(input%scale_angc_xc_vc_dc_hc, 1), ubound(input%scale_angc_xc_vc_dc_hc, 1)
    call json%create_real(json_val, input%scale_angc_xc_vc_dc_hc(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine ab_list_to_json
subroutine ABELL_to_json (input, json_root, depth, max_depth)
  use definition, only: ABELL
  implicit none
  type(json_core) :: json
  type (ABELL), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%DZ)) then
    !'real(dp), POINTER :: DZ(:) => null(), T(:) => null(), TE(:) => null()'
    call json%create_array(json_list1, 'dz')
    do i1 = lbound(input%DZ, 1), ubound(input%DZ, 1)
      call json%create_real(json_val, input%DZ(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%T)) then
    !'real(dp), POINTER :: DZ(:) => null(), T(:) => null(), TE(:) => null()'
    call json%create_array(json_list1, 't')
    do i1 = lbound(input%T, 1), ubound(input%T, 1)
      call json%create_real(json_val, input%T(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%TE)) then
    !'real(dp), POINTER :: DZ(:) => null(), T(:) => null(), TE(:) => null()'
    call json%create_array(json_list1, 'te')
    do i1 = lbound(input%TE, 1), ubound(input%TE, 1)
      call json%create_real(json_val, input%TE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%B)) then
    !'complex(dp), POINTER :: B(:,:) => null(),E(:,:) => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%B, 2), ubound(input%B, 2)
      call json%create_array(json_list1, 'b')
      do i1 = lbound(input%B, 1), ubound(input%B, 1)
        call complex_to_json(input%B(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%E)) then
    !'complex(dp), POINTER :: B(:,:) => null(),E(:,:) => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%E, 2), ubound(input%E, 2)
      call json%create_array(json_list1, 'e')
      do i1 = lbound(input%E, 1), ubound(input%E, 1)
        call complex_to_json(input%E(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%M)) then
    call json%add(json_root, 'm', int(input%M))
  endif
  if (associated(input%SCALE)) then
    call json%add(json_root, 'scale', input%SCALE)
  endif
  if (associated(input%angc)) then
    call json%add(json_root, 'angc', input%angc)
  endif
  if (associated(input%dc)) then
    call json%add(json_root, 'dc', input%dc)
  endif
  if (associated(input%hc)) then
    call json%add(json_root, 'hc', input%hc)
  endif
  if (associated(input%xc)) then
    call json%add(json_root, 'xc', input%xc)
  endif
  if (associated(input%vc)) then
    call json%add(json_root, 'vc', input%vc)
  endif
  if (associated(input%xprime)) then
    call json%add(json_root, 'xprime', input%xprime)
  endif
end subroutine ABELL_to_json
subroutine ABELLP_to_json (input, json_root, depth, max_depth)
  use definition, only: ABELLP
  implicit none
  type(json_core) :: json
  type (ABELLP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%DZ)) then
    !'real(dp), POINTER :: DZ(:) => null(),T(:) => null(), TE(:) => null()'
    call json%create_array(json_list1, 'dz')
    do i1 = lbound(input%DZ, 1), ubound(input%DZ, 1)
      call json%create_real(json_val, input%DZ(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%T)) then
    !'real(dp), POINTER :: DZ(:) => null(),T(:) => null(), TE(:) => null()'
    call json%create_array(json_list1, 't')
    do i1 = lbound(input%T, 1), ubound(input%T, 1)
      call json%create_real(json_val, input%T(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%TE)) then
    !'real(dp), POINTER :: DZ(:) => null(),T(:) => null(), TE(:) => null()'
    call json%create_array(json_list1, 'te')
    do i1 = lbound(input%TE, 1), ubound(input%TE, 1)
      call json%create_real(json_val, input%TE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%B)) then
    !'complex(dp), POINTER :: B(:,:) => null(),E(:,:) => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%B, 2), ubound(input%B, 2)
      call json%create_array(json_list1, 'b')
      do i1 = lbound(input%B, 1), ubound(input%B, 1)
        call complex_to_json(input%B(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%E)) then
    !'complex(dp), POINTER :: B(:,:) => null(),E(:,:) => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%E, 2), ubound(input%E, 2)
      call json%create_array(json_list1, 'e')
      do i1 = lbound(input%E, 1), ubound(input%E, 1)
        call complex_to_json(input%E(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%M)) then
    call json%add(json_root, 'm', int(input%M))
  endif
  if (associated(input%angc)) then
    call json%add(json_root, 'angc', input%angc)
  endif
  if (associated(input%dc)) then
    call json%add(json_root, 'dc', input%dc)
  endif
  if (associated(input%hc)) then
    call json%add(json_root, 'hc', input%hc)
  endif
  if (associated(input%xc)) then
    call json%add(json_root, 'xc', input%xc)
  endif
  if (associated(input%vc)) then
    call json%add(json_root, 'vc', input%vc)
  endif
  if (associated(input%SCALE)) then
    call REAL_8_to_json(input%SCALE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'SCALE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%xprime)) then
    call json%add(json_root, 'xprime', input%xprime)
  endif
end subroutine ABELLP_to_json
subroutine acceleration_to_json (input, json_root, depth, max_depth)
  use definition, only: acceleration
  implicit none
  type(json_core) :: json
  type (acceleration), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%n)) then
    call json%add(json_root, 'n', int(input%n))
  endif
  if (associated(input%POS)) then
    call json%add(json_root, 'pos', int(input%POS))
  endif
  if (associated(input%nst)) then
    call json%add(json_root, 'nst', int(input%nst))
  endif
  if (associated(input%r)) then
    call json%add(json_root, 'r', input%r)
  endif
  if (associated(input%de)) then
    !'real(dp), pointer :: r=> null(),de(:)=> null(),e_in(:)=> null()'
    call json%create_array(json_list1, 'de')
    do i1 = lbound(input%de, 1), ubound(input%de, 1)
      call json%create_real(json_val, input%de(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%e_in)) then
    !'real(dp), pointer :: r=> null(),de(:)=> null(),e_in(:)=> null()'
    call json%create_array(json_list1, 'e_in')
    do i1 = lbound(input%e_in, 1), ubound(input%e_in, 1)
      call json%create_real(json_val, input%e_in(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%w1)) then
    call work_to_json(input%w1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'w1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%w2)) then
    call work_to_json(input%w2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'w2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PREVIOUS)) then
    call FIBRE_to_json(input%PREVIOUS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PREVIOUS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%NEXT)) then
    call FIBRE_to_json(input%NEXT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'NEXT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%tableau)) then
    !'type(temps_energie),pointer :: tableau(:) => null()'
    call json%create_array(json_list1, 'tableau')
    do i1 = lbound(input%tableau, 1), ubound(input%tableau, 1)
      call temps_energie_to_json(input%tableau(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%fichier)) then
    call json%add(json_root, 'fichier', trim(input%fichier))
  endif
end subroutine acceleration_to_json
subroutine AFFINE_FRAME_to_json (input, json_root, depth, max_depth)
  use definition, only: AFFINE_FRAME
  implicit none
  type(json_core) :: json
  type (AFFINE_FRAME), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%ANGLE)) then
    !'REAL(DP), POINTER,DIMENSION(:)  ::   ANGLE(:) => null()'
    call json%create_array(json_list1, 'angle')
    do i1 = lbound(input%ANGLE, 1), ubound(input%ANGLE, 1)
      call json%create_real(json_val, input%ANGLE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D)) then
    !'REAL(DP), POINTER,DIMENSION(:)  ::   D(:)     => null()'
    call json%create_array(json_list1, 'd')
    do i1 = lbound(input%D, 1), ubound(input%D, 1)
      call json%create_real(json_val, input%D(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%A)) then
    !'REAL(DP), POINTER,DIMENSION(:)  ::   A        => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%A, 1), ubound(input%A, 1)
      call json%create_real(json_val, input%A(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ENT)) then
    !'REAL(DP), POINTER,DIMENSION(:,:)::   ENT      => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%ENT, 2), ubound(input%ENT, 2)
      call json%create_array(json_list1, 'ent')
      do i1 = lbound(input%ENT, 1), ubound(input%ENT, 1)
        call json%create_real(json_val, input%ENT(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%B)) then
    !'REAL(DP), POINTER,DIMENSION(:)  ::   B        => null()'
    call json%create_array(json_list1, 'b')
    do i1 = lbound(input%B, 1), ubound(input%B, 1)
      call json%create_real(json_val, input%B(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%EXI)) then
    !'REAL(DP), POINTER,DIMENSION(:,:)::   EXI      => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%EXI, 2), ubound(input%EXI, 2)
      call json%create_array(json_list1, 'exi')
      do i1 = lbound(input%EXI, 1), ubound(input%EXI, 1)
        call json%create_real(json_val, input%EXI(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine AFFINE_FRAME_to_json
subroutine ap_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: ap_list
  implicit none
  type(json_core) :: json
  type (ap_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'kind', int(input%KIND))
  !'real(dp) r(2)'
  call json%create_array(json_list1, 'r')
  do i1 = lbound(input%r, 1), ubound(input%r, 1)
    call json%create_real(json_val, input%r(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'y', input%y)
  call json%add(json_root, 'dx', input%dx)
  call json%add(json_root, 'dy', input%dy)
  call json%add(json_root, 'on', input%on)
end subroutine ap_list_to_json
subroutine B_CYL_to_json (input, json_root, depth, max_depth)
  use s_status, only: B_CYL
  implicit none
  type(json_core) :: json
  type (B_CYL), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'firsttime', int(input%firsttime))
  if (associated(input%nmul)) then
    call json%add(json_root, 'nmul', int(input%nmul))
  endif
  if (associated(input%n_mono)) then
    call json%add(json_root, 'n_mono', int(input%n_mono))
  endif
  if (associated(input%i)) then
    !'integer, DIMENSION(:), POINTER   :: i,j'
    call json%create_array(json_list1, 'i')
    do i1 = lbound(input%i, 1), ubound(input%i, 1)
      call json%create_integer(json_val, input%i(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%j)) then
    !'integer, DIMENSION(:), POINTER   :: i,j'
    call json%create_array(json_list1, 'j')
    do i1 = lbound(input%j, 1), ubound(input%j, 1)
      call json%create_integer(json_val, input%j(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%a_x)) then
    !'real(dp), DIMENSION(:,:), POINTER   :: a_x,a_y,b_x,b_y,va,vb'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%a_x, 2), ubound(input%a_x, 2)
      call json%create_array(json_list1, 'a_x')
      do i1 = lbound(input%a_x, 1), ubound(input%a_x, 1)
        call json%create_real(json_val, input%a_x(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%a_y)) then
    !'real(dp), DIMENSION(:,:), POINTER   :: a_x,a_y,b_x,b_y,va,vb'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%a_y, 2), ubound(input%a_y, 2)
      call json%create_array(json_list1, 'a_y')
      do i1 = lbound(input%a_y, 1), ubound(input%a_y, 1)
        call json%create_real(json_val, input%a_y(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%b_x)) then
    !'real(dp), DIMENSION(:,:), POINTER   :: a_x,a_y,b_x,b_y,va,vb'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%b_x, 2), ubound(input%b_x, 2)
      call json%create_array(json_list1, 'b_x')
      do i1 = lbound(input%b_x, 1), ubound(input%b_x, 1)
        call json%create_real(json_val, input%b_x(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%b_y)) then
    !'real(dp), DIMENSION(:,:), POINTER   :: a_x,a_y,b_x,b_y,va,vb'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%b_y, 2), ubound(input%b_y, 2)
      call json%create_array(json_list1, 'b_y')
      do i1 = lbound(input%b_y, 1), ubound(input%b_y, 1)
        call json%create_real(json_val, input%b_y(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%va)) then
    !'real(dp), DIMENSION(:,:), POINTER   :: a_x,a_y,b_x,b_y,va,vb'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%va, 2), ubound(input%va, 2)
      call json%create_array(json_list1, 'va')
      do i1 = lbound(input%va, 1), ubound(input%va, 1)
        call json%create_real(json_val, input%va(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%vb)) then
    !'real(dp), DIMENSION(:,:), POINTER   :: a_x,a_y,b_x,b_y,va,vb'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%vb, 2), ubound(input%vb, 2)
      call json%create_array(json_list1, 'vb')
      do i1 = lbound(input%vb, 1), ubound(input%vb, 1)
        call json%create_real(json_val, input%vb(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine B_CYL_to_json
subroutine BEAM_BEAM_NODE_to_json (input, json_root, depth, max_depth)
  use definition, only: BEAM_BEAM_NODE
  implicit none
  type(json_core) :: json
  type (BEAM_BEAM_NODE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%S)) then
    !'REAL(DP), POINTER :: S(:)  => null()'
    call json%create_array(json_list1, 's')
    do i1 = lbound(input%S, 1), ubound(input%S, 1)
      call json%create_real(json_val, input%S(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%SX)) then
    !'REAL(DP), POINTER :: SX(:) => null(),SY(:) => null(),FK(:) => null()'
    call json%create_array(json_list1, 'sx')
    do i1 = lbound(input%SX, 1), ubound(input%SX, 1)
      call json%create_real(json_val, input%SX(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%SY)) then
    !'REAL(DP), POINTER :: SX(:) => null(),SY(:) => null(),FK(:) => null()'
    call json%create_array(json_list1, 'sy')
    do i1 = lbound(input%SY, 1), ubound(input%SY, 1)
      call json%create_real(json_val, input%SY(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FK)) then
    !'REAL(DP), POINTER :: SX(:) => null(),SY(:) => null(),FK(:) => null()'
    call json%create_array(json_list1, 'fk')
    do i1 = lbound(input%FK, 1), ubound(input%FK, 1)
      call json%create_real(json_val, input%FK(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%XM)) then
    !'REAL(DP), POINTER :: XM(:) => null(),YM(:) => null()'
    call json%create_array(json_list1, 'xm')
    do i1 = lbound(input%XM, 1), ubound(input%XM, 1)
      call json%create_real(json_val, input%XM(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%YM)) then
    !'REAL(DP), POINTER :: XM(:) => null(),YM(:) => null()'
    call json%create_array(json_list1, 'ym')
    do i1 = lbound(input%YM, 1), ubound(input%YM, 1)
      call json%create_real(json_val, input%YM(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BBK)) then
    !'REAL(DP), POINTER :: BBK(:,:)  => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%BBK, 2), ubound(input%BBK, 2)
      call json%create_array(json_list1, 'bbk')
      do i1 = lbound(input%BBK, 1), ubound(input%BBK, 1)
        call json%create_real(json_val, input%BBK(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%A)) then
    !'REAL(DP), POINTER :: A(:)  => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%A, 1), ubound(input%A, 1)
      call json%create_real(json_val, input%A(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D)) then
    !'REAL(DP), POINTER :: D(:)  => null()'
    call json%create_array(json_list1, 'd')
    do i1 = lbound(input%D, 1), ubound(input%D, 1)
      call json%create_real(json_val, input%D(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%A_X1)) then
    call json%add(json_root, 'a_x1', int(input%A_X1))
  endif
  if (associated(input%A_X2)) then
    call json%add(json_root, 'a_x2', int(input%A_X2))
  endif
  if (associated(input%PATCH)) then
    call json%add(json_root, 'patch', input%PATCH)
  endif
end subroutine BEAM_BEAM_NODE_to_json
subroutine BEAM_LOCATION_to_json (input, json_root, depth, max_depth)
  use definition, only: BEAM_LOCATION
  implicit none
  type(json_core) :: json
  type (BEAM_LOCATION), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%NODE)) then
    call INTEGRATION_NODE_to_json(input%NODE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'NODE')
    call json%add(json_root, json_val)
  endif
end subroutine BEAM_LOCATION_to_json
subroutine bunch_to_json (input, json_root, depth, max_depth)
  use duan_zhe_map, only: bunch
  implicit none
  type(json_core) :: json
  type (bunch), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! config skip_members: bunch%xs (type, )
  call json%add(json_root, 'n', int(input%n))
  call json%add(json_root, 'r', int(input%r))
  call json%add(json_root, 'reloaded', int(input%reloaded))
  if (associated(input%stable)) then
    !'logical, pointer :: stable(:)'
    call json%create_array(json_list1, 'stable')
    do i1 = lbound(input%stable, 1), ubound(input%stable, 1)
      call json%create_logical(json_val, input%stable(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%turn)) then
    !'real(dp) , pointer :: turn(:)'
    call json%create_array(json_list1, 'turn')
    do i1 = lbound(input%turn, 1), ubound(input%turn, 1)
      call json%create_real(json_val, input%turn(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine bunch_to_json
subroutine c_dalevel_to_json (input, json_root, depth, max_depth)
  use definition, only: c_dalevel
  implicit none
  type(json_core) :: json
  type (c_dalevel), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%CLOSED)) then
    call json%add(json_root, 'closed', input%CLOSED)
  endif
  if (associated(input%PRESENT)) then
    call c_dascratch_to_json(input%PRESENT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PRESENT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END)) then
    call c_dascratch_to_json(input%END, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START)) then
    call c_dascratch_to_json(input%START, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START_GROUND)) then
    call c_dascratch_to_json(input%START_GROUND, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START_GROUND')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END_GROUND)) then
    call c_dascratch_to_json(input%END_GROUND, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END_GROUND')
    call json%add(json_root, json_val)
  endif
end subroutine c_dalevel_to_json
subroutine c_damap_to_json (input, json_root, depth, max_depth)
  use definition, only: c_damap
  implicit none
  type(json_core) :: json
  type (c_damap), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type (c_taylor) v(lnv)'
  call json%create_array(json_list1, 'v')
  do i1 = lbound(input%v, 1), ubound(input%v, 1)
    call c_taylor_to_json(input%v(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call c_quaternion_to_json(input%q, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'q')
  call json%add(json_root, json_val)
  !'complex(dp) e_ij(6,6)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%e_ij, 2), ubound(input%e_ij, 2)
    call json%create_array(json_list1, 'e_ij')
    do i1 = lbound(input%e_ij, 1), ubound(input%e_ij, 1)
      call complex_to_json(input%e_ij(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'n', int(input%n))
  !'complex(dp) x0(lnv)'
  call json%create_array(json_list1, 'x0')
  do i1 = lbound(input%x0, 1), ubound(input%x0, 1)
    call complex_to_json(input%x0(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (associated(input%cm)) then
    !'complex(dpn), pointer :: cm(:,:)=> null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%cm, 2), ubound(input%cm, 2)
      call json%create_array(json_list1, 'cm')
      do i1 = lbound(input%cm, 1), ubound(input%cm, 1)
        call complex_to_json(input%cm(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%m)) then
    !'real(dpn),pointer :: m(:,:)=> null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%m, 2), ubound(input%m, 2)
      call json%create_array(json_list1, 'm')
      do i1 = lbound(input%m, 1), ubound(input%m, 1)
        call json%create_real(json_val, input%m(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  call c_spinmatrix_to_json(input%s, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 's')
  call json%add(json_root, json_val)
end subroutine c_damap_to_json
subroutine c_dascratch_to_json (input, json_root, depth, max_depth)
  use definition, only: c_dascratch
  implicit none
  type(json_core) :: json
  type (c_dascratch), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%t)) then
    call c_taylor_to_json(input%t, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 't')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: c_dascratch%PREVIOUS (TYPE, )
  ! config skip_members: c_dascratch%NEXT (TYPE, )
end subroutine c_dascratch_to_json
subroutine c_factored_lie_to_json (input, json_root, depth, max_depth)
  use definition, only: c_factored_lie
  implicit none
  type(json_core) :: json
  type (c_factored_lie), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'n', int(input%n))
  call json%add(json_root, 'dir', int(input%dir))
  if (associated(input%f)) then
    !'type (c_vector_field), pointer :: f(:)=>null()'
    call json%create_array(json_list1, 'f')
    do i1 = lbound(input%f, 1), ubound(input%f, 1)
      call c_vector_field_to_json(input%f(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine c_factored_lie_to_json
subroutine c_lattice_function_to_json (input, json_root, depth, max_depth)
  use definition, only: c_lattice_function
  implicit none
  type(json_core) :: json
  type (c_lattice_function), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) :: E(3,6,6) =0 ,K(3,6,6) =0'
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%E, 3), ubound(input%E, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%E, 2), ubound(input%E, 2)
      call json%create_array(json_list1, 'e')
      do i1 = lbound(input%E, 1), ubound(input%E, 1)
        call json%create_real(json_val, input%E(i1, i2, i3), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
  !'real(dp) :: E(3,6,6) =0 ,K(3,6,6) =0'
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%K, 3), ubound(input%K, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%K, 2), ubound(input%K, 2)
      call json%create_array(json_list1, 'k')
      do i1 = lbound(input%K, 1), ubound(input%K, 1)
        call json%create_real(json_val, input%K(i1, i2, i3), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
  !'real(dp) :: H(3,6,6) = 0,B(3,6,6) =0'
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%H, 3), ubound(input%H, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%H, 2), ubound(input%H, 2)
      call json%create_array(json_list1, 'h')
      do i1 = lbound(input%H, 1), ubound(input%H, 1)
        call json%create_real(json_val, input%H(i1, i2, i3), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
  !'real(dp) :: H(3,6,6) = 0,B(3,6,6) =0'
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%B, 3), ubound(input%B, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%B, 2), ubound(input%B, 2)
      call json%create_array(json_list1, 'b')
      do i1 = lbound(input%B, 1), ubound(input%B, 1)
        call json%create_real(json_val, input%B(i1, i2, i3), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
  !'real(dp) :: S(1:3,1:3,0:6) =0'
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%S, 3), ubound(input%S, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%S, 2), ubound(input%S, 2)
      call json%create_array(json_list1, 's')
      do i1 = lbound(input%S, 1), ubound(input%S, 1)
        call json%create_real(json_val, input%S(i1, i2, i3), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
  !'real(dp) ::phase(3) =0 ,damping(3) =0 , spin(2) =0'
  call json%create_array(json_list1, 'phase')
  do i1 = lbound(input%phase, 1), ubound(input%phase, 1)
    call json%create_real(json_val, input%phase(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) ::phase(3) =0 ,damping(3) =0 , spin(2) =0'
  call json%create_array(json_list1, 'damping')
  do i1 = lbound(input%damping, 1), ubound(input%damping, 1)
    call json%create_real(json_val, input%damping(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) ::phase(3) =0 ,damping(3) =0 , spin(2) =0'
  call json%create_array(json_list1, 'spin')
  do i1 = lbound(input%spin, 1), ubound(input%spin, 1)
    call json%create_real(json_val, input%spin(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp):: fix(6) =0'
  call json%create_array(json_list1, 'fix')
  do i1 = lbound(input%fix, 1), ubound(input%fix, 1)
    call json%create_real(json_val, input%fix(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (associated(input%f)) then
    call fibre_to_json(input%f, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'f')
    call json%add(json_root, json_val)
  endif
  if (associated(input%t)) then
    call integration_node_to_json(input%t, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 't')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'symplectic', input%symplectic)
  !'real(dp) :: sigmas(6,6)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%sigmas, 2), ubound(input%sigmas, 2)
    call json%create_array(json_list1, 'sigmas')
    do i1 = lbound(input%sigmas, 1), ubound(input%sigmas, 1)
      call json%create_real(json_val, input%sigmas(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine c_lattice_function_to_json
subroutine c_linear_map_to_json (input, json_root, depth, max_depth)
  use definition, only: c_linear_map
  implicit none
  type(json_core) :: json
  type (c_linear_map), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'complex(dp) mat(6,6)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%mat, 2), ubound(input%mat, 2)
    call json%create_array(json_list1, 'mat')
    do i1 = lbound(input%mat, 1), ubound(input%mat, 1)
      call complex_to_json(input%mat(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'complex(dp)  q(0:3,0:6)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%q, 2), ubound(input%q, 2)
    call json%create_array(json_list1, 'q')
    do i1 = lbound(input%q, 1), ubound(input%q, 1)
      call complex_to_json(input%q(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine c_linear_map_to_json
subroutine c_normal_form_to_json (input, json_root, depth, max_depth)
  use definition, only: c_normal_form
  implicit none
  type(json_core) :: json
  type (c_normal_form), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call c_damap_to_json(input%Atot, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'Atot')
  call json%add(json_root, json_val)
  call c_vector_field_to_json(input%H, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'H')
  call json%add(json_root, json_val)
  call c_vector_field_to_json(input%H_l, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'H_l')
  call json%add(json_root, json_val)
  call c_vector_field_to_json(input%H_nl, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'H_nl')
  call json%add(json_root, json_val)
  !'complex(dp) s_ij0(6,6)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%s_ij0, 2), ubound(input%s_ij0, 2)
    call json%create_array(json_list1, 's_ij0')
    do i1 = lbound(input%s_ij0, 1), ubound(input%s_ij0, 1)
      call complex_to_json(input%s_ij0(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'complex(dp) s_ijr(6,6)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%s_ijr, 2), ubound(input%s_ijr, 2)
    call json%create_array(json_list1, 's_ijr')
    do i1 = lbound(input%s_ijr, 1), ubound(input%s_ijr, 1)
      call complex_to_json(input%s_ijr(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'complex(dp) b_ijr(6,6)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%b_ijr, 2), ubound(input%b_ijr, 2)
    call json%create_array(json_list1, 'b_ijr')
    do i1 = lbound(input%b_ijr, 1), ubound(input%b_ijr, 1)
      call complex_to_json(input%b_ijr(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp) emittance(3)'
  call json%create_array(json_list1, 'emittance')
  do i1 = lbound(input%emittance, 1), ubound(input%emittance, 1)
    call json%create_real(json_val, input%emittance(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'nres', int(input%NRES))
  !'integer NRES,M(NDIM2t/2,NRESO),ms(NRESO)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%M, 2), ubound(input%M, 2)
    call json%create_array(json_list1, 'm')
    do i1 = lbound(input%M, 1), ubound(input%M, 1)
      call json%create_integer(json_val, input%M(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'integer NRES,M(NDIM2t/2,NRESO),ms(NRESO)'
  call json%create_array(json_list1, 'ms')
  do i1 = lbound(input%ms, 1), ubound(input%ms, 1)
    call json%create_integer(json_val, input%ms(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) tune(NDIM2t/2),damping(NDIM2t/2),spin_tune,quaternion_angle'
  call json%create_array(json_list1, 'tune')
  do i1 = lbound(input%tune, 1), ubound(input%tune, 1)
    call json%create_real(json_val, input%tune(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) tune(NDIM2t/2),damping(NDIM2t/2),spin_tune,quaternion_angle'
  call json%create_array(json_list1, 'damping')
  do i1 = lbound(input%damping, 1), ubound(input%damping, 1)
    call json%create_real(json_val, input%damping(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'spin_tune', input%spin_tune)
  call json%add(json_root, 'quaternion_angle', input%quaternion_angle)
  call json%add(json_root, 'positive', input%positive)
  call c_damap_to_json(input%a_t, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'a_t')
  call json%add(json_root, json_val)
  call c_damap_to_json(input%a1, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'a1')
  call json%add(json_root, json_val)
  call c_damap_to_json(input%a2, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'a2')
  call json%add(json_root, json_val)
  ! parent pointer skip: g (type, @1 nonlinear part of a in phasors)
  call c_factored_lie_to_json(input%ker, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'ker')
  call json%add(json_root, json_val)
  call c_damap_to_json(input%n, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'n')
  call json%add(json_root, json_val)
  call c_damap_to_json(input%As, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'As')
  call json%add(json_root, json_val)
end subroutine c_normal_form_to_json
subroutine c_quaternion_to_json (input, json_root, depth, max_depth)
  use definition, only: c_quaternion
  implicit none
  type(json_core) :: json
  type (c_quaternion), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type(c_taylor) x(0:3)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call c_taylor_to_json(input%x(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine c_quaternion_to_json
subroutine c_ray_to_json (input, json_root, depth, max_depth)
  use definition, only: c_ray
  implicit none
  type(json_core) :: json
  type (c_ray), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'complex(dp) x(lnv)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call complex_to_json(input%x(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call complex_quaternion_to_json(input%q, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'q')
  call json%add(json_root, json_val)
  call json%add(json_root, 'n', int(input%n))
  !'complex(dp) s1(3),s2(3),s3(3)'
  call json%create_array(json_list1, 's1')
  do i1 = lbound(input%s1, 1), ubound(input%s1, 1)
    call complex_to_json(input%s1(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'complex(dp) s1(3),s2(3),s3(3)'
  call json%create_array(json_list1, 's2')
  do i1 = lbound(input%s2, 1), ubound(input%s2, 1)
    call complex_to_json(input%s2(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'complex(dp) s1(3),s2(3),s3(3)'
  call json%create_array(json_list1, 's3')
  do i1 = lbound(input%s3, 1), ubound(input%s3, 1)
    call complex_to_json(input%s3(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine c_ray_to_json
subroutine c_spinmatrix_to_json (input, json_root, depth, max_depth)
  use definition, only: c_spinmatrix
  implicit none
  type(json_core) :: json
  type (c_spinmatrix), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type(c_taylor) s(3,3)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%s, 2), ubound(input%s, 2)
    call json%create_array(json_list1, 's')
    do i1 = lbound(input%s, 1), ubound(input%s, 1)
      call c_taylor_to_json(input%s(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine c_spinmatrix_to_json
subroutine c_spinor_to_json (input, json_root, depth, max_depth)
  use definition, only: c_spinor
  implicit none
  type(json_core) :: json
  type (c_spinor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type(c_taylor) v(3)'
  call json%create_array(json_list1, 'v')
  do i1 = lbound(input%v, 1), ubound(input%v, 1)
    call c_taylor_to_json(input%v(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine c_spinor_to_json
subroutine C_taylor_to_json (input, json_root, depth, max_depth)
  use definition, only: C_taylor
  implicit none
  type(json_core) :: json
  type (C_taylor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'i', int(input%I))
end subroutine C_taylor_to_json
subroutine c_UNIVERSAL_TAYLOR_to_json (input, json_root, depth, max_depth)
  use definition, only: c_UNIVERSAL_TAYLOR
  implicit none
  type(json_core) :: json
  type (c_UNIVERSAL_TAYLOR), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%NV)) then
    call json%add(json_root, 'nv', int(input%NV))
  endif
  if (associated(input%nd2)) then
    call json%add(json_root, 'nd2', int(input%nd2))
  endif
  if (associated(input%C)) then
    !'complex(DP), POINTER,dimension(:)::C => null()'
    call json%create_array(json_list1, 'c')
    do i1 = lbound(input%C, 1), ubound(input%C, 1)
      call complex_to_json(input%C(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%J)) then
    !'INTEGER, POINTER,dimension(:,:)::J=> null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%J, 2), ubound(input%J, 2)
      call json%create_array(json_list1, 'j')
      do i1 = lbound(input%J, 1), ubound(input%J, 1)
        call json%create_integer(json_val, input%J(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine c_UNIVERSAL_TAYLOR_to_json
subroutine c_vector_field_to_json (input, json_root, depth, max_depth)
  use definition, only: c_vector_field
  implicit none
  type(json_core) :: json
  type (c_vector_field), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'n', int(input%n))
  call json%add(json_root, 'nrmax', int(input%nrmax))
  call json%add(json_root, 'eps', input%eps)
  !'type (c_taylor) v(lnv)'
  call json%create_array(json_list1, 'v')
  do i1 = lbound(input%v, 1), ubound(input%v, 1)
    call c_taylor_to_json(input%v(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call c_quaternion_to_json(input%q, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'q')
  call json%add(json_root, json_val)
  call c_spinmatrix_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'L')
  call json%add(json_root, json_val)
end subroutine c_vector_field_to_json
subroutine c_vector_field_fourier_to_json (input, json_root, depth, max_depth)
  use definition, only: c_vector_field_fourier
  implicit none
  type(json_core) :: json
  type (c_vector_field_fourier), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'n', int(input%n))
  if (associated(input%f)) then
    !'type (c_vector_field), pointer :: f(:)  =>null()'
    call json%create_array(json_list1, 'f')
    do i1 = lbound(input%f, 1), ubound(input%f, 1)
      call c_vector_field_to_json(input%f(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine c_vector_field_fourier_to_json
subroutine c_yu_w_to_json (input, json_root, depth, max_depth)
  use definition, only: c_yu_w
  implicit none
  type(json_core) :: json
  type (c_yu_w), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%w)) then
    !'type (c_taylor),pointer :: w(:,:)=> null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%w, 2), ubound(input%w, 2)
      call json%create_array(json_list1, 'w')
      do i1 = lbound(input%w, 1), ubound(input%w, 1)
        call c_taylor_to_json(input%w(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  call json%add(json_root, 'n', int(input%n))
end subroutine c_yu_w_to_json
subroutine CAV4_to_json (input, json_root, depth, max_depth)
  use definition, only: CAV4
  implicit none
  type(json_core) :: json
  type (CAV4), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%VOLT)) then
    call json%add(json_root, 'volt', input%VOLT)
  endif
  if (associated(input%FREQ)) then
    call json%add(json_root, 'freq', input%FREQ)
  endif
  if (associated(input%PHAS)) then
    call json%add(json_root, 'phas', input%PHAS)
  endif
  if (associated(input%DELTA_E)) then
    call json%add(json_root, 'delta_e', input%DELTA_E)
  endif
  if (associated(input%phase0)) then
    call json%add(json_root, 'phase0', input%phase0)
  endif
  if (associated(input%t)) then
    call json%add(json_root, 't', input%t)
  endif
  if (associated(input%F)) then
    !'real(dp), POINTER :: F(:) => null()'
    call json%create_array(json_list1, 'f')
    do i1 = lbound(input%F, 1), ubound(input%F, 1)
      call json%create_real(json_val, input%F(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%A)) then
    call json%add(json_root, 'a', input%A)
  endif
  if (associated(input%R)) then
    call json%add(json_root, 'r', input%R)
  endif
  if (associated(input%PH)) then
    !'real(dp), POINTER :: PH(:) => null()'
    call json%create_array(json_list1, 'ph')
    do i1 = lbound(input%PH, 1), ubound(input%PH, 1)
      call json%create_real(json_val, input%PH(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%NF)) then
    call json%add(json_root, 'nf', int(input%NF))
  endif
  if (associated(input%N_BESSEL)) then
    call json%add(json_root, 'n_bessel', int(input%N_BESSEL))
  endif
  if (associated(input%CAVITY_TOTALPATH)) then
    call json%add(json_root, 'cavity_totalpath', int(input%CAVITY_TOTALPATH))
  endif
  if (associated(input%always_on)) then
    call json%add(json_root, 'always_on', input%always_on)
  endif
  if (associated(input%xprime)) then
    call json%add(json_root, 'xprime', input%xprime)
  endif
  if (associated(input%ACC)) then
    call acceleration_to_json(input%ACC, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ACC')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H1)) then
    call json%add(json_root, 'h1', input%H1)
  endif
  if (associated(input%H2)) then
    call json%add(json_root, 'h2', input%H2)
  endif
  if (associated(input%AN0)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN0 => null(),BN0 => null()'
    call json%create_array(json_list1, 'an0')
    do i1 = lbound(input%AN0, 1), ubound(input%AN0, 1)
      call json%create_real(json_val, input%AN0(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN0)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN0 => null(),BN0 => null()'
    call json%create_array(json_list1, 'bn0')
    do i1 = lbound(input%BN0, 1), ubound(input%BN0, 1)
      call json%create_real(json_val, input%BN0(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine CAV4_to_json
subroutine CAV4P_to_json (input, json_root, depth, max_depth)
  use definition, only: CAV4P
  implicit none
  type(json_core) :: json
  type (CAV4P), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%VOLT)) then
    call REAL_8_to_json(input%VOLT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VOLT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%FREQ)) then
    call REAL_8_to_json(input%FREQ, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'FREQ')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PHAS)) then
    call REAL_8_to_json(input%PHAS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PHAS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%DELTA_E)) then
    call json%add(json_root, 'delta_e', input%DELTA_E)
  endif
  if (associated(input%phase0)) then
    call json%add(json_root, 'phase0', input%phase0)
  endif
  if (associated(input%t)) then
    call json%add(json_root, 't', input%t)
  endif
  if (associated(input%F)) then
    !'TYPE(REAL_8), POINTER :: F(:) => null()'
    call json%create_array(json_list1, 'f')
    do i1 = lbound(input%F, 1), ubound(input%F, 1)
      call REAL_8_to_json(input%F(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%PH)) then
    !'TYPE(REAL_8), POINTER :: PH(:) => null()'
    call json%create_array(json_list1, 'ph')
    do i1 = lbound(input%PH, 1), ubound(input%PH, 1)
      call REAL_8_to_json(input%PH(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%A)) then
    call REAL_8_to_json(input%A, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'A')
    call json%add(json_root, json_val)
  endif
  if (associated(input%R)) then
    call REAL_8_to_json(input%R, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'R')
    call json%add(json_root, json_val)
  endif
  if (associated(input%NF)) then
    call json%add(json_root, 'nf', int(input%NF))
  endif
  if (associated(input%N_BESSEL)) then
    call json%add(json_root, 'n_bessel', int(input%N_BESSEL))
  endif
  if (associated(input%CAVITY_TOTALPATH)) then
    call json%add(json_root, 'cavity_totalpath', int(input%CAVITY_TOTALPATH))
  endif
  if (associated(input%always_on)) then
    call json%add(json_root, 'always_on', input%always_on)
  endif
  if (associated(input%xprime)) then
    call json%add(json_root, 'xprime', input%xprime)
  endif
  if (associated(input%ACC)) then
    call acceleration_to_json(input%ACC, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ACC')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H1)) then
    call REAL_8_to_json(input%H1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H2)) then
    call REAL_8_to_json(input%H2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN0)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN0 => null(),BN0 => null()'
    call json%create_array(json_list1, 'an0')
    do i1 = lbound(input%AN0, 1), ubound(input%AN0, 1)
      call REAL_8_to_json(input%AN0(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN0)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN0 => null(),BN0 => null()'
    call json%create_array(json_list1, 'bn0')
    do i1 = lbound(input%BN0, 1), ubound(input%BN0, 1)
      call REAL_8_to_json(input%BN0(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine CAV4P_to_json
subroutine cav_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: cav_list
  implicit none
  type(json_core) :: json
  type (cav_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'n_bessel', int(input%N_BESSEL))
  call json%add(json_root, 'nf', int(input%NF))
  call json%add(json_root, 'cavity_totalpath', int(input%CAVITY_TOTALPATH))
  call json%add(json_root, 'phase0', input%phase0)
  call json%add(json_root, 't', input%t)
  call json%add(json_root, 'always_on', input%always_on)
  call json%add(json_root, 'xprime', input%xprime)
  !'real(dp) F(harm_max)'
  call json%create_array(json_list1, 'f')
  do i1 = lbound(input%F, 1), ubound(input%F, 1)
    call json%create_real(json_val, input%F(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) PH(harm_max)'
  call json%create_array(json_list1, 'ph')
  do i1 = lbound(input%PH, 1), ubound(input%PH, 1)
    call json%create_real(json_val, input%PH(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'a', input%A)
  call json%add(json_root, 'r', input%R)
end subroutine cav_list_to_json
subroutine CAV_TRAV_to_json (input, json_root, depth, max_depth)
  use definition, only: CAV_TRAV
  implicit none
  type(json_core) :: json
  type (CAV_TRAV), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%VOLT)) then
    call json%add(json_root, 'volt', input%VOLT)
  endif
  if (associated(input%FREQ)) then
    call json%add(json_root, 'freq', input%FREQ)
  endif
  if (associated(input%PHAS)) then
    call json%add(json_root, 'phas', input%PHAS)
  endif
  if (associated(input%DELTA_E)) then
    call json%add(json_root, 'delta_e', input%DELTA_E)
  endif
  if (associated(input%phase0)) then
    call json%add(json_root, 'phase0', input%phase0)
  endif
  if (associated(input%PSI)) then
    call json%add(json_root, 'psi', input%PSI)
  endif
  if (associated(input%DPHAS)) then
    call json%add(json_root, 'dphas', input%DPHAS)
  endif
  if (associated(input%DVDS)) then
    call json%add(json_root, 'dvds', input%DVDS)
  endif
  if (associated(input%always_on)) then
    call json%add(json_root, 'always_on', input%always_on)
  endif
  if (associated(input%implicit)) then
    call json%add(json_root, 'implicit', input%implicit)
  endif
  if (associated(input%CAVITY_TOTALPATH)) then
    call json%add(json_root, 'cavity_totalpath', int(input%CAVITY_TOTALPATH))
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine CAV_TRAV_to_json
subroutine CAV_TRAVP_to_json (input, json_root, depth, max_depth)
  use definition, only: CAV_TRAVP
  implicit none
  type(json_core) :: json
  type (CAV_TRAVP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VOLT)) then
    call REAL_8_to_json(input%VOLT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VOLT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%FREQ)) then
    call REAL_8_to_json(input%FREQ, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'FREQ')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PHAS)) then
    call REAL_8_to_json(input%PHAS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PHAS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PSI)) then
    call REAL_8_to_json(input%PSI, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PSI')
    call json%add(json_root, json_val)
  endif
  if (associated(input%DPHAS)) then
    call REAL_8_to_json(input%DPHAS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'DPHAS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%DVDS)) then
    call REAL_8_to_json(input%DVDS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'DVDS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%DELTA_E)) then
    call json%add(json_root, 'delta_e', input%DELTA_E)
  endif
  if (associated(input%phase0)) then
    call json%add(json_root, 'phase0', input%phase0)
  endif
  if (associated(input%always_on)) then
    call json%add(json_root, 'always_on', input%always_on)
  endif
  if (associated(input%implicit)) then
    call json%add(json_root, 'implicit', input%implicit)
  endif
  if (associated(input%CAVITY_TOTALPATH)) then
    call json%add(json_root, 'cavity_totalpath', int(input%CAVITY_TOTALPATH))
  endif
  if (associated(input%AN)) then
    !'type(real_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call real_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'type(real_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call real_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine CAV_TRAVP_to_json
subroutine CHART_to_json (input, json_root, depth, max_depth)
  use definition, only: CHART
  implicit none
  type(json_core) :: json
  type (CHART), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%f)) then
    call magnet_frame_to_json(input%f, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'f')
    call json%add(json_root, json_val)
  endif
  if (associated(input%D_IN)) then
    !'real(dp),dimension(:),  POINTER::   D_IN => null() ,ANG_IN => null()'
    call json%create_array(json_list1, 'd_in')
    do i1 = lbound(input%D_IN, 1), ubound(input%D_IN, 1)
      call json%create_real(json_val, input%D_IN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ANG_IN)) then
    !'real(dp),dimension(:),  POINTER::   D_IN => null() ,ANG_IN => null()'
    call json%create_array(json_list1, 'ang_in')
    do i1 = lbound(input%ANG_IN, 1), ubound(input%ANG_IN, 1)
      call json%create_real(json_val, input%ANG_IN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D_OUT)) then
    !'real(dp),dimension(:),  POINTER::   D_OUT => null() ,ANG_OUT => null()'
    call json%create_array(json_list1, 'd_out')
    do i1 = lbound(input%D_OUT, 1), ubound(input%D_OUT, 1)
      call json%create_real(json_val, input%D_OUT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ANG_OUT)) then
    !'real(dp),dimension(:),  POINTER::   D_OUT => null() ,ANG_OUT => null()'
    call json%create_array(json_list1, 'ang_out')
    do i1 = lbound(input%ANG_OUT, 1), ubound(input%ANG_OUT, 1)
      call json%create_real(json_val, input%ANG_OUT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine CHART_to_json
subroutine CHARTlist_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: CHARTlist
  implicit none
  type(json_core) :: json
  type (CHARTlist), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) D_IN(3),D_OUT(3),ANG_IN(3),ANG_OUT(3)'
  call json%create_array(json_list1, 'd_in')
  do i1 = lbound(input%D_IN, 1), ubound(input%D_IN, 1)
    call json%create_real(json_val, input%D_IN(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) D_IN(3),D_OUT(3),ANG_IN(3),ANG_OUT(3)'
  call json%create_array(json_list1, 'd_out')
  do i1 = lbound(input%D_OUT, 1), ubound(input%D_OUT, 1)
    call json%create_real(json_val, input%D_OUT(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) D_IN(3),D_OUT(3),ANG_IN(3),ANG_OUT(3)'
  call json%create_array(json_list1, 'ang_in')
  do i1 = lbound(input%ANG_IN, 1), ubound(input%ANG_IN, 1)
    call json%create_real(json_val, input%ANG_IN(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) D_IN(3),D_OUT(3),ANG_IN(3),ANG_OUT(3)'
  call json%create_array(json_list1, 'ang_out')
  do i1 = lbound(input%ANG_OUT, 1), ubound(input%ANG_OUT, 1)
    call json%create_real(json_val, input%ANG_OUT(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine CHARTlist_to_json
subroutine complex_8_to_json (input, json_root, depth, max_depth)
  use definition, only: complex_8
  implicit none
  type(json_core) :: json
  type (complex_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call complextaylor_to_json(input%t, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 't')
  call json%add(json_root, json_val)
  call complex_to_json(input%r, json_list1, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_list1, 'r')
  call json%add(json_root, json_list1)
  call json%add(json_root, 'alloc', input%alloc)
  call json%add(json_root, 'kind', int(input%kind))
  call json%add(json_root, 'i', int(input%i))
  call json%add(json_root, 'j', int(input%j))
  call complex_to_json(input%s, json_list1, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_list1, 's')
  call json%add(json_root, json_list1)
end subroutine complex_8_to_json
subroutine complex_quaternion_to_json (input, json_root, depth, max_depth)
  use definition, only: complex_quaternion
  implicit none
  type(json_core) :: json
  type (complex_quaternion), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'complex(dp) x(0:3)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call complex_to_json(input%x(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine complex_quaternion_to_json
subroutine complextaylor_to_json (input, json_root, depth, max_depth)
  use definition, only: complextaylor
  implicit none
  type(json_core) :: json
  type (complextaylor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call taylor_to_json(input%r, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'r')
  call json%add(json_root, json_val)
  call taylor_to_json(input%i, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'i')
  call json%add(json_root, json_val)
end subroutine complextaylor_to_json
subroutine CONTROL_to_json (input, json_root, depth, max_depth)
  use precision_constants, only: CONTROL
  implicit none
  type(json_core) :: json
  type (CONTROL), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%total_da_size)) then
    call json%add(json_root, 'total_da_size', input%total_da_size)
  endif
  if (associated(input%lda_used)) then
    call json%add(json_root, 'lda_used', int(input%lda_used))
  endif
  if (associated(input%OLD)) then
    call json%add(json_root, 'old', input%OLD)
  endif
  if (associated(input%real_warning)) then
    call json%add(json_root, 'real_warning', input%real_warning)
  endif
  if (associated(input%no)) then
    call json%add(json_root, 'no', int(input%no))
  endif
  if (associated(input%nv)) then
    call json%add(json_root, 'nv', int(input%nv))
  endif
  if (associated(input%nd)) then
    call json%add(json_root, 'nd', int(input%nd))
  endif
  if (associated(input%nd2)) then
    call json%add(json_root, 'nd2', int(input%nd2))
  endif
  if (associated(input%np)) then
    call json%add(json_root, 'np', int(input%np))
  endif
  if (associated(input%nspin)) then
    call json%add(json_root, 'nspin', int(input%nspin))
  endif
  if (associated(input%ndpt)) then
    call json%add(json_root, 'ndpt', int(input%ndpt))
  endif
  if (associated(input%ndptb)) then
    call json%add(json_root, 'ndptb', int(input%ndptb))
  endif
  if (associated(input%NPARA)) then
    call json%add(json_root, 'npara', int(input%NPARA))
  endif
  if (associated(input%npara_fpp)) then
    call json%add(json_root, 'npara_fpp', int(input%npara_fpp))
  endif
  if (associated(input%np_pol)) then
    call json%add(json_root, 'np_pol', int(input%np_pol))
  endif
  if (associated(input%nd2t)) then
    call json%add(json_root, 'nd2t', int(input%nd2t))
  endif
  if (associated(input%nd2harm)) then
    call json%add(json_root, 'nd2harm', int(input%nd2harm))
  endif
  if (associated(input%ndc2t)) then
    call json%add(json_root, 'ndc2t', int(input%ndc2t))
  endif
  if (associated(input%pos_of_delta)) then
    call json%add(json_root, 'pos_of_delta', int(input%pos_of_delta))
  endif
  if (associated(input%rf)) then
    call json%add(json_root, 'rf', int(input%rf))
  endif
  if (associated(input%knob)) then
    call json%add(json_root, 'knob', input%knob)
  endif
  if (associated(input%valishev)) then
    call json%add(json_root, 'valishev', input%valishev)
  endif
  if (associated(input%setknob)) then
    call json%add(json_root, 'setknob', input%setknob)
  endif
  if (associated(input%da_absolute_aperture)) then
    call json%add(json_root, 'da_absolute_aperture', input%da_absolute_aperture)
  endif
  if (associated(input%wherelost)) then
    call json%add(json_root, 'wherelost', int(input%wherelost))
  endif
  if (associated(input%ROOT_CHECK)) then
    call json%add(json_root, 'root_check', input%ROOT_CHECK)
  endif
  if (associated(input%CHECK_STABLE)) then
    call json%add(json_root, 'check_stable', input%CHECK_STABLE)
  endif
  if (associated(input%CHECK_MADX_APERTURE)) then
    call json%add(json_root, 'check_madx_aperture', input%CHECK_MADX_APERTURE)
  endif
  if (associated(input%APERTURE_FLAG)) then
    call json%add(json_root, 'aperture_flag', input%APERTURE_FLAG)
  endif
  if (associated(input%s_aperture_CHECK)) then
    call json%add(json_root, 's_aperture_check', input%s_aperture_CHECK)
  endif
  if (associated(input%WATCH_USER)) then
    call json%add(json_root, 'watch_user', input%WATCH_USER)
  endif
  if (associated(input%absolute_aperture)) then
    call json%add(json_root, 'absolute_aperture', input%absolute_aperture)
  endif
  if (associated(input%hyperbolic_aperture)) then
    call json%add(json_root, 'hyperbolic_aperture', input%hyperbolic_aperture)
  endif
  if (associated(input%MADTHICK)) then
    call json%add(json_root, 'madthick', int(input%MADTHICK))
  endif
  if (associated(input%MADTHIN_NORMAL)) then
    call json%add(json_root, 'madthin_normal', int(input%MADTHIN_NORMAL))
  endif
  if (associated(input%MADTHIN_SKEW)) then
    call json%add(json_root, 'madthin_skew', int(input%MADTHIN_SKEW))
  endif
  if (associated(input%NSTD)) then
    call json%add(json_root, 'nstd', int(input%NSTD))
  endif
  if (associated(input%METD)) then
    call json%add(json_root, 'metd', int(input%METD))
  endif
  if (associated(input%MADLENGTH)) then
    call json%add(json_root, 'madlength', input%MADLENGTH)
  endif
  if (associated(input%MAD)) then
    call json%add(json_root, 'mad', input%MAD)
  endif
  if (associated(input%EXACT_MODEL)) then
    call json%add(json_root, 'exact_model', input%EXACT_MODEL)
  endif
  if (associated(input%ALWAYS_EXACTMIS)) then
    call json%add(json_root, 'always_exactmis', input%ALWAYS_EXACTMIS)
  endif
  if (associated(input%ALWAYS_knobs)) then
    call json%add(json_root, 'always_knobs', input%ALWAYS_knobs)
  endif
  if (associated(input%recirculator_cheat)) then
    call json%add(json_root, 'recirculator_cheat', input%recirculator_cheat)
  endif
  if (associated(input%sixtrack_compatible)) then
    call json%add(json_root, 'sixtrack_compatible', input%sixtrack_compatible)
  endif
  if (associated(input%CAVITY_TOTALPATH)) then
    call json%add(json_root, 'cavity_totalpath', int(input%CAVITY_TOTALPATH))
  endif
  if (associated(input%HIGHEST_FRINGE)) then
    call json%add(json_root, 'highest_fringe', int(input%HIGHEST_FRINGE))
  endif
  if (associated(input%do_beam_beam)) then
    call json%add(json_root, 'do_beam_beam', input%do_beam_beam)
  endif
  if (associated(input%FIBRE_DIR)) then
    call json%add(json_root, 'fibre_dir', int(input%FIBRE_DIR))
  endif
  if (associated(input%INITIAL_CHARGE)) then
    call json%add(json_root, 'initial_charge', input%INITIAL_CHARGE)
  endif
  if (associated(input%FIBRE_flip)) then
    call json%add(json_root, 'fibre_flip', input%FIBRE_flip)
  endif
  if (associated(input%eps_pos)) then
    call json%add(json_root, 'eps_pos', input%eps_pos)
  endif
  if (associated(input%SECTOR_NMUL_MAX)) then
    call json%add(json_root, 'sector_nmul_max', int(input%SECTOR_NMUL_MAX))
  endif
  if (associated(input%SECTOR_NMUL)) then
    call json%add(json_root, 'sector_nmul', int(input%SECTOR_NMUL))
  endif
  if (associated(input%wedge_coeff)) then
    !'real(dp), pointer :: wedge_coeff(:) => null()'
    call json%create_array(json_list1, 'wedge_coeff')
    do i1 = lbound(input%wedge_coeff, 1), ubound(input%wedge_coeff, 1)
      call json%create_real(json_val, input%wedge_coeff(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%MAD8_WEDGE)) then
    call json%add(json_root, 'mad8_wedge', input%MAD8_WEDGE)
  endif
  if (associated(input%electron)) then
    call json%add(json_root, 'electron', input%electron)
  endif
  if (associated(input%massfactor)) then
    call json%add(json_root, 'massfactor', input%massfactor)
  endif
  if (associated(input%compute_stoch_kick)) then
    call json%add(json_root, 'compute_stoch_kick', input%compute_stoch_kick)
  endif
  if (associated(input%FEED_P0C)) then
    call json%add(json_root, 'feed_p0c', input%FEED_P0C)
  endif
  if (associated(input%ALWAYS_EXACT_PATCHING)) then
    call json%add(json_root, 'always_exact_patching', input%ALWAYS_EXACT_PATCHING)
  endif
  if (associated(input%stable_da)) then
    call json%add(json_root, 'stable_da', input%stable_da)
  endif
  if (associated(input%STABLE_DA_pancake)) then
    call json%add(json_root, 'stable_da_pancake', input%STABLE_DA_pancake)
  endif
  if (associated(input%check_da)) then
    call json%add(json_root, 'check_da', input%check_da)
  endif
  if (associated(input%OLD_IMPLEMENTATION_OF_SIXTRACK)) then
    call json%add(json_root, 'old_implementation_of_sixtrack', input%OLD_IMPLEMENTATION_OF_SIXTRACK)
  endif
  if (associated(input%phase0)) then
    call json%add(json_root, 'phase0', input%phase0)
  endif
  if (associated(input%global_verbose)) then
    call json%add(json_root, 'global_verbose', input%global_verbose)
  endif
  if (associated(input%no_hyperbolic_in_normal_form)) then
    call json%add(json_root, 'no_hyperbolic_in_normal_form', input%no_hyperbolic_in_normal_form)
  endif
  if (associated(input%ndpt_bmad)) then
    call json%add(json_root, 'ndpt_bmad', int(input%ndpt_bmad))
  endif
end subroutine CONTROL_to_json
subroutine dalevel_to_json (input, json_root, depth, max_depth)
  use definition, only: dalevel
  implicit none
  type(json_core) :: json
  type (dalevel), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%CLOSED)) then
    call json%add(json_root, 'closed', input%CLOSED)
  endif
  if (associated(input%PRESENT)) then
    call dascratch_to_json(input%PRESENT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PRESENT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END)) then
    call dascratch_to_json(input%END, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START)) then
    call dascratch_to_json(input%START, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START_GROUND)) then
    call dascratch_to_json(input%START_GROUND, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START_GROUND')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END_GROUND)) then
    call dascratch_to_json(input%END_GROUND, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END_GROUND')
    call json%add(json_root, json_val)
  endif
end subroutine dalevel_to_json
subroutine DAMAP_to_json (input, json_root, depth, max_depth)
  use definition, only: DAMAP
  implicit none
  type(json_core) :: json
  type (DAMAP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'TYPE (TAYLOR) V(ndim2)'
  call json%create_array(json_list1, 'v')
  do i1 = lbound(input%V, 1), ubound(input%V, 1)
    call TAYLOR_to_json(input%V(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine DAMAP_to_json
subroutine dascratch_to_json (input, json_root, depth, max_depth)
  use definition, only: dascratch
  implicit none
  type(json_core) :: json
  type (dascratch), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%t)) then
    call taylor_to_json(input%t, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 't')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: dascratch%PREVIOUS (TYPE, )
  ! config skip_members: dascratch%NEXT (TYPE, )
end subroutine dascratch_to_json
subroutine DKD2_to_json (input, json_root, depth, max_depth)
  use definition, only: DKD2
  implicit none
  type(json_core) :: json
  type (DKD2), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(),HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call json%create_real(json_val, input%FINT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(),HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call json%create_real(json_val, input%HGAP(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call json%add(json_root, 'h1', input%H1)
  endif
  if (associated(input%H2)) then
    call json%add(json_root, 'h2', input%H2)
  endif
  if (associated(input%VA)) then
    call json%add(json_root, 'va', input%VA)
  endif
  if (associated(input%VS)) then
    call json%add(json_root, 'vs', input%VS)
  endif
  if (associated(input%f)) then
    call json%add(json_root, 'f', int(input%f))
  endif
end subroutine DKD2_to_json
subroutine DKD2P_to_json (input, json_root, depth, max_depth)
  use definition, only: DKD2P
  implicit none
  type(json_core) :: json
  type (DKD2P), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(),HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call REAL_8_to_json(input%FINT(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(),HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call REAL_8_to_json(input%HGAP(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call REAL_8_to_json(input%H1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H2)) then
    call REAL_8_to_json(input%H2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VA)) then
    call REAL_8_to_json(input%VA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VS)) then
    call REAL_8_to_json(input%VS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%f)) then
    call json%add(json_root, 'f', int(input%f))
  endif
end subroutine DKD2P_to_json
subroutine DRAGTFINN_to_json (input, json_root, depth, max_depth)
  use definition, only: DRAGTFINN
  implicit none
  type(json_core) :: json
  type (DRAGTFINN), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp)  constant(ndim2)'
  call json%create_array(json_list1, 'constant')
  do i1 = lbound(input%constant, 1), ubound(input%constant, 1)
    call json%create_real(json_val, input%constant(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call damap_to_json(input%Linear, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'Linear')
  call json%add(json_root, json_val)
  call vecfield_to_json(input%nonlinear, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'nonlinear')
  call json%add(json_root, json_val)
  call pbfield_to_json(input%pb, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'pb')
  call json%add(json_root, json_val)
end subroutine DRAGTFINN_to_json
subroutine DRIFT1_to_json (input, json_root, depth, max_depth)
  use definition, only: DRIFT1
  implicit none
  type(json_core) :: json
  type (DRIFT1), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
end subroutine DRIFT1_to_json
subroutine DRIFT1P_to_json (input, json_root, depth, max_depth)
  use definition, only: DRIFT1P
  implicit none
  type(json_core) :: json
  type (DRIFT1P), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
end subroutine DRIFT1P_to_json
subroutine E_BEAM_to_json (input, json_root, depth, max_depth)
  use definition, only: E_BEAM
  implicit none
  type(json_core) :: json
  type (E_BEAM), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'n', int(input%N))
  if (associated(input%Z)) then
    !'type(probe), POINTER :: Z(:)  => null()'
    call json%create_array(json_list1, 'z')
    do i1 = lbound(input%Z, 1), ubound(input%Z, 1)
      call probe_to_json(input%Z(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine E_BEAM_to_json
subroutine E_GENERAL_to_json (input, json_root, depth, max_depth)
  use s_euclidean, only: E_GENERAL
  implicit none
  type(json_core) :: json
  type (E_GENERAL), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'kind', int(input%KIND))
  call R_XY_to_json(input%T1, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'T1')
  call json%add(json_root, json_val)
  call R_Z_to_json(input%T2, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'T2')
  call json%add(json_root, json_val)
  call T_XYZ_to_json(input%T3, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'T3')
  call json%add(json_root, json_val)
end subroutine E_GENERAL_to_json
subroutine ECOL_to_json (input, json_root, depth, max_depth)
  use definition, only: ECOL
  implicit none
  type(json_core) :: json
  type (ECOL), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
end subroutine ECOL_to_json
subroutine ECOLP_to_json (input, json_root, depth, max_depth)
  use definition, only: ECOLP
  implicit none
  type(json_core) :: json
  type (ECOLP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
end subroutine ECOLP_to_json
subroutine EL_LIST_to_json (input, json_root, depth, max_depth)
  use mad_like, only: EL_LIST
  implicit none
  type(json_core) :: json
  type (EL_LIST), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'l', input%L)
  call json%add(json_root, 'ld', input%LD)
  call json%add(json_root, 'lc', input%LC)
  !'real(dp) L,LD,LC,K(NMAX),KS(NMAX)'
  call json%create_array(json_list1, 'k')
  do i1 = lbound(input%K, 1), ubound(input%K, 1)
    call json%create_real(json_val, input%K(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) L,LD,LC,K(NMAX),KS(NMAX)'
  call json%create_array(json_list1, 'ks')
  do i1 = lbound(input%KS, 1), ubound(input%KS, 1)
    call json%create_real(json_val, input%KS(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) ang(3),t(3)'
  call json%create_array(json_list1, 'ang')
  do i1 = lbound(input%ang, 1), ubound(input%ang, 1)
    call json%create_real(json_val, input%ang(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) ang(3),t(3)'
  call json%create_array(json_list1, 't')
  do i1 = lbound(input%t, 1), ubound(input%t, 1)
    call json%create_real(json_val, input%t(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) angi(3),ti(3)'
  call json%create_array(json_list1, 'angi')
  do i1 = lbound(input%angi, 1), ubound(input%angi, 1)
    call json%create_real(json_val, input%angi(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) angi(3),ti(3)'
  call json%create_array(json_list1, 'ti')
  do i1 = lbound(input%ti, 1), ubound(input%ti, 1)
    call json%create_real(json_val, input%ti(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'patchg', int(input%patchg))
  call json%add(json_root, 'cavity_totalpath', int(input%CAVITY_TOTALPATH))
  call json%add(json_root, 't1', input%T1)
  call json%add(json_root, 't2', input%T2)
  call json%add(json_root, 'b0', input%B0)
  call json%add(json_root, 'volt', input%volt)
  call json%add(json_root, 'freq0', input%freq0)
  call json%add(json_root, 'harmon', input%harmon)
  call json%add(json_root, 'lag', input%lag)
  call json%add(json_root, 'delta_e', input%DELTA_E)
  call json%add(json_root, 'bsol', input%BSOL)
  call json%add(json_root, 'tilt', input%tilt)
  call json%add(json_root, 'fint', input%FINT)
  call json%add(json_root, 'hgap', input%hgap)
  call json%add(json_root, 'fint2', input%FINT2)
  call json%add(json_root, 'hgap2', input%hgap2)
  call json%add(json_root, 'h1', input%h1)
  call json%add(json_root, 'h2', input%h2)
  call json%add(json_root, 'x_col', input%X_COL)
  call json%add(json_root, 'y_col', input%Y_COL)
  call json%add(json_root, 'thin_h_foc', input%thin_h_foc)
  call json%add(json_root, 'thin_v_foc', input%thin_v_foc)
  call json%add(json_root, 'thin_h_angle', input%thin_h_angle)
  call json%add(json_root, 'thin_v_angle', input%thin_v_angle)
  call json%add(json_root, 'hf', input%hf)
  call json%add(json_root, 'vf', input%vf)
  call json%add(json_root, 'ls', input%ls)
  call json%add(json_root, 'file', trim(input%file))
  call json%add(json_root, 'file_rev', trim(input%file_rev))
  call json%add(json_root, 'name', trim(input%NAME))
  call json%add(json_root, 'vorname', trim(input%VORNAME))
  call json%add(json_root, 'kind', int(input%KIND))
  call json%add(json_root, 'nmul', int(input%nmul))
  call json%add(json_root, 'nst', int(input%nst))
  call json%add(json_root, 'method', int(input%method))
  call json%add(json_root, 'aperture_on', input%APERTURE_ON)
  call json%add(json_root, 'aperture_kind', int(input%APERTURE_KIND))
  !'REAL(DP) APERTURE_R(2),APERTURE_X,APERTURE_Y,APERTURE_DX,APERTURE_DY'
  call json%create_array(json_list1, 'aperture_r')
  do i1 = lbound(input%APERTURE_R, 1), ubound(input%APERTURE_R, 1)
    call json%create_real(json_val, input%APERTURE_R(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'aperture_x', input%APERTURE_X)
  call json%add(json_root, 'aperture_y', input%APERTURE_Y)
  call json%add(json_root, 'aperture_dx', input%APERTURE_DX)
  call json%add(json_root, 'aperture_dy', input%APERTURE_DY)
  call json%add(json_root, 'aperture_polygn', int(input%APERTURE_POLYGN))
  if (associated(input%APERTURE_POLYGX)) then
    !'REAL(DP), pointer, dimension (:) :: APERTURE_POLYGX => null()'
    call json%create_array(json_list1, 'aperture_polygx')
    do i1 = lbound(input%APERTURE_POLYGX, 1), ubound(input%APERTURE_POLYGX, 1)
      call json%create_real(json_val, input%APERTURE_POLYGX(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%APERTURE_POLYGY)) then
    !'REAL(DP), pointer, dimension (:) :: APERTURE_POLYGY => null()'
    call json%create_array(json_list1, 'aperture_polygy')
    do i1 = lbound(input%APERTURE_POLYGY, 1), ubound(input%APERTURE_POLYGY, 1)
      call json%create_real(json_val, input%APERTURE_POLYGY(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'kill_ent_fringe', input%KILL_ENT_FRINGE)
  call json%add(json_root, 'kill_exi_fringe', input%KILL_EXI_FRINGE)
  call json%add(json_root, 'bend_fringe', input%BEND_FRINGE)
  call json%add(json_root, 'kill_ent_spin', input%KILL_ENT_SPIN)
  call json%add(json_root, 'kill_exi_spin', input%KILL_EXI_SPIN)
  call json%add(json_root, 'permfringe', int(input%PERMFRINGE))
  call json%add(json_root, 'highest_fringe', int(input%highest_fringe))
  call json%add(json_root, 'dphas', input%DPHAS)
  call json%add(json_root, 'psi', input%PSI)
  call json%add(json_root, 'dvds', input%dvds)
  call json%add(json_root, 'usethin', input%usethin)
  call json%add(json_root, 'n_bessel', int(input%N_BESSEL))
  call json%add(json_root, 'n_ac', int(input%n_ac))
  !'REAL(DP) d_bn(NMAX), d_an(NMAX)'
  call json%create_array(json_list1, 'd_bn')
  do i1 = lbound(input%d_bn, 1), ubound(input%d_bn, 1)
    call json%create_real(json_val, input%d_bn(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'REAL(DP) d_bn(NMAX), d_an(NMAX)'
  call json%create_array(json_list1, 'd_an')
  do i1 = lbound(input%d_an, 1), ubound(input%d_an, 1)
    call json%create_real(json_val, input%d_an(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'd_volt', input%d_volt)
  call json%add(json_root, 'd_phas', input%d_phas)
  call json%add(json_root, 'd_ac', input%D_ac)
  call json%add(json_root, 'dc_ac', input%DC_ac)
  call json%add(json_root, 'a_ac', input%A_ac)
  call json%add(json_root, 'clockno_ac', int(input%clockno_ac))
  call json%add(json_root, 'theta_ac', input%theta_ac)
end subroutine EL_LIST_to_json
subroutine ele_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: ele_list
  implicit none
  type(json_core) :: json
  type (ele_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'kind', int(input%KIND))
  !'character(nlp) name_vorname(2)'
  call json%create_array(json_list1, 'name_vorname')
  do i1 = lbound(input%name_vorname, 1), ubound(input%name_vorname, 1)
    call json%create_string(json_val, trim(input%name_vorname(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'l', input%L)
  call json%add(json_root, 'b_sol', input%B_SOL)
  !'real(dp) an(nmul_max)'
  call json%create_array(json_list1, 'an')
  do i1 = lbound(input%an, 1), ubound(input%an, 1)
    call json%create_real(json_val, input%an(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) bn(nmul_max)'
  call json%create_array(json_list1, 'bn')
  do i1 = lbound(input%bn, 1), ubound(input%bn, 1)
    call json%create_real(json_val, input%bn(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) VOLT_FREQ_PHAS(3)'
  call json%create_array(json_list1, 'volt_freq_phas')
  do i1 = lbound(input%VOLT_FREQ_PHAS, 1), ubound(input%VOLT_FREQ_PHAS, 1)
    call json%create_real(json_val, input%VOLT_FREQ_PHAS(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'thin', input%THIN)
  !'real(dp) fint_hgap_h1_h2_va_vs(8)'
  call json%create_array(json_list1, 'fint_hgap_h1_h2_va_vs')
  do i1 = lbound(input%fint_hgap_h1_h2_va_vs, 1), ubound(input%fint_hgap_h1_h2_va_vs, 1)
    call json%create_real(json_val, input%fint_hgap_h1_h2_va_vs(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'logical(lp) recut_even_electric_MIS(4)'
  call json%create_array(json_list1, 'recut_even_electric_mis')
  do i1 = lbound(input%recut_even_electric_MIS, 1), ubound(input%recut_even_electric_MIS, 1)
    call json%create_logical(json_val, input%recut_even_electric_MIS(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'slow_ac', int(input%slow_ac))
  !'logical(lp) usebf_do1bf(4)'
  call json%create_array(json_list1, 'usebf_do1bf')
  do i1 = lbound(input%usebf_do1bf, 1), ubound(input%usebf_do1bf, 1)
    call json%create_logical(json_val, input%usebf_do1bf(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'integer skipptcbf(2)'
  call json%create_array(json_list1, 'skipptcbf')
  do i1 = lbound(input%skipptcbf, 1), ubound(input%skipptcbf, 1)
    call json%create_integer(json_val, input%skipptcbf(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'filef', trim(input%filef))
  call json%add(json_root, 'fileb', trim(input%fileb))
end subroutine ele_list_to_json
subroutine ELEMENT_to_json (input, json_root, depth, max_depth)
  use definition, only: ELEMENT
  implicit none
  type(json_core) :: json
  type (ELEMENT), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%KIND)) then
    call json%add(json_root, 'kind', int(input%KIND))
  endif
  if (associated(input%old_integrator)) then
    call json%add(json_root, 'old_integrator', int(input%old_integrator))
  endif
  if (associated(input%recut)) then
    call json%add(json_root, 'recut', input%recut)
  endif
  if (associated(input%even)) then
    call json%add(json_root, 'even', input%even)
  endif
  if (associated(input%probe)) then
    call json%add(json_root, 'probe', input%probe)
  endif
  if (associated(input%PLOT)) then
    call json%add(json_root, 'plot', input%PLOT)
  endif
  if (associated(input%electric)) then
    call json%add(json_root, 'electric', input%electric)
  endif
  if (associated(input%filef)) then
    call json%add(json_root, 'filef', trim(input%filef))
  endif
  if (associated(input%fileb)) then
    call json%add(json_root, 'fileb', trim(input%fileb))
  endif
  ! parent pointer skip: P (type, )
  if (associated(input%NAME)) then
    call json%add(json_root, 'name', trim(input%NAME))
  endif
  if (associated(input%VORNAME)) then
    call json%add(json_root, 'vorname', trim(input%VORNAME))
  endif
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%AN)) then
    !'real(dp),   DIMENSION(:), POINTER:: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),   DIMENSION(:), POINTER:: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(),HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call json%create_real(json_val, input%FINT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(),HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call json%create_real(json_val, input%HGAP(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call json%add(json_root, 'h1', input%H1)
  endif
  if (associated(input%H2)) then
    call json%add(json_root, 'h2', input%H2)
  endif
  if (associated(input%VA)) then
    call json%add(json_root, 'va', input%VA)
  endif
  if (associated(input%VS)) then
    call json%add(json_root, 'vs', input%VS)
  endif
  if (associated(input%VOLT)) then
    call json%add(json_root, 'volt', input%VOLT)
  endif
  if (associated(input%FREQ)) then
    call json%add(json_root, 'freq', input%FREQ)
  endif
  if (associated(input%PHAS)) then
    call json%add(json_root, 'phas', input%PHAS)
  endif
  if (associated(input%DELTA_E)) then
    call json%add(json_root, 'delta_e', input%DELTA_E)
  endif
  if (associated(input%LAG)) then
    call json%add(json_root, 'lag', input%LAG)
  endif
  if (associated(input%DC_ac)) then
    call json%add(json_root, 'dc_ac', input%DC_ac)
  endif
  if (associated(input%A_ac)) then
    call json%add(json_root, 'a_ac', input%A_ac)
  endif
  if (associated(input%theta_ac)) then
    call json%add(json_root, 'theta_ac', input%theta_ac)
  endif
  if (associated(input%D_AC)) then
    call json%add(json_root, 'd_ac', input%D_AC)
  endif
  if (associated(input%D_AN)) then
    !'real(dp),   DIMENSION(:), POINTER:: D_AN => null(),D_BN => null(),D0_AN => null(),D0_BN => null();'
    call json%create_array(json_list1, 'd_an')
    do i1 = lbound(input%D_AN, 1), ubound(input%D_AN, 1)
      call json%create_real(json_val, input%D_AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D_BN)) then
    !'real(dp),   DIMENSION(:), POINTER:: D_AN => null(),D_BN => null(),D0_AN => null(),D0_BN => null();'
    call json%create_array(json_list1, 'd_bn')
    do i1 = lbound(input%D_BN, 1), ubound(input%D_BN, 1)
      call json%create_real(json_val, input%D_BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D0_AN)) then
    !'real(dp),   DIMENSION(:), POINTER:: D_AN => null(),D_BN => null(),D0_AN => null(),D0_BN => null();'
    call json%create_array(json_list1, 'd0_an')
    do i1 = lbound(input%D0_AN, 1), ubound(input%D0_AN, 1)
      call json%create_real(json_val, input%D0_AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D0_BN)) then
    !'real(dp),   DIMENSION(:), POINTER:: D_AN => null(),D_BN => null(),D0_AN => null(),D0_BN => null();'
    call json%create_array(json_list1, 'd0_bn')
    do i1 = lbound(input%D0_BN, 1), ubound(input%D0_BN, 1)
      call json%create_real(json_val, input%D0_BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D_Volt)) then
    call json%add(json_root, 'd_volt', input%D_Volt)
  endif
  if (associated(input%D0_Volt)) then
    call json%add(json_root, 'd0_volt', input%D0_Volt)
  endif
  if (associated(input%D_phas)) then
    call json%add(json_root, 'd_phas', input%D_phas)
  endif
  if (associated(input%D0_phas)) then
    call json%add(json_root, 'd0_phas', input%D0_phas)
  endif
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  if (associated(input%slow_ac)) then
    call json%add(json_root, 'slow_ac', int(input%slow_ac))
  endif
  if (associated(input%B_SOL)) then
    call json%add(json_root, 'b_sol', input%B_SOL)
  endif
  if (associated(input%MIS)) then
    call json%add(json_root, 'mis', input%MIS)
  endif
  if (associated(input%D0)) then
    call DRIFT1_to_json(input%D0, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'D0')
    call json%add(json_root, json_val)
  endif
  if (associated(input%K2)) then
    call DKD2_to_json(input%K2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'K2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%K3)) then
    call KICKT3_to_json(input%K3, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'K3')
    call json%add(json_root, json_val)
  endif
  if (associated(input%C4)) then
    call CAV4_to_json(input%C4, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'C4')
    call json%add(json_root, json_val)
  endif
  if (associated(input%S5)) then
    call SOL5_to_json(input%S5, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'S5')
    call json%add(json_root, json_val)
  endif
  if (associated(input%T6)) then
    call KTK_to_json(input%T6, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'T6')
    call json%add(json_root, json_val)
  endif
  if (associated(input%T7)) then
    call TKTF_to_json(input%T7, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'T7')
    call json%add(json_root, json_val)
  endif
  if (associated(input%S8)) then
    call NSMI_to_json(input%S8, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'S8')
    call json%add(json_root, json_val)
  endif
  if (associated(input%S9)) then
    call SSMI_to_json(input%S9, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'S9')
    call json%add(json_root, json_val)
  endif
  if (associated(input%TP10)) then
    call TEAPOT_to_json(input%TP10, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'TP10')
    call json%add(json_root, json_val)
  endif
  if (associated(input%MON14)) then
    call MON_to_json(input%MON14, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'MON14')
    call json%add(json_root, json_val)
  endif
  if (associated(input%SEP15)) then
    call ESEPTUM_to_json(input%SEP15, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'SEP15')
    call json%add(json_root, json_val)
  endif
  if (associated(input%K16)) then
    call STREX_to_json(input%K16, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'K16')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ENGE17)) then
    call ENGE_to_json(input%ENGE17, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ENGE17')
    call json%add(json_root, json_val)
  endif
  if (associated(input%RCOL18)) then
    call RCOL_to_json(input%RCOL18, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'RCOL18')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ECOL19)) then
    call ECOL_to_json(input%ECOL19, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ECOL19')
    call json%add(json_root, json_val)
  endif
  if (associated(input%CAV21)) then
    call CAV_TRAV_to_json(input%CAV21, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'CAV21')
    call json%add(json_root, json_val)
  endif
  if (associated(input%WI)) then
    call SAGAN_to_json(input%WI, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'WI')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PA)) then
    call PANCAKE_to_json(input%PA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AB)) then
    call ABELL_to_json(input%AB, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'AB')
    call json%add(json_root, json_val)
  endif
  if (associated(input%HE22)) then
    call HELICAL_DIPOLE_to_json(input%HE22, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'HE22')
    call json%add(json_root, json_val)
  endif
  if (associated(input%SDR)) then
    call SUPERDRIFT_to_json(input%SDR, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'SDR')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PARENT_FIBRE)) then
    call FIBRE_to_json(input%PARENT_FIBRE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PARENT_FIBRE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%doko)) then
    call fibre_appearance_to_json(input%doko, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'doko')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: ELEMENT%siamese (type, magnets somewhat glued together)
  ! config skip_members: ELEMENT%girders (type, magnets on a girder)
  if (associated(input%SIAMESE_FRAME)) then
    call AFFINE_FRAME_to_json(input%SIAMESE_FRAME, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'SIAMESE_FRAME')
    call json%add(json_root, json_val)
  endif
  if (associated(input%girder_FRAME)) then
    call AFFINE_FRAME_to_json(input%girder_FRAME, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'girder_FRAME')
    call json%add(json_root, json_val)
  endif
  if (associated(input%assembly)) then
    call girder_to_json(input%assembly, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'assembly')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ramp)) then
    call ramping_to_json(input%ramp, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ramp')
    call json%add(json_root, json_val)
  endif
  if (associated(input%forward)) then
    !'type(tree_element), pointer :: forward(:)=> null(),backward(:)=> null()'
    call json%create_array(json_list1, 'forward')
    do i1 = lbound(input%forward, 1), ubound(input%forward, 1)
      call tree_element_to_json(input%forward(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%backward)) then
    !'type(tree_element), pointer :: forward(:)=> null(),backward(:)=> null()'
    call json%create_array(json_list1, 'backward')
    do i1 = lbound(input%backward, 1), ubound(input%backward, 1)
      call tree_element_to_json(input%backward(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%usef)) then
    call json%add(json_root, 'usef', input%usef)
  endif
  if (associated(input%useb)) then
    call json%add(json_root, 'useb', input%useb)
  endif
  if (associated(input%skip_ptc_f)) then
    call json%add(json_root, 'skip_ptc_f', int(input%skip_ptc_f))
  endif
  if (associated(input%skip_ptc_b)) then
    call json%add(json_root, 'skip_ptc_b', int(input%skip_ptc_b))
  endif
  if (associated(input%do1mapf)) then
    call json%add(json_root, 'do1mapf', input%do1mapf)
  endif
  if (associated(input%do1mapb)) then
    call json%add(json_root, 'do1mapb', input%do1mapb)
  endif
  if (associated(input%ene)) then
    call json%add(json_root, 'ene', input%ene)
  endif
end subroutine ELEMENT_to_json
subroutine ELEMENTP_to_json (input, json_root, depth, max_depth)
  use definition, only: ELEMENTP
  implicit none
  type(json_core) :: json
  type (ELEMENTP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%KIND)) then
    call json%add(json_root, 'kind', int(input%KIND))
  endif
  if (associated(input%old_integrator)) then
    call json%add(json_root, 'old_integrator', int(input%old_integrator))
  endif
  if (associated(input%KNOB)) then
    call json%add(json_root, 'knob', input%KNOB)
  endif
  if (associated(input%probe)) then
    call json%add(json_root, 'probe', input%probe)
  endif
  if (associated(input%NAME)) then
    call json%add(json_root, 'name', trim(input%NAME))
  endif
  if (associated(input%VORNAME)) then
    call json%add(json_root, 'vorname', trim(input%VORNAME))
  endif
  if (associated(input%electric)) then
    call json%add(json_root, 'electric', input%electric)
  endif
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN   => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN   => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(),HGAP  => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call REAL_8_to_json(input%FINT(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(),HGAP  => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call REAL_8_to_json(input%HGAP(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call REAL_8_to_json(input%H1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H2)) then
    call REAL_8_to_json(input%H2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VA)) then
    call REAL_8_to_json(input%VA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VS)) then
    call REAL_8_to_json(input%VS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VOLT)) then
    call REAL_8_to_json(input%VOLT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VOLT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%FREQ)) then
    call REAL_8_to_json(input%FREQ, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'FREQ')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PHAS)) then
    call REAL_8_to_json(input%PHAS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PHAS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%DELTA_E)) then
    call json%add(json_root, 'delta_e', input%DELTA_E)
  endif
  if (associated(input%DC_ac)) then
    call REAL_8_to_json(input%DC_ac, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'DC_ac')
    call json%add(json_root, json_val)
  endif
  if (associated(input%A_ac)) then
    call REAL_8_to_json(input%A_ac, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'A_ac')
    call json%add(json_root, json_val)
  endif
  if (associated(input%theta_ac)) then
    call REAL_8_to_json(input%theta_ac, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'theta_ac')
    call json%add(json_root, json_val)
  endif
  if (associated(input%D_AC)) then
    call REAL_8_to_json(input%D_AC, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'D_AC')
    call json%add(json_root, json_val)
  endif
  if (associated(input%D_AN)) then
    !'TYPE(REAL_8),   DIMENSION(:), POINTER:: D_AN => null(),D_BN => null(),D0_AN => null(),D0_BN => null()'
    call json%create_array(json_list1, 'd_an')
    do i1 = lbound(input%D_AN, 1), ubound(input%D_AN, 1)
      call REAL_8_to_json(input%D_AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D_BN)) then
    !'TYPE(REAL_8),   DIMENSION(:), POINTER:: D_AN => null(),D_BN => null(),D0_AN => null(),D0_BN => null()'
    call json%create_array(json_list1, 'd_bn')
    do i1 = lbound(input%D_BN, 1), ubound(input%D_BN, 1)
      call REAL_8_to_json(input%D_BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D0_AN)) then
    !'TYPE(REAL_8),   DIMENSION(:), POINTER:: D_AN => null(),D_BN => null(),D0_AN => null(),D0_BN => null()'
    call json%create_array(json_list1, 'd0_an')
    do i1 = lbound(input%D0_AN, 1), ubound(input%D0_AN, 1)
      call REAL_8_to_json(input%D0_AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D0_BN)) then
    !'TYPE(REAL_8),   DIMENSION(:), POINTER:: D_AN => null(),D_BN => null(),D0_AN => null(),D0_BN => null()'
    call json%create_array(json_list1, 'd0_bn')
    do i1 = lbound(input%D0_BN, 1), ubound(input%D0_BN, 1)
      call REAL_8_to_json(input%D0_BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D_Volt)) then
    call REAL_8_to_json(input%D_Volt, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'D_Volt')
    call json%add(json_root, json_val)
  endif
  if (associated(input%D0_Volt)) then
    call REAL_8_to_json(input%D0_Volt, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'D0_Volt')
    call json%add(json_root, json_val)
  endif
  if (associated(input%D_phas)) then
    call REAL_8_to_json(input%D_phas, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'D_phas')
    call json%add(json_root, json_val)
  endif
  if (associated(input%D0_phas)) then
    call REAL_8_to_json(input%D0_phas, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'D0_phas')
    call json%add(json_root, json_val)
  endif
  if (associated(input%B_SOL)) then
    call REAL_8_to_json(input%B_SOL, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'B_SOL')
    call json%add(json_root, json_val)
  endif
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  if (associated(input%slow_ac)) then
    call json%add(json_root, 'slow_ac', int(input%slow_ac))
  endif
  if (associated(input%MIS)) then
    call json%add(json_root, 'mis', input%MIS)
  endif
  ! parent pointer skip: P (TYPE, TYPES OF POLYMORPHIC MAGNETS)
  if (associated(input%D0)) then
    call DRIFT1P_to_json(input%D0, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'D0')
    call json%add(json_root, json_val)
  endif
  if (associated(input%K2)) then
    call DKD2P_to_json(input%K2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'K2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%K3)) then
    call KICKT3P_to_json(input%K3, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'K3')
    call json%add(json_root, json_val)
  endif
  if (associated(input%C4)) then
    call CAV4P_to_json(input%C4, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'C4')
    call json%add(json_root, json_val)
  endif
  if (associated(input%S5)) then
    call SOL5P_to_json(input%S5, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'S5')
    call json%add(json_root, json_val)
  endif
  if (associated(input%T6)) then
    call KTKP_to_json(input%T6, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'T6')
    call json%add(json_root, json_val)
  endif
  if (associated(input%T7)) then
    call TKTFP_to_json(input%T7, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'T7')
    call json%add(json_root, json_val)
  endif
  if (associated(input%S8)) then
    call NSMIP_to_json(input%S8, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'S8')
    call json%add(json_root, json_val)
  endif
  if (associated(input%S9)) then
    call SSMIP_to_json(input%S9, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'S9')
    call json%add(json_root, json_val)
  endif
  if (associated(input%TP10)) then
    call TEAPOTP_to_json(input%TP10, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'TP10')
    call json%add(json_root, json_val)
  endif
  if (associated(input%MON14)) then
    call MONP_to_json(input%MON14, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'MON14')
    call json%add(json_root, json_val)
  endif
  if (associated(input%SEP15)) then
    call ESEPTUMP_to_json(input%SEP15, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'SEP15')
    call json%add(json_root, json_val)
  endif
  if (associated(input%K16)) then
    call STREXP_to_json(input%K16, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'K16')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ENGE17)) then
    call ENGEP_to_json(input%ENGE17, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ENGE17')
    call json%add(json_root, json_val)
  endif
  if (associated(input%RCOL18)) then
    call RCOLP_to_json(input%RCOL18, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'RCOL18')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ECOL19)) then
    call ECOLP_to_json(input%ECOL19, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ECOL19')
    call json%add(json_root, json_val)
  endif
  if (associated(input%CAV21)) then
    call CAV_TRAVP_to_json(input%CAV21, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'CAV21')
    call json%add(json_root, json_val)
  endif
  if (associated(input%HE22)) then
    call HELICAL_DIPOLEP_to_json(input%HE22, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'HE22')
    call json%add(json_root, json_val)
  endif
  if (associated(input%SDR)) then
    call SUPERDRIFTP_to_json(input%SDR, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'SDR')
    call json%add(json_root, json_val)
  endif
  if (associated(input%WI)) then
    call SAGANP_to_json(input%WI, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'WI')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PA)) then
    call PANCAKEP_to_json(input%PA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AB)) then
    call ABELLP_to_json(input%AB, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'AB')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PARENT_FIBRE)) then
    call FIBRE_to_json(input%PARENT_FIBRE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PARENT_FIBRE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ramp)) then
    call ramping_to_json(input%ramp, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ramp')
    call json%add(json_root, json_val)
  endif
  if (associated(input%forward)) then
    !'type(tree_element), pointer :: forward(:)=> null(),backward(:)=> null()'
    call json%create_array(json_list1, 'forward')
    do i1 = lbound(input%forward, 1), ubound(input%forward, 1)
      call tree_element_to_json(input%forward(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%backward)) then
    !'type(tree_element), pointer :: forward(:)=> null(),backward(:)=> null()'
    call json%create_array(json_list1, 'backward')
    do i1 = lbound(input%backward, 1), ubound(input%backward, 1)
      call tree_element_to_json(input%backward(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%usef)) then
    call json%add(json_root, 'usef', input%usef)
  endif
  if (associated(input%useb)) then
    call json%add(json_root, 'useb', input%useb)
  endif
  if (associated(input%skip_ptc_f)) then
    call json%add(json_root, 'skip_ptc_f', int(input%skip_ptc_f))
  endif
  if (associated(input%skip_ptc_b)) then
    call json%add(json_root, 'skip_ptc_b', int(input%skip_ptc_b))
  endif
  if (associated(input%do1mapf)) then
    call json%add(json_root, 'do1mapf', input%do1mapf)
  endif
  if (associated(input%do1mapb)) then
    call json%add(json_root, 'do1mapb', input%do1mapb)
  endif
end subroutine ELEMENTP_to_json
subroutine ENGE_to_json (input, json_root, depth, max_depth)
  use definition, only: ENGE
  implicit none
  type(json_core) :: json
  type (ENGE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%D)) then
    call json%add(json_root, 'd', input%D)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%A)) then
    !'real(dp),  DIMENSION(:), POINTER :: A => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%A, 1), ubound(input%A, 1)
      call json%create_real(json_val, input%A(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%nbessel)) then
    call json%add(json_root, 'nbessel', int(input%nbessel))
  endif
  if (associated(input%F)) then
    call my_1D_taylor_to_json(input%F, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'F')
    call json%add(json_root, json_val)
  endif
end subroutine ENGE_to_json
subroutine ENGEP_to_json (input, json_root, depth, max_depth)
  use definition, only: ENGEP
  implicit none
  type(json_core) :: json
  type (ENGEP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%D)) then
    call json%add(json_root, 'd', input%D)
  endif
  if (associated(input%A)) then
    !'real(dp),  DIMENSION(:), POINTER :: A => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%A, 1), ubound(input%A, 1)
      call json%create_real(json_val, input%A(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%nbessel)) then
    call json%add(json_root, 'nbessel', int(input%nbessel))
  endif
  if (associated(input%F)) then
    call my_1D_taylor_to_json(input%F, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'F')
    call json%add(json_root, json_val)
  endif
end subroutine ENGEP_to_json
subroutine ESEPTUM_to_json (input, json_root, depth, max_depth)
  use definition, only: ESEPTUM
  implicit none
  type(json_core) :: json
  type (ESEPTUM), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%VOLT)) then
    call json%add(json_root, 'volt', input%VOLT)
  endif
  if (associated(input%PHAS)) then
    call json%add(json_root, 'phas', input%PHAS)
  endif
end subroutine ESEPTUM_to_json
subroutine ESEPTUMP_to_json (input, json_root, depth, max_depth)
  use definition, only: ESEPTUMP
  implicit none
  type(json_core) :: json
  type (ESEPTUMP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VOLT)) then
    call REAL_8_to_json(input%VOLT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VOLT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PHAS)) then
    call REAL_8_to_json(input%PHAS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PHAS')
    call json%add(json_root, json_val)
  endif
end subroutine ESEPTUMP_to_json
subroutine EXTRA_WORK_to_json (input, json_root, depth, max_depth)
  use definition, only: EXTRA_WORK
  implicit none
  type(json_core) :: json
  type (EXTRA_WORK), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%KIND)) then
    call json%add(json_root, 'kind', int(input%KIND))
  endif
  if (associated(input%NODE)) then
    call INTEGRATION_NODE_to_json(input%NODE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'NODE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%BB)) then
    call BEAM_BEAM_NODE_to_json(input%BB, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'BB')
    call json%add(json_root, json_val)
  endif
  if (associated(input%A)) then
    call MADX_APERTURE_to_json(input%A, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'A')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ORB)) then
    !'REAL(DP), POINTER :: ORB(:)  => null()'
    call json%create_array(json_list1, 'orb')
    do i1 = lbound(input%ORB, 1), ubound(input%ORB, 1)
      call json%create_real(json_val, input%ORB(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine EXTRA_WORK_to_json
subroutine FIBRE_to_json (input, json_root, depth, max_depth)
  use definition, only: FIBRE
  implicit none
  type(json_core) :: json
  type (FIBRE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%DIR)) then
    call json%add(json_root, 'dir', int(input%DIR))
  endif
  if (associated(input%PATCH)) then
    call PATCH_to_json(input%PATCH, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PATCH')
    call json%add(json_root, json_val)
  endif
  if (associated(input%CHART)) then
    call CHART_to_json(input%CHART, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'CHART')
    call json%add(json_root, json_val)
  endif
  if (associated(input%MAG)) then
    call ELEMENT_to_json(input%MAG, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'MAG')
    call json%add(json_root, json_val)
  endif
  if (associated(input%MAGP)) then
    call ELEMENTP_to_json(input%MAGP, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'MAGP')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: FIBRE%PREVIOUS (TYPE, )
  ! config skip_members: FIBRE%NEXT (TYPE, POINTING TO PARENT LAYOUT AND PARENT FIBRE DATA)
  if (associated(input%PARENT_LAYOUT)) then
    call LAYOUT_to_json(input%PARENT_LAYOUT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PARENT_LAYOUT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%i)) then
    call info_to_json(input%i, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'i')
    call json%add(json_root, json_val)
  endif
  if (associated(input%T1)) then
    call INTEGRATION_NODE_to_json(input%T1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'T1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%T2)) then
    call INTEGRATION_NODE_to_json(input%T2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'T2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%TM)) then
    call INTEGRATION_NODE_to_json(input%TM, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'TM')
    call json%add(json_root, json_val)
  endif
  if (associated(input%pos)) then
    call json%add(json_root, 'pos', int(input%pos))
  endif
  if (associated(input%BETA0)) then
    call json%add(json_root, 'beta0', input%BETA0)
  endif
  if (associated(input%GAMMA0I)) then
    call json%add(json_root, 'gamma0i', input%GAMMA0I)
  endif
  if (associated(input%GAMBET)) then
    call json%add(json_root, 'gambet', input%GAMBET)
  endif
  if (associated(input%MASS)) then
    call json%add(json_root, 'mass', input%MASS)
  endif
  if (associated(input%CHARGE)) then
    call json%add(json_root, 'charge', input%CHARGE)
  endif
  if (associated(input%AG)) then
    call json%add(json_root, 'ag', input%AG)
  endif
  ! parent pointer skip: P (TYPE, tying them in the so-called database universe M_u)
  ! config skip_members: FIBRE%N (TYPE, )
  if (associated(input%loc)) then
    call json%add(json_root, 'loc', int(input%loc))
  endif
end subroutine FIBRE_to_json
subroutine fibre_appearance_to_json (input, json_root, depth, max_depth)
  use definition, only: fibre_appearance
  implicit none
  type(json_core) :: json
  type (fibre_appearance), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%PARENT_FIBRE)) then
    call FIBRE_to_json(input%PARENT_FIBRE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PARENT_FIBRE')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: fibre_appearance%next (TYPE, )
end subroutine fibre_appearance_to_json
subroutine fibre_array_to_json (input, json_root, depth, max_depth)
  use definition, only: fibre_array
  implicit none
  type(json_core) :: json
  type (fibre_array), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: p (type, )
  if (associated(input%t)) then
    call integration_node_to_json(input%t, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 't')
    call json%add(json_root, json_val)
  endif
  if (associated(input%pos)) then
    call json%add(json_root, 'pos', int(input%pos))
  endif
  if (associated(input%v)) then
    call json%add(json_root, 'v', input%v)
  endif
  if (associated(input%vmax)) then
    call json%add(json_root, 'vmax', input%vmax)
  endif
  if (associated(input%s)) then
    !'real(dp), pointer :: s(:)=> null()'
    call json%create_array(json_list1, 's')
    do i1 = lbound(input%s, 1), ubound(input%s, 1)
      call json%create_real(json_val, input%s(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%err)) then
    call json%add(json_root, 'err', input%err)
  endif
end subroutine fibre_array_to_json
subroutine fibre_monitor_data_to_json (input, json_root, depth, max_depth)
  use s_fitting_new, only: fibre_monitor_data
  implicit none
  type(json_core) :: json
  type (fibre_monitor_data), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: p (type, fibre location)
  if (associated(input%turn)) then
    call json%add(json_root, 'turn', int(input%turn))
  endif
  if (associated(input%kind)) then
    call json%add(json_root, 'kind', int(input%kind))
  endif
  if (associated(input%bpm)) then
    !'real(dp), pointer :: bpm(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%bpm, 2), ubound(input%bpm, 2)
      call json%create_array(json_list1, 'bpm')
      do i1 = lbound(input%bpm, 1), ubound(input%bpm, 1)
        call json%create_real(json_val, input%bpm(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%r)) then
    !'real(dp), pointer :: r(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%r, 2), ubound(input%r, 2)
      call json%create_array(json_list1, 'r')
      do i1 = lbound(input%r, 1), ubound(input%r, 1)
        call json%create_real(json_val, input%r(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%xf)) then
    !'real(dp), pointer :: xf(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%xf, 2), ubound(input%xf, 2)
      call json%create_array(json_list1, 'xf')
      do i1 = lbound(input%xf, 1), ubound(input%xf, 1)
        call json%create_real(json_val, input%xf(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%xn)) then
    !'real(dp), pointer :: xn(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%xn, 2), ubound(input%xn, 2)
      call json%create_array(json_list1, 'xn')
      do i1 = lbound(input%xn, 1), ubound(input%xn, 1)
        call json%create_real(json_val, input%xn(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%mom)) then
    !'real(dp), pointer :: mom(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%mom, 2), ubound(input%mom, 2)
      call json%create_array(json_list1, 'mom')
      do i1 = lbound(input%mom, 1), ubound(input%mom, 1)
        call json%create_real(json_val, input%mom(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%A)) then
    !'real(dp), pointer :: A(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%A, 2), ubound(input%A, 2)
      call json%create_array(json_list1, 'a')
      do i1 = lbound(input%A, 1), ubound(input%A, 1)
        call json%create_real(json_val, input%A(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%At)) then
    !'real(dp), pointer :: At(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%At, 2), ubound(input%At, 2)
      call json%create_array(json_list1, 'at')
      do i1 = lbound(input%At, 1), ubound(input%At, 1)
        call json%create_real(json_val, input%At(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  call json%add(json_root, 'full', input%full)
end subroutine fibre_monitor_data_to_json
subroutine fibrelist_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: fibrelist
  implicit none
  type(json_core) :: json
  type (fibrelist), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) GAMMA0I_GAMBET_MASS_AG(4)'
  call json%create_array(json_list1, 'gamma0i_gambet_mass_ag')
  do i1 = lbound(input%GAMMA0I_GAMBET_MASS_AG, 1), ubound(input%GAMMA0I_GAMBET_MASS_AG, 1)
    call json%create_real(json_val, input%GAMMA0I_GAMBET_MASS_AG(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'charge', input%CHARGE)
  call json%add(json_root, 'dir', int(input%DIR))
  call json%add(json_root, 'patch', int(input%patch))
end subroutine fibrelist_to_json
subroutine file__to_json (input, json_root, depth, max_depth)
  use file_handler, only: file_
  implicit none
  type(json_core) :: json
  type (file_), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'mf', input%MF)
end subroutine file__to_json
subroutine file_K_to_json (input, json_root, depth, max_depth)
  use file_handler, only: file_K
  implicit none
  type(json_core) :: json
  type (file_K), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'mf', input%MF)
end subroutine file_K_to_json
subroutine genfield_to_json (input, json_root, depth, max_depth)
  use definition, only: genfield
  implicit none
  type(json_core) :: json
  type (genfield), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call taylor_to_json(input%h, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'h')
  call json%add(json_root, json_val)
  call damap_to_json(input%m, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'm')
  call json%add(json_root, json_val)
  !'type (taylor) d(ndim,ndim)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%d, 2), ubound(input%d, 2)
    call json%create_array(json_list1, 'd')
    do i1 = lbound(input%d, 1), ubound(input%d, 1)
      call taylor_to_json(input%d(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call damap_to_json(input%linear, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'linear')
  call json%add(json_root, json_val)
  call damap_to_json(input%lineart, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'lineart')
  call json%add(json_root, json_val)
  call damap_to_json(input%mt, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'mt')
  call json%add(json_root, json_val)
  !'real(dp) constant(ndim2),eps'
  call json%create_array(json_list1, 'constant')
  do i1 = lbound(input%constant, 1), ubound(input%constant, 1)
    call json%create_real(json_val, input%constant(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'eps', input%eps)
  call json%add(json_root, 'imax', int(input%imax))
  call json%add(json_root, 'ifac', int(input%ifac))
  call json%add(json_root, 'linear_in', input%linear_in)
  call json%add(json_root, 'no_cut', int(input%no_cut))
end subroutine genfield_to_json
subroutine girder_to_json (input, json_root, depth, max_depth)
  use definition, only: girder
  implicit none
  type(json_core) :: json
  type (girder), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%i)) then
    call json%add(json_root, 'i', int(input%i))
  endif
  if (associated(input%pos)) then
    call json%add(json_root, 'pos', int(input%pos))
  endif
  if (associated(input%mul)) then
    call json%add(json_root, 'mul', int(input%mul))
  endif
  if (associated(input%added)) then
    call json%add(json_root, 'added', int(input%added))
  endif
  if (associated(input%discarded)) then
    call json%add(json_root, 'discarded', int(input%discarded))
  endif
  if (associated(input%a)) then
    !'real(dp), pointer:: a(:) => null(),ent(:,:) => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%a, 1), ubound(input%a, 1)
      call json%create_real(json_val, input%a(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ent)) then
    !'real(dp), pointer:: a(:) => null(),ent(:,:) => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%ent, 2), ubound(input%ent, 2)
      call json%create_array(json_list1, 'ent')
      do i1 = lbound(input%ent, 1), ubound(input%ent, 1)
        call json%create_real(json_val, input%ent(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%info)) then
    call girder_info_to_json(input%info, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'info')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: girder%PREVIOUS (TYPE, Terminated link list)
  ! config skip_members: girder%NEXT (TYPE, )
end subroutine girder_to_json
subroutine girder_info_to_json (input, json_root, depth, max_depth)
  use definition, only: girder_info
  implicit none
  type(json_core) :: json
  type (girder_info), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%NAME)) then
    call json%add(json_root, 'name', trim(input%NAME))
  endif
  if (associated(input%d)) then
    !'real(dp), POINTER ::  d(:)  => null()'
    call json%create_array(json_list1, 'd')
    do i1 = lbound(input%d, 1), ubound(input%d, 1)
      call json%create_real(json_val, input%d(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%mag)) then
    call element_to_json(input%mag, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'mag')
    call json%add(json_root, json_val)
  endif
  if (associated(input%a)) then
    !'real(dp), pointer:: a(:) => null(),ent(:,:) => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%a, 1), ubound(input%a, 1)
      call json%create_real(json_val, input%a(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ent)) then
    !'real(dp), pointer:: a(:) => null(),ent(:,:) => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%ent, 2), ubound(input%ent, 2)
      call json%create_array(json_list1, 'ent')
      do i1 = lbound(input%ent, 1), ubound(input%ent, 1)
        call json%create_real(json_val, input%ent(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%parent_girder)) then
    call girder_to_json(input%parent_girder, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'parent_girder')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: girder_info%NEXT (TYPE, Terminated link list)
end subroutine girder_info_to_json
subroutine girder_list_to_json (input, json_root, depth, max_depth)
  use definition, only: girder_list
  implicit none
  type(json_core) :: json
  type (girder_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%NAME)) then
    call json%add(json_root, 'name', trim(input%NAME))
  endif
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%discarded)) then
    call json%add(json_root, 'discarded', int(input%discarded))
  endif
  if (associated(input%LASTPOS)) then
    call json%add(json_root, 'lastpos', int(input%LASTPOS))
  endif
  if (associated(input%LAST)) then
    call girder_to_json(input%LAST, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'LAST')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END)) then
    call girder_to_json(input%END, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START)) then
    call girder_to_json(input%START, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START')
    call json%add(json_root, json_val)
  endif
  if (associated(input%lastfibre)) then
    call fibre_to_json(input%lastfibre, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'lastfibre')
    call json%add(json_root, json_val)
  endif
end subroutine girder_list_to_json
subroutine girder_siamese_to_json (input, json_root, depth, max_depth)
  use definition, only: girder_siamese
  implicit none
  type(json_core) :: json
  type (girder_siamese), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%mag)) then
    call element_to_json(input%mag, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'mag')
    call json%add(json_root, json_val)
  endif
end subroutine girder_siamese_to_json
subroutine GMAP_to_json (input, json_root, depth, max_depth)
  use definition, only: GMAP
  implicit none
  type(json_core) :: json
  type (GMAP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'TYPE (TAYLOR) V(lnv)'
  call json%create_array(json_list1, 'v')
  do i1 = lbound(input%V, 1), ubound(input%V, 1)
    call TAYLOR_to_json(input%V(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n', int(input%N))
end subroutine GMAP_to_json
subroutine hel_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: hel_list
  implicit none
  type(json_core) :: json
  type (hel_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'n_bessel', int(input%N_BESSEL))
  !'real(dp) fake_shift(6)'
  call json%create_array(json_list1, 'fake_shift')
  do i1 = lbound(input%fake_shift, 1), ubound(input%fake_shift, 1)
    call json%create_real(json_val, input%fake_shift(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine hel_list_to_json
subroutine HELICAL_DIPOLE_to_json (input, json_root, depth, max_depth)
  use definition, only: HELICAL_DIPOLE
  implicit none
  type(json_core) :: json
  type (HELICAL_DIPOLE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null(),fake_shift=> null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null(),fake_shift=> null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%fake_shift)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null(),fake_shift=> null()'
    call json%create_array(json_list1, 'fake_shift')
    do i1 = lbound(input%fake_shift, 1), ubound(input%fake_shift, 1)
      call json%create_real(json_val, input%fake_shift(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FREQ)) then
    call json%add(json_root, 'freq', input%FREQ)
  endif
  if (associated(input%PHAS)) then
    call json%add(json_root, 'phas', input%PHAS)
  endif
  if (associated(input%N_BESSEL)) then
    call json%add(json_root, 'n_bessel', int(input%N_BESSEL))
  endif
end subroutine HELICAL_DIPOLE_to_json
subroutine HELICAL_DIPOLEP_to_json (input, json_root, depth, max_depth)
  use definition, only: HELICAL_DIPOLEP
  implicit none
  type(json_core) :: json
  type (HELICAL_DIPOLEP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%fake_shift)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: fake_shift=> null()'
    call json%create_array(json_list1, 'fake_shift')
    do i1 = lbound(input%fake_shift, 1), ubound(input%fake_shift, 1)
      call REAL_8_to_json(input%fake_shift(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FREQ)) then
    call REAL_8_to_json(input%FREQ, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'FREQ')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PHAS)) then
    call REAL_8_to_json(input%PHAS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PHAS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%N_BESSEL)) then
    call json%add(json_root, 'n_bessel', int(input%N_BESSEL))
  endif
end subroutine HELICAL_DIPOLEP_to_json
subroutine hermite_to_json (input, json_root, depth, max_depth)
  use pointer_lattice, only: hermite
  implicit none
  type(json_core) :: json
  type (hermite), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'n', int(input%n))
  !'real(dp) :: h(2)'
  call json%create_array(json_list1, 'h')
  do i1 = lbound(input%h, 1), ubound(input%h, 1)
    call json%create_real(json_val, input%h(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) :: a(6,6)=0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%a, 2), ubound(input%a, 2)
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%a, 1), ubound(input%a, 1)
      call json%create_real(json_val, input%a(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp):: ai(6,6)=0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%ai, 2), ubound(input%ai, 2)
    call json%create_array(json_list1, 'ai')
    do i1 = lbound(input%ai, 1), ubound(input%ai, 1)
      call json%create_real(json_val, input%ai(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp):: m(6,6)=0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%m, 2), ubound(input%m, 2)
    call json%create_array(json_list1, 'm')
    do i1 = lbound(input%m, 1), ubound(input%m, 1)
      call json%create_real(json_val, input%m(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp):: mi(6,6)=0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%mi, 2), ubound(input%mi, 2)
    call json%create_array(json_list1, 'mi')
    do i1 = lbound(input%mi, 1), ubound(input%mi, 1)
      call json%create_real(json_val, input%mi(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp) ::f(6)=0'
  call json%create_array(json_list1, 'f')
  do i1 = lbound(input%f, 1), ubound(input%f, 1)
    call json%create_real(json_val, input%f(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) b(2,2)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%b, 2), ubound(input%b, 2)
    call json%create_array(json_list1, 'b')
    do i1 = lbound(input%b, 1), ubound(input%b, 1)
      call json%create_real(json_val, input%b(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'gen', int(input%gen))
  if (associated(input%ms)) then
    !'type(damap), pointer :: ms(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%ms, 2), ubound(input%ms, 2)
      call json%create_array(json_list1, 'ms')
      do i1 = lbound(input%ms, 1), ubound(input%ms, 1)
        call damap_to_json(input%ms(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%p)) then
    !'type(probe_8), pointer :: p(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%p, 2), ubound(input%p, 2)
      call json%create_array(json_list1, 'p')
      do i1 = lbound(input%p, 1), ubound(input%p, 1)
        call probe_8_to_json(input%p(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%x0)) then
    !'real(dp), pointer ::  x0(:,:,:) => null()'
    call json%create_array(json_list3, 'dim-3')
    do i3 = lbound(input%x0, 3), ubound(input%x0, 3)
      call json%create_array(json_list2, 'dim-2')
      do i2 = lbound(input%x0, 2), ubound(input%x0, 2)
        call json%create_array(json_list1, 'x0')
        do i1 = lbound(input%x0, 1), ubound(input%x0, 1)
          call json%create_real(json_val, input%x0(i1, i2, i3), '')
          call json%add(json_list1, json_val)
        enddo
        call json%add(json_list2, json_list1)
        nullify(json_list1)
      enddo
      call json%add(json_list3, json_list2)
      nullify(json_list2)
    enddo
    call json%add(json_root, json_list3)
    nullify(json_list3)
  endif
  call internal_state_to_json(input%state, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'state')
  call json%add(json_root, json_val)
  if (associated(input%r)) then
    call layout_to_json(input%r, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'r')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'pos', int(input%pos))
  call json%add(json_root, 'noh', int(input%noh))
  call json%add(json_root, 'no', int(input%no))
  call json%add(json_root, 'maxite', int(input%maxite))
  call json%add(json_root, 'nint', int(input%nint))
  call json%add(json_root, 'linear', input%linear)
  call json%add(json_root, 'eps', input%eps)
  if (associated(input%he)) then
    !'real(dp), pointer ::  he(:,:,:,:,:) => null()'
    call json%create_array(json_list5, 'dim-5')
    do i5 = lbound(input%he, 5), ubound(input%he, 5)
      call json%create_array(json_list4, 'dim-4')
      do i4 = lbound(input%he, 4), ubound(input%he, 4)
        call json%create_array(json_list3, 'dim-3')
        do i3 = lbound(input%he, 3), ubound(input%he, 3)
          call json%create_array(json_list2, 'dim-2')
          do i2 = lbound(input%he, 2), ubound(input%he, 2)
            call json%create_array(json_list1, 'he')
            do i1 = lbound(input%he, 1), ubound(input%he, 1)
              call json%create_real(json_val, input%he(i1, i2, i3, i4, i5), '')
              call json%add(json_list1, json_val)
            enddo
            call json%add(json_list2, json_list1)
            nullify(json_list1)
          enddo
          call json%add(json_list3, json_list2)
          nullify(json_list2)
        enddo
        call json%add(json_list4, json_list3)
        nullify(json_list3)
      enddo
      call json%add(json_list5, json_list4)
      nullify(json_list4)
    enddo
    call json%add(json_root, json_list5)
    nullify(json_list5)
  endif
end subroutine hermite_to_json
subroutine info_to_json (input, json_root, depth, max_depth)
  use definition, only: info
  implicit none
  type(json_core) :: json
  type (info), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%s)) then
    call json%add(json_root, 's', input%s)
  endif
  if (associated(input%beta)) then
    !'real(dp),pointer ::  beta(:)  => null()'
    call json%create_array(json_list1, 'beta')
    do i1 = lbound(input%beta, 1), ubound(input%beta, 1)
      call json%create_real(json_val, input%beta(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%fix0)) then
    !'real(dp),pointer ::  fix0(:)  => null()'
    call json%create_array(json_list1, 'fix0')
    do i1 = lbound(input%fix0, 1), ubound(input%fix0, 1)
      call json%create_real(json_val, input%fix0(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%fix)) then
    !'real(dp),pointer ::  fix(:)  => null()'
    call json%create_array(json_list1, 'fix')
    do i1 = lbound(input%fix, 1), ubound(input%fix, 1)
      call json%create_real(json_val, input%fix(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%pos)) then
    !'real(dp), pointer:: pos(:)  => null()'
    call json%create_array(json_list1, 'pos')
    do i1 = lbound(input%pos, 1), ubound(input%pos, 1)
      call json%create_real(json_val, input%pos(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%m)) then
    !'real(dp), pointer:: m(:,:)  => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%m, 2), ubound(input%m, 2)
      call json%create_array(json_list1, 'm')
      do i1 = lbound(input%m, 1), ubound(input%m, 1)
        call json%create_real(json_val, input%m(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine info_to_json
subroutine INTEGRATION_NODE_to_json (input, json_root, depth, max_depth)
  use definition, only: INTEGRATION_NODE
  implicit none
  type(json_core) :: json
  type (INTEGRATION_NODE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%pos_in_fibre)) then
    call json%add(json_root, 'pos_in_fibre', int(input%pos_in_fibre))
  endif
  if (associated(input%CAS)) then
    call json%add(json_root, 'cas', int(input%CAS))
  endif
  if (associated(input%pos)) then
    call json%add(json_root, 'pos', int(input%pos))
  endif
  if (associated(input%lost)) then
    call json%add(json_root, 'lost', int(input%lost))
  endif
  if (associated(input%S)) then
    !'real(dp), POINTER :: S(:)  => null()'
    call json%create_array(json_list1, 's')
    do i1 = lbound(input%S, 1), ubound(input%S, 1)
      call json%create_real(json_val, input%S(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ds_ac)) then
    call json%add(json_root, 'ds_ac', input%ds_ac)
  endif
  if (associated(input%ref)) then
    !'real(dp), POINTER :: ref(:)  => null()'
    call json%create_array(json_list1, 'ref')
    do i1 = lbound(input%ref, 1), ubound(input%ref, 1)
      call json%create_real(json_val, input%ref(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ent)) then
    !'real(dp), pointer :: ent(:,:),a(:)  => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%ent, 2), ubound(input%ent, 2)
      call json%create_array(json_list1, 'ent')
      do i1 = lbound(input%ent, 1), ubound(input%ent, 1)
        call json%create_real(json_val, input%ent(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%a)) then
    !'real(dp), pointer :: ent(:,:),a(:)  => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%a, 1), ubound(input%a, 1)
      call json%create_real(json_val, input%a(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%exi)) then
    !'real(dp), pointer :: exi(:,:),b(:)  => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%exi, 2), ubound(input%exi, 2)
      call json%create_array(json_list1, 'exi')
      do i1 = lbound(input%exi, 1), ubound(input%exi, 1)
        call json%create_real(json_val, input%exi(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%b)) then
    !'real(dp), pointer :: exi(:,:),b(:)  => null()'
    call json%create_array(json_list1, 'b')
    do i1 = lbound(input%b, 1), ubound(input%b, 1)
      call json%create_real(json_val, input%b(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%delta_rad_in)) then
    call json%add(json_root, 'delta_rad_in', input%delta_rad_in)
  endif
  if (associated(input%delta_rad_out)) then
    call json%add(json_root, 'delta_rad_out', input%delta_rad_out)
  endif
  if (associated(input%TEAPOT_LIKE)) then
    call json%add(json_root, 'teapot_like', int(input%TEAPOT_LIKE))
  endif
  ! config skip_members: INTEGRATION_NODE%NEXT (TYPE, )
  ! config skip_members: INTEGRATION_NODE%PREVIOUS (TYPE, )
  if (associated(input%PARENT_NODE_LAYOUT)) then
    call NODE_LAYOUT_to_json(input%PARENT_NODE_LAYOUT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PARENT_NODE_LAYOUT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PARENT_FIBRE)) then
    call FIBRE_to_json(input%PARENT_FIBRE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PARENT_FIBRE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%lf)) then
    call c_lattice_function_to_json(input%lf, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'lf')
    call json%add(json_root, json_val)
  endif
  if (associated(input%BB)) then
    call BEAM_BEAM_NODE_to_json(input%BB, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'BB')
    call json%add(json_root, json_val)
  endif
end subroutine INTEGRATION_NODE_to_json
subroutine INTERNAL_STATE_to_json (input, json_root, depth, max_depth)
  use definition, only: INTERNAL_STATE
  implicit none
  type(json_core) :: json
  type (INTERNAL_STATE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'totalpath', int(input%TOTALPATH))
  call json%add(json_root, 'time', input%TIME)
  call json%add(json_root, 'radiation', input%RADIATION)
  call json%add(json_root, 'nocavity', input%NOCAVITY)
  call json%add(json_root, 'fringe', input%FRINGE)
  call json%add(json_root, 'stochastic', input%STOCHASTIC)
  call json%add(json_root, 'envelope', input%ENVELOPE)
  call json%add(json_root, 'para_in', input%PARA_IN)
  call json%add(json_root, 'only_4d', input%ONLY_4D)
  call json%add(json_root, 'delta', input%DELTA)
  call json%add(json_root, 'spin', input%SPIN)
  call json%add(json_root, 'modulation', input%MODULATION)
  call json%add(json_root, 'only_2d', input%ONLY_2D)
  call json%add(json_root, 'full_way', input%FULL_WAY)
end subroutine INTERNAL_STATE_to_json
subroutine k16_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: k16_list
  implicit none
  type(json_core) :: json
  type (k16_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'driftkick', input%DRIFTKICK)
  call json%add(json_root, 'likemad', input%LIKEMAD)
end subroutine k16_list_to_json
subroutine keywords_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: keywords
  implicit none
  type(json_core) :: json
  type (keywords), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'magnet', trim(input%magnet))
  call json%add(json_root, 'model', trim(input%model))
  call json%add(json_root, 'fibre_flip', input%FIBRE_flip)
  call json%add(json_root, 'fibre_dir', int(input%FIBRE_DIR))
  call json%add(json_root, 'method', int(input%method))
  call json%add(json_root, 'nstep', int(input%nstep))
  call json%add(json_root, 'exact', input%exact)
  call json%add(json_root, 'madlength', input%madLENGTH)
  call json%add(json_root, 'mad8', input%mad8)
  call json%add(json_root, 'tiltd', input%tiltd)
  call el_list_to_json(input%LIST, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'LIST')
  call json%add(json_root, json_val)
end subroutine keywords_to_json
subroutine KICKT3_to_json (input, json_root, depth, max_depth)
  use definition, only: KICKT3
  implicit none
  type(json_core) :: json
  type (KICKT3), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%thin_h_foc)) then
    call json%add(json_root, 'thin_h_foc', input%thin_h_foc)
  endif
  if (associated(input%thin_v_foc)) then
    call json%add(json_root, 'thin_v_foc', input%thin_v_foc)
  endif
  if (associated(input%thin_h_angle)) then
    call json%add(json_root, 'thin_h_angle', input%thin_h_angle)
  endif
  if (associated(input%thin_v_angle)) then
    call json%add(json_root, 'thin_v_angle', input%thin_v_angle)
  endif
  if (associated(input%hf)) then
    call json%add(json_root, 'hf', input%hf)
  endif
  if (associated(input%vf)) then
    call json%add(json_root, 'vf', input%vf)
  endif
  if (associated(input%patch)) then
    call json%add(json_root, 'patch', input%patch)
  endif
  if (associated(input%B_SOL)) then
    call json%add(json_root, 'b_sol', input%B_SOL)
  endif
  if (associated(input%ls)) then
    call json%add(json_root, 'ls', input%ls)
  endif
  if (associated(input%dx)) then
    call json%add(json_root, 'dx', input%dx)
  endif
  if (associated(input%dy)) then
    call json%add(json_root, 'dy', input%dy)
  endif
  if (associated(input%pitch_x)) then
    call json%add(json_root, 'pitch_x', input%pitch_x)
  endif
  if (associated(input%pitch_y)) then
    call json%add(json_root, 'pitch_y', input%pitch_y)
  endif
end subroutine KICKT3_to_json
subroutine KICKT3P_to_json (input, json_root, depth, max_depth)
  use definition, only: KICKT3P
  implicit none
  type(json_core) :: json
  type (KICKT3P), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%thin_h_foc)) then
    call REAL_8_to_json(input%thin_h_foc, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'thin_h_foc')
    call json%add(json_root, json_val)
  endif
  if (associated(input%thin_v_foc)) then
    call REAL_8_to_json(input%thin_v_foc, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'thin_v_foc')
    call json%add(json_root, json_val)
  endif
  if (associated(input%thin_h_angle)) then
    call REAL_8_to_json(input%thin_h_angle, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'thin_h_angle')
    call json%add(json_root, json_val)
  endif
  if (associated(input%thin_v_angle)) then
    call REAL_8_to_json(input%thin_v_angle, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'thin_v_angle')
    call json%add(json_root, json_val)
  endif
  if (associated(input%hf)) then
    call REAL_8_to_json(input%hf, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'hf')
    call json%add(json_root, json_val)
  endif
  if (associated(input%vf)) then
    call REAL_8_to_json(input%vf, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'vf')
    call json%add(json_root, json_val)
  endif
  if (associated(input%patch)) then
    call json%add(json_root, 'patch', input%patch)
  endif
  if (associated(input%B_SOL)) then
    call REAL_8_to_json(input%B_SOL, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'B_SOL')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ls)) then
    call json%add(json_root, 'ls', input%ls)
  endif
  if (associated(input%dx)) then
    call json%add(json_root, 'dx', input%dx)
  endif
  if (associated(input%dy)) then
    call json%add(json_root, 'dy', input%dy)
  endif
  if (associated(input%pitch_x)) then
    call json%add(json_root, 'pitch_x', input%pitch_x)
  endif
  if (associated(input%pitch_y)) then
    call json%add(json_root, 'pitch_y', input%pitch_y)
  endif
end subroutine KICKT3P_to_json
subroutine KTK_to_json (input, json_root, depth, max_depth)
  use definition, only: KTK
  implicit none
  type(json_core) :: json
  type (KTK), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%MATX)) then
    !'real(dp),  DIMENSION(:,:), POINTER :: MATX => null(), MATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATX, 2), ubound(input%MATX, 2)
      call json%create_array(json_list1, 'matx')
      do i1 = lbound(input%MATX, 1), ubound(input%MATX, 1)
        call json%create_real(json_val, input%MATX(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%MATY)) then
    !'real(dp),  DIMENSION(:,:), POINTER :: MATX => null(), MATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATY, 2), ubound(input%MATY, 2)
      call json%create_array(json_list1, 'maty')
      do i1 = lbound(input%MATY, 1), ubound(input%MATY, 1)
        call json%create_real(json_val, input%MATY(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%lx)) then
    !'real(dp),  DIMENSION(:), POINTER :: lx => null(), ly => null()'
    call json%create_array(json_list1, 'lx')
    do i1 = lbound(input%lx, 1), ubound(input%lx, 1)
      call json%create_real(json_val, input%lx(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ly)) then
    !'real(dp),  DIMENSION(:), POINTER :: lx => null(), ly => null()'
    call json%create_array(json_list1, 'ly')
    do i1 = lbound(input%ly, 1), ubound(input%ly, 1)
      call json%create_real(json_val, input%ly(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call json%create_real(json_val, input%FINT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call json%create_real(json_val, input%HGAP(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call json%add(json_root, 'h1', input%H1)
  endif
  if (associated(input%H2)) then
    call json%add(json_root, 'h2', input%H2)
  endif
  if (associated(input%VA)) then
    call json%add(json_root, 'va', input%VA)
  endif
  if (associated(input%VS)) then
    call json%add(json_root, 'vs', input%VS)
  endif
end subroutine KTK_to_json
subroutine KTKP_to_json (input, json_root, depth, max_depth)
  use definition, only: KTKP
  implicit none
  type(json_core) :: json
  type (KTKP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%MATX)) then
    !'TYPE(REAL_8),  DIMENSION(:,:), POINTER :: MATX => null(), MATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATX, 2), ubound(input%MATX, 2)
      call json%create_array(json_list1, 'matx')
      do i1 = lbound(input%MATX, 1), ubound(input%MATX, 1)
        call REAL_8_to_json(input%MATX(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%MATY)) then
    !'TYPE(REAL_8),  DIMENSION(:,:), POINTER :: MATX => null(), MATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATY, 2), ubound(input%MATY, 2)
      call json%create_array(json_list1, 'maty')
      do i1 = lbound(input%MATY, 1), ubound(input%MATY, 1)
        call REAL_8_to_json(input%MATY(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%lx)) then
    !'TYPE(REAL_8), DIMENSION(:), POINTER :: lx => null(), ly => null()'
    call json%create_array(json_list1, 'lx')
    do i1 = lbound(input%lx, 1), ubound(input%lx, 1)
      call REAL_8_to_json(input%lx(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ly)) then
    !'TYPE(REAL_8), DIMENSION(:), POINTER :: lx => null(), ly => null()'
    call json%create_array(json_list1, 'ly')
    do i1 = lbound(input%ly, 1), ubound(input%ly, 1)
      call REAL_8_to_json(input%ly(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call REAL_8_to_json(input%FINT(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call REAL_8_to_json(input%HGAP(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call REAL_8_to_json(input%H1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H2)) then
    call REAL_8_to_json(input%H2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VA)) then
    call REAL_8_to_json(input%VA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VS)) then
    call REAL_8_to_json(input%VS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VS')
    call json%add(json_root, json_val)
  endif
end subroutine KTKP_to_json
subroutine LAYOUT_to_json (input, json_root, depth, max_depth)
  use definition, only: LAYOUT
  implicit none
  type(json_core) :: json
  type (LAYOUT), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%NAME)) then
    call json%add(json_root, 'name', trim(input%NAME))
  endif
  if (associated(input%INDEX)) then
    call json%add(json_root, 'index', int(input%INDEX))
  endif
  if (associated(input%HARMONIC_NUMBER)) then
    call json%add(json_root, 'harmonic_number', input%HARMONIC_NUMBER)
  endif
  if (associated(input%CLOSED)) then
    call json%add(json_root, 'closed', input%CLOSED)
  endif
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%NTHIN)) then
    call json%add(json_root, 'nthin', int(input%NTHIN))
  endif
  if (associated(input%THIN)) then
    call json%add(json_root, 'thin', input%THIN)
  endif
  if (associated(input%LASTPOS)) then
    call json%add(json_root, 'lastpos', int(input%LASTPOS))
  endif
  if (associated(input%LAST)) then
    call FIBRE_to_json(input%LAST, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'LAST')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END)) then
    call FIBRE_to_json(input%END, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START)) then
    call FIBRE_to_json(input%START, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START_GROUND)) then
    call FIBRE_to_json(input%START_GROUND, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START_GROUND')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END_GROUND)) then
    call FIBRE_to_json(input%END_GROUND, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END_GROUND')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: LAYOUT%NEXT (TYPE, )
  ! config skip_members: LAYOUT%PREVIOUS (TYPE, )
  if (associated(input%T)) then
    call NODE_LAYOUT_to_json(input%T, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'T')
    call json%add(json_root, json_val)
  endif
  if (associated(input%parent_universe)) then
    call MAD_UNIVERSE_to_json(input%parent_universe, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'parent_universe')
    call json%add(json_root, json_val)
  endif
  if (associated(input%DNA)) then
    !'TYPE(layout_array), POINTER :: DNA(:)  => null()'
    call json%create_array(json_list1, 'dna')
    do i1 = lbound(input%DNA, 1), ubound(input%DNA, 1)
      call layout_array_to_json(input%DNA(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine LAYOUT_to_json
subroutine layout_array_to_json (input, json_root, depth, max_depth)
  use definition, only: layout_array
  implicit none
  type(json_core) :: json
  type (layout_array), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%L)) then
    call layout_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'counter', int(input%counter))
end subroutine layout_array_to_json
subroutine MAD_UNIVERSE_to_json (input, json_root, depth, max_depth)
  use definition, only: MAD_UNIVERSE
  implicit none
  type(json_core) :: json
  type (MAD_UNIVERSE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%SHARED)) then
    call json%add(json_root, 'shared', int(input%SHARED))
  endif
  if (associated(input%END)) then
    call LAYOUT_to_json(input%END, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START)) then
    call LAYOUT_to_json(input%START, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START')
    call json%add(json_root, json_val)
  endif
  if (associated(input%NF)) then
    call json%add(json_root, 'nf', int(input%NF))
  endif
  if (associated(input%LASTPOS)) then
    call json%add(json_root, 'lastpos', int(input%LASTPOS))
  endif
  if (associated(input%LAST)) then
    call FIBRE_to_json(input%LAST, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'LAST')
    call json%add(json_root, json_val)
  endif
end subroutine MAD_UNIVERSE_to_json
subroutine MADX_APERTURE_to_json (input, json_root, depth, max_depth)
  use definition, only: MADX_APERTURE
  implicit none
  type(json_core) :: json
  type (MADX_APERTURE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%pos)) then
    call json%add(json_root, 'pos', int(input%pos))
  endif
  if (associated(input%KIND)) then
    call json%add(json_root, 'kind', int(input%KIND))
  endif
  if (associated(input%R)) then
    !'REAL(DP),pointer :: R(:)  => null()'
    call json%create_array(json_list1, 'r')
    do i1 = lbound(input%R, 1), ubound(input%R, 1)
      call json%create_real(json_val, input%R(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%X)) then
    call json%add(json_root, 'x', input%X)
  endif
  if (associated(input%Y)) then
    call json%add(json_root, 'y', input%Y)
  endif
  if (associated(input%DX)) then
    call json%add(json_root, 'dx', input%DX)
  endif
  if (associated(input%DY)) then
    call json%add(json_root, 'dy', input%DY)
  endif
  if (associated(input%POLYGX)) then
    !'REAL(DP),pointer :: POLYGX(:)  => null(), POLYGY(:)  => null()'
    call json%create_array(json_list1, 'polygx')
    do i1 = lbound(input%POLYGX, 1), ubound(input%POLYGX, 1)
      call json%create_real(json_val, input%POLYGX(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%POLYGY)) then
    !'REAL(DP),pointer :: POLYGX(:)  => null(), POLYGY(:)  => null()'
    call json%create_array(json_list1, 'polygy')
    do i1 = lbound(input%POLYGY, 1), ubound(input%POLYGY, 1)
      call json%create_real(json_val, input%POLYGY(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%POLYGN)) then
    call json%add(json_root, 'polygn', int(input%POLYGN))
  endif
end subroutine MADX_APERTURE_to_json
subroutine MADX_SURVEY_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: MADX_SURVEY
  implicit none
  type(json_core) :: json
  type (MADX_SURVEY), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'alpha', input%ALPHA)
  call json%add(json_root, 'tilt', input%TILT)
  call json%add(json_root, 'ld', input%LD)
  call json%add(json_root, 'phi', input%PHI)
  call json%add(json_root, 'theta', input%THETA)
  call json%add(json_root, 'psi', input%PSI)
  call CHART_to_json(input%CHART, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'CHART')
  call json%add(json_root, json_val)
end subroutine MADX_SURVEY_to_json
subroutine MAGNET_CHART_to_json (input, json_root, depth, max_depth)
  use definition, only: MAGNET_CHART
  implicit none
  type(json_core) :: json
  type (MAGNET_CHART), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%f)) then
    call magnet_frame_to_json(input%f, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'f')
    call json%add(json_root, json_val)
  endif
  if (associated(input%APERTURE)) then
    call MADX_APERTURE_to_json(input%APERTURE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'APERTURE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%A)) then
    !'type(S_APERTURE), pointer:: A(:)  => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%A, 1), ubound(input%A, 1)
      call S_APERTURE_to_json(input%A(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%charge)) then
    call json%add(json_root, 'charge', input%charge)
  endif
  if (associated(input%dir)) then
    call json%add(json_root, 'dir', int(input%dir))
  endif
  if (associated(input%BETA0)) then
    call json%add(json_root, 'beta0', input%BETA0)
  endif
  if (associated(input%GAMMA0I)) then
    call json%add(json_root, 'gamma0i', input%GAMMA0I)
  endif
  if (associated(input%GAMBET)) then
    call json%add(json_root, 'gambet', input%GAMBET)
  endif
  if (associated(input%MASS)) then
    call json%add(json_root, 'mass', input%MASS)
  endif
  if (associated(input%ag)) then
    call json%add(json_root, 'ag', input%ag)
  endif
  if (associated(input%P0C)) then
    call json%add(json_root, 'p0c', input%P0C)
  endif
  if (associated(input%LD)) then
    call json%add(json_root, 'ld', input%LD)
  endif
  if (associated(input%B0)) then
    call json%add(json_root, 'b0', input%B0)
  endif
  if (associated(input%LC)) then
    call json%add(json_root, 'lc', input%LC)
  endif
  if (associated(input%TILTD)) then
    call json%add(json_root, 'tiltd', input%TILTD)
  endif
  if (associated(input%EDGE)) then
    !'real(dp),  DIMENSION(:), POINTER :: EDGE  => null()'
    call json%create_array(json_list1, 'edge')
    do i1 = lbound(input%EDGE, 1), ubound(input%EDGE, 1)
      call json%create_real(json_val, input%EDGE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%EXACT)) then
    call json%add(json_root, 'exact', input%EXACT)
  endif
  if (associated(input%KILL_ENT_FRINGE)) then
    call json%add(json_root, 'kill_ent_fringe', input%KILL_ENT_FRINGE)
  endif
  if (associated(input%KILL_EXI_FRINGE)) then
    call json%add(json_root, 'kill_exi_fringe', input%KILL_EXI_FRINGE)
  endif
  if (associated(input%bend_fringe)) then
    call json%add(json_root, 'bend_fringe', input%bend_fringe)
  endif
  if (associated(input%KILL_ENT_SPIN)) then
    call json%add(json_root, 'kill_ent_spin', input%KILL_ENT_SPIN)
  endif
  if (associated(input%KILL_EXI_SPIN)) then
    call json%add(json_root, 'kill_exi_spin', input%KILL_EXI_SPIN)
  endif
  if (associated(input%permFRINGE)) then
    call json%add(json_root, 'permfringe', int(input%permFRINGE))
  endif
  if (associated(input%highest_fringe)) then
    call json%add(json_root, 'highest_fringe', int(input%highest_fringe))
  endif
  if (associated(input%METHOD)) then
    call json%add(json_root, 'method', int(input%METHOD))
  endif
  if (associated(input%NST)) then
    call json%add(json_root, 'nst', int(input%NST))
  endif
  if (associated(input%NMUL)) then
    call json%add(json_root, 'nmul', int(input%NMUL))
  endif
end subroutine MAGNET_CHART_to_json
subroutine MAGNET_CHARTLIST_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: MAGNET_CHARTLIST
  implicit none
  type(json_core) :: json
  type (MAGNET_CHARTLIST), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) LC_LD_B0_P0(4)'
  call json%create_array(json_list1, 'lc_ld_b0_p0')
  do i1 = lbound(input%LC_LD_B0_P0, 1), ubound(input%LC_LD_B0_P0, 1)
    call json%create_real(json_val, input%LC_LD_B0_P0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) TILTD_EDGE(3)'
  call json%create_array(json_list1, 'tiltd_edge')
  do i1 = lbound(input%TILTD_EDGE, 1), ubound(input%TILTD_EDGE, 1)
    call json%create_real(json_val, input%TILTD_EDGE(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'LOGICAL(Lp) KIN_KEX_BENDFRINGE_EXACT(4)'
  call json%create_array(json_list1, 'kin_kex_bendfringe_exact')
  do i1 = lbound(input%KIN_KEX_BENDFRINGE_EXACT, 1), ubound(input%KIN_KEX_BENDFRINGE_EXACT, 1)
    call json%create_logical(json_val, input%KIN_KEX_BENDFRINGE_EXACT(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'INTEGER METHOD_NST_NMUL_permfringe_highest(5)'
  call json%create_array(json_list1, 'method_nst_nmul_permfringe_highest')
  do i1 = lbound(input%METHOD_NST_NMUL_permfringe_highest, 1), ubound(input%METHOD_NST_NMUL_permfringe_highest, 1)
    call json%create_integer(json_val, input%METHOD_NST_NMUL_permfringe_highest(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'LOGICAL(Lp) kill_spin(2)'
  call json%create_array(json_list1, 'kill_spin')
  do i1 = lbound(input%kill_spin, 1), ubound(input%kill_spin, 1)
    call json%create_logical(json_val, input%kill_spin(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine MAGNET_CHARTLIST_to_json
subroutine MAGNET_FRAME_to_json (input, json_root, depth, max_depth)
  use definition, only: MAGNET_FRAME
  implicit none
  type(json_core) :: json
  type (MAGNET_FRAME), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%A)) then
    !'REAL(DP), POINTER,DIMENSION(:)  ::   A   => null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%A, 1), ubound(input%A, 1)
      call json%create_real(json_val, input%A(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ENT)) then
    !'REAL(DP), POINTER,DIMENSION(:,:)::   ENT => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%ENT, 2), ubound(input%ENT, 2)
      call json%create_array(json_list1, 'ent')
      do i1 = lbound(input%ENT, 1), ubound(input%ENT, 1)
        call json%create_real(json_val, input%ENT(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%O)) then
    !'REAL(DP), POINTER,DIMENSION(:)  ::   O   => null()'
    call json%create_array(json_list1, 'o')
    do i1 = lbound(input%O, 1), ubound(input%O, 1)
      call json%create_real(json_val, input%O(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%MID)) then
    !'REAL(DP), POINTER,DIMENSION(:,:)::   MID => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MID, 2), ubound(input%MID, 2)
      call json%create_array(json_list1, 'mid')
      do i1 = lbound(input%MID, 1), ubound(input%MID, 1)
        call json%create_real(json_val, input%MID(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%B)) then
    !'REAL(DP), POINTER,DIMENSION(:)  ::   B   => null()'
    call json%create_array(json_list1, 'b')
    do i1 = lbound(input%B, 1), ubound(input%B, 1)
      call json%create_real(json_val, input%B(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%EXI)) then
    !'REAL(DP), POINTER,DIMENSION(:,:)::   EXI => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%EXI, 2), ubound(input%EXI, 2)
      call json%create_array(json_list1, 'exi')
      do i1 = lbound(input%EXI, 1), ubound(input%EXI, 1)
        call json%create_real(json_val, input%EXI(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine MAGNET_FRAME_to_json
subroutine MON_to_json (input, json_root, depth, max_depth)
  use definition, only: MON
  implicit none
  type(json_core) :: json
  type (MON), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%x)) then
    call json%add(json_root, 'x', input%x)
  endif
  if (associated(input%y)) then
    call json%add(json_root, 'y', input%y)
  endif
end subroutine MON_to_json
subroutine MONP_to_json (input, json_root, depth, max_depth)
  use definition, only: MONP
  implicit none
  type(json_core) :: json
  type (MONP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%x)) then
    call json%add(json_root, 'x', input%x)
  endif
  if (associated(input%y)) then
    call json%add(json_root, 'y', input%y)
  endif
end subroutine MONP_to_json
subroutine MUL_BLOCK_to_json (input, json_root, depth, max_depth)
  use definition, only: MUL_BLOCK
  implicit none
  type(json_core) :: json
  type (MUL_BLOCK), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) AN(NMAX),BN(NMAX)'
  call json%create_array(json_list1, 'an')
  do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
    call json%create_real(json_val, input%AN(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) AN(NMAX),BN(NMAX)'
  call json%create_array(json_list1, 'bn')
  do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
    call json%create_real(json_val, input%BN(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'nmul', int(input%NMUL))
  call json%add(json_root, 'natural', int(input%NATURAL))
  call json%add(json_root, 'add', int(input%ADD))
end subroutine MUL_BLOCK_to_json
subroutine my_1D_taylor_to_json (input, json_root, depth, max_depth)
  use my_own_1d_tpsa, only: my_1D_taylor
  implicit none
  type(json_core) :: json
  type (my_1D_taylor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) a(0:N_my_1D_taylor)'
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%a, 1), ubound(input%a, 1)
    call json%create_real(json_val, input%a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine my_1D_taylor_to_json
subroutine my_linear_taylor_to_json (input, json_root, depth, max_depth)
  use my_own_linear_tpsa, only: my_linear_taylor
  implicit none
  type(json_core) :: json
  type (my_linear_taylor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'complex(dp) a(0:n_mono)'
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%a, 1), ubound(input%a, 1)
    call complex_to_json(input%a(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine my_linear_taylor_to_json
subroutine node_array_to_json (input, json_root, depth, max_depth)
  use definition, only: node_array
  implicit none
  type(json_core) :: json
  type (node_array), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%t)) then
    call integration_node_to_json(input%t, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 't')
    call json%add(json_root, json_val)
  endif
  if (associated(input%pos)) then
    call json%add(json_root, 'pos', int(input%pos))
  endif
  if (associated(input%v)) then
    call json%add(json_root, 'v', input%v)
  endif
  if (associated(input%vmax)) then
    call json%add(json_root, 'vmax', input%vmax)
  endif
  if (associated(input%s)) then
    !'complex(dp), pointer :: s(:)=> null()'
    call json%create_array(json_list1, 's')
    do i1 = lbound(input%s, 1), ubound(input%s, 1)
      call complex_to_json(input%s(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%err)) then
    call json%add(json_root, 'err', input%err)
  endif
  if (associated(input%f)) then
    call c_vector_field_to_json(input%f, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'f')
    call json%add(json_root, json_val)
  endif
  if (associated(input%m)) then
    call c_damap_to_json(input%m, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'm')
    call json%add(json_root, json_val)
  endif
end subroutine node_array_to_json
subroutine NODE_LAYOUT_to_json (input, json_root, depth, max_depth)
  use definition, only: NODE_LAYOUT
  implicit none
  type(json_core) :: json
  type (NODE_LAYOUT), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%NAME)) then
    call json%add(json_root, 'name', trim(input%NAME))
  endif
  if (associated(input%INDEX)) then
    call json%add(json_root, 'index', int(input%INDEX))
  endif
  if (associated(input%CLOSED)) then
    call json%add(json_root, 'closed', input%CLOSED)
  endif
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%LASTPOS)) then
    call json%add(json_root, 'lastpos', int(input%LASTPOS))
  endif
  if (associated(input%LAST)) then
    call INTEGRATION_NODE_to_json(input%LAST, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'LAST')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END)) then
    call INTEGRATION_NODE_to_json(input%END, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START)) then
    call INTEGRATION_NODE_to_json(input%START, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START')
    call json%add(json_root, json_val)
  endif
  if (associated(input%START_GROUND)) then
    call INTEGRATION_NODE_to_json(input%START_GROUND, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'START_GROUND')
    call json%add(json_root, json_val)
  endif
  if (associated(input%END_GROUND)) then
    call INTEGRATION_NODE_to_json(input%END_GROUND, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'END_GROUND')
    call json%add(json_root, json_val)
  endif
  if (associated(input%PARENT_LAYOUT)) then
    call LAYOUT_to_json(input%PARENT_LAYOUT, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'PARENT_LAYOUT')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ORBIT_LATTICE)) then
    call ORBIT_LATTICE_to_json(input%ORBIT_LATTICE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'ORBIT_LATTICE')
    call json%add(json_root, json_val)
  endif
end subroutine NODE_LAYOUT_to_json
subroutine normalform_to_json (input, json_root, depth, max_depth)
  use definition, only: normalform
  implicit none
  type(json_core) :: json
  type (normalform), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call damap_to_json(input%A_t, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'A_t')
  call json%add(json_root, json_val)
  call damap_to_json(input%A1, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'A1')
  call json%add(json_root, json_val)
  call reversedragtfinn_to_json(input%A, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'A')
  call json%add(json_root, json_val)
  call dragtfinn_to_json(input%NORMAL, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'NORMAL')
  call json%add(json_root, json_val)
  call damap_to_json(input%DHDJ, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'DHDJ')
  call json%add(json_root, json_val)
  !'real(dp) TUNE(NDIM),DAMPING(NDIM)'
  call json%create_array(json_list1, 'tune')
  do i1 = lbound(input%TUNE, 1), ubound(input%TUNE, 1)
    call json%create_real(json_val, input%TUNE(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) TUNE(NDIM),DAMPING(NDIM)'
  call json%create_array(json_list1, 'damping')
  do i1 = lbound(input%DAMPING, 1), ubound(input%DAMPING, 1)
    call json%create_real(json_val, input%DAMPING(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'nord', int(input%nord))
  call json%add(json_root, 'jtune', int(input%jtune))
  call json%add(json_root, 'nres', int(input%NRES))
  !'integer NRES,M(NDIM,NRESO),PLANE(NDIM)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%M, 2), ubound(input%M, 2)
    call json%create_array(json_list1, 'm')
    do i1 = lbound(input%M, 1), ubound(input%M, 1)
      call json%create_integer(json_val, input%M(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'integer NRES,M(NDIM,NRESO),PLANE(NDIM)'
  call json%create_array(json_list1, 'plane')
  do i1 = lbound(input%PLANE, 1), ubound(input%PLANE, 1)
    call json%create_integer(json_val, input%PLANE(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'auto', input%AUTO)
end subroutine normalform_to_json
subroutine NSMI_to_json (input, json_root, depth, max_depth)
  use definition, only: NSMI
  implicit none
  type(json_core) :: json
  type (NSMI), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine NSMI_to_json
subroutine NSMIP_to_json (input, json_root, depth, max_depth)
  use definition, only: NSMIP
  implicit none
  type(json_core) :: json
  type (NSMIP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine NSMIP_to_json
subroutine ONELIEEXPONENT_to_json (input, json_root, depth, max_depth)
  use definition, only: ONELIEEXPONENT
  implicit none
  type(json_core) :: json
  type (ONELIEEXPONENT), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'eps', input%EPS)
  call vecfield_to_json(input%VECTOR, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'VECTOR')
  call json%add(json_root, json_val)
  call pbfield_to_json(input%pb, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'pb')
  call json%add(json_root, json_val)
end subroutine ONELIEEXPONENT_to_json
subroutine ORBIT_LATTICE_to_json (input, json_root, depth, max_depth)
  use definition, only: ORBIT_LATTICE
  implicit none
  type(json_core) :: json
  type (ORBIT_LATTICE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%ORBIT_NODES)) then
    !'TYPE(ORBIT_NODE), pointer :: ORBIT_NODES(:)  => null()'
    call json%create_array(json_list1, 'orbit_nodes')
    do i1 = lbound(input%ORBIT_NODES, 1), ubound(input%ORBIT_NODES, 1)
      call ORBIT_NODE_to_json(input%ORBIT_NODES(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ORBIT_N_NODE)) then
    call json%add(json_root, 'orbit_n_node', int(input%ORBIT_N_NODE))
  endif
  if (associated(input%ORBIT_USE_ORBIT_UNITS)) then
    call json%add(json_root, 'orbit_use_orbit_units', input%ORBIT_USE_ORBIT_UNITS)
  endif
  if (associated(input%accel)) then
    call json%add(json_root, 'accel', input%accel)
  endif
  if (associated(input%ORBIT_WARNING)) then
    call json%add(json_root, 'orbit_warning', int(input%ORBIT_WARNING))
  endif
  if (associated(input%ORBIT_LMAX)) then
    call json%add(json_root, 'orbit_lmax', input%ORBIT_LMAX)
  endif
  if (associated(input%ORBIT_MAX_PATCH_TZ)) then
    call json%add(json_root, 'orbit_max_patch_tz', input%ORBIT_MAX_PATCH_TZ)
  endif
  if (associated(input%ORBIT_mass_in_amu)) then
    call json%add(json_root, 'orbit_mass_in_amu', input%ORBIT_mass_in_amu)
  endif
  if (associated(input%ORBIT_gammat)) then
    call json%add(json_root, 'orbit_gammat', input%ORBIT_gammat)
  endif
  if (associated(input%ORBIT_harmonic)) then
    call json%add(json_root, 'orbit_harmonic', input%ORBIT_harmonic)
  endif
  if (associated(input%ORBIT_L)) then
    call json%add(json_root, 'orbit_l', input%ORBIT_L)
  endif
  if (associated(input%ORBIT_CHARGE)) then
    call json%add(json_root, 'orbit_charge', input%ORBIT_CHARGE)
  endif
  if (associated(input%ORBIT_OMEGA)) then
    call json%add(json_root, 'orbit_omega', input%ORBIT_OMEGA)
  endif
  if (associated(input%ORBIT_P0C)) then
    call json%add(json_root, 'orbit_p0c', input%ORBIT_P0C)
  endif
  if (associated(input%ORBIT_BETA0)) then
    call json%add(json_root, 'orbit_beta0', input%ORBIT_BETA0)
  endif
  if (associated(input%orbit_kinetic)) then
    call json%add(json_root, 'orbit_kinetic', input%orbit_kinetic)
  endif
  if (associated(input%orbit_brho)) then
    call json%add(json_root, 'orbit_brho', input%orbit_brho)
  endif
  if (associated(input%orbit_energy)) then
    call json%add(json_root, 'orbit_energy', input%orbit_energy)
  endif
  if (associated(input%orbit_gamma)) then
    call json%add(json_root, 'orbit_gamma', input%orbit_gamma)
  endif
  if (associated(input%orbit_deltae)) then
    call json%add(json_root, 'orbit_deltae', input%orbit_deltae)
  endif
  if (associated(input%ORBIT_OMEGA_after)) then
    call json%add(json_root, 'orbit_omega_after', input%ORBIT_OMEGA_after)
  endif
  if (associated(input%STATE)) then
    call INTERNAL_STATE_to_json(input%STATE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'STATE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%tp)) then
    call INTEGRATION_NODE_to_json(input%tp, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'tp')
    call json%add(json_root, json_val)
  endif
  if (associated(input%parent_layout)) then
    call layout_to_json(input%parent_layout, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'parent_layout')
    call json%add(json_root, json_val)
  endif
  if (associated(input%dt)) then
    !'real(dp), pointer :: dt(:)  => null()'
    call json%create_array(json_list1, 'dt')
    do i1 = lbound(input%dt, 1), ubound(input%dt, 1)
      call json%create_real(json_val, input%dt(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine ORBIT_LATTICE_to_json
subroutine ORBIT_NODE_to_json (input, json_root, depth, max_depth)
  use definition, only: ORBIT_NODE
  implicit none
  type(json_core) :: json
  type (ORBIT_NODE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%NODE)) then
    call INTEGRATION_NODE_to_json(input%NODE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'NODE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%LATTICE)) then
    !'REAL(DP), POINTER :: LATTICE(:)  => null()'
    call json%create_array(json_list1, 'lattice')
    do i1 = lbound(input%LATTICE, 1), ubound(input%LATTICE, 1)
      call json%create_real(json_val, input%LATTICE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%DPOS)) then
    call json%add(json_root, 'dpos', int(input%DPOS))
  endif
  if (associated(input%ENTERING_TASK)) then
    call json%add(json_root, 'entering_task', int(input%ENTERING_TASK))
  endif
  if (associated(input%PTC_TASK)) then
    call json%add(json_root, 'ptc_task', int(input%PTC_TASK))
  endif
  if (associated(input%cavity)) then
    call json%add(json_root, 'cavity', input%cavity)
  endif
end subroutine ORBIT_NODE_to_json
subroutine PANCAKE_to_json (input, json_root, depth, max_depth)
  use definition, only: PANCAKE
  implicit none
  type(json_core) :: json
  type (PANCAKE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%B)) then
    !'type(tree_element),  POINTER :: B(:) => null()'
    call json%create_array(json_list1, 'b')
    do i1 = lbound(input%B, 1), ubound(input%B, 1)
      call tree_element_to_json(input%B(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%SCALE)) then
    call json%add(json_root, 'scale', input%SCALE)
  endif
  if (associated(input%angc)) then
    call json%add(json_root, 'angc', input%angc)
  endif
  if (associated(input%dc)) then
    call json%add(json_root, 'dc', input%dc)
  endif
  if (associated(input%hc)) then
    call json%add(json_root, 'hc', input%hc)
  endif
  if (associated(input%xc)) then
    call json%add(json_root, 'xc', input%xc)
  endif
  if (associated(input%vc)) then
    call json%add(json_root, 'vc', input%vc)
  endif
  if (associated(input%xprime)) then
    call json%add(json_root, 'xprime', input%xprime)
  endif
end subroutine PANCAKE_to_json
subroutine PANCAKEP_to_json (input, json_root, depth, max_depth)
  use definition, only: PANCAKEP
  implicit none
  type(json_core) :: json
  type (PANCAKEP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%B)) then
    !'type(tree_element),  POINTER :: B(:) => null()'
    call json%create_array(json_list1, 'b')
    do i1 = lbound(input%B, 1), ubound(input%B, 1)
      call tree_element_to_json(input%B(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%SCALE)) then
    call REAL_8_to_json(input%SCALE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'SCALE')
    call json%add(json_root, json_val)
  endif
  if (associated(input%angc)) then
    call json%add(json_root, 'angc', input%angc)
  endif
  if (associated(input%dc)) then
    call json%add(json_root, 'dc', input%dc)
  endif
  if (associated(input%hc)) then
    call json%add(json_root, 'hc', input%hc)
  endif
  if (associated(input%xc)) then
    call json%add(json_root, 'xc', input%xc)
  endif
  if (associated(input%vc)) then
    call json%add(json_root, 'vc', input%vc)
  endif
  if (associated(input%xprime)) then
    call json%add(json_root, 'xprime', input%xprime)
  endif
end subroutine PANCAKEP_to_json
subroutine PATCH_to_json (input, json_root, depth, max_depth)
  use definition, only: PATCH
  implicit none
  type(json_core) :: json
  type (PATCH), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%PATCH)) then
    call json%add(json_root, 'patch', int(input%PATCH))
  endif
  if (associated(input%A_X1)) then
    call json%add(json_root, 'a_x1', int(input%A_X1))
  endif
  if (associated(input%A_X2)) then
    call json%add(json_root, 'a_x2', int(input%A_X2))
  endif
  if (associated(input%B_X1)) then
    call json%add(json_root, 'b_x1', int(input%B_X1))
  endif
  if (associated(input%B_X2)) then
    call json%add(json_root, 'b_x2', int(input%B_X2))
  endif
  if (associated(input%A_D)) then
    !'REAL(DP),DIMENSION(:), POINTER:: A_D => null() ,B_D => null()'
    call json%create_array(json_list1, 'a_d')
    do i1 = lbound(input%A_D, 1), ubound(input%A_D, 1)
      call json%create_real(json_val, input%A_D(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%B_D)) then
    !'REAL(DP),DIMENSION(:), POINTER:: A_D => null() ,B_D => null()'
    call json%create_array(json_list1, 'b_d')
    do i1 = lbound(input%B_D, 1), ubound(input%B_D, 1)
      call json%create_real(json_val, input%B_D(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%A_ANG)) then
    !'REAL(DP),DIMENSION(:), POINTER:: A_ANG => null() ,B_ANG => null()'
    call json%create_array(json_list1, 'a_ang')
    do i1 = lbound(input%A_ANG, 1), ubound(input%A_ANG, 1)
      call json%create_real(json_val, input%A_ANG(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%B_ANG)) then
    !'REAL(DP),DIMENSION(:), POINTER:: A_ANG => null() ,B_ANG => null()'
    call json%create_array(json_list1, 'b_ang')
    do i1 = lbound(input%B_ANG, 1), ubound(input%B_ANG, 1)
      call json%create_real(json_val, input%B_ANG(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ENERGY)) then
    call json%add(json_root, 'energy', int(input%ENERGY))
  endif
  if (associated(input%TIME)) then
    call json%add(json_root, 'time', int(input%TIME))
  endif
  if (associated(input%A_T)) then
    call json%add(json_root, 'a_t', input%A_T)
  endif
  if (associated(input%B_T)) then
    call json%add(json_root, 'b_t', input%B_T)
  endif
  if (associated(input%A_L)) then
    call json%add(json_root, 'a_l', input%A_L)
  endif
  if (associated(input%B_L)) then
    call json%add(json_root, 'b_l', input%B_L)
  endif
  if (associated(input%p0b)) then
    call json%add(json_root, 'p0b', input%p0b)
  endif
  if (associated(input%b0b)) then
    call json%add(json_root, 'b0b', input%b0b)
  endif
  if (associated(input%track)) then
    call json%add(json_root, 'track', input%track)
  endif
end subroutine PATCH_to_json
subroutine patchlist_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: patchlist
  implicit none
  type(json_core) :: json
  type (patchlist), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'a_x1', int(input%A_X1))
  call json%add(json_root, 'a_x2', int(input%A_X2))
  call json%add(json_root, 'b_x1', int(input%B_X1))
  call json%add(json_root, 'b_x2', int(input%B_X2))
  !'real(dp) A_D(3),B_D(3),A_ANG(3),B_ANG(3), A_L,B_L , A_T,B_T'
  call json%create_array(json_list1, 'a_d')
  do i1 = lbound(input%A_D, 1), ubound(input%A_D, 1)
    call json%create_real(json_val, input%A_D(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) A_D(3),B_D(3),A_ANG(3),B_ANG(3), A_L,B_L , A_T,B_T'
  call json%create_array(json_list1, 'b_d')
  do i1 = lbound(input%B_D, 1), ubound(input%B_D, 1)
    call json%create_real(json_val, input%B_D(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) A_D(3),B_D(3),A_ANG(3),B_ANG(3), A_L,B_L , A_T,B_T'
  call json%create_array(json_list1, 'a_ang')
  do i1 = lbound(input%A_ANG, 1), ubound(input%A_ANG, 1)
    call json%create_real(json_val, input%A_ANG(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) A_D(3),B_D(3),A_ANG(3),B_ANG(3), A_L,B_L , A_T,B_T'
  call json%create_array(json_list1, 'b_ang')
  do i1 = lbound(input%B_ANG, 1), ubound(input%B_ANG, 1)
    call json%create_real(json_val, input%B_ANG(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'a_l', input%A_L)
  call json%add(json_root, 'b_l', input%B_L)
  call json%add(json_root, 'a_t', input%A_T)
  call json%add(json_root, 'b_t', input%B_T)
  call json%add(json_root, 'energy', int(input%ENERGY))
  call json%add(json_root, 'time', int(input%TIME))
  call json%add(json_root, 'geometry', int(input%GEOMETRY))
  call json%add(json_root, 'track', input%track)
end subroutine patchlist_to_json
subroutine pbfield_to_json (input, json_root, depth, max_depth)
  use definition, only: pbfield
  implicit none
  type(json_core) :: json
  type (pbfield), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call taylor_to_json(input%h, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'h')
  call json%add(json_root, json_val)
  call json%add(json_root, 'ifac', int(input%ifac))
  call json%add(json_root, 'nd_used', int(input%nd_used))
end subroutine pbfield_to_json
subroutine pbresonance_to_json (input, json_root, depth, max_depth)
  use definition, only: pbresonance
  implicit none
  type(json_core) :: json
  type (pbresonance), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call pbfield_to_json(input%cos, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'cos')
  call json%add(json_root, json_val)
  call pbfield_to_json(input%sin, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'sin')
  call json%add(json_root, json_val)
  call json%add(json_root, 'ifac', int(input%ifac))
end subroutine pbresonance_to_json
subroutine POL_BLOCK_to_json (input, json_root, depth, max_depth)
  use definition, only: POL_BLOCK
  implicit none
  type(json_core) :: json
  type (POL_BLOCK), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'name', trim(input%NAME))
  call json%add(json_root, 'n_name', int(input%n_name))
  call json%add(json_root, 'vorname', trim(input%VORNAME))
  if (associated(input%TPSAFIT)) then
    !'real(dp),DIMENSION(:), POINTER :: TPSAFIT => null()'
    call json%create_array(json_list1, 'tpsafit')
    do i1 = lbound(input%TPSAFIT, 1), ubound(input%TPSAFIT, 1)
      call json%create_real(json_val, input%TPSAFIT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%SET_TPSAFIT)) then
    call json%add(json_root, 'set_tpsafit', input%SET_TPSAFIT)
  endif
  if (associated(input%SET_ELEMENT)) then
    call json%add(json_root, 'set_element', input%SET_ELEMENT)
  endif
  call json%add(json_root, 'npara', int(input%NPARA))
  !'INTEGER IAN(NMAX),IBN(NMAX)'
  call json%create_array(json_list1, 'ian')
  do i1 = lbound(input%IAN, 1), ubound(input%IAN, 1)
    call json%create_integer(json_val, input%IAN(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'INTEGER IAN(NMAX),IBN(NMAX)'
  call json%create_array(json_list1, 'ibn')
  do i1 = lbound(input%IBN, 1), ubound(input%IBN, 1)
    call json%create_integer(json_val, input%IBN(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) SAN(NMAX),SBN(NMAX)'
  call json%create_array(json_list1, 'san')
  do i1 = lbound(input%SAN, 1), ubound(input%SAN, 1)
    call json%create_real(json_val, input%SAN(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) SAN(NMAX),SBN(NMAX)'
  call json%create_array(json_list1, 'sbn')
  do i1 = lbound(input%SBN, 1), ubound(input%SBN, 1)
    call json%create_real(json_val, input%SBN(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ivolt', int(input%IVOLT))
  call json%add(json_root, 'ifreq', int(input%IFREQ))
  call json%add(json_root, 'iphas', int(input%IPHAS))
  call json%add(json_root, 'ib_sol', int(input%IB_SOL))
  call json%add(json_root, 'svolt', input%SVOLT)
  call json%add(json_root, 'sfreq', input%SFREQ)
  call json%add(json_root, 'sphas', input%SPHAS)
  call json%add(json_root, 'sb_sol', input%SB_SOL)
  ! parent pointer skip: g (integer, group index  number of blocks)
  call json%add(json_root, 'np', int(input%np))
  call json%add(json_root, 'nb', int(input%nb))
  call POL_BLOCK_sagan_to_json(input%sagan, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'sagan')
  call json%add(json_root, json_val)
end subroutine POL_BLOCK_to_json
subroutine POL_BLOCK_INICOND_to_json (input, json_root, depth, max_depth)
  use definition, only: POL_BLOCK_INICOND
  implicit none
  type(json_core) :: json
  type (POL_BLOCK_INICOND), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'INTEGER       :: BETA(3)'
  call json%create_array(json_list1, 'beta')
  do i1 = lbound(input%BETA, 1), ubound(input%BETA, 1)
    call json%create_integer(json_val, input%BETA(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'INTEGER       :: ALFA(3)'
  call json%create_array(json_list1, 'alfa')
  do i1 = lbound(input%ALFA, 1), ubound(input%ALFA, 1)
    call json%create_integer(json_val, input%ALFA(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'INTEGER       :: DISPERSION(4)'
  call json%create_array(json_list1, 'dispersion')
  do i1 = lbound(input%DISPERSION, 1), ubound(input%DISPERSION, 1)
    call json%create_integer(json_val, input%DISPERSION(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine POL_BLOCK_INICOND_to_json
subroutine POL_BLOCK_sagan_to_json (input, json_root, depth, max_depth)
  use definition, only: POL_BLOCK_sagan
  implicit none
  type(json_core) :: json
  type (POL_BLOCK_sagan), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'INTEGER Iinternal(6)'
  call json%create_array(json_list1, 'iinternal')
  do i1 = lbound(input%Iinternal, 1), ubound(input%Iinternal, 1)
    call json%create_integer(json_val, input%Iinternal(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) SInternal(6)'
  call json%create_array(json_list1, 'sinternal')
  do i1 = lbound(input%SInternal, 1), ubound(input%SInternal, 1)
    call json%create_real(json_val, input%SInternal(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call POL_sagan_to_json(input%w, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'w')
  call json%add(json_root, json_val)
end subroutine POL_BLOCK_sagan_to_json
subroutine POL_sagan_to_json (input, json_root, depth, max_depth)
  use definition, only: POL_sagan
  implicit none
  type(json_core) :: json
  type (POL_sagan), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'INTEGER ia(n_max)'
  call json%create_array(json_list1, 'ia')
  do i1 = lbound(input%ia, 1), ubound(input%ia, 1)
    call json%create_integer(json_val, input%ia(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) Sa(n_max)'
  call json%create_array(json_list1, 'sa')
  do i1 = lbound(input%Sa, 1), ubound(input%Sa, 1)
    call json%create_real(json_val, input%Sa(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine POL_sagan_to_json
subroutine probe_to_json (input, json_root, depth, max_depth)
  use definition, only: probe
  implicit none
  type(json_core) :: json
  type (probe), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) x(6)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call json%create_real(json_val, input%x(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'type(spinor) s(3)'
  call json%create_array(json_list1, 's')
  do i1 = lbound(input%s, 1), ubound(input%s, 1)
    call spinor_to_json(input%s(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call quaternion_to_json(input%q, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'q')
  call json%add(json_root, json_val)
  !'type(rf_phasor)  AC(nacmax)'
  call json%create_array(json_list1, 'ac')
  do i1 = lbound(input%AC, 1), ubound(input%AC, 1)
    call rf_phasor_to_json(input%AC(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'nac', int(input%nac))
  ! parent pointer skip: u (logical, )
  call json%add(json_root, 'use_q', input%use_q)
  if (associated(input%last_node)) then
    call integration_node_to_json(input%last_node, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'last_node')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'e', input%e)
end subroutine probe_to_json
subroutine probe_8_to_json (input, json_root, depth, max_depth)
  use definition, only: probe_8
  implicit none
  type(json_core) :: json
  type (probe_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type(real_8) x(6)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call real_8_to_json(input%x(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'type(spinor_8) s(3)'
  call json%create_array(json_list1, 's')
  do i1 = lbound(input%s, 1), ubound(input%s, 1)
    call spinor_8_to_json(input%s(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call quaternion_8_to_json(input%q, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'q')
  call json%add(json_root, json_val)
  !'type(rf_phasor_8)  ac(nacmax)'
  call json%create_array(json_list1, 'ac')
  do i1 = lbound(input%ac, 1), ubound(input%ac, 1)
    call rf_phasor_8_to_json(input%ac(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'nac', int(input%nac))
  !'real(dp) E_ij(6,6)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%E_ij, 2), ubound(input%E_ij, 2)
    call json%create_array(json_list1, 'e_ij')
    do i1 = lbound(input%E_ij, 1), ubound(input%E_ij, 1)
      call json%create_real(json_val, input%E_ij(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp) x0(6)'
  call json%create_array(json_list1, 'x0')
  do i1 = lbound(input%x0, 1), ubound(input%x0, 1)
    call json%create_real(json_val, input%x0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  ! parent pointer skip: u (logical, )
  call json%add(json_root, 'use_q', input%use_q)
  if (associated(input%last_node)) then
    call integration_node_to_json(input%last_node, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'last_node')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'e', input%e)
end subroutine probe_8_to_json
subroutine quaternion_to_json (input, json_root, depth, max_depth)
  use definition, only: quaternion
  implicit none
  type(json_core) :: json
  type (quaternion), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) x(0:3)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call json%create_real(json_val, input%x(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine quaternion_to_json
subroutine quaternion_8_to_json (input, json_root, depth, max_depth)
  use definition, only: quaternion_8
  implicit none
  type(json_core) :: json
  type (quaternion_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type(real_8) x(0:3)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call real_8_to_json(input%x(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine quaternion_8_to_json
subroutine R_XY_to_json (input, json_root, depth, max_depth)
  use s_euclidean, only: R_XY
  implicit none
  type(json_core) :: json
  type (R_XY), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'REAL(DP) A(2)'
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%A, 1), ubound(input%A, 1)
    call json%create_real(json_val, input%A(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine R_XY_to_json
subroutine R_Z_to_json (input, json_root, depth, max_depth)
  use s_euclidean, only: R_Z
  implicit none
  type(json_core) :: json
  type (R_Z), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'a', input%A)
end subroutine R_Z_to_json
subroutine ramping_to_json (input, json_root, depth, max_depth)
  use definition, only: ramping
  implicit none
  type(json_core) :: json
  type (ramping), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%n)) then
    call json%add(json_root, 'n', int(input%n))
  endif
  if (associated(input%r)) then
    call json%add(json_root, 'r', input%r)
  endif
  if (associated(input%t_max)) then
    call json%add(json_root, 't_max', input%t_max)
  endif
  if (associated(input%table)) then
    !'type(time_energy),pointer :: table(:) => null()'
    call json%create_array(json_list1, 'table')
    do i1 = lbound(input%table, 1), ubound(input%table, 1)
      call time_energy_to_json(input%table(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%file)) then
    call json%add(json_root, 'file', trim(input%file))
  endif
end subroutine ramping_to_json
subroutine RCOL_to_json (input, json_root, depth, max_depth)
  use definition, only: RCOL
  implicit none
  type(json_core) :: json
  type (RCOL), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
end subroutine RCOL_to_json
subroutine RCOLP_to_json (input, json_root, depth, max_depth)
  use definition, only: RCOLP
  implicit none
  type(json_core) :: json
  type (RCOLP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
end subroutine RCOLP_to_json
subroutine REAL_8_to_json (input, json_root, depth, max_depth)
  use definition, only: REAL_8
  implicit none
  type(json_core) :: json
  type (REAL_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call TAYLOR_to_json(input%T, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'T')
  call json%add(json_root, json_val)
  call json%add(json_root, 'r', input%R)
  call json%add(json_root, 'kind', int(input%KIND))
  call json%add(json_root, 'i', int(input%I))
  call json%add(json_root, 's', input%S)
  call json%add(json_root, 'alloc', input%ALLOC)
end subroutine REAL_8_to_json
subroutine reversedragtfinn_to_json (input, json_root, depth, max_depth)
  use definition, only: reversedragtfinn
  implicit none
  type(json_core) :: json
  type (reversedragtfinn), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp)  CONSTANT(NDIM2)'
  call json%create_array(json_list1, 'constant')
  do i1 = lbound(input%CONSTANT, 1), ubound(input%CONSTANT, 1)
    call json%create_real(json_val, input%CONSTANT(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call damap_to_json(input%Linear, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'Linear')
  call json%add(json_root, json_val)
  call vecfield_to_json(input%nonlinear, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'nonlinear')
  call json%add(json_root, json_val)
  call pbfield_to_json(input%pb, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'pb')
  call json%add(json_root, json_val)
end subroutine reversedragtfinn_to_json
subroutine rf_phasor_to_json (input, json_root, depth, max_depth)
  use definition, only: rf_phasor
  implicit none
  type(json_core) :: json
  type (rf_phasor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) x(2)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call json%create_real(json_val, input%x(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'om', input%om)
  call json%add(json_root, 't', input%t)
end subroutine rf_phasor_to_json
subroutine rf_phasor_8_to_json (input, json_root, depth, max_depth)
  use definition, only: rf_phasor_8
  implicit none
  type(json_core) :: json
  type (rf_phasor_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type(real_8)  x(2)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call real_8_to_json(input%x(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call real_8_to_json(input%om, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'om')
  call json%add(json_root, json_val)
  call json%add(json_root, 't', input%t)
end subroutine rf_phasor_8_to_json
subroutine S_APERTURE_to_json (input, json_root, depth, max_depth)
  use definition, only: S_APERTURE
  implicit none
  type(json_core) :: json
  type (S_APERTURE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%APERTURE)) then
    call MADX_APERTURE_to_json(input%APERTURE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'APERTURE')
    call json%add(json_root, json_val)
  endif
end subroutine S_APERTURE_to_json
subroutine SAGAN_to_json (input, json_root, depth, max_depth)
  use definition, only: SAGAN
  implicit none
  type(json_core) :: json
  type (SAGAN), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%n_min)) then
    call json%add(json_root, 'n_min', int(input%n_min))
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN=> null(),BN=> null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN=> null(),BN=> null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%INTERNAL)) then
    !'real(dp),  DIMENSION(:),  POINTER ::INTERNAL  => null()'
    call json%create_array(json_list1, 'internal')
    do i1 = lbound(input%INTERNAL, 1), ubound(input%INTERNAL, 1)
      call json%create_real(json_val, input%INTERNAL(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%xprime)) then
    call json%add(json_root, 'xprime', input%xprime)
  endif
  if (associated(input%W)) then
    call undu_R_to_json(input%W, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'W')
    call json%add(json_root, json_val)
  endif
end subroutine SAGAN_to_json
subroutine SAGANP_to_json (input, json_root, depth, max_depth)
  use definition, only: SAGANP
  implicit none
  type(json_core) :: json
  type (SAGANP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%n_min)) then
    call json%add(json_root, 'n_min', int(input%n_min))
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN=> null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN=> null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%INTERNAL)) then
    !'TYPE(REAL_8), DIMENSION(:),POINTER ::INTERNAL=> null()'
    call json%create_array(json_list1, 'internal')
    do i1 = lbound(input%INTERNAL, 1), ubound(input%INTERNAL, 1)
      call REAL_8_to_json(input%INTERNAL(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%xprime)) then
    call json%add(json_root, 'xprime', input%xprime)
  endif
  if (associated(input%W)) then
    call undu_p_to_json(input%W, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'W')
    call json%add(json_root, json_val)
  endif
end subroutine SAGANP_to_json
subroutine siam_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: siam_list
  implicit none
  type(json_core) :: json
  type (siam_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) angle(3)'
  call json%create_array(json_list1, 'angle')
  do i1 = lbound(input%angle, 1), ubound(input%angle, 1)
    call json%create_real(json_val, input%angle(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) d(3)'
  call json%create_array(json_list1, 'd')
  do i1 = lbound(input%d, 1), ubound(input%d, 1)
    call json%create_real(json_val, input%d(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine siam_list_to_json
subroutine SOL5_to_json (input, json_root, depth, max_depth)
  use definition, only: SOL5
  implicit none
  type(json_core) :: json
  type (SOL5), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%B_SOL)) then
    call json%add(json_root, 'b_sol', input%B_SOL)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(),BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'real(dp), DIMENSION(:),    POINTER:: FINT => null(),HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call json%create_real(json_val, input%FINT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'real(dp), DIMENSION(:),    POINTER:: FINT => null(),HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call json%create_real(json_val, input%HGAP(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call json%add(json_root, 'h1', input%H1)
  endif
  if (associated(input%H2)) then
    call json%add(json_root, 'h2', input%H2)
  endif
  if (associated(input%VA)) then
    call json%add(json_root, 'va', input%VA)
  endif
  if (associated(input%VS)) then
    call json%add(json_root, 'vs', input%VS)
  endif
  if (associated(input%dx)) then
    call json%add(json_root, 'dx', input%dx)
  endif
  if (associated(input%dy)) then
    call json%add(json_root, 'dy', input%dy)
  endif
  if (associated(input%pitch_x)) then
    call json%add(json_root, 'pitch_x', input%pitch_x)
  endif
  if (associated(input%pitch_y)) then
    call json%add(json_root, 'pitch_y', input%pitch_y)
  endif
end subroutine SOL5_to_json
subroutine sol5_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: sol5_list
  implicit none
  type(json_core) :: json
  type (sol5_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) dx_dy_pitchx_pitchy(4)'
  call json%create_array(json_list1, 'dx_dy_pitchx_pitchy')
  do i1 = lbound(input%dx_dy_pitchx_pitchy, 1), ubound(input%dx_dy_pitchx_pitchy, 1)
    call json%create_real(json_val, input%dx_dy_pitchx_pitchy(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine sol5_list_to_json
subroutine SOL5P_to_json (input, json_root, depth, max_depth)
  use definition, only: SOL5P
  implicit none
  type(json_core) :: json
  type (SOL5P), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%B_SOL)) then
    call REAL_8_to_json(input%B_SOL, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'B_SOL')
    call json%add(json_root, json_val)
  endif
  if (associated(input%FINT)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call REAL_8_to_json(input%FINT(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call REAL_8_to_json(input%HGAP(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call REAL_8_to_json(input%H1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H2)) then
    call REAL_8_to_json(input%H2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VA)) then
    call REAL_8_to_json(input%VA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VS)) then
    call REAL_8_to_json(input%VS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%dx)) then
    call json%add(json_root, 'dx', input%dx)
  endif
  if (associated(input%dy)) then
    call json%add(json_root, 'dy', input%dy)
  endif
  if (associated(input%pitch_x)) then
    call json%add(json_root, 'pitch_x', input%pitch_x)
  endif
  if (associated(input%pitch_y)) then
    call json%add(json_root, 'pitch_y', input%pitch_y)
  endif
end subroutine SOL5P_to_json
subroutine spinor_to_json (input, json_root, depth, max_depth)
  use definition, only: spinor
  implicit none
  type(json_core) :: json
  type (spinor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) x(3)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call json%create_real(json_val, input%x(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine spinor_to_json
subroutine spinor_8_to_json (input, json_root, depth, max_depth)
  use definition, only: spinor_8
  implicit none
  type(json_core) :: json
  type (spinor_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type(real_8) x(3)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call real_8_to_json(input%x(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine spinor_8_to_json
subroutine SSMI_to_json (input, json_root, depth, max_depth)
  use definition, only: SSMI
  implicit none
  type(json_core) :: json
  type (SSMI), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN  => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine SSMI_to_json
subroutine SSMIP_to_json (input, json_root, depth, max_depth)
  use definition, only: SSMIP
  implicit none
  type(json_core) :: json
  type (SSMIP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine SSMIP_to_json
subroutine STREX_to_json (input, json_root, depth, max_depth)
  use definition, only: STREX
  implicit none
  type(json_core) :: json
  type (STREX), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%DRIFTKICK)) then
    call json%add(json_root, 'driftkick', input%DRIFTKICK)
  endif
  if (associated(input%FINT)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call json%create_real(json_val, input%FINT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call json%create_real(json_val, input%HGAP(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call json%add(json_root, 'h1', input%H1)
  endif
  if (associated(input%H2)) then
    call json%add(json_root, 'h2', input%H2)
  endif
  if (associated(input%VA)) then
    call json%add(json_root, 'va', input%VA)
  endif
  if (associated(input%VS)) then
    call json%add(json_root, 'vs', input%VS)
  endif
  if (associated(input%f)) then
    call json%add(json_root, 'f', int(input%f))
  endif
end subroutine STREX_to_json
subroutine STREXP_to_json (input, json_root, depth, max_depth)
  use definition, only: STREXP
  implicit none
  type(json_core) :: json
  type (STREXP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%DRIFTKICK)) then
    call json%add(json_root, 'driftkick', input%DRIFTKICK)
  endif
  if (associated(input%FINT)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call REAL_8_to_json(input%FINT(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call REAL_8_to_json(input%HGAP(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call REAL_8_to_json(input%H1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H2)) then
    call REAL_8_to_json(input%H2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VA)) then
    call REAL_8_to_json(input%VA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VS)) then
    call REAL_8_to_json(input%VS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%f)) then
    call json%add(json_root, 'f', int(input%f))
  endif
end subroutine STREXP_to_json
subroutine sub_taylor_to_json (input, json_root, depth, max_depth)
  use definition, only: sub_taylor
  implicit none
  type(json_core) :: json
  type (sub_taylor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'INTEGER j(lnv)'
  call json%create_array(json_list1, 'j')
  do i1 = lbound(input%j, 1), ubound(input%j, 1)
    call json%create_integer(json_val, input%j(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'min', int(input%min))
  call json%add(json_root, 'max', int(input%max))
end subroutine sub_taylor_to_json
subroutine SUPERDRIFT_to_json (input, json_root, depth, max_depth)
  use definition, only: SUPERDRIFT
  implicit none
  type(json_core) :: json
  type (SUPERDRIFT), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%D)) then
    !'REAL(DP),DIMENSION(:), POINTER:: D => null(),ang => null()'
    call json%create_array(json_list1, 'd')
    do i1 = lbound(input%D, 1), ubound(input%D, 1)
      call json%create_real(json_val, input%D(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ang)) then
    !'REAL(DP),DIMENSION(:), POINTER:: D => null(),ang => null()'
    call json%create_array(json_list1, 'ang')
    do i1 = lbound(input%ang, 1), ubound(input%ang, 1)
      call json%create_real(json_val, input%ang(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%A_X1)) then
    call json%add(json_root, 'a_x1', int(input%A_X1))
  endif
  if (associated(input%A_X2)) then
    call json%add(json_root, 'a_x2', int(input%A_X2))
  endif
end subroutine SUPERDRIFT_to_json
subroutine SUPERDRIFTP_to_json (input, json_root, depth, max_depth)
  use definition, only: SUPERDRIFTP
  implicit none
  type(json_core) :: json
  type (SUPERDRIFTP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%D)) then
    !'REAL(DP),DIMENSION(:), POINTER:: D => null(),ang => null()'
    call json%create_array(json_list1, 'd')
    do i1 = lbound(input%D, 1), ubound(input%D, 1)
      call json%create_real(json_val, input%D(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ang)) then
    !'REAL(DP),DIMENSION(:), POINTER:: D => null(),ang => null()'
    call json%create_array(json_list1, 'ang')
    do i1 = lbound(input%ang, 1), ubound(input%ang, 1)
      call json%create_real(json_val, input%ang(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%A_X1)) then
    call json%add(json_root, 'a_x1', int(input%A_X1))
  endif
  if (associated(input%A_X2)) then
    call json%add(json_root, 'a_x2', int(input%A_X2))
  endif
end subroutine SUPERDRIFTP_to_json
subroutine T_XYZ_to_json (input, json_root, depth, max_depth)
  use s_euclidean, only: T_XYZ
  implicit none
  type(json_core) :: json
  type (T_XYZ), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'sixtrack', input%SIXTRACK)
  call json%add(json_root, 'l_design', input%L_DESIGN)
  call json%add(json_root, 'dl_sixtrack', input%DL_SIXTRACK)
  !'REAL(DP) D(3),DL'
  call json%create_array(json_list1, 'd')
  do i1 = lbound(input%D, 1), ubound(input%D, 1)
    call json%create_real(json_val, input%D(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'dl', input%DL)
end subroutine T_XYZ_to_json
subroutine taylor_to_json (input, json_root, depth, max_depth)
  use definition, only: taylor
  implicit none
  type(json_core) :: json
  type (taylor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'i', int(input%I))
end subroutine taylor_to_json
subroutine taylorresonance_to_json (input, json_root, depth, max_depth)
  use definition, only: taylorresonance
  implicit none
  type(json_core) :: json
  type (taylorresonance), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call taylor_to_json(input%cos, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'cos')
  call json%add(json_root, json_val)
  call taylor_to_json(input%sin, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'sin')
  call json%add(json_root, json_val)
end subroutine taylorresonance_to_json
subroutine tcav_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: tcav_list
  implicit none
  type(json_core) :: json
  type (tcav_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) PSI_DPHAS_DVDS_phase0(4)'
  call json%create_array(json_list1, 'psi_dphas_dvds_phase0')
  do i1 = lbound(input%PSI_DPHAS_DVDS_phase0, 1), ubound(input%PSI_DPHAS_DVDS_phase0, 1)
    call json%create_real(json_val, input%PSI_DPHAS_DVDS_phase0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'always_on', input%always_on)
  call json%add(json_root, 'implicit', input%implicit)
end subroutine tcav_list_to_json
subroutine TEAPOT_to_json (input, json_root, depth, max_depth)
  use definition, only: TEAPOT
  implicit none
  type(json_core) :: json
  type (TEAPOT), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%b_sol)) then
    call json%add(json_root, 'b_sol', input%b_sol)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%bf_x)) then
    !'real(dp),  DIMENSION(:), POINTER :: bf_x => null(),bf_y => null()'
    call json%create_array(json_list1, 'bf_x')
    do i1 = lbound(input%bf_x, 1), ubound(input%bf_x, 1)
      call json%create_real(json_val, input%bf_x(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%bf_y)) then
    !'real(dp),  DIMENSION(:), POINTER :: bf_x => null(),bf_y => null()'
    call json%create_array(json_list1, 'bf_y')
    do i1 = lbound(input%bf_y, 1), ubound(input%bf_y, 1)
      call json%create_real(json_val, input%bf_y(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%DRIFTKICK)) then
    call json%add(json_root, 'driftkick', input%DRIFTKICK)
  endif
  if (associated(input%FINT)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call json%create_real(json_val, input%FINT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call json%create_real(json_val, input%HGAP(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call json%add(json_root, 'h1', input%H1)
  endif
  if (associated(input%H2)) then
    call json%add(json_root, 'h2', input%H2)
  endif
  if (associated(input%f)) then
    call json%add(json_root, 'f', int(input%f))
  endif
  if (associated(input%VA)) then
    call json%add(json_root, 'va', input%VA)
  endif
  if (associated(input%VS)) then
    call json%add(json_root, 'vs', input%VS)
  endif
  if (associated(input%AE)) then
    !'real(dp),  DIMENSION(:), POINTER :: AE => null(), BE => null()'
    call json%create_array(json_list1, 'ae')
    do i1 = lbound(input%AE, 1), ubound(input%AE, 1)
      call json%create_real(json_val, input%AE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BE)) then
    !'real(dp),  DIMENSION(:), POINTER :: AE => null(), BE => null()'
    call json%create_array(json_list1, 'be')
    do i1 = lbound(input%BE, 1), ubound(input%BE, 1)
      call json%create_real(json_val, input%BE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%e_x)) then
    !'real(dp),  DIMENSION(:),  POINTER :: e_x => null(),e_y => null(),PHI => null(),vm => null()'
    call json%create_array(json_list1, 'e_x')
    do i1 = lbound(input%e_x, 1), ubound(input%e_x, 1)
      call json%create_real(json_val, input%e_x(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%e_y)) then
    !'real(dp),  DIMENSION(:),  POINTER :: e_x => null(),e_y => null(),PHI => null(),vm => null()'
    call json%create_array(json_list1, 'e_y')
    do i1 = lbound(input%e_y, 1), ubound(input%e_y, 1)
      call json%create_real(json_val, input%e_y(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%PHI)) then
    !'real(dp),  DIMENSION(:),  POINTER :: e_x => null(),e_y => null(),PHI => null(),vm => null()'
    call json%create_array(json_list1, 'phi')
    do i1 = lbound(input%PHI, 1), ubound(input%PHI, 1)
      call json%create_real(json_val, input%PHI(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%vm)) then
    !'real(dp),  DIMENSION(:),  POINTER :: e_x => null(),e_y => null(),PHI => null(),vm => null()'
    call json%create_array(json_list1, 'vm')
    do i1 = lbound(input%vm, 1), ubound(input%vm, 1)
      call json%create_real(json_val, input%vm(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ELECTRIC)) then
    call json%add(json_root, 'electric', input%ELECTRIC)
  endif
end subroutine TEAPOT_to_json
subroutine TEAPOTP_to_json (input, json_root, depth, max_depth)
  use definition, only: TEAPOTP
  implicit none
  type(json_core) :: json
  type (TEAPOTP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%b_sol)) then
    call REAL_8_to_json(input%b_sol, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'b_sol')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%bf_x)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: bf_x => null(),bf_y => null()'
    call json%create_array(json_list1, 'bf_x')
    do i1 = lbound(input%bf_x, 1), ubound(input%bf_x, 1)
      call REAL_8_to_json(input%bf_x(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%bf_y)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: bf_x => null(),bf_y => null()'
    call json%create_array(json_list1, 'bf_y')
    do i1 = lbound(input%bf_y, 1), ubound(input%bf_y, 1)
      call REAL_8_to_json(input%bf_y(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%DRIFTKICK)) then
    call json%add(json_root, 'driftkick', input%DRIFTKICK)
  endif
  if (associated(input%FINT)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call REAL_8_to_json(input%FINT(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call REAL_8_to_json(input%HGAP(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call REAL_8_to_json(input%H1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H2)) then
    call REAL_8_to_json(input%H2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%f)) then
    call json%add(json_root, 'f', int(input%f))
  endif
  if (associated(input%VA)) then
    call REAL_8_to_json(input%VA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VS)) then
    call REAL_8_to_json(input%VS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AE)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AE => null(), BE => null()'
    call json%create_array(json_list1, 'ae')
    do i1 = lbound(input%AE, 1), ubound(input%AE, 1)
      call REAL_8_to_json(input%AE(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BE)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AE => null(), BE => null()'
    call json%create_array(json_list1, 'be')
    do i1 = lbound(input%BE, 1), ubound(input%BE, 1)
      call REAL_8_to_json(input%BE(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%e_x)) then
    !'TYPE(REAL_8),  DIMENSION(:),  POINTER :: e_x => null(),e_y => null(),PHI => null(),vm => null()'
    call json%create_array(json_list1, 'e_x')
    do i1 = lbound(input%e_x, 1), ubound(input%e_x, 1)
      call REAL_8_to_json(input%e_x(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%e_y)) then
    !'TYPE(REAL_8),  DIMENSION(:),  POINTER :: e_x => null(),e_y => null(),PHI => null(),vm => null()'
    call json%create_array(json_list1, 'e_y')
    do i1 = lbound(input%e_y, 1), ubound(input%e_y, 1)
      call REAL_8_to_json(input%e_y(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%PHI)) then
    !'TYPE(REAL_8),  DIMENSION(:),  POINTER :: e_x => null(),e_y => null(),PHI => null(),vm => null()'
    call json%create_array(json_list1, 'phi')
    do i1 = lbound(input%PHI, 1), ubound(input%PHI, 1)
      call REAL_8_to_json(input%PHI(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%vm)) then
    !'TYPE(REAL_8),  DIMENSION(:),  POINTER :: e_x => null(),e_y => null(),PHI => null(),vm => null()'
    call json%create_array(json_list1, 'vm')
    do i1 = lbound(input%vm, 1), ubound(input%vm, 1)
      call REAL_8_to_json(input%vm(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ELECTRIC)) then
    call json%add(json_root, 'electric', input%ELECTRIC)
  endif
end subroutine TEAPOTP_to_json
subroutine TEMPORAL_BEAM_to_json (input, json_root, depth, max_depth)
  use definition, only: TEMPORAL_BEAM
  implicit none
  type(json_core) :: json
  type (TEMPORAL_BEAM), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%TP)) then
    !'TYPE(TEMPORAL_PROBE), pointer :: TP(:)'
    call json%create_array(json_list1, 'tp')
    do i1 = lbound(input%TP, 1), ubound(input%TP, 1)
      call TEMPORAL_PROBE_to_json(input%TP(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  !'real(DP) a(3),ent(3,3),p0c,total_time'
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%a, 1), ubound(input%a, 1)
    call json%create_real(json_val, input%a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(DP) a(3),ent(3,3),p0c,total_time'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%ent, 2), ubound(input%ent, 2)
    call json%create_array(json_list1, 'ent')
    do i1 = lbound(input%ent, 1), ubound(input%ent, 1)
      call json%create_real(json_val, input%ent(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'p0c', input%p0c)
  call json%add(json_root, 'total_time', input%total_time)
  call json%add(json_root, 'n', int(input%n))
  if (associated(input%c)) then
    call integration_node_to_json(input%c, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'c')
    call json%add(json_root, json_val)
  endif
  call internal_state_to_json(input%state, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'state')
  call json%add(json_root, json_val)
end subroutine TEMPORAL_BEAM_to_json
subroutine TEMPORAL_PROBE_to_json (input, json_root, depth, max_depth)
  use definition, only: TEMPORAL_PROBE
  implicit none
  type(json_core) :: json
  type (TEMPORAL_PROBE), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call probe_to_json(input%XS, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'XS')
  call json%add(json_root, json_val)
  if (associated(input%NODE)) then
    call INTEGRATION_NODE_to_json(input%NODE, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'NODE')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'r', input%r)
  call json%add(json_root, 'dt0', input%dt0)
  !'real(DP)   POS(6),T'
  call json%create_array(json_list1, 'pos')
  do i1 = lbound(input%POS, 1), ubound(input%POS, 1)
    call json%create_real(json_val, input%POS(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 't', input%T)
  !'real(DP)   IC(3)'
  call json%create_array(json_list1, 'ic')
  do i1 = lbound(input%IC, 1), ubound(input%IC, 1)
    call json%create_real(json_val, input%IC(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'type(spinor) s(3)'
  call json%create_array(json_list1, 's')
  do i1 = lbound(input%s, 1), ubound(input%s, 1)
    call spinor_to_json(input%s(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine TEMPORAL_PROBE_to_json
subroutine temps_energie_to_json (input, json_root, depth, max_depth)
  use definition, only: temps_energie
  implicit none
  type(json_core) :: json
  type (temps_energie), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%temps)) then
    call json%add(json_root, 'temps', input%temps)
  endif
  if (associated(input%energie)) then
    call json%add(json_root, 'energie', input%energie)
  endif
  if (associated(input%volt)) then
    !'real(dp),pointer :: volt(:)=> null(),phase(:)=> null(),tc=> null()'
    call json%create_array(json_list1, 'volt')
    do i1 = lbound(input%volt, 1), ubound(input%volt, 1)
      call json%create_real(json_val, input%volt(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%phase)) then
    !'real(dp),pointer :: volt(:)=> null(),phase(:)=> null(),tc=> null()'
    call json%create_array(json_list1, 'phase')
    do i1 = lbound(input%phase, 1), ubound(input%phase, 1)
      call json%create_real(json_val, input%phase(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%tc)) then
    call json%add(json_root, 'tc', input%tc)
  endif
end subroutine temps_energie_to_json
subroutine thin3_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: thin3_list
  implicit none
  type(json_core) :: json
  type (thin3_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'thin_h_foc', input%thin_h_foc)
  call json%add(json_root, 'thin_v_foc', input%thin_v_foc)
  call json%add(json_root, 'thin_h_angle', input%thin_h_angle)
  call json%add(json_root, 'thin_v_angle', input%thin_v_angle)
  call json%add(json_root, 'hf', input%hf)
  call json%add(json_root, 'vf', input%vf)
  call json%add(json_root, 'ls', input%ls)
  call json%add(json_root, 'patch', input%patch)
  !'real(dp) dx_dy_pitchx_pitchy(4)'
  call json%create_array(json_list1, 'dx_dy_pitchx_pitchy')
  do i1 = lbound(input%dx_dy_pitchx_pitchy, 1), ubound(input%dx_dy_pitchx_pitchy, 1)
    call json%create_real(json_val, input%dx_dy_pitchx_pitchy(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine thin3_list_to_json
subroutine three_d_info_to_json (input, json_root, depth, max_depth)
  use ptc_multiparticle, only: three_d_info
  implicit none
  type(json_core) :: json
  type (three_d_info), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp)  a(3),b(3)'
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%a, 1), ubound(input%a, 1)
    call json%create_real(json_val, input%a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp)  a(3),b(3)'
  call json%create_array(json_list1, 'b')
  do i1 = lbound(input%b, 1), ubound(input%b, 1)
    call json%create_real(json_val, input%b(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp)  ent(3,3),exi(3,3)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%ent, 2), ubound(input%ent, 2)
    call json%create_array(json_list1, 'ent')
    do i1 = lbound(input%ent, 1), ubound(input%ent, 1)
      call json%create_real(json_val, input%ent(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp)  ent(3,3),exi(3,3)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%exi, 2), ubound(input%exi, 2)
    call json%create_array(json_list1, 'exi')
    do i1 = lbound(input%exi, 1), ubound(input%exi, 1)
      call json%create_real(json_val, input%exi(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'wx', input%wx)
  call json%add(json_root, 'wy', input%wy)
  !'real(dp)  o(3),mid(3,3)'
  call json%create_array(json_list1, 'o')
  do i1 = lbound(input%o, 1), ubound(input%o, 1)
    call json%create_real(json_val, input%o(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp)  o(3),mid(3,3)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%mid, 2), ubound(input%mid, 2)
    call json%create_array(json_list1, 'mid')
    do i1 = lbound(input%mid, 1), ubound(input%mid, 1)
      call json%create_real(json_val, input%mid(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !'real(dp)  reference_ray(6)'
  call json%create_array(json_list1, 'reference_ray')
  do i1 = lbound(input%reference_ray, 1), ubound(input%reference_ray, 1)
    call json%create_real(json_val, input%reference_ray(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) x(6)'
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call json%create_real(json_val, input%x(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) r0(3),r(3)'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) r0(3),r(3)'
  call json%create_array(json_list1, 'r')
  do i1 = lbound(input%r, 1), ubound(input%r, 1)
    call json%create_real(json_val, input%r(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'scale', input%scale)
  !'logical(lp) u(2)'
  call json%create_array(json_list1, 'u')
  do i1 = lbound(input%u, 1), ubound(input%u, 1)
    call json%create_logical(json_val, input%u(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine three_d_info_to_json
subroutine tilting_to_json (input, json_root, depth, max_depth)
  use definition, only: tilting
  implicit none
  type(json_core) :: json
  type (tilting), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'real(dp) tilt(0:nmax)'
  call json%create_array(json_list1, 'tilt')
  do i1 = lbound(input%tilt, 1), ubound(input%tilt, 1)
    call json%create_real(json_val, input%tilt(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'natural', input%natural)
end subroutine tilting_to_json
subroutine time_energy_to_json (input, json_root, depth, max_depth)
  use definition, only: time_energy
  implicit none
  type(json_core) :: json
  type (time_energy), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%time)) then
    call json%add(json_root, 'time', input%time)
  endif
  if (associated(input%energy)) then
    call json%add(json_root, 'energy', input%energy)
  endif
  if (associated(input%an)) then
    !'real(dp),pointer :: an(:) => null(),bn(:) => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%an, 1), ubound(input%an, 1)
      call json%create_real(json_val, input%an(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%bn)) then
    !'real(dp),pointer :: an(:) => null(),bn(:) => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%bn, 1), ubound(input%bn, 1)
      call json%create_real(json_val, input%bn(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%b_t)) then
    call json%add(json_root, 'b_t', input%b_t)
  endif
end subroutine time_energy_to_json
subroutine TKTF_to_json (input, json_root, depth, max_depth)
  use definition, only: TKTF
  implicit none
  type(json_core) :: json
  type (TKTF), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call json%add(json_root, 'l', input%L)
  endif
  if (associated(input%AN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call json%create_real(json_val, input%AN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'real(dp),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call json%create_real(json_val, input%BN(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%MATX)) then
    !'real(dp),  DIMENSION(:,:), POINTER :: MATX => null(), MATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATX, 2), ubound(input%MATX, 2)
      call json%create_array(json_list1, 'matx')
      do i1 = lbound(input%MATX, 1), ubound(input%MATX, 1)
        call json%create_real(json_val, input%MATX(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%MATY)) then
    !'real(dp),  DIMENSION(:,:), POINTER :: MATX => null(), MATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATY, 2), ubound(input%MATY, 2)
      call json%create_array(json_list1, 'maty')
      do i1 = lbound(input%MATY, 1), ubound(input%MATY, 1)
        call json%create_real(json_val, input%MATY(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%MATX2)) then
    !'real(dp),  DIMENSION(:,:), POINTER :: MATX2 => null(), MATY2 => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATX2, 2), ubound(input%MATX2, 2)
      call json%create_array(json_list1, 'matx2')
      do i1 = lbound(input%MATX2, 1), ubound(input%MATX2, 1)
        call json%create_real(json_val, input%MATX2(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%MATY2)) then
    !'real(dp),  DIMENSION(:,:), POINTER :: MATX2 => null(), MATY2 => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATY2, 2), ubound(input%MATY2, 2)
      call json%create_array(json_list1, 'maty2')
      do i1 = lbound(input%MATY2, 1), ubound(input%MATY2, 1)
        call json%create_real(json_val, input%MATY2(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%lx)) then
    !'real(dp), DIMENSION(:), POINTER :: lx => null()'
    call json%create_array(json_list1, 'lx')
    do i1 = lbound(input%lx, 1), ubound(input%lx, 1)
      call json%create_real(json_val, input%lx(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%RMATX)) then
    !'real(dp), DIMENSION(:,:), POINTER :: RMATX => null(), RMATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%RMATX, 2), ubound(input%RMATX, 2)
      call json%create_array(json_list1, 'rmatx')
      do i1 = lbound(input%RMATX, 1), ubound(input%RMATX, 1)
        call json%create_real(json_val, input%RMATX(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%RMATY)) then
    !'real(dp), DIMENSION(:,:), POINTER :: RMATX => null(), RMATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%RMATY, 2), ubound(input%RMATY, 2)
      call json%create_array(json_list1, 'rmaty')
      do i1 = lbound(input%RMATY, 1), ubound(input%RMATY, 1)
        call json%create_real(json_val, input%RMATY(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%Rlx)) then
    !'real(dp), DIMENSION(:), POINTER ::   Rlx => null()'
    call json%create_array(json_list1, 'rlx')
    do i1 = lbound(input%Rlx, 1), ubound(input%Rlx, 1)
      call json%create_real(json_val, input%Rlx(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call json%create_real(json_val, input%FINT(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'real(dp), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call json%create_real(json_val, input%HGAP(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call json%add(json_root, 'h1', input%H1)
  endif
  if (associated(input%H2)) then
    call json%add(json_root, 'h2', input%H2)
  endif
  if (associated(input%VA)) then
    call json%add(json_root, 'va', input%VA)
  endif
  if (associated(input%VS)) then
    call json%add(json_root, 'vs', input%VS)
  endif
  if (associated(input%f)) then
    call json%add(json_root, 'f', int(input%f))
  endif
end subroutine TKTF_to_json
subroutine TKTFP_to_json (input, json_root, depth, max_depth)
  use definition, only: TKTFP
  implicit none
  type(json_core) :: json
  type (TKTFP), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! parent pointer skip: P (TYPE, )
  if (associated(input%L)) then
    call REAL_8_to_json(input%L, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'L')
    call json%add(json_root, json_val)
  endif
  if (associated(input%AN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'an')
    do i1 = lbound(input%AN, 1), ubound(input%AN, 1)
      call REAL_8_to_json(input%AN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%BN)) then
    !'TYPE(REAL_8),  DIMENSION(:), POINTER :: AN => null(), BN => null()'
    call json%create_array(json_list1, 'bn')
    do i1 = lbound(input%BN, 1), ubound(input%BN, 1)
      call REAL_8_to_json(input%BN(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%MATX)) then
    !'TYPE(REAL_8),  DIMENSION(:,:), POINTER :: MATX => null(), MATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATX, 2), ubound(input%MATX, 2)
      call json%create_array(json_list1, 'matx')
      do i1 = lbound(input%MATX, 1), ubound(input%MATX, 1)
        call REAL_8_to_json(input%MATX(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%MATY)) then
    !'TYPE(REAL_8),  DIMENSION(:,:), POINTER :: MATX => null(), MATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATY, 2), ubound(input%MATY, 2)
      call json%create_array(json_list1, 'maty')
      do i1 = lbound(input%MATY, 1), ubound(input%MATY, 1)
        call REAL_8_to_json(input%MATY(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%MATX2)) then
    !'TYPE(REAL_8),  DIMENSION(:,:), POINTER :: MATX2 => null(), MATY2 => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATX2, 2), ubound(input%MATX2, 2)
      call json%create_array(json_list1, 'matx2')
      do i1 = lbound(input%MATX2, 1), ubound(input%MATX2, 1)
        call REAL_8_to_json(input%MATX2(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%MATY2)) then
    !'TYPE(REAL_8),  DIMENSION(:,:), POINTER :: MATX2 => null(), MATY2 => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%MATY2, 2), ubound(input%MATY2, 2)
      call json%create_array(json_list1, 'maty2')
      do i1 = lbound(input%MATY2, 1), ubound(input%MATY2, 1)
        call REAL_8_to_json(input%MATY2(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%lx)) then
    !'TYPE(REAL_8), DIMENSION(:), POINTER :: lx => null()'
    call json%create_array(json_list1, 'lx')
    do i1 = lbound(input%lx, 1), ubound(input%lx, 1)
      call REAL_8_to_json(input%lx(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%RMATX)) then
    !'TYPE(REAL_8), DIMENSION(:,:), POINTER :: RMATX => null(), RMATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%RMATX, 2), ubound(input%RMATX, 2)
      call json%create_array(json_list1, 'rmatx')
      do i1 = lbound(input%RMATX, 1), ubound(input%RMATX, 1)
        call REAL_8_to_json(input%RMATX(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%RMATY)) then
    !'TYPE(REAL_8), DIMENSION(:,:), POINTER :: RMATX => null(), RMATY => null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%RMATY, 2), ubound(input%RMATY, 2)
      call json%create_array(json_list1, 'rmaty')
      do i1 = lbound(input%RMATY, 1), ubound(input%RMATY, 1)
        call REAL_8_to_json(input%RMATY(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%Rlx)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER :: Rlx => null()'
    call json%create_array(json_list1, 'rlx')
    do i1 = lbound(input%Rlx, 1), ubound(input%Rlx, 1)
      call REAL_8_to_json(input%Rlx(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FINT)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'fint')
    do i1 = lbound(input%FINT, 1), ubound(input%FINT, 1)
      call REAL_8_to_json(input%FINT(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%HGAP)) then
    !'TYPE(REAL_8), DIMENSION(:),   POINTER:: FINT => null(), HGAP => null()'
    call json%create_array(json_list1, 'hgap')
    do i1 = lbound(input%HGAP, 1), ubound(input%HGAP, 1)
      call REAL_8_to_json(input%HGAP(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%H1)) then
    call REAL_8_to_json(input%H1, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H1')
    call json%add(json_root, json_val)
  endif
  if (associated(input%H2)) then
    call REAL_8_to_json(input%H2, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'H2')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VA)) then
    call REAL_8_to_json(input%VA, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VA')
    call json%add(json_root, json_val)
  endif
  if (associated(input%VS)) then
    call REAL_8_to_json(input%VS, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'VS')
    call json%add(json_root, json_val)
  endif
  if (associated(input%f)) then
    call json%add(json_root, 'f', int(input%f))
  endif
end subroutine TKTFP_to_json
subroutine tp10_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: tp10_list
  implicit none
  type(json_core) :: json
  type (tp10_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'driftkick', input%DRIFTKICK)
  !'real(dp) ae(nmul_max)'
  call json%create_array(json_list1, 'ae')
  do i1 = lbound(input%ae, 1), ubound(input%ae, 1)
    call json%create_real(json_val, input%ae(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) be(nmul_max)'
  call json%create_array(json_list1, 'be')
  do i1 = lbound(input%be, 1), ubound(input%be, 1)
    call json%create_real(json_val, input%be(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine tp10_list_to_json
subroutine track_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: track_list
  implicit none
  type(json_core) :: json
  type (track_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'name', trim(input%name))
  !'integer range(3),direction'
  call json%create_array(json_list1, 'range')
  do i1 = lbound(input%range, 1), ubound(input%range, 1)
    call json%create_integer(json_val, input%range(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'direction', int(input%direction))
end subroutine track_list_to_json
subroutine tree_to_json (input, json_root, depth, max_depth)
  use definition, only: tree
  implicit none
  type(json_core) :: json
  type (tree), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type (taylor) branch(ndim2)'
  call json%create_array(json_list1, 'branch')
  do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
    call taylor_to_json(input%branch(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine tree_to_json
subroutine tree_element_to_json (input, json_root, depth, max_depth)
  use definition, only: tree_element
  implicit none
  type(json_core) :: json
  type (tree_element), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%CC)) then
    !'real(dp) ,  DIMENSION(:), POINTER :: CC'
    call json%create_array(json_list1, 'cc')
    do i1 = lbound(input%CC, 1), ubound(input%CC, 1)
      call json%create_real(json_val, input%CC(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%fixr)) then
    !'real(dp) ,  DIMENSION(:), POINTER :: fixr,fix,fix0'
    call json%create_array(json_list1, 'fixr')
    do i1 = lbound(input%fixr, 1), ubound(input%fixr, 1)
      call json%create_real(json_val, input%fixr(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%fix)) then
    !'real(dp) ,  DIMENSION(:), POINTER :: fixr,fix,fix0'
    call json%create_array(json_list1, 'fix')
    do i1 = lbound(input%fix, 1), ubound(input%fix, 1)
      call json%create_real(json_val, input%fix(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%fix0)) then
    !'real(dp) ,  DIMENSION(:), POINTER :: fixr,fix,fix0'
    call json%create_array(json_list1, 'fix0')
    do i1 = lbound(input%fix0, 1), ubound(input%fix0, 1)
      call json%create_real(json_val, input%fix0(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%JL)) then
    !'integer,  DIMENSION(:), POINTER :: JL,JV'
    call json%create_array(json_list1, 'jl')
    do i1 = lbound(input%JL, 1), ubound(input%JL, 1)
      call json%create_integer(json_val, input%JL(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%JV)) then
    !'integer,  DIMENSION(:), POINTER :: JL,JV'
    call json%create_array(json_list1, 'jv')
    do i1 = lbound(input%JV, 1), ubound(input%JV, 1)
      call json%create_integer(json_val, input%JV(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%NP)) then
    call json%add(json_root, 'np', int(input%NP))
  endif
  if (associated(input%no)) then
    call json%add(json_root, 'no', int(input%no))
  endif
  if (associated(input%e_ij)) then
    !'real(dp), pointer :: e_ij(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%e_ij, 2), ubound(input%e_ij, 2)
      call json%create_array(json_list1, 'e_ij')
      do i1 = lbound(input%e_ij, 1), ubound(input%e_ij, 1)
        call json%create_real(json_val, input%e_ij(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%rad)) then
    !'real(dp), pointer :: rad(:,:)'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%rad, 2), ubound(input%rad, 2)
      call json%create_array(json_list1, 'rad')
      do i1 = lbound(input%rad, 1), ubound(input%rad, 1)
        call json%create_real(json_val, input%rad(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%ds)) then
    call json%add(json_root, 'ds', input%ds)
  endif
  if (associated(input%beta0)) then
    call json%add(json_root, 'beta0', input%beta0)
  endif
  if (associated(input%eps)) then
    call json%add(json_root, 'eps', input%eps)
  endif
  if (associated(input%symptrack)) then
    call json%add(json_root, 'symptrack', input%symptrack)
  endif
  if (associated(input%usenonsymp)) then
    call json%add(json_root, 'usenonsymp', input%usenonsymp)
  endif
  if (associated(input%factored)) then
    call json%add(json_root, 'factored', input%factored)
  endif
end subroutine tree_element_to_json
subroutine undu_p_to_json (input, json_root, depth, max_depth)
  use definition, only: undu_p
  implicit none
  type(json_core) :: json
  type (undu_p), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%K)) then
    !'TYPE(REAL_8), DIMENSION(:,:), pointer :: K=> null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%K, 2), ubound(input%K, 2)
      call json%create_array(json_list1, 'k')
      do i1 = lbound(input%K, 1), ubound(input%K, 1)
        call REAL_8_to_json(input%K(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%A)) then
    !'TYPE(REAL_8), DIMENSION(:), pointer :: A=> null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%A, 1), ubound(input%A, 1)
      call REAL_8_to_json(input%A(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%F)) then
    !'TYPE(REAL_8), DIMENSION(:), pointer :: F=> null()'
    call json%create_array(json_list1, 'f')
    do i1 = lbound(input%F, 1), ubound(input%F, 1)
      call REAL_8_to_json(input%F(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%x0)) then
    !'TYPE(REAL_8), DIMENSION(:), pointer :: x0=> null()'
    call json%create_array(json_list1, 'x0')
    do i1 = lbound(input%x0, 1), ubound(input%x0, 1)
      call REAL_8_to_json(input%x0(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%y0)) then
    !'TYPE(REAL_8), DIMENSION(:), pointer :: y0=> null()'
    call json%create_array(json_list1, 'y0')
    do i1 = lbound(input%y0, 1), ubound(input%y0, 1)
      call REAL_8_to_json(input%y0(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%KE)) then
    !'TYPE(REAL_8), DIMENSION(:,:), pointer :: KE=> null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%KE, 2), ubound(input%KE, 2)
      call json%create_array(json_list1, 'ke')
      do i1 = lbound(input%KE, 1), ubound(input%KE, 1)
        call REAL_8_to_json(input%KE(i1, i2), json_val, depth=depth + 1, max_depth=max_depth)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%AE)) then
    !'TYPE(REAL_8), DIMENSION(:), pointer :: AE=> null()'
    call json%create_array(json_list1, 'ae')
    do i1 = lbound(input%AE, 1), ubound(input%AE, 1)
      call REAL_8_to_json(input%AE(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FE)) then
    !'TYPE(REAL_8), DIMENSION(:), pointer :: FE=> null()'
    call json%create_array(json_list1, 'fe')
    do i1 = lbound(input%FE, 1), ubound(input%FE, 1)
      call REAL_8_to_json(input%FE(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%x0E)) then
    !'TYPE(REAL_8), DIMENSION(:), pointer :: x0E=> null()'
    call json%create_array(json_list1, 'x0e')
    do i1 = lbound(input%x0E, 1), ubound(input%x0E, 1)
      call REAL_8_to_json(input%x0E(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%y0E)) then
    !'TYPE(REAL_8), DIMENSION(:), pointer :: y0E=> null()'
    call json%create_array(json_list1, 'y0e')
    do i1 = lbound(input%y0E, 1), ubound(input%y0E, 1)
      call REAL_8_to_json(input%y0E(i1), json_val, depth=depth + 1, max_depth=max_depth)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ex)) then
    !'real(dp), DIMENSION(:), pointer :: ex=> null(),ey=> null()'
    call json%create_array(json_list1, 'ex')
    do i1 = lbound(input%ex, 1), ubound(input%ex, 1)
      call json%create_real(json_val, input%ex(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ey)) then
    !'real(dp), DIMENSION(:), pointer :: ex=> null(),ey=> null()'
    call json%create_array(json_list1, 'ey')
    do i1 = lbound(input%ey, 1), ubound(input%ey, 1)
      call json%create_real(json_val, input%ey(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%offset)) then
    call REAL_8_to_json(input%offset, json_val, depth=depth + 1, max_depth=max_depth)
    call json%rename(json_val, 'offset')
    call json%add(json_root, json_val)
  endif
  if (associated(input%n)) then
    call json%add(json_root, 'n', int(input%n))
  endif
  if (associated(input%ne)) then
    call json%add(json_root, 'ne', int(input%ne))
  endif
  if (associated(input%FORM)) then
    !'integer, DIMENSION(:), pointer :: FORM=> null()'
    call json%create_array(json_list1, 'form')
    do i1 = lbound(input%FORM, 1), ubound(input%FORM, 1)
      call json%create_integer(json_val, input%FORM(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FORME)) then
    !'integer, DIMENSION(:), pointer :: FORME=> null()'
    call json%create_array(json_list1, 'forme')
    do i1 = lbound(input%FORME, 1), ubound(input%FORME, 1)
      call json%create_integer(json_val, input%FORME(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine undu_p_to_json
subroutine undu_R_to_json (input, json_root, depth, max_depth)
  use definition, only: undu_R
  implicit none
  type(json_core) :: json
  type (undu_R), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%K)) then
    !'real(dp), DIMENSION(:,:), pointer :: K=> null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%K, 2), ubound(input%K, 2)
      call json%create_array(json_list1, 'k')
      do i1 = lbound(input%K, 1), ubound(input%K, 1)
        call json%create_real(json_val, input%K(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%A)) then
    !'real(dp), DIMENSION(:), pointer :: A=> null()'
    call json%create_array(json_list1, 'a')
    do i1 = lbound(input%A, 1), ubound(input%A, 1)
      call json%create_real(json_val, input%A(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%F)) then
    !'real(dp), DIMENSION(:), pointer :: F=> null()'
    call json%create_array(json_list1, 'f')
    do i1 = lbound(input%F, 1), ubound(input%F, 1)
      call json%create_real(json_val, input%F(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%x0)) then
    !'real(dp), DIMENSION(:), pointer :: x0=> null()'
    call json%create_array(json_list1, 'x0')
    do i1 = lbound(input%x0, 1), ubound(input%x0, 1)
      call json%create_real(json_val, input%x0(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%y0)) then
    !'real(dp), DIMENSION(:), pointer :: y0=> null()'
    call json%create_array(json_list1, 'y0')
    do i1 = lbound(input%y0, 1), ubound(input%y0, 1)
      call json%create_real(json_val, input%y0(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%KE)) then
    !'real(dp), DIMENSION(:,:), pointer :: KE=> null()'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%KE, 2), ubound(input%KE, 2)
      call json%create_array(json_list1, 'ke')
      do i1 = lbound(input%KE, 1), ubound(input%KE, 1)
        call json%create_real(json_val, input%KE(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (associated(input%AE)) then
    !'real(dp), DIMENSION(:), pointer :: AE=> null()'
    call json%create_array(json_list1, 'ae')
    do i1 = lbound(input%AE, 1), ubound(input%AE, 1)
      call json%create_real(json_val, input%AE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FE)) then
    !'real(dp), DIMENSION(:), pointer :: FE=> null()'
    call json%create_array(json_list1, 'fe')
    do i1 = lbound(input%FE, 1), ubound(input%FE, 1)
      call json%create_real(json_val, input%FE(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%x0E)) then
    !'real(dp), DIMENSION(:), pointer :: x0E=> null()'
    call json%create_array(json_list1, 'x0e')
    do i1 = lbound(input%x0E, 1), ubound(input%x0E, 1)
      call json%create_real(json_val, input%x0E(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%y0E)) then
    !'real(dp), DIMENSION(:), pointer :: y0E=> null()'
    call json%create_array(json_list1, 'y0e')
    do i1 = lbound(input%y0E, 1), ubound(input%y0E, 1)
      call json%create_real(json_val, input%y0E(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ex)) then
    !'real(dp), DIMENSION(:), pointer :: ex=> null(),ey=> null()'
    call json%create_array(json_list1, 'ex')
    do i1 = lbound(input%ex, 1), ubound(input%ex, 1)
      call json%create_real(json_val, input%ex(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ey)) then
    !'real(dp), DIMENSION(:), pointer :: ex=> null(),ey=> null()'
    call json%create_array(json_list1, 'ey')
    do i1 = lbound(input%ey, 1), ubound(input%ey, 1)
      call json%create_real(json_val, input%ey(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%offset)) then
    call json%add(json_root, 'offset', input%offset)
  endif
  if (associated(input%n)) then
    call json%add(json_root, 'n', int(input%n))
  endif
  if (associated(input%ne)) then
    call json%add(json_root, 'ne', int(input%ne))
  endif
  if (associated(input%FORM)) then
    !'integer, DIMENSION(:), pointer :: FORM=> null()'
    call json%create_array(json_list1, 'form')
    do i1 = lbound(input%FORM, 1), ubound(input%FORM, 1)
      call json%create_integer(json_val, input%FORM(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%FORME)) then
    !'integer, DIMENSION(:), pointer :: FORME=> null()'
    call json%create_array(json_list1, 'forme')
    do i1 = lbound(input%FORME, 1), ubound(input%FORME, 1)
      call json%create_integer(json_val, input%FORME(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine undu_R_to_json
subroutine UNIVERSAL_TAYLOR_to_json (input, json_root, depth, max_depth)
  use definition, only: UNIVERSAL_TAYLOR
  implicit none
  type(json_core) :: json
  type (UNIVERSAL_TAYLOR), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%N)) then
    call json%add(json_root, 'n', int(input%N))
  endif
  if (associated(input%NV)) then
    call json%add(json_root, 'nv', int(input%NV))
  endif
  if (associated(input%C)) then
    !'REAL(DP), POINTER,dimension(:)::C'
    call json%create_array(json_list1, 'c')
    do i1 = lbound(input%C, 1), ubound(input%C, 1)
      call json%create_real(json_val, input%C(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%J)) then
    !'INTEGER, POINTER,dimension(:,:)::J'
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%J, 2), ubound(input%J, 2)
      call json%create_array(json_list1, 'j')
      do i1 = lbound(input%J, 1), ubound(input%J, 1)
        call json%create_integer(json_val, input%J(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine UNIVERSAL_TAYLOR_to_json
subroutine vecfield_to_json (input, json_root, depth, max_depth)
  use definition, only: vecfield
  implicit none
  type(json_core) :: json
  type (vecfield), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !'type (taylor) v(ndim2)'
  call json%create_array(json_list1, 'v')
  do i1 = lbound(input%v, 1), ubound(input%v, 1)
    call taylor_to_json(input%v(i1), json_val, depth=depth + 1, max_depth=max_depth)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ifac', int(input%ifac))
end subroutine vecfield_to_json
subroutine vecresonance_to_json (input, json_root, depth, max_depth)
  use definition, only: vecresonance
  implicit none
  type(json_core) :: json
  type (vecresonance), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call vecfield_to_json(input%cos, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'cos')
  call json%add(json_root, json_val)
  call vecfield_to_json(input%sin, json_val, depth=depth + 1, max_depth=max_depth)
  call json%rename(json_val, 'sin')
  call json%add(json_root, json_val)
  call json%add(json_root, 'ifac', int(input%ifac))
end subroutine vecresonance_to_json
subroutine wig_list_to_json (input, json_root, depth, max_depth)
  use madx_keywords, only: wig_list
  implicit none
  type(json_core) :: json
  type (wig_list), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'offset', input%offset)
  !'real(dp) internal(6)'
  call json%create_array(json_list1, 'internal')
  do i1 = lbound(input%internal, 1), ubound(input%internal, 1)
    call json%create_real(json_val, input%internal(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) ex(wiggler_suntao),ey(wiggler_suntao)'
  call json%create_array(json_list1, 'ex')
  do i1 = lbound(input%ex, 1), ubound(input%ex, 1)
    call json%create_real(json_val, input%ex(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) ex(wiggler_suntao),ey(wiggler_suntao)'
  call json%create_array(json_list1, 'ey')
  do i1 = lbound(input%ey, 1), ubound(input%ey, 1)
    call json%create_real(json_val, input%ey(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n', int(input%n))
  !'real(dp) a(mode_max)'
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%a, 1), ubound(input%a, 1)
    call json%create_real(json_val, input%a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) f(mode_max)'
  call json%create_array(json_list1, 'f')
  do i1 = lbound(input%f, 1), ubound(input%f, 1)
    call json%create_real(json_val, input%f(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'integer form(mode_max)'
  call json%create_array(json_list1, 'form')
  do i1 = lbound(input%form, 1), ubound(input%form, 1)
    call json%create_integer(json_val, input%form(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) k(3,mode_max)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%k, 2), ubound(input%k, 2)
    call json%create_array(json_list1, 'k')
    do i1 = lbound(input%k, 1), ubound(input%k, 1)
      call json%create_real(json_val, input%k(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'ne', int(input%ne))
  !'real(dp) ae(mode_max)'
  call json%create_array(json_list1, 'ae')
  do i1 = lbound(input%ae, 1), ubound(input%ae, 1)
    call json%create_real(json_val, input%ae(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) fe(mode_max)'
  call json%create_array(json_list1, 'fe')
  do i1 = lbound(input%fe, 1), ubound(input%fe, 1)
    call json%create_real(json_val, input%fe(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'integer forme(mode_max)'
  call json%create_array(json_list1, 'forme')
  do i1 = lbound(input%forme, 1), ubound(input%forme, 1)
    call json%create_integer(json_val, input%forme(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !'real(dp) ke(3,mode_max)'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%ke, 2), ubound(input%ke, 2)
    call json%create_array(json_list1, 'ke')
    do i1 = lbound(input%ke, 1), ubound(input%ke, 1)
      call json%create_real(json_val, input%ke(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine wig_list_to_json
subroutine work_to_json (input, json_root, depth, max_depth)
  use definition, only: work
  implicit none
  type(json_core) :: json
  type (work), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'beta0', input%beta0)
  call json%add(json_root, 'energy', input%energy)
  call json%add(json_root, 'kinetic', input%kinetic)
  call json%add(json_root, 'p0c', input%p0c)
  call json%add(json_root, 'brho', input%brho)
  call json%add(json_root, 'gamma0i', input%gamma0I)
  call json%add(json_root, 'gambet', input%gambet)
  call json%add(json_root, 'mass', input%mass)
  call json%add(json_root, 'rescale', input%rescale)
  call json%add(json_root, 'power', int(input%power))
end subroutine work_to_json
end module forest_json