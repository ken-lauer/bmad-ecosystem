module bmad_struct_proxy_mod
  use bmad_struct
  use tao_struct
  use, intrinsic :: iso_c_binding
contains

  !! spline_struct
  ! spline_struct%x0: 0D_NOT_real

  subroutine spline_struct_get_x0(struct_obj_ptr, value_out) bind(c, name='spline_struct_get_x0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spline_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine

  ! spline_struct%y0: 0D_NOT_real

  subroutine spline_struct_get_y0(struct_obj_ptr, value_out) bind(c, name='spline_struct_get_y0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spline_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine

  ! spline_struct%x1: 0D_NOT_real

  subroutine spline_struct_get_x1(struct_obj_ptr, value_out) bind(c, name='spline_struct_get_x1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spline_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x1
  end subroutine

  ! spline_struct%coef: 1D_NOT_real

  subroutine spline_struct_get_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='spline_struct_get_coef_info')
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

  !! spin_polar_struct
  ! spin_polar_struct%polarization: 0D_NOT_real

  subroutine spin_polar_struct_get_polarization(struct_obj_ptr, value_out) bind(c, name='spin_polar_struct_get_polarization')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spin_polar_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%polarization
  end subroutine

  ! spin_polar_struct%theta: 0D_NOT_real

  subroutine spin_polar_struct_get_theta(struct_obj_ptr, value_out) bind(c, name='spin_polar_struct_get_theta')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spin_polar_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%theta
  end subroutine

  ! spin_polar_struct%phi: 0D_NOT_real

  subroutine spin_polar_struct_get_phi(struct_obj_ptr, value_out) bind(c, name='spin_polar_struct_get_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spin_polar_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine

  ! spin_polar_struct%xi: 0D_NOT_real

  subroutine spin_polar_struct_get_xi(struct_obj_ptr, value_out) bind(c, name='spin_polar_struct_get_xi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(spin_polar_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%xi
  end subroutine

  !! ac_kicker_time_struct
  ! ac_kicker_time_struct%amp: 0D_NOT_real

  subroutine ac_kicker_time_struct_get_amp(struct_obj_ptr, value_out) bind(c, name='ac_kicker_time_struct_get_amp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_time_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp
  end subroutine

  ! ac_kicker_time_struct%time: 0D_NOT_real

  subroutine ac_kicker_time_struct_get_time(struct_obj_ptr, value_out) bind(c, name='ac_kicker_time_struct_get_time')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_time_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time
  end subroutine

  ! ac_kicker_time_struct%spline: 0D_NOT_type

  subroutine ac_kicker_time_struct_get_spline(struct_obj_ptr, ptr_out) bind(c, name='ac_kicker_time_struct_get_spline')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ac_kicker_time_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%spline)
  end subroutine

  !! ac_kicker_freq_struct
  ! ac_kicker_freq_struct%f: 0D_NOT_real

  subroutine ac_kicker_freq_struct_get_f(struct_obj_ptr, value_out) bind(c, name='ac_kicker_freq_struct_get_f')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_freq_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f
  end subroutine

  ! ac_kicker_freq_struct%amp: 0D_NOT_real

  subroutine ac_kicker_freq_struct_get_amp(struct_obj_ptr, value_out) bind(c, name='ac_kicker_freq_struct_get_amp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_freq_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp
  end subroutine

  ! ac_kicker_freq_struct%phi: 0D_NOT_real

  subroutine ac_kicker_freq_struct_get_phi(struct_obj_ptr, value_out) bind(c, name='ac_kicker_freq_struct_get_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ac_kicker_freq_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine

  ! ac_kicker_freq_struct%rf_clock_harmonic: 0D_NOT_integer

  subroutine ac_kicker_freq_struct_get_rf_clock_harmonic(struct_obj_ptr, value_out) bind(c, name='ac_kicker_freq_struct_get_rf_clock_harmonic')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ac_kicker_freq_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rf_clock_harmonic
  end subroutine

  !! ac_kicker_struct
  ! ac_kicker_struct%amp_vs_time: 1D_ALLOC_type

  subroutine ac_kicker_struct_get_amp_vs_time_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='ac_kicker_struct_get_amp_vs_time_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(ac_kicker_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%amp_vs_time)) then
      data_ptr = c_loc(struct_obj%amp_vs_time(lbound(struct_obj%amp_vs_time, 1)))
      lower_bound = int(lbound(struct_obj%amp_vs_time, 1), c_int)
      upper_bound = int(ubound(struct_obj%amp_vs_time, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%amp_vs_time(lbound(struct_obj%amp_vs_time, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! ac_kicker_struct%frequency: 1D_ALLOC_type

  subroutine ac_kicker_struct_get_frequency_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='ac_kicker_struct_get_frequency_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(ac_kicker_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%frequency)) then
      data_ptr = c_loc(struct_obj%frequency(lbound(struct_obj%frequency, 1)))
      lower_bound = int(lbound(struct_obj%frequency, 1), c_int)
      upper_bound = int(ubound(struct_obj%frequency, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%frequency(lbound(struct_obj%frequency, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! interval1_coef_struct
  ! interval1_coef_struct%c0: 0D_NOT_real

  subroutine interval1_coef_struct_get_c0(struct_obj_ptr, value_out) bind(c, name='interval1_coef_struct_get_c0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(interval1_coef_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%c0
  end subroutine

  ! interval1_coef_struct%c1: 0D_NOT_real

  subroutine interval1_coef_struct_get_c1(struct_obj_ptr, value_out) bind(c, name='interval1_coef_struct_get_c1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(interval1_coef_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%c1
  end subroutine

  ! interval1_coef_struct%n_exp: 0D_NOT_real

  subroutine interval1_coef_struct_get_n_exp(struct_obj_ptr, value_out) bind(c, name='interval1_coef_struct_get_n_exp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(interval1_coef_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_exp
  end subroutine

  !! photon_reflect_table_struct
  ! photon_reflect_table_struct%angle: 1D_ALLOC_real

  subroutine photon_reflect_table_struct_get_angle_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='photon_reflect_table_struct_get_angle_info')
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

  ! photon_reflect_table_struct%energy: 1D_ALLOC_real

  subroutine photon_reflect_table_struct_get_energy_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='photon_reflect_table_struct_get_energy_info')
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

  ! photon_reflect_table_struct%int1: 1D_ALLOC_type

  subroutine photon_reflect_table_struct_get_int1_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='photon_reflect_table_struct_get_int1_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(photon_reflect_table_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%int1)) then
      data_ptr = c_loc(struct_obj%int1(lbound(struct_obj%int1, 1)))
      lower_bound = int(lbound(struct_obj%int1, 1), c_int)
      upper_bound = int(ubound(struct_obj%int1, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%int1(lbound(struct_obj%int1, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! photon_reflect_table_struct%p_reflect: 2D_ALLOC_real

  subroutine photon_reflect_table_struct_get_p_reflect_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c, name='photon_reflect_table_struct_get_p_reflect_info')
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

  ! photon_reflect_table_struct%max_energy: 0D_NOT_real

  subroutine photon_reflect_table_struct_get_max_energy(struct_obj_ptr, value_out) bind(c, name='photon_reflect_table_struct_get_max_energy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(photon_reflect_table_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%max_energy
  end subroutine

  ! photon_reflect_table_struct%p_reflect_scratch: 1D_ALLOC_real

  subroutine photon_reflect_table_struct_get_p_reflect_scratch_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='photon_reflect_table_struct_get_p_reflect_scratch_info')
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

  ! photon_reflect_table_struct%bragg_angle: 1D_ALLOC_real

  subroutine photon_reflect_table_struct_get_bragg_angle_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='photon_reflect_table_struct_get_bragg_angle_info')
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

  !! photon_reflect_surface_struct
  ! photon_reflect_surface_struct%name: 0D_NOT_character

  subroutine photon_reflect_surface_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='photon_reflect_surface_struct_get_name_info')
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

  ! photon_reflect_surface_struct%description: 0D_NOT_character

  subroutine photon_reflect_surface_struct_get_description_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='photon_reflect_surface_struct_get_description_info')
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

  ! photon_reflect_surface_struct%reflectivity_file: 0D_NOT_character

  subroutine photon_reflect_surface_struct_get_reflectivity_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='photon_reflect_surface_struct_get_reflectivity_file_info')
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

  ! photon_reflect_surface_struct%table: 1D_ALLOC_type

  subroutine photon_reflect_surface_struct_get_table_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='photon_reflect_surface_struct_get_table_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(photon_reflect_surface_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%table)) then
      data_ptr = c_loc(struct_obj%table(lbound(struct_obj%table, 1)))
      lower_bound = int(lbound(struct_obj%table, 1), c_int)
      upper_bound = int(ubound(struct_obj%table, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%table(lbound(struct_obj%table, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! photon_reflect_surface_struct%surface_roughness_rms: 0D_NOT_real

  subroutine photon_reflect_surface_struct_get_surface_roughness_rms(struct_obj_ptr, value_out) bind(c, name='photon_reflect_surface_struct_get_surface_roughness_rms')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(photon_reflect_surface_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%surface_roughness_rms
  end subroutine

  ! photon_reflect_surface_struct%roughness_correlation_len: 0D_NOT_real

  subroutine photon_reflect_surface_struct_get_roughness_correlation_len(struct_obj_ptr, value_out) bind(c, name='photon_reflect_surface_struct_get_roughness_correlation_len')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(photon_reflect_surface_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%roughness_correlation_len
  end subroutine

  ! photon_reflect_surface_struct%ix_surface: 0D_NOT_integer

  subroutine photon_reflect_surface_struct_get_ix_surface(struct_obj_ptr, value_out) bind(c, name='photon_reflect_surface_struct_get_ix_surface')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(photon_reflect_surface_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_surface
  end subroutine

  !! coord_struct
  ! coord_struct%vec: 1D_NOT_real

  subroutine coord_struct_get_vec_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='coord_struct_get_vec_info')
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

  ! coord_struct%s: 0D_NOT_real

  subroutine coord_struct_get_s(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_s')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine

  ! coord_struct%t: 0D_NOT_real16

  subroutine coord_struct_get_t(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_t')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_long_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t
  end subroutine

  ! coord_struct%spin: 1D_NOT_real

  subroutine coord_struct_get_spin_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='coord_struct_get_spin_info')
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

  ! coord_struct%field: 1D_NOT_real

  subroutine coord_struct_get_field_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='coord_struct_get_field_info')
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

  ! coord_struct%phase: 1D_NOT_real

  subroutine coord_struct_get_phase_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='coord_struct_get_phase_info')
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

  ! coord_struct%charge: 0D_NOT_real

  subroutine coord_struct_get_charge(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_charge')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge
  end subroutine

  ! coord_struct%dt_ref: 0D_NOT_real

  subroutine coord_struct_get_dt_ref(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_dt_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dt_ref
  end subroutine

  ! coord_struct%r: 0D_NOT_real

  subroutine coord_struct_get_r(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_r')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%r
  end subroutine

  ! coord_struct%p0c: 0D_NOT_real

  subroutine coord_struct_get_p0c(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_p0c')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%p0c
  end subroutine

  ! coord_struct%E_potential: 0D_NOT_real

  subroutine coord_struct_get_E_potential(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_E_potential')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_potential
  end subroutine

  ! coord_struct%beta: 0D_NOT_real

  subroutine coord_struct_get_beta(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_beta')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%beta
  end subroutine

  ! coord_struct%ix_ele: 0D_NOT_integer

  subroutine coord_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! coord_struct%ix_branch: 0D_NOT_integer

  subroutine coord_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  ! coord_struct%ix_turn: 0D_NOT_integer

  subroutine coord_struct_get_ix_turn(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_ix_turn')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_turn
  end subroutine

  ! coord_struct%ix_user: 0D_NOT_integer

  subroutine coord_struct_get_ix_user(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_ix_user')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_user
  end subroutine

  ! coord_struct%state: 0D_NOT_integer

  subroutine coord_struct_get_state(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_state')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%state
  end subroutine

  ! coord_struct%direction: 0D_NOT_integer

  subroutine coord_struct_get_direction(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_direction')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%direction
  end subroutine

  ! coord_struct%time_dir: 0D_NOT_integer

  subroutine coord_struct_get_time_dir(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_time_dir')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time_dir
  end subroutine

  ! coord_struct%species: 0D_NOT_integer

  subroutine coord_struct_get_species(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_species')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%species
  end subroutine

  ! coord_struct%location: 0D_NOT_integer

  subroutine coord_struct_get_location(struct_obj_ptr, value_out) bind(c, name='coord_struct_get_location')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(coord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%location
  end subroutine

  !! coord_array_struct
  ! coord_array_struct%orbit: 1D_ALLOC_type

  subroutine coord_array_struct_get_orbit_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='coord_array_struct_get_orbit_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(coord_array_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%orbit)) then
      data_ptr = c_loc(struct_obj%orbit(lbound(struct_obj%orbit, 1)))
      lower_bound = int(lbound(struct_obj%orbit, 1), c_int)
      upper_bound = int(ubound(struct_obj%orbit, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%orbit(lbound(struct_obj%orbit, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! bpm_phase_coupling_struct
  ! bpm_phase_coupling_struct%K_22a: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_K_22a(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_K_22a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%K_22a
  end subroutine

  ! bpm_phase_coupling_struct%K_12a: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_K_12a(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_K_12a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%K_12a
  end subroutine

  ! bpm_phase_coupling_struct%K_11b: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_K_11b(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_K_11b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%K_11b
  end subroutine

  ! bpm_phase_coupling_struct%K_12b: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_K_12b(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_K_12b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%K_12b
  end subroutine

  ! bpm_phase_coupling_struct%Cbar22_a: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_Cbar22_a(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_Cbar22_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Cbar22_a
  end subroutine

  ! bpm_phase_coupling_struct%Cbar12_a: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_Cbar12_a(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_Cbar12_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Cbar12_a
  end subroutine

  ! bpm_phase_coupling_struct%Cbar11_b: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_Cbar11_b(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_Cbar11_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Cbar11_b
  end subroutine

  ! bpm_phase_coupling_struct%Cbar12_b: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_Cbar12_b(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_Cbar12_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Cbar12_b
  end subroutine

  ! bpm_phase_coupling_struct%phi_a: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_phi_a(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_phi_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi_a
  end subroutine

  ! bpm_phase_coupling_struct%phi_b: 0D_NOT_real

  subroutine bpm_phase_coupling_struct_get_phi_b(struct_obj_ptr, value_out) bind(c, name='bpm_phase_coupling_struct_get_phi_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bpm_phase_coupling_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi_b
  end subroutine

  !! expression_atom_struct
  ! expression_atom_struct%name: 0D_NOT_character

  subroutine expression_atom_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='expression_atom_struct_get_name_info')
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

  ! expression_atom_struct%type: 0D_NOT_integer

  subroutine expression_atom_struct_get_type(struct_obj_ptr, value_out) bind(c, name='expression_atom_struct_get_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(expression_atom_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine

  ! expression_atom_struct%value: 0D_NOT_real

  subroutine expression_atom_struct_get_value(struct_obj_ptr, value_out) bind(c, name='expression_atom_struct_get_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(expression_atom_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%value
  end subroutine

  !! wake_sr_z_long_struct
  ! wake_sr_z_long_struct%w: 1D_ALLOC_real

  subroutine wake_sr_z_long_struct_get_w_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='wake_sr_z_long_struct_get_w_info')
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
  ! wake_sr_z_long_struct%dz: 0D_NOT_real

  subroutine wake_sr_z_long_struct_get_dz(struct_obj_ptr, value_out) bind(c, name='wake_sr_z_long_struct_get_dz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz
  end subroutine

  ! wake_sr_z_long_struct%z0: 0D_NOT_real

  subroutine wake_sr_z_long_struct_get_z0(struct_obj_ptr, value_out) bind(c, name='wake_sr_z_long_struct_get_z0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z0
  end subroutine

  ! wake_sr_z_long_struct%smoothing_sigma: 0D_NOT_real

  subroutine wake_sr_z_long_struct_get_smoothing_sigma(struct_obj_ptr, value_out) bind(c, name='wake_sr_z_long_struct_get_smoothing_sigma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%smoothing_sigma
  end subroutine

  ! wake_sr_z_long_struct%position_dependence: 0D_NOT_integer

  subroutine wake_sr_z_long_struct_get_position_dependence(struct_obj_ptr, value_out) bind(c, name='wake_sr_z_long_struct_get_position_dependence')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%position_dependence
  end subroutine

  ! wake_sr_z_long_struct%time_based: 0D_NOT_logical

  subroutine wake_sr_z_long_struct_get_time_based(struct_obj_ptr, value_out) bind(c, name='wake_sr_z_long_struct_get_time_based')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wake_sr_z_long_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time_based
  end subroutine

  !! wake_sr_mode_struct
  ! wake_sr_mode_struct%amp: 0D_NOT_real

  subroutine wake_sr_mode_struct_get_amp(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_amp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp
  end subroutine

  ! wake_sr_mode_struct%damp: 0D_NOT_real

  subroutine wake_sr_mode_struct_get_damp(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_damp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%damp
  end subroutine

  ! wake_sr_mode_struct%k: 0D_NOT_real

  subroutine wake_sr_mode_struct_get_k(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_k')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%k
  end subroutine

  ! wake_sr_mode_struct%phi: 0D_NOT_real

  subroutine wake_sr_mode_struct_get_phi(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine

  ! wake_sr_mode_struct%b_sin: 0D_NOT_real

  subroutine wake_sr_mode_struct_get_b_sin(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_b_sin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_sin
  end subroutine

  ! wake_sr_mode_struct%b_cos: 0D_NOT_real

  subroutine wake_sr_mode_struct_get_b_cos(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_b_cos')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_cos
  end subroutine

  ! wake_sr_mode_struct%a_sin: 0D_NOT_real

  subroutine wake_sr_mode_struct_get_a_sin(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_a_sin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_sin
  end subroutine

  ! wake_sr_mode_struct%a_cos: 0D_NOT_real

  subroutine wake_sr_mode_struct_get_a_cos(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_a_cos')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_cos
  end subroutine

  ! wake_sr_mode_struct%polarization: 0D_NOT_integer

  subroutine wake_sr_mode_struct_get_polarization(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_polarization')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%polarization
  end subroutine

  ! wake_sr_mode_struct%position_dependence: 0D_NOT_integer

  subroutine wake_sr_mode_struct_get_position_dependence(struct_obj_ptr, value_out) bind(c, name='wake_sr_mode_struct_get_position_dependence')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wake_sr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%position_dependence
  end subroutine

  !! wake_sr_struct
  ! wake_sr_struct%file: 0D_NOT_character

  subroutine wake_sr_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wake_sr_struct_get_file_info')
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

  ! wake_sr_struct%z_long: 0D_NOT_type

  subroutine wake_sr_struct_get_z_long(struct_obj_ptr, ptr_out) bind(c, name='wake_sr_struct_get_z_long')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z_long)
  end subroutine

  ! wake_sr_struct%long: 1D_ALLOC_type

  subroutine wake_sr_struct_get_long_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='wake_sr_struct_get_long_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%long)) then
      data_ptr = c_loc(struct_obj%long(lbound(struct_obj%long, 1)))
      lower_bound = int(lbound(struct_obj%long, 1), c_int)
      upper_bound = int(ubound(struct_obj%long, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%long(lbound(struct_obj%long, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! wake_sr_struct%trans: 1D_ALLOC_type

  subroutine wake_sr_struct_get_trans_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='wake_sr_struct_get_trans_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%trans)) then
      data_ptr = c_loc(struct_obj%trans(lbound(struct_obj%trans, 1)))
      lower_bound = int(lbound(struct_obj%trans, 1), c_int)
      upper_bound = int(ubound(struct_obj%trans, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%trans(lbound(struct_obj%trans, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! wake_sr_struct%z_ref_long: 0D_NOT_real

  subroutine wake_sr_struct_get_z_ref_long(struct_obj_ptr, value_out) bind(c, name='wake_sr_struct_get_z_ref_long')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_ref_long
  end subroutine

  ! wake_sr_struct%z_ref_trans: 0D_NOT_real

  subroutine wake_sr_struct_get_z_ref_trans(struct_obj_ptr, value_out) bind(c, name='wake_sr_struct_get_z_ref_trans')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_ref_trans
  end subroutine

  ! wake_sr_struct%z_max: 0D_NOT_real

  subroutine wake_sr_struct_get_z_max(struct_obj_ptr, value_out) bind(c, name='wake_sr_struct_get_z_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_max
  end subroutine

  ! wake_sr_struct%amp_scale: 0D_NOT_real

  subroutine wake_sr_struct_get_amp_scale(struct_obj_ptr, value_out) bind(c, name='wake_sr_struct_get_amp_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp_scale
  end subroutine

  ! wake_sr_struct%z_scale: 0D_NOT_real

  subroutine wake_sr_struct_get_z_scale(struct_obj_ptr, value_out) bind(c, name='wake_sr_struct_get_z_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_scale
  end subroutine

  ! wake_sr_struct%scale_with_length: 0D_NOT_logical

  subroutine wake_sr_struct_get_scale_with_length(struct_obj_ptr, value_out) bind(c, name='wake_sr_struct_get_scale_with_length')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wake_sr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%scale_with_length
  end subroutine

  !! wake_lr_mode_struct
  ! wake_lr_mode_struct%freq: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_freq(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_freq')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%freq
  end subroutine

  ! wake_lr_mode_struct%freq_in: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_freq_in(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_freq_in')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%freq_in
  end subroutine

  ! wake_lr_mode_struct%R_over_Q: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_R_over_Q(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_R_over_Q')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%R_over_Q
  end subroutine

  ! wake_lr_mode_struct%Q: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_Q(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_Q')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%Q
  end subroutine

  ! wake_lr_mode_struct%damp: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_damp(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_damp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%damp
  end subroutine

  ! wake_lr_mode_struct%phi: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_phi(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine

  ! wake_lr_mode_struct%angle: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_angle(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_angle')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%angle
  end subroutine

  ! wake_lr_mode_struct%b_sin: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_b_sin(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_b_sin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_sin
  end subroutine

  ! wake_lr_mode_struct%b_cos: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_b_cos(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_b_cos')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_cos
  end subroutine

  ! wake_lr_mode_struct%a_sin: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_a_sin(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_a_sin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_sin
  end subroutine

  ! wake_lr_mode_struct%a_cos: 0D_NOT_real

  subroutine wake_lr_mode_struct_get_a_cos(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_a_cos')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_cos
  end subroutine

  ! wake_lr_mode_struct%m: 0D_NOT_integer

  subroutine wake_lr_mode_struct_get_m(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_m')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%m
  end subroutine

  ! wake_lr_mode_struct%polarized: 0D_NOT_logical

  subroutine wake_lr_mode_struct_get_polarized(struct_obj_ptr, value_out) bind(c, name='wake_lr_mode_struct_get_polarized')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wake_lr_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%polarized
  end subroutine

  !! wake_lr_struct
  ! wake_lr_struct%file: 0D_NOT_character

  subroutine wake_lr_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wake_lr_struct_get_file_info')
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

  ! wake_lr_struct%mode: 1D_ALLOC_type

  subroutine wake_lr_struct_get_mode_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='wake_lr_struct_get_mode_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%mode)) then
      data_ptr = c_loc(struct_obj%mode(lbound(struct_obj%mode, 1)))
      lower_bound = int(lbound(struct_obj%mode, 1), c_int)
      upper_bound = int(ubound(struct_obj%mode, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%mode(lbound(struct_obj%mode, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! wake_lr_struct%t_ref: 0D_NOT_real

  subroutine wake_lr_struct_get_t_ref(struct_obj_ptr, value_out) bind(c, name='wake_lr_struct_get_t_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t_ref
  end subroutine

  ! wake_lr_struct%freq_spread: 0D_NOT_real

  subroutine wake_lr_struct_get_freq_spread(struct_obj_ptr, value_out) bind(c, name='wake_lr_struct_get_freq_spread')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%freq_spread
  end subroutine

  ! wake_lr_struct%amp_scale: 0D_NOT_real

  subroutine wake_lr_struct_get_amp_scale(struct_obj_ptr, value_out) bind(c, name='wake_lr_struct_get_amp_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%amp_scale
  end subroutine

  ! wake_lr_struct%time_scale: 0D_NOT_real

  subroutine wake_lr_struct_get_time_scale(struct_obj_ptr, value_out) bind(c, name='wake_lr_struct_get_time_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time_scale
  end subroutine

  ! wake_lr_struct%self_wake_on: 0D_NOT_logical

  subroutine wake_lr_struct_get_self_wake_on(struct_obj_ptr, value_out) bind(c, name='wake_lr_struct_get_self_wake_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wake_lr_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%self_wake_on
  end subroutine

  !! lat_ele_loc_struct
  ! lat_ele_loc_struct%ix_ele: 0D_NOT_integer

  subroutine lat_ele_loc_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='lat_ele_loc_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_ele_loc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! lat_ele_loc_struct%ix_branch: 0D_NOT_integer

  subroutine lat_ele_loc_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='lat_ele_loc_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_ele_loc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  !! wake_struct
  ! wake_struct%sr: 0D_NOT_type

  subroutine wake_struct_get_sr(struct_obj_ptr, ptr_out) bind(c, name='wake_struct_get_sr')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(wake_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%sr)
  end subroutine

  ! wake_struct%lr: 0D_NOT_type

  subroutine wake_struct_get_lr(struct_obj_ptr, ptr_out) bind(c, name='wake_struct_get_lr')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(wake_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lr)
  end subroutine

  !! taylor_term_struct
  ! taylor_term_struct%coef: 0D_NOT_real

  subroutine taylor_term_struct_get_coef(struct_obj_ptr, value_out) bind(c, name='taylor_term_struct_get_coef')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%coef
  end subroutine

  ! taylor_term_struct%expn: 1D_NOT_integer

  subroutine taylor_term_struct_get_expn_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='taylor_term_struct_get_expn_info')
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

  !! taylor_struct
  ! taylor_struct%ref: 0D_NOT_real

  subroutine taylor_struct_get_ref(struct_obj_ptr, value_out) bind(c, name='taylor_struct_get_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref
  end subroutine

  ! taylor_struct%term: 1D_PTR_type

  subroutine taylor_struct_get_term_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='taylor_struct_get_term_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%term)) then
      data_ptr = c_loc(struct_obj%term(lbound(struct_obj%term, 1)))
      lower_bound = int(lbound(struct_obj%term, 1), c_int)
      upper_bound = int(ubound(struct_obj%term, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%term(lbound(struct_obj%term, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! em_taylor_term_struct
  ! em_taylor_term_struct%coef: 0D_NOT_real

  subroutine em_taylor_term_struct_get_coef(struct_obj_ptr, value_out) bind(c, name='em_taylor_term_struct_get_coef')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(em_taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%coef
  end subroutine

  ! em_taylor_term_struct%expn: 1D_NOT_integer

  subroutine em_taylor_term_struct_get_expn_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='em_taylor_term_struct_get_expn_info')
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

  !! em_taylor_struct
  ! em_taylor_struct%ref: 0D_NOT_real

  subroutine em_taylor_struct_get_ref(struct_obj_ptr, value_out) bind(c, name='em_taylor_struct_get_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(em_taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref
  end subroutine

  ! em_taylor_struct%term: 1D_ALLOC_type

  subroutine em_taylor_struct_get_term_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='em_taylor_struct_get_term_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(em_taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%term)) then
      data_ptr = c_loc(struct_obj%term(lbound(struct_obj%term, 1)))
      lower_bound = int(lbound(struct_obj%term, 1), c_int)
      upper_bound = int(ubound(struct_obj%term, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%term(lbound(struct_obj%term, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! cartesian_map_term1_struct
  ! cartesian_map_term1_struct%coef: 0D_NOT_real

  subroutine cartesian_map_term1_struct_get_coef(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_coef')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%coef
  end subroutine

  ! cartesian_map_term1_struct%kx: 0D_NOT_real

  subroutine cartesian_map_term1_struct_get_kx(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_kx')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%kx
  end subroutine

  ! cartesian_map_term1_struct%ky: 0D_NOT_real

  subroutine cartesian_map_term1_struct_get_ky(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_ky')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ky
  end subroutine

  ! cartesian_map_term1_struct%kz: 0D_NOT_real

  subroutine cartesian_map_term1_struct_get_kz(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_kz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%kz
  end subroutine

  ! cartesian_map_term1_struct%x0: 0D_NOT_real

  subroutine cartesian_map_term1_struct_get_x0(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_x0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine

  ! cartesian_map_term1_struct%y0: 0D_NOT_real

  subroutine cartesian_map_term1_struct_get_y0(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_y0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine

  ! cartesian_map_term1_struct%phi_z: 0D_NOT_real

  subroutine cartesian_map_term1_struct_get_phi_z(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_phi_z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi_z
  end subroutine

  ! cartesian_map_term1_struct%family: 0D_NOT_integer

  subroutine cartesian_map_term1_struct_get_family(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_family')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%family
  end subroutine

  ! cartesian_map_term1_struct%form: 0D_NOT_integer

  subroutine cartesian_map_term1_struct_get_form(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term1_struct_get_form')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%form
  end subroutine

  !! cartesian_map_term_struct
  ! cartesian_map_term_struct%file: 0D_NOT_character

  subroutine cartesian_map_term_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='cartesian_map_term_struct_get_file_info')
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

  ! cartesian_map_term_struct%n_link: 0D_NOT_integer

  subroutine cartesian_map_term_struct_get_n_link(struct_obj_ptr, value_out) bind(c, name='cartesian_map_term_struct_get_n_link')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_link
  end subroutine

  ! cartesian_map_term_struct%term: 1D_ALLOC_type

  subroutine cartesian_map_term_struct_get_term_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='cartesian_map_term_struct_get_term_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(cartesian_map_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%term)) then
      data_ptr = c_loc(struct_obj%term(lbound(struct_obj%term, 1)))
      lower_bound = int(lbound(struct_obj%term, 1), c_int)
      upper_bound = int(ubound(struct_obj%term, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%term(lbound(struct_obj%term, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! cartesian_map_struct
  ! cartesian_map_struct%field_scale: 0D_NOT_real

  subroutine cartesian_map_struct_get_field_scale(struct_obj_ptr, value_out) bind(c, name='cartesian_map_struct_get_field_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_scale
  end subroutine

  ! cartesian_map_struct%r0: 1D_NOT_real

  subroutine cartesian_map_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='cartesian_map_struct_get_r0_info')
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

  ! cartesian_map_struct%master_parameter: 0D_NOT_integer

  subroutine cartesian_map_struct_get_master_parameter(struct_obj_ptr, value_out) bind(c, name='cartesian_map_struct_get_master_parameter')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%master_parameter
  end subroutine

  ! cartesian_map_struct%ele_anchor_pt: 0D_NOT_integer

  subroutine cartesian_map_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c, name='cartesian_map_struct_get_ele_anchor_pt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine

  ! cartesian_map_struct%field_type: 0D_NOT_integer

  subroutine cartesian_map_struct_get_field_type(struct_obj_ptr, value_out) bind(c, name='cartesian_map_struct_get_field_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cartesian_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_type
  end subroutine

  ! cartesian_map_struct%ptr: 0D_PTR_type

  subroutine cartesian_map_struct_get_ptr(struct_obj_ptr, ptr_out) bind(c, name='cartesian_map_struct_get_ptr')
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

  !! cylindrical_map_term1_struct
  ! cylindrical_map_term1_struct%e_coef: 0D_NOT_complex

  subroutine cylindrical_map_term1_struct_get_e_coef(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_term1_struct_get_e_coef')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(cylindrical_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%e_coef
  end subroutine

  ! cylindrical_map_term1_struct%b_coef: 0D_NOT_complex

  subroutine cylindrical_map_term1_struct_get_b_coef(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_term1_struct_get_b_coef')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(cylindrical_map_term1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_coef
  end subroutine

  !! cylindrical_map_term_struct
  ! cylindrical_map_term_struct%file: 0D_NOT_character

  subroutine cylindrical_map_term_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='cylindrical_map_term_struct_get_file_info')
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

  ! cylindrical_map_term_struct%n_link: 0D_NOT_integer

  subroutine cylindrical_map_term_struct_get_n_link(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_term_struct_get_n_link')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_link
  end subroutine

  ! cylindrical_map_term_struct%term: 1D_ALLOC_type

  subroutine cylindrical_map_term_struct_get_term_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='cylindrical_map_term_struct_get_term_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(cylindrical_map_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%term)) then
      data_ptr = c_loc(struct_obj%term(lbound(struct_obj%term, 1)))
      lower_bound = int(lbound(struct_obj%term, 1), c_int)
      upper_bound = int(ubound(struct_obj%term, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%term(lbound(struct_obj%term, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! cylindrical_map_struct
  ! cylindrical_map_struct%m: 0D_NOT_integer

  subroutine cylindrical_map_struct_get_m(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_struct_get_m')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%m
  end subroutine

  ! cylindrical_map_struct%harmonic: 0D_NOT_integer

  subroutine cylindrical_map_struct_get_harmonic(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_struct_get_harmonic')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%harmonic
  end subroutine

  ! cylindrical_map_struct%phi0_fieldmap: 0D_NOT_real

  subroutine cylindrical_map_struct_get_phi0_fieldmap(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_struct_get_phi0_fieldmap')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi0_fieldmap
  end subroutine

  ! cylindrical_map_struct%theta0_azimuth: 0D_NOT_real

  subroutine cylindrical_map_struct_get_theta0_azimuth(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_struct_get_theta0_azimuth')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%theta0_azimuth
  end subroutine

  ! cylindrical_map_struct%field_scale: 0D_NOT_real

  subroutine cylindrical_map_struct_get_field_scale(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_struct_get_field_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_scale
  end subroutine

  ! cylindrical_map_struct%master_parameter: 0D_NOT_integer

  subroutine cylindrical_map_struct_get_master_parameter(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_struct_get_master_parameter')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%master_parameter
  end subroutine

  ! cylindrical_map_struct%ele_anchor_pt: 0D_NOT_integer

  subroutine cylindrical_map_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_struct_get_ele_anchor_pt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine

  ! cylindrical_map_struct%dz: 0D_NOT_real

  subroutine cylindrical_map_struct_get_dz(struct_obj_ptr, value_out) bind(c, name='cylindrical_map_struct_get_dz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(cylindrical_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz
  end subroutine

  ! cylindrical_map_struct%r0: 1D_NOT_real

  subroutine cylindrical_map_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='cylindrical_map_struct_get_r0_info')
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

  ! cylindrical_map_struct%ptr: 0D_PTR_type

  subroutine cylindrical_map_struct_get_ptr(struct_obj_ptr, ptr_out) bind(c, name='cylindrical_map_struct_get_ptr')
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

  !! bicubic_cmplx_coef_struct
  ! skipped bicubic_cmplx_coef_struct%coef: Unsupported type: 2D_NOT_complex
  ! bicubic_cmplx_coef_struct%i_box: 1D_NOT_integer

  subroutine bicubic_cmplx_coef_struct_get_i_box_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='bicubic_cmplx_coef_struct_get_i_box_info')
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

  !! tricubic_cmplx_coef_struct
  ! skipped tricubic_cmplx_coef_struct%coef: Unsupported type: 3D_NOT_complex
  ! tricubic_cmplx_coef_struct%i_box: 1D_NOT_integer

  subroutine tricubic_cmplx_coef_struct_get_i_box_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tricubic_cmplx_coef_struct_get_i_box_info')
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

  !! grid_field_pt1_struct
  ! grid_field_pt1_struct%E: 1D_NOT_complex

  subroutine grid_field_pt1_struct_get_E_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='grid_field_pt1_struct_get_E_info')
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

  ! grid_field_pt1_struct%B: 1D_NOT_complex

  subroutine grid_field_pt1_struct_get_B_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='grid_field_pt1_struct_get_B_info')
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

  !! grid_field_pt_struct
  ! grid_field_pt_struct%file: 0D_NOT_character

  subroutine grid_field_pt_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='grid_field_pt_struct_get_file_info')
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

  ! grid_field_pt_struct%n_link: 0D_NOT_integer

  subroutine grid_field_pt_struct_get_n_link(struct_obj_ptr, value_out) bind(c, name='grid_field_pt_struct_get_n_link')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_link
  end subroutine

  ! skipped grid_field_pt_struct%pt: Unsupported type: 3D_ALLOC_type
  !! grid_field_struct
  ! grid_field_struct%geometry: 0D_NOT_integer

  subroutine grid_field_struct_get_geometry(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_geometry')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%geometry
  end subroutine

  ! grid_field_struct%harmonic: 0D_NOT_integer

  subroutine grid_field_struct_get_harmonic(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_harmonic')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%harmonic
  end subroutine

  ! grid_field_struct%phi0_fieldmap: 0D_NOT_real

  subroutine grid_field_struct_get_phi0_fieldmap(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_phi0_fieldmap')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi0_fieldmap
  end subroutine

  ! grid_field_struct%field_scale: 0D_NOT_real

  subroutine grid_field_struct_get_field_scale(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_field_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_scale
  end subroutine

  ! grid_field_struct%field_type: 0D_NOT_integer

  subroutine grid_field_struct_get_field_type(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_field_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_type
  end subroutine

  ! grid_field_struct%master_parameter: 0D_NOT_integer

  subroutine grid_field_struct_get_master_parameter(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_master_parameter')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%master_parameter
  end subroutine

  ! grid_field_struct%ele_anchor_pt: 0D_NOT_integer

  subroutine grid_field_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_ele_anchor_pt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine

  ! grid_field_struct%interpolation_order: 0D_NOT_integer

  subroutine grid_field_struct_get_interpolation_order(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_interpolation_order')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%interpolation_order
  end subroutine

  ! grid_field_struct%dr: 1D_NOT_real

  subroutine grid_field_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='grid_field_struct_get_dr_info')
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

  ! grid_field_struct%r0: 1D_NOT_real

  subroutine grid_field_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='grid_field_struct_get_r0_info')
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

  ! grid_field_struct%curved_ref_frame: 0D_NOT_logical

  subroutine grid_field_struct_get_curved_ref_frame(struct_obj_ptr, value_out) bind(c, name='grid_field_struct_get_curved_ref_frame')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(grid_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%curved_ref_frame
  end subroutine

  ! grid_field_struct%ptr: 0D_PTR_type

  subroutine grid_field_struct_get_ptr(struct_obj_ptr, ptr_out) bind(c, name='grid_field_struct_get_ptr')
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
  !! floor_position_struct
  ! floor_position_struct%r: 1D_NOT_real

  subroutine floor_position_struct_get_r_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='floor_position_struct_get_r_info')
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
  ! floor_position_struct%theta: 0D_NOT_real

  subroutine floor_position_struct_get_theta(struct_obj_ptr, value_out) bind(c, name='floor_position_struct_get_theta')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(floor_position_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%theta
  end subroutine

  ! floor_position_struct%phi: 0D_NOT_real

  subroutine floor_position_struct_get_phi(struct_obj_ptr, value_out) bind(c, name='floor_position_struct_get_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(floor_position_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine

  ! floor_position_struct%psi: 0D_NOT_real

  subroutine floor_position_struct_get_psi(struct_obj_ptr, value_out) bind(c, name='floor_position_struct_get_psi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(floor_position_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%psi
  end subroutine

  !! high_energy_space_charge_struct
  ! high_energy_space_charge_struct%closed_orb: 0D_NOT_type

  subroutine high_energy_space_charge_struct_get_closed_orb(struct_obj_ptr, ptr_out) bind(c, name='high_energy_space_charge_struct_get_closed_orb')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%closed_orb)
  end subroutine

  ! high_energy_space_charge_struct%kick_const: 0D_NOT_real

  subroutine high_energy_space_charge_struct_get_kick_const(struct_obj_ptr, value_out) bind(c, name='high_energy_space_charge_struct_get_kick_const')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%kick_const
  end subroutine

  ! high_energy_space_charge_struct%sig_x: 0D_NOT_real

  subroutine high_energy_space_charge_struct_get_sig_x(struct_obj_ptr, value_out) bind(c, name='high_energy_space_charge_struct_get_sig_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_x
  end subroutine

  ! high_energy_space_charge_struct%sig_y: 0D_NOT_real

  subroutine high_energy_space_charge_struct_get_sig_y(struct_obj_ptr, value_out) bind(c, name='high_energy_space_charge_struct_get_sig_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_y
  end subroutine

  ! high_energy_space_charge_struct%phi: 0D_NOT_real

  subroutine high_energy_space_charge_struct_get_phi(struct_obj_ptr, value_out) bind(c, name='high_energy_space_charge_struct_get_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine

  ! high_energy_space_charge_struct%sin_phi: 0D_NOT_real

  subroutine high_energy_space_charge_struct_get_sin_phi(struct_obj_ptr, value_out) bind(c, name='high_energy_space_charge_struct_get_sin_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sin_phi
  end subroutine

  ! high_energy_space_charge_struct%cos_phi: 0D_NOT_real

  subroutine high_energy_space_charge_struct_get_cos_phi(struct_obj_ptr, value_out) bind(c, name='high_energy_space_charge_struct_get_cos_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%cos_phi
  end subroutine

  ! high_energy_space_charge_struct%sig_z: 0D_NOT_real

  subroutine high_energy_space_charge_struct_get_sig_z(struct_obj_ptr, value_out) bind(c, name='high_energy_space_charge_struct_get_sig_z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(high_energy_space_charge_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_z
  end subroutine

  !! xy_disp_struct
  ! xy_disp_struct%eta: 0D_NOT_real

  subroutine xy_disp_struct_get_eta(struct_obj_ptr, value_out) bind(c, name='xy_disp_struct_get_eta')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%eta
  end subroutine

  ! xy_disp_struct%etap: 0D_NOT_real

  subroutine xy_disp_struct_get_etap(struct_obj_ptr, value_out) bind(c, name='xy_disp_struct_get_etap')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%etap
  end subroutine

  ! xy_disp_struct%deta_ds: 0D_NOT_real

  subroutine xy_disp_struct_get_deta_ds(struct_obj_ptr, value_out) bind(c, name='xy_disp_struct_get_deta_ds')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%deta_ds
  end subroutine

  ! xy_disp_struct%sigma: 0D_NOT_real

  subroutine xy_disp_struct_get_sigma(struct_obj_ptr, value_out) bind(c, name='xy_disp_struct_get_sigma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma
  end subroutine

  ! xy_disp_struct%deta_dpz: 0D_NOT_real

  subroutine xy_disp_struct_get_deta_dpz(struct_obj_ptr, value_out) bind(c, name='xy_disp_struct_get_deta_dpz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%deta_dpz
  end subroutine

  ! xy_disp_struct%detap_dpz: 0D_NOT_real

  subroutine xy_disp_struct_get_detap_dpz(struct_obj_ptr, value_out) bind(c, name='xy_disp_struct_get_detap_dpz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(xy_disp_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%detap_dpz
  end subroutine

  !! twiss_struct
  ! twiss_struct%beta: 0D_NOT_real

  subroutine twiss_struct_get_beta(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_beta')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%beta
  end subroutine

  ! twiss_struct%alpha: 0D_NOT_real

  subroutine twiss_struct_get_alpha(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_alpha')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%alpha
  end subroutine

  ! twiss_struct%gamma: 0D_NOT_real

  subroutine twiss_struct_get_gamma(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_gamma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%gamma
  end subroutine

  ! twiss_struct%phi: 0D_NOT_real

  subroutine twiss_struct_get_phi(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine

  ! twiss_struct%eta: 0D_NOT_real

  subroutine twiss_struct_get_eta(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_eta')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%eta
  end subroutine

  ! twiss_struct%etap: 0D_NOT_real

  subroutine twiss_struct_get_etap(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_etap')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%etap
  end subroutine

  ! twiss_struct%deta_ds: 0D_NOT_real

  subroutine twiss_struct_get_deta_ds(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_deta_ds')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%deta_ds
  end subroutine

  ! twiss_struct%sigma: 0D_NOT_real

  subroutine twiss_struct_get_sigma(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_sigma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma
  end subroutine

  ! twiss_struct%sigma_p: 0D_NOT_real

  subroutine twiss_struct_get_sigma_p(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_sigma_p')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma_p
  end subroutine

  ! twiss_struct%emit: 0D_NOT_real

  subroutine twiss_struct_get_emit(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emit
  end subroutine

  ! twiss_struct%norm_emit: 0D_NOT_real

  subroutine twiss_struct_get_norm_emit(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_norm_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%norm_emit
  end subroutine

  ! twiss_struct%chrom: 0D_NOT_real

  subroutine twiss_struct_get_chrom(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_chrom')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom
  end subroutine

  ! twiss_struct%dbeta_dpz: 0D_NOT_real

  subroutine twiss_struct_get_dbeta_dpz(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_dbeta_dpz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dbeta_dpz
  end subroutine

  ! twiss_struct%dalpha_dpz: 0D_NOT_real

  subroutine twiss_struct_get_dalpha_dpz(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_dalpha_dpz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dalpha_dpz
  end subroutine

  ! twiss_struct%deta_dpz: 0D_NOT_real

  subroutine twiss_struct_get_deta_dpz(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_deta_dpz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%deta_dpz
  end subroutine

  ! twiss_struct%detap_dpz: 0D_NOT_real

  subroutine twiss_struct_get_detap_dpz(struct_obj_ptr, value_out) bind(c, name='twiss_struct_get_detap_dpz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(twiss_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%detap_dpz
  end subroutine

  !! mode3_struct
  ! skipped mode3_struct%v: Unsupported type: 2D_NOT_real
  ! mode3_struct%a: 0D_NOT_type

  subroutine mode3_struct_get_a(struct_obj_ptr, ptr_out) bind(c, name='mode3_struct_get_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine

  ! mode3_struct%b: 0D_NOT_type

  subroutine mode3_struct_get_b(struct_obj_ptr, ptr_out) bind(c, name='mode3_struct_get_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine

  ! mode3_struct%c: 0D_NOT_type

  subroutine mode3_struct_get_c(struct_obj_ptr, ptr_out) bind(c, name='mode3_struct_get_c')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%c)
  end subroutine

  ! mode3_struct%x: 0D_NOT_type

  subroutine mode3_struct_get_x(struct_obj_ptr, ptr_out) bind(c, name='mode3_struct_get_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%x)
  end subroutine

  ! mode3_struct%y: 0D_NOT_type

  subroutine mode3_struct_get_y(struct_obj_ptr, ptr_out) bind(c, name='mode3_struct_get_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(mode3_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%y)
  end subroutine

  !! bookkeeping_state_struct
  ! bookkeeping_state_struct%attributes: 0D_NOT_integer

  subroutine bookkeeping_state_struct_get_attributes(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_attributes')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%attributes
  end subroutine

  ! bookkeeping_state_struct%control: 0D_NOT_integer

  subroutine bookkeeping_state_struct_get_control(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_control')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%control
  end subroutine

  ! bookkeeping_state_struct%floor_position: 0D_NOT_integer

  subroutine bookkeeping_state_struct_get_floor_position(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_floor_position')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%floor_position
  end subroutine

  ! bookkeeping_state_struct%s_position: 0D_NOT_integer

  subroutine bookkeeping_state_struct_get_s_position(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_s_position')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_position
  end subroutine

  ! bookkeeping_state_struct%ref_energy: 0D_NOT_integer

  subroutine bookkeeping_state_struct_get_ref_energy(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_ref_energy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref_energy
  end subroutine

  ! bookkeeping_state_struct%mat6: 0D_NOT_integer

  subroutine bookkeeping_state_struct_get_mat6(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_mat6')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%mat6
  end subroutine

  ! bookkeeping_state_struct%rad_int: 0D_NOT_integer

  subroutine bookkeeping_state_struct_get_rad_int(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_rad_int')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rad_int
  end subroutine

  ! bookkeeping_state_struct%ptc: 0D_NOT_integer

  subroutine bookkeeping_state_struct_get_ptc(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_ptc')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ptc
  end subroutine

  ! bookkeeping_state_struct%has_misalign: 0D_NOT_logical

  subroutine bookkeeping_state_struct_get_has_misalign(struct_obj_ptr, value_out) bind(c, name='bookkeeping_state_struct_get_has_misalign')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bookkeeping_state_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%has_misalign
  end subroutine

  !! rad_map_struct
  ! rad_map_struct%ref_orb: 1D_NOT_real

  subroutine rad_map_struct_get_ref_orb_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='rad_map_struct_get_ref_orb_info')
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
  ! rad_map_struct%xfer_damp_vec: 1D_NOT_real

  subroutine rad_map_struct_get_xfer_damp_vec_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='rad_map_struct_get_xfer_damp_vec_info')
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
  !! rad_map_ele_struct
  ! rad_map_ele_struct%rm0: 0D_NOT_type

  subroutine rad_map_ele_struct_get_rm0(struct_obj_ptr, ptr_out) bind(c, name='rad_map_ele_struct_get_rm0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(rad_map_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%rm0)
  end subroutine

  ! rad_map_ele_struct%rm1: 0D_NOT_type

  subroutine rad_map_ele_struct_get_rm1(struct_obj_ptr, ptr_out) bind(c, name='rad_map_ele_struct_get_rm1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(rad_map_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%rm1)
  end subroutine

  ! rad_map_ele_struct%stale: 0D_NOT_logical

  subroutine rad_map_ele_struct_get_stale(struct_obj_ptr, value_out) bind(c, name='rad_map_ele_struct_get_stale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(rad_map_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%stale
  end subroutine

  !! gen_grad1_struct
  ! gen_grad1_struct%m: 0D_NOT_integer

  subroutine gen_grad1_struct_get_m(struct_obj_ptr, value_out) bind(c, name='gen_grad1_struct_get_m')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%m
  end subroutine

  ! gen_grad1_struct%sincos: 0D_NOT_integer

  subroutine gen_grad1_struct_get_sincos(struct_obj_ptr, value_out) bind(c, name='gen_grad1_struct_get_sincos')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sincos
  end subroutine

  ! gen_grad1_struct%n_deriv_max: 0D_NOT_integer

  subroutine gen_grad1_struct_get_n_deriv_max(struct_obj_ptr, value_out) bind(c, name='gen_grad1_struct_get_n_deriv_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_deriv_max
  end subroutine

  ! gen_grad1_struct%deriv: 2D_ALLOC_real

  subroutine gen_grad1_struct_get_deriv_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c, name='gen_grad1_struct_get_deriv_info')
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

  !! gen_grad_map_struct
  ! gen_grad_map_struct%file: 0D_NOT_character

  subroutine gen_grad_map_struct_get_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='gen_grad_map_struct_get_file_info')
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

  ! gen_grad_map_struct%gg: 1D_ALLOC_type

  subroutine gen_grad_map_struct_get_gg_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='gen_grad_map_struct_get_gg_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%gg)) then
      data_ptr = c_loc(struct_obj%gg(lbound(struct_obj%gg, 1)))
      lower_bound = int(lbound(struct_obj%gg, 1), c_int)
      upper_bound = int(ubound(struct_obj%gg, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%gg(lbound(struct_obj%gg, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! gen_grad_map_struct%ele_anchor_pt: 0D_NOT_integer

  subroutine gen_grad_map_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c, name='gen_grad_map_struct_get_ele_anchor_pt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine

  ! gen_grad_map_struct%field_type: 0D_NOT_integer

  subroutine gen_grad_map_struct_get_field_type(struct_obj_ptr, value_out) bind(c, name='gen_grad_map_struct_get_field_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_type
  end subroutine

  ! gen_grad_map_struct%iz0: 0D_NOT_integer

  subroutine gen_grad_map_struct_get_iz0(struct_obj_ptr, value_out) bind(c, name='gen_grad_map_struct_get_iz0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%iz0
  end subroutine

  ! gen_grad_map_struct%iz1: 0D_NOT_integer

  subroutine gen_grad_map_struct_get_iz1(struct_obj_ptr, value_out) bind(c, name='gen_grad_map_struct_get_iz1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%iz1
  end subroutine

  ! gen_grad_map_struct%dz: 0D_NOT_real

  subroutine gen_grad_map_struct_get_dz(struct_obj_ptr, value_out) bind(c, name='gen_grad_map_struct_get_dz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz
  end subroutine

  ! gen_grad_map_struct%r0: 1D_NOT_real

  subroutine gen_grad_map_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='gen_grad_map_struct_get_r0_info')
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

  ! gen_grad_map_struct%field_scale: 0D_NOT_real

  subroutine gen_grad_map_struct_get_field_scale(struct_obj_ptr, value_out) bind(c, name='gen_grad_map_struct_get_field_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_scale
  end subroutine

  ! gen_grad_map_struct%master_parameter: 0D_NOT_integer

  subroutine gen_grad_map_struct_get_master_parameter(struct_obj_ptr, value_out) bind(c, name='gen_grad_map_struct_get_master_parameter')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%master_parameter
  end subroutine

  ! gen_grad_map_struct%curved_ref_frame: 0D_NOT_logical

  subroutine gen_grad_map_struct_get_curved_ref_frame(struct_obj_ptr, value_out) bind(c, name='gen_grad_map_struct_get_curved_ref_frame')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(gen_grad_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%curved_ref_frame
  end subroutine

  !! surface_segmented_pt_struct
  ! surface_segmented_pt_struct%x0: 0D_NOT_real

  subroutine surface_segmented_pt_struct_get_x0(struct_obj_ptr, value_out) bind(c, name='surface_segmented_pt_struct_get_x0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine

  ! surface_segmented_pt_struct%y0: 0D_NOT_real

  subroutine surface_segmented_pt_struct_get_y0(struct_obj_ptr, value_out) bind(c, name='surface_segmented_pt_struct_get_y0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine

  ! surface_segmented_pt_struct%z0: 0D_NOT_real

  subroutine surface_segmented_pt_struct_get_z0(struct_obj_ptr, value_out) bind(c, name='surface_segmented_pt_struct_get_z0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z0
  end subroutine

  ! surface_segmented_pt_struct%dz_dx: 0D_NOT_real

  subroutine surface_segmented_pt_struct_get_dz_dx(struct_obj_ptr, value_out) bind(c, name='surface_segmented_pt_struct_get_dz_dx')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz_dx
  end subroutine

  ! surface_segmented_pt_struct%dz_dy: 0D_NOT_real

  subroutine surface_segmented_pt_struct_get_dz_dy(struct_obj_ptr, value_out) bind(c, name='surface_segmented_pt_struct_get_dz_dy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_segmented_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz_dy
  end subroutine

  !! surface_segmented_struct
  ! surface_segmented_struct%active: 0D_NOT_logical

  subroutine surface_segmented_struct_get_active(struct_obj_ptr, value_out) bind(c, name='surface_segmented_struct_get_active')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(surface_segmented_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%active
  end subroutine

  ! surface_segmented_struct%dr: 1D_NOT_real

  subroutine surface_segmented_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='surface_segmented_struct_get_dr_info')
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

  ! surface_segmented_struct%r0: 1D_NOT_real

  subroutine surface_segmented_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='surface_segmented_struct_get_r0_info')
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
  !! surface_h_misalign_pt_struct
  ! surface_h_misalign_pt_struct%x0: 0D_NOT_real

  subroutine surface_h_misalign_pt_struct_get_x0(struct_obj_ptr, value_out) bind(c, name='surface_h_misalign_pt_struct_get_x0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine

  ! surface_h_misalign_pt_struct%y0: 0D_NOT_real

  subroutine surface_h_misalign_pt_struct_get_y0(struct_obj_ptr, value_out) bind(c, name='surface_h_misalign_pt_struct_get_y0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine

  ! surface_h_misalign_pt_struct%rot_y: 0D_NOT_real

  subroutine surface_h_misalign_pt_struct_get_rot_y(struct_obj_ptr, value_out) bind(c, name='surface_h_misalign_pt_struct_get_rot_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rot_y
  end subroutine

  ! surface_h_misalign_pt_struct%rot_t: 0D_NOT_real

  subroutine surface_h_misalign_pt_struct_get_rot_t(struct_obj_ptr, value_out) bind(c, name='surface_h_misalign_pt_struct_get_rot_t')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rot_t
  end subroutine

  ! surface_h_misalign_pt_struct%rot_y_rms: 0D_NOT_real

  subroutine surface_h_misalign_pt_struct_get_rot_y_rms(struct_obj_ptr, value_out) bind(c, name='surface_h_misalign_pt_struct_get_rot_y_rms')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rot_y_rms
  end subroutine

  ! surface_h_misalign_pt_struct%rot_t_rms: 0D_NOT_real

  subroutine surface_h_misalign_pt_struct_get_rot_t_rms(struct_obj_ptr, value_out) bind(c, name='surface_h_misalign_pt_struct_get_rot_t_rms')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_h_misalign_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rot_t_rms
  end subroutine

  !! surface_h_misalign_struct
  ! surface_h_misalign_struct%active: 0D_NOT_logical

  subroutine surface_h_misalign_struct_get_active(struct_obj_ptr, value_out) bind(c, name='surface_h_misalign_struct_get_active')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(surface_h_misalign_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%active
  end subroutine

  ! surface_h_misalign_struct%dr: 1D_NOT_real

  subroutine surface_h_misalign_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='surface_h_misalign_struct_get_dr_info')
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

  ! surface_h_misalign_struct%r0: 1D_NOT_real

  subroutine surface_h_misalign_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='surface_h_misalign_struct_get_r0_info')
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
  !! surface_displacement_pt_struct
  ! surface_displacement_pt_struct%x0: 0D_NOT_real

  subroutine surface_displacement_pt_struct_get_x0(struct_obj_ptr, value_out) bind(c, name='surface_displacement_pt_struct_get_x0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine

  ! surface_displacement_pt_struct%y0: 0D_NOT_real

  subroutine surface_displacement_pt_struct_get_y0(struct_obj_ptr, value_out) bind(c, name='surface_displacement_pt_struct_get_y0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine

  ! surface_displacement_pt_struct%z0: 0D_NOT_real

  subroutine surface_displacement_pt_struct_get_z0(struct_obj_ptr, value_out) bind(c, name='surface_displacement_pt_struct_get_z0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z0
  end subroutine

  ! surface_displacement_pt_struct%dz_dx: 0D_NOT_real

  subroutine surface_displacement_pt_struct_get_dz_dx(struct_obj_ptr, value_out) bind(c, name='surface_displacement_pt_struct_get_dz_dx')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz_dx
  end subroutine

  ! surface_displacement_pt_struct%dz_dy: 0D_NOT_real

  subroutine surface_displacement_pt_struct_get_dz_dy(struct_obj_ptr, value_out) bind(c, name='surface_displacement_pt_struct_get_dz_dy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dz_dy
  end subroutine

  ! surface_displacement_pt_struct%d2z_dxdy: 0D_NOT_real

  subroutine surface_displacement_pt_struct_get_d2z_dxdy(struct_obj_ptr, value_out) bind(c, name='surface_displacement_pt_struct_get_d2z_dxdy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_displacement_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%d2z_dxdy
  end subroutine

  !! surface_displacement_struct
  ! surface_displacement_struct%active: 0D_NOT_logical

  subroutine surface_displacement_struct_get_active(struct_obj_ptr, value_out) bind(c, name='surface_displacement_struct_get_active')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(surface_displacement_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%active
  end subroutine

  ! surface_displacement_struct%dr: 1D_NOT_real

  subroutine surface_displacement_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='surface_displacement_struct_get_dr_info')
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

  ! surface_displacement_struct%r0: 1D_NOT_real

  subroutine surface_displacement_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='surface_displacement_struct_get_r0_info')
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
  !! target_point_struct
  ! target_point_struct%r: 1D_NOT_real

  subroutine target_point_struct_get_r_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='target_point_struct_get_r_info')
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

  !! surface_curvature_struct
  ! skipped surface_curvature_struct%xy: Unsupported type: 2D_NOT_real
  ! surface_curvature_struct%spherical: 0D_NOT_real

  subroutine surface_curvature_struct_get_spherical(struct_obj_ptr, value_out) bind(c, name='surface_curvature_struct_get_spherical')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(surface_curvature_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spherical
  end subroutine

  ! surface_curvature_struct%elliptical: 1D_NOT_real

  subroutine surface_curvature_struct_get_elliptical_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='surface_curvature_struct_get_elliptical_info')
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

  ! surface_curvature_struct%has_curvature: 0D_NOT_logical

  subroutine surface_curvature_struct_get_has_curvature(struct_obj_ptr, value_out) bind(c, name='surface_curvature_struct_get_has_curvature')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(surface_curvature_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%has_curvature
  end subroutine

  !! photon_target_struct
  ! photon_target_struct%type: 0D_NOT_integer

  subroutine photon_target_struct_get_type(struct_obj_ptr, value_out) bind(c, name='photon_target_struct_get_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine

  ! photon_target_struct%n_corner: 0D_NOT_integer

  subroutine photon_target_struct_get_n_corner(struct_obj_ptr, value_out) bind(c, name='photon_target_struct_get_n_corner')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_corner
  end subroutine

  ! photon_target_struct%ele_loc: 0D_NOT_type

  subroutine photon_target_struct_get_ele_loc(struct_obj_ptr, ptr_out) bind(c, name='photon_target_struct_get_ele_loc')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ele_loc)
  end subroutine

  ! photon_target_struct%corner: 1D_NOT_type

  subroutine photon_target_struct_get_corner_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='photon_target_struct_get_corner_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%corner(lbound(struct_obj%corner, 1)))
    lower_bound = int(lbound(struct_obj%corner, 1), c_int)
    upper_bound = int(ubound(struct_obj%corner, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%corner(lbound(struct_obj%corner, 1))) / 8, c_size_t)
  end subroutine

  ! photon_target_struct%center: 0D_NOT_type

  subroutine photon_target_struct_get_center(struct_obj_ptr, ptr_out) bind(c, name='photon_target_struct_get_center')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_target_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%center)
  end subroutine

  !! photon_material_struct
  ! photon_material_struct%f0_m1: 0D_NOT_complex

  subroutine photon_material_struct_get_f0_m1(struct_obj_ptr, value_out) bind(c, name='photon_material_struct_get_f0_m1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f0_m1
  end subroutine

  ! photon_material_struct%f0_m2: 0D_NOT_complex

  subroutine photon_material_struct_get_f0_m2(struct_obj_ptr, value_out) bind(c, name='photon_material_struct_get_f0_m2')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f0_m2
  end subroutine

  ! photon_material_struct%f_0: 0D_NOT_complex

  subroutine photon_material_struct_get_f_0(struct_obj_ptr, value_out) bind(c, name='photon_material_struct_get_f_0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f_0
  end subroutine

  ! photon_material_struct%f_h: 0D_NOT_complex

  subroutine photon_material_struct_get_f_h(struct_obj_ptr, value_out) bind(c, name='photon_material_struct_get_f_h')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f_h
  end subroutine

  ! photon_material_struct%f_hbar: 0D_NOT_complex

  subroutine photon_material_struct_get_f_hbar(struct_obj_ptr, value_out) bind(c, name='photon_material_struct_get_f_hbar')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f_hbar
  end subroutine

  ! photon_material_struct%f_hkl: 0D_NOT_complex

  subroutine photon_material_struct_get_f_hkl(struct_obj_ptr, value_out) bind(c, name='photon_material_struct_get_f_hkl')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(photon_material_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%f_hkl
  end subroutine

  ! photon_material_struct%h_norm: 1D_NOT_real

  subroutine photon_material_struct_get_h_norm_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='photon_material_struct_get_h_norm_info')
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

  ! photon_material_struct%l_ref: 1D_NOT_real

  subroutine photon_material_struct_get_l_ref_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='photon_material_struct_get_l_ref_info')
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

  !! pixel_pt_struct
  ! pixel_pt_struct%n_photon: 0D_NOT_integer8

  subroutine pixel_pt_struct_get_n_photon(struct_obj_ptr, value_out) bind(c, name='pixel_pt_struct_get_n_photon')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_photon
  end subroutine

  ! pixel_pt_struct%E_x: 0D_NOT_complex

  subroutine pixel_pt_struct_get_E_x(struct_obj_ptr, value_out) bind(c, name='pixel_pt_struct_get_E_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_x
  end subroutine

  ! pixel_pt_struct%E_y: 0D_NOT_complex

  subroutine pixel_pt_struct_get_E_y(struct_obj_ptr, value_out) bind(c, name='pixel_pt_struct_get_E_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_y
  end subroutine

  ! pixel_pt_struct%intensity_x: 0D_NOT_real

  subroutine pixel_pt_struct_get_intensity_x(struct_obj_ptr, value_out) bind(c, name='pixel_pt_struct_get_intensity_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%intensity_x
  end subroutine

  ! pixel_pt_struct%intensity_y: 0D_NOT_real

  subroutine pixel_pt_struct_get_intensity_y(struct_obj_ptr, value_out) bind(c, name='pixel_pt_struct_get_intensity_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%intensity_y
  end subroutine

  ! pixel_pt_struct%intensity: 0D_NOT_real

  subroutine pixel_pt_struct_get_intensity(struct_obj_ptr, value_out) bind(c, name='pixel_pt_struct_get_intensity')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(pixel_pt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%intensity
  end subroutine

  ! pixel_pt_struct%orbit: 1D_NOT_real

  subroutine pixel_pt_struct_get_orbit_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='pixel_pt_struct_get_orbit_info')
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

  ! pixel_pt_struct%orbit_rms: 1D_NOT_real

  subroutine pixel_pt_struct_get_orbit_rms_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='pixel_pt_struct_get_orbit_rms_info')
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

  ! pixel_pt_struct%init_orbit: 1D_NOT_real

  subroutine pixel_pt_struct_get_init_orbit_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='pixel_pt_struct_get_init_orbit_info')
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

  ! pixel_pt_struct%init_orbit_rms: 1D_NOT_real

  subroutine pixel_pt_struct_get_init_orbit_rms_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='pixel_pt_struct_get_init_orbit_rms_info')
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

  !! pixel_detec_struct
  ! pixel_detec_struct%dr: 1D_NOT_real

  subroutine pixel_detec_struct_get_dr_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='pixel_detec_struct_get_dr_info')
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

  ! pixel_detec_struct%r0: 1D_NOT_real

  subroutine pixel_detec_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='pixel_detec_struct_get_r0_info')
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

  ! pixel_detec_struct%n_track_tot: 0D_NOT_integer8

  subroutine pixel_detec_struct_get_n_track_tot(struct_obj_ptr, value_out) bind(c, name='pixel_detec_struct_get_n_track_tot')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(pixel_detec_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_track_tot
  end subroutine

  ! pixel_detec_struct%n_hit_detec: 0D_NOT_integer8

  subroutine pixel_detec_struct_get_n_hit_detec(struct_obj_ptr, value_out) bind(c, name='pixel_detec_struct_get_n_hit_detec')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(pixel_detec_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_hit_detec
  end subroutine

  ! pixel_detec_struct%n_hit_pixel: 0D_NOT_integer8

  subroutine pixel_detec_struct_get_n_hit_pixel(struct_obj_ptr, value_out) bind(c, name='pixel_detec_struct_get_n_hit_pixel')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(pixel_detec_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_hit_pixel
  end subroutine

  ! skipped pixel_detec_struct%pt: Unsupported type: 2D_ALLOC_type
  !! photon_element_struct
  ! photon_element_struct%curvature: 0D_NOT_type

  subroutine photon_element_struct_get_curvature(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_curvature')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%curvature)
  end subroutine

  ! photon_element_struct%target: 0D_NOT_type

  subroutine photon_element_struct_get_target(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_target')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%target)
  end subroutine

  ! photon_element_struct%material: 0D_NOT_type

  subroutine photon_element_struct_get_material(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_material')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%material)
  end subroutine

  ! photon_element_struct%segmented: 0D_NOT_type

  subroutine photon_element_struct_get_segmented(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_segmented')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%segmented)
  end subroutine

  ! photon_element_struct%h_misalign: 0D_NOT_type

  subroutine photon_element_struct_get_h_misalign(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_h_misalign')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%h_misalign)
  end subroutine

  ! photon_element_struct%displacement: 0D_NOT_type

  subroutine photon_element_struct_get_displacement(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_displacement')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%displacement)
  end subroutine

  ! photon_element_struct%pixel: 0D_NOT_type

  subroutine photon_element_struct_get_pixel(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_pixel')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%pixel)
  end subroutine

  ! photon_element_struct%reflectivity_table_type: 0D_NOT_integer

  subroutine photon_element_struct_get_reflectivity_table_type(struct_obj_ptr, value_out) bind(c, name='photon_element_struct_get_reflectivity_table_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%reflectivity_table_type
  end subroutine

  ! photon_element_struct%reflectivity_table_sigma: 0D_NOT_type

  subroutine photon_element_struct_get_reflectivity_table_sigma(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_reflectivity_table_sigma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%reflectivity_table_sigma)
  end subroutine

  ! photon_element_struct%reflectivity_table_pi: 0D_NOT_type

  subroutine photon_element_struct_get_reflectivity_table_pi(struct_obj_ptr, ptr_out) bind(c, name='photon_element_struct_get_reflectivity_table_pi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%reflectivity_table_pi)
  end subroutine

  ! photon_element_struct%init_energy_prob: 1D_ALLOC_type

  subroutine photon_element_struct_get_init_energy_prob_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='photon_element_struct_get_init_energy_prob_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(photon_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%init_energy_prob)) then
      data_ptr = c_loc(struct_obj%init_energy_prob(lbound(struct_obj%init_energy_prob, 1)))
      lower_bound = int(lbound(struct_obj%init_energy_prob, 1), c_int)
      upper_bound = int(ubound(struct_obj%init_energy_prob, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%init_energy_prob(lbound(struct_obj%init_energy_prob, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! photon_element_struct%integrated_init_energy_prob: 1D_ALLOC_real

  subroutine photon_element_struct_get_integrated_init_energy_prob_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='photon_element_struct_get_integrated_init_energy_prob_info')
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

  !! wall3d_vertex_struct
  ! wall3d_vertex_struct%x: 0D_NOT_real

  subroutine wall3d_vertex_struct_get_x(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x
  end subroutine

  ! wall3d_vertex_struct%y: 0D_NOT_real

  subroutine wall3d_vertex_struct_get_y(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y
  end subroutine

  ! wall3d_vertex_struct%radius_x: 0D_NOT_real

  subroutine wall3d_vertex_struct_get_radius_x(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_radius_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radius_x
  end subroutine

  ! wall3d_vertex_struct%radius_y: 0D_NOT_real

  subroutine wall3d_vertex_struct_get_radius_y(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_radius_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radius_y
  end subroutine

  ! wall3d_vertex_struct%tilt: 0D_NOT_real

  subroutine wall3d_vertex_struct_get_tilt(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_tilt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tilt
  end subroutine

  ! wall3d_vertex_struct%angle: 0D_NOT_real

  subroutine wall3d_vertex_struct_get_angle(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_angle')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%angle
  end subroutine

  ! wall3d_vertex_struct%x0: 0D_NOT_real

  subroutine wall3d_vertex_struct_get_x0(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_x0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x0
  end subroutine

  ! wall3d_vertex_struct%y0: 0D_NOT_real

  subroutine wall3d_vertex_struct_get_y0(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_y0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y0
  end subroutine

  ! wall3d_vertex_struct%type: 0D_NOT_integer

  subroutine wall3d_vertex_struct_get_type(struct_obj_ptr, value_out) bind(c, name='wall3d_vertex_struct_get_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_vertex_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine

  !! wall3d_section_struct
  ! wall3d_section_struct%name: 0D_NOT_character

  subroutine wall3d_section_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_section_struct_get_name_info')
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

  ! wall3d_section_struct%material: 0D_NOT_character

  subroutine wall3d_section_struct_get_material_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_section_struct_get_material_info')
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

  ! wall3d_section_struct%v: 1D_ALLOC_type

  subroutine wall3d_section_struct_get_v_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='wall3d_section_struct_get_v_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%v)) then
      data_ptr = c_loc(struct_obj%v(lbound(struct_obj%v, 1)))
      lower_bound = int(lbound(struct_obj%v, 1), c_int)
      upper_bound = int(ubound(struct_obj%v, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%v(lbound(struct_obj%v, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! wall3d_section_struct%surface: 0D_PTR_type

  subroutine wall3d_section_struct_get_surface(struct_obj_ptr, ptr_out) bind(c, name='wall3d_section_struct_get_surface')
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

  ! wall3d_section_struct%type: 0D_NOT_integer

  subroutine wall3d_section_struct_get_type(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine

  ! wall3d_section_struct%n_vertex_input: 0D_NOT_integer

  subroutine wall3d_section_struct_get_n_vertex_input(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_n_vertex_input')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_vertex_input
  end subroutine

  ! wall3d_section_struct%ix_ele: 0D_NOT_integer

  subroutine wall3d_section_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! wall3d_section_struct%ix_branch: 0D_NOT_integer

  subroutine wall3d_section_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  ! wall3d_section_struct%vertices_state: 0D_NOT_integer

  subroutine wall3d_section_struct_get_vertices_state(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_vertices_state')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%vertices_state
  end subroutine

  ! wall3d_section_struct%patch_in_region: 0D_NOT_logical

  subroutine wall3d_section_struct_get_patch_in_region(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_patch_in_region')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%patch_in_region
  end subroutine

  ! wall3d_section_struct%thickness: 0D_NOT_real

  subroutine wall3d_section_struct_get_thickness(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_thickness')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%thickness
  end subroutine

  ! wall3d_section_struct%s: 0D_NOT_real

  subroutine wall3d_section_struct_get_s(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_s')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine

  ! wall3d_section_struct%r0: 1D_NOT_real

  subroutine wall3d_section_struct_get_r0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_section_struct_get_r0_info')
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

  ! wall3d_section_struct%dx0_ds: 0D_NOT_real

  subroutine wall3d_section_struct_get_dx0_ds(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_dx0_ds')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dx0_ds
  end subroutine

  ! wall3d_section_struct%dy0_ds: 0D_NOT_real

  subroutine wall3d_section_struct_get_dy0_ds(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_dy0_ds')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dy0_ds
  end subroutine

  ! wall3d_section_struct%x0_coef: 1D_NOT_real

  subroutine wall3d_section_struct_get_x0_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_section_struct_get_x0_coef_info')
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

  ! wall3d_section_struct%y0_coef: 1D_NOT_real

  subroutine wall3d_section_struct_get_y0_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_section_struct_get_y0_coef_info')
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

  ! wall3d_section_struct%dr_ds: 0D_NOT_real

  subroutine wall3d_section_struct_get_dr_ds(struct_obj_ptr, value_out) bind(c, name='wall3d_section_struct_get_dr_ds')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_section_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dr_ds
  end subroutine

  ! wall3d_section_struct%p1_coef: 1D_NOT_real

  subroutine wall3d_section_struct_get_p1_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_section_struct_get_p1_coef_info')
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

  ! wall3d_section_struct%p2_coef: 1D_NOT_real

  subroutine wall3d_section_struct_get_p2_coef_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_section_struct_get_p2_coef_info')
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

  !! wall3d_struct
  ! wall3d_struct%name: 0D_NOT_character

  subroutine wall3d_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_struct_get_name_info')
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

  ! wall3d_struct%type: 0D_NOT_integer

  subroutine wall3d_struct_get_type(struct_obj_ptr, value_out) bind(c, name='wall3d_struct_get_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%type
  end subroutine

  ! wall3d_struct%ix_wall3d: 0D_NOT_integer

  subroutine wall3d_struct_get_ix_wall3d(struct_obj_ptr, value_out) bind(c, name='wall3d_struct_get_ix_wall3d')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_wall3d
  end subroutine

  ! wall3d_struct%n_link: 0D_NOT_integer

  subroutine wall3d_struct_get_n_link(struct_obj_ptr, value_out) bind(c, name='wall3d_struct_get_n_link')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_link
  end subroutine

  ! wall3d_struct%thickness: 0D_NOT_real

  subroutine wall3d_struct_get_thickness(struct_obj_ptr, value_out) bind(c, name='wall3d_struct_get_thickness')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%thickness
  end subroutine

  ! wall3d_struct%clear_material: 0D_NOT_character

  subroutine wall3d_struct_get_clear_material_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_struct_get_clear_material_info')
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

  ! wall3d_struct%opaque_material: 0D_NOT_character

  subroutine wall3d_struct_get_opaque_material_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='wall3d_struct_get_opaque_material_info')
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

  ! wall3d_struct%superimpose: 0D_NOT_logical

  subroutine wall3d_struct_get_superimpose(struct_obj_ptr, value_out) bind(c, name='wall3d_struct_get_superimpose')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%superimpose
  end subroutine

  ! wall3d_struct%ele_anchor_pt: 0D_NOT_integer

  subroutine wall3d_struct_get_ele_anchor_pt(struct_obj_ptr, value_out) bind(c, name='wall3d_struct_get_ele_anchor_pt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ele_anchor_pt
  end subroutine

  ! wall3d_struct%section: 1D_ALLOC_type

  subroutine wall3d_struct_get_section_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='wall3d_struct_get_section_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(wall3d_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%section)) then
      data_ptr = c_loc(struct_obj%section(lbound(struct_obj%section, 1)))
      lower_bound = int(lbound(struct_obj%section, 1), c_int)
      upper_bound = int(ubound(struct_obj%section, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%section(lbound(struct_obj%section, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! ramper_lord_struct
  ! ramper_lord_struct%ix_ele: 0D_NOT_integer

  subroutine ramper_lord_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='ramper_lord_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ramper_lord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! ramper_lord_struct%ix_con: 0D_NOT_integer

  subroutine ramper_lord_struct_get_ix_con(struct_obj_ptr, value_out) bind(c, name='ramper_lord_struct_get_ix_con')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ramper_lord_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_con
  end subroutine

  ! ramper_lord_struct%attrib_ptr: 0D_PTR_real

  subroutine ramper_lord_struct_get_attrib_ptr(struct_obj_ptr, ptr_out) bind(c, name='ramper_lord_struct_get_attrib_ptr')
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

  !! control_struct
  ! control_struct%value: 0D_NOT_real

  subroutine control_struct_get_value(struct_obj_ptr, value_out) bind(c, name='control_struct_get_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%value
  end subroutine

  ! control_struct%y_knot: 1D_ALLOC_real

  subroutine control_struct_get_y_knot_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='control_struct_get_y_knot_info')
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

  ! control_struct%stack: 1D_ALLOC_type

  subroutine control_struct_get_stack_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='control_struct_get_stack_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%stack)) then
      data_ptr = c_loc(struct_obj%stack(lbound(struct_obj%stack, 1)))
      lower_bound = int(lbound(struct_obj%stack, 1), c_int)
      upper_bound = int(ubound(struct_obj%stack, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%stack(lbound(struct_obj%stack, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! control_struct%slave: 0D_NOT_type

  subroutine control_struct_get_slave(struct_obj_ptr, ptr_out) bind(c, name='control_struct_get_slave')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%slave)
  end subroutine

  ! control_struct%lord: 0D_NOT_type

  subroutine control_struct_get_lord(struct_obj_ptr, ptr_out) bind(c, name='control_struct_get_lord')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lord)
  end subroutine

  ! control_struct%slave_name: 0D_NOT_character

  subroutine control_struct_get_slave_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='control_struct_get_slave_name_info')
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

  ! control_struct%attribute: 0D_NOT_character

  subroutine control_struct_get_attribute_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='control_struct_get_attribute_info')
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

  ! control_struct%ix_attrib: 0D_NOT_integer

  subroutine control_struct_get_ix_attrib(struct_obj_ptr, value_out) bind(c, name='control_struct_get_ix_attrib')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(control_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_attrib
  end subroutine

  !! control_var1_struct
  ! control_var1_struct%name: 0D_NOT_character

  subroutine control_var1_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='control_var1_struct_get_name_info')
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

  ! control_var1_struct%value: 0D_NOT_real

  subroutine control_var1_struct_get_value(struct_obj_ptr, value_out) bind(c, name='control_var1_struct_get_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(control_var1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%value
  end subroutine

  ! control_var1_struct%old_value: 0D_NOT_real

  subroutine control_var1_struct_get_old_value(struct_obj_ptr, value_out) bind(c, name='control_var1_struct_get_old_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(control_var1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%old_value
  end subroutine

  !! control_ramp1_struct
  ! control_ramp1_struct%y_knot: 1D_ALLOC_real

  subroutine control_ramp1_struct_get_y_knot_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='control_ramp1_struct_get_y_knot_info')
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

  ! control_ramp1_struct%stack: 1D_ALLOC_type

  subroutine control_ramp1_struct_get_stack_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='control_ramp1_struct_get_stack_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(control_ramp1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%stack)) then
      data_ptr = c_loc(struct_obj%stack(lbound(struct_obj%stack, 1)))
      lower_bound = int(lbound(struct_obj%stack, 1), c_int)
      upper_bound = int(ubound(struct_obj%stack, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%stack(lbound(struct_obj%stack, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! control_ramp1_struct%attribute: 0D_NOT_character

  subroutine control_ramp1_struct_get_attribute_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='control_ramp1_struct_get_attribute_info')
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

  ! control_ramp1_struct%slave_name: 0D_NOT_character

  subroutine control_ramp1_struct_get_slave_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='control_ramp1_struct_get_slave_name_info')
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

  ! control_ramp1_struct%is_controller: 0D_NOT_logical

  subroutine control_ramp1_struct_get_is_controller(struct_obj_ptr, value_out) bind(c, name='control_ramp1_struct_get_is_controller')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(control_ramp1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%is_controller
  end subroutine

  !! controller_struct
  ! controller_struct%var: 1D_ALLOC_type

  subroutine controller_struct_get_var_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='controller_struct_get_var_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(controller_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%var)) then
      data_ptr = c_loc(struct_obj%var(lbound(struct_obj%var, 1)))
      lower_bound = int(lbound(struct_obj%var, 1), c_int)
      upper_bound = int(ubound(struct_obj%var, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%var(lbound(struct_obj%var, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! controller_struct%ramp: 1D_ALLOC_type

  subroutine controller_struct_get_ramp_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='controller_struct_get_ramp_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(controller_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ramp)) then
      data_ptr = c_loc(struct_obj%ramp(lbound(struct_obj%ramp, 1)))
      lower_bound = int(lbound(struct_obj%ramp, 1), c_int)
      upper_bound = int(ubound(struct_obj%ramp, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%ramp(lbound(struct_obj%ramp, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! controller_struct%ramper_lord: 1D_ALLOC_type

  subroutine controller_struct_get_ramper_lord_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='controller_struct_get_ramper_lord_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(controller_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ramper_lord)) then
      data_ptr = c_loc(struct_obj%ramper_lord(lbound(struct_obj%ramper_lord, 1)))
      lower_bound = int(lbound(struct_obj%ramper_lord, 1), c_int)
      upper_bound = int(ubound(struct_obj%ramper_lord, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%ramper_lord(lbound(struct_obj%ramper_lord, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! controller_struct%x_knot: 1D_ALLOC_real

  subroutine controller_struct_get_x_knot_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='controller_struct_get_x_knot_info')
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

  !! ellipse_beam_init_struct
  ! ellipse_beam_init_struct%part_per_ellipse: 0D_NOT_integer

  subroutine ellipse_beam_init_struct_get_part_per_ellipse(struct_obj_ptr, value_out) bind(c, name='ellipse_beam_init_struct_get_part_per_ellipse')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ellipse_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%part_per_ellipse
  end subroutine

  ! ellipse_beam_init_struct%n_ellipse: 0D_NOT_integer

  subroutine ellipse_beam_init_struct_get_n_ellipse(struct_obj_ptr, value_out) bind(c, name='ellipse_beam_init_struct_get_n_ellipse')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ellipse_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ellipse
  end subroutine

  ! ellipse_beam_init_struct%sigma_cutoff: 0D_NOT_real

  subroutine ellipse_beam_init_struct_get_sigma_cutoff(struct_obj_ptr, value_out) bind(c, name='ellipse_beam_init_struct_get_sigma_cutoff')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ellipse_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma_cutoff
  end subroutine

  !! kv_beam_init_struct
  ! kv_beam_init_struct%part_per_phi: 1D_NOT_integer

  subroutine kv_beam_init_struct_get_part_per_phi_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='kv_beam_init_struct_get_part_per_phi_info')
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

  ! kv_beam_init_struct%n_I2: 0D_NOT_integer

  subroutine kv_beam_init_struct_get_n_I2(struct_obj_ptr, value_out) bind(c, name='kv_beam_init_struct_get_n_I2')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(kv_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_I2
  end subroutine

  ! kv_beam_init_struct%A: 0D_NOT_real

  subroutine kv_beam_init_struct_get_A(struct_obj_ptr, value_out) bind(c, name='kv_beam_init_struct_get_A')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(kv_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%A
  end subroutine

  !! grid_beam_init_struct
  ! grid_beam_init_struct%n_x: 0D_NOT_integer

  subroutine grid_beam_init_struct_get_n_x(struct_obj_ptr, value_out) bind(c, name='grid_beam_init_struct_get_n_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_x
  end subroutine

  ! grid_beam_init_struct%n_px: 0D_NOT_integer

  subroutine grid_beam_init_struct_get_n_px(struct_obj_ptr, value_out) bind(c, name='grid_beam_init_struct_get_n_px')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_px
  end subroutine

  ! grid_beam_init_struct%x_min: 0D_NOT_real

  subroutine grid_beam_init_struct_get_x_min(struct_obj_ptr, value_out) bind(c, name='grid_beam_init_struct_get_x_min')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_min
  end subroutine

  ! grid_beam_init_struct%x_max: 0D_NOT_real

  subroutine grid_beam_init_struct_get_x_max(struct_obj_ptr, value_out) bind(c, name='grid_beam_init_struct_get_x_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_max
  end subroutine

  ! grid_beam_init_struct%px_min: 0D_NOT_real

  subroutine grid_beam_init_struct_get_px_min(struct_obj_ptr, value_out) bind(c, name='grid_beam_init_struct_get_px_min')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%px_min
  end subroutine

  ! grid_beam_init_struct%px_max: 0D_NOT_real

  subroutine grid_beam_init_struct_get_px_max(struct_obj_ptr, value_out) bind(c, name='grid_beam_init_struct_get_px_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(grid_beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%px_max
  end subroutine

  !! beam_init_struct
  ! beam_init_struct%position_file: 0D_NOT_character

  subroutine beam_init_struct_get_position_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_position_file_info')
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
  ! beam_init_struct%spin: 1D_NOT_real

  subroutine beam_init_struct_get_spin_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_spin_info')
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

  ! beam_init_struct%ellipse: 1D_NOT_type

  subroutine beam_init_struct_get_ellipse_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='beam_init_struct_get_ellipse_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ellipse(lbound(struct_obj%ellipse, 1)))
    lower_bound = int(lbound(struct_obj%ellipse, 1), c_int)
    upper_bound = int(ubound(struct_obj%ellipse, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%ellipse(lbound(struct_obj%ellipse, 1))) / 8, c_size_t)
  end subroutine

  ! beam_init_struct%KV: 0D_NOT_type

  subroutine beam_init_struct_get_KV(struct_obj_ptr, ptr_out) bind(c, name='beam_init_struct_get_KV')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%KV)
  end subroutine

  ! beam_init_struct%grid: 1D_NOT_type

  subroutine beam_init_struct_get_grid_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='beam_init_struct_get_grid_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%grid(lbound(struct_obj%grid, 1)))
    lower_bound = int(lbound(struct_obj%grid, 1), c_int)
    upper_bound = int(ubound(struct_obj%grid, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%grid(lbound(struct_obj%grid, 1))) / 8, c_size_t)
  end subroutine

  ! beam_init_struct%center_jitter: 1D_NOT_real

  subroutine beam_init_struct_get_center_jitter_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_center_jitter_info')
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

  ! beam_init_struct%emit_jitter: 1D_NOT_real

  subroutine beam_init_struct_get_emit_jitter_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_emit_jitter_info')
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

  ! beam_init_struct%sig_z_jitter: 0D_NOT_real

  subroutine beam_init_struct_get_sig_z_jitter(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_sig_z_jitter')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_z_jitter
  end subroutine

  ! beam_init_struct%sig_pz_jitter: 0D_NOT_real

  subroutine beam_init_struct_get_sig_pz_jitter(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_sig_pz_jitter')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_pz_jitter
  end subroutine

  ! beam_init_struct%n_particle: 0D_NOT_integer

  subroutine beam_init_struct_get_n_particle(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_n_particle')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_particle
  end subroutine

  ! beam_init_struct%renorm_center: 0D_NOT_logical

  subroutine beam_init_struct_get_renorm_center(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_renorm_center')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%renorm_center
  end subroutine

  ! beam_init_struct%renorm_sigma: 0D_NOT_logical

  subroutine beam_init_struct_get_renorm_sigma(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_renorm_sigma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%renorm_sigma
  end subroutine

  ! beam_init_struct%random_engine: 0D_NOT_character

  subroutine beam_init_struct_get_random_engine_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_random_engine_info')
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

  ! beam_init_struct%random_gauss_converter: 0D_NOT_character

  subroutine beam_init_struct_get_random_gauss_converter_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_random_gauss_converter_info')
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

  ! beam_init_struct%random_sigma_cutoff: 0D_NOT_real

  subroutine beam_init_struct_get_random_sigma_cutoff(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_random_sigma_cutoff')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%random_sigma_cutoff
  end subroutine

  ! beam_init_struct%a_norm_emit: 0D_NOT_real

  subroutine beam_init_struct_get_a_norm_emit(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_a_norm_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_norm_emit
  end subroutine

  ! beam_init_struct%b_norm_emit: 0D_NOT_real

  subroutine beam_init_struct_get_b_norm_emit(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_b_norm_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_norm_emit
  end subroutine

  ! beam_init_struct%a_emit: 0D_NOT_real

  subroutine beam_init_struct_get_a_emit(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_a_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_emit
  end subroutine

  ! beam_init_struct%b_emit: 0D_NOT_real

  subroutine beam_init_struct_get_b_emit(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_b_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_emit
  end subroutine

  ! beam_init_struct%dPz_dz: 0D_NOT_real

  subroutine beam_init_struct_get_dPz_dz(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_dPz_dz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dPz_dz
  end subroutine

  ! beam_init_struct%center: 1D_NOT_real

  subroutine beam_init_struct_get_center_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_center_info')
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

  ! beam_init_struct%t_offset: 0D_NOT_real

  subroutine beam_init_struct_get_t_offset(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_t_offset')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t_offset
  end subroutine

  ! beam_init_struct%dt_bunch: 0D_NOT_real

  subroutine beam_init_struct_get_dt_bunch(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_dt_bunch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dt_bunch
  end subroutine

  ! beam_init_struct%sig_z: 0D_NOT_real

  subroutine beam_init_struct_get_sig_z(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_sig_z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_z
  end subroutine

  ! beam_init_struct%sig_pz: 0D_NOT_real

  subroutine beam_init_struct_get_sig_pz(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_sig_pz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_pz
  end subroutine

  ! beam_init_struct%bunch_charge: 0D_NOT_real

  subroutine beam_init_struct_get_bunch_charge(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_bunch_charge')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%bunch_charge
  end subroutine

  ! beam_init_struct%n_bunch: 0D_NOT_integer

  subroutine beam_init_struct_get_n_bunch(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_n_bunch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bunch
  end subroutine

  ! beam_init_struct%ix_turn: 0D_NOT_integer

  subroutine beam_init_struct_get_ix_turn(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_ix_turn')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_turn
  end subroutine

  ! beam_init_struct%species: 0D_NOT_character

  subroutine beam_init_struct_get_species_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_species_info')
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

  ! beam_init_struct%full_6D_coupling_calc: 0D_NOT_logical

  subroutine beam_init_struct_get_full_6D_coupling_calc(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_full_6D_coupling_calc')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%full_6D_coupling_calc
  end subroutine

  ! beam_init_struct%use_particle_start: 0D_NOT_logical

  subroutine beam_init_struct_get_use_particle_start(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_use_particle_start')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%use_particle_start
  end subroutine

  ! beam_init_struct%use_t_coords: 0D_NOT_logical

  subroutine beam_init_struct_get_use_t_coords(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_use_t_coords')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%use_t_coords
  end subroutine

  ! beam_init_struct%use_z_as_t: 0D_NOT_logical

  subroutine beam_init_struct_get_use_z_as_t(struct_obj_ptr, value_out) bind(c, name='beam_init_struct_get_use_z_as_t')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(beam_init_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%use_z_as_t
  end subroutine

  ! beam_init_struct%file_name: 0D_NOT_character

  subroutine beam_init_struct_get_file_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='beam_init_struct_get_file_name_info')
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

  !! lat_param_struct
  ! lat_param_struct%n_part: 0D_NOT_real

  subroutine lat_param_struct_get_n_part(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_n_part')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_part
  end subroutine

  ! lat_param_struct%total_length: 0D_NOT_real

  subroutine lat_param_struct_get_total_length(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_total_length')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%total_length
  end subroutine

  ! lat_param_struct%unstable_factor: 0D_NOT_real

  subroutine lat_param_struct_get_unstable_factor(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_unstable_factor')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%unstable_factor
  end subroutine

  ! skipped lat_param_struct%t1_with_RF: Unsupported type: 2D_NOT_real
  ! skipped lat_param_struct%t1_no_RF: Unsupported type: 2D_NOT_real
  ! lat_param_struct%spin_tune: 0D_NOT_real

  subroutine lat_param_struct_get_spin_tune(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_spin_tune')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_tune
  end subroutine

  ! lat_param_struct%particle: 0D_NOT_integer

  subroutine lat_param_struct_get_particle(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_particle')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%particle
  end subroutine

  ! lat_param_struct%default_tracking_species: 0D_NOT_integer

  subroutine lat_param_struct_get_default_tracking_species(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_default_tracking_species')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%default_tracking_species
  end subroutine

  ! lat_param_struct%geometry: 0D_NOT_integer

  subroutine lat_param_struct_get_geometry(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_geometry')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%geometry
  end subroutine

  ! lat_param_struct%ixx: 0D_NOT_integer

  subroutine lat_param_struct_get_ixx(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_ixx')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ixx
  end subroutine

  ! lat_param_struct%stable: 0D_NOT_logical

  subroutine lat_param_struct_get_stable(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_stable')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%stable
  end subroutine

  ! lat_param_struct%live_branch: 0D_NOT_logical

  subroutine lat_param_struct_get_live_branch(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_live_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%live_branch
  end subroutine

  ! lat_param_struct%g1_integral: 0D_NOT_real

  subroutine lat_param_struct_get_g1_integral(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_g1_integral')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%g1_integral
  end subroutine

  ! lat_param_struct%g2_integral: 0D_NOT_real

  subroutine lat_param_struct_get_g2_integral(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_g2_integral')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%g2_integral
  end subroutine

  ! lat_param_struct%g3_integral: 0D_NOT_real

  subroutine lat_param_struct_get_g3_integral(struct_obj_ptr, value_out) bind(c, name='lat_param_struct_get_g3_integral')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%g3_integral
  end subroutine

  ! lat_param_struct%bookkeeping_state: 0D_NOT_type

  subroutine lat_param_struct_get_bookkeeping_state(struct_obj_ptr, ptr_out) bind(c, name='lat_param_struct_get_bookkeeping_state')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%bookkeeping_state)
  end subroutine

  ! lat_param_struct%beam_init: 0D_NOT_type

  subroutine lat_param_struct_get_beam_init(struct_obj_ptr, ptr_out) bind(c, name='lat_param_struct_get_beam_init')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam_init)
  end subroutine

  !! mode_info_struct
  ! mode_info_struct%stable: 0D_NOT_logical

  subroutine mode_info_struct_get_stable(struct_obj_ptr, value_out) bind(c, name='mode_info_struct_get_stable')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%stable
  end subroutine

  ! mode_info_struct%tune: 0D_NOT_real

  subroutine mode_info_struct_get_tune(struct_obj_ptr, value_out) bind(c, name='mode_info_struct_get_tune')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tune
  end subroutine

  ! mode_info_struct%emit: 0D_NOT_real

  subroutine mode_info_struct_get_emit(struct_obj_ptr, value_out) bind(c, name='mode_info_struct_get_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emit
  end subroutine

  ! mode_info_struct%chrom: 0D_NOT_real

  subroutine mode_info_struct_get_chrom(struct_obj_ptr, value_out) bind(c, name='mode_info_struct_get_chrom')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom
  end subroutine

  ! mode_info_struct%sigma: 0D_NOT_real

  subroutine mode_info_struct_get_sigma(struct_obj_ptr, value_out) bind(c, name='mode_info_struct_get_sigma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma
  end subroutine

  ! mode_info_struct%sigmap: 0D_NOT_real

  subroutine mode_info_struct_get_sigmap(struct_obj_ptr, value_out) bind(c, name='mode_info_struct_get_sigmap')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(mode_info_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigmap
  end subroutine

  !! pre_tracker_struct
  ! pre_tracker_struct%who: 0D_NOT_integer

  subroutine pre_tracker_struct_get_who(struct_obj_ptr, value_out) bind(c, name='pre_tracker_struct_get_who')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(pre_tracker_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%who
  end subroutine

  ! pre_tracker_struct%ix_ele_start: 0D_NOT_integer

  subroutine pre_tracker_struct_get_ix_ele_start(struct_obj_ptr, value_out) bind(c, name='pre_tracker_struct_get_ix_ele_start')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(pre_tracker_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele_start
  end subroutine

  ! pre_tracker_struct%ix_ele_end: 0D_NOT_integer

  subroutine pre_tracker_struct_get_ix_ele_end(struct_obj_ptr, value_out) bind(c, name='pre_tracker_struct_get_ix_ele_end')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(pre_tracker_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele_end
  end subroutine

  ! pre_tracker_struct%input_file: 0D_NOT_character

  subroutine pre_tracker_struct_get_input_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='pre_tracker_struct_get_input_file_info')
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

  !! anormal_mode_struct
  ! anormal_mode_struct%emittance: 0D_NOT_real

  subroutine anormal_mode_struct_get_emittance(struct_obj_ptr, value_out) bind(c, name='anormal_mode_struct_get_emittance')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emittance
  end subroutine

  ! anormal_mode_struct%emittance_no_vert: 0D_NOT_real

  subroutine anormal_mode_struct_get_emittance_no_vert(struct_obj_ptr, value_out) bind(c, name='anormal_mode_struct_get_emittance_no_vert')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emittance_no_vert
  end subroutine

  ! anormal_mode_struct%synch_int: 1D_NOT_real

  subroutine anormal_mode_struct_get_synch_int_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='anormal_mode_struct_get_synch_int_info')
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

  ! anormal_mode_struct%j_damp: 0D_NOT_real

  subroutine anormal_mode_struct_get_j_damp(struct_obj_ptr, value_out) bind(c, name='anormal_mode_struct_get_j_damp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%j_damp
  end subroutine

  ! anormal_mode_struct%alpha_damp: 0D_NOT_real

  subroutine anormal_mode_struct_get_alpha_damp(struct_obj_ptr, value_out) bind(c, name='anormal_mode_struct_get_alpha_damp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%alpha_damp
  end subroutine

  ! anormal_mode_struct%chrom: 0D_NOT_real

  subroutine anormal_mode_struct_get_chrom(struct_obj_ptr, value_out) bind(c, name='anormal_mode_struct_get_chrom')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom
  end subroutine

  ! anormal_mode_struct%tune: 0D_NOT_real

  subroutine anormal_mode_struct_get_tune(struct_obj_ptr, value_out) bind(c, name='anormal_mode_struct_get_tune')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(anormal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tune
  end subroutine

  !! linac_normal_mode_struct
  ! linac_normal_mode_struct%i2_E4: 0D_NOT_real

  subroutine linac_normal_mode_struct_get_i2_E4(struct_obj_ptr, value_out) bind(c, name='linac_normal_mode_struct_get_i2_E4')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i2_E4
  end subroutine

  ! linac_normal_mode_struct%i3_E7: 0D_NOT_real

  subroutine linac_normal_mode_struct_get_i3_E7(struct_obj_ptr, value_out) bind(c, name='linac_normal_mode_struct_get_i3_E7')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i3_E7
  end subroutine

  ! linac_normal_mode_struct%i5a_E6: 0D_NOT_real

  subroutine linac_normal_mode_struct_get_i5a_E6(struct_obj_ptr, value_out) bind(c, name='linac_normal_mode_struct_get_i5a_E6')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i5a_E6
  end subroutine

  ! linac_normal_mode_struct%i5b_E6: 0D_NOT_real

  subroutine linac_normal_mode_struct_get_i5b_E6(struct_obj_ptr, value_out) bind(c, name='linac_normal_mode_struct_get_i5b_E6')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i5b_E6
  end subroutine

  ! linac_normal_mode_struct%sig_E1: 0D_NOT_real

  subroutine linac_normal_mode_struct_get_sig_E1(struct_obj_ptr, value_out) bind(c, name='linac_normal_mode_struct_get_sig_E1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_E1
  end subroutine

  ! linac_normal_mode_struct%a_emittance_end: 0D_NOT_real

  subroutine linac_normal_mode_struct_get_a_emittance_end(struct_obj_ptr, value_out) bind(c, name='linac_normal_mode_struct_get_a_emittance_end')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_emittance_end
  end subroutine

  ! linac_normal_mode_struct%b_emittance_end: 0D_NOT_real

  subroutine linac_normal_mode_struct_get_b_emittance_end(struct_obj_ptr, value_out) bind(c, name='linac_normal_mode_struct_get_b_emittance_end')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(linac_normal_mode_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_emittance_end
  end subroutine

  !! normal_modes_struct
  ! normal_modes_struct%synch_int: 1D_NOT_real

  subroutine normal_modes_struct_get_synch_int_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='normal_modes_struct_get_synch_int_info')
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

  ! normal_modes_struct%sigE_E: 0D_NOT_real

  subroutine normal_modes_struct_get_sigE_E(struct_obj_ptr, value_out) bind(c, name='normal_modes_struct_get_sigE_E')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigE_E
  end subroutine

  ! normal_modes_struct%sig_z: 0D_NOT_real

  subroutine normal_modes_struct_get_sig_z(struct_obj_ptr, value_out) bind(c, name='normal_modes_struct_get_sig_z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sig_z
  end subroutine

  ! normal_modes_struct%e_loss: 0D_NOT_real

  subroutine normal_modes_struct_get_e_loss(struct_obj_ptr, value_out) bind(c, name='normal_modes_struct_get_e_loss')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%e_loss
  end subroutine

  ! normal_modes_struct%rf_voltage: 0D_NOT_real

  subroutine normal_modes_struct_get_rf_voltage(struct_obj_ptr, value_out) bind(c, name='normal_modes_struct_get_rf_voltage')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rf_voltage
  end subroutine

  ! normal_modes_struct%pz_aperture: 0D_NOT_real

  subroutine normal_modes_struct_get_pz_aperture(struct_obj_ptr, value_out) bind(c, name='normal_modes_struct_get_pz_aperture')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pz_aperture
  end subroutine

  ! normal_modes_struct%pz_average: 0D_NOT_real

  subroutine normal_modes_struct_get_pz_average(struct_obj_ptr, value_out) bind(c, name='normal_modes_struct_get_pz_average')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pz_average
  end subroutine

  ! normal_modes_struct%momentum_compaction: 0D_NOT_real

  subroutine normal_modes_struct_get_momentum_compaction(struct_obj_ptr, value_out) bind(c, name='normal_modes_struct_get_momentum_compaction')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%momentum_compaction
  end subroutine

  ! normal_modes_struct%dpz_damp: 0D_NOT_real

  subroutine normal_modes_struct_get_dpz_damp(struct_obj_ptr, value_out) bind(c, name='normal_modes_struct_get_dpz_damp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dpz_damp
  end subroutine

  ! normal_modes_struct%a: 0D_NOT_type

  subroutine normal_modes_struct_get_a(struct_obj_ptr, ptr_out) bind(c, name='normal_modes_struct_get_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine

  ! normal_modes_struct%b: 0D_NOT_type

  subroutine normal_modes_struct_get_b(struct_obj_ptr, ptr_out) bind(c, name='normal_modes_struct_get_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine

  ! normal_modes_struct%z: 0D_NOT_type

  subroutine normal_modes_struct_get_z(struct_obj_ptr, ptr_out) bind(c, name='normal_modes_struct_get_z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z)
  end subroutine

  ! normal_modes_struct%lin: 0D_NOT_type

  subroutine normal_modes_struct_get_lin(struct_obj_ptr, ptr_out) bind(c, name='normal_modes_struct_get_lin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(normal_modes_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lin)
  end subroutine

  !! em_field_struct
  ! em_field_struct%E: 1D_NOT_real

  subroutine em_field_struct_get_E_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='em_field_struct_get_E_info')
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

  ! em_field_struct%B: 1D_NOT_real

  subroutine em_field_struct_get_B_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='em_field_struct_get_B_info')
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
  ! em_field_struct%phi: 0D_NOT_real

  subroutine em_field_struct_get_phi(struct_obj_ptr, value_out) bind(c, name='em_field_struct_get_phi')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(em_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi
  end subroutine

  ! em_field_struct%phi_B: 0D_NOT_real

  subroutine em_field_struct_get_phi_B(struct_obj_ptr, value_out) bind(c, name='em_field_struct_get_phi_B')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(em_field_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%phi_B
  end subroutine

  ! em_field_struct%A: 1D_NOT_real

  subroutine em_field_struct_get_A_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='em_field_struct_get_A_info')
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

  !! strong_beam_struct
  ! strong_beam_struct%ix_slice: 0D_NOT_integer

  subroutine strong_beam_struct_get_ix_slice(struct_obj_ptr, value_out) bind(c, name='strong_beam_struct_get_ix_slice')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_slice
  end subroutine

  ! strong_beam_struct%x_center: 0D_NOT_real

  subroutine strong_beam_struct_get_x_center(struct_obj_ptr, value_out) bind(c, name='strong_beam_struct_get_x_center')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_center
  end subroutine

  ! strong_beam_struct%y_center: 0D_NOT_real

  subroutine strong_beam_struct_get_y_center(struct_obj_ptr, value_out) bind(c, name='strong_beam_struct_get_y_center')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y_center
  end subroutine

  ! strong_beam_struct%x_sigma: 0D_NOT_real

  subroutine strong_beam_struct_get_x_sigma(struct_obj_ptr, value_out) bind(c, name='strong_beam_struct_get_x_sigma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_sigma
  end subroutine

  ! strong_beam_struct%y_sigma: 0D_NOT_real

  subroutine strong_beam_struct_get_y_sigma(struct_obj_ptr, value_out) bind(c, name='strong_beam_struct_get_y_sigma')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y_sigma
  end subroutine

  ! strong_beam_struct%dx: 0D_NOT_real

  subroutine strong_beam_struct_get_dx(struct_obj_ptr, value_out) bind(c, name='strong_beam_struct_get_dx')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dx
  end subroutine

  ! strong_beam_struct%dy: 0D_NOT_real

  subroutine strong_beam_struct_get_dy(struct_obj_ptr, value_out) bind(c, name='strong_beam_struct_get_dy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(strong_beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dy
  end subroutine

  !! track_point_struct
  ! track_point_struct%s_lab: 0D_NOT_real

  subroutine track_point_struct_get_s_lab(struct_obj_ptr, value_out) bind(c, name='track_point_struct_get_s_lab')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_lab
  end subroutine

  ! track_point_struct%s_body: 0D_NOT_real

  subroutine track_point_struct_get_s_body(struct_obj_ptr, value_out) bind(c, name='track_point_struct_get_s_body')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_body
  end subroutine

  ! track_point_struct%orb: 0D_NOT_type

  subroutine track_point_struct_get_orb(struct_obj_ptr, ptr_out) bind(c, name='track_point_struct_get_orb')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%orb)
  end subroutine

  ! track_point_struct%field: 0D_NOT_type

  subroutine track_point_struct_get_field(struct_obj_ptr, ptr_out) bind(c, name='track_point_struct_get_field')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%field)
  end subroutine

  ! track_point_struct%strong_beam: 0D_NOT_type

  subroutine track_point_struct_get_strong_beam(struct_obj_ptr, ptr_out) bind(c, name='track_point_struct_get_strong_beam')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(track_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%strong_beam)
  end subroutine

  ! track_point_struct%vec0: 1D_NOT_real

  subroutine track_point_struct_get_vec0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='track_point_struct_get_vec0_info')
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
  !! track_struct
  ! track_struct%pt: 1D_ALLOC_type

  subroutine track_struct_get_pt_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='track_struct_get_pt_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%pt)) then
      data_ptr = c_loc(struct_obj%pt(lbound(struct_obj%pt, 1)))
      lower_bound = int(lbound(struct_obj%pt, 1), c_int)
      upper_bound = int(ubound(struct_obj%pt, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%pt(lbound(struct_obj%pt, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! track_struct%ds_save: 0D_NOT_real

  subroutine track_struct_get_ds_save(struct_obj_ptr, value_out) bind(c, name='track_struct_get_ds_save')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ds_save
  end subroutine

  ! track_struct%n_pt: 0D_NOT_integer

  subroutine track_struct_get_n_pt(struct_obj_ptr, value_out) bind(c, name='track_struct_get_n_pt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_pt
  end subroutine

  ! track_struct%n_bad: 0D_NOT_integer

  subroutine track_struct_get_n_bad(struct_obj_ptr, value_out) bind(c, name='track_struct_get_n_bad')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bad
  end subroutine

  ! track_struct%n_ok: 0D_NOT_integer

  subroutine track_struct_get_n_ok(struct_obj_ptr, value_out) bind(c, name='track_struct_get_n_ok')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ok
  end subroutine

  !! space_charge_common_struct
  ! space_charge_common_struct%ds_track_step: 0D_NOT_real

  subroutine space_charge_common_struct_get_ds_track_step(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_ds_track_step')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ds_track_step
  end subroutine

  ! space_charge_common_struct%dt_track_step: 0D_NOT_real

  subroutine space_charge_common_struct_get_dt_track_step(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_dt_track_step')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dt_track_step
  end subroutine

  ! space_charge_common_struct%cathode_strength_cutoff: 0D_NOT_real

  subroutine space_charge_common_struct_get_cathode_strength_cutoff(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_cathode_strength_cutoff')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%cathode_strength_cutoff
  end subroutine

  ! space_charge_common_struct%rel_tol_tracking: 0D_NOT_real

  subroutine space_charge_common_struct_get_rel_tol_tracking(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_rel_tol_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rel_tol_tracking
  end subroutine

  ! space_charge_common_struct%abs_tol_tracking: 0D_NOT_real

  subroutine space_charge_common_struct_get_abs_tol_tracking(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_abs_tol_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%abs_tol_tracking
  end subroutine

  ! space_charge_common_struct%beam_chamber_height: 0D_NOT_real

  subroutine space_charge_common_struct_get_beam_chamber_height(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_beam_chamber_height')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%beam_chamber_height
  end subroutine

  ! space_charge_common_struct%lsc_sigma_cutoff: 0D_NOT_real

  subroutine space_charge_common_struct_get_lsc_sigma_cutoff(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_lsc_sigma_cutoff')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lsc_sigma_cutoff
  end subroutine

  ! space_charge_common_struct%particle_sigma_cutoff: 0D_NOT_real

  subroutine space_charge_common_struct_get_particle_sigma_cutoff(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_particle_sigma_cutoff')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%particle_sigma_cutoff
  end subroutine

  ! space_charge_common_struct%space_charge_mesh_size: 1D_NOT_integer

  subroutine space_charge_common_struct_get_space_charge_mesh_size_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='space_charge_common_struct_get_space_charge_mesh_size_info')
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

  ! space_charge_common_struct%csr3d_mesh_size: 1D_NOT_integer

  subroutine space_charge_common_struct_get_csr3d_mesh_size_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='space_charge_common_struct_get_csr3d_mesh_size_info')
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

  ! space_charge_common_struct%n_bin: 0D_NOT_integer

  subroutine space_charge_common_struct_get_n_bin(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_n_bin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bin
  end subroutine

  ! space_charge_common_struct%particle_bin_span: 0D_NOT_integer

  subroutine space_charge_common_struct_get_particle_bin_span(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_particle_bin_span')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%particle_bin_span
  end subroutine

  ! space_charge_common_struct%n_shield_images: 0D_NOT_integer

  subroutine space_charge_common_struct_get_n_shield_images(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_n_shield_images')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_shield_images
  end subroutine

  ! space_charge_common_struct%sc_min_in_bin: 0D_NOT_integer

  subroutine space_charge_common_struct_get_sc_min_in_bin(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_sc_min_in_bin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sc_min_in_bin
  end subroutine

  ! space_charge_common_struct%lsc_kick_transverse_dependence: 0D_NOT_logical

  subroutine space_charge_common_struct_get_lsc_kick_transverse_dependence(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_lsc_kick_transverse_dependence')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lsc_kick_transverse_dependence
  end subroutine

  ! space_charge_common_struct%debug: 0D_NOT_logical

  subroutine space_charge_common_struct_get_debug(struct_obj_ptr, value_out) bind(c, name='space_charge_common_struct_get_debug')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(space_charge_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%debug
  end subroutine

  ! space_charge_common_struct%diagnostic_output_file: 0D_NOT_character

  subroutine space_charge_common_struct_get_diagnostic_output_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='space_charge_common_struct_get_diagnostic_output_file_info')
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

  !! bmad_common_struct
  ! bmad_common_struct%max_aperture_limit: 0D_NOT_real

  subroutine bmad_common_struct_get_max_aperture_limit(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_max_aperture_limit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%max_aperture_limit
  end subroutine

  ! bmad_common_struct%d_orb: 1D_NOT_real

  subroutine bmad_common_struct_get_d_orb_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='bmad_common_struct_get_d_orb_info')
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

  ! bmad_common_struct%default_ds_step: 0D_NOT_real

  subroutine bmad_common_struct_get_default_ds_step(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_default_ds_step')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%default_ds_step
  end subroutine

  ! bmad_common_struct%significant_length: 0D_NOT_real

  subroutine bmad_common_struct_get_significant_length(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_significant_length')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%significant_length
  end subroutine

  ! bmad_common_struct%rel_tol_tracking: 0D_NOT_real

  subroutine bmad_common_struct_get_rel_tol_tracking(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_rel_tol_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rel_tol_tracking
  end subroutine

  ! bmad_common_struct%abs_tol_tracking: 0D_NOT_real

  subroutine bmad_common_struct_get_abs_tol_tracking(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_abs_tol_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%abs_tol_tracking
  end subroutine

  ! bmad_common_struct%rel_tol_adaptive_tracking: 0D_NOT_real

  subroutine bmad_common_struct_get_rel_tol_adaptive_tracking(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_rel_tol_adaptive_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rel_tol_adaptive_tracking
  end subroutine

  ! bmad_common_struct%abs_tol_adaptive_tracking: 0D_NOT_real

  subroutine bmad_common_struct_get_abs_tol_adaptive_tracking(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_abs_tol_adaptive_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%abs_tol_adaptive_tracking
  end subroutine

  ! bmad_common_struct%init_ds_adaptive_tracking: 0D_NOT_real

  subroutine bmad_common_struct_get_init_ds_adaptive_tracking(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_init_ds_adaptive_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%init_ds_adaptive_tracking
  end subroutine

  ! bmad_common_struct%min_ds_adaptive_tracking: 0D_NOT_real

  subroutine bmad_common_struct_get_min_ds_adaptive_tracking(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_min_ds_adaptive_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%min_ds_adaptive_tracking
  end subroutine

  ! bmad_common_struct%fatal_ds_adaptive_tracking: 0D_NOT_real

  subroutine bmad_common_struct_get_fatal_ds_adaptive_tracking(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_fatal_ds_adaptive_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%fatal_ds_adaptive_tracking
  end subroutine

  ! bmad_common_struct%autoscale_amp_abs_tol: 0D_NOT_real

  subroutine bmad_common_struct_get_autoscale_amp_abs_tol(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_autoscale_amp_abs_tol')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%autoscale_amp_abs_tol
  end subroutine

  ! bmad_common_struct%autoscale_amp_rel_tol: 0D_NOT_real

  subroutine bmad_common_struct_get_autoscale_amp_rel_tol(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_autoscale_amp_rel_tol')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%autoscale_amp_rel_tol
  end subroutine

  ! bmad_common_struct%autoscale_phase_tol: 0D_NOT_real

  subroutine bmad_common_struct_get_autoscale_phase_tol(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_autoscale_phase_tol')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%autoscale_phase_tol
  end subroutine

  ! bmad_common_struct%electric_dipole_moment: 0D_NOT_real

  subroutine bmad_common_struct_get_electric_dipole_moment(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_electric_dipole_moment')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%electric_dipole_moment
  end subroutine

  ! bmad_common_struct%synch_rad_scale: 0D_NOT_real

  subroutine bmad_common_struct_get_synch_rad_scale(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_synch_rad_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%synch_rad_scale
  end subroutine

  ! bmad_common_struct%sad_eps_scale: 0D_NOT_real

  subroutine bmad_common_struct_get_sad_eps_scale(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_sad_eps_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sad_eps_scale
  end subroutine

  ! bmad_common_struct%sad_amp_max: 0D_NOT_real

  subroutine bmad_common_struct_get_sad_amp_max(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_sad_amp_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sad_amp_max
  end subroutine

  ! bmad_common_struct%sad_n_div_max: 0D_NOT_integer

  subroutine bmad_common_struct_get_sad_n_div_max(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_sad_n_div_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sad_n_div_max
  end subroutine

  ! bmad_common_struct%taylor_order: 0D_NOT_integer

  subroutine bmad_common_struct_get_taylor_order(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_taylor_order')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%taylor_order
  end subroutine

  ! bmad_common_struct%runge_kutta_order: 0D_NOT_integer

  subroutine bmad_common_struct_get_runge_kutta_order(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_runge_kutta_order')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%runge_kutta_order
  end subroutine

  ! bmad_common_struct%default_integ_order: 0D_NOT_integer

  subroutine bmad_common_struct_get_default_integ_order(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_default_integ_order')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%default_integ_order
  end subroutine

  ! bmad_common_struct%max_num_runge_kutta_step: 0D_NOT_integer

  subroutine bmad_common_struct_get_max_num_runge_kutta_step(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_max_num_runge_kutta_step')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%max_num_runge_kutta_step
  end subroutine

  ! bmad_common_struct%rf_phase_below_transition_ref: 0D_NOT_logical

  subroutine bmad_common_struct_get_rf_phase_below_transition_ref(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_rf_phase_below_transition_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rf_phase_below_transition_ref
  end subroutine

  ! bmad_common_struct%sr_wakes_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_sr_wakes_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_sr_wakes_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sr_wakes_on
  end subroutine

  ! bmad_common_struct%lr_wakes_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_lr_wakes_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_lr_wakes_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lr_wakes_on
  end subroutine

  ! bmad_common_struct%auto_bookkeeper: 0D_NOT_logical

  subroutine bmad_common_struct_get_auto_bookkeeper(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_auto_bookkeeper')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%auto_bookkeeper
  end subroutine

  ! bmad_common_struct%high_energy_space_charge_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_high_energy_space_charge_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_high_energy_space_charge_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%high_energy_space_charge_on
  end subroutine

  ! bmad_common_struct%csr_and_space_charge_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_csr_and_space_charge_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_csr_and_space_charge_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%csr_and_space_charge_on
  end subroutine

  ! bmad_common_struct%spin_tracking_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_spin_tracking_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_spin_tracking_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_tracking_on
  end subroutine

  ! bmad_common_struct%spin_sokolov_ternov_flipping_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_spin_sokolov_ternov_flipping_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_spin_sokolov_ternov_flipping_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_sokolov_ternov_flipping_on
  end subroutine

  ! bmad_common_struct%radiation_damping_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_radiation_damping_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_radiation_damping_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radiation_damping_on
  end subroutine

  ! bmad_common_struct%radiation_zero_average: 0D_NOT_logical

  subroutine bmad_common_struct_get_radiation_zero_average(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_radiation_zero_average')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radiation_zero_average
  end subroutine

  ! bmad_common_struct%radiation_fluctuations_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_radiation_fluctuations_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_radiation_fluctuations_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%radiation_fluctuations_on
  end subroutine

  ! bmad_common_struct%conserve_taylor_maps: 0D_NOT_logical

  subroutine bmad_common_struct_get_conserve_taylor_maps(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_conserve_taylor_maps')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%conserve_taylor_maps
  end subroutine

  ! bmad_common_struct%absolute_time_tracking: 0D_NOT_logical

  subroutine bmad_common_struct_get_absolute_time_tracking(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_absolute_time_tracking')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%absolute_time_tracking
  end subroutine

  ! bmad_common_struct%absolute_time_ref_shift: 0D_NOT_logical

  subroutine bmad_common_struct_get_absolute_time_ref_shift(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_absolute_time_ref_shift')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%absolute_time_ref_shift
  end subroutine

  ! bmad_common_struct%convert_to_kinetic_momentum: 0D_NOT_logical

  subroutine bmad_common_struct_get_convert_to_kinetic_momentum(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_convert_to_kinetic_momentum')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%convert_to_kinetic_momentum
  end subroutine

  ! bmad_common_struct%normalize_twiss: 0D_NOT_logical

  subroutine bmad_common_struct_get_normalize_twiss(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_normalize_twiss')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%normalize_twiss
  end subroutine

  ! bmad_common_struct%aperture_limit_on: 0D_NOT_logical

  subroutine bmad_common_struct_get_aperture_limit_on(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_aperture_limit_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%aperture_limit_on
  end subroutine

  ! bmad_common_struct%spin_n0_direction_user_set: 0D_NOT_logical

  subroutine bmad_common_struct_get_spin_n0_direction_user_set(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_spin_n0_direction_user_set')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_n0_direction_user_set
  end subroutine

  ! bmad_common_struct%debug: 0D_NOT_logical

  subroutine bmad_common_struct_get_debug(struct_obj_ptr, value_out) bind(c, name='bmad_common_struct_get_debug')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bmad_common_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%debug
  end subroutine

  !! rad_int1_struct
  ! rad_int1_struct%i0: 0D_NOT_real

  subroutine rad_int1_struct_get_i0(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i0
  end subroutine

  ! rad_int1_struct%i1: 0D_NOT_real

  subroutine rad_int1_struct_get_i1(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i1
  end subroutine

  ! rad_int1_struct%i2: 0D_NOT_real

  subroutine rad_int1_struct_get_i2(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i2')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i2
  end subroutine

  ! rad_int1_struct%i3: 0D_NOT_real

  subroutine rad_int1_struct_get_i3(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i3')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i3
  end subroutine

  ! rad_int1_struct%i4a: 0D_NOT_real

  subroutine rad_int1_struct_get_i4a(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i4a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i4a
  end subroutine

  ! rad_int1_struct%i4b: 0D_NOT_real

  subroutine rad_int1_struct_get_i4b(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i4b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i4b
  end subroutine

  ! rad_int1_struct%i4z: 0D_NOT_real

  subroutine rad_int1_struct_get_i4z(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i4z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i4z
  end subroutine

  ! rad_int1_struct%i5a: 0D_NOT_real

  subroutine rad_int1_struct_get_i5a(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i5a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i5a
  end subroutine

  ! rad_int1_struct%i5b: 0D_NOT_real

  subroutine rad_int1_struct_get_i5b(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i5b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i5b
  end subroutine

  ! rad_int1_struct%i6b: 0D_NOT_real

  subroutine rad_int1_struct_get_i6b(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_i6b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i6b
  end subroutine

  ! rad_int1_struct%lin_i2_E4: 0D_NOT_real

  subroutine rad_int1_struct_get_lin_i2_E4(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_lin_i2_E4')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_i2_E4
  end subroutine

  ! rad_int1_struct%lin_i3_E7: 0D_NOT_real

  subroutine rad_int1_struct_get_lin_i3_E7(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_lin_i3_E7')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_i3_E7
  end subroutine

  ! rad_int1_struct%lin_i5a_E6: 0D_NOT_real

  subroutine rad_int1_struct_get_lin_i5a_E6(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_lin_i5a_E6')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_i5a_E6
  end subroutine

  ! rad_int1_struct%lin_i5b_E6: 0D_NOT_real

  subroutine rad_int1_struct_get_lin_i5b_E6(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_lin_i5b_E6')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_i5b_E6
  end subroutine

  ! rad_int1_struct%lin_norm_emit_a: 0D_NOT_real

  subroutine rad_int1_struct_get_lin_norm_emit_a(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_lin_norm_emit_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_norm_emit_a
  end subroutine

  ! rad_int1_struct%lin_norm_emit_b: 0D_NOT_real

  subroutine rad_int1_struct_get_lin_norm_emit_b(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_lin_norm_emit_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_norm_emit_b
  end subroutine

  ! rad_int1_struct%lin_sig_E: 0D_NOT_real

  subroutine rad_int1_struct_get_lin_sig_E(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_lin_sig_E')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lin_sig_E
  end subroutine

  ! rad_int1_struct%n_steps: 0D_NOT_real

  subroutine rad_int1_struct_get_n_steps(struct_obj_ptr, value_out) bind(c, name='rad_int1_struct_get_n_steps')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rad_int1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_steps
  end subroutine

  !! rad_int_branch_struct
  ! rad_int_branch_struct%ele: 1D_ALLOC_type

  subroutine rad_int_branch_struct_get_ele_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='rad_int_branch_struct_get_ele_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(rad_int_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ele)) then
      data_ptr = c_loc(struct_obj%ele(lbound(struct_obj%ele, 1)))
      lower_bound = int(lbound(struct_obj%ele, 1), c_int)
      upper_bound = int(ubound(struct_obj%ele, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%ele(lbound(struct_obj%ele, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! rad_int_all_ele_struct
  ! rad_int_all_ele_struct%branch: 1D_ALLOC_type

  subroutine rad_int_all_ele_struct_get_branch_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='rad_int_all_ele_struct_get_branch_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(rad_int_all_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%branch)) then
      data_ptr = c_loc(struct_obj%branch(lbound(struct_obj%branch, 1)))
      lower_bound = int(lbound(struct_obj%branch, 1), c_int)
      upper_bound = int(ubound(struct_obj%branch, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%branch(lbound(struct_obj%branch, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! rf_stair_step_struct
  ! rf_stair_step_struct%E_tot0: 0D_NOT_real

  subroutine rf_stair_step_struct_get_E_tot0(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_E_tot0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_tot0
  end subroutine

  ! rf_stair_step_struct%E_tot1: 0D_NOT_real

  subroutine rf_stair_step_struct_get_E_tot1(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_E_tot1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%E_tot1
  end subroutine

  ! rf_stair_step_struct%p0c: 0D_NOT_real

  subroutine rf_stair_step_struct_get_p0c(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_p0c')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%p0c
  end subroutine

  ! rf_stair_step_struct%p1c: 0D_NOT_real

  subroutine rf_stair_step_struct_get_p1c(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_p1c')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%p1c
  end subroutine

  ! rf_stair_step_struct%dE_amp: 0D_NOT_real

  subroutine rf_stair_step_struct_get_dE_amp(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_dE_amp')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dE_amp
  end subroutine

  ! rf_stair_step_struct%scale: 0D_NOT_real

  subroutine rf_stair_step_struct_get_scale(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%scale
  end subroutine

  ! rf_stair_step_struct%time: 0D_NOT_real

  subroutine rf_stair_step_struct_get_time(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_time')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%time
  end subroutine

  ! rf_stair_step_struct%s: 0D_NOT_real

  subroutine rf_stair_step_struct_get_s(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_s')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine

  ! rf_stair_step_struct%ix_step: 0D_NOT_integer

  subroutine rf_stair_step_struct_get_ix_step(struct_obj_ptr, value_out) bind(c, name='rf_stair_step_struct_get_ix_step')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(rf_stair_step_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_step
  end subroutine

  !! rf_ele_struct
  ! rf_ele_struct%steps: 1D_ALLOC_type

  subroutine rf_ele_struct_get_steps_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='rf_ele_struct_get_steps_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(rf_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%steps)) then
      data_ptr = c_loc(struct_obj%steps(lbound(struct_obj%steps, 1)))
      lower_bound = int(lbound(struct_obj%steps, 1), c_int)
      upper_bound = int(ubound(struct_obj%steps, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%steps(lbound(struct_obj%steps, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! rf_ele_struct%ds_step: 0D_NOT_real

  subroutine rf_ele_struct_get_ds_step(struct_obj_ptr, value_out) bind(c, name='rf_ele_struct_get_ds_step')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(rf_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ds_step
  end subroutine

  !! ele_struct
  ! ele_struct%name: 0D_NOT_character

  subroutine ele_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ele_struct_get_name_info')
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

  ! ele_struct%type: 0D_NOT_character

  subroutine ele_struct_get_type_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ele_struct_get_type_info')
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

  ! ele_struct%alias: 0D_NOT_character

  subroutine ele_struct_get_alias_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ele_struct_get_alias_info')
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

  ! ele_struct%component_name: 0D_NOT_character

  subroutine ele_struct_get_component_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ele_struct_get_component_name_info')
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

  ! ele_struct%descrip: 0D_PTR_character

  subroutine ele_struct_get_descrip_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='ele_struct_get_descrip_info')
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

  ! ele_struct%a: 0D_NOT_type

  subroutine ele_struct_get_a(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine

  ! ele_struct%b: 0D_NOT_type

  subroutine ele_struct_get_b(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine

  ! ele_struct%z: 0D_NOT_type

  subroutine ele_struct_get_z(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z)
  end subroutine

  ! ele_struct%x: 0D_NOT_type

  subroutine ele_struct_get_x(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%x)
  end subroutine

  ! ele_struct%y: 0D_NOT_type

  subroutine ele_struct_get_y(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%y)
  end subroutine

  ! ele_struct%ac_kick: 0D_PTR_type

  subroutine ele_struct_get_ac_kick(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_ac_kick')
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

  ! ele_struct%bookkeeping_state: 0D_NOT_type

  subroutine ele_struct_get_bookkeeping_state(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_bookkeeping_state')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%bookkeeping_state)
  end subroutine

  ! ele_struct%branch: 0D_PTR_type

  subroutine ele_struct_get_branch(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_branch')
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

  ! ele_struct%control: 0D_PTR_type

  subroutine ele_struct_get_control(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_control')
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

  ! ele_struct%rf: 0D_PTR_type

  subroutine ele_struct_get_rf(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_rf')
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

  ! ele_struct%lord: 0D_PTR_type

  subroutine ele_struct_get_lord(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_lord')
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

  ! ele_struct%floor: 0D_NOT_type

  subroutine ele_struct_get_floor(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_floor')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%floor)
  end subroutine

  ! ele_struct%high_energy_space_charge: 0D_PTR_type

  subroutine ele_struct_get_high_energy_space_charge(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_high_energy_space_charge')
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

  ! ele_struct%mode3: 0D_PTR_type

  subroutine ele_struct_get_mode3(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_mode3')
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

  ! ele_struct%photon: 0D_PTR_type

  subroutine ele_struct_get_photon(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_photon')
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

  ! ele_struct%rad_map: 0D_PTR_type

  subroutine ele_struct_get_rad_map(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_rad_map')
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

  ! ele_struct%taylor: 1D_NOT_type

  subroutine ele_struct_get_taylor_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='ele_struct_get_taylor_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%taylor(lbound(struct_obj%taylor, 1)))
    lower_bound = int(lbound(struct_obj%taylor, 1), c_int)
    upper_bound = int(ubound(struct_obj%taylor, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%taylor(lbound(struct_obj%taylor, 1))) / 8, c_size_t)
  end subroutine

  ! ele_struct%spin_taylor_ref_orb_in: 1D_NOT_real

  subroutine ele_struct_get_spin_taylor_ref_orb_in_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ele_struct_get_spin_taylor_ref_orb_in_info')
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

  ! ele_struct%spin_taylor: 1D_NOT_type

  subroutine ele_struct_get_spin_taylor_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='ele_struct_get_spin_taylor_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%spin_taylor(lbound(struct_obj%spin_taylor, 1)))
    lower_bound = int(lbound(struct_obj%spin_taylor, 1), c_int)
    upper_bound = int(ubound(struct_obj%spin_taylor, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%spin_taylor(lbound(struct_obj%spin_taylor, 1))) / 8, c_size_t)
  end subroutine

  ! ele_struct%wake: 0D_PTR_type

  subroutine ele_struct_get_wake(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_wake')
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

  ! ele_struct%wall3d: 1D_PTR_type

  subroutine ele_struct_get_wall3d_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='ele_struct_get_wall3d_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%wall3d)) then
      data_ptr = c_loc(struct_obj%wall3d(lbound(struct_obj%wall3d, 1)))
      lower_bound = int(lbound(struct_obj%wall3d, 1), c_int)
      upper_bound = int(ubound(struct_obj%wall3d, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%wall3d(lbound(struct_obj%wall3d, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! ele_struct%cartesian_map: 1D_PTR_type

  subroutine ele_struct_get_cartesian_map_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='ele_struct_get_cartesian_map_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%cartesian_map)) then
      data_ptr = c_loc(struct_obj%cartesian_map(lbound(struct_obj%cartesian_map, 1)))
      lower_bound = int(lbound(struct_obj%cartesian_map, 1), c_int)
      upper_bound = int(ubound(struct_obj%cartesian_map, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%cartesian_map(lbound(struct_obj%cartesian_map, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! ele_struct%cylindrical_map: 1D_PTR_type

  subroutine ele_struct_get_cylindrical_map_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='ele_struct_get_cylindrical_map_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%cylindrical_map)) then
      data_ptr = c_loc(struct_obj%cylindrical_map(lbound(struct_obj%cylindrical_map, 1)))
      lower_bound = int(lbound(struct_obj%cylindrical_map, 1), c_int)
      upper_bound = int(ubound(struct_obj%cylindrical_map, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%cylindrical_map(lbound(struct_obj%cylindrical_map, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! ele_struct%gen_grad_map: 1D_PTR_type

  subroutine ele_struct_get_gen_grad_map_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='ele_struct_get_gen_grad_map_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%gen_grad_map)) then
      data_ptr = c_loc(struct_obj%gen_grad_map(lbound(struct_obj%gen_grad_map, 1)))
      lower_bound = int(lbound(struct_obj%gen_grad_map, 1), c_int)
      upper_bound = int(ubound(struct_obj%gen_grad_map, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%gen_grad_map(lbound(struct_obj%gen_grad_map, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! ele_struct%grid_field: 1D_PTR_type

  subroutine ele_struct_get_grid_field_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='ele_struct_get_grid_field_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%grid_field)) then
      data_ptr = c_loc(struct_obj%grid_field(lbound(struct_obj%grid_field, 1)))
      lower_bound = int(lbound(struct_obj%grid_field, 1), c_int)
      upper_bound = int(ubound(struct_obj%grid_field, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%grid_field(lbound(struct_obj%grid_field, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! ele_struct%map_ref_orb_in: 0D_NOT_type

  subroutine ele_struct_get_map_ref_orb_in(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_map_ref_orb_in')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%map_ref_orb_in)
  end subroutine

  ! ele_struct%map_ref_orb_out: 0D_NOT_type

  subroutine ele_struct_get_map_ref_orb_out(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_map_ref_orb_out')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%map_ref_orb_out)
  end subroutine

  ! ele_struct%time_ref_orb_in: 0D_NOT_type

  subroutine ele_struct_get_time_ref_orb_in(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_time_ref_orb_in')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%time_ref_orb_in)
  end subroutine

  ! ele_struct%time_ref_orb_out: 0D_NOT_type

  subroutine ele_struct_get_time_ref_orb_out(struct_obj_ptr, ptr_out) bind(c, name='ele_struct_get_time_ref_orb_out')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%time_ref_orb_out)
  end subroutine

  ! ele_struct%value: 1D_NOT_real

  subroutine ele_struct_get_value_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ele_struct_get_value_info')
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

  ! ele_struct%old_value: 1D_NOT_real

  subroutine ele_struct_get_old_value_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ele_struct_get_old_value_info')
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
  ! ele_struct%vec0: 1D_NOT_real

  subroutine ele_struct_get_vec0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ele_struct_get_vec0_info')
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
  ! ele_struct%gamma_c: 0D_NOT_real

  subroutine ele_struct_get_gamma_c(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_gamma_c')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%gamma_c
  end subroutine

  ! ele_struct%s_start: 0D_NOT_real

  subroutine ele_struct_get_s_start(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_s_start')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_start
  end subroutine

  ! ele_struct%s: 0D_NOT_real

  subroutine ele_struct_get_s(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_s')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine

  ! ele_struct%ref_time: 0D_NOT_real

  subroutine ele_struct_get_ref_time(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ref_time')
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
  ! ele_struct%key: 0D_NOT_integer

  subroutine ele_struct_get_key(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_key')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%key
  end subroutine

  ! ele_struct%sub_key: 0D_NOT_integer

  subroutine ele_struct_get_sub_key(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_sub_key')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sub_key
  end subroutine

  ! ele_struct%ix_ele: 0D_NOT_integer

  subroutine ele_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! ele_struct%ix_branch: 0D_NOT_integer

  subroutine ele_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  ! ele_struct%lord_status: 0D_NOT_integer

  subroutine ele_struct_get_lord_status(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_lord_status')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lord_status
  end subroutine

  ! ele_struct%n_slave: 0D_NOT_integer

  subroutine ele_struct_get_n_slave(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_n_slave')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_slave
  end subroutine

  ! ele_struct%n_slave_field: 0D_NOT_integer

  subroutine ele_struct_get_n_slave_field(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_n_slave_field')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_slave_field
  end subroutine

  ! ele_struct%ix1_slave: 0D_NOT_integer

  subroutine ele_struct_get_ix1_slave(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ix1_slave')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix1_slave
  end subroutine

  ! ele_struct%slave_status: 0D_NOT_integer

  subroutine ele_struct_get_slave_status(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_slave_status')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%slave_status
  end subroutine

  ! ele_struct%n_lord: 0D_NOT_integer

  subroutine ele_struct_get_n_lord(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_n_lord')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_lord
  end subroutine

  ! ele_struct%n_lord_field: 0D_NOT_integer

  subroutine ele_struct_get_n_lord_field(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_n_lord_field')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_lord_field
  end subroutine

  ! ele_struct%n_lord_ramper: 0D_NOT_integer

  subroutine ele_struct_get_n_lord_ramper(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_n_lord_ramper')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_lord_ramper
  end subroutine

  ! ele_struct%ic1_lord: 0D_NOT_integer

  subroutine ele_struct_get_ic1_lord(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ic1_lord')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ic1_lord
  end subroutine

  ! ele_struct%ix_pointer: 0D_NOT_integer

  subroutine ele_struct_get_ix_pointer(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ix_pointer')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_pointer
  end subroutine

  ! ele_struct%ixx: 0D_NOT_integer

  subroutine ele_struct_get_ixx(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ixx')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ixx
  end subroutine

  ! ele_struct%iyy: 0D_NOT_integer

  subroutine ele_struct_get_iyy(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_iyy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%iyy
  end subroutine

  ! ele_struct%izz: 0D_NOT_integer

  subroutine ele_struct_get_izz(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_izz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%izz
  end subroutine

  ! ele_struct%mat6_calc_method: 0D_NOT_integer

  subroutine ele_struct_get_mat6_calc_method(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_mat6_calc_method')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%mat6_calc_method
  end subroutine

  ! ele_struct%tracking_method: 0D_NOT_integer

  subroutine ele_struct_get_tracking_method(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_tracking_method')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tracking_method
  end subroutine

  ! ele_struct%spin_tracking_method: 0D_NOT_integer

  subroutine ele_struct_get_spin_tracking_method(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_spin_tracking_method')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_tracking_method
  end subroutine

  ! ele_struct%csr_method: 0D_NOT_integer

  subroutine ele_struct_get_csr_method(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_csr_method')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%csr_method
  end subroutine

  ! ele_struct%space_charge_method: 0D_NOT_integer

  subroutine ele_struct_get_space_charge_method(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_space_charge_method')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%space_charge_method
  end subroutine

  ! ele_struct%ptc_integration_type: 0D_NOT_integer

  subroutine ele_struct_get_ptc_integration_type(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ptc_integration_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ptc_integration_type
  end subroutine

  ! ele_struct%field_calc: 0D_NOT_integer

  subroutine ele_struct_get_field_calc(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_field_calc')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_calc
  end subroutine

  ! ele_struct%aperture_at: 0D_NOT_integer

  subroutine ele_struct_get_aperture_at(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_aperture_at')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%aperture_at
  end subroutine

  ! ele_struct%aperture_type: 0D_NOT_integer

  subroutine ele_struct_get_aperture_type(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_aperture_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%aperture_type
  end subroutine

  ! ele_struct%ref_species: 0D_NOT_integer

  subroutine ele_struct_get_ref_species(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_ref_species')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref_species
  end subroutine

  ! ele_struct%orientation: 0D_NOT_integer

  subroutine ele_struct_get_orientation(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_orientation')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%orientation
  end subroutine

  ! ele_struct%symplectify: 0D_NOT_logical

  subroutine ele_struct_get_symplectify(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_symplectify')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%symplectify
  end subroutine

  ! ele_struct%mode_flip: 0D_NOT_logical

  subroutine ele_struct_get_mode_flip(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_mode_flip')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%mode_flip
  end subroutine

  ! ele_struct%multipoles_on: 0D_NOT_logical

  subroutine ele_struct_get_multipoles_on(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_multipoles_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%multipoles_on
  end subroutine

  ! ele_struct%scale_multipoles: 0D_NOT_logical

  subroutine ele_struct_get_scale_multipoles(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_scale_multipoles')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%scale_multipoles
  end subroutine

  ! ele_struct%taylor_map_includes_offsets: 0D_NOT_logical

  subroutine ele_struct_get_taylor_map_includes_offsets(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_taylor_map_includes_offsets')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%taylor_map_includes_offsets
  end subroutine

  ! ele_struct%field_master: 0D_NOT_logical

  subroutine ele_struct_get_field_master(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_field_master')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%field_master
  end subroutine

  ! ele_struct%is_on: 0D_NOT_logical

  subroutine ele_struct_get_is_on(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_is_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%is_on
  end subroutine

  ! ele_struct%logic: 0D_NOT_logical

  subroutine ele_struct_get_logic(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_logic')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%logic
  end subroutine

  ! ele_struct%bmad_logic: 0D_NOT_logical

  subroutine ele_struct_get_bmad_logic(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_bmad_logic')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%bmad_logic
  end subroutine

  ! ele_struct%select: 0D_NOT_logical

  subroutine ele_struct_get_select(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_select')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%select
  end subroutine

  ! ele_struct%offset_moves_aperture: 0D_NOT_logical

  subroutine ele_struct_get_offset_moves_aperture(struct_obj_ptr, value_out) bind(c, name='ele_struct_get_offset_moves_aperture')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%offset_moves_aperture
  end subroutine

  !! complex_taylor_term_struct
  ! complex_taylor_term_struct%coef: 0D_NOT_complex

  subroutine complex_taylor_term_struct_get_coef(struct_obj_ptr, value_out) bind(c, name='complex_taylor_term_struct_get_coef')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(complex_taylor_term_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%coef
  end subroutine

  ! complex_taylor_term_struct%expn: 1D_NOT_integer

  subroutine complex_taylor_term_struct_get_expn_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='complex_taylor_term_struct_get_expn_info')
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

  !! complex_taylor_struct
  ! complex_taylor_struct%ref: 0D_NOT_complex

  subroutine complex_taylor_struct_get_ref(struct_obj_ptr, value_out) bind(c, name='complex_taylor_struct_get_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(complex_taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref
  end subroutine

  ! complex_taylor_struct%term: 1D_PTR_type

  subroutine complex_taylor_struct_get_term_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='complex_taylor_struct_get_term_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(complex_taylor_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%term)) then
      data_ptr = c_loc(struct_obj%term(lbound(struct_obj%term, 1)))
      lower_bound = int(lbound(struct_obj%term, 1), c_int)
      upper_bound = int(ubound(struct_obj%term, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%term(lbound(struct_obj%term, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! branch_struct
  ! branch_struct%name: 0D_NOT_character

  subroutine branch_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='branch_struct_get_name_info')
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

  ! branch_struct%ix_branch: 0D_NOT_integer

  subroutine branch_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='branch_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  ! branch_struct%ix_from_branch: 0D_NOT_integer

  subroutine branch_struct_get_ix_from_branch(struct_obj_ptr, value_out) bind(c, name='branch_struct_get_ix_from_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_from_branch
  end subroutine

  ! branch_struct%ix_from_ele: 0D_NOT_integer

  subroutine branch_struct_get_ix_from_ele(struct_obj_ptr, value_out) bind(c, name='branch_struct_get_ix_from_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_from_ele
  end subroutine

  ! branch_struct%ix_to_ele: 0D_NOT_integer

  subroutine branch_struct_get_ix_to_ele(struct_obj_ptr, value_out) bind(c, name='branch_struct_get_ix_to_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_to_ele
  end subroutine

  ! branch_struct%ix_fixer: 0D_NOT_integer

  subroutine branch_struct_get_ix_fixer(struct_obj_ptr, value_out) bind(c, name='branch_struct_get_ix_fixer')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_fixer
  end subroutine

  ! branch_struct%n_ele_track: 0D_NOT_integer

  subroutine branch_struct_get_n_ele_track(struct_obj_ptr, value_out) bind(c, name='branch_struct_get_n_ele_track')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ele_track
  end subroutine

  ! branch_struct%n_ele_max: 0D_NOT_integer

  subroutine branch_struct_get_n_ele_max(struct_obj_ptr, value_out) bind(c, name='branch_struct_get_n_ele_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ele_max
  end subroutine

  ! branch_struct%lat: 0D_PTR_type

  subroutine branch_struct_get_lat(struct_obj_ptr, ptr_out) bind(c, name='branch_struct_get_lat')
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

  ! branch_struct%a: 0D_NOT_type

  subroutine branch_struct_get_a(struct_obj_ptr, ptr_out) bind(c, name='branch_struct_get_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine

  ! branch_struct%b: 0D_NOT_type

  subroutine branch_struct_get_b(struct_obj_ptr, ptr_out) bind(c, name='branch_struct_get_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine

  ! branch_struct%z: 0D_NOT_type

  subroutine branch_struct_get_z(struct_obj_ptr, ptr_out) bind(c, name='branch_struct_get_z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z)
  end subroutine

  ! branch_struct%ele: 1D_PTR_type

  subroutine branch_struct_get_ele_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='branch_struct_get_ele_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ele)) then
      data_ptr = c_loc(struct_obj%ele(lbound(struct_obj%ele, 1)))
      lower_bound = int(lbound(struct_obj%ele, 1), c_int)
      upper_bound = int(ubound(struct_obj%ele, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%ele(lbound(struct_obj%ele, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! branch_struct%param: 0D_NOT_type

  subroutine branch_struct_get_param(struct_obj_ptr, ptr_out) bind(c, name='branch_struct_get_param')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%param)
  end subroutine

  ! branch_struct%particle_start: 0D_NOT_type

  subroutine branch_struct_get_particle_start(struct_obj_ptr, ptr_out) bind(c, name='branch_struct_get_particle_start')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%particle_start)
  end subroutine

  ! branch_struct%wall3d: 1D_PTR_type

  subroutine branch_struct_get_wall3d_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='branch_struct_get_wall3d_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%wall3d)) then
      data_ptr = c_loc(struct_obj%wall3d(lbound(struct_obj%wall3d, 1)))
      lower_bound = int(lbound(struct_obj%wall3d, 1), c_int)
      upper_bound = int(ubound(struct_obj%wall3d, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%wall3d(lbound(struct_obj%wall3d, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! lat_struct
  ! lat_struct%use_name: 0D_NOT_character

  subroutine lat_struct_get_use_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='lat_struct_get_use_name_info')
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

  ! lat_struct%lattice: 0D_NOT_character

  subroutine lat_struct_get_lattice_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='lat_struct_get_lattice_info')
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

  ! lat_struct%machine: 0D_NOT_character

  subroutine lat_struct_get_machine_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='lat_struct_get_machine_info')
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

  ! lat_struct%input_file_name: 0D_NOT_character

  subroutine lat_struct_get_input_file_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='lat_struct_get_input_file_name_info')
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

  ! lat_struct%title: 0D_NOT_character

  subroutine lat_struct_get_title_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='lat_struct_get_title_info')
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
  ! lat_struct%constant: 1D_ALLOC_type

  subroutine lat_struct_get_constant_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='lat_struct_get_constant_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%constant)) then
      data_ptr = c_loc(struct_obj%constant(lbound(struct_obj%constant, 1)))
      lower_bound = int(lbound(struct_obj%constant, 1), c_int)
      upper_bound = int(ubound(struct_obj%constant, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%constant(lbound(struct_obj%constant, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! lat_struct%a: 0D_PTR_type

  subroutine lat_struct_get_a(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_a')
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

  ! lat_struct%b: 0D_PTR_type

  subroutine lat_struct_get_b(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_b')
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

  ! lat_struct%z: 0D_PTR_type

  subroutine lat_struct_get_z(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_z')
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

  ! lat_struct%param: 0D_PTR_type

  subroutine lat_struct_get_param(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_param')
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

  ! lat_struct%lord_state: 0D_NOT_type

  subroutine lat_struct_get_lord_state(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_lord_state')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lord_state)
  end subroutine

  ! lat_struct%ele_init: 0D_NOT_type

  subroutine lat_struct_get_ele_init(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_ele_init')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ele_init)
  end subroutine

  ! lat_struct%branch: 1D_ALLOC_type

  subroutine lat_struct_get_branch_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='lat_struct_get_branch_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%branch)) then
      data_ptr = c_loc(struct_obj%branch(lbound(struct_obj%branch, 1)))
      lower_bound = int(lbound(struct_obj%branch, 1), c_int)
      upper_bound = int(ubound(struct_obj%branch, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%branch(lbound(struct_obj%branch, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! lat_struct%control: 1D_ALLOC_type

  subroutine lat_struct_get_control_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='lat_struct_get_control_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%control)) then
      data_ptr = c_loc(struct_obj%control(lbound(struct_obj%control, 1)))
      lower_bound = int(lbound(struct_obj%control, 1), c_int)
      upper_bound = int(ubound(struct_obj%control, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%control(lbound(struct_obj%control, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! lat_struct%particle_start: 0D_PTR_type

  subroutine lat_struct_get_particle_start(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_particle_start')
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

  ! lat_struct%beam_init: 0D_NOT_type

  subroutine lat_struct_get_beam_init(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_beam_init')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam_init)
  end subroutine

  ! lat_struct%pre_tracker: 0D_NOT_type

  subroutine lat_struct_get_pre_tracker(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_pre_tracker')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%pre_tracker)
  end subroutine

  ! lat_struct%custom: 1D_ALLOC_real

  subroutine lat_struct_get_custom_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='lat_struct_get_custom_info')
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

  ! lat_struct%version: 0D_NOT_integer

  subroutine lat_struct_get_version(struct_obj_ptr, value_out) bind(c, name='lat_struct_get_version')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%version
  end subroutine

  ! lat_struct%n_ele_track: 0D_PTR_integer

  subroutine lat_struct_get_n_ele_track(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_n_ele_track')
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

  ! lat_struct%n_ele_max: 0D_PTR_integer

  subroutine lat_struct_get_n_ele_max(struct_obj_ptr, ptr_out) bind(c, name='lat_struct_get_n_ele_max')
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

  ! lat_struct%n_control_max: 0D_NOT_integer

  subroutine lat_struct_get_n_control_max(struct_obj_ptr, value_out) bind(c, name='lat_struct_get_n_control_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_control_max
  end subroutine

  ! lat_struct%n_ic_max: 0D_NOT_integer

  subroutine lat_struct_get_n_ic_max(struct_obj_ptr, value_out) bind(c, name='lat_struct_get_n_ic_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_ic_max
  end subroutine

  ! lat_struct%input_taylor_order: 0D_NOT_integer

  subroutine lat_struct_get_input_taylor_order(struct_obj_ptr, value_out) bind(c, name='lat_struct_get_input_taylor_order')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%input_taylor_order
  end subroutine

  ! lat_struct%ic: 1D_ALLOC_integer

  subroutine lat_struct_get_ic_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='lat_struct_get_ic_info')
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

  ! lat_struct%photon_type: 0D_NOT_integer

  subroutine lat_struct_get_photon_type(struct_obj_ptr, value_out) bind(c, name='lat_struct_get_photon_type')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%photon_type
  end subroutine

  ! lat_struct%creation_hash: 0D_NOT_integer

  subroutine lat_struct_get_creation_hash(struct_obj_ptr, value_out) bind(c, name='lat_struct_get_creation_hash')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%creation_hash
  end subroutine

  ! lat_struct%ramper_slave_bookkeeping: 0D_NOT_integer

  subroutine lat_struct_get_ramper_slave_bookkeeping(struct_obj_ptr, value_out) bind(c, name='lat_struct_get_ramper_slave_bookkeeping')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ramper_slave_bookkeeping
  end subroutine

  !! bunch_struct
  ! bunch_struct%particle: 1D_ALLOC_type

  subroutine bunch_struct_get_particle_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='bunch_struct_get_particle_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%particle)) then
      data_ptr = c_loc(struct_obj%particle(lbound(struct_obj%particle, 1)))
      lower_bound = int(lbound(struct_obj%particle, 1), c_int)
      upper_bound = int(ubound(struct_obj%particle, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%particle(lbound(struct_obj%particle, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! bunch_struct%ix_z: 1D_ALLOC_integer

  subroutine bunch_struct_get_ix_z_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='bunch_struct_get_ix_z_info')
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

  ! bunch_struct%charge_tot: 0D_NOT_real

  subroutine bunch_struct_get_charge_tot(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_charge_tot')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge_tot
  end subroutine

  ! bunch_struct%charge_live: 0D_NOT_real

  subroutine bunch_struct_get_charge_live(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_charge_live')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge_live
  end subroutine

  ! bunch_struct%z_center: 0D_NOT_real

  subroutine bunch_struct_get_z_center(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_z_center')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%z_center
  end subroutine

  ! bunch_struct%t_center: 0D_NOT_real

  subroutine bunch_struct_get_t_center(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_t_center')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t_center
  end subroutine

  ! bunch_struct%t0: 0D_NOT_real

  subroutine bunch_struct_get_t0(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_t0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t0
  end subroutine

  ! bunch_struct%drift_between_t_and_s: 0D_NOT_logical

  subroutine bunch_struct_get_drift_between_t_and_s(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_drift_between_t_and_s')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%drift_between_t_and_s
  end subroutine

  ! bunch_struct%ix_ele: 0D_NOT_integer

  subroutine bunch_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! bunch_struct%ix_bunch: 0D_NOT_integer

  subroutine bunch_struct_get_ix_bunch(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_ix_bunch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_bunch
  end subroutine

  ! bunch_struct%ix_turn: 0D_NOT_integer

  subroutine bunch_struct_get_ix_turn(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_ix_turn')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_turn
  end subroutine

  ! bunch_struct%n_live: 0D_NOT_integer

  subroutine bunch_struct_get_n_live(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_n_live')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_live
  end subroutine

  ! bunch_struct%n_good: 0D_NOT_integer

  subroutine bunch_struct_get_n_good(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_n_good')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_good
  end subroutine

  ! bunch_struct%n_bad: 0D_NOT_integer

  subroutine bunch_struct_get_n_bad(struct_obj_ptr, value_out) bind(c, name='bunch_struct_get_n_bad')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bad
  end subroutine

  !! bunch_params_struct
  ! bunch_params_struct%centroid: 0D_NOT_type

  subroutine bunch_params_struct_get_centroid(struct_obj_ptr, ptr_out) bind(c, name='bunch_params_struct_get_centroid')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%centroid)
  end subroutine

  ! bunch_params_struct%x: 0D_NOT_type

  subroutine bunch_params_struct_get_x(struct_obj_ptr, ptr_out) bind(c, name='bunch_params_struct_get_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%x)
  end subroutine

  ! bunch_params_struct%y: 0D_NOT_type

  subroutine bunch_params_struct_get_y(struct_obj_ptr, ptr_out) bind(c, name='bunch_params_struct_get_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%y)
  end subroutine

  ! bunch_params_struct%z: 0D_NOT_type

  subroutine bunch_params_struct_get_z(struct_obj_ptr, ptr_out) bind(c, name='bunch_params_struct_get_z')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%z)
  end subroutine

  ! bunch_params_struct%a: 0D_NOT_type

  subroutine bunch_params_struct_get_a(struct_obj_ptr, ptr_out) bind(c, name='bunch_params_struct_get_a')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%a)
  end subroutine

  ! bunch_params_struct%b: 0D_NOT_type

  subroutine bunch_params_struct_get_b(struct_obj_ptr, ptr_out) bind(c, name='bunch_params_struct_get_b')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%b)
  end subroutine

  ! bunch_params_struct%c: 0D_NOT_type

  subroutine bunch_params_struct_get_c(struct_obj_ptr, ptr_out) bind(c, name='bunch_params_struct_get_c')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%c)
  end subroutine

  ! skipped bunch_params_struct%sigma: Unsupported type: 2D_NOT_real
  ! bunch_params_struct%rel_max: 1D_NOT_real

  subroutine bunch_params_struct_get_rel_max_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='bunch_params_struct_get_rel_max_info')
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

  ! bunch_params_struct%rel_min: 1D_NOT_real

  subroutine bunch_params_struct_get_rel_min_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='bunch_params_struct_get_rel_min_info')
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

  ! bunch_params_struct%s: 0D_NOT_real

  subroutine bunch_params_struct_get_s(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_s')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine

  ! bunch_params_struct%t: 0D_NOT_real

  subroutine bunch_params_struct_get_t(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_t')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%t
  end subroutine

  ! bunch_params_struct%sigma_t: 0D_NOT_real

  subroutine bunch_params_struct_get_sigma_t(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_sigma_t')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma_t
  end subroutine

  ! bunch_params_struct%charge_live: 0D_NOT_real

  subroutine bunch_params_struct_get_charge_live(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_charge_live')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge_live
  end subroutine

  ! bunch_params_struct%charge_tot: 0D_NOT_real

  subroutine bunch_params_struct_get_charge_tot(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_charge_tot')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%charge_tot
  end subroutine

  ! bunch_params_struct%n_particle_tot: 0D_NOT_integer

  subroutine bunch_params_struct_get_n_particle_tot(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_n_particle_tot')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_particle_tot
  end subroutine

  ! bunch_params_struct%n_particle_live: 0D_NOT_integer

  subroutine bunch_params_struct_get_n_particle_live(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_n_particle_live')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_particle_live
  end subroutine

  ! bunch_params_struct%n_particle_lost_in_ele: 0D_NOT_integer

  subroutine bunch_params_struct_get_n_particle_lost_in_ele(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_n_particle_lost_in_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_particle_lost_in_ele
  end subroutine

  ! bunch_params_struct%n_good_steps: 0D_NOT_integer

  subroutine bunch_params_struct_get_n_good_steps(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_n_good_steps')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_good_steps
  end subroutine

  ! bunch_params_struct%n_bad_steps: 0D_NOT_integer

  subroutine bunch_params_struct_get_n_bad_steps(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_n_bad_steps')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_bad_steps
  end subroutine

  ! bunch_params_struct%ix_ele: 0D_NOT_integer

  subroutine bunch_params_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! bunch_params_struct%location: 0D_NOT_integer

  subroutine bunch_params_struct_get_location(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_location')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%location
  end subroutine

  ! bunch_params_struct%twiss_valid: 0D_NOT_logical

  subroutine bunch_params_struct_get_twiss_valid(struct_obj_ptr, value_out) bind(c, name='bunch_params_struct_get_twiss_valid')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(bunch_params_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%twiss_valid
  end subroutine

  !! beam_struct
  ! beam_struct%bunch: 1D_ALLOC_type

  subroutine beam_struct_get_bunch_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='beam_struct_get_bunch_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(beam_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%bunch)) then
      data_ptr = c_loc(struct_obj%bunch(lbound(struct_obj%bunch, 1)))
      lower_bound = int(lbound(struct_obj%bunch, 1), c_int)
      upper_bound = int(ubound(struct_obj%bunch, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%bunch(lbound(struct_obj%bunch, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! aperture_point_struct
  ! aperture_point_struct%x: 0D_NOT_real

  subroutine aperture_point_struct_get_x(struct_obj_ptr, value_out) bind(c, name='aperture_point_struct_get_x')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x
  end subroutine

  ! aperture_point_struct%y: 0D_NOT_real

  subroutine aperture_point_struct_get_y(struct_obj_ptr, value_out) bind(c, name='aperture_point_struct_get_y')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y
  end subroutine

  ! aperture_point_struct%plane: 0D_NOT_integer

  subroutine aperture_point_struct_get_plane(struct_obj_ptr, value_out) bind(c, name='aperture_point_struct_get_plane')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%plane
  end subroutine

  ! aperture_point_struct%ix_ele: 0D_NOT_integer

  subroutine aperture_point_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='aperture_point_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! aperture_point_struct%i_turn: 0D_NOT_integer

  subroutine aperture_point_struct_get_i_turn(struct_obj_ptr, value_out) bind(c, name='aperture_point_struct_get_i_turn')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_point_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%i_turn
  end subroutine

  !! aperture_param_struct
  ! aperture_param_struct%min_angle: 0D_NOT_real

  subroutine aperture_param_struct_get_min_angle(struct_obj_ptr, value_out) bind(c, name='aperture_param_struct_get_min_angle')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%min_angle
  end subroutine

  ! aperture_param_struct%max_angle: 0D_NOT_real

  subroutine aperture_param_struct_get_max_angle(struct_obj_ptr, value_out) bind(c, name='aperture_param_struct_get_max_angle')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%max_angle
  end subroutine

  ! aperture_param_struct%n_angle: 0D_NOT_integer

  subroutine aperture_param_struct_get_n_angle(struct_obj_ptr, value_out) bind(c, name='aperture_param_struct_get_n_angle')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_angle
  end subroutine

  ! aperture_param_struct%n_turn: 0D_NOT_integer

  subroutine aperture_param_struct_get_n_turn(struct_obj_ptr, value_out) bind(c, name='aperture_param_struct_get_n_turn')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_turn
  end subroutine

  ! aperture_param_struct%x_init: 0D_NOT_real

  subroutine aperture_param_struct_get_x_init(struct_obj_ptr, value_out) bind(c, name='aperture_param_struct_get_x_init')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%x_init
  end subroutine

  ! aperture_param_struct%y_init: 0D_NOT_real

  subroutine aperture_param_struct_get_y_init(struct_obj_ptr, value_out) bind(c, name='aperture_param_struct_get_y_init')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%y_init
  end subroutine

  ! aperture_param_struct%rel_accuracy: 0D_NOT_real

  subroutine aperture_param_struct_get_rel_accuracy(struct_obj_ptr, value_out) bind(c, name='aperture_param_struct_get_rel_accuracy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rel_accuracy
  end subroutine

  ! aperture_param_struct%abs_accuracy: 0D_NOT_real

  subroutine aperture_param_struct_get_abs_accuracy(struct_obj_ptr, value_out) bind(c, name='aperture_param_struct_get_abs_accuracy')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_param_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%abs_accuracy
  end subroutine

  ! aperture_param_struct%start_ele: 0D_NOT_character

  subroutine aperture_param_struct_get_start_ele_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='aperture_param_struct_get_start_ele_info')
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

  !! aperture_scan_struct
  ! aperture_scan_struct%point: 1D_ALLOC_type

  subroutine aperture_scan_struct_get_point_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='aperture_scan_struct_get_point_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(aperture_scan_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%point)) then
      data_ptr = c_loc(struct_obj%point(lbound(struct_obj%point, 1)))
      lower_bound = int(lbound(struct_obj%point, 1), c_int)
      upper_bound = int(ubound(struct_obj%point, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%point(lbound(struct_obj%point, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! aperture_scan_struct%ref_orb: 0D_NOT_type

  subroutine aperture_scan_struct_get_ref_orb(struct_obj_ptr, ptr_out) bind(c, name='aperture_scan_struct_get_ref_orb')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(aperture_scan_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ref_orb)
  end subroutine

  ! aperture_scan_struct%pz_start: 0D_NOT_real

  subroutine aperture_scan_struct_get_pz_start(struct_obj_ptr, value_out) bind(c, name='aperture_scan_struct_get_pz_start')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(aperture_scan_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pz_start
  end subroutine

  !! tao_spin_dn_dpz_struct
  ! tao_spin_dn_dpz_struct%vec: 1D_NOT_real

  subroutine tao_spin_dn_dpz_struct_get_vec_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_spin_dn_dpz_struct_get_vec_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_spin_dn_dpz_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%vec(lbound(struct_obj%vec, 1)))
    lower_bound = int(lbound(struct_obj%vec, 1), c_int)
    upper_bound = int(ubound(struct_obj%vec, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! skipped tao_spin_dn_dpz_struct%partial: Unsupported type: 2D_NOT_real
  ! skipped tao_spin_dn_dpz_struct%partial2: Unsupported type: 2D_NOT_real
  !! resonance_h_struct
  ! resonance_h_struct%id: 0D_NOT_character

  subroutine resonance_h_struct_get_id_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='resonance_h_struct_get_id_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(resonance_h_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%id)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%id), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! resonance_h_struct%c_val: 0D_NOT_complex

  subroutine resonance_h_struct_get_c_val(struct_obj_ptr, value_out) bind(c, name='resonance_h_struct_get_c_val')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(resonance_h_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%c_val
  end subroutine

  !! spin_orbit_map1_struct
  ! skipped spin_orbit_map1_struct%orb_mat: Unsupported type: 2D_NOT_real
  ! spin_orbit_map1_struct%vec0: 1D_NOT_real

  subroutine spin_orbit_map1_struct_get_vec0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='spin_orbit_map1_struct_get_vec0_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(spin_orbit_map1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%vec0(lbound(struct_obj%vec0, 1)))
    lower_bound = int(lbound(struct_obj%vec0, 1), c_int)
    upper_bound = int(ubound(struct_obj%vec0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! skipped spin_orbit_map1_struct%spin_q: Unsupported type: 2D_NOT_real
  !! spin_axis_struct
  ! spin_axis_struct%l: 1D_NOT_real

  subroutine spin_axis_struct_get_l_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='spin_axis_struct_get_l_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(spin_axis_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%l(lbound(struct_obj%l, 1)))
    lower_bound = int(lbound(struct_obj%l, 1), c_int)
    upper_bound = int(ubound(struct_obj%l, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! spin_axis_struct%n0: 1D_NOT_real

  subroutine spin_axis_struct_get_n0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='spin_axis_struct_get_n0_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(spin_axis_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%n0(lbound(struct_obj%n0, 1)))
    lower_bound = int(lbound(struct_obj%n0, 1), c_int)
    upper_bound = int(ubound(struct_obj%n0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! spin_axis_struct%m: 1D_NOT_real

  subroutine spin_axis_struct_get_m_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='spin_axis_struct_get_m_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(spin_axis_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%m(lbound(struct_obj%m, 1)))
    lower_bound = int(lbound(struct_obj%m, 1), c_int)
    upper_bound = int(ubound(struct_obj%m, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  !! ptc_normal_form_struct
  ! ptc_normal_form_struct%ele_origin: 0D_PTR_type

  subroutine ptc_normal_form_struct_get_ele_origin(struct_obj_ptr, ptr_out) bind(c, name='ptc_normal_form_struct_get_ele_origin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(ptc_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ele_origin)) then
      ptr_out = c_loc(struct_obj%ele_origin)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

  ! ptc_normal_form_struct%orb0: 1D_NOT_real

  subroutine ptc_normal_form_struct_get_orb0_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='ptc_normal_form_struct_get_orb0_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(ptc_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%orb0(lbound(struct_obj%orb0, 1)))
    lower_bound = int(lbound(struct_obj%orb0, 1), c_int)
    upper_bound = int(ubound(struct_obj%orb0, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! ptc_normal_form_struct%valid_map: 0D_NOT_logical

  subroutine ptc_normal_form_struct_get_valid_map(struct_obj_ptr, value_out) bind(c, name='ptc_normal_form_struct_get_valid_map')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(ptc_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%valid_map
  end subroutine

  !! bmad_normal_form_struct
  ! bmad_normal_form_struct%ele_origin: 0D_PTR_type

  subroutine bmad_normal_form_struct_get_ele_origin(struct_obj_ptr, ptr_out) bind(c, name='bmad_normal_form_struct_get_ele_origin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(bmad_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%ele_origin)) then
      ptr_out = c_loc(struct_obj%ele_origin)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

  ! bmad_normal_form_struct%M: 1D_NOT_type

  subroutine bmad_normal_form_struct_get_M_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='bmad_normal_form_struct_get_M_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(bmad_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%M(lbound(struct_obj%M, 1)))
    lower_bound = int(lbound(struct_obj%M, 1), c_int)
    upper_bound = int(ubound(struct_obj%M, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%M(lbound(struct_obj%M, 1))) / 8, c_size_t)
  end subroutine

  ! bmad_normal_form_struct%A: 1D_NOT_type

  subroutine bmad_normal_form_struct_get_A_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='bmad_normal_form_struct_get_A_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(bmad_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%A(lbound(struct_obj%A, 1)))
    lower_bound = int(lbound(struct_obj%A, 1), c_int)
    upper_bound = int(ubound(struct_obj%A, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%A(lbound(struct_obj%A, 1))) / 8, c_size_t)
  end subroutine

  ! bmad_normal_form_struct%A_inv: 1D_NOT_type

  subroutine bmad_normal_form_struct_get_A_inv_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='bmad_normal_form_struct_get_A_inv_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(bmad_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%A_inv(lbound(struct_obj%A_inv, 1)))
    lower_bound = int(lbound(struct_obj%A_inv, 1), c_int)
    upper_bound = int(ubound(struct_obj%A_inv, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%A_inv(lbound(struct_obj%A_inv, 1))) / 8, c_size_t)
  end subroutine

  ! bmad_normal_form_struct%dhdj: 1D_NOT_type

  subroutine bmad_normal_form_struct_get_dhdj_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='bmad_normal_form_struct_get_dhdj_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(bmad_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%dhdj(lbound(struct_obj%dhdj, 1)))
    lower_bound = int(lbound(struct_obj%dhdj, 1), c_int)
    upper_bound = int(ubound(struct_obj%dhdj, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%dhdj(lbound(struct_obj%dhdj, 1))) / 8, c_size_t)
  end subroutine

  ! bmad_normal_form_struct%F: 1D_NOT_type

  subroutine bmad_normal_form_struct_get_F_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='bmad_normal_form_struct_get_F_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(bmad_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%F(lbound(struct_obj%F, 1)))
    lower_bound = int(lbound(struct_obj%F, 1), c_int)
    upper_bound = int(ubound(struct_obj%F, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%F(lbound(struct_obj%F, 1))) / 8, c_size_t)
  end subroutine

  ! bmad_normal_form_struct%L: 1D_NOT_type

  subroutine bmad_normal_form_struct_get_L_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='bmad_normal_form_struct_get_L_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(bmad_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%L(lbound(struct_obj%L, 1)))
    lower_bound = int(lbound(struct_obj%L, 1), c_int)
    upper_bound = int(ubound(struct_obj%L, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%L(lbound(struct_obj%L, 1))) / 8, c_size_t)
  end subroutine

  ! bmad_normal_form_struct%h: 1D_ALLOC_type

  subroutine bmad_normal_form_struct_get_h_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='bmad_normal_form_struct_get_h_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(bmad_normal_form_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%h)) then
      data_ptr = c_loc(struct_obj%h(lbound(struct_obj%h, 1)))
      lower_bound = int(lbound(struct_obj%h, 1), c_int)
      upper_bound = int(ubound(struct_obj%h, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%h(lbound(struct_obj%h, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! bunch_track_struct
  ! bunch_track_struct%pt: 1D_ALLOC_type

  subroutine bunch_track_struct_get_pt_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='bunch_track_struct_get_pt_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(bunch_track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%pt)) then
      data_ptr = c_loc(struct_obj%pt(lbound(struct_obj%pt, 1)))
      lower_bound = int(lbound(struct_obj%pt, 1), c_int)
      upper_bound = int(ubound(struct_obj%pt, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%pt(lbound(struct_obj%pt, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! bunch_track_struct%ds_save: 0D_NOT_real

  subroutine bunch_track_struct_get_ds_save(struct_obj_ptr, value_out) bind(c, name='bunch_track_struct_get_ds_save')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(bunch_track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ds_save
  end subroutine

  ! bunch_track_struct%n_pt: 0D_NOT_integer

  subroutine bunch_track_struct_get_n_pt(struct_obj_ptr, value_out) bind(c, name='bunch_track_struct_get_n_pt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(bunch_track_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_pt
  end subroutine

  !! summation_rdt_struct
  ! summation_rdt_struct%h11001: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h11001(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h11001')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h11001
  end subroutine

  ! summation_rdt_struct%h00111: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h00111(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h00111')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h00111
  end subroutine

  ! summation_rdt_struct%h20001: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h20001(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h20001')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h20001
  end subroutine

  ! summation_rdt_struct%h00201: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h00201(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h00201')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h00201
  end subroutine

  ! summation_rdt_struct%h10002: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h10002(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h10002')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h10002
  end subroutine

  ! summation_rdt_struct%h21000: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h21000(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h21000')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h21000
  end subroutine

  ! summation_rdt_struct%h30000: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h30000(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h30000')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h30000
  end subroutine

  ! summation_rdt_struct%h10110: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h10110(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h10110')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h10110
  end subroutine

  ! summation_rdt_struct%h10020: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h10020(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h10020')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h10020
  end subroutine

  ! summation_rdt_struct%h10200: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h10200(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h10200')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h10200
  end subroutine

  ! summation_rdt_struct%h31000: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h31000(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h31000')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h31000
  end subroutine

  ! summation_rdt_struct%h40000: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h40000(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h40000')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h40000
  end subroutine

  ! summation_rdt_struct%h20110: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h20110(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h20110')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h20110
  end subroutine

  ! summation_rdt_struct%h11200: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h11200(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h11200')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h11200
  end subroutine

  ! summation_rdt_struct%h20020: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h20020(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h20020')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h20020
  end subroutine

  ! summation_rdt_struct%h20200: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h20200(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h20200')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h20200
  end subroutine

  ! summation_rdt_struct%h00310: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h00310(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h00310')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h00310
  end subroutine

  ! summation_rdt_struct%h00400: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h00400(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h00400')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h00400
  end subroutine

  ! summation_rdt_struct%h22000: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h22000(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h22000')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h22000
  end subroutine

  ! summation_rdt_struct%h00220: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h00220(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h00220')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h00220
  end subroutine

  ! summation_rdt_struct%h11110: 0D_NOT_complex

  subroutine summation_rdt_struct_get_h11110(struct_obj_ptr, value_out) bind(c, name='summation_rdt_struct_get_h11110')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(summation_rdt_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%h11110
  end subroutine

  !! lat_ele_order1_struct
  ! lat_ele_order1_struct%ix_branch: 0D_NOT_integer

  subroutine lat_ele_order1_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='lat_ele_order1_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_ele_order1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  ! lat_ele_order1_struct%ix_order: 0D_NOT_integer

  subroutine lat_ele_order1_struct_get_ix_order(struct_obj_ptr, value_out) bind(c, name='lat_ele_order1_struct_get_ix_order')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(lat_ele_order1_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_order
  end subroutine

  !! lat_ele_order_array_struct
  ! lat_ele_order_array_struct%ele: 1D_ALLOC_type

  subroutine lat_ele_order_array_struct_get_ele_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='lat_ele_order_array_struct_get_ele_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(lat_ele_order_array_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ele)) then
      data_ptr = c_loc(struct_obj%ele(lbound(struct_obj%ele, 1)))
      lower_bound = int(lbound(struct_obj%ele, 1), c_int)
      upper_bound = int(ubound(struct_obj%ele, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%ele(lbound(struct_obj%ele, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! tao_lat_sigma_struct
  ! skipped tao_lat_sigma_struct%mat: Unsupported type: 2D_NOT_real
  !! tao_spin_ele_struct
  ! tao_spin_ele_struct%dn_dpz: 0D_NOT_type

  subroutine tao_spin_ele_struct_get_dn_dpz(struct_obj_ptr, ptr_out) bind(c, name='tao_spin_ele_struct_get_dn_dpz')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_spin_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%dn_dpz)
  end subroutine

  ! tao_spin_ele_struct%orb_eigen_val: 1D_NOT_real

  subroutine tao_spin_ele_struct_get_orb_eigen_val_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_spin_ele_struct_get_orb_eigen_val_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_spin_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%orb_eigen_val(lbound(struct_obj%orb_eigen_val, 1)))
    lower_bound = int(lbound(struct_obj%orb_eigen_val, 1), c_int)
    upper_bound = int(ubound(struct_obj%orb_eigen_val, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! skipped tao_spin_ele_struct%orb_eigen_vec: Unsupported type: 2D_NOT_real
  ! skipped tao_spin_ele_struct%spin_eigen_vec: Unsupported type: 2D_NOT_real
  ! tao_spin_ele_struct%valid: 0D_NOT_logical

  subroutine tao_spin_ele_struct_get_valid(struct_obj_ptr, value_out) bind(c, name='tao_spin_ele_struct_get_valid')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_spin_ele_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%valid
  end subroutine

  !! tao_plot_cache_struct
  ! tao_plot_cache_struct%ele_to_s: 0D_NOT_type

  subroutine tao_plot_cache_struct_get_ele_to_s(struct_obj_ptr, ptr_out) bind(c, name='tao_plot_cache_struct_get_ele_to_s')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_plot_cache_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ele_to_s)
  end subroutine

  ! tao_plot_cache_struct%orbit: 0D_NOT_type

  subroutine tao_plot_cache_struct_get_orbit(struct_obj_ptr, ptr_out) bind(c, name='tao_plot_cache_struct_get_orbit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_plot_cache_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%orbit)
  end subroutine

  ! tao_plot_cache_struct%err: 0D_NOT_logical

  subroutine tao_plot_cache_struct_get_err(struct_obj_ptr, value_out) bind(c, name='tao_plot_cache_struct_get_err')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_plot_cache_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%err
  end subroutine

  !! tao_spin_polarization_struct
  ! tao_spin_polarization_struct%tune: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_tune(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_tune')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%tune
  end subroutine

  ! tao_spin_polarization_struct%pol_limit_st: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_pol_limit_st(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_pol_limit_st')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pol_limit_st
  end subroutine

  ! tao_spin_polarization_struct%pol_limit_dk: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_pol_limit_dk(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_pol_limit_dk')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pol_limit_dk
  end subroutine

  ! tao_spin_polarization_struct%pol_limit_dk_partial: 1D_NOT_real

  subroutine tao_spin_polarization_struct_get_pol_limit_dk_partial_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_spin_polarization_struct_get_pol_limit_dk_partial_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%pol_limit_dk_partial(lbound(struct_obj%pol_limit_dk_partial, 1)))
    lower_bound = int(lbound(struct_obj%pol_limit_dk_partial, 1), c_int)
    upper_bound = int(ubound(struct_obj%pol_limit_dk_partial, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_spin_polarization_struct%pol_limit_dk_partial2: 1D_NOT_real

  subroutine tao_spin_polarization_struct_get_pol_limit_dk_partial2_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_spin_polarization_struct_get_pol_limit_dk_partial2_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%pol_limit_dk_partial2(lbound(struct_obj%pol_limit_dk_partial2, 1)))
    lower_bound = int(lbound(struct_obj%pol_limit_dk_partial2, 1), c_int)
    upper_bound = int(ubound(struct_obj%pol_limit_dk_partial2, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_spin_polarization_struct%pol_rate_bks: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_pol_rate_bks(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_pol_rate_bks')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%pol_rate_bks
  end subroutine

  ! tao_spin_polarization_struct%depol_rate: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_depol_rate(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_depol_rate')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%depol_rate
  end subroutine

  ! tao_spin_polarization_struct%depol_rate_partial: 1D_NOT_real

  subroutine tao_spin_polarization_struct_get_depol_rate_partial_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_spin_polarization_struct_get_depol_rate_partial_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%depol_rate_partial(lbound(struct_obj%depol_rate_partial, 1)))
    lower_bound = int(lbound(struct_obj%depol_rate_partial, 1), c_int)
    upper_bound = int(ubound(struct_obj%depol_rate_partial, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_spin_polarization_struct%depol_rate_partial2: 1D_NOT_real

  subroutine tao_spin_polarization_struct_get_depol_rate_partial2_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_spin_polarization_struct_get_depol_rate_partial2_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%depol_rate_partial2(lbound(struct_obj%depol_rate_partial2, 1)))
    lower_bound = int(lbound(struct_obj%depol_rate_partial2, 1), c_int)
    upper_bound = int(ubound(struct_obj%depol_rate_partial2, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_spin_polarization_struct%integral_bn: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_integral_bn(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_integral_bn')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%integral_bn
  end subroutine

  ! tao_spin_polarization_struct%integral_bdn: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_integral_bdn(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_integral_bdn')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%integral_bdn
  end subroutine

  ! tao_spin_polarization_struct%integral_1ns: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_integral_1ns(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_integral_1ns')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%integral_1ns
  end subroutine

  ! tao_spin_polarization_struct%integral_dn2: 0D_NOT_real

  subroutine tao_spin_polarization_struct_get_integral_dn2(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_integral_dn2')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%integral_dn2
  end subroutine

  ! tao_spin_polarization_struct%valid: 0D_NOT_logical

  subroutine tao_spin_polarization_struct_get_valid(struct_obj_ptr, value_out) bind(c, name='tao_spin_polarization_struct_get_valid')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%valid
  end subroutine

  ! tao_spin_polarization_struct%q_1turn: 0D_NOT_type

  subroutine tao_spin_polarization_struct_get_q_1turn(struct_obj_ptr, ptr_out) bind(c, name='tao_spin_polarization_struct_get_q_1turn')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%q_1turn)
  end subroutine

  ! tao_spin_polarization_struct%q_ele: 1D_ALLOC_type

  subroutine tao_spin_polarization_struct_get_q_ele_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_spin_polarization_struct_get_q_ele_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_spin_polarization_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%q_ele)) then
      data_ptr = c_loc(struct_obj%q_ele(lbound(struct_obj%q_ele, 1)))
      lower_bound = int(lbound(struct_obj%q_ele, 1), c_int)
      upper_bound = int(ubound(struct_obj%q_ele, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%q_ele(lbound(struct_obj%q_ele, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! tao_lattice_branch_struct
  ! tao_lattice_branch_struct%lat_sigma: 1D_ALLOC_type

  subroutine tao_lattice_branch_struct_get_lat_sigma_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_branch_struct_get_lat_sigma_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%lat_sigma)) then
      data_ptr = c_loc(struct_obj%lat_sigma(lbound(struct_obj%lat_sigma, 1)))
      lower_bound = int(lbound(struct_obj%lat_sigma, 1), c_int)
      upper_bound = int(ubound(struct_obj%lat_sigma, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%lat_sigma(lbound(struct_obj%lat_sigma, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_lattice_branch_struct%spin_ele: 1D_ALLOC_type

  subroutine tao_lattice_branch_struct_get_spin_ele_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_branch_struct_get_spin_ele_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%spin_ele)) then
      data_ptr = c_loc(struct_obj%spin_ele(lbound(struct_obj%spin_ele, 1)))
      lower_bound = int(lbound(struct_obj%spin_ele, 1), c_int)
      upper_bound = int(ubound(struct_obj%spin_ele, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%spin_ele(lbound(struct_obj%spin_ele, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_lattice_branch_struct%bunch_params: 1D_ALLOC_type

  subroutine tao_lattice_branch_struct_get_bunch_params_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_branch_struct_get_bunch_params_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%bunch_params)) then
      data_ptr = c_loc(struct_obj%bunch_params(lbound(struct_obj%bunch_params, 1)))
      lower_bound = int(lbound(struct_obj%bunch_params, 1), c_int)
      upper_bound = int(ubound(struct_obj%bunch_params, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%bunch_params(lbound(struct_obj%bunch_params, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_lattice_branch_struct%bunch_params_comb: 1D_ALLOC_type

  subroutine tao_lattice_branch_struct_get_bunch_params_comb_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_branch_struct_get_bunch_params_comb_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%bunch_params_comb)) then
      data_ptr = c_loc(struct_obj%bunch_params_comb(lbound(struct_obj%bunch_params_comb, 1)))
      lower_bound = int(lbound(struct_obj%bunch_params_comb, 1), c_int)
      upper_bound = int(ubound(struct_obj%bunch_params_comb, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%bunch_params_comb(lbound(struct_obj%bunch_params_comb, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_lattice_branch_struct%orbit: 1D_ALLOC_type

  subroutine tao_lattice_branch_struct_get_orbit_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_branch_struct_get_orbit_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%orbit)) then
      data_ptr = c_loc(struct_obj%orbit(lbound(struct_obj%orbit, 1)))
      lower_bound = int(lbound(struct_obj%orbit, 1), c_int)
      upper_bound = int(ubound(struct_obj%orbit, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%orbit(lbound(struct_obj%orbit, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_lattice_branch_struct%plot_cache: 1D_ALLOC_type

  subroutine tao_lattice_branch_struct_get_plot_cache_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_branch_struct_get_plot_cache_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%plot_cache)) then
      data_ptr = c_loc(struct_obj%plot_cache(lbound(struct_obj%plot_cache, 1)))
      lower_bound = int(lbound(struct_obj%plot_cache, 1), c_int)
      upper_bound = int(ubound(struct_obj%plot_cache, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%plot_cache(lbound(struct_obj%plot_cache, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_lattice_branch_struct%spin: 0D_NOT_type

  subroutine tao_lattice_branch_struct_get_spin(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_branch_struct_get_spin')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%spin)
  end subroutine

  ! tao_lattice_branch_struct%srdt: 0D_NOT_type

  subroutine tao_lattice_branch_struct_get_srdt(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_branch_struct_get_srdt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%srdt)
  end subroutine

  ! tao_lattice_branch_struct%orb0: 0D_NOT_type

  subroutine tao_lattice_branch_struct_get_orb0(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_branch_struct_get_orb0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%orb0)
  end subroutine

  ! tao_lattice_branch_struct%modes_ri: 0D_NOT_type

  subroutine tao_lattice_branch_struct_get_modes_ri(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_branch_struct_get_modes_ri')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%modes_ri)
  end subroutine

  ! tao_lattice_branch_struct%modes_6d: 0D_NOT_type

  subroutine tao_lattice_branch_struct_get_modes_6d(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_branch_struct_get_modes_6d')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%modes_6d)
  end subroutine

  ! tao_lattice_branch_struct%ptc_normal_form: 0D_NOT_type

  subroutine tao_lattice_branch_struct_get_ptc_normal_form(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_branch_struct_get_ptc_normal_form')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ptc_normal_form)
  end subroutine

  ! tao_lattice_branch_struct%bmad_normal_form: 0D_NOT_type

  subroutine tao_lattice_branch_struct_get_bmad_normal_form(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_branch_struct_get_bmad_normal_form')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%bmad_normal_form)
  end subroutine

  ! tao_lattice_branch_struct%high_E_orb: 1D_ALLOC_type

  subroutine tao_lattice_branch_struct_get_high_E_orb_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_branch_struct_get_high_E_orb_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%high_E_orb)) then
      data_ptr = c_loc(struct_obj%high_E_orb(lbound(struct_obj%high_E_orb, 1)))
      lower_bound = int(lbound(struct_obj%high_E_orb, 1), c_int)
      upper_bound = int(ubound(struct_obj%high_E_orb, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%high_E_orb(lbound(struct_obj%high_E_orb, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_lattice_branch_struct%low_E_orb: 1D_ALLOC_type

  subroutine tao_lattice_branch_struct_get_low_E_orb_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_branch_struct_get_low_E_orb_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%low_E_orb)) then
      data_ptr = c_loc(struct_obj%low_E_orb(lbound(struct_obj%low_E_orb, 1)))
      lower_bound = int(lbound(struct_obj%low_E_orb, 1), c_int)
      upper_bound = int(ubound(struct_obj%low_E_orb, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%low_E_orb(lbound(struct_obj%low_E_orb, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_lattice_branch_struct%cache_x_min: 0D_NOT_real

  subroutine tao_lattice_branch_struct_get_cache_x_min(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_cache_x_min')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%cache_x_min
  end subroutine

  ! tao_lattice_branch_struct%cache_x_max: 0D_NOT_real

  subroutine tao_lattice_branch_struct_get_cache_x_max(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_cache_x_max')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%cache_x_max
  end subroutine

  ! tao_lattice_branch_struct%comb_ds_save: 0D_NOT_real

  subroutine tao_lattice_branch_struct_get_comb_ds_save(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_comb_ds_save')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%comb_ds_save
  end subroutine

  ! tao_lattice_branch_struct%track_state: 0D_NOT_integer

  subroutine tao_lattice_branch_struct_get_track_state(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_track_state')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%track_state
  end subroutine

  ! tao_lattice_branch_struct%cache_n_pts: 0D_NOT_integer

  subroutine tao_lattice_branch_struct_get_cache_n_pts(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_cache_n_pts')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%cache_n_pts
  end subroutine

  ! tao_lattice_branch_struct%ix_rad_int_cache: 0D_NOT_integer

  subroutine tao_lattice_branch_struct_get_ix_rad_int_cache(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_ix_rad_int_cache')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_rad_int_cache
  end subroutine

  ! tao_lattice_branch_struct%has_open_match_element: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_has_open_match_element(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_has_open_match_element')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%has_open_match_element
  end subroutine

  ! tao_lattice_branch_struct%plot_cache_valid: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_plot_cache_valid(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_plot_cache_valid')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%plot_cache_valid
  end subroutine

  ! tao_lattice_branch_struct%spin_map_valid: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_spin_map_valid(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_spin_map_valid')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_map_valid
  end subroutine

  ! tao_lattice_branch_struct%twiss_valid: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_twiss_valid(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_twiss_valid')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%twiss_valid
  end subroutine

  ! tao_lattice_branch_struct%mode_flip_here: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_mode_flip_here(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_mode_flip_here')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%mode_flip_here
  end subroutine

  ! tao_lattice_branch_struct%chrom_calc_ok: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_chrom_calc_ok(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_chrom_calc_ok')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom_calc_ok
  end subroutine

  ! tao_lattice_branch_struct%rad_int_calc_ok: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_rad_int_calc_ok(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_rad_int_calc_ok')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rad_int_calc_ok
  end subroutine

  ! tao_lattice_branch_struct%emit_6d_calc_ok: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_emit_6d_calc_ok(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_emit_6d_calc_ok')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%emit_6d_calc_ok
  end subroutine

  ! tao_lattice_branch_struct%sigma_track_ok: 0D_NOT_logical

  subroutine tao_lattice_branch_struct_get_sigma_track_ok(struct_obj_ptr, value_out) bind(c, name='tao_lattice_branch_struct_get_sigma_track_ok')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_lattice_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%sigma_track_ok
  end subroutine

  !! tao_model_element_struct
  ! tao_model_element_struct%beam: 0D_NOT_type

  subroutine tao_model_element_struct_get_beam(struct_obj_ptr, ptr_out) bind(c, name='tao_model_element_struct_get_beam')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_model_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam)
  end subroutine

  ! tao_model_element_struct%save_beam_internally: 0D_NOT_logical

  subroutine tao_model_element_struct_get_save_beam_internally(struct_obj_ptr, value_out) bind(c, name='tao_model_element_struct_get_save_beam_internally')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_model_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%save_beam_internally
  end subroutine

  ! tao_model_element_struct%save_beam_to_file: 0D_NOT_logical

  subroutine tao_model_element_struct_get_save_beam_to_file(struct_obj_ptr, value_out) bind(c, name='tao_model_element_struct_get_save_beam_to_file')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_model_element_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%save_beam_to_file
  end subroutine

  !! tao_beam_branch_struct
  ! tao_beam_branch_struct%beam_at_start: 0D_NOT_type

  subroutine tao_beam_branch_struct_get_beam_at_start(struct_obj_ptr, ptr_out) bind(c, name='tao_beam_branch_struct_get_beam_at_start')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_beam_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam_at_start)
  end subroutine

  ! tao_beam_branch_struct%beam_init: 0D_NOT_type

  subroutine tao_beam_branch_struct_get_beam_init(struct_obj_ptr, ptr_out) bind(c, name='tao_beam_branch_struct_get_beam_init')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_beam_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam_init)
  end subroutine

  ! tao_beam_branch_struct%beam_init_used: 0D_NOT_type

  subroutine tao_beam_branch_struct_get_beam_init_used(struct_obj_ptr, ptr_out) bind(c, name='tao_beam_branch_struct_get_beam_init_used')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_beam_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam_init_used)
  end subroutine

  ! tao_beam_branch_struct%init_starting_distribution: 0D_NOT_logical

  subroutine tao_beam_branch_struct_get_init_starting_distribution(struct_obj_ptr, value_out) bind(c, name='tao_beam_branch_struct_get_init_starting_distribution')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_beam_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%init_starting_distribution
  end subroutine

  ! tao_beam_branch_struct%track_start: 0D_NOT_character

  subroutine tao_beam_branch_struct_get_track_start_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_beam_branch_struct_get_track_start_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_beam_branch_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%track_start)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%track_start), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_beam_branch_struct%track_end: 0D_NOT_character

  subroutine tao_beam_branch_struct_get_track_end_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_beam_branch_struct_get_track_end_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_beam_branch_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%track_end)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%track_end), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_beam_branch_struct%ix_branch: 0D_NOT_integer

  subroutine tao_beam_branch_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='tao_beam_branch_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_beam_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  ! tao_beam_branch_struct%ix_track_start: 0D_NOT_integer

  subroutine tao_beam_branch_struct_get_ix_track_start(struct_obj_ptr, value_out) bind(c, name='tao_beam_branch_struct_get_ix_track_start')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_beam_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_track_start
  end subroutine

  ! tao_beam_branch_struct%ix_track_end: 0D_NOT_integer

  subroutine tao_beam_branch_struct_get_ix_track_end(struct_obj_ptr, value_out) bind(c, name='tao_beam_branch_struct_get_ix_track_end')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_beam_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_track_end
  end subroutine

  !! tao_d1_data_struct
  ! tao_d1_data_struct%name: 0D_NOT_character

  subroutine tao_d1_data_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_d1_data_struct_get_name_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_d1_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  !! tao_lattice_struct
  ! tao_lattice_struct%name: 0D_NOT_character

  subroutine tao_lattice_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_lattice_struct_get_name_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_lattice_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_lattice_struct%lat: 0D_NOT_type

  subroutine tao_lattice_struct_get_lat(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_struct_get_lat')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%lat)
  end subroutine

  ! tao_lattice_struct%high_E_lat: 0D_NOT_type

  subroutine tao_lattice_struct_get_high_E_lat(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_struct_get_high_E_lat')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%high_E_lat)
  end subroutine

  ! tao_lattice_struct%low_E_lat: 0D_NOT_type

  subroutine tao_lattice_struct_get_low_E_lat(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_struct_get_low_E_lat')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%low_E_lat)
  end subroutine

  ! tao_lattice_struct%rad_int_by_ele_ri: 0D_NOT_type

  subroutine tao_lattice_struct_get_rad_int_by_ele_ri(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_struct_get_rad_int_by_ele_ri')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%rad_int_by_ele_ri)
  end subroutine

  ! tao_lattice_struct%rad_int_by_ele_6d: 0D_NOT_type

  subroutine tao_lattice_struct_get_rad_int_by_ele_6d(struct_obj_ptr, ptr_out) bind(c, name='tao_lattice_struct_get_rad_int_by_ele_6d')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_lattice_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%rad_int_by_ele_6d)
  end subroutine

  ! tao_lattice_struct%tao_branch: 1D_ALLOC_type

  subroutine tao_lattice_struct_get_tao_branch_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_lattice_struct_get_tao_branch_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_lattice_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%tao_branch)) then
      data_ptr = c_loc(struct_obj%tao_branch(lbound(struct_obj%tao_branch, 1)))
      lower_bound = int(lbound(struct_obj%tao_branch, 1), c_int)
      upper_bound = int(ubound(struct_obj%tao_branch, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%tao_branch(lbound(struct_obj%tao_branch, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! tao_beam_uni_struct
  ! tao_beam_uni_struct%saved_at: 0D_NOT_character

  subroutine tao_beam_uni_struct_get_saved_at_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_beam_uni_struct_get_saved_at_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_beam_uni_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%saved_at)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%saved_at), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_beam_uni_struct%dump_file: 0D_NOT_character

  subroutine tao_beam_uni_struct_get_dump_file_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_beam_uni_struct_get_dump_file_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_beam_uni_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%dump_file)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%dump_file), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_beam_uni_struct%dump_at: 0D_NOT_character

  subroutine tao_beam_uni_struct_get_dump_at_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_beam_uni_struct_get_dump_at_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_beam_uni_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%dump_at)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%dump_at), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_beam_uni_struct%track_beam_in_universe: 0D_NOT_logical

  subroutine tao_beam_uni_struct_get_track_beam_in_universe(struct_obj_ptr, value_out) bind(c, name='tao_beam_uni_struct_get_track_beam_in_universe')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_beam_uni_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%track_beam_in_universe
  end subroutine

  ! tao_beam_uni_struct%always_reinit: 0D_NOT_logical

  subroutine tao_beam_uni_struct_get_always_reinit(struct_obj_ptr, value_out) bind(c, name='tao_beam_uni_struct_get_always_reinit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_beam_uni_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%always_reinit
  end subroutine

  !! tao_dynamic_aperture_struct
  ! tao_dynamic_aperture_struct%param: 0D_NOT_type

  subroutine tao_dynamic_aperture_struct_get_param(struct_obj_ptr, ptr_out) bind(c, name='tao_dynamic_aperture_struct_get_param')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_dynamic_aperture_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%param)
  end subroutine

  ! tao_dynamic_aperture_struct%scan: 1D_ALLOC_type

  subroutine tao_dynamic_aperture_struct_get_scan_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_dynamic_aperture_struct_get_scan_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_dynamic_aperture_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%scan)) then
      data_ptr = c_loc(struct_obj%scan(lbound(struct_obj%scan, 1)))
      lower_bound = int(lbound(struct_obj%scan, 1), c_int)
      upper_bound = int(ubound(struct_obj%scan, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%scan(lbound(struct_obj%scan, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_dynamic_aperture_struct%pz: 1D_ALLOC_real

  subroutine tao_dynamic_aperture_struct_get_pz_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='tao_dynamic_aperture_struct_get_pz_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(tao_dynamic_aperture_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%pz)) then
      data_ptr = c_loc(struct_obj%pz(lbound(struct_obj%pz, 1)))
      lower_bound = int(lbound(struct_obj%pz, 1), c_int)
      upper_bound = int(ubound(struct_obj%pz, 1), c_int)
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

  ! tao_dynamic_aperture_struct%ellipse_scale: 0D_NOT_real

  subroutine tao_dynamic_aperture_struct_get_ellipse_scale(struct_obj_ptr, value_out) bind(c, name='tao_dynamic_aperture_struct_get_ellipse_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_dynamic_aperture_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ellipse_scale
  end subroutine

  ! tao_dynamic_aperture_struct%a_emit: 0D_NOT_real

  subroutine tao_dynamic_aperture_struct_get_a_emit(struct_obj_ptr, value_out) bind(c, name='tao_dynamic_aperture_struct_get_a_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_dynamic_aperture_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_emit
  end subroutine

  ! tao_dynamic_aperture_struct%b_emit: 0D_NOT_real

  subroutine tao_dynamic_aperture_struct_get_b_emit(struct_obj_ptr, value_out) bind(c, name='tao_dynamic_aperture_struct_get_b_emit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_dynamic_aperture_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_emit
  end subroutine

  !! tao_model_branch_struct
  ! tao_model_branch_struct%ele: 1D_ALLOC_type

  subroutine tao_model_branch_struct_get_ele_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_model_branch_struct_get_ele_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_model_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%ele)) then
      data_ptr = c_loc(struct_obj%ele(lbound(struct_obj%ele, 1)))
      lower_bound = int(lbound(struct_obj%ele, 1), c_int)
      upper_bound = int(ubound(struct_obj%ele, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%ele(lbound(struct_obj%ele, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_model_branch_struct%beam: 0D_NOT_type

  subroutine tao_model_branch_struct_get_beam(struct_obj_ptr, ptr_out) bind(c, name='tao_model_branch_struct_get_beam')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_model_branch_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam)
  end subroutine

  !! tao_d2_data_struct
  ! tao_d2_data_struct%name: 0D_NOT_character

  subroutine tao_d2_data_struct_get_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_d2_data_struct_get_name_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_d2_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_d2_data_struct%data_file_name: 0D_NOT_character

  subroutine tao_d2_data_struct_get_data_file_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_d2_data_struct_get_data_file_name_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_d2_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%data_file_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%data_file_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_d2_data_struct%ref_file_name: 0D_NOT_character

  subroutine tao_d2_data_struct_get_ref_file_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_d2_data_struct_get_ref_file_name_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_d2_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ref_file_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%ref_file_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_d2_data_struct%data_date: 0D_NOT_character

  subroutine tao_d2_data_struct_get_data_date_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_d2_data_struct_get_data_date_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_d2_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%data_date)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%data_date), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_d2_data_struct%ref_date: 0D_NOT_character

  subroutine tao_d2_data_struct_get_ref_date_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_d2_data_struct_get_ref_date_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_d2_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ref_date)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%ref_date), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! skipped tao_d2_data_struct%descrip: Unsupported type: 1D_NOT_character
  ! tao_d2_data_struct%d1: 1D_ALLOC_type

  subroutine tao_d2_data_struct_get_d1_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_d2_data_struct_get_d1_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_d2_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%d1)) then
      data_ptr = c_loc(struct_obj%d1(lbound(struct_obj%d1, 1)))
      lower_bound = int(lbound(struct_obj%d1, 1), c_int)
      upper_bound = int(ubound(struct_obj%d1, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%d1(lbound(struct_obj%d1, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_d2_data_struct%ix_universe: 0D_NOT_integer

  subroutine tao_d2_data_struct_get_ix_universe(struct_obj_ptr, value_out) bind(c, name='tao_d2_data_struct_get_ix_universe')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_d2_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_universe
  end subroutine

  ! tao_d2_data_struct%ix_d2_data: 0D_NOT_integer

  subroutine tao_d2_data_struct_get_ix_d2_data(struct_obj_ptr, value_out) bind(c, name='tao_d2_data_struct_get_ix_d2_data')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_d2_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_d2_data
  end subroutine

  ! tao_d2_data_struct%ix_ref: 0D_NOT_integer

  subroutine tao_d2_data_struct_get_ix_ref(struct_obj_ptr, value_out) bind(c, name='tao_d2_data_struct_get_ix_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_d2_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ref
  end subroutine

  ! tao_d2_data_struct%data_read_in: 0D_NOT_logical

  subroutine tao_d2_data_struct_get_data_read_in(struct_obj_ptr, value_out) bind(c, name='tao_d2_data_struct_get_data_read_in')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_d2_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%data_read_in
  end subroutine

  ! tao_d2_data_struct%ref_read_in: 0D_NOT_logical

  subroutine tao_d2_data_struct_get_ref_read_in(struct_obj_ptr, value_out) bind(c, name='tao_d2_data_struct_get_ref_read_in')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_d2_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref_read_in
  end subroutine

  !! tao_spin_map_struct
  ! tao_spin_map_struct%valid: 0D_NOT_logical

  subroutine tao_spin_map_struct_get_valid(struct_obj_ptr, value_out) bind(c, name='tao_spin_map_struct_get_valid')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%valid
  end subroutine

  ! tao_spin_map_struct%map1: 0D_NOT_type

  subroutine tao_spin_map_struct_get_map1(struct_obj_ptr, ptr_out) bind(c, name='tao_spin_map_struct_get_map1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%map1)
  end subroutine

  ! tao_spin_map_struct%axis_input: 0D_NOT_type

  subroutine tao_spin_map_struct_get_axis_input(struct_obj_ptr, ptr_out) bind(c, name='tao_spin_map_struct_get_axis_input')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%axis_input)
  end subroutine

  ! tao_spin_map_struct%axis0: 0D_NOT_type

  subroutine tao_spin_map_struct_get_axis0(struct_obj_ptr, ptr_out) bind(c, name='tao_spin_map_struct_get_axis0')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%axis0)
  end subroutine

  ! tao_spin_map_struct%axis1: 0D_NOT_type

  subroutine tao_spin_map_struct_get_axis1(struct_obj_ptr, ptr_out) bind(c, name='tao_spin_map_struct_get_axis1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%axis1)
  end subroutine

  ! tao_spin_map_struct%ix_ele: 0D_NOT_integer

  subroutine tao_spin_map_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='tao_spin_map_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! tao_spin_map_struct%ix_ref: 0D_NOT_integer

  subroutine tao_spin_map_struct_get_ix_ref(struct_obj_ptr, value_out) bind(c, name='tao_spin_map_struct_get_ix_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ref
  end subroutine

  ! tao_spin_map_struct%ix_uni: 0D_NOT_integer

  subroutine tao_spin_map_struct_get_ix_uni(struct_obj_ptr, value_out) bind(c, name='tao_spin_map_struct_get_ix_uni')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_uni
  end subroutine

  ! tao_spin_map_struct%ix_branch: 0D_NOT_integer

  subroutine tao_spin_map_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='tao_spin_map_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_spin_map_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  ! skipped tao_spin_map_struct%mat8: Unsupported type: 2D_NOT_real
  !! tao_data_struct
  ! tao_data_struct%ele_name: 0D_NOT_character

  subroutine tao_data_struct_get_ele_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_data_struct_get_ele_name_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ele_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%ele_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_data_struct%ele_start_name: 0D_NOT_character

  subroutine tao_data_struct_get_ele_start_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_data_struct_get_ele_start_name_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ele_start_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%ele_start_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_data_struct%ele_ref_name: 0D_NOT_character

  subroutine tao_data_struct_get_ele_ref_name_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_data_struct_get_ele_ref_name_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%ele_ref_name)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%ele_ref_name), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_data_struct%merit_type: 0D_NOT_character

  subroutine tao_data_struct_get_merit_type_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_data_struct_get_merit_type_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%merit_type)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%merit_type), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_data_struct%id: 0D_NOT_character

  subroutine tao_data_struct_get_id_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_data_struct_get_id_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%id)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%id), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_data_struct%data_source: 0D_NOT_character

  subroutine tao_data_struct_get_data_source_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_data_struct_get_data_source_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%data_source)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%data_source), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_data_struct%why_invalid: 0D_NOT_character

  subroutine tao_data_struct_get_why_invalid_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='tao_data_struct_get_why_invalid_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(tao_data_struct), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%why_invalid)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%why_invalid), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine

  ! tao_data_struct%ix_uni: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_uni(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_uni')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_uni
  end subroutine

  ! tao_data_struct%ix_bunch: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_bunch(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_bunch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_bunch
  end subroutine

  ! tao_data_struct%ix_branch: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_branch(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_branch')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_branch
  end subroutine

  ! tao_data_struct%ix_ele: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_ele(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_ele')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele
  end subroutine

  ! tao_data_struct%ix_ele_start: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_ele_start(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_ele_start')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele_start
  end subroutine

  ! tao_data_struct%ix_ele_ref: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_ele_ref(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_ele_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele_ref
  end subroutine

  ! tao_data_struct%ix_ele_merit: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_ele_merit(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_ele_merit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_ele_merit
  end subroutine

  ! tao_data_struct%ix_d1: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_d1(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_d1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_d1
  end subroutine

  ! tao_data_struct%ix_data: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_data(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_data')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_data
  end subroutine

  ! tao_data_struct%ix_dModel: 0D_NOT_integer

  subroutine tao_data_struct_get_ix_dModel(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ix_dModel')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_dModel
  end subroutine

  ! tao_data_struct%eval_point: 0D_NOT_integer

  subroutine tao_data_struct_get_eval_point(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_eval_point')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%eval_point
  end subroutine

  ! tao_data_struct%meas_value: 0D_NOT_real

  subroutine tao_data_struct_get_meas_value(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_meas_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%meas_value
  end subroutine

  ! tao_data_struct%ref_value: 0D_NOT_real

  subroutine tao_data_struct_get_ref_value(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_ref_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ref_value
  end subroutine

  ! tao_data_struct%model_value: 0D_NOT_real

  subroutine tao_data_struct_get_model_value(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_model_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%model_value
  end subroutine

  ! tao_data_struct%design_value: 0D_NOT_real

  subroutine tao_data_struct_get_design_value(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_design_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%design_value
  end subroutine

  ! tao_data_struct%old_value: 0D_NOT_real

  subroutine tao_data_struct_get_old_value(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_old_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%old_value
  end subroutine

  ! tao_data_struct%base_value: 0D_NOT_real

  subroutine tao_data_struct_get_base_value(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_base_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%base_value
  end subroutine

  ! tao_data_struct%error_rms: 0D_NOT_real

  subroutine tao_data_struct_get_error_rms(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_error_rms')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%error_rms
  end subroutine

  ! tao_data_struct%delta_merit: 0D_NOT_real

  subroutine tao_data_struct_get_delta_merit(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_delta_merit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%delta_merit
  end subroutine

  ! tao_data_struct%weight: 0D_NOT_real

  subroutine tao_data_struct_get_weight(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_weight')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%weight
  end subroutine

  ! tao_data_struct%invalid_value: 0D_NOT_real

  subroutine tao_data_struct_get_invalid_value(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_invalid_value')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%invalid_value
  end subroutine

  ! tao_data_struct%merit: 0D_NOT_real

  subroutine tao_data_struct_get_merit(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_merit')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%merit
  end subroutine

  ! tao_data_struct%s: 0D_NOT_real

  subroutine tao_data_struct_get_s(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_s')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s
  end subroutine

  ! tao_data_struct%s_offset: 0D_NOT_real

  subroutine tao_data_struct_get_s_offset(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_s_offset')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%s_offset
  end subroutine

  ! tao_data_struct%err_message_printed: 0D_NOT_logical

  subroutine tao_data_struct_get_err_message_printed(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_err_message_printed')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%err_message_printed
  end subroutine

  ! tao_data_struct%exists: 0D_NOT_logical

  subroutine tao_data_struct_get_exists(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_exists')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%exists
  end subroutine

  ! tao_data_struct%good_model: 0D_NOT_logical

  subroutine tao_data_struct_get_good_model(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_good_model')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%good_model
  end subroutine

  ! tao_data_struct%good_base: 0D_NOT_logical

  subroutine tao_data_struct_get_good_base(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_good_base')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%good_base
  end subroutine

  ! tao_data_struct%good_design: 0D_NOT_logical

  subroutine tao_data_struct_get_good_design(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_good_design')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%good_design
  end subroutine

  ! tao_data_struct%good_meas: 0D_NOT_logical

  subroutine tao_data_struct_get_good_meas(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_good_meas')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%good_meas
  end subroutine

  ! tao_data_struct%good_ref: 0D_NOT_logical

  subroutine tao_data_struct_get_good_ref(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_good_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%good_ref
  end subroutine

  ! tao_data_struct%good_user: 0D_NOT_logical

  subroutine tao_data_struct_get_good_user(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_good_user')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%good_user
  end subroutine

  ! tao_data_struct%good_opt: 0D_NOT_logical

  subroutine tao_data_struct_get_good_opt(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_good_opt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%good_opt
  end subroutine

  ! tao_data_struct%good_plot: 0D_NOT_logical

  subroutine tao_data_struct_get_good_plot(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_good_plot')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%good_plot
  end subroutine

  ! tao_data_struct%useit_plot: 0D_NOT_logical

  subroutine tao_data_struct_get_useit_plot(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_useit_plot')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%useit_plot
  end subroutine

  ! tao_data_struct%useit_opt: 0D_NOT_logical

  subroutine tao_data_struct_get_useit_opt(struct_obj_ptr, value_out) bind(c, name='tao_data_struct_get_useit_opt')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%useit_opt
  end subroutine

  ! tao_data_struct%spin_map: 0D_NOT_type

  subroutine tao_data_struct_get_spin_map(struct_obj_ptr, ptr_out) bind(c, name='tao_data_struct_get_spin_map')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%spin_map)
  end subroutine

  ! tao_data_struct%d1: 0D_PTR_type

  subroutine tao_data_struct_get_d1(struct_obj_ptr, ptr_out) bind(c, name='tao_data_struct_get_d1')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_data_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%d1)) then
      ptr_out = c_loc(struct_obj%d1)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

  !! tao_ping_scale_struct
  ! tao_ping_scale_struct%a_mode_meas: 0D_NOT_real

  subroutine tao_ping_scale_struct_get_a_mode_meas(struct_obj_ptr, value_out) bind(c, name='tao_ping_scale_struct_get_a_mode_meas')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_ping_scale_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_mode_meas
  end subroutine

  ! tao_ping_scale_struct%a_mode_ref: 0D_NOT_real

  subroutine tao_ping_scale_struct_get_a_mode_ref(struct_obj_ptr, value_out) bind(c, name='tao_ping_scale_struct_get_a_mode_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_ping_scale_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%a_mode_ref
  end subroutine

  ! tao_ping_scale_struct%b_mode_meas: 0D_NOT_real

  subroutine tao_ping_scale_struct_get_b_mode_meas(struct_obj_ptr, value_out) bind(c, name='tao_ping_scale_struct_get_b_mode_meas')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_ping_scale_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_mode_meas
  end subroutine

  ! tao_ping_scale_struct%b_mode_ref: 0D_NOT_real

  subroutine tao_ping_scale_struct_get_b_mode_ref(struct_obj_ptr, value_out) bind(c, name='tao_ping_scale_struct_get_b_mode_ref')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(tao_ping_scale_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%b_mode_ref
  end subroutine

  !! tao_universe_calc_struct
  ! tao_universe_calc_struct%srdt_for_data: 0D_NOT_integer

  subroutine tao_universe_calc_struct_get_srdt_for_data(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_srdt_for_data')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%srdt_for_data
  end subroutine

  ! tao_universe_calc_struct%rad_int_for_data: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_rad_int_for_data(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_rad_int_for_data')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rad_int_for_data
  end subroutine

  ! tao_universe_calc_struct%rad_int_for_plotting: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_rad_int_for_plotting(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_rad_int_for_plotting')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%rad_int_for_plotting
  end subroutine

  ! tao_universe_calc_struct%chrom_for_data: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_chrom_for_data(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_chrom_for_data')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom_for_data
  end subroutine

  ! tao_universe_calc_struct%chrom_for_plotting: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_chrom_for_plotting(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_chrom_for_plotting')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%chrom_for_plotting
  end subroutine

  ! tao_universe_calc_struct%lat_sigma_for_data: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_lat_sigma_for_data(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_lat_sigma_for_data')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lat_sigma_for_data
  end subroutine

  ! tao_universe_calc_struct%lat_sigma_for_plotting: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_lat_sigma_for_plotting(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_lat_sigma_for_plotting')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lat_sigma_for_plotting
  end subroutine

  ! tao_universe_calc_struct%dynamic_aperture: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_dynamic_aperture(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_dynamic_aperture')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%dynamic_aperture
  end subroutine

  ! tao_universe_calc_struct%one_turn_map: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_one_turn_map(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_one_turn_map')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%one_turn_map
  end subroutine

  ! tao_universe_calc_struct%lattice: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_lattice(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_lattice')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%lattice
  end subroutine

  ! tao_universe_calc_struct%twiss: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_twiss(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_twiss')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%twiss
  end subroutine

  ! tao_universe_calc_struct%track: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_track(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_track')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%track
  end subroutine

  ! tao_universe_calc_struct%spin_matrices: 0D_NOT_logical

  subroutine tao_universe_calc_struct_get_spin_matrices(struct_obj_ptr, value_out) bind(c, name='tao_universe_calc_struct_get_spin_matrices')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_calc_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%spin_matrices
  end subroutine

  !! lat_ele_order_struct
  ! lat_ele_order_struct%branch: 1D_ALLOC_type

  subroutine lat_ele_order_struct_get_branch_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='lat_ele_order_struct_get_branch_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(lat_ele_order_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%branch)) then
      data_ptr = c_loc(struct_obj%branch(lbound(struct_obj%branch, 1)))
      lower_bound = int(lbound(struct_obj%branch, 1), c_int)
      upper_bound = int(ubound(struct_obj%branch, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%branch(lbound(struct_obj%branch, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  !! tao_universe_struct
  ! tao_universe_struct%model: 0D_PTR_type

  subroutine tao_universe_struct_get_model(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_model')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%model)) then
      ptr_out = c_loc(struct_obj%model)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

  ! tao_universe_struct%design: 0D_PTR_type

  subroutine tao_universe_struct_get_design(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_design')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%design)) then
      ptr_out = c_loc(struct_obj%design)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

  ! tao_universe_struct%base: 0D_PTR_type

  subroutine tao_universe_struct_get_base(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_base')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%base)) then
      ptr_out = c_loc(struct_obj%base)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine

  ! tao_universe_struct%beam: 0D_NOT_type

  subroutine tao_universe_struct_get_beam(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_beam')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%beam)
  end subroutine

  ! tao_universe_struct%dynamic_aperture: 0D_NOT_type

  subroutine tao_universe_struct_get_dynamic_aperture(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_dynamic_aperture')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%dynamic_aperture)
  end subroutine

  ! tao_universe_struct%model_branch: 1D_PTR_type

  subroutine tao_universe_struct_get_model_branch_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_universe_struct_get_model_branch_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%model_branch)) then
      data_ptr = c_loc(struct_obj%model_branch(lbound(struct_obj%model_branch, 1)))
      lower_bound = int(lbound(struct_obj%model_branch, 1), c_int)
      upper_bound = int(ubound(struct_obj%model_branch, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%model_branch(lbound(struct_obj%model_branch, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_universe_struct%d2_data: 1D_ALLOC_type

  subroutine tao_universe_struct_get_d2_data_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_universe_struct_get_d2_data_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%d2_data)) then
      data_ptr = c_loc(struct_obj%d2_data(lbound(struct_obj%d2_data, 1)))
      lower_bound = int(lbound(struct_obj%d2_data, 1), c_int)
      upper_bound = int(ubound(struct_obj%d2_data, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%d2_data(lbound(struct_obj%d2_data, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_universe_struct%data: 1D_ALLOC_type

  subroutine tao_universe_struct_get_data_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='tao_universe_struct_get_data_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%data)) then
      data_ptr = c_loc(struct_obj%data(lbound(struct_obj%data, 1)))
      lower_bound = int(lbound(struct_obj%data, 1), c_int)
      upper_bound = int(ubound(struct_obj%data, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%data(lbound(struct_obj%data, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine

  ! tao_universe_struct%ping_scale: 0D_NOT_type

  subroutine tao_universe_struct_get_ping_scale(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_ping_scale')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ping_scale)
  end subroutine

  ! tao_universe_struct%scratch_lat: 0D_NOT_type

  subroutine tao_universe_struct_get_scratch_lat(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_scratch_lat')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%scratch_lat)
  end subroutine

  ! tao_universe_struct%calc: 0D_NOT_type

  subroutine tao_universe_struct_get_calc(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_calc')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%calc)
  end subroutine

  ! tao_universe_struct%ele_order: 0D_NOT_type

  subroutine tao_universe_struct_get_ele_order(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_ele_order')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%ele_order)
  end subroutine

  ! tao_universe_struct%spin_map: 0D_NOT_type

  subroutine tao_universe_struct_get_spin_map(struct_obj_ptr, ptr_out) bind(c, name='tao_universe_struct_get_spin_map')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%spin_map)
  end subroutine

  ! tao_universe_struct%dModel_dVar: 2D_ALLOC_real

  subroutine tao_universe_struct_get_dModel_dVar_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c, name='tao_universe_struct_get_dModel_dVar_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    logical(c_bool), intent(out) :: is_allocated
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%dModel_dVar)) then
      data_ptr = c_loc(struct_obj%dModel_dVar(lbound(struct_obj%dModel_dVar,1), lbound(struct_obj%dModel_dVar,2)))
      
      dim1_lower = int(lbound(struct_obj%dModel_dVar, 1), c_int)
      dim1_upper = int(ubound(struct_obj%dModel_dVar, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      
      dim2_lower = int(lbound(struct_obj%dModel_dVar, 2), c_int)
      dim2_upper = int(ubound(struct_obj%dModel_dVar, 2), c_int)
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

  ! tao_universe_struct%ix_uni: 0D_NOT_integer

  subroutine tao_universe_struct_get_ix_uni(struct_obj_ptr, value_out) bind(c, name='tao_universe_struct_get_ix_uni')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%ix_uni
  end subroutine

  ! tao_universe_struct%n_d2_data_used: 0D_NOT_integer

  subroutine tao_universe_struct_get_n_d2_data_used(struct_obj_ptr, value_out) bind(c, name='tao_universe_struct_get_n_d2_data_used')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_d2_data_used
  end subroutine

  ! tao_universe_struct%n_data_used: 0D_NOT_integer

  subroutine tao_universe_struct_get_n_data_used(struct_obj_ptr, value_out) bind(c, name='tao_universe_struct_get_n_data_used')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%n_data_used
  end subroutine

  ! tao_universe_struct%is_on: 0D_NOT_logical

  subroutine tao_universe_struct_get_is_on(struct_obj_ptr, value_out) bind(c, name='tao_universe_struct_get_is_on')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%is_on
  end subroutine

  ! tao_universe_struct%design_same_as_previous: 0D_NOT_logical

  subroutine tao_universe_struct_get_design_same_as_previous(struct_obj_ptr, value_out) bind(c, name='tao_universe_struct_get_design_same_as_previous')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%design_same_as_previous
  end subroutine

  ! tao_universe_struct%picked_uni: 0D_NOT_logical

  subroutine tao_universe_struct_get_picked_uni(struct_obj_ptr, value_out) bind(c, name='tao_universe_struct_get_picked_uni')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(tao_universe_struct), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%picked_uni
  end subroutine

end module
