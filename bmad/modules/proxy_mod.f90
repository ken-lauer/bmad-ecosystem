module bmad_struct_proxy_mod
  use bmad_struct
  use, intrinsic :: iso_c_binding
contains

! spline_struct

  subroutine spline_struct_get_x0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spline_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine


  subroutine spline_struct_get_y0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spline_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine


  subroutine spline_struct_get_x1(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spline_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x1
  end subroutine


  subroutine spline_struct_get_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(spline_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%coef(lbound(struct_obj%coef, 1)))
    lower_bound = int(lbound(struct_obj%coef, 1), c_int)
    upper_bound = int(ubound(struct_obj%coef, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! spin_polar_struct

  subroutine spin_polar_struct_get_polarization(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spin_polar_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%polarization
  end subroutine


  subroutine spin_polar_struct_get_theta(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spin_polar_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%theta
  end subroutine


  subroutine spin_polar_struct_get_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spin_polar_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine


  subroutine spin_polar_struct_get_xi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spin_polar_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%xi
  end subroutine

! ac_kicker_time_struct

  subroutine ac_kicker_time_struct_get_amp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_time_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp
  end subroutine


  subroutine ac_kicker_time_struct_get_time(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_time_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time
  end subroutine


  subroutine ac_kicker_time_struct_get_spline(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ac_kicker_time_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%spline)
  end subroutine

! ac_kicker_freq_struct

  subroutine ac_kicker_freq_struct_get_f(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_freq_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f
  end subroutine


  subroutine ac_kicker_freq_struct_get_amp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_freq_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp
  end subroutine


  subroutine ac_kicker_freq_struct_get_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_freq_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine


  subroutine ac_kicker_freq_struct_get_rf_clock_harmonic(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ac_kicker_freq_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rf_clock_harmonic
  end subroutine

! ac_kicker_struct
! skipped ac_kicker_struct%amp_vs_time: Unsupported type: 1D_ALLOC_type
! skipped ac_kicker_struct%frequency: Unsupported type: 1D_ALLOC_type
! interval1_coef_struct

  subroutine interval1_coef_struct_get_c0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(interval1_coef_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%c0
  end subroutine


  subroutine interval1_coef_struct_get_c1(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(interval1_coef_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%c1
  end subroutine


  subroutine interval1_coef_struct_get_n_exp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(interval1_coef_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_exp
  end subroutine

! photon_reflect_table_struct

  subroutine photon_reflect_table_struct_get_angle_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(photon_reflect_table_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%angle)) then
      data_ptr = c_loc(struct_obj%angle(lbound(struct_obj%angle, 1)))
      lower_bound = int(lbound(struct_obj%angle, 1), c_int)
      upper_bound = int(ubound(struct_obj%angle, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine


  subroutine photon_reflect_table_struct_get_energy_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(photon_reflect_table_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%energy)) then
      data_ptr = c_loc(struct_obj%energy(lbound(struct_obj%energy, 1)))
      lower_bound = int(lbound(struct_obj%energy, 1), c_int)
      upper_bound = int(ubound(struct_obj%energy, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine

! skipped photon_reflect_table_struct%int1: Unsupported type: 1D_ALLOC_type

  subroutine photon_reflect_table_struct_get_p_reflect_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    logical(c_bool), intent(out) :: is_allocated
    type(photon_reflect_table_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%p_reflect)) then
      data_ptr = c_loc(struct_obj%p_reflect(lbound(struct_obj%p_reflect,1), lbound(struct_obj%p_reflect,2)))
      
      dim1_lower = int(lbound(struct_obj%p_reflect, 1), c_int)
      dim1_upper = int(ubound(struct_obj%p_reflect, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      
      dim2_lower = int(lbound(struct_obj%p_reflect, 2), c_int)
      dim2_upper = int(ubound(struct_obj%p_reflect, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      
      stride1 = 1_c_int
      stride2 = dim1_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int
      is_allocated = .false.
    endif
  end subroutine


  subroutine photon_reflect_table_struct_get_max_energy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(photon_reflect_table_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%max_energy
  end subroutine


  subroutine photon_reflect_table_struct_get_p_reflect_scratch_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(photon_reflect_table_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%p_reflect_scratch)) then
      data_ptr = c_loc(struct_obj%p_reflect_scratch(lbound(struct_obj%p_reflect_scratch, 1)))
      lower_bound = int(lbound(struct_obj%p_reflect_scratch, 1), c_int)
      upper_bound = int(ubound(struct_obj%p_reflect_scratch, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine


  subroutine photon_reflect_table_struct_get_bragg_angle_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(photon_reflect_table_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%bragg_angle)) then
      data_ptr = c_loc(struct_obj%bragg_angle(lbound(struct_obj%bragg_angle, 1)))
      lower_bound = int(lbound(struct_obj%bragg_angle, 1), c_int)
      upper_bound = int(ubound(struct_obj%bragg_angle, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine

! photon_reflect_surface_struct

  subroutine photon_reflect_surface_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(photon_reflect_surface_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine photon_reflect_surface_struct_get_description_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(photon_reflect_surface_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%description)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%description), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine photon_reflect_surface_struct_get_reflectivity_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(photon_reflect_surface_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%reflectivity_file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%reflectivity_file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped photon_reflect_surface_struct%table: Unsupported type: 1D_ALLOC_type

  subroutine photon_reflect_surface_struct_get_surface_roughness_rms(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(photon_reflect_surface_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%surface_roughness_rms
  end subroutine


  subroutine photon_reflect_surface_struct_get_roughness_correlation_len(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(photon_reflect_surface_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%roughness_correlation_len
  end subroutine


  subroutine photon_reflect_surface_struct_get_ix_surface(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(photon_reflect_surface_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_surface
  end subroutine

! coord_struct

  subroutine coord_struct_get_vec_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%vec(lbound(struct_obj%vec, 1)))
    lower_bound = int(lbound(struct_obj%vec, 1), c_int)
    upper_bound = int(ubound(struct_obj%vec, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine coord_struct_get_s(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine


  subroutine coord_struct_get_t(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_long_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t
  end subroutine


  subroutine coord_struct_get_spin_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%spin(lbound(struct_obj%spin, 1)))
    lower_bound = int(lbound(struct_obj%spin, 1), c_int)
    upper_bound = int(ubound(struct_obj%spin, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine coord_struct_get_field_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%field(lbound(struct_obj%field, 1)))
    lower_bound = int(lbound(struct_obj%field, 1), c_int)
    upper_bound = int(ubound(struct_obj%field, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine coord_struct_get_phase_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%phase(lbound(struct_obj%phase, 1)))
    lower_bound = int(lbound(struct_obj%phase, 1), c_int)
    upper_bound = int(ubound(struct_obj%phase, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine coord_struct_get_charge(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge
  end subroutine


  subroutine coord_struct_get_dt_ref(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dt_ref
  end subroutine


  subroutine coord_struct_get_r(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%r
  end subroutine


  subroutine coord_struct_get_p0c(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%p0c
  end subroutine


  subroutine coord_struct_get_E_potential(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_potential
  end subroutine


  subroutine coord_struct_get_beta(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%beta
  end subroutine


  subroutine coord_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine


  subroutine coord_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine


  subroutine coord_struct_get_ix_turn(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_turn
  end subroutine


  subroutine coord_struct_get_ix_user(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_user
  end subroutine


  subroutine coord_struct_get_state(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%state
  end subroutine


  subroutine coord_struct_get_direction(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%direction
  end subroutine


  subroutine coord_struct_get_time_dir(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time_dir
  end subroutine


  subroutine coord_struct_get_species(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%species
  end subroutine


  subroutine coord_struct_get_location(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%location
  end subroutine

! coord_array_struct
! skipped coord_array_struct%orbit: Unsupported type: 1D_ALLOC_type
! bpm_phase_coupling_struct

  subroutine bpm_phase_coupling_struct_get_K_22a(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%K_22a
  end subroutine


  subroutine bpm_phase_coupling_struct_get_K_12a(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%K_12a
  end subroutine


  subroutine bpm_phase_coupling_struct_get_K_11b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%K_11b
  end subroutine


  subroutine bpm_phase_coupling_struct_get_K_12b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%K_12b
  end subroutine


  subroutine bpm_phase_coupling_struct_get_Cbar22_a(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Cbar22_a
  end subroutine


  subroutine bpm_phase_coupling_struct_get_Cbar12_a(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Cbar12_a
  end subroutine


  subroutine bpm_phase_coupling_struct_get_Cbar11_b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Cbar11_b
  end subroutine


  subroutine bpm_phase_coupling_struct_get_Cbar12_b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Cbar12_b
  end subroutine


  subroutine bpm_phase_coupling_struct_get_phi_a(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi_a
  end subroutine


  subroutine bpm_phase_coupling_struct_get_phi_b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi_b
  end subroutine

! expression_atom_struct

  subroutine expression_atom_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(expression_atom_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine expression_atom_struct_get_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(expression_atom_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine


  subroutine expression_atom_struct_get_value(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(expression_atom_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%value
  end subroutine

! wake_sr_z_long_struct

  subroutine wake_sr_z_long_struct_get_w_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%w)) then
      data_ptr = c_loc(struct_obj%w(lbound(struct_obj%w, 1)))
      lower_bound = int(lbound(struct_obj%w, 1), c_int)
      upper_bound = int(ubound(struct_obj%w, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine

! skipped wake_sr_z_long_struct%fw: Unsupported type: 1D_ALLOC_complex
! skipped wake_sr_z_long_struct%fbunch: Unsupported type: 1D_ALLOC_complex
! skipped wake_sr_z_long_struct%w_out: Unsupported type: 1D_ALLOC_complex

  subroutine wake_sr_z_long_struct_get_dz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz
  end subroutine


  subroutine wake_sr_z_long_struct_get_z0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z0
  end subroutine


  subroutine wake_sr_z_long_struct_get_smoothing_sigma(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%smoothing_sigma
  end subroutine


  subroutine wake_sr_z_long_struct_get_position_dependence(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%position_dependence
  end subroutine


  subroutine wake_sr_z_long_struct_get_time_based(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time_based
  end subroutine

! wake_sr_mode_struct

  subroutine wake_sr_mode_struct_get_amp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp
  end subroutine


  subroutine wake_sr_mode_struct_get_damp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%damp
  end subroutine


  subroutine wake_sr_mode_struct_get_k(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%k
  end subroutine


  subroutine wake_sr_mode_struct_get_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine


  subroutine wake_sr_mode_struct_get_b_sin(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_sin
  end subroutine


  subroutine wake_sr_mode_struct_get_b_cos(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_cos
  end subroutine


  subroutine wake_sr_mode_struct_get_a_sin(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_sin
  end subroutine


  subroutine wake_sr_mode_struct_get_a_cos(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_cos
  end subroutine


  subroutine wake_sr_mode_struct_get_polarization(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%polarization
  end subroutine


  subroutine wake_sr_mode_struct_get_position_dependence(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%position_dependence
  end subroutine

! wake_sr_struct

  subroutine wake_sr_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wake_sr_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wake_sr_struct_get_z_long(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z_long)
  end subroutine

! skipped wake_sr_struct%long: Unsupported type: 1D_ALLOC_type
! skipped wake_sr_struct%trans: Unsupported type: 1D_ALLOC_type

  subroutine wake_sr_struct_get_z_ref_long(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_ref_long
  end subroutine


  subroutine wake_sr_struct_get_z_ref_trans(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_ref_trans
  end subroutine


  subroutine wake_sr_struct_get_z_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_max
  end subroutine


  subroutine wake_sr_struct_get_amp_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp_scale
  end subroutine


  subroutine wake_sr_struct_get_z_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_scale
  end subroutine


  subroutine wake_sr_struct_get_scale_with_length(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%scale_with_length
  end subroutine

! wake_lr_mode_struct

  subroutine wake_lr_mode_struct_get_freq(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%freq
  end subroutine


  subroutine wake_lr_mode_struct_get_freq_in(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%freq_in
  end subroutine


  subroutine wake_lr_mode_struct_get_R_over_Q(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%R_over_Q
  end subroutine


  subroutine wake_lr_mode_struct_get_Q(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Q
  end subroutine


  subroutine wake_lr_mode_struct_get_damp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%damp
  end subroutine


  subroutine wake_lr_mode_struct_get_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine


  subroutine wake_lr_mode_struct_get_angle(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%angle
  end subroutine


  subroutine wake_lr_mode_struct_get_b_sin(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_sin
  end subroutine


  subroutine wake_lr_mode_struct_get_b_cos(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_cos
  end subroutine


  subroutine wake_lr_mode_struct_get_a_sin(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_sin
  end subroutine


  subroutine wake_lr_mode_struct_get_a_cos(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_cos
  end subroutine


  subroutine wake_lr_mode_struct_get_m(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%m
  end subroutine


  subroutine wake_lr_mode_struct_get_polarized(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%polarized
  end subroutine

! wake_lr_struct

  subroutine wake_lr_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wake_lr_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped wake_lr_struct%mode: Unsupported type: 1D_ALLOC_type

  subroutine wake_lr_struct_get_t_ref(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t_ref
  end subroutine


  subroutine wake_lr_struct_get_freq_spread(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%freq_spread
  end subroutine


  subroutine wake_lr_struct_get_amp_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp_scale
  end subroutine


  subroutine wake_lr_struct_get_time_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time_scale
  end subroutine


  subroutine wake_lr_struct_get_self_wake_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%self_wake_on
  end subroutine

! lat_ele_loc_struct

  subroutine lat_ele_loc_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_ele_loc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine


  subroutine lat_ele_loc_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_ele_loc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

! wake_struct

  subroutine wake_struct_get_sr(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(wake_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%sr)
  end subroutine


  subroutine wake_struct_get_lr(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(wake_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lr)
  end subroutine

! taylor_term_struct

  subroutine taylor_term_struct_get_coef(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%coef
  end subroutine


  subroutine taylor_term_struct_get_expn_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%expn(lbound(struct_obj%expn, 1)))
    lower_bound = int(lbound(struct_obj%expn, 1), c_int)
    upper_bound = int(ubound(struct_obj%expn, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! taylor_struct

  subroutine taylor_struct_get_ref(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref
  end subroutine

! skipped taylor_struct%term: Unsupported type: 1D_PTR_type
! em_taylor_term_struct

  subroutine em_taylor_term_struct_get_coef(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(em_taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%coef
  end subroutine


  subroutine em_taylor_term_struct_get_expn_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(em_taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%expn(lbound(struct_obj%expn, 1)))
    lower_bound = int(lbound(struct_obj%expn, 1), c_int)
    upper_bound = int(ubound(struct_obj%expn, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! em_taylor_struct

  subroutine em_taylor_struct_get_ref(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(em_taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref
  end subroutine

! skipped em_taylor_struct%term: Unsupported type: 1D_ALLOC_type
! cartesian_map_term1_struct

  subroutine cartesian_map_term1_struct_get_coef(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%coef
  end subroutine


  subroutine cartesian_map_term1_struct_get_kx(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%kx
  end subroutine


  subroutine cartesian_map_term1_struct_get_ky(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ky
  end subroutine


  subroutine cartesian_map_term1_struct_get_kz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%kz
  end subroutine


  subroutine cartesian_map_term1_struct_get_x0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine


  subroutine cartesian_map_term1_struct_get_y0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine


  subroutine cartesian_map_term1_struct_get_phi_z(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi_z
  end subroutine


  subroutine cartesian_map_term1_struct_get_family(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%family
  end subroutine


  subroutine cartesian_map_term1_struct_get_form(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%form
  end subroutine

! cartesian_map_term_struct

  subroutine cartesian_map_term_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(cartesian_map_term_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine cartesian_map_term_struct_get_n_link(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_link
  end subroutine

! skipped cartesian_map_term_struct%term: Unsupported type: 1D_ALLOC_type
! cartesian_map_struct

  subroutine cartesian_map_struct_get_field_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_scale
  end subroutine


  subroutine cartesian_map_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine cartesian_map_struct_get_master_parameter(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%master_parameter
  end subroutine


  subroutine cartesian_map_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine


  subroutine cartesian_map_struct_get_field_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_type
  end subroutine


  subroutine cartesian_map_struct_get_ptr(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ptr)) then
      ptr_out = c_loc(struct_obj%ptr)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

! cylindrical_map_term1_struct

  subroutine cylindrical_map_term1_struct_get_e_coef(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(cylindrical_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%e_coef
  end subroutine


  subroutine cylindrical_map_term1_struct_get_b_coef(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(cylindrical_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_coef
  end subroutine

! cylindrical_map_term_struct

  subroutine cylindrical_map_term_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(cylindrical_map_term_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine cylindrical_map_term_struct_get_n_link(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_link
  end subroutine

! skipped cylindrical_map_term_struct%term: Unsupported type: 1D_ALLOC_type
! cylindrical_map_struct

  subroutine cylindrical_map_struct_get_m(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%m
  end subroutine


  subroutine cylindrical_map_struct_get_harmonic(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%harmonic
  end subroutine


  subroutine cylindrical_map_struct_get_phi0_fieldmap(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi0_fieldmap
  end subroutine


  subroutine cylindrical_map_struct_get_theta0_azimuth(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%theta0_azimuth
  end subroutine


  subroutine cylindrical_map_struct_get_field_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_scale
  end subroutine


  subroutine cylindrical_map_struct_get_master_parameter(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%master_parameter
  end subroutine


  subroutine cylindrical_map_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine


  subroutine cylindrical_map_struct_get_dz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz
  end subroutine


  subroutine cylindrical_map_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine cylindrical_map_struct_get_ptr(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ptr)) then
      ptr_out = c_loc(struct_obj%ptr)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

! bicubic_cmplx_coef_struct
! skipped bicubic_cmplx_coef_struct%coef: Unsupported type: 2D_NOT_complex

  subroutine bicubic_cmplx_coef_struct_get_i_box_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(bicubic_cmplx_coef_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%i_box(lbound(struct_obj%i_box, 1)))
    lower_bound = int(lbound(struct_obj%i_box, 1), c_int)
    upper_bound = int(ubound(struct_obj%i_box, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! tricubic_cmplx_coef_struct
! skipped tricubic_cmplx_coef_struct%coef: Unsupported type: 3D_NOT_complex

  subroutine tricubic_cmplx_coef_struct_get_i_box_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tricubic_cmplx_coef_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%i_box(lbound(struct_obj%i_box, 1)))
    lower_bound = int(lbound(struct_obj%i_box, 1), c_int)
    upper_bound = int(ubound(struct_obj%i_box, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! grid_field_pt1_struct

  subroutine grid_field_pt1_struct_get_E_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(grid_field_pt1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%E(lbound(struct_obj%E, 1)))
    lower_bound = int(lbound(struct_obj%E, 1), c_int)
    upper_bound = int(ubound(struct_obj%E, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine grid_field_pt1_struct_get_B_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(grid_field_pt1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%B(lbound(struct_obj%B, 1)))
    lower_bound = int(lbound(struct_obj%B, 1), c_int)
    upper_bound = int(ubound(struct_obj%B, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! grid_field_pt_struct

  subroutine grid_field_pt_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(grid_field_pt_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine grid_field_pt_struct_get_n_link(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_link
  end subroutine

! skipped grid_field_pt_struct%pt: Unsupported type: 3D_ALLOC_type
! grid_field_struct

  subroutine grid_field_struct_get_geometry(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%geometry
  end subroutine


  subroutine grid_field_struct_get_harmonic(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%harmonic
  end subroutine


  subroutine grid_field_struct_get_phi0_fieldmap(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi0_fieldmap
  end subroutine


  subroutine grid_field_struct_get_field_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_scale
  end subroutine


  subroutine grid_field_struct_get_field_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_type
  end subroutine


  subroutine grid_field_struct_get_master_parameter(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%master_parameter
  end subroutine


  subroutine grid_field_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine


  subroutine grid_field_struct_get_interpolation_order(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%interpolation_order
  end subroutine


  subroutine grid_field_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%dr(lbound(struct_obj%dr, 1)))
    lower_bound = int(lbound(struct_obj%dr, 1), c_int)
    upper_bound = int(ubound(struct_obj%dr, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine grid_field_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine grid_field_struct_get_curved_ref_frame(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%curved_ref_frame
  end subroutine


  subroutine grid_field_struct_get_ptr(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ptr)) then
      ptr_out = c_loc(struct_obj%ptr)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

! skipped grid_field_struct%bi_coef: Unsupported type: 3D_NOT_type
! skipped grid_field_struct%tri_coef: Unsupported type: 3D_NOT_type
! floor_position_struct

  subroutine floor_position_struct_get_r_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(floor_position_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r(lbound(struct_obj%r, 1)))
    lower_bound = int(lbound(struct_obj%r, 1), c_int)
    upper_bound = int(ubound(struct_obj%r, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped floor_position_struct%w: Unsupported type: 2D_NOT_real

  subroutine floor_position_struct_get_theta(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(floor_position_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%theta
  end subroutine


  subroutine floor_position_struct_get_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(floor_position_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine


  subroutine floor_position_struct_get_psi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(floor_position_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%psi
  end subroutine

! high_energy_space_charge_struct

  subroutine high_energy_space_charge_struct_get_closed_orb(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%closed_orb)
  end subroutine


  subroutine high_energy_space_charge_struct_get_kick_const(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%kick_const
  end subroutine


  subroutine high_energy_space_charge_struct_get_sig_x(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_x
  end subroutine


  subroutine high_energy_space_charge_struct_get_sig_y(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_y
  end subroutine


  subroutine high_energy_space_charge_struct_get_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine


  subroutine high_energy_space_charge_struct_get_sin_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sin_phi
  end subroutine


  subroutine high_energy_space_charge_struct_get_cos_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%cos_phi
  end subroutine


  subroutine high_energy_space_charge_struct_get_sig_z(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_z
  end subroutine

! xy_disp_struct

  subroutine xy_disp_struct_get_eta(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%eta
  end subroutine


  subroutine xy_disp_struct_get_etap(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%etap
  end subroutine


  subroutine xy_disp_struct_get_deta_ds(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%deta_ds
  end subroutine


  subroutine xy_disp_struct_get_sigma(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma
  end subroutine


  subroutine xy_disp_struct_get_deta_dpz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%deta_dpz
  end subroutine


  subroutine xy_disp_struct_get_detap_dpz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%detap_dpz
  end subroutine

! twiss_struct

  subroutine twiss_struct_get_beta(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%beta
  end subroutine


  subroutine twiss_struct_get_alpha(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%alpha
  end subroutine


  subroutine twiss_struct_get_gamma(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%gamma
  end subroutine


  subroutine twiss_struct_get_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine


  subroutine twiss_struct_get_eta(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%eta
  end subroutine


  subroutine twiss_struct_get_etap(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%etap
  end subroutine


  subroutine twiss_struct_get_deta_ds(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%deta_ds
  end subroutine


  subroutine twiss_struct_get_sigma(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma
  end subroutine


  subroutine twiss_struct_get_sigma_p(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma_p
  end subroutine


  subroutine twiss_struct_get_emit(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emit
  end subroutine


  subroutine twiss_struct_get_norm_emit(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%norm_emit
  end subroutine


  subroutine twiss_struct_get_chrom(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom
  end subroutine


  subroutine twiss_struct_get_dbeta_dpz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dbeta_dpz
  end subroutine


  subroutine twiss_struct_get_dalpha_dpz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dalpha_dpz
  end subroutine


  subroutine twiss_struct_get_deta_dpz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%deta_dpz
  end subroutine


  subroutine twiss_struct_get_detap_dpz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%detap_dpz
  end subroutine

! mode3_struct
! skipped mode3_struct%v: Unsupported type: 2D_NOT_real

  subroutine mode3_struct_get_a(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine


  subroutine mode3_struct_get_b(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine


  subroutine mode3_struct_get_c(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%c)
  end subroutine


  subroutine mode3_struct_get_x(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%x)
  end subroutine


  subroutine mode3_struct_get_y(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%y)
  end subroutine

! bookkeeping_state_struct

  subroutine bookkeeping_state_struct_get_attributes(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%attributes
  end subroutine


  subroutine bookkeeping_state_struct_get_control(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%control
  end subroutine


  subroutine bookkeeping_state_struct_get_floor_position(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%floor_position
  end subroutine


  subroutine bookkeeping_state_struct_get_s_position(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_position
  end subroutine


  subroutine bookkeeping_state_struct_get_ref_energy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref_energy
  end subroutine


  subroutine bookkeeping_state_struct_get_mat6(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%mat6
  end subroutine


  subroutine bookkeeping_state_struct_get_rad_int(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rad_int
  end subroutine


  subroutine bookkeeping_state_struct_get_ptc(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ptc
  end subroutine


  subroutine bookkeeping_state_struct_get_has_misalign(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%has_misalign
  end subroutine

! rad_map_struct

  subroutine rad_map_struct_get_ref_orb_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(rad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ref_orb(lbound(struct_obj%ref_orb, 1)))
    lower_bound = int(lbound(struct_obj%ref_orb, 1), c_int)
    upper_bound = int(ubound(struct_obj%ref_orb, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped rad_map_struct%damp_dmat: Unsupported type: 2D_NOT_real

  subroutine rad_map_struct_get_xfer_damp_vec_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(rad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%xfer_damp_vec(lbound(struct_obj%xfer_damp_vec, 1)))
    lower_bound = int(lbound(struct_obj%xfer_damp_vec, 1), c_int)
    upper_bound = int(ubound(struct_obj%xfer_damp_vec, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped rad_map_struct%xfer_damp_mat: Unsupported type: 2D_NOT_real
! skipped rad_map_struct%stoc_mat: Unsupported type: 2D_NOT_real
! rad_map_ele_struct

  subroutine rad_map_ele_struct_get_rm0(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(rad_map_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%rm0)
  end subroutine


  subroutine rad_map_ele_struct_get_rm1(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(rad_map_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%rm1)
  end subroutine


  subroutine rad_map_ele_struct_get_stale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(rad_map_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%stale
  end subroutine

! gen_grad1_struct

  subroutine gen_grad1_struct_get_m(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%m
  end subroutine


  subroutine gen_grad1_struct_get_sincos(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sincos
  end subroutine


  subroutine gen_grad1_struct_get_n_deriv_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_deriv_max
  end subroutine


  subroutine gen_grad1_struct_get_deriv_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    logical(c_bool), intent(out) :: is_allocated
    type(gen_grad1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%deriv)) then
      data_ptr = c_loc(struct_obj%deriv(lbound(struct_obj%deriv,1), lbound(struct_obj%deriv,2)))
      
      dim1_lower = int(lbound(struct_obj%deriv, 1), c_int)
      dim1_upper = int(ubound(struct_obj%deriv, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      
      dim2_lower = int(lbound(struct_obj%deriv, 2), c_int)
      dim2_upper = int(ubound(struct_obj%deriv, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      
      stride1 = 1_c_int
      stride2 = dim1_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int
      is_allocated = .false.
    endif
  end subroutine

! gen_grad_map_struct

  subroutine gen_grad_map_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(gen_grad_map_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped gen_grad_map_struct%gg: Unsupported type: 1D_ALLOC_type

  subroutine gen_grad_map_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine


  subroutine gen_grad_map_struct_get_field_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_type
  end subroutine


  subroutine gen_grad_map_struct_get_iz0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%iz0
  end subroutine


  subroutine gen_grad_map_struct_get_iz1(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%iz1
  end subroutine


  subroutine gen_grad_map_struct_get_dz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz
  end subroutine


  subroutine gen_grad_map_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine gen_grad_map_struct_get_field_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_scale
  end subroutine


  subroutine gen_grad_map_struct_get_master_parameter(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%master_parameter
  end subroutine


  subroutine gen_grad_map_struct_get_curved_ref_frame(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%curved_ref_frame
  end subroutine

! surface_segmented_pt_struct

  subroutine surface_segmented_pt_struct_get_x0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine


  subroutine surface_segmented_pt_struct_get_y0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine


  subroutine surface_segmented_pt_struct_get_z0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z0
  end subroutine


  subroutine surface_segmented_pt_struct_get_dz_dx(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz_dx
  end subroutine


  subroutine surface_segmented_pt_struct_get_dz_dy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz_dy
  end subroutine

! surface_segmented_struct

  subroutine surface_segmented_struct_get_active(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(surface_segmented_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%active
  end subroutine


  subroutine surface_segmented_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(surface_segmented_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%dr(lbound(struct_obj%dr, 1)))
    lower_bound = int(lbound(struct_obj%dr, 1), c_int)
    upper_bound = int(ubound(struct_obj%dr, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine surface_segmented_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(surface_segmented_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped surface_segmented_struct%pt: Unsupported type: 2D_ALLOC_type
! surface_h_misalign_pt_struct

  subroutine surface_h_misalign_pt_struct_get_x0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine


  subroutine surface_h_misalign_pt_struct_get_y0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine


  subroutine surface_h_misalign_pt_struct_get_rot_y(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rot_y
  end subroutine


  subroutine surface_h_misalign_pt_struct_get_rot_t(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rot_t
  end subroutine


  subroutine surface_h_misalign_pt_struct_get_rot_y_rms(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rot_y_rms
  end subroutine


  subroutine surface_h_misalign_pt_struct_get_rot_t_rms(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rot_t_rms
  end subroutine

! surface_h_misalign_struct

  subroutine surface_h_misalign_struct_get_active(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(surface_h_misalign_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%active
  end subroutine


  subroutine surface_h_misalign_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(surface_h_misalign_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%dr(lbound(struct_obj%dr, 1)))
    lower_bound = int(lbound(struct_obj%dr, 1), c_int)
    upper_bound = int(ubound(struct_obj%dr, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine surface_h_misalign_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(surface_h_misalign_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped surface_h_misalign_struct%pt: Unsupported type: 2D_ALLOC_type
! surface_displacement_pt_struct

  subroutine surface_displacement_pt_struct_get_x0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine


  subroutine surface_displacement_pt_struct_get_y0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine


  subroutine surface_displacement_pt_struct_get_z0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z0
  end subroutine


  subroutine surface_displacement_pt_struct_get_dz_dx(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz_dx
  end subroutine


  subroutine surface_displacement_pt_struct_get_dz_dy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz_dy
  end subroutine


  subroutine surface_displacement_pt_struct_get_d2z_dxdy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%d2z_dxdy
  end subroutine

! surface_displacement_struct

  subroutine surface_displacement_struct_get_active(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(surface_displacement_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%active
  end subroutine


  subroutine surface_displacement_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(surface_displacement_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%dr(lbound(struct_obj%dr, 1)))
    lower_bound = int(lbound(struct_obj%dr, 1), c_int)
    upper_bound = int(ubound(struct_obj%dr, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine surface_displacement_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(surface_displacement_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped surface_displacement_struct%pt: Unsupported type: 2D_ALLOC_type
! target_point_struct

  subroutine target_point_struct_get_r_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(target_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r(lbound(struct_obj%r, 1)))
    lower_bound = int(lbound(struct_obj%r, 1), c_int)
    upper_bound = int(ubound(struct_obj%r, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! surface_curvature_struct
! skipped surface_curvature_struct%xy: Unsupported type: 2D_NOT_real

  subroutine surface_curvature_struct_get_spherical(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_curvature_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spherical
  end subroutine


  subroutine surface_curvature_struct_get_elliptical_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(surface_curvature_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%elliptical(lbound(struct_obj%elliptical, 1)))
    lower_bound = int(lbound(struct_obj%elliptical, 1), c_int)
    upper_bound = int(ubound(struct_obj%elliptical, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine surface_curvature_struct_get_has_curvature(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(surface_curvature_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%has_curvature
  end subroutine

! photon_target_struct

  subroutine photon_target_struct_get_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine


  subroutine photon_target_struct_get_n_corner(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_corner
  end subroutine


  subroutine photon_target_struct_get_ele_loc(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ele_loc)
  end subroutine

! skipped photon_target_struct%corner: Unsupported type: 1D_NOT_type

  subroutine photon_target_struct_get_center(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%center)
  end subroutine

! photon_material_struct

  subroutine photon_material_struct_get_f0_m1(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f0_m1
  end subroutine


  subroutine photon_material_struct_get_f0_m2(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f0_m2
  end subroutine


  subroutine photon_material_struct_get_f_0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f_0
  end subroutine


  subroutine photon_material_struct_get_f_h(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f_h
  end subroutine


  subroutine photon_material_struct_get_f_hbar(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f_hbar
  end subroutine


  subroutine photon_material_struct_get_f_hkl(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f_hkl
  end subroutine


  subroutine photon_material_struct_get_h_norm_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%h_norm(lbound(struct_obj%h_norm, 1)))
    lower_bound = int(lbound(struct_obj%h_norm, 1), c_int)
    upper_bound = int(ubound(struct_obj%h_norm, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine photon_material_struct_get_l_ref_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%l_ref(lbound(struct_obj%l_ref, 1)))
    lower_bound = int(lbound(struct_obj%l_ref, 1), c_int)
    upper_bound = int(ubound(struct_obj%l_ref, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! pixel_pt_struct

  subroutine pixel_pt_struct_get_n_photon(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_photon
  end subroutine


  subroutine pixel_pt_struct_get_E_x(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_x
  end subroutine


  subroutine pixel_pt_struct_get_E_y(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_y
  end subroutine


  subroutine pixel_pt_struct_get_intensity_x(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%intensity_x
  end subroutine


  subroutine pixel_pt_struct_get_intensity_y(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%intensity_y
  end subroutine


  subroutine pixel_pt_struct_get_intensity(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%intensity
  end subroutine


  subroutine pixel_pt_struct_get_orbit_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%orbit(lbound(struct_obj%orbit, 1)))
    lower_bound = int(lbound(struct_obj%orbit, 1), c_int)
    upper_bound = int(ubound(struct_obj%orbit, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine pixel_pt_struct_get_orbit_rms_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%orbit_rms(lbound(struct_obj%orbit_rms, 1)))
    lower_bound = int(lbound(struct_obj%orbit_rms, 1), c_int)
    upper_bound = int(ubound(struct_obj%orbit_rms, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine pixel_pt_struct_get_init_orbit_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%init_orbit(lbound(struct_obj%init_orbit, 1)))
    lower_bound = int(lbound(struct_obj%init_orbit, 1), c_int)
    upper_bound = int(ubound(struct_obj%init_orbit, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine pixel_pt_struct_get_init_orbit_rms_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%init_orbit_rms(lbound(struct_obj%init_orbit_rms, 1)))
    lower_bound = int(lbound(struct_obj%init_orbit_rms, 1), c_int)
    upper_bound = int(ubound(struct_obj%init_orbit_rms, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! pixel_detec_struct

  subroutine pixel_detec_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(pixel_detec_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%dr(lbound(struct_obj%dr, 1)))
    lower_bound = int(lbound(struct_obj%dr, 1), c_int)
    upper_bound = int(ubound(struct_obj%dr, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine pixel_detec_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(pixel_detec_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine pixel_detec_struct_get_n_track_tot(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(pixel_detec_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_track_tot
  end subroutine


  subroutine pixel_detec_struct_get_n_hit_detec(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(pixel_detec_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_hit_detec
  end subroutine


  subroutine pixel_detec_struct_get_n_hit_pixel(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(pixel_detec_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_hit_pixel
  end subroutine

! skipped pixel_detec_struct%pt: Unsupported type: 2D_ALLOC_type
! photon_element_struct

  subroutine photon_element_struct_get_curvature(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%curvature)
  end subroutine


  subroutine photon_element_struct_get_target(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%target)
  end subroutine


  subroutine photon_element_struct_get_material(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%material)
  end subroutine


  subroutine photon_element_struct_get_segmented(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%segmented)
  end subroutine


  subroutine photon_element_struct_get_h_misalign(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%h_misalign)
  end subroutine


  subroutine photon_element_struct_get_displacement(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%displacement)
  end subroutine


  subroutine photon_element_struct_get_pixel(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%pixel)
  end subroutine


  subroutine photon_element_struct_get_reflectivity_table_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%reflectivity_table_type
  end subroutine


  subroutine photon_element_struct_get_reflectivity_table_sigma(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%reflectivity_table_sigma)
  end subroutine


  subroutine photon_element_struct_get_reflectivity_table_pi(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%reflectivity_table_pi)
  end subroutine

! skipped photon_element_struct%init_energy_prob: Unsupported type: 1D_ALLOC_type

  subroutine photon_element_struct_get_integrated_init_energy_prob_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%integrated_init_energy_prob)) then
      data_ptr = c_loc(struct_obj%integrated_init_energy_prob(lbound(struct_obj%integrated_init_energy_prob, 1)))
      lower_bound = int(lbound(struct_obj%integrated_init_energy_prob, 1), c_int)
      upper_bound = int(ubound(struct_obj%integrated_init_energy_prob, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine

! wall3d_vertex_struct

  subroutine wall3d_vertex_struct_get_x(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x
  end subroutine


  subroutine wall3d_vertex_struct_get_y(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y
  end subroutine


  subroutine wall3d_vertex_struct_get_radius_x(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radius_x
  end subroutine


  subroutine wall3d_vertex_struct_get_radius_y(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radius_y
  end subroutine


  subroutine wall3d_vertex_struct_get_tilt(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tilt
  end subroutine


  subroutine wall3d_vertex_struct_get_angle(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%angle
  end subroutine


  subroutine wall3d_vertex_struct_get_x0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine


  subroutine wall3d_vertex_struct_get_y0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine


  subroutine wall3d_vertex_struct_get_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine

! wall3d_section_struct

  subroutine wall3d_section_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_section_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wall3d_section_struct_get_material_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_section_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%material)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%material), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped wall3d_section_struct%v: Unsupported type: 1D_ALLOC_type

  subroutine wall3d_section_struct_get_surface(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%surface)) then
      ptr_out = c_loc(struct_obj%surface)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine wall3d_section_struct_get_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine


  subroutine wall3d_section_struct_get_n_vertex_input(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_vertex_input
  end subroutine


  subroutine wall3d_section_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine


  subroutine wall3d_section_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine


  subroutine wall3d_section_struct_get_vertices_state(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%vertices_state
  end subroutine


  subroutine wall3d_section_struct_get_patch_in_region(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%patch_in_region
  end subroutine


  subroutine wall3d_section_struct_get_thickness(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%thickness
  end subroutine


  subroutine wall3d_section_struct_get_s(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine


  subroutine wall3d_section_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%r0(lbound(struct_obj%r0, 1)))
    lower_bound = int(lbound(struct_obj%r0, 1), c_int)
    upper_bound = int(ubound(struct_obj%r0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wall3d_section_struct_get_dx0_ds(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dx0_ds
  end subroutine


  subroutine wall3d_section_struct_get_dy0_ds(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dy0_ds
  end subroutine


  subroutine wall3d_section_struct_get_x0_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%x0_coef(lbound(struct_obj%x0_coef, 1)))
    lower_bound = int(lbound(struct_obj%x0_coef, 1), c_int)
    upper_bound = int(ubound(struct_obj%x0_coef, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wall3d_section_struct_get_y0_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%y0_coef(lbound(struct_obj%y0_coef, 1)))
    lower_bound = int(lbound(struct_obj%y0_coef, 1), c_int)
    upper_bound = int(ubound(struct_obj%y0_coef, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wall3d_section_struct_get_dr_ds(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dr_ds
  end subroutine


  subroutine wall3d_section_struct_get_p1_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%p1_coef(lbound(struct_obj%p1_coef, 1)))
    lower_bound = int(lbound(struct_obj%p1_coef, 1), c_int)
    upper_bound = int(ubound(struct_obj%p1_coef, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wall3d_section_struct_get_p2_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%p2_coef(lbound(struct_obj%p2_coef, 1)))
    lower_bound = int(lbound(struct_obj%p2_coef, 1), c_int)
    upper_bound = int(ubound(struct_obj%p2_coef, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! wall3d_struct

  subroutine wall3d_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wall3d_struct_get_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine


  subroutine wall3d_struct_get_ix_wall3d(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_wall3d
  end subroutine


  subroutine wall3d_struct_get_n_link(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_link
  end subroutine


  subroutine wall3d_struct_get_thickness(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%thickness
  end subroutine


  subroutine wall3d_struct_get_clear_material_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%clear_material)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%clear_material), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wall3d_struct_get_opaque_material_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(wall3d_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%opaque_material)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%opaque_material), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine wall3d_struct_get_superimpose(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%superimpose
  end subroutine


  subroutine wall3d_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine

! skipped wall3d_struct%section: Unsupported type: 1D_ALLOC_type
! ramper_lord_struct

  subroutine ramper_lord_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ramper_lord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine


  subroutine ramper_lord_struct_get_ix_con(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ramper_lord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_con
  end subroutine


  subroutine ramper_lord_struct_get_attrib_ptr(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ramper_lord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%attrib_ptr)) then
      ptr_out = c_loc(struct_obj%attrib_ptr)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

! control_struct

  subroutine control_struct_get_value(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%value
  end subroutine


  subroutine control_struct_get_y_knot_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%y_knot)) then
      data_ptr = c_loc(struct_obj%y_knot(lbound(struct_obj%y_knot, 1)))
      lower_bound = int(lbound(struct_obj%y_knot, 1), c_int)
      upper_bound = int(ubound(struct_obj%y_knot, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine

! skipped control_struct%stack: Unsupported type: 1D_ALLOC_type

  subroutine control_struct_get_slave(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%slave)
  end subroutine


  subroutine control_struct_get_lord(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lord)
  end subroutine


  subroutine control_struct_get_slave_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(control_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%slave_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%slave_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine control_struct_get_attribute_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(control_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%attribute)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%attribute), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine control_struct_get_ix_attrib(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_attrib
  end subroutine

! control_var1_struct

  subroutine control_var1_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(control_var1_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine control_var1_struct_get_value(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(control_var1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%value
  end subroutine


  subroutine control_var1_struct_get_old_value(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(control_var1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%old_value
  end subroutine

! control_ramp1_struct

  subroutine control_ramp1_struct_get_y_knot_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(control_ramp1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%y_knot)) then
      data_ptr = c_loc(struct_obj%y_knot(lbound(struct_obj%y_knot, 1)))
      lower_bound = int(lbound(struct_obj%y_knot, 1), c_int)
      upper_bound = int(ubound(struct_obj%y_knot, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine

! skipped control_ramp1_struct%stack: Unsupported type: 1D_ALLOC_type

  subroutine control_ramp1_struct_get_attribute_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(control_ramp1_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%attribute)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%attribute), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine control_ramp1_struct_get_slave_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(control_ramp1_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%slave_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%slave_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine control_ramp1_struct_get_is_controller(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(control_ramp1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%is_controller
  end subroutine

! controller_struct
! skipped controller_struct%var: Unsupported type: 1D_ALLOC_type
! skipped controller_struct%ramp: Unsupported type: 1D_ALLOC_type
! skipped controller_struct%ramper_lord: Unsupported type: 1D_ALLOC_type

  subroutine controller_struct_get_x_knot_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(controller_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%x_knot)) then
      data_ptr = c_loc(struct_obj%x_knot(lbound(struct_obj%x_knot, 1)))
      lower_bound = int(lbound(struct_obj%x_knot, 1), c_int)
      upper_bound = int(ubound(struct_obj%x_knot, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine

! ellipse_beam_init_struct

  subroutine ellipse_beam_init_struct_get_part_per_ellipse(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ellipse_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%part_per_ellipse
  end subroutine


  subroutine ellipse_beam_init_struct_get_n_ellipse(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ellipse_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ellipse
  end subroutine


  subroutine ellipse_beam_init_struct_get_sigma_cutoff(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ellipse_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma_cutoff
  end subroutine

! kv_beam_init_struct

  subroutine kv_beam_init_struct_get_part_per_phi_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(kv_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%part_per_phi(lbound(struct_obj%part_per_phi, 1)))
    lower_bound = int(lbound(struct_obj%part_per_phi, 1), c_int)
    upper_bound = int(ubound(struct_obj%part_per_phi, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine kv_beam_init_struct_get_n_I2(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(kv_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_I2
  end subroutine


  subroutine kv_beam_init_struct_get_A(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(kv_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%A
  end subroutine

! grid_beam_init_struct

  subroutine grid_beam_init_struct_get_n_x(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_x
  end subroutine


  subroutine grid_beam_init_struct_get_n_px(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_px
  end subroutine


  subroutine grid_beam_init_struct_get_x_min(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_min
  end subroutine


  subroutine grid_beam_init_struct_get_x_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_max
  end subroutine


  subroutine grid_beam_init_struct_get_px_min(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%px_min
  end subroutine


  subroutine grid_beam_init_struct_get_px_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%px_max
  end subroutine

! beam_init_struct

  subroutine beam_init_struct_get_position_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%position_file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%position_file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped beam_init_struct%distribution_type: Unsupported type: 1D_NOT_character

  subroutine beam_init_struct_get_spin_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%spin(lbound(struct_obj%spin, 1)))
    lower_bound = int(lbound(struct_obj%spin, 1), c_int)
    upper_bound = int(ubound(struct_obj%spin, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped beam_init_struct%ellipse: Unsupported type: 1D_NOT_type

  subroutine beam_init_struct_get_KV(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%KV)
  end subroutine

! skipped beam_init_struct%grid: Unsupported type: 1D_NOT_type

  subroutine beam_init_struct_get_center_jitter_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%center_jitter(lbound(struct_obj%center_jitter, 1)))
    lower_bound = int(lbound(struct_obj%center_jitter, 1), c_int)
    upper_bound = int(ubound(struct_obj%center_jitter, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine beam_init_struct_get_emit_jitter_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%emit_jitter(lbound(struct_obj%emit_jitter, 1)))
    lower_bound = int(lbound(struct_obj%emit_jitter, 1), c_int)
    upper_bound = int(ubound(struct_obj%emit_jitter, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine beam_init_struct_get_sig_z_jitter(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_z_jitter
  end subroutine


  subroutine beam_init_struct_get_sig_pz_jitter(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_pz_jitter
  end subroutine


  subroutine beam_init_struct_get_n_particle(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_particle
  end subroutine


  subroutine beam_init_struct_get_renorm_center(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%renorm_center
  end subroutine


  subroutine beam_init_struct_get_renorm_sigma(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%renorm_sigma
  end subroutine


  subroutine beam_init_struct_get_random_engine_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%random_engine)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%random_engine), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine beam_init_struct_get_random_gauss_converter_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%random_gauss_converter)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%random_gauss_converter), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine beam_init_struct_get_random_sigma_cutoff(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%random_sigma_cutoff
  end subroutine


  subroutine beam_init_struct_get_a_norm_emit(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_norm_emit
  end subroutine


  subroutine beam_init_struct_get_b_norm_emit(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_norm_emit
  end subroutine


  subroutine beam_init_struct_get_a_emit(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_emit
  end subroutine


  subroutine beam_init_struct_get_b_emit(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_emit
  end subroutine


  subroutine beam_init_struct_get_dPz_dz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dPz_dz
  end subroutine


  subroutine beam_init_struct_get_center_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%center(lbound(struct_obj%center, 1)))
    lower_bound = int(lbound(struct_obj%center, 1), c_int)
    upper_bound = int(ubound(struct_obj%center, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine beam_init_struct_get_t_offset(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t_offset
  end subroutine


  subroutine beam_init_struct_get_dt_bunch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dt_bunch
  end subroutine


  subroutine beam_init_struct_get_sig_z(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_z
  end subroutine


  subroutine beam_init_struct_get_sig_pz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_pz
  end subroutine


  subroutine beam_init_struct_get_bunch_charge(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%bunch_charge
  end subroutine


  subroutine beam_init_struct_get_n_bunch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bunch
  end subroutine


  subroutine beam_init_struct_get_ix_turn(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_turn
  end subroutine


  subroutine beam_init_struct_get_species_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%species)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%species), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine beam_init_struct_get_full_6D_coupling_calc(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%full_6D_coupling_calc
  end subroutine


  subroutine beam_init_struct_get_use_particle_start(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%use_particle_start
  end subroutine


  subroutine beam_init_struct_get_use_t_coords(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%use_t_coords
  end subroutine


  subroutine beam_init_struct_get_use_z_as_t(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%use_z_as_t
  end subroutine


  subroutine beam_init_struct_get_file_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(beam_init_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%file_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%file_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! lat_param_struct

  subroutine lat_param_struct_get_n_part(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_part
  end subroutine


  subroutine lat_param_struct_get_total_length(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%total_length
  end subroutine


  subroutine lat_param_struct_get_unstable_factor(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%unstable_factor
  end subroutine

! skipped lat_param_struct%t1_with_RF: Unsupported type: 2D_NOT_real
! skipped lat_param_struct%t1_no_RF: Unsupported type: 2D_NOT_real

  subroutine lat_param_struct_get_spin_tune(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_tune
  end subroutine


  subroutine lat_param_struct_get_particle(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%particle
  end subroutine


  subroutine lat_param_struct_get_default_tracking_species(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%default_tracking_species
  end subroutine


  subroutine lat_param_struct_get_geometry(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%geometry
  end subroutine


  subroutine lat_param_struct_get_ixx(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ixx
  end subroutine


  subroutine lat_param_struct_get_stable(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%stable
  end subroutine


  subroutine lat_param_struct_get_live_branch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%live_branch
  end subroutine


  subroutine lat_param_struct_get_g1_integral(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%g1_integral
  end subroutine


  subroutine lat_param_struct_get_g2_integral(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%g2_integral
  end subroutine


  subroutine lat_param_struct_get_g3_integral(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%g3_integral
  end subroutine


  subroutine lat_param_struct_get_bookkeeping_state(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%bookkeeping_state)
  end subroutine


  subroutine lat_param_struct_get_beam_init(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam_init)
  end subroutine

! mode_info_struct

  subroutine mode_info_struct_get_stable(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%stable
  end subroutine


  subroutine mode_info_struct_get_tune(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tune
  end subroutine


  subroutine mode_info_struct_get_emit(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emit
  end subroutine


  subroutine mode_info_struct_get_chrom(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom
  end subroutine


  subroutine mode_info_struct_get_sigma(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma
  end subroutine


  subroutine mode_info_struct_get_sigmap(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigmap
  end subroutine

! pre_tracker_struct

  subroutine pre_tracker_struct_get_who(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(pre_tracker_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%who
  end subroutine


  subroutine pre_tracker_struct_get_ix_ele_start(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(pre_tracker_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele_start
  end subroutine


  subroutine pre_tracker_struct_get_ix_ele_end(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(pre_tracker_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele_end
  end subroutine


  subroutine pre_tracker_struct_get_input_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(pre_tracker_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%input_file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%input_file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! anormal_mode_struct

  subroutine anormal_mode_struct_get_emittance(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emittance
  end subroutine


  subroutine anormal_mode_struct_get_emittance_no_vert(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emittance_no_vert
  end subroutine


  subroutine anormal_mode_struct_get_synch_int_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%synch_int(lbound(struct_obj%synch_int, 1)))
    lower_bound = int(lbound(struct_obj%synch_int, 1), c_int)
    upper_bound = int(ubound(struct_obj%synch_int, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine anormal_mode_struct_get_j_damp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%j_damp
  end subroutine


  subroutine anormal_mode_struct_get_alpha_damp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%alpha_damp
  end subroutine


  subroutine anormal_mode_struct_get_chrom(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom
  end subroutine


  subroutine anormal_mode_struct_get_tune(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tune
  end subroutine

! linac_normal_mode_struct

  subroutine linac_normal_mode_struct_get_i2_E4(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i2_E4
  end subroutine


  subroutine linac_normal_mode_struct_get_i3_E7(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i3_E7
  end subroutine


  subroutine linac_normal_mode_struct_get_i5a_E6(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i5a_E6
  end subroutine


  subroutine linac_normal_mode_struct_get_i5b_E6(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i5b_E6
  end subroutine


  subroutine linac_normal_mode_struct_get_sig_E1(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_E1
  end subroutine


  subroutine linac_normal_mode_struct_get_a_emittance_end(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_emittance_end
  end subroutine


  subroutine linac_normal_mode_struct_get_b_emittance_end(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_emittance_end
  end subroutine

! normal_modes_struct

  subroutine normal_modes_struct_get_synch_int_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%synch_int(lbound(struct_obj%synch_int, 1)))
    lower_bound = int(lbound(struct_obj%synch_int, 1), c_int)
    upper_bound = int(ubound(struct_obj%synch_int, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine normal_modes_struct_get_sigE_E(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigE_E
  end subroutine


  subroutine normal_modes_struct_get_sig_z(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_z
  end subroutine


  subroutine normal_modes_struct_get_e_loss(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%e_loss
  end subroutine


  subroutine normal_modes_struct_get_rf_voltage(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rf_voltage
  end subroutine


  subroutine normal_modes_struct_get_pz_aperture(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pz_aperture
  end subroutine


  subroutine normal_modes_struct_get_pz_average(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pz_average
  end subroutine


  subroutine normal_modes_struct_get_momentum_compaction(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%momentum_compaction
  end subroutine


  subroutine normal_modes_struct_get_dpz_damp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dpz_damp
  end subroutine


  subroutine normal_modes_struct_get_a(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine


  subroutine normal_modes_struct_get_b(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine


  subroutine normal_modes_struct_get_z(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z)
  end subroutine


  subroutine normal_modes_struct_get_lin(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lin)
  end subroutine

! em_field_struct

  subroutine em_field_struct_get_E_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(em_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%E(lbound(struct_obj%E, 1)))
    lower_bound = int(lbound(struct_obj%E, 1), c_int)
    upper_bound = int(ubound(struct_obj%E, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine em_field_struct_get_B_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(em_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%B(lbound(struct_obj%B, 1)))
    lower_bound = int(lbound(struct_obj%B, 1), c_int)
    upper_bound = int(ubound(struct_obj%B, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped em_field_struct%dE: Unsupported type: 2D_NOT_real
! skipped em_field_struct%dB: Unsupported type: 2D_NOT_real

  subroutine em_field_struct_get_phi(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(em_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine


  subroutine em_field_struct_get_phi_B(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(em_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi_B
  end subroutine


  subroutine em_field_struct_get_A_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(em_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%A(lbound(struct_obj%A, 1)))
    lower_bound = int(lbound(struct_obj%A, 1), c_int)
    upper_bound = int(ubound(struct_obj%A, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! strong_beam_struct

  subroutine strong_beam_struct_get_ix_slice(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_slice
  end subroutine


  subroutine strong_beam_struct_get_x_center(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_center
  end subroutine


  subroutine strong_beam_struct_get_y_center(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y_center
  end subroutine


  subroutine strong_beam_struct_get_x_sigma(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_sigma
  end subroutine


  subroutine strong_beam_struct_get_y_sigma(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y_sigma
  end subroutine


  subroutine strong_beam_struct_get_dx(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dx
  end subroutine


  subroutine strong_beam_struct_get_dy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dy
  end subroutine

! track_point_struct

  subroutine track_point_struct_get_s_lab(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_lab
  end subroutine


  subroutine track_point_struct_get_s_body(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_body
  end subroutine


  subroutine track_point_struct_get_orb(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%orb)
  end subroutine


  subroutine track_point_struct_get_field(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%field)
  end subroutine


  subroutine track_point_struct_get_strong_beam(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%strong_beam)
  end subroutine


  subroutine track_point_struct_get_vec0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%vec0(lbound(struct_obj%vec0, 1)))
    lower_bound = int(lbound(struct_obj%vec0, 1), c_int)
    upper_bound = int(ubound(struct_obj%vec0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped track_point_struct%mat6: Unsupported type: 2D_NOT_real
! track_struct
! skipped track_struct%pt: Unsupported type: 1D_ALLOC_type

  subroutine track_struct_get_ds_save(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ds_save
  end subroutine


  subroutine track_struct_get_n_pt(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_pt
  end subroutine


  subroutine track_struct_get_n_bad(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bad
  end subroutine


  subroutine track_struct_get_n_ok(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ok
  end subroutine

! space_charge_common_struct

  subroutine space_charge_common_struct_get_ds_track_step(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ds_track_step
  end subroutine


  subroutine space_charge_common_struct_get_dt_track_step(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dt_track_step
  end subroutine


  subroutine space_charge_common_struct_get_cathode_strength_cutoff(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%cathode_strength_cutoff
  end subroutine


  subroutine space_charge_common_struct_get_rel_tol_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rel_tol_tracking
  end subroutine


  subroutine space_charge_common_struct_get_abs_tol_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%abs_tol_tracking
  end subroutine


  subroutine space_charge_common_struct_get_beam_chamber_height(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%beam_chamber_height
  end subroutine


  subroutine space_charge_common_struct_get_lsc_sigma_cutoff(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lsc_sigma_cutoff
  end subroutine


  subroutine space_charge_common_struct_get_particle_sigma_cutoff(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%particle_sigma_cutoff
  end subroutine


  subroutine space_charge_common_struct_get_space_charge_mesh_size_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%space_charge_mesh_size(lbound(struct_obj%space_charge_mesh_size, 1)))
    lower_bound = int(lbound(struct_obj%space_charge_mesh_size, 1), c_int)
    upper_bound = int(ubound(struct_obj%space_charge_mesh_size, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine space_charge_common_struct_get_csr3d_mesh_size_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%csr3d_mesh_size(lbound(struct_obj%csr3d_mesh_size, 1)))
    lower_bound = int(lbound(struct_obj%csr3d_mesh_size, 1), c_int)
    upper_bound = int(ubound(struct_obj%csr3d_mesh_size, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine space_charge_common_struct_get_n_bin(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bin
  end subroutine


  subroutine space_charge_common_struct_get_particle_bin_span(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%particle_bin_span
  end subroutine


  subroutine space_charge_common_struct_get_n_shield_images(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_shield_images
  end subroutine


  subroutine space_charge_common_struct_get_sc_min_in_bin(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sc_min_in_bin
  end subroutine


  subroutine space_charge_common_struct_get_lsc_kick_transverse_dependence(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lsc_kick_transverse_dependence
  end subroutine


  subroutine space_charge_common_struct_get_debug(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%debug
  end subroutine


  subroutine space_charge_common_struct_get_diagnostic_output_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(space_charge_common_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%diagnostic_output_file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%diagnostic_output_file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! bmad_common_struct

  subroutine bmad_common_struct_get_max_aperture_limit(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%max_aperture_limit
  end subroutine


  subroutine bmad_common_struct_get_d_orb_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%d_orb(lbound(struct_obj%d_orb, 1)))
    lower_bound = int(lbound(struct_obj%d_orb, 1), c_int)
    upper_bound = int(ubound(struct_obj%d_orb, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine bmad_common_struct_get_default_ds_step(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%default_ds_step
  end subroutine


  subroutine bmad_common_struct_get_significant_length(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%significant_length
  end subroutine


  subroutine bmad_common_struct_get_rel_tol_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rel_tol_tracking
  end subroutine


  subroutine bmad_common_struct_get_abs_tol_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%abs_tol_tracking
  end subroutine


  subroutine bmad_common_struct_get_rel_tol_adaptive_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rel_tol_adaptive_tracking
  end subroutine


  subroutine bmad_common_struct_get_abs_tol_adaptive_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%abs_tol_adaptive_tracking
  end subroutine


  subroutine bmad_common_struct_get_init_ds_adaptive_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%init_ds_adaptive_tracking
  end subroutine


  subroutine bmad_common_struct_get_min_ds_adaptive_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%min_ds_adaptive_tracking
  end subroutine


  subroutine bmad_common_struct_get_fatal_ds_adaptive_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%fatal_ds_adaptive_tracking
  end subroutine


  subroutine bmad_common_struct_get_autoscale_amp_abs_tol(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%autoscale_amp_abs_tol
  end subroutine


  subroutine bmad_common_struct_get_autoscale_amp_rel_tol(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%autoscale_amp_rel_tol
  end subroutine


  subroutine bmad_common_struct_get_autoscale_phase_tol(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%autoscale_phase_tol
  end subroutine


  subroutine bmad_common_struct_get_electric_dipole_moment(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%electric_dipole_moment
  end subroutine


  subroutine bmad_common_struct_get_synch_rad_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%synch_rad_scale
  end subroutine


  subroutine bmad_common_struct_get_sad_eps_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sad_eps_scale
  end subroutine


  subroutine bmad_common_struct_get_sad_amp_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sad_amp_max
  end subroutine


  subroutine bmad_common_struct_get_sad_n_div_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sad_n_div_max
  end subroutine


  subroutine bmad_common_struct_get_taylor_order(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%taylor_order
  end subroutine


  subroutine bmad_common_struct_get_runge_kutta_order(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%runge_kutta_order
  end subroutine


  subroutine bmad_common_struct_get_default_integ_order(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%default_integ_order
  end subroutine


  subroutine bmad_common_struct_get_max_num_runge_kutta_step(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%max_num_runge_kutta_step
  end subroutine


  subroutine bmad_common_struct_get_rf_phase_below_transition_ref(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rf_phase_below_transition_ref
  end subroutine


  subroutine bmad_common_struct_get_sr_wakes_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sr_wakes_on
  end subroutine


  subroutine bmad_common_struct_get_lr_wakes_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lr_wakes_on
  end subroutine


  subroutine bmad_common_struct_get_auto_bookkeeper(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%auto_bookkeeper
  end subroutine


  subroutine bmad_common_struct_get_high_energy_space_charge_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%high_energy_space_charge_on
  end subroutine


  subroutine bmad_common_struct_get_csr_and_space_charge_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%csr_and_space_charge_on
  end subroutine


  subroutine bmad_common_struct_get_spin_tracking_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_tracking_on
  end subroutine


  subroutine bmad_common_struct_get_spin_sokolov_ternov_flipping_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_sokolov_ternov_flipping_on
  end subroutine


  subroutine bmad_common_struct_get_radiation_damping_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radiation_damping_on
  end subroutine


  subroutine bmad_common_struct_get_radiation_zero_average(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radiation_zero_average
  end subroutine


  subroutine bmad_common_struct_get_radiation_fluctuations_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radiation_fluctuations_on
  end subroutine


  subroutine bmad_common_struct_get_conserve_taylor_maps(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%conserve_taylor_maps
  end subroutine


  subroutine bmad_common_struct_get_absolute_time_tracking(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%absolute_time_tracking
  end subroutine


  subroutine bmad_common_struct_get_absolute_time_ref_shift(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%absolute_time_ref_shift
  end subroutine


  subroutine bmad_common_struct_get_convert_to_kinetic_momentum(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%convert_to_kinetic_momentum
  end subroutine


  subroutine bmad_common_struct_get_normalize_twiss(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%normalize_twiss
  end subroutine


  subroutine bmad_common_struct_get_aperture_limit_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%aperture_limit_on
  end subroutine


  subroutine bmad_common_struct_get_spin_n0_direction_user_set(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_n0_direction_user_set
  end subroutine


  subroutine bmad_common_struct_get_debug(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%debug
  end subroutine

! rad_int1_struct

  subroutine rad_int1_struct_get_i0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i0
  end subroutine


  subroutine rad_int1_struct_get_i1(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i1
  end subroutine


  subroutine rad_int1_struct_get_i2(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i2
  end subroutine


  subroutine rad_int1_struct_get_i3(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i3
  end subroutine


  subroutine rad_int1_struct_get_i4a(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i4a
  end subroutine


  subroutine rad_int1_struct_get_i4b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i4b
  end subroutine


  subroutine rad_int1_struct_get_i4z(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i4z
  end subroutine


  subroutine rad_int1_struct_get_i5a(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i5a
  end subroutine


  subroutine rad_int1_struct_get_i5b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i5b
  end subroutine


  subroutine rad_int1_struct_get_i6b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i6b
  end subroutine


  subroutine rad_int1_struct_get_lin_i2_E4(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_i2_E4
  end subroutine


  subroutine rad_int1_struct_get_lin_i3_E7(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_i3_E7
  end subroutine


  subroutine rad_int1_struct_get_lin_i5a_E6(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_i5a_E6
  end subroutine


  subroutine rad_int1_struct_get_lin_i5b_E6(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_i5b_E6
  end subroutine


  subroutine rad_int1_struct_get_lin_norm_emit_a(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_norm_emit_a
  end subroutine


  subroutine rad_int1_struct_get_lin_norm_emit_b(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_norm_emit_b
  end subroutine


  subroutine rad_int1_struct_get_lin_sig_E(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_sig_E
  end subroutine


  subroutine rad_int1_struct_get_n_steps(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_steps
  end subroutine

! rad_int_branch_struct
! skipped rad_int_branch_struct%ele: Unsupported type: 1D_ALLOC_type
! rad_int_all_ele_struct
! skipped rad_int_all_ele_struct%branch: Unsupported type: 1D_ALLOC_type
! rf_stair_step_struct

  subroutine rf_stair_step_struct_get_E_tot0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_tot0
  end subroutine


  subroutine rf_stair_step_struct_get_E_tot1(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_tot1
  end subroutine


  subroutine rf_stair_step_struct_get_p0c(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%p0c
  end subroutine


  subroutine rf_stair_step_struct_get_p1c(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%p1c
  end subroutine


  subroutine rf_stair_step_struct_get_dE_amp(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dE_amp
  end subroutine


  subroutine rf_stair_step_struct_get_scale(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%scale
  end subroutine


  subroutine rf_stair_step_struct_get_time(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time
  end subroutine


  subroutine rf_stair_step_struct_get_s(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine


  subroutine rf_stair_step_struct_get_ix_step(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_step
  end subroutine

! rf_ele_struct
! skipped rf_ele_struct%steps: Unsupported type: 1D_ALLOC_type

  subroutine rf_ele_struct_get_ds_step(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ds_step
  end subroutine

! ele_struct

  subroutine ele_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ele_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine ele_struct_get_type_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ele_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%type)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%type), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine ele_struct_get_alias_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ele_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%alias)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%alias), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine ele_struct_get_component_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ele_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%component_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%component_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine ele_struct_get_descrip_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(ele_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%descrip)) then
      data_ptr = c_loc(struct_obj%descrip)
      lower_bound = 1_c_int
      upper_bound = int(len_trim(struct_obj%descrip), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine


  subroutine ele_struct_get_a(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine


  subroutine ele_struct_get_b(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine


  subroutine ele_struct_get_z(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z)
  end subroutine


  subroutine ele_struct_get_x(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%x)
  end subroutine


  subroutine ele_struct_get_y(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%y)
  end subroutine


  subroutine ele_struct_get_ac_kick(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ac_kick)) then
      ptr_out = c_loc(struct_obj%ac_kick)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine ele_struct_get_bookkeeping_state(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%bookkeeping_state)
  end subroutine


  subroutine ele_struct_get_branch(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%branch)) then
      ptr_out = c_loc(struct_obj%branch)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine ele_struct_get_control(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%control)) then
      ptr_out = c_loc(struct_obj%control)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine ele_struct_get_rf(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%rf)) then
      ptr_out = c_loc(struct_obj%rf)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine ele_struct_get_lord(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%lord)) then
      ptr_out = c_loc(struct_obj%lord)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine ele_struct_get_floor(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%floor)
  end subroutine


  subroutine ele_struct_get_high_energy_space_charge(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%high_energy_space_charge)) then
      ptr_out = c_loc(struct_obj%high_energy_space_charge)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine ele_struct_get_mode3(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%mode3)) then
      ptr_out = c_loc(struct_obj%mode3)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine ele_struct_get_photon(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%photon)) then
      ptr_out = c_loc(struct_obj%photon)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine ele_struct_get_rad_map(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%rad_map)) then
      ptr_out = c_loc(struct_obj%rad_map)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

! skipped ele_struct%taylor: Unsupported type: 1D_NOT_type

  subroutine ele_struct_get_spin_taylor_ref_orb_in_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%spin_taylor_ref_orb_in(lbound(struct_obj%spin_taylor_ref_orb_in, 1)))
    lower_bound = int(lbound(struct_obj%spin_taylor_ref_orb_in, 1), c_int)
    upper_bound = int(ubound(struct_obj%spin_taylor_ref_orb_in, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped ele_struct%spin_taylor: Unsupported type: 1D_NOT_type

  subroutine ele_struct_get_wake(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%wake)) then
      ptr_out = c_loc(struct_obj%wake)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

! skipped ele_struct%wall3d: Unsupported type: 1D_PTR_type
! skipped ele_struct%cartesian_map: Unsupported type: 1D_PTR_type
! skipped ele_struct%cylindrical_map: Unsupported type: 1D_PTR_type
! skipped ele_struct%gen_grad_map: Unsupported type: 1D_PTR_type
! skipped ele_struct%grid_field: Unsupported type: 1D_PTR_type

  subroutine ele_struct_get_map_ref_orb_in(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%map_ref_orb_in)
  end subroutine


  subroutine ele_struct_get_map_ref_orb_out(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%map_ref_orb_out)
  end subroutine


  subroutine ele_struct_get_time_ref_orb_in(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%time_ref_orb_in)
  end subroutine


  subroutine ele_struct_get_time_ref_orb_out(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%time_ref_orb_out)
  end subroutine


  subroutine ele_struct_get_value_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%value(lbound(struct_obj%value, 1)))
    lower_bound = int(lbound(struct_obj%value, 1), c_int)
    upper_bound = int(ubound(struct_obj%value, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine ele_struct_get_old_value_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%old_value(lbound(struct_obj%old_value, 1)))
    lower_bound = int(lbound(struct_obj%old_value, 1), c_int)
    upper_bound = int(ubound(struct_obj%old_value, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped ele_struct%spin_q: Unsupported type: 2D_NOT_real

  subroutine ele_struct_get_vec0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%vec0(lbound(struct_obj%vec0, 1)))
    lower_bound = int(lbound(struct_obj%vec0, 1), c_int)
    upper_bound = int(ubound(struct_obj%vec0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped ele_struct%mat6: Unsupported type: 2D_NOT_real
! skipped ele_struct%c_mat: Unsupported type: 2D_NOT_real

  subroutine ele_struct_get_gamma_c(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%gamma_c
  end subroutine


  subroutine ele_struct_get_s_start(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_start
  end subroutine


  subroutine ele_struct_get_s(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine


  subroutine ele_struct_get_ref_time(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref_time
  end subroutine

! skipped ele_struct%a_pole: Unsupported type: 1D_PTR_real
! skipped ele_struct%b_pole: Unsupported type: 1D_PTR_real
! skipped ele_struct%a_pole_elec: Unsupported type: 1D_PTR_real
! skipped ele_struct%b_pole_elec: Unsupported type: 1D_PTR_real
! skipped ele_struct%custom: Unsupported type: 1D_PTR_real
! skipped ele_struct%r: Unsupported type: 3D_PTR_real

  subroutine ele_struct_get_key(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%key
  end subroutine


  subroutine ele_struct_get_sub_key(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sub_key
  end subroutine


  subroutine ele_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine


  subroutine ele_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine


  subroutine ele_struct_get_lord_status(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lord_status
  end subroutine


  subroutine ele_struct_get_n_slave(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_slave
  end subroutine


  subroutine ele_struct_get_n_slave_field(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_slave_field
  end subroutine


  subroutine ele_struct_get_ix1_slave(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix1_slave
  end subroutine


  subroutine ele_struct_get_slave_status(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%slave_status
  end subroutine


  subroutine ele_struct_get_n_lord(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_lord
  end subroutine


  subroutine ele_struct_get_n_lord_field(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_lord_field
  end subroutine


  subroutine ele_struct_get_n_lord_ramper(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_lord_ramper
  end subroutine


  subroutine ele_struct_get_ic1_lord(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ic1_lord
  end subroutine


  subroutine ele_struct_get_ix_pointer(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_pointer
  end subroutine


  subroutine ele_struct_get_ixx(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ixx
  end subroutine


  subroutine ele_struct_get_iyy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%iyy
  end subroutine


  subroutine ele_struct_get_izz(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%izz
  end subroutine


  subroutine ele_struct_get_mat6_calc_method(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%mat6_calc_method
  end subroutine


  subroutine ele_struct_get_tracking_method(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tracking_method
  end subroutine


  subroutine ele_struct_get_spin_tracking_method(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_tracking_method
  end subroutine


  subroutine ele_struct_get_csr_method(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%csr_method
  end subroutine


  subroutine ele_struct_get_space_charge_method(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%space_charge_method
  end subroutine


  subroutine ele_struct_get_ptc_integration_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ptc_integration_type
  end subroutine


  subroutine ele_struct_get_field_calc(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_calc
  end subroutine


  subroutine ele_struct_get_aperture_at(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%aperture_at
  end subroutine


  subroutine ele_struct_get_aperture_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%aperture_type
  end subroutine


  subroutine ele_struct_get_ref_species(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref_species
  end subroutine


  subroutine ele_struct_get_orientation(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%orientation
  end subroutine


  subroutine ele_struct_get_symplectify(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%symplectify
  end subroutine


  subroutine ele_struct_get_mode_flip(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%mode_flip
  end subroutine


  subroutine ele_struct_get_multipoles_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%multipoles_on
  end subroutine


  subroutine ele_struct_get_scale_multipoles(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%scale_multipoles
  end subroutine


  subroutine ele_struct_get_taylor_map_includes_offsets(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%taylor_map_includes_offsets
  end subroutine


  subroutine ele_struct_get_field_master(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_master
  end subroutine


  subroutine ele_struct_get_is_on(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%is_on
  end subroutine


  subroutine ele_struct_get_logic(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%logic
  end subroutine


  subroutine ele_struct_get_bmad_logic(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%bmad_logic
  end subroutine


  subroutine ele_struct_get_select(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%select
  end subroutine


  subroutine ele_struct_get_offset_moves_aperture(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%offset_moves_aperture
  end subroutine

! complex_taylor_term_struct

  subroutine complex_taylor_term_struct_get_coef(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(complex_taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%coef
  end subroutine


  subroutine complex_taylor_term_struct_get_expn_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(complex_taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%expn(lbound(struct_obj%expn, 1)))
    lower_bound = int(lbound(struct_obj%expn, 1), c_int)
    upper_bound = int(ubound(struct_obj%expn, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! complex_taylor_struct

  subroutine complex_taylor_struct_get_ref(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(complex_taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref
  end subroutine

! skipped complex_taylor_struct%term: Unsupported type: 1D_PTR_type
! branch_struct

  subroutine branch_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(branch_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine branch_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine


  subroutine branch_struct_get_ix_from_branch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_from_branch
  end subroutine


  subroutine branch_struct_get_ix_from_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_from_ele
  end subroutine


  subroutine branch_struct_get_ix_to_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_to_ele
  end subroutine


  subroutine branch_struct_get_ix_fixer(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_fixer
  end subroutine


  subroutine branch_struct_get_n_ele_track(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ele_track
  end subroutine


  subroutine branch_struct_get_n_ele_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ele_max
  end subroutine


  subroutine branch_struct_get_lat(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%lat)) then
      ptr_out = c_loc(struct_obj%lat)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine branch_struct_get_a(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine


  subroutine branch_struct_get_b(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine


  subroutine branch_struct_get_z(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z)
  end subroutine

! skipped branch_struct%ele: Unsupported type: 1D_PTR_type

  subroutine branch_struct_get_param(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%param)
  end subroutine


  subroutine branch_struct_get_particle_start(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%particle_start)
  end subroutine

! skipped branch_struct%wall3d: Unsupported type: 1D_PTR_type
! lat_struct

  subroutine lat_struct_get_use_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(lat_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%use_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%use_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine lat_struct_get_lattice_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(lat_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%lattice)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%lattice), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine lat_struct_get_machine_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(lat_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%machine)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%machine), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine lat_struct_get_input_file_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(lat_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%input_file_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%input_file_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine lat_struct_get_title_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(lat_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%title)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%title), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! skipped lat_struct%print_str: Unsupported type: 1D_ALLOC_character
! skipped lat_struct%constant: Unsupported type: 1D_ALLOC_type

  subroutine lat_struct_get_a(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%a)) then
      ptr_out = c_loc(struct_obj%a)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine lat_struct_get_b(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%b)) then
      ptr_out = c_loc(struct_obj%b)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine lat_struct_get_z(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%z)) then
      ptr_out = c_loc(struct_obj%z)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine lat_struct_get_param(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%param)) then
      ptr_out = c_loc(struct_obj%param)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine lat_struct_get_lord_state(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lord_state)
  end subroutine


  subroutine lat_struct_get_ele_init(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ele_init)
  end subroutine

! skipped lat_struct%branch: Unsupported type: 1D_ALLOC_type
! skipped lat_struct%control: Unsupported type: 1D_ALLOC_type

  subroutine lat_struct_get_particle_start(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%particle_start)) then
      ptr_out = c_loc(struct_obj%particle_start)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine lat_struct_get_beam_init(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam_init)
  end subroutine


  subroutine lat_struct_get_pre_tracker(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%pre_tracker)
  end subroutine


  subroutine lat_struct_get_custom_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%custom)) then
      data_ptr = c_loc(struct_obj%custom(lbound(struct_obj%custom, 1)))
      lower_bound = int(lbound(struct_obj%custom, 1), c_int)
      upper_bound = int(ubound(struct_obj%custom, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine


  subroutine lat_struct_get_version(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%version
  end subroutine


  subroutine lat_struct_get_n_ele_track(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%n_ele_track)) then
      ptr_out = c_loc(struct_obj%n_ele_track)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine lat_struct_get_n_ele_max(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%n_ele_max)) then
      ptr_out = c_loc(struct_obj%n_ele_max)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine


  subroutine lat_struct_get_n_control_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_control_max
  end subroutine


  subroutine lat_struct_get_n_ic_max(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ic_max
  end subroutine


  subroutine lat_struct_get_input_taylor_order(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%input_taylor_order
  end subroutine


  subroutine lat_struct_get_ic_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ic)) then
      data_ptr = c_loc(struct_obj%ic(lbound(struct_obj%ic, 1)))
      lower_bound = int(lbound(struct_obj%ic, 1), c_int)
      upper_bound = int(ubound(struct_obj%ic, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine


  subroutine lat_struct_get_photon_type(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%photon_type
  end subroutine


  subroutine lat_struct_get_creation_hash(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%creation_hash
  end subroutine


  subroutine lat_struct_get_ramper_slave_bookkeeping(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ramper_slave_bookkeeping
  end subroutine

! bunch_struct
! skipped bunch_struct%particle: Unsupported type: 1D_ALLOC_type

  subroutine bunch_struct_get_ix_z_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ix_z)) then
      data_ptr = c_loc(struct_obj%ix_z(lbound(struct_obj%ix_z, 1)))
      lower_bound = int(lbound(struct_obj%ix_z, 1), c_int)
      upper_bound = int(ubound(struct_obj%ix_z, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine


  subroutine bunch_struct_get_charge_tot(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge_tot
  end subroutine


  subroutine bunch_struct_get_charge_live(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge_live
  end subroutine


  subroutine bunch_struct_get_z_center(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_center
  end subroutine


  subroutine bunch_struct_get_t_center(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t_center
  end subroutine


  subroutine bunch_struct_get_t0(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t0
  end subroutine


  subroutine bunch_struct_get_drift_between_t_and_s(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%drift_between_t_and_s
  end subroutine


  subroutine bunch_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine


  subroutine bunch_struct_get_ix_bunch(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_bunch
  end subroutine


  subroutine bunch_struct_get_ix_turn(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_turn
  end subroutine


  subroutine bunch_struct_get_n_live(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_live
  end subroutine


  subroutine bunch_struct_get_n_good(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_good
  end subroutine


  subroutine bunch_struct_get_n_bad(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bad
  end subroutine

! bunch_params_struct

  subroutine bunch_params_struct_get_centroid(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%centroid)
  end subroutine


  subroutine bunch_params_struct_get_x(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%x)
  end subroutine


  subroutine bunch_params_struct_get_y(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%y)
  end subroutine


  subroutine bunch_params_struct_get_z(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z)
  end subroutine


  subroutine bunch_params_struct_get_a(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine


  subroutine bunch_params_struct_get_b(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine


  subroutine bunch_params_struct_get_c(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%c)
  end subroutine

! skipped bunch_params_struct%sigma: Unsupported type: 2D_NOT_real

  subroutine bunch_params_struct_get_rel_max_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%rel_max(lbound(struct_obj%rel_max, 1)))
    lower_bound = int(lbound(struct_obj%rel_max, 1), c_int)
    upper_bound = int(ubound(struct_obj%rel_max, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine bunch_params_struct_get_rel_min_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%rel_min(lbound(struct_obj%rel_min, 1)))
    lower_bound = int(lbound(struct_obj%rel_min, 1), c_int)
    upper_bound = int(ubound(struct_obj%rel_min, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine


  subroutine bunch_params_struct_get_s(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine


  subroutine bunch_params_struct_get_t(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t
  end subroutine


  subroutine bunch_params_struct_get_sigma_t(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma_t
  end subroutine


  subroutine bunch_params_struct_get_charge_live(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge_live
  end subroutine


  subroutine bunch_params_struct_get_charge_tot(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge_tot
  end subroutine


  subroutine bunch_params_struct_get_n_particle_tot(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_particle_tot
  end subroutine


  subroutine bunch_params_struct_get_n_particle_live(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_particle_live
  end subroutine


  subroutine bunch_params_struct_get_n_particle_lost_in_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_particle_lost_in_ele
  end subroutine


  subroutine bunch_params_struct_get_n_good_steps(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_good_steps
  end subroutine


  subroutine bunch_params_struct_get_n_bad_steps(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bad_steps
  end subroutine


  subroutine bunch_params_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine


  subroutine bunch_params_struct_get_location(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%location
  end subroutine


  subroutine bunch_params_struct_get_twiss_valid(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%twiss_valid
  end subroutine

! beam_struct
! skipped beam_struct%bunch: Unsupported type: 1D_ALLOC_type
! aperture_point_struct

  subroutine aperture_point_struct_get_x(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x
  end subroutine


  subroutine aperture_point_struct_get_y(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y
  end subroutine


  subroutine aperture_point_struct_get_plane(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%plane
  end subroutine


  subroutine aperture_point_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine


  subroutine aperture_point_struct_get_i_turn(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i_turn
  end subroutine

! aperture_param_struct

  subroutine aperture_param_struct_get_min_angle(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%min_angle
  end subroutine


  subroutine aperture_param_struct_get_max_angle(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%max_angle
  end subroutine


  subroutine aperture_param_struct_get_n_angle(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_angle
  end subroutine


  subroutine aperture_param_struct_get_n_turn(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_turn
  end subroutine


  subroutine aperture_param_struct_get_x_init(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_init
  end subroutine


  subroutine aperture_param_struct_get_y_init(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y_init
  end subroutine


  subroutine aperture_param_struct_get_rel_accuracy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rel_accuracy
  end subroutine


  subroutine aperture_param_struct_get_abs_accuracy(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%abs_accuracy
  end subroutine


  subroutine aperture_param_struct_get_start_ele_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(aperture_param_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%start_ele)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%start_ele), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

! aperture_scan_struct
! skipped aperture_scan_struct%point: Unsupported type: 1D_ALLOC_type

  subroutine aperture_scan_struct_get_ref_orb(struct_obj_ptr, ptr_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(aperture_scan_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ref_orb)
  end subroutine


  subroutine aperture_scan_struct_get_pz_start(struct_obj_ptr, value_out) bind(c)
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_scan_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pz_start
  end subroutine

end module
