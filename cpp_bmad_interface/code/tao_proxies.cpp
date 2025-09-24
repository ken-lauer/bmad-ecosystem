#include "tao_proxies.hpp"

using namespace tao;

TaoUniverseProxy TaoUniverseIndexProxy::operator*() const {
  int n_universes = tao_get_n_universes();
  if (ix_uni_ < 0 || ix_uni_ >= n_universes) {
    throw InvalidIndexException("universe", ix_uni_, n_universes);
  }
  return TaoUniverseProxy(tao_c_get_universe_ptr(ix_uni_));
}
double SplineProxy::x0() const {
  double value;
  spline_struct_get_x0(get_fortran_ptr(), &value);
  return value;
}
double SplineProxy::y0() const {
  double value;
  spline_struct_get_y0(get_fortran_ptr(), &value);
  return value;
}
double SplineProxy::x1() const {
  double value;
  spline_struct_get_x1(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> SplineProxy::coef() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  spline_struct_get_coef_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double SpinPolarProxy::polarization() const {
  double value;
  spin_polar_struct_get_polarization(get_fortran_ptr(), &value);
  return value;
}
double SpinPolarProxy::theta() const {
  double value;
  spin_polar_struct_get_theta(get_fortran_ptr(), &value);
  return value;
}
double SpinPolarProxy::phi() const {
  double value;
  spin_polar_struct_get_phi(get_fortran_ptr(), &value);
  return value;
}
double SpinPolarProxy::xi() const {
  double value;
  spin_polar_struct_get_xi(get_fortran_ptr(), &value);
  return value;
}
double AcKickerTimeProxy::amp() const {
  double value;
  ac_kicker_time_struct_get_amp(get_fortran_ptr(), &value);
  return value;
}
double AcKickerTimeProxy::time() const {
  double value;
  ac_kicker_time_struct_get_time(get_fortran_ptr(), &value);
  return value;
}
SplineProxy AcKickerTimeProxy::spline() const {
  void* ptr;
  ac_kicker_time_struct_get_spline(get_fortran_ptr(), &ptr);
  return SplineProxy(get_fortran_ptr());
}
double AcKickerFreqProxy::f() const {
  double value;
  ac_kicker_freq_struct_get_f(get_fortran_ptr(), &value);
  return value;
}
double AcKickerFreqProxy::amp() const {
  double value;
  ac_kicker_freq_struct_get_amp(get_fortran_ptr(), &value);
  return value;
}
double AcKickerFreqProxy::phi() const {
  double value;
  ac_kicker_freq_struct_get_phi(get_fortran_ptr(), &value);
  return value;
}
int AcKickerFreqProxy::rf_clock_harmonic() const {
  int value;
  ac_kicker_freq_struct_get_rf_clock_harmonic(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<AcKickerTimeProxy> AcKickerProxy::amp_vs_time() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  ac_kicker_struct_get_amp_vs_time_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<AcKickerTimeProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<AcKickerFreqProxy> AcKickerProxy::frequency() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  ac_kicker_struct_get_frequency_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<AcKickerFreqProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double Interval1CoefProxy::c0() const {
  double value;
  interval1_coef_struct_get_c0(get_fortran_ptr(), &value);
  return value;
}
double Interval1CoefProxy::c1() const {
  double value;
  interval1_coef_struct_get_c1(get_fortran_ptr(), &value);
  return value;
}
double Interval1CoefProxy::n_exp() const {
  double value;
  interval1_coef_struct_get_n_exp(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> PhotonReflectTableProxy::angle() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  photon_reflect_table_struct_get_angle_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
FortranArray1D<double> PhotonReflectTableProxy::energy() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  photon_reflect_table_struct_get_energy_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
FortranTypeArray1D<Interval1CoefProxy> PhotonReflectTableProxy::int1() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  photon_reflect_table_struct_get_int1_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<Interval1CoefProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranArray2D<double> PhotonReflectTableProxy::p_reflect() const {
  double* data_ptr;
  int dim1_size, dim1_lower, dim1_upper;
  int dim2_size, dim2_lower, dim2_upper;
  int stride1, stride2;
  bool is_allocated;

  photon_reflect_table_struct_get_p_reflect_info(
      get_fortran_ptr(),
      &data_ptr,
      &dim1_size,
      &dim1_lower,
      &dim1_upper,
      &dim2_size,
      &dim2_lower,
      &dim2_upper,
      &stride1,
      &stride2,
      &is_allocated);

  return FortranArray2D<double>(
      data_ptr,
      dim1_size,
      dim1_lower,
      dim1_upper,
      dim2_size,
      dim2_lower,
      dim2_upper,
      stride1,
      stride2,
      is_allocated);
}
double PhotonReflectTableProxy::max_energy() const {
  double value;
  photon_reflect_table_struct_get_max_energy(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> PhotonReflectTableProxy::p_reflect_scratch() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  photon_reflect_table_struct_get_p_reflect_scratch_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
FortranArray1D<double> PhotonReflectTableProxy::bragg_angle() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  photon_reflect_table_struct_get_bragg_angle_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
std::string PhotonReflectSurfaceProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> PhotonReflectSurfaceProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  photon_reflect_surface_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string PhotonReflectSurfaceProxy::description() const {
  auto char_array = get_description_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> PhotonReflectSurfaceProxy::get_description_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  photon_reflect_surface_struct_get_description_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string PhotonReflectSurfaceProxy::reflectivity_file() const {
  auto char_array = get_reflectivity_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> PhotonReflectSurfaceProxy::get_reflectivity_file_chars()
    const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  photon_reflect_surface_struct_get_reflectivity_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<PhotonReflectTableProxy> PhotonReflectSurfaceProxy::table()
    const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  photon_reflect_surface_struct_get_table_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<PhotonReflectTableProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double PhotonReflectSurfaceProxy::surface_roughness_rms() const {
  double value;
  photon_reflect_surface_struct_get_surface_roughness_rms(
      get_fortran_ptr(), &value);
  return value;
}
double PhotonReflectSurfaceProxy::roughness_correlation_len() const {
  double value;
  photon_reflect_surface_struct_get_roughness_correlation_len(
      get_fortran_ptr(), &value);
  return value;
}
int PhotonReflectSurfaceProxy::ix_surface() const {
  int value;
  photon_reflect_surface_struct_get_ix_surface(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> CoordProxy::vec() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  coord_struct_get_vec_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double CoordProxy::s() const {
  double value;
  coord_struct_get_s(get_fortran_ptr(), &value);
  return value;
}
long double CoordProxy::t() const {
  long double value;
  coord_struct_get_t(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> CoordProxy::spin() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  coord_struct_get_spin_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> CoordProxy::field() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  coord_struct_get_field_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> CoordProxy::phase() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  coord_struct_get_phase_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double CoordProxy::charge() const {
  double value;
  coord_struct_get_charge(get_fortran_ptr(), &value);
  return value;
}
double CoordProxy::dt_ref() const {
  double value;
  coord_struct_get_dt_ref(get_fortran_ptr(), &value);
  return value;
}
double CoordProxy::r() const {
  double value;
  coord_struct_get_r(get_fortran_ptr(), &value);
  return value;
}
double CoordProxy::p0c() const {
  double value;
  coord_struct_get_p0c(get_fortran_ptr(), &value);
  return value;
}
double CoordProxy::E_potential() const {
  double value;
  coord_struct_get_E_potential(get_fortran_ptr(), &value);
  return value;
}
double CoordProxy::beta() const {
  double value;
  coord_struct_get_beta(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::ix_ele() const {
  int value;
  coord_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::ix_branch() const {
  int value;
  coord_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::ix_turn() const {
  int value;
  coord_struct_get_ix_turn(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::ix_user() const {
  int value;
  coord_struct_get_ix_user(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::state() const {
  int value;
  coord_struct_get_state(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::direction() const {
  int value;
  coord_struct_get_direction(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::time_dir() const {
  int value;
  coord_struct_get_time_dir(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::species() const {
  int value;
  coord_struct_get_species(get_fortran_ptr(), &value);
  return value;
}
int CoordProxy::location() const {
  int value;
  coord_struct_get_location(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<CoordProxy> CoordArrayProxy::orbit() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  coord_array_struct_get_orbit_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CoordProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double BpmPhaseCouplingProxy::K_22a() const {
  double value;
  bpm_phase_coupling_struct_get_K_22a(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::K_12a() const {
  double value;
  bpm_phase_coupling_struct_get_K_12a(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::K_11b() const {
  double value;
  bpm_phase_coupling_struct_get_K_11b(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::K_12b() const {
  double value;
  bpm_phase_coupling_struct_get_K_12b(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::Cbar22_a() const {
  double value;
  bpm_phase_coupling_struct_get_Cbar22_a(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::Cbar12_a() const {
  double value;
  bpm_phase_coupling_struct_get_Cbar12_a(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::Cbar11_b() const {
  double value;
  bpm_phase_coupling_struct_get_Cbar11_b(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::Cbar12_b() const {
  double value;
  bpm_phase_coupling_struct_get_Cbar12_b(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::phi_a() const {
  double value;
  bpm_phase_coupling_struct_get_phi_a(get_fortran_ptr(), &value);
  return value;
}
double BpmPhaseCouplingProxy::phi_b() const {
  double value;
  bpm_phase_coupling_struct_get_phi_b(get_fortran_ptr(), &value);
  return value;
}
std::string ExpressionAtomProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> ExpressionAtomProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  expression_atom_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int ExpressionAtomProxy::type() const {
  int value;
  expression_atom_struct_get_type(get_fortran_ptr(), &value);
  return value;
}
double ExpressionAtomProxy::value() const {
  double value;
  expression_atom_struct_get_value(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> WakeSrZLongProxy::w() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  wake_sr_z_long_struct_get_w_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
double WakeSrZLongProxy::dz() const {
  double value;
  wake_sr_z_long_struct_get_dz(get_fortran_ptr(), &value);
  return value;
}
double WakeSrZLongProxy::z0() const {
  double value;
  wake_sr_z_long_struct_get_z0(get_fortran_ptr(), &value);
  return value;
}
double WakeSrZLongProxy::smoothing_sigma() const {
  double value;
  wake_sr_z_long_struct_get_smoothing_sigma(get_fortran_ptr(), &value);
  return value;
}
int WakeSrZLongProxy::position_dependence() const {
  int value;
  wake_sr_z_long_struct_get_position_dependence(get_fortran_ptr(), &value);
  return value;
}
bool WakeSrZLongProxy::time_based() const {
  bool value;
  wake_sr_z_long_struct_get_time_based(get_fortran_ptr(), &value);
  return value;
}
double WakeSrModeProxy::amp() const {
  double value;
  wake_sr_mode_struct_get_amp(get_fortran_ptr(), &value);
  return value;
}
double WakeSrModeProxy::damp() const {
  double value;
  wake_sr_mode_struct_get_damp(get_fortran_ptr(), &value);
  return value;
}
double WakeSrModeProxy::k() const {
  double value;
  wake_sr_mode_struct_get_k(get_fortran_ptr(), &value);
  return value;
}
double WakeSrModeProxy::phi() const {
  double value;
  wake_sr_mode_struct_get_phi(get_fortran_ptr(), &value);
  return value;
}
double WakeSrModeProxy::b_sin() const {
  double value;
  wake_sr_mode_struct_get_b_sin(get_fortran_ptr(), &value);
  return value;
}
double WakeSrModeProxy::b_cos() const {
  double value;
  wake_sr_mode_struct_get_b_cos(get_fortran_ptr(), &value);
  return value;
}
double WakeSrModeProxy::a_sin() const {
  double value;
  wake_sr_mode_struct_get_a_sin(get_fortran_ptr(), &value);
  return value;
}
double WakeSrModeProxy::a_cos() const {
  double value;
  wake_sr_mode_struct_get_a_cos(get_fortran_ptr(), &value);
  return value;
}
int WakeSrModeProxy::polarization() const {
  int value;
  wake_sr_mode_struct_get_polarization(get_fortran_ptr(), &value);
  return value;
}
int WakeSrModeProxy::position_dependence() const {
  int value;
  wake_sr_mode_struct_get_position_dependence(get_fortran_ptr(), &value);
  return value;
}
std::string WakeSrProxy::file() const {
  auto char_array = get_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> WakeSrProxy::get_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  wake_sr_struct_get_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
WakeSrZLongProxy WakeSrProxy::z_long() const {
  void* ptr;
  wake_sr_struct_get_z_long(get_fortran_ptr(), &ptr);
  return WakeSrZLongProxy(get_fortran_ptr());
}
FortranTypeArray1D<WakeSrModeProxy> WakeSrProxy::long_wake() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  wake_sr_struct_get_long_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<WakeSrModeProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<WakeSrModeProxy> WakeSrProxy::trans_wake() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  wake_sr_struct_get_trans_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<WakeSrModeProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double WakeSrProxy::z_ref_long() const {
  double value;
  wake_sr_struct_get_z_ref_long(get_fortran_ptr(), &value);
  return value;
}
double WakeSrProxy::z_ref_trans() const {
  double value;
  wake_sr_struct_get_z_ref_trans(get_fortran_ptr(), &value);
  return value;
}
double WakeSrProxy::z_max() const {
  double value;
  wake_sr_struct_get_z_max(get_fortran_ptr(), &value);
  return value;
}
double WakeSrProxy::amp_scale() const {
  double value;
  wake_sr_struct_get_amp_scale(get_fortran_ptr(), &value);
  return value;
}
double WakeSrProxy::z_scale() const {
  double value;
  wake_sr_struct_get_z_scale(get_fortran_ptr(), &value);
  return value;
}
bool WakeSrProxy::scale_with_length() const {
  bool value;
  wake_sr_struct_get_scale_with_length(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::freq() const {
  double value;
  wake_lr_mode_struct_get_freq(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::freq_in() const {
  double value;
  wake_lr_mode_struct_get_freq_in(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::R_over_Q() const {
  double value;
  wake_lr_mode_struct_get_R_over_Q(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::Q() const {
  double value;
  wake_lr_mode_struct_get_Q(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::damp() const {
  double value;
  wake_lr_mode_struct_get_damp(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::phi() const {
  double value;
  wake_lr_mode_struct_get_phi(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::angle() const {
  double value;
  wake_lr_mode_struct_get_angle(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::b_sin() const {
  double value;
  wake_lr_mode_struct_get_b_sin(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::b_cos() const {
  double value;
  wake_lr_mode_struct_get_b_cos(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::a_sin() const {
  double value;
  wake_lr_mode_struct_get_a_sin(get_fortran_ptr(), &value);
  return value;
}
double WakeLrModeProxy::a_cos() const {
  double value;
  wake_lr_mode_struct_get_a_cos(get_fortran_ptr(), &value);
  return value;
}
int WakeLrModeProxy::m() const {
  int value;
  wake_lr_mode_struct_get_m(get_fortran_ptr(), &value);
  return value;
}
bool WakeLrModeProxy::polarized() const {
  bool value;
  wake_lr_mode_struct_get_polarized(get_fortran_ptr(), &value);
  return value;
}
std::string WakeLrProxy::file() const {
  auto char_array = get_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> WakeLrProxy::get_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  wake_lr_struct_get_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<WakeLrModeProxy> WakeLrProxy::mode() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  wake_lr_struct_get_mode_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<WakeLrModeProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double WakeLrProxy::t_ref() const {
  double value;
  wake_lr_struct_get_t_ref(get_fortran_ptr(), &value);
  return value;
}
double WakeLrProxy::freq_spread() const {
  double value;
  wake_lr_struct_get_freq_spread(get_fortran_ptr(), &value);
  return value;
}
double WakeLrProxy::amp_scale() const {
  double value;
  wake_lr_struct_get_amp_scale(get_fortran_ptr(), &value);
  return value;
}
double WakeLrProxy::time_scale() const {
  double value;
  wake_lr_struct_get_time_scale(get_fortran_ptr(), &value);
  return value;
}
bool WakeLrProxy::self_wake_on() const {
  bool value;
  wake_lr_struct_get_self_wake_on(get_fortran_ptr(), &value);
  return value;
}
int LatEleLocProxy::ix_ele() const {
  int value;
  lat_ele_loc_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int LatEleLocProxy::ix_branch() const {
  int value;
  lat_ele_loc_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
WakeSrProxy WakeProxy::sr() const {
  void* ptr;
  wake_struct_get_sr(get_fortran_ptr(), &ptr);
  return WakeSrProxy(get_fortran_ptr());
}
WakeLrProxy WakeProxy::lr() const {
  void* ptr;
  wake_struct_get_lr(get_fortran_ptr(), &ptr);
  return WakeLrProxy(get_fortran_ptr());
}
double TaylorTermProxy::coef() const {
  double value;
  taylor_term_struct_get_coef(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<int> TaylorTermProxy::expn() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;

  taylor_term_struct_get_expn_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double TaylorProxy::ref() const {
  double value;
  taylor_struct_get_ref(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<TaylorTermProxy> TaylorProxy::term() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  taylor_struct_get_term_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaylorTermProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double EmTaylorTermProxy::coef() const {
  double value;
  em_taylor_term_struct_get_coef(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<int> EmTaylorTermProxy::expn() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;

  em_taylor_term_struct_get_expn_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double EmTaylorProxy::ref() const {
  double value;
  em_taylor_struct_get_ref(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<EmTaylorTermProxy> EmTaylorProxy::term() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  em_taylor_struct_get_term_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<EmTaylorTermProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double CartesianMapTerm1Proxy::coef() const {
  double value;
  cartesian_map_term1_struct_get_coef(get_fortran_ptr(), &value);
  return value;
}
double CartesianMapTerm1Proxy::kx() const {
  double value;
  cartesian_map_term1_struct_get_kx(get_fortran_ptr(), &value);
  return value;
}
double CartesianMapTerm1Proxy::ky() const {
  double value;
  cartesian_map_term1_struct_get_ky(get_fortran_ptr(), &value);
  return value;
}
double CartesianMapTerm1Proxy::kz() const {
  double value;
  cartesian_map_term1_struct_get_kz(get_fortran_ptr(), &value);
  return value;
}
double CartesianMapTerm1Proxy::x0() const {
  double value;
  cartesian_map_term1_struct_get_x0(get_fortran_ptr(), &value);
  return value;
}
double CartesianMapTerm1Proxy::y0() const {
  double value;
  cartesian_map_term1_struct_get_y0(get_fortran_ptr(), &value);
  return value;
}
double CartesianMapTerm1Proxy::phi_z() const {
  double value;
  cartesian_map_term1_struct_get_phi_z(get_fortran_ptr(), &value);
  return value;
}
int CartesianMapTerm1Proxy::family() const {
  int value;
  cartesian_map_term1_struct_get_family(get_fortran_ptr(), &value);
  return value;
}
int CartesianMapTerm1Proxy::form() const {
  int value;
  cartesian_map_term1_struct_get_form(get_fortran_ptr(), &value);
  return value;
}
std::string CartesianMapTermProxy::file() const {
  auto char_array = get_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> CartesianMapTermProxy::get_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  cartesian_map_term_struct_get_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int CartesianMapTermProxy::n_link() const {
  int value;
  cartesian_map_term_struct_get_n_link(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<CartesianMapTerm1Proxy> CartesianMapTermProxy::term() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  cartesian_map_term_struct_get_term_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CartesianMapTerm1Proxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double CartesianMapProxy::field_scale() const {
  double value;
  cartesian_map_struct_get_field_scale(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> CartesianMapProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  cartesian_map_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int CartesianMapProxy::master_parameter() const {
  int value;
  cartesian_map_struct_get_master_parameter(get_fortran_ptr(), &value);
  return value;
}
int CartesianMapProxy::ele_anchor_pt() const {
  int value;
  cartesian_map_struct_get_ele_anchor_pt(get_fortran_ptr(), &value);
  return value;
}
int CartesianMapProxy::field_type() const {
  int value;
  cartesian_map_struct_get_field_type(get_fortran_ptr(), &value);
  return value;
}
const void* CartesianMapProxy::ptr() const {
  void* ptr;
  cartesian_map_struct_get_ptr(get_fortran_ptr(), &ptr);
  return ptr;
}
std::complex<double> CylindricalMapTerm1Proxy::e_coef() const {
  std::complex<double> c_value;
  cylindrical_map_term1_struct_get_e_coef(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> CylindricalMapTerm1Proxy::b_coef() const {
  std::complex<double> c_value;
  cylindrical_map_term1_struct_get_b_coef(get_fortran_ptr(), &c_value);
  return c_value;
}
std::string CylindricalMapTermProxy::file() const {
  auto char_array = get_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> CylindricalMapTermProxy::get_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  cylindrical_map_term_struct_get_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int CylindricalMapTermProxy::n_link() const {
  int value;
  cylindrical_map_term_struct_get_n_link(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<CylindricalMapTerm1Proxy> CylindricalMapTermProxy::term()
    const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  cylindrical_map_term_struct_get_term_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CylindricalMapTerm1Proxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
int CylindricalMapProxy::m() const {
  int value;
  cylindrical_map_struct_get_m(get_fortran_ptr(), &value);
  return value;
}
int CylindricalMapProxy::harmonic() const {
  int value;
  cylindrical_map_struct_get_harmonic(get_fortran_ptr(), &value);
  return value;
}
double CylindricalMapProxy::phi0_fieldmap() const {
  double value;
  cylindrical_map_struct_get_phi0_fieldmap(get_fortran_ptr(), &value);
  return value;
}
double CylindricalMapProxy::theta0_azimuth() const {
  double value;
  cylindrical_map_struct_get_theta0_azimuth(get_fortran_ptr(), &value);
  return value;
}
double CylindricalMapProxy::field_scale() const {
  double value;
  cylindrical_map_struct_get_field_scale(get_fortran_ptr(), &value);
  return value;
}
int CylindricalMapProxy::master_parameter() const {
  int value;
  cylindrical_map_struct_get_master_parameter(get_fortran_ptr(), &value);
  return value;
}
int CylindricalMapProxy::ele_anchor_pt() const {
  int value;
  cylindrical_map_struct_get_ele_anchor_pt(get_fortran_ptr(), &value);
  return value;
}
double CylindricalMapProxy::dz() const {
  double value;
  cylindrical_map_struct_get_dz(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> CylindricalMapProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  cylindrical_map_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
const void* CylindricalMapProxy::ptr() const {
  void* ptr;
  cylindrical_map_struct_get_ptr(get_fortran_ptr(), &ptr);
  return ptr;
}
FortranArray1D<int> BicubicCmplxCoefProxy::i_box() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;

  bicubic_cmplx_coef_struct_get_i_box_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<int> TricubicCmplxCoefProxy::i_box() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;

  tricubic_cmplx_coef_struct_get_i_box_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<std::complex<double>> GridFieldPt1Proxy::E() const {
  std::complex<double>* data_ptr;
  int size_out, lower_bound, upper_bound;

  grid_field_pt1_struct_get_E_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<std::complex<double>>(
      reinterpret_cast<std::complex<double>*>(data_ptr),
      size_out,
      lower_bound,
      upper_bound,
      true);
}
FortranArray1D<std::complex<double>> GridFieldPt1Proxy::B() const {
  std::complex<double>* data_ptr;
  int size_out, lower_bound, upper_bound;

  grid_field_pt1_struct_get_B_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<std::complex<double>>(
      reinterpret_cast<std::complex<double>*>(data_ptr),
      size_out,
      lower_bound,
      upper_bound,
      true);
}
std::string GridFieldPtProxy::file() const {
  auto char_array = get_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> GridFieldPtProxy::get_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  grid_field_pt_struct_get_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int GridFieldPtProxy::n_link() const {
  int value;
  grid_field_pt_struct_get_n_link(get_fortran_ptr(), &value);
  return value;
}
int GridFieldProxy::geometry() const {
  int value;
  grid_field_struct_get_geometry(get_fortran_ptr(), &value);
  return value;
}
int GridFieldProxy::harmonic() const {
  int value;
  grid_field_struct_get_harmonic(get_fortran_ptr(), &value);
  return value;
}
double GridFieldProxy::phi0_fieldmap() const {
  double value;
  grid_field_struct_get_phi0_fieldmap(get_fortran_ptr(), &value);
  return value;
}
double GridFieldProxy::field_scale() const {
  double value;
  grid_field_struct_get_field_scale(get_fortran_ptr(), &value);
  return value;
}
int GridFieldProxy::field_type() const {
  int value;
  grid_field_struct_get_field_type(get_fortran_ptr(), &value);
  return value;
}
int GridFieldProxy::master_parameter() const {
  int value;
  grid_field_struct_get_master_parameter(get_fortran_ptr(), &value);
  return value;
}
int GridFieldProxy::ele_anchor_pt() const {
  int value;
  grid_field_struct_get_ele_anchor_pt(get_fortran_ptr(), &value);
  return value;
}
int GridFieldProxy::interpolation_order() const {
  int value;
  grid_field_struct_get_interpolation_order(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> GridFieldProxy::dr() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  grid_field_struct_get_dr_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> GridFieldProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  grid_field_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
bool GridFieldProxy::curved_ref_frame() const {
  bool value;
  grid_field_struct_get_curved_ref_frame(get_fortran_ptr(), &value);
  return value;
}
const void* GridFieldProxy::ptr() const {
  void* ptr;
  grid_field_struct_get_ptr(get_fortran_ptr(), &ptr);
  return ptr;
}
FortranArray1D<double> FloorPositionProxy::r() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  floor_position_struct_get_r_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double FloorPositionProxy::theta() const {
  double value;
  floor_position_struct_get_theta(get_fortran_ptr(), &value);
  return value;
}
double FloorPositionProxy::phi() const {
  double value;
  floor_position_struct_get_phi(get_fortran_ptr(), &value);
  return value;
}
double FloorPositionProxy::psi() const {
  double value;
  floor_position_struct_get_psi(get_fortran_ptr(), &value);
  return value;
}
CoordProxy HighEnergySpaceChargeProxy::closed_orb() const {
  void* ptr;
  high_energy_space_charge_struct_get_closed_orb(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
double HighEnergySpaceChargeProxy::kick_const() const {
  double value;
  high_energy_space_charge_struct_get_kick_const(get_fortran_ptr(), &value);
  return value;
}
double HighEnergySpaceChargeProxy::sig_x() const {
  double value;
  high_energy_space_charge_struct_get_sig_x(get_fortran_ptr(), &value);
  return value;
}
double HighEnergySpaceChargeProxy::sig_y() const {
  double value;
  high_energy_space_charge_struct_get_sig_y(get_fortran_ptr(), &value);
  return value;
}
double HighEnergySpaceChargeProxy::phi() const {
  double value;
  high_energy_space_charge_struct_get_phi(get_fortran_ptr(), &value);
  return value;
}
double HighEnergySpaceChargeProxy::sin_phi() const {
  double value;
  high_energy_space_charge_struct_get_sin_phi(get_fortran_ptr(), &value);
  return value;
}
double HighEnergySpaceChargeProxy::cos_phi() const {
  double value;
  high_energy_space_charge_struct_get_cos_phi(get_fortran_ptr(), &value);
  return value;
}
double HighEnergySpaceChargeProxy::sig_z() const {
  double value;
  high_energy_space_charge_struct_get_sig_z(get_fortran_ptr(), &value);
  return value;
}
double XyDispProxy::eta() const {
  double value;
  xy_disp_struct_get_eta(get_fortran_ptr(), &value);
  return value;
}
double XyDispProxy::etap() const {
  double value;
  xy_disp_struct_get_etap(get_fortran_ptr(), &value);
  return value;
}
double XyDispProxy::deta_ds() const {
  double value;
  xy_disp_struct_get_deta_ds(get_fortran_ptr(), &value);
  return value;
}
double XyDispProxy::sigma() const {
  double value;
  xy_disp_struct_get_sigma(get_fortran_ptr(), &value);
  return value;
}
double XyDispProxy::deta_dpz() const {
  double value;
  xy_disp_struct_get_deta_dpz(get_fortran_ptr(), &value);
  return value;
}
double XyDispProxy::detap_dpz() const {
  double value;
  xy_disp_struct_get_detap_dpz(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::beta() const {
  double value;
  twiss_struct_get_beta(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::alpha() const {
  double value;
  twiss_struct_get_alpha(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::gamma() const {
  double value;
  twiss_struct_get_gamma(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::phi() const {
  double value;
  twiss_struct_get_phi(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::eta() const {
  double value;
  twiss_struct_get_eta(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::etap() const {
  double value;
  twiss_struct_get_etap(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::deta_ds() const {
  double value;
  twiss_struct_get_deta_ds(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::sigma() const {
  double value;
  twiss_struct_get_sigma(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::sigma_p() const {
  double value;
  twiss_struct_get_sigma_p(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::emit() const {
  double value;
  twiss_struct_get_emit(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::norm_emit() const {
  double value;
  twiss_struct_get_norm_emit(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::chrom() const {
  double value;
  twiss_struct_get_chrom(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::dbeta_dpz() const {
  double value;
  twiss_struct_get_dbeta_dpz(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::dalpha_dpz() const {
  double value;
  twiss_struct_get_dalpha_dpz(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::deta_dpz() const {
  double value;
  twiss_struct_get_deta_dpz(get_fortran_ptr(), &value);
  return value;
}
double TwissProxy::detap_dpz() const {
  double value;
  twiss_struct_get_detap_dpz(get_fortran_ptr(), &value);
  return value;
}
TwissProxy Mode3Proxy::a() const {
  void* ptr;
  mode3_struct_get_a(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy Mode3Proxy::b() const {
  void* ptr;
  mode3_struct_get_b(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy Mode3Proxy::c() const {
  void* ptr;
  mode3_struct_get_c(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy Mode3Proxy::x() const {
  void* ptr;
  mode3_struct_get_x(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy Mode3Proxy::y() const {
  void* ptr;
  mode3_struct_get_y(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
int BookkeepingStateProxy::attributes() const {
  int value;
  bookkeeping_state_struct_get_attributes(get_fortran_ptr(), &value);
  return value;
}
int BookkeepingStateProxy::control() const {
  int value;
  bookkeeping_state_struct_get_control(get_fortran_ptr(), &value);
  return value;
}
int BookkeepingStateProxy::floor_position() const {
  int value;
  bookkeeping_state_struct_get_floor_position(get_fortran_ptr(), &value);
  return value;
}
int BookkeepingStateProxy::s_position() const {
  int value;
  bookkeeping_state_struct_get_s_position(get_fortran_ptr(), &value);
  return value;
}
int BookkeepingStateProxy::ref_energy() const {
  int value;
  bookkeeping_state_struct_get_ref_energy(get_fortran_ptr(), &value);
  return value;
}
int BookkeepingStateProxy::mat6() const {
  int value;
  bookkeeping_state_struct_get_mat6(get_fortran_ptr(), &value);
  return value;
}
int BookkeepingStateProxy::rad_int() const {
  int value;
  bookkeeping_state_struct_get_rad_int(get_fortran_ptr(), &value);
  return value;
}
int BookkeepingStateProxy::ptc() const {
  int value;
  bookkeeping_state_struct_get_ptc(get_fortran_ptr(), &value);
  return value;
}
bool BookkeepingStateProxy::has_misalign() const {
  bool value;
  bookkeeping_state_struct_get_has_misalign(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> RadMapProxy::ref_orb() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  rad_map_struct_get_ref_orb_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> RadMapProxy::xfer_damp_vec() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  rad_map_struct_get_xfer_damp_vec_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
RadMapProxy RadMapEleProxy::rm0() const {
  void* ptr;
  rad_map_ele_struct_get_rm0(get_fortran_ptr(), &ptr);
  return RadMapProxy(get_fortran_ptr());
}
RadMapProxy RadMapEleProxy::rm1() const {
  void* ptr;
  rad_map_ele_struct_get_rm1(get_fortran_ptr(), &ptr);
  return RadMapProxy(get_fortran_ptr());
}
bool RadMapEleProxy::stale() const {
  bool value;
  rad_map_ele_struct_get_stale(get_fortran_ptr(), &value);
  return value;
}
int GenGrad1Proxy::m() const {
  int value;
  gen_grad1_struct_get_m(get_fortran_ptr(), &value);
  return value;
}
int GenGrad1Proxy::sincos() const {
  int value;
  gen_grad1_struct_get_sincos(get_fortran_ptr(), &value);
  return value;
}
int GenGrad1Proxy::n_deriv_max() const {
  int value;
  gen_grad1_struct_get_n_deriv_max(get_fortran_ptr(), &value);
  return value;
}
FortranArray2D<double> GenGrad1Proxy::deriv() const {
  double* data_ptr;
  int dim1_size, dim1_lower, dim1_upper;
  int dim2_size, dim2_lower, dim2_upper;
  int stride1, stride2;
  bool is_allocated;

  gen_grad1_struct_get_deriv_info(
      get_fortran_ptr(),
      &data_ptr,
      &dim1_size,
      &dim1_lower,
      &dim1_upper,
      &dim2_size,
      &dim2_lower,
      &dim2_upper,
      &stride1,
      &stride2,
      &is_allocated);

  return FortranArray2D<double>(
      data_ptr,
      dim1_size,
      dim1_lower,
      dim1_upper,
      dim2_size,
      dim2_lower,
      dim2_upper,
      stride1,
      stride2,
      is_allocated);
}
std::string GenGradMapProxy::file() const {
  auto char_array = get_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> GenGradMapProxy::get_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  gen_grad_map_struct_get_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<GenGrad1Proxy> GenGradMapProxy::gg() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  gen_grad_map_struct_get_gg_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<GenGrad1Proxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
int GenGradMapProxy::ele_anchor_pt() const {
  int value;
  gen_grad_map_struct_get_ele_anchor_pt(get_fortran_ptr(), &value);
  return value;
}
int GenGradMapProxy::field_type() const {
  int value;
  gen_grad_map_struct_get_field_type(get_fortran_ptr(), &value);
  return value;
}
int GenGradMapProxy::iz0() const {
  int value;
  gen_grad_map_struct_get_iz0(get_fortran_ptr(), &value);
  return value;
}
int GenGradMapProxy::iz1() const {
  int value;
  gen_grad_map_struct_get_iz1(get_fortran_ptr(), &value);
  return value;
}
double GenGradMapProxy::dz() const {
  double value;
  gen_grad_map_struct_get_dz(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> GenGradMapProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  gen_grad_map_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double GenGradMapProxy::field_scale() const {
  double value;
  gen_grad_map_struct_get_field_scale(get_fortran_ptr(), &value);
  return value;
}
int GenGradMapProxy::master_parameter() const {
  int value;
  gen_grad_map_struct_get_master_parameter(get_fortran_ptr(), &value);
  return value;
}
bool GenGradMapProxy::curved_ref_frame() const {
  bool value;
  gen_grad_map_struct_get_curved_ref_frame(get_fortran_ptr(), &value);
  return value;
}
double SurfaceSegmentedPtProxy::x0() const {
  double value;
  surface_segmented_pt_struct_get_x0(get_fortran_ptr(), &value);
  return value;
}
double SurfaceSegmentedPtProxy::y0() const {
  double value;
  surface_segmented_pt_struct_get_y0(get_fortran_ptr(), &value);
  return value;
}
double SurfaceSegmentedPtProxy::z0() const {
  double value;
  surface_segmented_pt_struct_get_z0(get_fortran_ptr(), &value);
  return value;
}
double SurfaceSegmentedPtProxy::dz_dx() const {
  double value;
  surface_segmented_pt_struct_get_dz_dx(get_fortran_ptr(), &value);
  return value;
}
double SurfaceSegmentedPtProxy::dz_dy() const {
  double value;
  surface_segmented_pt_struct_get_dz_dy(get_fortran_ptr(), &value);
  return value;
}
bool SurfaceSegmentedProxy::active() const {
  bool value;
  surface_segmented_struct_get_active(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> SurfaceSegmentedProxy::dr() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  surface_segmented_struct_get_dr_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> SurfaceSegmentedProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  surface_segmented_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double SurfaceHMisalignPtProxy::x0() const {
  double value;
  surface_h_misalign_pt_struct_get_x0(get_fortran_ptr(), &value);
  return value;
}
double SurfaceHMisalignPtProxy::y0() const {
  double value;
  surface_h_misalign_pt_struct_get_y0(get_fortran_ptr(), &value);
  return value;
}
double SurfaceHMisalignPtProxy::rot_y() const {
  double value;
  surface_h_misalign_pt_struct_get_rot_y(get_fortran_ptr(), &value);
  return value;
}
double SurfaceHMisalignPtProxy::rot_t() const {
  double value;
  surface_h_misalign_pt_struct_get_rot_t(get_fortran_ptr(), &value);
  return value;
}
double SurfaceHMisalignPtProxy::rot_y_rms() const {
  double value;
  surface_h_misalign_pt_struct_get_rot_y_rms(get_fortran_ptr(), &value);
  return value;
}
double SurfaceHMisalignPtProxy::rot_t_rms() const {
  double value;
  surface_h_misalign_pt_struct_get_rot_t_rms(get_fortran_ptr(), &value);
  return value;
}
bool SurfaceHMisalignProxy::active() const {
  bool value;
  surface_h_misalign_struct_get_active(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> SurfaceHMisalignProxy::dr() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  surface_h_misalign_struct_get_dr_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> SurfaceHMisalignProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  surface_h_misalign_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double SurfaceDisplacementPtProxy::x0() const {
  double value;
  surface_displacement_pt_struct_get_x0(get_fortran_ptr(), &value);
  return value;
}
double SurfaceDisplacementPtProxy::y0() const {
  double value;
  surface_displacement_pt_struct_get_y0(get_fortran_ptr(), &value);
  return value;
}
double SurfaceDisplacementPtProxy::z0() const {
  double value;
  surface_displacement_pt_struct_get_z0(get_fortran_ptr(), &value);
  return value;
}
double SurfaceDisplacementPtProxy::dz_dx() const {
  double value;
  surface_displacement_pt_struct_get_dz_dx(get_fortran_ptr(), &value);
  return value;
}
double SurfaceDisplacementPtProxy::dz_dy() const {
  double value;
  surface_displacement_pt_struct_get_dz_dy(get_fortran_ptr(), &value);
  return value;
}
double SurfaceDisplacementPtProxy::d2z_dxdy() const {
  double value;
  surface_displacement_pt_struct_get_d2z_dxdy(get_fortran_ptr(), &value);
  return value;
}
bool SurfaceDisplacementProxy::active() const {
  bool value;
  surface_displacement_struct_get_active(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> SurfaceDisplacementProxy::dr() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  surface_displacement_struct_get_dr_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> SurfaceDisplacementProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  surface_displacement_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> TargetPointProxy::r() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  target_point_struct_get_r_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double SurfaceCurvatureProxy::spherical() const {
  double value;
  surface_curvature_struct_get_spherical(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> SurfaceCurvatureProxy::elliptical() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  surface_curvature_struct_get_elliptical_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
bool SurfaceCurvatureProxy::has_curvature() const {
  bool value;
  surface_curvature_struct_get_has_curvature(get_fortran_ptr(), &value);
  return value;
}
int PhotonTargetProxy::type() const {
  int value;
  photon_target_struct_get_type(get_fortran_ptr(), &value);
  return value;
}
int PhotonTargetProxy::n_corner() const {
  int value;
  photon_target_struct_get_n_corner(get_fortran_ptr(), &value);
  return value;
}
LatEleLocProxy PhotonTargetProxy::ele_loc() const {
  void* ptr;
  photon_target_struct_get_ele_loc(get_fortran_ptr(), &ptr);
  return LatEleLocProxy(get_fortran_ptr());
}
FortranTypeArray1D<TargetPointProxy> PhotonTargetProxy::corner() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  photon_target_struct_get_corner_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<TargetPointProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
TargetPointProxy PhotonTargetProxy::center() const {
  void* ptr;
  photon_target_struct_get_center(get_fortran_ptr(), &ptr);
  return TargetPointProxy(get_fortran_ptr());
}
std::complex<double> PhotonMaterialProxy::f0_m1() const {
  std::complex<double> c_value;
  photon_material_struct_get_f0_m1(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> PhotonMaterialProxy::f0_m2() const {
  std::complex<double> c_value;
  photon_material_struct_get_f0_m2(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> PhotonMaterialProxy::f_0() const {
  std::complex<double> c_value;
  photon_material_struct_get_f_0(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> PhotonMaterialProxy::f_h() const {
  std::complex<double> c_value;
  photon_material_struct_get_f_h(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> PhotonMaterialProxy::f_hbar() const {
  std::complex<double> c_value;
  photon_material_struct_get_f_hbar(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> PhotonMaterialProxy::f_hkl() const {
  std::complex<double> c_value;
  photon_material_struct_get_f_hkl(get_fortran_ptr(), &c_value);
  return c_value;
}
FortranArray1D<double> PhotonMaterialProxy::h_norm() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  photon_material_struct_get_h_norm_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> PhotonMaterialProxy::l_ref() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  photon_material_struct_get_l_ref_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
long long PixelPtProxy::n_photon() const {
  long long value;
  pixel_pt_struct_get_n_photon(get_fortran_ptr(), &value);
  return value;
}
std::complex<double> PixelPtProxy::E_x() const {
  std::complex<double> c_value;
  pixel_pt_struct_get_E_x(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> PixelPtProxy::E_y() const {
  std::complex<double> c_value;
  pixel_pt_struct_get_E_y(get_fortran_ptr(), &c_value);
  return c_value;
}
double PixelPtProxy::intensity_x() const {
  double value;
  pixel_pt_struct_get_intensity_x(get_fortran_ptr(), &value);
  return value;
}
double PixelPtProxy::intensity_y() const {
  double value;
  pixel_pt_struct_get_intensity_y(get_fortran_ptr(), &value);
  return value;
}
double PixelPtProxy::intensity() const {
  double value;
  pixel_pt_struct_get_intensity(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> PixelPtProxy::orbit() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  pixel_pt_struct_get_orbit_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> PixelPtProxy::orbit_rms() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  pixel_pt_struct_get_orbit_rms_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> PixelPtProxy::init_orbit() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  pixel_pt_struct_get_init_orbit_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> PixelPtProxy::init_orbit_rms() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  pixel_pt_struct_get_init_orbit_rms_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> PixelDetecProxy::dr() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  pixel_detec_struct_get_dr_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> PixelDetecProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  pixel_detec_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
long long PixelDetecProxy::n_track_tot() const {
  long long value;
  pixel_detec_struct_get_n_track_tot(get_fortran_ptr(), &value);
  return value;
}
long long PixelDetecProxy::n_hit_detec() const {
  long long value;
  pixel_detec_struct_get_n_hit_detec(get_fortran_ptr(), &value);
  return value;
}
long long PixelDetecProxy::n_hit_pixel() const {
  long long value;
  pixel_detec_struct_get_n_hit_pixel(get_fortran_ptr(), &value);
  return value;
}
SurfaceCurvatureProxy PhotonElementProxy::curvature() const {
  void* ptr;
  photon_element_struct_get_curvature(get_fortran_ptr(), &ptr);
  return SurfaceCurvatureProxy(get_fortran_ptr());
}
PhotonTargetProxy PhotonElementProxy::target() const {
  void* ptr;
  photon_element_struct_get_target(get_fortran_ptr(), &ptr);
  return PhotonTargetProxy(get_fortran_ptr());
}
PhotonMaterialProxy PhotonElementProxy::material() const {
  void* ptr;
  photon_element_struct_get_material(get_fortran_ptr(), &ptr);
  return PhotonMaterialProxy(get_fortran_ptr());
}
SurfaceSegmentedProxy PhotonElementProxy::segmented() const {
  void* ptr;
  photon_element_struct_get_segmented(get_fortran_ptr(), &ptr);
  return SurfaceSegmentedProxy(get_fortran_ptr());
}
SurfaceHMisalignProxy PhotonElementProxy::h_misalign() const {
  void* ptr;
  photon_element_struct_get_h_misalign(get_fortran_ptr(), &ptr);
  return SurfaceHMisalignProxy(get_fortran_ptr());
}
SurfaceDisplacementProxy PhotonElementProxy::displacement() const {
  void* ptr;
  photon_element_struct_get_displacement(get_fortran_ptr(), &ptr);
  return SurfaceDisplacementProxy(get_fortran_ptr());
}
PixelDetecProxy PhotonElementProxy::pixel() const {
  void* ptr;
  photon_element_struct_get_pixel(get_fortran_ptr(), &ptr);
  return PixelDetecProxy(get_fortran_ptr());
}
int PhotonElementProxy::reflectivity_table_type() const {
  int value;
  photon_element_struct_get_reflectivity_table_type(get_fortran_ptr(), &value);
  return value;
}
PhotonReflectTableProxy PhotonElementProxy::reflectivity_table_sigma() const {
  void* ptr;
  photon_element_struct_get_reflectivity_table_sigma(get_fortran_ptr(), &ptr);
  return PhotonReflectTableProxy(get_fortran_ptr());
}
PhotonReflectTableProxy PhotonElementProxy::reflectivity_table_pi() const {
  void* ptr;
  photon_element_struct_get_reflectivity_table_pi(get_fortran_ptr(), &ptr);
  return PhotonReflectTableProxy(get_fortran_ptr());
}
FortranTypeArray1D<SplineProxy> PhotonElementProxy::init_energy_prob() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  photon_element_struct_get_init_energy_prob_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<SplineProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranArray1D<double> PhotonElementProxy::integrated_init_energy_prob() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  photon_element_struct_get_integrated_init_energy_prob_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
double Wall3dVertexProxy::x() const {
  double value;
  wall3d_vertex_struct_get_x(get_fortran_ptr(), &value);
  return value;
}
double Wall3dVertexProxy::y() const {
  double value;
  wall3d_vertex_struct_get_y(get_fortran_ptr(), &value);
  return value;
}
double Wall3dVertexProxy::radius_x() const {
  double value;
  wall3d_vertex_struct_get_radius_x(get_fortran_ptr(), &value);
  return value;
}
double Wall3dVertexProxy::radius_y() const {
  double value;
  wall3d_vertex_struct_get_radius_y(get_fortran_ptr(), &value);
  return value;
}
double Wall3dVertexProxy::tilt() const {
  double value;
  wall3d_vertex_struct_get_tilt(get_fortran_ptr(), &value);
  return value;
}
double Wall3dVertexProxy::angle() const {
  double value;
  wall3d_vertex_struct_get_angle(get_fortran_ptr(), &value);
  return value;
}
double Wall3dVertexProxy::x0() const {
  double value;
  wall3d_vertex_struct_get_x0(get_fortran_ptr(), &value);
  return value;
}
double Wall3dVertexProxy::y0() const {
  double value;
  wall3d_vertex_struct_get_y0(get_fortran_ptr(), &value);
  return value;
}
int Wall3dVertexProxy::type() const {
  int value;
  wall3d_vertex_struct_get_type(get_fortran_ptr(), &value);
  return value;
}
std::string Wall3dSectionProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> Wall3dSectionProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_section_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string Wall3dSectionProxy::material() const {
  auto char_array = get_material_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> Wall3dSectionProxy::get_material_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_section_struct_get_material_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<Wall3dVertexProxy> Wall3dSectionProxy::v() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  wall3d_section_struct_get_v_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<Wall3dVertexProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
const void* Wall3dSectionProxy::surface() const {
  void* ptr;
  wall3d_section_struct_get_surface(get_fortran_ptr(), &ptr);
  return ptr;
}
int Wall3dSectionProxy::type() const {
  int value;
  wall3d_section_struct_get_type(get_fortran_ptr(), &value);
  return value;
}
int Wall3dSectionProxy::n_vertex_input() const {
  int value;
  wall3d_section_struct_get_n_vertex_input(get_fortran_ptr(), &value);
  return value;
}
int Wall3dSectionProxy::ix_ele() const {
  int value;
  wall3d_section_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int Wall3dSectionProxy::ix_branch() const {
  int value;
  wall3d_section_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
int Wall3dSectionProxy::vertices_state() const {
  int value;
  wall3d_section_struct_get_vertices_state(get_fortran_ptr(), &value);
  return value;
}
bool Wall3dSectionProxy::patch_in_region() const {
  bool value;
  wall3d_section_struct_get_patch_in_region(get_fortran_ptr(), &value);
  return value;
}
double Wall3dSectionProxy::thickness() const {
  double value;
  wall3d_section_struct_get_thickness(get_fortran_ptr(), &value);
  return value;
}
double Wall3dSectionProxy::s() const {
  double value;
  wall3d_section_struct_get_s(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> Wall3dSectionProxy::r0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_section_struct_get_r0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double Wall3dSectionProxy::dx0_ds() const {
  double value;
  wall3d_section_struct_get_dx0_ds(get_fortran_ptr(), &value);
  return value;
}
double Wall3dSectionProxy::dy0_ds() const {
  double value;
  wall3d_section_struct_get_dy0_ds(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> Wall3dSectionProxy::x0_coef() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_section_struct_get_x0_coef_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> Wall3dSectionProxy::y0_coef() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_section_struct_get_y0_coef_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double Wall3dSectionProxy::dr_ds() const {
  double value;
  wall3d_section_struct_get_dr_ds(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> Wall3dSectionProxy::p1_coef() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_section_struct_get_p1_coef_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> Wall3dSectionProxy::p2_coef() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_section_struct_get_p2_coef_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string Wall3dProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> Wall3dProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int Wall3dProxy::type() const {
  int value;
  wall3d_struct_get_type(get_fortran_ptr(), &value);
  return value;
}
int Wall3dProxy::ix_wall3d() const {
  int value;
  wall3d_struct_get_ix_wall3d(get_fortran_ptr(), &value);
  return value;
}
int Wall3dProxy::n_link() const {
  int value;
  wall3d_struct_get_n_link(get_fortran_ptr(), &value);
  return value;
}
double Wall3dProxy::thickness() const {
  double value;
  wall3d_struct_get_thickness(get_fortran_ptr(), &value);
  return value;
}
std::string Wall3dProxy::clear_material() const {
  auto char_array = get_clear_material_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> Wall3dProxy::get_clear_material_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_struct_get_clear_material_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string Wall3dProxy::opaque_material() const {
  auto char_array = get_opaque_material_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> Wall3dProxy::get_opaque_material_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  wall3d_struct_get_opaque_material_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
bool Wall3dProxy::superimpose() const {
  bool value;
  wall3d_struct_get_superimpose(get_fortran_ptr(), &value);
  return value;
}
int Wall3dProxy::ele_anchor_pt() const {
  int value;
  wall3d_struct_get_ele_anchor_pt(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<Wall3dSectionProxy> Wall3dProxy::section() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  wall3d_struct_get_section_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<Wall3dSectionProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
int RamperLordProxy::ix_ele() const {
  int value;
  ramper_lord_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int RamperLordProxy::ix_con() const {
  int value;
  ramper_lord_struct_get_ix_con(get_fortran_ptr(), &value);
  return value;
}
double* RamperLordProxy::attrib_ptr() const {
  double* ptr;
  ramper_lord_struct_get_attrib_ptr(get_fortran_ptr(), &ptr);
  return ptr;
}
double ControlProxy::value() const {
  double value;
  control_struct_get_value(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> ControlProxy::y_knot() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  control_struct_get_y_knot_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
FortranTypeArray1D<ExpressionAtomProxy> ControlProxy::stack() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  control_struct_get_stack_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ExpressionAtomProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
LatEleLocProxy ControlProxy::slave() const {
  void* ptr;
  control_struct_get_slave(get_fortran_ptr(), &ptr);
  return LatEleLocProxy(get_fortran_ptr());
}
LatEleLocProxy ControlProxy::lord() const {
  void* ptr;
  control_struct_get_lord(get_fortran_ptr(), &ptr);
  return LatEleLocProxy(get_fortran_ptr());
}
std::string ControlProxy::slave_name() const {
  auto char_array = get_slave_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> ControlProxy::get_slave_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  control_struct_get_slave_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string ControlProxy::attribute() const {
  auto char_array = get_attribute_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> ControlProxy::get_attribute_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  control_struct_get_attribute_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int ControlProxy::ix_attrib() const {
  int value;
  control_struct_get_ix_attrib(get_fortran_ptr(), &value);
  return value;
}
std::string ControlVar1Proxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> ControlVar1Proxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  control_var1_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double ControlVar1Proxy::value() const {
  double value;
  control_var1_struct_get_value(get_fortran_ptr(), &value);
  return value;
}
double ControlVar1Proxy::old_value() const {
  double value;
  control_var1_struct_get_old_value(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> ControlRamp1Proxy::y_knot() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  control_ramp1_struct_get_y_knot_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
FortranTypeArray1D<ExpressionAtomProxy> ControlRamp1Proxy::stack() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  control_ramp1_struct_get_stack_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ExpressionAtomProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
std::string ControlRamp1Proxy::attribute() const {
  auto char_array = get_attribute_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> ControlRamp1Proxy::get_attribute_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  control_ramp1_struct_get_attribute_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string ControlRamp1Proxy::slave_name() const {
  auto char_array = get_slave_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> ControlRamp1Proxy::get_slave_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  control_ramp1_struct_get_slave_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
bool ControlRamp1Proxy::is_controller() const {
  bool value;
  control_ramp1_struct_get_is_controller(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<ControlVar1Proxy> ControllerProxy::var() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  controller_struct_get_var_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ControlVar1Proxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<ControlRamp1Proxy> ControllerProxy::ramp() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  controller_struct_get_ramp_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ControlRamp1Proxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<RamperLordProxy> ControllerProxy::ramper_lord() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  controller_struct_get_ramper_lord_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<RamperLordProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranArray1D<double> ControllerProxy::x_knot() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  controller_struct_get_x_knot_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
int EllipseBeamInitProxy::part_per_ellipse() const {
  int value;
  ellipse_beam_init_struct_get_part_per_ellipse(get_fortran_ptr(), &value);
  return value;
}
int EllipseBeamInitProxy::n_ellipse() const {
  int value;
  ellipse_beam_init_struct_get_n_ellipse(get_fortran_ptr(), &value);
  return value;
}
double EllipseBeamInitProxy::sigma_cutoff() const {
  double value;
  ellipse_beam_init_struct_get_sigma_cutoff(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<int> KvBeamInitProxy::part_per_phi() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;

  kv_beam_init_struct_get_part_per_phi_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int KvBeamInitProxy::n_I2() const {
  int value;
  kv_beam_init_struct_get_n_I2(get_fortran_ptr(), &value);
  return value;
}
double KvBeamInitProxy::A() const {
  double value;
  kv_beam_init_struct_get_A(get_fortran_ptr(), &value);
  return value;
}
int GridBeamInitProxy::n_x() const {
  int value;
  grid_beam_init_struct_get_n_x(get_fortran_ptr(), &value);
  return value;
}
int GridBeamInitProxy::n_px() const {
  int value;
  grid_beam_init_struct_get_n_px(get_fortran_ptr(), &value);
  return value;
}
double GridBeamInitProxy::x_min() const {
  double value;
  grid_beam_init_struct_get_x_min(get_fortran_ptr(), &value);
  return value;
}
double GridBeamInitProxy::x_max() const {
  double value;
  grid_beam_init_struct_get_x_max(get_fortran_ptr(), &value);
  return value;
}
double GridBeamInitProxy::px_min() const {
  double value;
  grid_beam_init_struct_get_px_min(get_fortran_ptr(), &value);
  return value;
}
double GridBeamInitProxy::px_max() const {
  double value;
  grid_beam_init_struct_get_px_max(get_fortran_ptr(), &value);
  return value;
}
std::string BeamInitProxy::position_file() const {
  auto char_array = get_position_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> BeamInitProxy::get_position_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_position_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> BeamInitProxy::spin() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_spin_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<EllipseBeamInitProxy> BeamInitProxy::ellipse() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  beam_init_struct_get_ellipse_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<EllipseBeamInitProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
KvBeamInitProxy BeamInitProxy::KV() const {
  void* ptr;
  beam_init_struct_get_KV(get_fortran_ptr(), &ptr);
  return KvBeamInitProxy(get_fortran_ptr());
}
FortranTypeArray1D<GridBeamInitProxy> BeamInitProxy::grid() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  beam_init_struct_get_grid_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<GridBeamInitProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
FortranArray1D<double> BeamInitProxy::center_jitter() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_center_jitter_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> BeamInitProxy::emit_jitter() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_emit_jitter_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double BeamInitProxy::sig_z_jitter() const {
  double value;
  beam_init_struct_get_sig_z_jitter(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::sig_pz_jitter() const {
  double value;
  beam_init_struct_get_sig_pz_jitter(get_fortran_ptr(), &value);
  return value;
}
int BeamInitProxy::n_particle() const {
  int value;
  beam_init_struct_get_n_particle(get_fortran_ptr(), &value);
  return value;
}
bool BeamInitProxy::renorm_center() const {
  bool value;
  beam_init_struct_get_renorm_center(get_fortran_ptr(), &value);
  return value;
}
bool BeamInitProxy::renorm_sigma() const {
  bool value;
  beam_init_struct_get_renorm_sigma(get_fortran_ptr(), &value);
  return value;
}
std::string BeamInitProxy::random_engine() const {
  auto char_array = get_random_engine_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> BeamInitProxy::get_random_engine_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_random_engine_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string BeamInitProxy::random_gauss_converter() const {
  auto char_array = get_random_gauss_converter_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> BeamInitProxy::get_random_gauss_converter_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_random_gauss_converter_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double BeamInitProxy::random_sigma_cutoff() const {
  double value;
  beam_init_struct_get_random_sigma_cutoff(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::a_norm_emit() const {
  double value;
  beam_init_struct_get_a_norm_emit(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::b_norm_emit() const {
  double value;
  beam_init_struct_get_b_norm_emit(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::a_emit() const {
  double value;
  beam_init_struct_get_a_emit(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::b_emit() const {
  double value;
  beam_init_struct_get_b_emit(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::dPz_dz() const {
  double value;
  beam_init_struct_get_dPz_dz(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> BeamInitProxy::center() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_center_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double BeamInitProxy::t_offset() const {
  double value;
  beam_init_struct_get_t_offset(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::dt_bunch() const {
  double value;
  beam_init_struct_get_dt_bunch(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::sig_z() const {
  double value;
  beam_init_struct_get_sig_z(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::sig_pz() const {
  double value;
  beam_init_struct_get_sig_pz(get_fortran_ptr(), &value);
  return value;
}
double BeamInitProxy::bunch_charge() const {
  double value;
  beam_init_struct_get_bunch_charge(get_fortran_ptr(), &value);
  return value;
}
int BeamInitProxy::n_bunch() const {
  int value;
  beam_init_struct_get_n_bunch(get_fortran_ptr(), &value);
  return value;
}
int BeamInitProxy::ix_turn() const {
  int value;
  beam_init_struct_get_ix_turn(get_fortran_ptr(), &value);
  return value;
}
std::string BeamInitProxy::species() const {
  auto char_array = get_species_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> BeamInitProxy::get_species_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_species_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
bool BeamInitProxy::full_6D_coupling_calc() const {
  bool value;
  beam_init_struct_get_full_6D_coupling_calc(get_fortran_ptr(), &value);
  return value;
}
bool BeamInitProxy::use_particle_start() const {
  bool value;
  beam_init_struct_get_use_particle_start(get_fortran_ptr(), &value);
  return value;
}
bool BeamInitProxy::use_t_coords() const {
  bool value;
  beam_init_struct_get_use_t_coords(get_fortran_ptr(), &value);
  return value;
}
bool BeamInitProxy::use_z_as_t() const {
  bool value;
  beam_init_struct_get_use_z_as_t(get_fortran_ptr(), &value);
  return value;
}
std::string BeamInitProxy::file_name() const {
  auto char_array = get_file_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> BeamInitProxy::get_file_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  beam_init_struct_get_file_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double LatParamProxy::n_part() const {
  double value;
  lat_param_struct_get_n_part(get_fortran_ptr(), &value);
  return value;
}
double LatParamProxy::total_length() const {
  double value;
  lat_param_struct_get_total_length(get_fortran_ptr(), &value);
  return value;
}
double LatParamProxy::unstable_factor() const {
  double value;
  lat_param_struct_get_unstable_factor(get_fortran_ptr(), &value);
  return value;
}
double LatParamProxy::spin_tune() const {
  double value;
  lat_param_struct_get_spin_tune(get_fortran_ptr(), &value);
  return value;
}
int LatParamProxy::particle() const {
  int value;
  lat_param_struct_get_particle(get_fortran_ptr(), &value);
  return value;
}
int LatParamProxy::default_tracking_species() const {
  int value;
  lat_param_struct_get_default_tracking_species(get_fortran_ptr(), &value);
  return value;
}
int LatParamProxy::geometry() const {
  int value;
  lat_param_struct_get_geometry(get_fortran_ptr(), &value);
  return value;
}
int LatParamProxy::ixx() const {
  int value;
  lat_param_struct_get_ixx(get_fortran_ptr(), &value);
  return value;
}
bool LatParamProxy::stable() const {
  bool value;
  lat_param_struct_get_stable(get_fortran_ptr(), &value);
  return value;
}
bool LatParamProxy::live_branch() const {
  bool value;
  lat_param_struct_get_live_branch(get_fortran_ptr(), &value);
  return value;
}
double LatParamProxy::g1_integral() const {
  double value;
  lat_param_struct_get_g1_integral(get_fortran_ptr(), &value);
  return value;
}
double LatParamProxy::g2_integral() const {
  double value;
  lat_param_struct_get_g2_integral(get_fortran_ptr(), &value);
  return value;
}
double LatParamProxy::g3_integral() const {
  double value;
  lat_param_struct_get_g3_integral(get_fortran_ptr(), &value);
  return value;
}
BookkeepingStateProxy LatParamProxy::bookkeeping_state() const {
  void* ptr;
  lat_param_struct_get_bookkeeping_state(get_fortran_ptr(), &ptr);
  return BookkeepingStateProxy(get_fortran_ptr());
}
BeamInitProxy LatParamProxy::beam_init() const {
  void* ptr;
  lat_param_struct_get_beam_init(get_fortran_ptr(), &ptr);
  return BeamInitProxy(get_fortran_ptr());
}
bool ModeInfoProxy::stable() const {
  bool value;
  mode_info_struct_get_stable(get_fortran_ptr(), &value);
  return value;
}
double ModeInfoProxy::tune() const {
  double value;
  mode_info_struct_get_tune(get_fortran_ptr(), &value);
  return value;
}
double ModeInfoProxy::emit() const {
  double value;
  mode_info_struct_get_emit(get_fortran_ptr(), &value);
  return value;
}
double ModeInfoProxy::chrom() const {
  double value;
  mode_info_struct_get_chrom(get_fortran_ptr(), &value);
  return value;
}
double ModeInfoProxy::sigma() const {
  double value;
  mode_info_struct_get_sigma(get_fortran_ptr(), &value);
  return value;
}
double ModeInfoProxy::sigmap() const {
  double value;
  mode_info_struct_get_sigmap(get_fortran_ptr(), &value);
  return value;
}
int PreTrackerProxy::who() const {
  int value;
  pre_tracker_struct_get_who(get_fortran_ptr(), &value);
  return value;
}
int PreTrackerProxy::ix_ele_start() const {
  int value;
  pre_tracker_struct_get_ix_ele_start(get_fortran_ptr(), &value);
  return value;
}
int PreTrackerProxy::ix_ele_end() const {
  int value;
  pre_tracker_struct_get_ix_ele_end(get_fortran_ptr(), &value);
  return value;
}
std::string PreTrackerProxy::input_file() const {
  auto char_array = get_input_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> PreTrackerProxy::get_input_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  pre_tracker_struct_get_input_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double AnormalModeProxy::emittance() const {
  double value;
  anormal_mode_struct_get_emittance(get_fortran_ptr(), &value);
  return value;
}
double AnormalModeProxy::emittance_no_vert() const {
  double value;
  anormal_mode_struct_get_emittance_no_vert(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> AnormalModeProxy::synch_int() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  anormal_mode_struct_get_synch_int_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double AnormalModeProxy::j_damp() const {
  double value;
  anormal_mode_struct_get_j_damp(get_fortran_ptr(), &value);
  return value;
}
double AnormalModeProxy::alpha_damp() const {
  double value;
  anormal_mode_struct_get_alpha_damp(get_fortran_ptr(), &value);
  return value;
}
double AnormalModeProxy::chrom() const {
  double value;
  anormal_mode_struct_get_chrom(get_fortran_ptr(), &value);
  return value;
}
double AnormalModeProxy::tune() const {
  double value;
  anormal_mode_struct_get_tune(get_fortran_ptr(), &value);
  return value;
}
double LinacNormalModeProxy::i2_E4() const {
  double value;
  linac_normal_mode_struct_get_i2_E4(get_fortran_ptr(), &value);
  return value;
}
double LinacNormalModeProxy::i3_E7() const {
  double value;
  linac_normal_mode_struct_get_i3_E7(get_fortran_ptr(), &value);
  return value;
}
double LinacNormalModeProxy::i5a_E6() const {
  double value;
  linac_normal_mode_struct_get_i5a_E6(get_fortran_ptr(), &value);
  return value;
}
double LinacNormalModeProxy::i5b_E6() const {
  double value;
  linac_normal_mode_struct_get_i5b_E6(get_fortran_ptr(), &value);
  return value;
}
double LinacNormalModeProxy::sig_E1() const {
  double value;
  linac_normal_mode_struct_get_sig_E1(get_fortran_ptr(), &value);
  return value;
}
double LinacNormalModeProxy::a_emittance_end() const {
  double value;
  linac_normal_mode_struct_get_a_emittance_end(get_fortran_ptr(), &value);
  return value;
}
double LinacNormalModeProxy::b_emittance_end() const {
  double value;
  linac_normal_mode_struct_get_b_emittance_end(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> NormalModesProxy::synch_int() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  normal_modes_struct_get_synch_int_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double NormalModesProxy::sigE_E() const {
  double value;
  normal_modes_struct_get_sigE_E(get_fortran_ptr(), &value);
  return value;
}
double NormalModesProxy::sig_z() const {
  double value;
  normal_modes_struct_get_sig_z(get_fortran_ptr(), &value);
  return value;
}
double NormalModesProxy::e_loss() const {
  double value;
  normal_modes_struct_get_e_loss(get_fortran_ptr(), &value);
  return value;
}
double NormalModesProxy::rf_voltage() const {
  double value;
  normal_modes_struct_get_rf_voltage(get_fortran_ptr(), &value);
  return value;
}
double NormalModesProxy::pz_aperture() const {
  double value;
  normal_modes_struct_get_pz_aperture(get_fortran_ptr(), &value);
  return value;
}
double NormalModesProxy::pz_average() const {
  double value;
  normal_modes_struct_get_pz_average(get_fortran_ptr(), &value);
  return value;
}
double NormalModesProxy::momentum_compaction() const {
  double value;
  normal_modes_struct_get_momentum_compaction(get_fortran_ptr(), &value);
  return value;
}
double NormalModesProxy::dpz_damp() const {
  double value;
  normal_modes_struct_get_dpz_damp(get_fortran_ptr(), &value);
  return value;
}
AnormalModeProxy NormalModesProxy::a() const {
  void* ptr;
  normal_modes_struct_get_a(get_fortran_ptr(), &ptr);
  return AnormalModeProxy(get_fortran_ptr());
}
AnormalModeProxy NormalModesProxy::b() const {
  void* ptr;
  normal_modes_struct_get_b(get_fortran_ptr(), &ptr);
  return AnormalModeProxy(get_fortran_ptr());
}
AnormalModeProxy NormalModesProxy::z() const {
  void* ptr;
  normal_modes_struct_get_z(get_fortran_ptr(), &ptr);
  return AnormalModeProxy(get_fortran_ptr());
}
LinacNormalModeProxy NormalModesProxy::lin() const {
  void* ptr;
  normal_modes_struct_get_lin(get_fortran_ptr(), &ptr);
  return LinacNormalModeProxy(get_fortran_ptr());
}
FortranArray1D<double> EmFieldProxy::E() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  em_field_struct_get_E_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> EmFieldProxy::B() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  em_field_struct_get_B_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double EmFieldProxy::phi() const {
  double value;
  em_field_struct_get_phi(get_fortran_ptr(), &value);
  return value;
}
double EmFieldProxy::phi_B() const {
  double value;
  em_field_struct_get_phi_B(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> EmFieldProxy::A() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  em_field_struct_get_A_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int StrongBeamProxy::ix_slice() const {
  int value;
  strong_beam_struct_get_ix_slice(get_fortran_ptr(), &value);
  return value;
}
double StrongBeamProxy::x_center() const {
  double value;
  strong_beam_struct_get_x_center(get_fortran_ptr(), &value);
  return value;
}
double StrongBeamProxy::y_center() const {
  double value;
  strong_beam_struct_get_y_center(get_fortran_ptr(), &value);
  return value;
}
double StrongBeamProxy::x_sigma() const {
  double value;
  strong_beam_struct_get_x_sigma(get_fortran_ptr(), &value);
  return value;
}
double StrongBeamProxy::y_sigma() const {
  double value;
  strong_beam_struct_get_y_sigma(get_fortran_ptr(), &value);
  return value;
}
double StrongBeamProxy::dx() const {
  double value;
  strong_beam_struct_get_dx(get_fortran_ptr(), &value);
  return value;
}
double StrongBeamProxy::dy() const {
  double value;
  strong_beam_struct_get_dy(get_fortran_ptr(), &value);
  return value;
}
double TrackPointProxy::s_lab() const {
  double value;
  track_point_struct_get_s_lab(get_fortran_ptr(), &value);
  return value;
}
double TrackPointProxy::s_body() const {
  double value;
  track_point_struct_get_s_body(get_fortran_ptr(), &value);
  return value;
}
CoordProxy TrackPointProxy::orb() const {
  void* ptr;
  track_point_struct_get_orb(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
EmFieldProxy TrackPointProxy::field() const {
  void* ptr;
  track_point_struct_get_field(get_fortran_ptr(), &ptr);
  return EmFieldProxy(get_fortran_ptr());
}
StrongBeamProxy TrackPointProxy::strong_beam() const {
  void* ptr;
  track_point_struct_get_strong_beam(get_fortran_ptr(), &ptr);
  return StrongBeamProxy(get_fortran_ptr());
}
FortranArray1D<double> TrackPointProxy::vec0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  track_point_struct_get_vec0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<TrackPointProxy> TrackProxy::pt() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  track_struct_get_pt_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TrackPointProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double TrackProxy::ds_save() const {
  double value;
  track_struct_get_ds_save(get_fortran_ptr(), &value);
  return value;
}
int TrackProxy::n_pt() const {
  int value;
  track_struct_get_n_pt(get_fortran_ptr(), &value);
  return value;
}
int TrackProxy::n_bad() const {
  int value;
  track_struct_get_n_bad(get_fortran_ptr(), &value);
  return value;
}
int TrackProxy::n_ok() const {
  int value;
  track_struct_get_n_ok(get_fortran_ptr(), &value);
  return value;
}
double SpaceChargeCommonProxy::ds_track_step() const {
  double value;
  space_charge_common_struct_get_ds_track_step(get_fortran_ptr(), &value);
  return value;
}
double SpaceChargeCommonProxy::dt_track_step() const {
  double value;
  space_charge_common_struct_get_dt_track_step(get_fortran_ptr(), &value);
  return value;
}
double SpaceChargeCommonProxy::cathode_strength_cutoff() const {
  double value;
  space_charge_common_struct_get_cathode_strength_cutoff(
      get_fortran_ptr(), &value);
  return value;
}
double SpaceChargeCommonProxy::rel_tol_tracking() const {
  double value;
  space_charge_common_struct_get_rel_tol_tracking(get_fortran_ptr(), &value);
  return value;
}
double SpaceChargeCommonProxy::abs_tol_tracking() const {
  double value;
  space_charge_common_struct_get_abs_tol_tracking(get_fortran_ptr(), &value);
  return value;
}
double SpaceChargeCommonProxy::beam_chamber_height() const {
  double value;
  space_charge_common_struct_get_beam_chamber_height(get_fortran_ptr(), &value);
  return value;
}
double SpaceChargeCommonProxy::lsc_sigma_cutoff() const {
  double value;
  space_charge_common_struct_get_lsc_sigma_cutoff(get_fortran_ptr(), &value);
  return value;
}
double SpaceChargeCommonProxy::particle_sigma_cutoff() const {
  double value;
  space_charge_common_struct_get_particle_sigma_cutoff(
      get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<int> SpaceChargeCommonProxy::space_charge_mesh_size() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;

  space_charge_common_struct_get_space_charge_mesh_size_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<int> SpaceChargeCommonProxy::csr3d_mesh_size() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;

  space_charge_common_struct_get_csr3d_mesh_size_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int SpaceChargeCommonProxy::n_bin() const {
  int value;
  space_charge_common_struct_get_n_bin(get_fortran_ptr(), &value);
  return value;
}
int SpaceChargeCommonProxy::particle_bin_span() const {
  int value;
  space_charge_common_struct_get_particle_bin_span(get_fortran_ptr(), &value);
  return value;
}
int SpaceChargeCommonProxy::n_shield_images() const {
  int value;
  space_charge_common_struct_get_n_shield_images(get_fortran_ptr(), &value);
  return value;
}
int SpaceChargeCommonProxy::sc_min_in_bin() const {
  int value;
  space_charge_common_struct_get_sc_min_in_bin(get_fortran_ptr(), &value);
  return value;
}
bool SpaceChargeCommonProxy::lsc_kick_transverse_dependence() const {
  bool value;
  space_charge_common_struct_get_lsc_kick_transverse_dependence(
      get_fortran_ptr(), &value);
  return value;
}
bool SpaceChargeCommonProxy::debug() const {
  bool value;
  space_charge_common_struct_get_debug(get_fortran_ptr(), &value);
  return value;
}
std::string SpaceChargeCommonProxy::diagnostic_output_file() const {
  auto char_array = get_diagnostic_output_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> SpaceChargeCommonProxy::get_diagnostic_output_file_chars()
    const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  space_charge_common_struct_get_diagnostic_output_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double BmadCommonProxy::max_aperture_limit() const {
  double value;
  bmad_common_struct_get_max_aperture_limit(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> BmadCommonProxy::d_orb() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  bmad_common_struct_get_d_orb_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double BmadCommonProxy::default_ds_step() const {
  double value;
  bmad_common_struct_get_default_ds_step(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::significant_length() const {
  double value;
  bmad_common_struct_get_significant_length(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::rel_tol_tracking() const {
  double value;
  bmad_common_struct_get_rel_tol_tracking(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::abs_tol_tracking() const {
  double value;
  bmad_common_struct_get_abs_tol_tracking(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::rel_tol_adaptive_tracking() const {
  double value;
  bmad_common_struct_get_rel_tol_adaptive_tracking(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::abs_tol_adaptive_tracking() const {
  double value;
  bmad_common_struct_get_abs_tol_adaptive_tracking(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::init_ds_adaptive_tracking() const {
  double value;
  bmad_common_struct_get_init_ds_adaptive_tracking(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::min_ds_adaptive_tracking() const {
  double value;
  bmad_common_struct_get_min_ds_adaptive_tracking(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::fatal_ds_adaptive_tracking() const {
  double value;
  bmad_common_struct_get_fatal_ds_adaptive_tracking(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::autoscale_amp_abs_tol() const {
  double value;
  bmad_common_struct_get_autoscale_amp_abs_tol(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::autoscale_amp_rel_tol() const {
  double value;
  bmad_common_struct_get_autoscale_amp_rel_tol(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::autoscale_phase_tol() const {
  double value;
  bmad_common_struct_get_autoscale_phase_tol(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::electric_dipole_moment() const {
  double value;
  bmad_common_struct_get_electric_dipole_moment(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::synch_rad_scale() const {
  double value;
  bmad_common_struct_get_synch_rad_scale(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::sad_eps_scale() const {
  double value;
  bmad_common_struct_get_sad_eps_scale(get_fortran_ptr(), &value);
  return value;
}
double BmadCommonProxy::sad_amp_max() const {
  double value;
  bmad_common_struct_get_sad_amp_max(get_fortran_ptr(), &value);
  return value;
}
int BmadCommonProxy::sad_n_div_max() const {
  int value;
  bmad_common_struct_get_sad_n_div_max(get_fortran_ptr(), &value);
  return value;
}
int BmadCommonProxy::taylor_order() const {
  int value;
  bmad_common_struct_get_taylor_order(get_fortran_ptr(), &value);
  return value;
}
int BmadCommonProxy::runge_kutta_order() const {
  int value;
  bmad_common_struct_get_runge_kutta_order(get_fortran_ptr(), &value);
  return value;
}
int BmadCommonProxy::default_integ_order() const {
  int value;
  bmad_common_struct_get_default_integ_order(get_fortran_ptr(), &value);
  return value;
}
int BmadCommonProxy::max_num_runge_kutta_step() const {
  int value;
  bmad_common_struct_get_max_num_runge_kutta_step(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::rf_phase_below_transition_ref() const {
  bool value;
  bmad_common_struct_get_rf_phase_below_transition_ref(
      get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::sr_wakes_on() const {
  bool value;
  bmad_common_struct_get_sr_wakes_on(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::lr_wakes_on() const {
  bool value;
  bmad_common_struct_get_lr_wakes_on(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::auto_bookkeeper() const {
  bool value;
  bmad_common_struct_get_auto_bookkeeper(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::high_energy_space_charge_on() const {
  bool value;
  bmad_common_struct_get_high_energy_space_charge_on(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::csr_and_space_charge_on() const {
  bool value;
  bmad_common_struct_get_csr_and_space_charge_on(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::spin_tracking_on() const {
  bool value;
  bmad_common_struct_get_spin_tracking_on(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::spin_sokolov_ternov_flipping_on() const {
  bool value;
  bmad_common_struct_get_spin_sokolov_ternov_flipping_on(
      get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::radiation_damping_on() const {
  bool value;
  bmad_common_struct_get_radiation_damping_on(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::radiation_zero_average() const {
  bool value;
  bmad_common_struct_get_radiation_zero_average(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::radiation_fluctuations_on() const {
  bool value;
  bmad_common_struct_get_radiation_fluctuations_on(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::conserve_taylor_maps() const {
  bool value;
  bmad_common_struct_get_conserve_taylor_maps(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::absolute_time_tracking() const {
  bool value;
  bmad_common_struct_get_absolute_time_tracking(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::absolute_time_ref_shift() const {
  bool value;
  bmad_common_struct_get_absolute_time_ref_shift(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::convert_to_kinetic_momentum() const {
  bool value;
  bmad_common_struct_get_convert_to_kinetic_momentum(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::normalize_twiss() const {
  bool value;
  bmad_common_struct_get_normalize_twiss(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::aperture_limit_on() const {
  bool value;
  bmad_common_struct_get_aperture_limit_on(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::spin_n0_direction_user_set() const {
  bool value;
  bmad_common_struct_get_spin_n0_direction_user_set(get_fortran_ptr(), &value);
  return value;
}
bool BmadCommonProxy::debug() const {
  bool value;
  bmad_common_struct_get_debug(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i0() const {
  double value;
  rad_int1_struct_get_i0(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i1() const {
  double value;
  rad_int1_struct_get_i1(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i2() const {
  double value;
  rad_int1_struct_get_i2(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i3() const {
  double value;
  rad_int1_struct_get_i3(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i4a() const {
  double value;
  rad_int1_struct_get_i4a(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i4b() const {
  double value;
  rad_int1_struct_get_i4b(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i4z() const {
  double value;
  rad_int1_struct_get_i4z(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i5a() const {
  double value;
  rad_int1_struct_get_i5a(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i5b() const {
  double value;
  rad_int1_struct_get_i5b(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::i6b() const {
  double value;
  rad_int1_struct_get_i6b(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::lin_i2_E4() const {
  double value;
  rad_int1_struct_get_lin_i2_E4(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::lin_i3_E7() const {
  double value;
  rad_int1_struct_get_lin_i3_E7(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::lin_i5a_E6() const {
  double value;
  rad_int1_struct_get_lin_i5a_E6(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::lin_i5b_E6() const {
  double value;
  rad_int1_struct_get_lin_i5b_E6(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::lin_norm_emit_a() const {
  double value;
  rad_int1_struct_get_lin_norm_emit_a(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::lin_norm_emit_b() const {
  double value;
  rad_int1_struct_get_lin_norm_emit_b(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::lin_sig_E() const {
  double value;
  rad_int1_struct_get_lin_sig_E(get_fortran_ptr(), &value);
  return value;
}
double RadInt1Proxy::n_steps() const {
  double value;
  rad_int1_struct_get_n_steps(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<RadInt1Proxy> RadIntBranchProxy::ele() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  rad_int_branch_struct_get_ele_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<RadInt1Proxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<RadIntBranchProxy> RadIntAllEleProxy::branch() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  rad_int_all_ele_struct_get_branch_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<RadIntBranchProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double RfStairStepProxy::E_tot0() const {
  double value;
  rf_stair_step_struct_get_E_tot0(get_fortran_ptr(), &value);
  return value;
}
double RfStairStepProxy::E_tot1() const {
  double value;
  rf_stair_step_struct_get_E_tot1(get_fortran_ptr(), &value);
  return value;
}
double RfStairStepProxy::p0c() const {
  double value;
  rf_stair_step_struct_get_p0c(get_fortran_ptr(), &value);
  return value;
}
double RfStairStepProxy::p1c() const {
  double value;
  rf_stair_step_struct_get_p1c(get_fortran_ptr(), &value);
  return value;
}
double RfStairStepProxy::dE_amp() const {
  double value;
  rf_stair_step_struct_get_dE_amp(get_fortran_ptr(), &value);
  return value;
}
double RfStairStepProxy::scale() const {
  double value;
  rf_stair_step_struct_get_scale(get_fortran_ptr(), &value);
  return value;
}
double RfStairStepProxy::time() const {
  double value;
  rf_stair_step_struct_get_time(get_fortran_ptr(), &value);
  return value;
}
double RfStairStepProxy::s() const {
  double value;
  rf_stair_step_struct_get_s(get_fortran_ptr(), &value);
  return value;
}
int RfStairStepProxy::ix_step() const {
  int value;
  rf_stair_step_struct_get_ix_step(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<RfStairStepProxy> RfEleProxy::steps() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  rf_ele_struct_get_steps_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<RfStairStepProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double RfEleProxy::ds_step() const {
  double value;
  rf_ele_struct_get_ds_step(get_fortran_ptr(), &value);
  return value;
}
std::string EleProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> EleProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  ele_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string EleProxy::type() const {
  auto char_array = get_type_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> EleProxy::get_type_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  ele_struct_get_type_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string EleProxy::alias() const {
  auto char_array = get_alias_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> EleProxy::get_alias_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  ele_struct_get_alias_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string EleProxy::component_name() const {
  auto char_array = get_component_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> EleProxy::get_component_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  ele_struct_get_component_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string EleProxy::descrip() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  ele_struct_get_descrip_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  if (!is_allocated || size_out == 0) {
    return std::string();
  }

  return std::string(data_ptr, size_out);
}
FortranArray1D<char> EleProxy::get_descrip_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  ele_struct_get_descrip_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
TwissProxy EleProxy::a() const {
  void* ptr;
  ele_struct_get_a(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy EleProxy::b() const {
  void* ptr;
  ele_struct_get_b(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy EleProxy::z() const {
  void* ptr;
  ele_struct_get_z(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
XyDispProxy EleProxy::x() const {
  void* ptr;
  ele_struct_get_x(get_fortran_ptr(), &ptr);
  return XyDispProxy(get_fortran_ptr());
}
XyDispProxy EleProxy::y() const {
  void* ptr;
  ele_struct_get_y(get_fortran_ptr(), &ptr);
  return XyDispProxy(get_fortran_ptr());
}
const void* EleProxy::ac_kick() const {
  void* ptr;
  ele_struct_get_ac_kick(get_fortran_ptr(), &ptr);
  return ptr;
}
BookkeepingStateProxy EleProxy::bookkeeping_state() const {
  void* ptr;
  ele_struct_get_bookkeeping_state(get_fortran_ptr(), &ptr);
  return BookkeepingStateProxy(get_fortran_ptr());
}
const void* EleProxy::branch() const {
  void* ptr;
  ele_struct_get_branch(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* EleProxy::control() const {
  void* ptr;
  ele_struct_get_control(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* EleProxy::rf() const {
  void* ptr;
  ele_struct_get_rf(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* EleProxy::lord() const {
  void* ptr;
  ele_struct_get_lord(get_fortran_ptr(), &ptr);
  return ptr;
}
FloorPositionProxy EleProxy::floor() const {
  void* ptr;
  ele_struct_get_floor(get_fortran_ptr(), &ptr);
  return FloorPositionProxy(get_fortran_ptr());
}
const void* EleProxy::high_energy_space_charge() const {
  void* ptr;
  ele_struct_get_high_energy_space_charge(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* EleProxy::mode3() const {
  void* ptr;
  ele_struct_get_mode3(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* EleProxy::photon() const {
  void* ptr;
  ele_struct_get_photon(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* EleProxy::rad_map() const {
  void* ptr;
  ele_struct_get_rad_map(get_fortran_ptr(), &ptr);
  return ptr;
}
FortranTypeArray1D<TaylorProxy> EleProxy::taylor() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  ele_struct_get_taylor_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<TaylorProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
FortranArray1D<double> EleProxy::spin_taylor_ref_orb_in() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  ele_struct_get_spin_taylor_ref_orb_in_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<TaylorProxy> EleProxy::spin_taylor() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  ele_struct_get_spin_taylor_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<TaylorProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
const void* EleProxy::wake() const {
  void* ptr;
  ele_struct_get_wake(get_fortran_ptr(), &ptr);
  return ptr;
}
FortranTypeArray1D<Wall3dProxy> EleProxy::wall3d() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  ele_struct_get_wall3d_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<Wall3dProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<CartesianMapProxy> EleProxy::cartesian_map() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  ele_struct_get_cartesian_map_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CartesianMapProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<CylindricalMapProxy> EleProxy::cylindrical_map() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  ele_struct_get_cylindrical_map_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CylindricalMapProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<GenGradMapProxy> EleProxy::gen_grad_map() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  ele_struct_get_gen_grad_map_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<GenGradMapProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<GridFieldProxy> EleProxy::grid_field() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  ele_struct_get_grid_field_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<GridFieldProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
CoordProxy EleProxy::map_ref_orb_in() const {
  void* ptr;
  ele_struct_get_map_ref_orb_in(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
CoordProxy EleProxy::map_ref_orb_out() const {
  void* ptr;
  ele_struct_get_map_ref_orb_out(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
CoordProxy EleProxy::time_ref_orb_in() const {
  void* ptr;
  ele_struct_get_time_ref_orb_in(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
CoordProxy EleProxy::time_ref_orb_out() const {
  void* ptr;
  ele_struct_get_time_ref_orb_out(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
FortranArray1D<double> EleProxy::value() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  ele_struct_get_value_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> EleProxy::old_value() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  ele_struct_get_old_value_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> EleProxy::vec0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  ele_struct_get_vec0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double EleProxy::gamma_c() const {
  double value;
  ele_struct_get_gamma_c(get_fortran_ptr(), &value);
  return value;
}
double EleProxy::s_start() const {
  double value;
  ele_struct_get_s_start(get_fortran_ptr(), &value);
  return value;
}
double EleProxy::s() const {
  double value;
  ele_struct_get_s(get_fortran_ptr(), &value);
  return value;
}
double EleProxy::ref_time() const {
  double value;
  ele_struct_get_ref_time(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::key() const {
  int value;
  ele_struct_get_key(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::sub_key() const {
  int value;
  ele_struct_get_sub_key(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::ix_ele() const {
  int value;
  ele_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::ix_branch() const {
  int value;
  ele_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::lord_status() const {
  int value;
  ele_struct_get_lord_status(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::n_slave() const {
  int value;
  ele_struct_get_n_slave(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::n_slave_field() const {
  int value;
  ele_struct_get_n_slave_field(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::ix1_slave() const {
  int value;
  ele_struct_get_ix1_slave(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::slave_status() const {
  int value;
  ele_struct_get_slave_status(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::n_lord() const {
  int value;
  ele_struct_get_n_lord(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::n_lord_field() const {
  int value;
  ele_struct_get_n_lord_field(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::n_lord_ramper() const {
  int value;
  ele_struct_get_n_lord_ramper(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::ic1_lord() const {
  int value;
  ele_struct_get_ic1_lord(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::ix_pointer() const {
  int value;
  ele_struct_get_ix_pointer(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::ixx() const {
  int value;
  ele_struct_get_ixx(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::iyy() const {
  int value;
  ele_struct_get_iyy(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::izz() const {
  int value;
  ele_struct_get_izz(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::mat6_calc_method() const {
  int value;
  ele_struct_get_mat6_calc_method(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::tracking_method() const {
  int value;
  ele_struct_get_tracking_method(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::spin_tracking_method() const {
  int value;
  ele_struct_get_spin_tracking_method(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::csr_method() const {
  int value;
  ele_struct_get_csr_method(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::space_charge_method() const {
  int value;
  ele_struct_get_space_charge_method(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::ptc_integration_type() const {
  int value;
  ele_struct_get_ptc_integration_type(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::field_calc() const {
  int value;
  ele_struct_get_field_calc(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::aperture_at() const {
  int value;
  ele_struct_get_aperture_at(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::aperture_type() const {
  int value;
  ele_struct_get_aperture_type(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::ref_species() const {
  int value;
  ele_struct_get_ref_species(get_fortran_ptr(), &value);
  return value;
}
int EleProxy::orientation() const {
  int value;
  ele_struct_get_orientation(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::symplectify() const {
  bool value;
  ele_struct_get_symplectify(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::mode_flip() const {
  bool value;
  ele_struct_get_mode_flip(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::multipoles_on() const {
  bool value;
  ele_struct_get_multipoles_on(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::scale_multipoles() const {
  bool value;
  ele_struct_get_scale_multipoles(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::taylor_map_includes_offsets() const {
  bool value;
  ele_struct_get_taylor_map_includes_offsets(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::field_master() const {
  bool value;
  ele_struct_get_field_master(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::is_on() const {
  bool value;
  ele_struct_get_is_on(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::logic() const {
  bool value;
  ele_struct_get_logic(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::bmad_logic() const {
  bool value;
  ele_struct_get_bmad_logic(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::select() const {
  bool value;
  ele_struct_get_select(get_fortran_ptr(), &value);
  return value;
}
bool EleProxy::offset_moves_aperture() const {
  bool value;
  ele_struct_get_offset_moves_aperture(get_fortran_ptr(), &value);
  return value;
}
std::complex<double> ComplexTaylorTermProxy::coef() const {
  std::complex<double> c_value;
  complex_taylor_term_struct_get_coef(get_fortran_ptr(), &c_value);
  return c_value;
}
FortranArray1D<int> ComplexTaylorTermProxy::expn() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;

  complex_taylor_term_struct_get_expn_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::complex<double> ComplexTaylorProxy::ref() const {
  std::complex<double> c_value;
  complex_taylor_struct_get_ref(get_fortran_ptr(), &c_value);
  return c_value;
}
FortranTypeArray1D<ComplexTaylorTermProxy> ComplexTaylorProxy::term() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  complex_taylor_struct_get_term_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ComplexTaylorTermProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
std::string BranchProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> BranchProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  branch_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int BranchProxy::ix_branch() const {
  int value;
  branch_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
int BranchProxy::ix_from_branch() const {
  int value;
  branch_struct_get_ix_from_branch(get_fortran_ptr(), &value);
  return value;
}
int BranchProxy::ix_from_ele() const {
  int value;
  branch_struct_get_ix_from_ele(get_fortran_ptr(), &value);
  return value;
}
int BranchProxy::ix_to_ele() const {
  int value;
  branch_struct_get_ix_to_ele(get_fortran_ptr(), &value);
  return value;
}
int BranchProxy::ix_fixer() const {
  int value;
  branch_struct_get_ix_fixer(get_fortran_ptr(), &value);
  return value;
}
int BranchProxy::n_ele_track() const {
  int value;
  branch_struct_get_n_ele_track(get_fortran_ptr(), &value);
  return value;
}
int BranchProxy::n_ele_max() const {
  int value;
  branch_struct_get_n_ele_max(get_fortran_ptr(), &value);
  return value;
}
const void* BranchProxy::lat() const {
  void* ptr;
  branch_struct_get_lat(get_fortran_ptr(), &ptr);
  return ptr;
}
ModeInfoProxy BranchProxy::a() const {
  void* ptr;
  branch_struct_get_a(get_fortran_ptr(), &ptr);
  return ModeInfoProxy(get_fortran_ptr());
}
ModeInfoProxy BranchProxy::b() const {
  void* ptr;
  branch_struct_get_b(get_fortran_ptr(), &ptr);
  return ModeInfoProxy(get_fortran_ptr());
}
ModeInfoProxy BranchProxy::z() const {
  void* ptr;
  branch_struct_get_z(get_fortran_ptr(), &ptr);
  return ModeInfoProxy(get_fortran_ptr());
}
FortranTypeArray1D<EleProxy> BranchProxy::ele() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  branch_struct_get_ele_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<EleProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
LatParamProxy BranchProxy::param() const {
  void* ptr;
  branch_struct_get_param(get_fortran_ptr(), &ptr);
  return LatParamProxy(get_fortran_ptr());
}
CoordProxy BranchProxy::particle_start() const {
  void* ptr;
  branch_struct_get_particle_start(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
FortranTypeArray1D<Wall3dProxy> BranchProxy::wall3d() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  branch_struct_get_wall3d_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<Wall3dProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
std::string LatProxy::use_name() const {
  auto char_array = get_use_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> LatProxy::get_use_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  lat_struct_get_use_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string LatProxy::lattice() const {
  auto char_array = get_lattice_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> LatProxy::get_lattice_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  lat_struct_get_lattice_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string LatProxy::machine() const {
  auto char_array = get_machine_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> LatProxy::get_machine_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  lat_struct_get_machine_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string LatProxy::input_file_name() const {
  auto char_array = get_input_file_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> LatProxy::get_input_file_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  lat_struct_get_input_file_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string LatProxy::title() const {
  auto char_array = get_title_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> LatProxy::get_title_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  lat_struct_get_title_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<ExpressionAtomProxy> LatProxy::constant() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  lat_struct_get_constant_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ExpressionAtomProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
const void* LatProxy::a() const {
  void* ptr;
  lat_struct_get_a(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* LatProxy::b() const {
  void* ptr;
  lat_struct_get_b(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* LatProxy::z() const {
  void* ptr;
  lat_struct_get_z(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* LatProxy::param() const {
  void* ptr;
  lat_struct_get_param(get_fortran_ptr(), &ptr);
  return ptr;
}
BookkeepingStateProxy LatProxy::lord_state() const {
  void* ptr;
  lat_struct_get_lord_state(get_fortran_ptr(), &ptr);
  return BookkeepingStateProxy(get_fortran_ptr());
}
EleProxy LatProxy::ele_init() const {
  void* ptr;
  lat_struct_get_ele_init(get_fortran_ptr(), &ptr);
  return EleProxy(get_fortran_ptr());
}
FortranTypeArray1D<BranchProxy> LatProxy::branch() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  lat_struct_get_branch_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<BranchProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<ControlProxy> LatProxy::control() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  lat_struct_get_control_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ControlProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
const void* LatProxy::particle_start() const {
  void* ptr;
  lat_struct_get_particle_start(get_fortran_ptr(), &ptr);
  return ptr;
}
BeamInitProxy LatProxy::beam_init() const {
  void* ptr;
  lat_struct_get_beam_init(get_fortran_ptr(), &ptr);
  return BeamInitProxy(get_fortran_ptr());
}
PreTrackerProxy LatProxy::pre_tracker() const {
  void* ptr;
  lat_struct_get_pre_tracker(get_fortran_ptr(), &ptr);
  return PreTrackerProxy(get_fortran_ptr());
}
FortranArray1D<double> LatProxy::custom() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  lat_struct_get_custom_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
int LatProxy::version() const {
  int value;
  lat_struct_get_version(get_fortran_ptr(), &value);
  return value;
}
int* LatProxy::n_ele_track() const {
  int* ptr;
  lat_struct_get_n_ele_track(get_fortran_ptr(), &ptr);
  return ptr;
}
int* LatProxy::n_ele_max() const {
  int* ptr;
  lat_struct_get_n_ele_max(get_fortran_ptr(), &ptr);
  return ptr;
}
int LatProxy::n_control_max() const {
  int value;
  lat_struct_get_n_control_max(get_fortran_ptr(), &value);
  return value;
}
int LatProxy::n_ic_max() const {
  int value;
  lat_struct_get_n_ic_max(get_fortran_ptr(), &value);
  return value;
}
int LatProxy::input_taylor_order() const {
  int value;
  lat_struct_get_input_taylor_order(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<int> LatProxy::ic() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  lat_struct_get_ic_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
int LatProxy::photon_type() const {
  int value;
  lat_struct_get_photon_type(get_fortran_ptr(), &value);
  return value;
}
int LatProxy::creation_hash() const {
  int value;
  lat_struct_get_creation_hash(get_fortran_ptr(), &value);
  return value;
}
int LatProxy::ramper_slave_bookkeeping() const {
  int value;
  lat_struct_get_ramper_slave_bookkeeping(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<CoordProxy> BunchProxy::particle() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  bunch_struct_get_particle_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CoordProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranArray1D<int> BunchProxy::ix_z() const {
  int* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  bunch_struct_get_ix_z_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<int>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
double BunchProxy::charge_tot() const {
  double value;
  bunch_struct_get_charge_tot(get_fortran_ptr(), &value);
  return value;
}
double BunchProxy::charge_live() const {
  double value;
  bunch_struct_get_charge_live(get_fortran_ptr(), &value);
  return value;
}
double BunchProxy::z_center() const {
  double value;
  bunch_struct_get_z_center(get_fortran_ptr(), &value);
  return value;
}
double BunchProxy::t_center() const {
  double value;
  bunch_struct_get_t_center(get_fortran_ptr(), &value);
  return value;
}
double BunchProxy::t0() const {
  double value;
  bunch_struct_get_t0(get_fortran_ptr(), &value);
  return value;
}
bool BunchProxy::drift_between_t_and_s() const {
  bool value;
  bunch_struct_get_drift_between_t_and_s(get_fortran_ptr(), &value);
  return value;
}
int BunchProxy::ix_ele() const {
  int value;
  bunch_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int BunchProxy::ix_bunch() const {
  int value;
  bunch_struct_get_ix_bunch(get_fortran_ptr(), &value);
  return value;
}
int BunchProxy::ix_turn() const {
  int value;
  bunch_struct_get_ix_turn(get_fortran_ptr(), &value);
  return value;
}
int BunchProxy::n_live() const {
  int value;
  bunch_struct_get_n_live(get_fortran_ptr(), &value);
  return value;
}
int BunchProxy::n_good() const {
  int value;
  bunch_struct_get_n_good(get_fortran_ptr(), &value);
  return value;
}
int BunchProxy::n_bad() const {
  int value;
  bunch_struct_get_n_bad(get_fortran_ptr(), &value);
  return value;
}
CoordProxy BunchParamsProxy::centroid() const {
  void* ptr;
  bunch_params_struct_get_centroid(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
TwissProxy BunchParamsProxy::x() const {
  void* ptr;
  bunch_params_struct_get_x(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy BunchParamsProxy::y() const {
  void* ptr;
  bunch_params_struct_get_y(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy BunchParamsProxy::z() const {
  void* ptr;
  bunch_params_struct_get_z(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy BunchParamsProxy::a() const {
  void* ptr;
  bunch_params_struct_get_a(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy BunchParamsProxy::b() const {
  void* ptr;
  bunch_params_struct_get_b(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
TwissProxy BunchParamsProxy::c() const {
  void* ptr;
  bunch_params_struct_get_c(get_fortran_ptr(), &ptr);
  return TwissProxy(get_fortran_ptr());
}
FortranArray1D<double> BunchParamsProxy::rel_max() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  bunch_params_struct_get_rel_max_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> BunchParamsProxy::rel_min() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  bunch_params_struct_get_rel_min_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double BunchParamsProxy::s() const {
  double value;
  bunch_params_struct_get_s(get_fortran_ptr(), &value);
  return value;
}
double BunchParamsProxy::t() const {
  double value;
  bunch_params_struct_get_t(get_fortran_ptr(), &value);
  return value;
}
double BunchParamsProxy::sigma_t() const {
  double value;
  bunch_params_struct_get_sigma_t(get_fortran_ptr(), &value);
  return value;
}
double BunchParamsProxy::charge_live() const {
  double value;
  bunch_params_struct_get_charge_live(get_fortran_ptr(), &value);
  return value;
}
double BunchParamsProxy::charge_tot() const {
  double value;
  bunch_params_struct_get_charge_tot(get_fortran_ptr(), &value);
  return value;
}
int BunchParamsProxy::n_particle_tot() const {
  int value;
  bunch_params_struct_get_n_particle_tot(get_fortran_ptr(), &value);
  return value;
}
int BunchParamsProxy::n_particle_live() const {
  int value;
  bunch_params_struct_get_n_particle_live(get_fortran_ptr(), &value);
  return value;
}
int BunchParamsProxy::n_particle_lost_in_ele() const {
  int value;
  bunch_params_struct_get_n_particle_lost_in_ele(get_fortran_ptr(), &value);
  return value;
}
int BunchParamsProxy::n_good_steps() const {
  int value;
  bunch_params_struct_get_n_good_steps(get_fortran_ptr(), &value);
  return value;
}
int BunchParamsProxy::n_bad_steps() const {
  int value;
  bunch_params_struct_get_n_bad_steps(get_fortran_ptr(), &value);
  return value;
}
int BunchParamsProxy::ix_ele() const {
  int value;
  bunch_params_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int BunchParamsProxy::location() const {
  int value;
  bunch_params_struct_get_location(get_fortran_ptr(), &value);
  return value;
}
bool BunchParamsProxy::twiss_valid() const {
  bool value;
  bunch_params_struct_get_twiss_valid(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<BunchProxy> BeamProxy::bunch() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  beam_struct_get_bunch_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<BunchProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double AperturePointProxy::x() const {
  double value;
  aperture_point_struct_get_x(get_fortran_ptr(), &value);
  return value;
}
double AperturePointProxy::y() const {
  double value;
  aperture_point_struct_get_y(get_fortran_ptr(), &value);
  return value;
}
int AperturePointProxy::plane() const {
  int value;
  aperture_point_struct_get_plane(get_fortran_ptr(), &value);
  return value;
}
int AperturePointProxy::ix_ele() const {
  int value;
  aperture_point_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int AperturePointProxy::i_turn() const {
  int value;
  aperture_point_struct_get_i_turn(get_fortran_ptr(), &value);
  return value;
}
double ApertureParamProxy::min_angle() const {
  double value;
  aperture_param_struct_get_min_angle(get_fortran_ptr(), &value);
  return value;
}
double ApertureParamProxy::max_angle() const {
  double value;
  aperture_param_struct_get_max_angle(get_fortran_ptr(), &value);
  return value;
}
int ApertureParamProxy::n_angle() const {
  int value;
  aperture_param_struct_get_n_angle(get_fortran_ptr(), &value);
  return value;
}
int ApertureParamProxy::n_turn() const {
  int value;
  aperture_param_struct_get_n_turn(get_fortran_ptr(), &value);
  return value;
}
double ApertureParamProxy::x_init() const {
  double value;
  aperture_param_struct_get_x_init(get_fortran_ptr(), &value);
  return value;
}
double ApertureParamProxy::y_init() const {
  double value;
  aperture_param_struct_get_y_init(get_fortran_ptr(), &value);
  return value;
}
double ApertureParamProxy::rel_accuracy() const {
  double value;
  aperture_param_struct_get_rel_accuracy(get_fortran_ptr(), &value);
  return value;
}
double ApertureParamProxy::abs_accuracy() const {
  double value;
  aperture_param_struct_get_abs_accuracy(get_fortran_ptr(), &value);
  return value;
}
std::string ApertureParamProxy::start_ele() const {
  auto char_array = get_start_ele_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> ApertureParamProxy::get_start_ele_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  aperture_param_struct_get_start_ele_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<AperturePointProxy> ApertureScanProxy::point() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  aperture_scan_struct_get_point_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<AperturePointProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
CoordProxy ApertureScanProxy::ref_orb() const {
  void* ptr;
  aperture_scan_struct_get_ref_orb(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
double ApertureScanProxy::pz_start() const {
  double value;
  aperture_scan_struct_get_pz_start(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> TaoSpinDnDpzProxy::vec() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_spin_dn_dpz_struct_get_vec_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string ResonanceHProxy::id() const {
  auto char_array = get_id_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> ResonanceHProxy::get_id_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  resonance_h_struct_get_id_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::complex<double> ResonanceHProxy::c_val() const {
  std::complex<double> c_value;
  resonance_h_struct_get_c_val(get_fortran_ptr(), &c_value);
  return c_value;
}
FortranArray1D<double> SpinOrbitMap1Proxy::vec0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  spin_orbit_map1_struct_get_vec0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> SpinAxisProxy::l() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  spin_axis_struct_get_l_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> SpinAxisProxy::n0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  spin_axis_struct_get_n0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> SpinAxisProxy::m() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  spin_axis_struct_get_m_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
const void* PtcNormalFormProxy::ele_origin() const {
  void* ptr;
  ptc_normal_form_struct_get_ele_origin(get_fortran_ptr(), &ptr);
  return ptr;
}
FortranArray1D<double> PtcNormalFormProxy::orb0() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  ptc_normal_form_struct_get_orb0_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
bool PtcNormalFormProxy::valid_map() const {
  bool value;
  ptc_normal_form_struct_get_valid_map(get_fortran_ptr(), &value);
  return value;
}
const void* BmadNormalFormProxy::ele_origin() const {
  void* ptr;
  bmad_normal_form_struct_get_ele_origin(get_fortran_ptr(), &ptr);
  return ptr;
}
FortranTypeArray1D<TaylorProxy> BmadNormalFormProxy::M() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  bmad_normal_form_struct_get_M_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<TaylorProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
FortranTypeArray1D<TaylorProxy> BmadNormalFormProxy::A() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  bmad_normal_form_struct_get_A_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<TaylorProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
FortranTypeArray1D<TaylorProxy> BmadNormalFormProxy::A_inv() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  bmad_normal_form_struct_get_A_inv_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<TaylorProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
FortranTypeArray1D<TaylorProxy> BmadNormalFormProxy::dhdj() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  bmad_normal_form_struct_get_dhdj_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<TaylorProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
FortranTypeArray1D<ComplexTaylorProxy> BmadNormalFormProxy::F() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  bmad_normal_form_struct_get_F_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<ComplexTaylorProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
FortranTypeArray1D<ComplexTaylorProxy> BmadNormalFormProxy::L() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  size_t element_size;

  bmad_normal_form_struct_get_L_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &element_size);

  return FortranTypeArray1D<ComplexTaylorProxy>(
      data_ptr, size_out, lower_bound, upper_bound, true, element_size);
}
FortranTypeArray1D<ResonanceHProxy> BmadNormalFormProxy::h() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  bmad_normal_form_struct_get_h_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ResonanceHProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<BunchParamsProxy> BunchTrackProxy::pt() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  bunch_track_struct_get_pt_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<BunchParamsProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double BunchTrackProxy::ds_save() const {
  double value;
  bunch_track_struct_get_ds_save(get_fortran_ptr(), &value);
  return value;
}
int BunchTrackProxy::n_pt() const {
  int value;
  bunch_track_struct_get_n_pt(get_fortran_ptr(), &value);
  return value;
}
std::complex<double> SummationRdtProxy::h11001() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h11001(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h00111() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h00111(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h20001() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h20001(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h00201() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h00201(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h10002() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h10002(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h21000() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h21000(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h30000() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h30000(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h10110() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h10110(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h10020() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h10020(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h10200() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h10200(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h31000() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h31000(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h40000() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h40000(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h20110() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h20110(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h11200() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h11200(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h20020() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h20020(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h20200() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h20200(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h00310() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h00310(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h00400() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h00400(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h22000() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h22000(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h00220() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h00220(get_fortran_ptr(), &c_value);
  return c_value;
}
std::complex<double> SummationRdtProxy::h11110() const {
  std::complex<double> c_value;
  summation_rdt_struct_get_h11110(get_fortran_ptr(), &c_value);
  return c_value;
}
int LatEleOrder1Proxy::ix_branch() const {
  int value;
  lat_ele_order1_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
int LatEleOrder1Proxy::ix_order() const {
  int value;
  lat_ele_order1_struct_get_ix_order(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<LatEleOrder1Proxy> LatEleOrderArrayProxy::ele() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  lat_ele_order_array_struct_get_ele_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<LatEleOrder1Proxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
TaoSpinDnDpzProxy TaoSpinEleProxy::dn_dpz() const {
  void* ptr;
  tao_spin_ele_struct_get_dn_dpz(get_fortran_ptr(), &ptr);
  return TaoSpinDnDpzProxy(get_fortran_ptr());
}
FortranArray1D<double> TaoSpinEleProxy::orb_eigen_val() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_spin_ele_struct_get_orb_eigen_val_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
bool TaoSpinEleProxy::valid() const {
  bool value;
  tao_spin_ele_struct_get_valid(get_fortran_ptr(), &value);
  return value;
}
EleProxy TaoPlotCacheProxy::ele_to_s() const {
  void* ptr;
  tao_plot_cache_struct_get_ele_to_s(get_fortran_ptr(), &ptr);
  return EleProxy(get_fortran_ptr());
}
CoordProxy TaoPlotCacheProxy::orbit() const {
  void* ptr;
  tao_plot_cache_struct_get_orbit(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
bool TaoPlotCacheProxy::err() const {
  bool value;
  tao_plot_cache_struct_get_err(get_fortran_ptr(), &value);
  return value;
}
double TaoSpinPolarizationProxy::tune() const {
  double value;
  tao_spin_polarization_struct_get_tune(get_fortran_ptr(), &value);
  return value;
}
double TaoSpinPolarizationProxy::pol_limit_st() const {
  double value;
  tao_spin_polarization_struct_get_pol_limit_st(get_fortran_ptr(), &value);
  return value;
}
double TaoSpinPolarizationProxy::pol_limit_dk() const {
  double value;
  tao_spin_polarization_struct_get_pol_limit_dk(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> TaoSpinPolarizationProxy::pol_limit_dk_partial() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_spin_polarization_struct_get_pol_limit_dk_partial_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> TaoSpinPolarizationProxy::pol_limit_dk_partial2() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_spin_polarization_struct_get_pol_limit_dk_partial2_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double TaoSpinPolarizationProxy::pol_rate_bks() const {
  double value;
  tao_spin_polarization_struct_get_pol_rate_bks(get_fortran_ptr(), &value);
  return value;
}
double TaoSpinPolarizationProxy::depol_rate() const {
  double value;
  tao_spin_polarization_struct_get_depol_rate(get_fortran_ptr(), &value);
  return value;
}
FortranArray1D<double> TaoSpinPolarizationProxy::depol_rate_partial() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_spin_polarization_struct_get_depol_rate_partial_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranArray1D<double> TaoSpinPolarizationProxy::depol_rate_partial2() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_spin_polarization_struct_get_depol_rate_partial2_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
double TaoSpinPolarizationProxy::integral_bn() const {
  double value;
  tao_spin_polarization_struct_get_integral_bn(get_fortran_ptr(), &value);
  return value;
}
double TaoSpinPolarizationProxy::integral_bdn() const {
  double value;
  tao_spin_polarization_struct_get_integral_bdn(get_fortran_ptr(), &value);
  return value;
}
double TaoSpinPolarizationProxy::integral_1ns() const {
  double value;
  tao_spin_polarization_struct_get_integral_1ns(get_fortran_ptr(), &value);
  return value;
}
double TaoSpinPolarizationProxy::integral_dn2() const {
  double value;
  tao_spin_polarization_struct_get_integral_dn2(get_fortran_ptr(), &value);
  return value;
}
bool TaoSpinPolarizationProxy::valid() const {
  bool value;
  tao_spin_polarization_struct_get_valid(get_fortran_ptr(), &value);
  return value;
}
SpinOrbitMap1Proxy TaoSpinPolarizationProxy::q_1turn() const {
  void* ptr;
  tao_spin_polarization_struct_get_q_1turn(get_fortran_ptr(), &ptr);
  return SpinOrbitMap1Proxy(get_fortran_ptr());
}
FortranTypeArray1D<SpinOrbitMap1Proxy> TaoSpinPolarizationProxy::q_ele() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_spin_polarization_struct_get_q_ele_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<SpinOrbitMap1Proxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<TaoLatSigmaProxy> TaoLatticeBranchProxy::lat_sigma() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_branch_struct_get_lat_sigma_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoLatSigmaProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<TaoSpinEleProxy> TaoLatticeBranchProxy::spin_ele() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_branch_struct_get_spin_ele_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoSpinEleProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<BunchParamsProxy> TaoLatticeBranchProxy::bunch_params()
    const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_branch_struct_get_bunch_params_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<BunchParamsProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<BunchTrackProxy> TaoLatticeBranchProxy::bunch_params_comb()
    const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_branch_struct_get_bunch_params_comb_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<BunchTrackProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<CoordProxy> TaoLatticeBranchProxy::orbit() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_branch_struct_get_orbit_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CoordProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<TaoPlotCacheProxy> TaoLatticeBranchProxy::plot_cache()
    const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_branch_struct_get_plot_cache_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoPlotCacheProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
TaoSpinPolarizationProxy TaoLatticeBranchProxy::spin() const {
  void* ptr;
  tao_lattice_branch_struct_get_spin(get_fortran_ptr(), &ptr);
  return TaoSpinPolarizationProxy(get_fortran_ptr());
}
SummationRdtProxy TaoLatticeBranchProxy::srdt() const {
  void* ptr;
  tao_lattice_branch_struct_get_srdt(get_fortran_ptr(), &ptr);
  return SummationRdtProxy(get_fortran_ptr());
}
CoordProxy TaoLatticeBranchProxy::orb0() const {
  void* ptr;
  tao_lattice_branch_struct_get_orb0(get_fortran_ptr(), &ptr);
  return CoordProxy(get_fortran_ptr());
}
NormalModesProxy TaoLatticeBranchProxy::modes_ri() const {
  void* ptr;
  tao_lattice_branch_struct_get_modes_ri(get_fortran_ptr(), &ptr);
  return NormalModesProxy(get_fortran_ptr());
}
NormalModesProxy TaoLatticeBranchProxy::modes_6d() const {
  void* ptr;
  tao_lattice_branch_struct_get_modes_6d(get_fortran_ptr(), &ptr);
  return NormalModesProxy(get_fortran_ptr());
}
PtcNormalFormProxy TaoLatticeBranchProxy::ptc_normal_form() const {
  void* ptr;
  tao_lattice_branch_struct_get_ptc_normal_form(get_fortran_ptr(), &ptr);
  return PtcNormalFormProxy(get_fortran_ptr());
}
BmadNormalFormProxy TaoLatticeBranchProxy::bmad_normal_form() const {
  void* ptr;
  tao_lattice_branch_struct_get_bmad_normal_form(get_fortran_ptr(), &ptr);
  return BmadNormalFormProxy(get_fortran_ptr());
}
FortranTypeArray1D<CoordProxy> TaoLatticeBranchProxy::high_E_orb() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_branch_struct_get_high_E_orb_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CoordProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<CoordProxy> TaoLatticeBranchProxy::low_E_orb() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_branch_struct_get_low_E_orb_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<CoordProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
double TaoLatticeBranchProxy::cache_x_min() const {
  double value;
  tao_lattice_branch_struct_get_cache_x_min(get_fortran_ptr(), &value);
  return value;
}
double TaoLatticeBranchProxy::cache_x_max() const {
  double value;
  tao_lattice_branch_struct_get_cache_x_max(get_fortran_ptr(), &value);
  return value;
}
double TaoLatticeBranchProxy::comb_ds_save() const {
  double value;
  tao_lattice_branch_struct_get_comb_ds_save(get_fortran_ptr(), &value);
  return value;
}
int TaoLatticeBranchProxy::track_state() const {
  int value;
  tao_lattice_branch_struct_get_track_state(get_fortran_ptr(), &value);
  return value;
}
int TaoLatticeBranchProxy::cache_n_pts() const {
  int value;
  tao_lattice_branch_struct_get_cache_n_pts(get_fortran_ptr(), &value);
  return value;
}
int TaoLatticeBranchProxy::ix_rad_int_cache() const {
  int value;
  tao_lattice_branch_struct_get_ix_rad_int_cache(get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::has_open_match_element() const {
  bool value;
  tao_lattice_branch_struct_get_has_open_match_element(
      get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::plot_cache_valid() const {
  bool value;
  tao_lattice_branch_struct_get_plot_cache_valid(get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::spin_map_valid() const {
  bool value;
  tao_lattice_branch_struct_get_spin_map_valid(get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::twiss_valid() const {
  bool value;
  tao_lattice_branch_struct_get_twiss_valid(get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::mode_flip_here() const {
  bool value;
  tao_lattice_branch_struct_get_mode_flip_here(get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::chrom_calc_ok() const {
  bool value;
  tao_lattice_branch_struct_get_chrom_calc_ok(get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::rad_int_calc_ok() const {
  bool value;
  tao_lattice_branch_struct_get_rad_int_calc_ok(get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::emit_6d_calc_ok() const {
  bool value;
  tao_lattice_branch_struct_get_emit_6d_calc_ok(get_fortran_ptr(), &value);
  return value;
}
bool TaoLatticeBranchProxy::sigma_track_ok() const {
  bool value;
  tao_lattice_branch_struct_get_sigma_track_ok(get_fortran_ptr(), &value);
  return value;
}
BeamProxy TaoModelElementProxy::beam() const {
  void* ptr;
  tao_model_element_struct_get_beam(get_fortran_ptr(), &ptr);
  return BeamProxy(get_fortran_ptr());
}
bool TaoModelElementProxy::save_beam_internally() const {
  bool value;
  tao_model_element_struct_get_save_beam_internally(get_fortran_ptr(), &value);
  return value;
}
bool TaoModelElementProxy::save_beam_to_file() const {
  bool value;
  tao_model_element_struct_get_save_beam_to_file(get_fortran_ptr(), &value);
  return value;
}
BeamProxy TaoBeamBranchProxy::beam_at_start() const {
  void* ptr;
  tao_beam_branch_struct_get_beam_at_start(get_fortran_ptr(), &ptr);
  return BeamProxy(get_fortran_ptr());
}
BeamInitProxy TaoBeamBranchProxy::beam_init() const {
  void* ptr;
  tao_beam_branch_struct_get_beam_init(get_fortran_ptr(), &ptr);
  return BeamInitProxy(get_fortran_ptr());
}
BeamInitProxy TaoBeamBranchProxy::beam_init_used() const {
  void* ptr;
  tao_beam_branch_struct_get_beam_init_used(get_fortran_ptr(), &ptr);
  return BeamInitProxy(get_fortran_ptr());
}
bool TaoBeamBranchProxy::init_starting_distribution() const {
  bool value;
  tao_beam_branch_struct_get_init_starting_distribution(
      get_fortran_ptr(), &value);
  return value;
}
std::string TaoBeamBranchProxy::track_start() const {
  auto char_array = get_track_start_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoBeamBranchProxy::get_track_start_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_beam_branch_struct_get_track_start_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoBeamBranchProxy::track_end() const {
  auto char_array = get_track_end_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoBeamBranchProxy::get_track_end_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_beam_branch_struct_get_track_end_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int TaoBeamBranchProxy::ix_branch() const {
  int value;
  tao_beam_branch_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
int TaoBeamBranchProxy::ix_track_start() const {
  int value;
  tao_beam_branch_struct_get_ix_track_start(get_fortran_ptr(), &value);
  return value;
}
int TaoBeamBranchProxy::ix_track_end() const {
  int value;
  tao_beam_branch_struct_get_ix_track_end(get_fortran_ptr(), &value);
  return value;
}
std::string TaoD1DataProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoD1DataProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_d1_data_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoLatticeProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoLatticeProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_lattice_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
LatProxy TaoLatticeProxy::lat() const {
  void* ptr;
  tao_lattice_struct_get_lat(get_fortran_ptr(), &ptr);
  return LatProxy(get_fortran_ptr());
}
LatProxy TaoLatticeProxy::high_E_lat() const {
  void* ptr;
  tao_lattice_struct_get_high_E_lat(get_fortran_ptr(), &ptr);
  return LatProxy(get_fortran_ptr());
}
LatProxy TaoLatticeProxy::low_E_lat() const {
  void* ptr;
  tao_lattice_struct_get_low_E_lat(get_fortran_ptr(), &ptr);
  return LatProxy(get_fortran_ptr());
}
RadIntAllEleProxy TaoLatticeProxy::rad_int_by_ele_ri() const {
  void* ptr;
  tao_lattice_struct_get_rad_int_by_ele_ri(get_fortran_ptr(), &ptr);
  return RadIntAllEleProxy(get_fortran_ptr());
}
RadIntAllEleProxy TaoLatticeProxy::rad_int_by_ele_6d() const {
  void* ptr;
  tao_lattice_struct_get_rad_int_by_ele_6d(get_fortran_ptr(), &ptr);
  return RadIntAllEleProxy(get_fortran_ptr());
}
FortranTypeArray1D<TaoLatticeBranchProxy> TaoLatticeProxy::tao_branch() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_lattice_struct_get_tao_branch_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoLatticeBranchProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
std::string TaoBeamUniProxy::saved_at() const {
  auto char_array = get_saved_at_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoBeamUniProxy::get_saved_at_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_beam_uni_struct_get_saved_at_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoBeamUniProxy::dump_file() const {
  auto char_array = get_dump_file_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoBeamUniProxy::get_dump_file_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_beam_uni_struct_get_dump_file_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoBeamUniProxy::dump_at() const {
  auto char_array = get_dump_at_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoBeamUniProxy::get_dump_at_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_beam_uni_struct_get_dump_at_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
bool TaoBeamUniProxy::track_beam_in_universe() const {
  bool value;
  tao_beam_uni_struct_get_track_beam_in_universe(get_fortran_ptr(), &value);
  return value;
}
bool TaoBeamUniProxy::always_reinit() const {
  bool value;
  tao_beam_uni_struct_get_always_reinit(get_fortran_ptr(), &value);
  return value;
}
ApertureParamProxy TaoDynamicApertureProxy::param() const {
  void* ptr;
  tao_dynamic_aperture_struct_get_param(get_fortran_ptr(), &ptr);
  return ApertureParamProxy(get_fortran_ptr());
}
FortranTypeArray1D<ApertureScanProxy> TaoDynamicApertureProxy::scan() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_dynamic_aperture_struct_get_scan_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<ApertureScanProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranArray1D<double> TaoDynamicApertureProxy::pz() const {
  double* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;

  tao_dynamic_aperture_struct_get_pz_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated);

  return FortranArray1D<double>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated);
}
double TaoDynamicApertureProxy::ellipse_scale() const {
  double value;
  tao_dynamic_aperture_struct_get_ellipse_scale(get_fortran_ptr(), &value);
  return value;
}
double TaoDynamicApertureProxy::a_emit() const {
  double value;
  tao_dynamic_aperture_struct_get_a_emit(get_fortran_ptr(), &value);
  return value;
}
double TaoDynamicApertureProxy::b_emit() const {
  double value;
  tao_dynamic_aperture_struct_get_b_emit(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<TaoModelElementProxy> TaoModelBranchProxy::ele() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_model_branch_struct_get_ele_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoModelElementProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
TaoBeamBranchProxy TaoModelBranchProxy::beam() const {
  void* ptr;
  tao_model_branch_struct_get_beam(get_fortran_ptr(), &ptr);
  return TaoBeamBranchProxy(get_fortran_ptr());
}
std::string TaoD2DataProxy::name() const {
  auto char_array = get_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoD2DataProxy::get_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_d2_data_struct_get_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoD2DataProxy::data_file_name() const {
  auto char_array = get_data_file_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoD2DataProxy::get_data_file_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_d2_data_struct_get_data_file_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoD2DataProxy::ref_file_name() const {
  auto char_array = get_ref_file_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoD2DataProxy::get_ref_file_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_d2_data_struct_get_ref_file_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoD2DataProxy::data_date() const {
  auto char_array = get_data_date_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoD2DataProxy::get_data_date_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_d2_data_struct_get_data_date_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoD2DataProxy::ref_date() const {
  auto char_array = get_ref_date_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoD2DataProxy::get_ref_date_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_d2_data_struct_get_ref_date_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
FortranTypeArray1D<TaoD1DataProxy> TaoD2DataProxy::d1() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_d2_data_struct_get_d1_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoD1DataProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
int TaoD2DataProxy::ix_universe() const {
  int value;
  tao_d2_data_struct_get_ix_universe(get_fortran_ptr(), &value);
  return value;
}
int TaoD2DataProxy::ix_d2_data() const {
  int value;
  tao_d2_data_struct_get_ix_d2_data(get_fortran_ptr(), &value);
  return value;
}
int TaoD2DataProxy::ix_ref() const {
  int value;
  tao_d2_data_struct_get_ix_ref(get_fortran_ptr(), &value);
  return value;
}
bool TaoD2DataProxy::data_read_in() const {
  bool value;
  tao_d2_data_struct_get_data_read_in(get_fortran_ptr(), &value);
  return value;
}
bool TaoD2DataProxy::ref_read_in() const {
  bool value;
  tao_d2_data_struct_get_ref_read_in(get_fortran_ptr(), &value);
  return value;
}
bool TaoSpinMapProxy::valid() const {
  bool value;
  tao_spin_map_struct_get_valid(get_fortran_ptr(), &value);
  return value;
}
SpinOrbitMap1Proxy TaoSpinMapProxy::map1() const {
  void* ptr;
  tao_spin_map_struct_get_map1(get_fortran_ptr(), &ptr);
  return SpinOrbitMap1Proxy(get_fortran_ptr());
}
SpinAxisProxy TaoSpinMapProxy::axis_input() const {
  void* ptr;
  tao_spin_map_struct_get_axis_input(get_fortran_ptr(), &ptr);
  return SpinAxisProxy(get_fortran_ptr());
}
SpinAxisProxy TaoSpinMapProxy::axis0() const {
  void* ptr;
  tao_spin_map_struct_get_axis0(get_fortran_ptr(), &ptr);
  return SpinAxisProxy(get_fortran_ptr());
}
SpinAxisProxy TaoSpinMapProxy::axis1() const {
  void* ptr;
  tao_spin_map_struct_get_axis1(get_fortran_ptr(), &ptr);
  return SpinAxisProxy(get_fortran_ptr());
}
int TaoSpinMapProxy::ix_ele() const {
  int value;
  tao_spin_map_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int TaoSpinMapProxy::ix_ref() const {
  int value;
  tao_spin_map_struct_get_ix_ref(get_fortran_ptr(), &value);
  return value;
}
int TaoSpinMapProxy::ix_uni() const {
  int value;
  tao_spin_map_struct_get_ix_uni(get_fortran_ptr(), &value);
  return value;
}
int TaoSpinMapProxy::ix_branch() const {
  int value;
  tao_spin_map_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
std::string TaoDataProxy::ele_name() const {
  auto char_array = get_ele_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoDataProxy::get_ele_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_data_struct_get_ele_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoDataProxy::ele_start_name() const {
  auto char_array = get_ele_start_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoDataProxy::get_ele_start_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_data_struct_get_ele_start_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoDataProxy::ele_ref_name() const {
  auto char_array = get_ele_ref_name_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoDataProxy::get_ele_ref_name_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_data_struct_get_ele_ref_name_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoDataProxy::merit_type() const {
  auto char_array = get_merit_type_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoDataProxy::get_merit_type_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_data_struct_get_merit_type_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoDataProxy::id() const {
  auto char_array = get_id_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoDataProxy::get_id_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_data_struct_get_id_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoDataProxy::data_source() const {
  auto char_array = get_data_source_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoDataProxy::get_data_source_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_data_struct_get_data_source_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
std::string TaoDataProxy::why_invalid() const {
  auto char_array = get_why_invalid_chars();
  return std::string(char_array.data(), char_array.size());
}
FortranArray1D<char> TaoDataProxy::get_why_invalid_chars() const {
  char* data_ptr;
  int size_out, lower_bound, upper_bound;

  tao_data_struct_get_why_invalid_info(
      get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound);

  return FortranArray1D<char>(
      data_ptr, size_out, lower_bound, upper_bound, true);
}
int TaoDataProxy::ix_uni() const {
  int value;
  tao_data_struct_get_ix_uni(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_bunch() const {
  int value;
  tao_data_struct_get_ix_bunch(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_branch() const {
  int value;
  tao_data_struct_get_ix_branch(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_ele() const {
  int value;
  tao_data_struct_get_ix_ele(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_ele_start() const {
  int value;
  tao_data_struct_get_ix_ele_start(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_ele_ref() const {
  int value;
  tao_data_struct_get_ix_ele_ref(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_ele_merit() const {
  int value;
  tao_data_struct_get_ix_ele_merit(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_d1() const {
  int value;
  tao_data_struct_get_ix_d1(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_data() const {
  int value;
  tao_data_struct_get_ix_data(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::ix_dModel() const {
  int value;
  tao_data_struct_get_ix_dModel(get_fortran_ptr(), &value);
  return value;
}
int TaoDataProxy::eval_point() const {
  int value;
  tao_data_struct_get_eval_point(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::meas_value() const {
  double value;
  tao_data_struct_get_meas_value(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::ref_value() const {
  double value;
  tao_data_struct_get_ref_value(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::model_value() const {
  double value;
  tao_data_struct_get_model_value(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::design_value() const {
  double value;
  tao_data_struct_get_design_value(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::old_value() const {
  double value;
  tao_data_struct_get_old_value(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::base_value() const {
  double value;
  tao_data_struct_get_base_value(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::error_rms() const {
  double value;
  tao_data_struct_get_error_rms(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::delta_merit() const {
  double value;
  tao_data_struct_get_delta_merit(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::weight() const {
  double value;
  tao_data_struct_get_weight(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::invalid_value() const {
  double value;
  tao_data_struct_get_invalid_value(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::merit() const {
  double value;
  tao_data_struct_get_merit(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::s() const {
  double value;
  tao_data_struct_get_s(get_fortran_ptr(), &value);
  return value;
}
double TaoDataProxy::s_offset() const {
  double value;
  tao_data_struct_get_s_offset(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::err_message_printed() const {
  bool value;
  tao_data_struct_get_err_message_printed(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::exists() const {
  bool value;
  tao_data_struct_get_exists(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::good_model() const {
  bool value;
  tao_data_struct_get_good_model(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::good_base() const {
  bool value;
  tao_data_struct_get_good_base(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::good_design() const {
  bool value;
  tao_data_struct_get_good_design(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::good_meas() const {
  bool value;
  tao_data_struct_get_good_meas(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::good_ref() const {
  bool value;
  tao_data_struct_get_good_ref(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::good_user() const {
  bool value;
  tao_data_struct_get_good_user(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::good_opt() const {
  bool value;
  tao_data_struct_get_good_opt(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::good_plot() const {
  bool value;
  tao_data_struct_get_good_plot(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::useit_plot() const {
  bool value;
  tao_data_struct_get_useit_plot(get_fortran_ptr(), &value);
  return value;
}
bool TaoDataProxy::useit_opt() const {
  bool value;
  tao_data_struct_get_useit_opt(get_fortran_ptr(), &value);
  return value;
}
TaoSpinMapProxy TaoDataProxy::spin_map() const {
  void* ptr;
  tao_data_struct_get_spin_map(get_fortran_ptr(), &ptr);
  return TaoSpinMapProxy(get_fortran_ptr());
}
const void* TaoDataProxy::d1() const {
  void* ptr;
  tao_data_struct_get_d1(get_fortran_ptr(), &ptr);
  return ptr;
}
double TaoPingScaleProxy::a_mode_meas() const {
  double value;
  tao_ping_scale_struct_get_a_mode_meas(get_fortran_ptr(), &value);
  return value;
}
double TaoPingScaleProxy::a_mode_ref() const {
  double value;
  tao_ping_scale_struct_get_a_mode_ref(get_fortran_ptr(), &value);
  return value;
}
double TaoPingScaleProxy::b_mode_meas() const {
  double value;
  tao_ping_scale_struct_get_b_mode_meas(get_fortran_ptr(), &value);
  return value;
}
double TaoPingScaleProxy::b_mode_ref() const {
  double value;
  tao_ping_scale_struct_get_b_mode_ref(get_fortran_ptr(), &value);
  return value;
}
int TaoUniverseCalcProxy::srdt_for_data() const {
  int value;
  tao_universe_calc_struct_get_srdt_for_data(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::rad_int_for_data() const {
  bool value;
  tao_universe_calc_struct_get_rad_int_for_data(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::rad_int_for_plotting() const {
  bool value;
  tao_universe_calc_struct_get_rad_int_for_plotting(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::chrom_for_data() const {
  bool value;
  tao_universe_calc_struct_get_chrom_for_data(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::chrom_for_plotting() const {
  bool value;
  tao_universe_calc_struct_get_chrom_for_plotting(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::lat_sigma_for_data() const {
  bool value;
  tao_universe_calc_struct_get_lat_sigma_for_data(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::lat_sigma_for_plotting() const {
  bool value;
  tao_universe_calc_struct_get_lat_sigma_for_plotting(
      get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::dynamic_aperture() const {
  bool value;
  tao_universe_calc_struct_get_dynamic_aperture(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::one_turn_map() const {
  bool value;
  tao_universe_calc_struct_get_one_turn_map(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::lattice() const {
  bool value;
  tao_universe_calc_struct_get_lattice(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::twiss() const {
  bool value;
  tao_universe_calc_struct_get_twiss(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::track() const {
  bool value;
  tao_universe_calc_struct_get_track(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseCalcProxy::spin_matrices() const {
  bool value;
  tao_universe_calc_struct_get_spin_matrices(get_fortran_ptr(), &value);
  return value;
}
FortranTypeArray1D<LatEleOrderArrayProxy> LatEleOrderProxy::branch() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  lat_ele_order_struct_get_branch_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<LatEleOrderArrayProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
const void* TaoUniverseProxy::model() const {
  void* ptr;
  tao_universe_struct_get_model(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* TaoUniverseProxy::design() const {
  void* ptr;
  tao_universe_struct_get_design(get_fortran_ptr(), &ptr);
  return ptr;
}
const void* TaoUniverseProxy::base() const {
  void* ptr;
  tao_universe_struct_get_base(get_fortran_ptr(), &ptr);
  return ptr;
}
TaoBeamUniProxy TaoUniverseProxy::beam() const {
  void* ptr;
  tao_universe_struct_get_beam(get_fortran_ptr(), &ptr);
  return TaoBeamUniProxy(get_fortran_ptr());
}
TaoDynamicApertureProxy TaoUniverseProxy::dynamic_aperture() const {
  void* ptr;
  tao_universe_struct_get_dynamic_aperture(get_fortran_ptr(), &ptr);
  return TaoDynamicApertureProxy(get_fortran_ptr());
}
FortranTypeArray1D<TaoModelBranchProxy> TaoUniverseProxy::model_branch() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_universe_struct_get_model_branch_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoModelBranchProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<TaoD2DataProxy> TaoUniverseProxy::d2_data() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_universe_struct_get_d2_data_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoD2DataProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
FortranTypeArray1D<TaoDataProxy> TaoUniverseProxy::data() const {
  void* data_ptr;
  int size_out, lower_bound, upper_bound;
  bool is_allocated;
  size_t element_size;

  tao_universe_struct_get_data_info(
      get_fortran_ptr(),
      &data_ptr,
      &size_out,
      &lower_bound,
      &upper_bound,
      &is_allocated,
      &element_size);

  return FortranTypeArray1D<TaoDataProxy>(
      data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
}
TaoPingScaleProxy TaoUniverseProxy::ping_scale() const {
  void* ptr;
  tao_universe_struct_get_ping_scale(get_fortran_ptr(), &ptr);
  return TaoPingScaleProxy(get_fortran_ptr());
}
LatProxy TaoUniverseProxy::scratch_lat() const {
  void* ptr;
  tao_universe_struct_get_scratch_lat(get_fortran_ptr(), &ptr);
  return LatProxy(get_fortran_ptr());
}
TaoUniverseCalcProxy TaoUniverseProxy::calc() const {
  void* ptr;
  tao_universe_struct_get_calc(get_fortran_ptr(), &ptr);
  return TaoUniverseCalcProxy(get_fortran_ptr());
}
LatEleOrderProxy TaoUniverseProxy::ele_order() const {
  void* ptr;
  tao_universe_struct_get_ele_order(get_fortran_ptr(), &ptr);
  return LatEleOrderProxy(get_fortran_ptr());
}
TaoSpinMapProxy TaoUniverseProxy::spin_map() const {
  void* ptr;
  tao_universe_struct_get_spin_map(get_fortran_ptr(), &ptr);
  return TaoSpinMapProxy(get_fortran_ptr());
}
FortranArray2D<double> TaoUniverseProxy::dModel_dVar() const {
  double* data_ptr;
  int dim1_size, dim1_lower, dim1_upper;
  int dim2_size, dim2_lower, dim2_upper;
  int stride1, stride2;
  bool is_allocated;

  tao_universe_struct_get_dModel_dVar_info(
      get_fortran_ptr(),
      &data_ptr,
      &dim1_size,
      &dim1_lower,
      &dim1_upper,
      &dim2_size,
      &dim2_lower,
      &dim2_upper,
      &stride1,
      &stride2,
      &is_allocated);

  return FortranArray2D<double>(
      data_ptr,
      dim1_size,
      dim1_lower,
      dim1_upper,
      dim2_size,
      dim2_lower,
      dim2_upper,
      stride1,
      stride2,
      is_allocated);
}
int TaoUniverseProxy::ix_uni() const {
  int value;
  tao_universe_struct_get_ix_uni(get_fortran_ptr(), &value);
  return value;
}
int TaoUniverseProxy::n_d2_data_used() const {
  int value;
  tao_universe_struct_get_n_d2_data_used(get_fortran_ptr(), &value);
  return value;
}
int TaoUniverseProxy::n_data_used() const {
  int value;
  tao_universe_struct_get_n_data_used(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseProxy::is_on() const {
  bool value;
  tao_universe_struct_get_is_on(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseProxy::design_same_as_previous() const {
  bool value;
  tao_universe_struct_get_design_same_as_previous(get_fortran_ptr(), &value);
  return value;
}
bool TaoUniverseProxy::picked_uni() const {
  bool value;
  tao_universe_struct_get_picked_uni(get_fortran_ptr(), &value);
  return value;
}