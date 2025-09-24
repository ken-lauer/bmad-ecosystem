#pragma once

#include "fortran_arrays.hpp"
#include "proxy_base.hpp"

#include <complex>
#include <iterator>
#include <memory>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

extern "C" {
// Forward declarations for Fortran interface

void spline_struct_get_x0(const void* struct_obj, double* value_out);

void spline_struct_get_y0(const void* struct_obj, double* value_out);

void spline_struct_get_x1(const void* struct_obj, double* value_out);

void spline_struct_get_coef_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void spin_polar_struct_get_polarization(
    const void* struct_obj,
    double* value_out);

void spin_polar_struct_get_theta(const void* struct_obj, double* value_out);

void spin_polar_struct_get_phi(const void* struct_obj, double* value_out);

void spin_polar_struct_get_xi(const void* struct_obj, double* value_out);

void ac_kicker_time_struct_get_amp(const void* struct_obj, double* value_out);

void ac_kicker_time_struct_get_time(const void* struct_obj, double* value_out);

void ac_kicker_time_struct_get_spline(const void* struct_obj, void** ptr_out);

void ac_kicker_freq_struct_get_f(const void* struct_obj, double* value_out);

void ac_kicker_freq_struct_get_amp(const void* struct_obj, double* value_out);

void ac_kicker_freq_struct_get_phi(const void* struct_obj, double* value_out);

void ac_kicker_freq_struct_get_rf_clock_harmonic(
    const void* struct_obj,
    int* value_out);

void ac_kicker_struct_get_amp_vs_time_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void ac_kicker_struct_get_frequency_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void interval1_coef_struct_get_c0(const void* struct_obj, double* value_out);

void interval1_coef_struct_get_c1(const void* struct_obj, double* value_out);

void interval1_coef_struct_get_n_exp(const void* struct_obj, double* value_out);

void photon_reflect_table_struct_get_angle_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void photon_reflect_table_struct_get_energy_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void photon_reflect_table_struct_get_int1_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void photon_reflect_table_struct_get_p_reflect_info(
    const void* struct_obj,
    double** data_ptr,
    int* dim1_size,
    int* dim1_lower,
    int* dim1_upper,
    int* dim2_size,
    int* dim2_lower,
    int* dim2_upper,
    int* stride1,
    int* stride2,
    bool* is_allocated);

void photon_reflect_table_struct_get_max_energy(
    const void* struct_obj,
    double* value_out);

void photon_reflect_table_struct_get_p_reflect_scratch_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void photon_reflect_table_struct_get_bragg_angle_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void photon_reflect_surface_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void photon_reflect_surface_struct_get_description_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void photon_reflect_surface_struct_get_reflectivity_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void photon_reflect_surface_struct_get_table_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void photon_reflect_surface_struct_get_surface_roughness_rms(
    const void* struct_obj,
    double* value_out);

void photon_reflect_surface_struct_get_roughness_correlation_len(
    const void* struct_obj,
    double* value_out);

void photon_reflect_surface_struct_get_ix_surface(
    const void* struct_obj,
    int* value_out);

void coord_struct_get_vec_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void coord_struct_get_s(const void* struct_obj, double* value_out);

void coord_struct_get_t(const void* struct_obj, long double* value_out);

void coord_struct_get_spin_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void coord_struct_get_field_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void coord_struct_get_phase_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void coord_struct_get_charge(const void* struct_obj, double* value_out);

void coord_struct_get_dt_ref(const void* struct_obj, double* value_out);

void coord_struct_get_r(const void* struct_obj, double* value_out);

void coord_struct_get_p0c(const void* struct_obj, double* value_out);

void coord_struct_get_E_potential(const void* struct_obj, double* value_out);

void coord_struct_get_beta(const void* struct_obj, double* value_out);

void coord_struct_get_ix_ele(const void* struct_obj, int* value_out);

void coord_struct_get_ix_branch(const void* struct_obj, int* value_out);

void coord_struct_get_ix_turn(const void* struct_obj, int* value_out);

void coord_struct_get_ix_user(const void* struct_obj, int* value_out);

void coord_struct_get_state(const void* struct_obj, int* value_out);

void coord_struct_get_direction(const void* struct_obj, int* value_out);

void coord_struct_get_time_dir(const void* struct_obj, int* value_out);

void coord_struct_get_species(const void* struct_obj, int* value_out);

void coord_struct_get_location(const void* struct_obj, int* value_out);

void coord_array_struct_get_orbit_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void bpm_phase_coupling_struct_get_K_22a(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_K_12a(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_K_11b(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_K_12b(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_Cbar22_a(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_Cbar12_a(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_Cbar11_b(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_Cbar12_b(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_phi_a(
    const void* struct_obj,
    double* value_out);

void bpm_phase_coupling_struct_get_phi_b(
    const void* struct_obj,
    double* value_out);

void expression_atom_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void expression_atom_struct_get_type(const void* struct_obj, int* value_out);

void expression_atom_struct_get_value(
    const void* struct_obj,
    double* value_out);

void wake_sr_z_long_struct_get_w_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void wake_sr_z_long_struct_get_dz(const void* struct_obj, double* value_out);

void wake_sr_z_long_struct_get_z0(const void* struct_obj, double* value_out);

void wake_sr_z_long_struct_get_smoothing_sigma(
    const void* struct_obj,
    double* value_out);

void wake_sr_z_long_struct_get_position_dependence(
    const void* struct_obj,
    int* value_out);

void wake_sr_z_long_struct_get_time_based(
    const void* struct_obj,
    bool* value_out);

void wake_sr_mode_struct_get_amp(const void* struct_obj, double* value_out);

void wake_sr_mode_struct_get_damp(const void* struct_obj, double* value_out);

void wake_sr_mode_struct_get_k(const void* struct_obj, double* value_out);

void wake_sr_mode_struct_get_phi(const void* struct_obj, double* value_out);

void wake_sr_mode_struct_get_b_sin(const void* struct_obj, double* value_out);

void wake_sr_mode_struct_get_b_cos(const void* struct_obj, double* value_out);

void wake_sr_mode_struct_get_a_sin(const void* struct_obj, double* value_out);

void wake_sr_mode_struct_get_a_cos(const void* struct_obj, double* value_out);

void wake_sr_mode_struct_get_polarization(
    const void* struct_obj,
    int* value_out);

void wake_sr_mode_struct_get_position_dependence(
    const void* struct_obj,
    int* value_out);

void wake_sr_struct_get_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wake_sr_struct_get_z_long(const void* struct_obj, void** ptr_out);

void wake_sr_struct_get_long_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void wake_sr_struct_get_trans_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void wake_sr_struct_get_z_ref_long(const void* struct_obj, double* value_out);

void wake_sr_struct_get_z_ref_trans(const void* struct_obj, double* value_out);

void wake_sr_struct_get_z_max(const void* struct_obj, double* value_out);

void wake_sr_struct_get_amp_scale(const void* struct_obj, double* value_out);

void wake_sr_struct_get_z_scale(const void* struct_obj, double* value_out);

void wake_sr_struct_get_scale_with_length(
    const void* struct_obj,
    bool* value_out);

void wake_lr_mode_struct_get_freq(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_freq_in(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_R_over_Q(
    const void* struct_obj,
    double* value_out);

void wake_lr_mode_struct_get_Q(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_damp(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_phi(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_angle(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_b_sin(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_b_cos(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_a_sin(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_a_cos(const void* struct_obj, double* value_out);

void wake_lr_mode_struct_get_m(const void* struct_obj, int* value_out);

void wake_lr_mode_struct_get_polarized(const void* struct_obj, bool* value_out);

void wake_lr_struct_get_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wake_lr_struct_get_mode_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void wake_lr_struct_get_t_ref(const void* struct_obj, double* value_out);

void wake_lr_struct_get_freq_spread(const void* struct_obj, double* value_out);

void wake_lr_struct_get_amp_scale(const void* struct_obj, double* value_out);

void wake_lr_struct_get_time_scale(const void* struct_obj, double* value_out);

void wake_lr_struct_get_self_wake_on(const void* struct_obj, bool* value_out);

void lat_ele_loc_struct_get_ix_ele(const void* struct_obj, int* value_out);

void lat_ele_loc_struct_get_ix_branch(const void* struct_obj, int* value_out);

void wake_struct_get_sr(const void* struct_obj, void** ptr_out);

void wake_struct_get_lr(const void* struct_obj, void** ptr_out);

void taylor_term_struct_get_coef(const void* struct_obj, double* value_out);

void taylor_term_struct_get_expn_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void taylor_struct_get_ref(const void* struct_obj, double* value_out);

void taylor_struct_get_term_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void em_taylor_term_struct_get_coef(const void* struct_obj, double* value_out);

void em_taylor_term_struct_get_expn_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void em_taylor_struct_get_ref(const void* struct_obj, double* value_out);

void em_taylor_struct_get_term_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void cartesian_map_term1_struct_get_coef(
    const void* struct_obj,
    double* value_out);

void cartesian_map_term1_struct_get_kx(
    const void* struct_obj,
    double* value_out);

void cartesian_map_term1_struct_get_ky(
    const void* struct_obj,
    double* value_out);

void cartesian_map_term1_struct_get_kz(
    const void* struct_obj,
    double* value_out);

void cartesian_map_term1_struct_get_x0(
    const void* struct_obj,
    double* value_out);

void cartesian_map_term1_struct_get_y0(
    const void* struct_obj,
    double* value_out);

void cartesian_map_term1_struct_get_phi_z(
    const void* struct_obj,
    double* value_out);

void cartesian_map_term1_struct_get_family(
    const void* struct_obj,
    int* value_out);

void cartesian_map_term1_struct_get_form(
    const void* struct_obj,
    int* value_out);

void cartesian_map_term_struct_get_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void cartesian_map_term_struct_get_n_link(
    const void* struct_obj,
    int* value_out);

void cartesian_map_term_struct_get_term_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void cartesian_map_struct_get_field_scale(
    const void* struct_obj,
    double* value_out);

void cartesian_map_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void cartesian_map_struct_get_master_parameter(
    const void* struct_obj,
    int* value_out);

void cartesian_map_struct_get_ele_anchor_pt(
    const void* struct_obj,
    int* value_out);

void cartesian_map_struct_get_field_type(
    const void* struct_obj,
    int* value_out);

void cartesian_map_struct_get_ptr(const void* struct_obj, void** ptr_out);

void cylindrical_map_term1_struct_get_e_coef(
    const void* struct_obj,
    std::complex<double>* value_out);

void cylindrical_map_term1_struct_get_b_coef(
    const void* struct_obj,
    std::complex<double>* value_out);

void cylindrical_map_term_struct_get_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void cylindrical_map_term_struct_get_n_link(
    const void* struct_obj,
    int* value_out);

void cylindrical_map_term_struct_get_term_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void cylindrical_map_struct_get_m(const void* struct_obj, int* value_out);

void cylindrical_map_struct_get_harmonic(
    const void* struct_obj,
    int* value_out);

void cylindrical_map_struct_get_phi0_fieldmap(
    const void* struct_obj,
    double* value_out);

void cylindrical_map_struct_get_theta0_azimuth(
    const void* struct_obj,
    double* value_out);

void cylindrical_map_struct_get_field_scale(
    const void* struct_obj,
    double* value_out);

void cylindrical_map_struct_get_master_parameter(
    const void* struct_obj,
    int* value_out);

void cylindrical_map_struct_get_ele_anchor_pt(
    const void* struct_obj,
    int* value_out);

void cylindrical_map_struct_get_dz(const void* struct_obj, double* value_out);

void cylindrical_map_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void cylindrical_map_struct_get_ptr(const void* struct_obj, void** ptr_out);

void bicubic_cmplx_coef_struct_get_i_box_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tricubic_cmplx_coef_struct_get_i_box_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void grid_field_pt1_struct_get_E_info(
    const void* struct_obj,
    std::complex<double>** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void grid_field_pt1_struct_get_B_info(
    const void* struct_obj,
    std::complex<double>** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void grid_field_pt_struct_get_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void grid_field_pt_struct_get_n_link(const void* struct_obj, int* value_out);

void grid_field_struct_get_geometry(const void* struct_obj, int* value_out);

void grid_field_struct_get_harmonic(const void* struct_obj, int* value_out);

void grid_field_struct_get_phi0_fieldmap(
    const void* struct_obj,
    double* value_out);

void grid_field_struct_get_field_scale(
    const void* struct_obj,
    double* value_out);

void grid_field_struct_get_field_type(const void* struct_obj, int* value_out);

void grid_field_struct_get_master_parameter(
    const void* struct_obj,
    int* value_out);

void grid_field_struct_get_ele_anchor_pt(
    const void* struct_obj,
    int* value_out);

void grid_field_struct_get_interpolation_order(
    const void* struct_obj,
    int* value_out);

void grid_field_struct_get_dr_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void grid_field_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void grid_field_struct_get_curved_ref_frame(
    const void* struct_obj,
    bool* value_out);

void grid_field_struct_get_ptr(const void* struct_obj, void** ptr_out);

void floor_position_struct_get_r_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void floor_position_struct_get_theta(const void* struct_obj, double* value_out);

void floor_position_struct_get_phi(const void* struct_obj, double* value_out);

void floor_position_struct_get_psi(const void* struct_obj, double* value_out);

void high_energy_space_charge_struct_get_closed_orb(
    const void* struct_obj,
    void** ptr_out);

void high_energy_space_charge_struct_get_kick_const(
    const void* struct_obj,
    double* value_out);

void high_energy_space_charge_struct_get_sig_x(
    const void* struct_obj,
    double* value_out);

void high_energy_space_charge_struct_get_sig_y(
    const void* struct_obj,
    double* value_out);

void high_energy_space_charge_struct_get_phi(
    const void* struct_obj,
    double* value_out);

void high_energy_space_charge_struct_get_sin_phi(
    const void* struct_obj,
    double* value_out);

void high_energy_space_charge_struct_get_cos_phi(
    const void* struct_obj,
    double* value_out);

void high_energy_space_charge_struct_get_sig_z(
    const void* struct_obj,
    double* value_out);

void xy_disp_struct_get_eta(const void* struct_obj, double* value_out);

void xy_disp_struct_get_etap(const void* struct_obj, double* value_out);

void xy_disp_struct_get_deta_ds(const void* struct_obj, double* value_out);

void xy_disp_struct_get_sigma(const void* struct_obj, double* value_out);

void xy_disp_struct_get_deta_dpz(const void* struct_obj, double* value_out);

void xy_disp_struct_get_detap_dpz(const void* struct_obj, double* value_out);

void twiss_struct_get_beta(const void* struct_obj, double* value_out);

void twiss_struct_get_alpha(const void* struct_obj, double* value_out);

void twiss_struct_get_gamma(const void* struct_obj, double* value_out);

void twiss_struct_get_phi(const void* struct_obj, double* value_out);

void twiss_struct_get_eta(const void* struct_obj, double* value_out);

void twiss_struct_get_etap(const void* struct_obj, double* value_out);

void twiss_struct_get_deta_ds(const void* struct_obj, double* value_out);

void twiss_struct_get_sigma(const void* struct_obj, double* value_out);

void twiss_struct_get_sigma_p(const void* struct_obj, double* value_out);

void twiss_struct_get_emit(const void* struct_obj, double* value_out);

void twiss_struct_get_norm_emit(const void* struct_obj, double* value_out);

void twiss_struct_get_chrom(const void* struct_obj, double* value_out);

void twiss_struct_get_dbeta_dpz(const void* struct_obj, double* value_out);

void twiss_struct_get_dalpha_dpz(const void* struct_obj, double* value_out);

void twiss_struct_get_deta_dpz(const void* struct_obj, double* value_out);

void twiss_struct_get_detap_dpz(const void* struct_obj, double* value_out);

void mode3_struct_get_a(const void* struct_obj, void** ptr_out);

void mode3_struct_get_b(const void* struct_obj, void** ptr_out);

void mode3_struct_get_c(const void* struct_obj, void** ptr_out);

void mode3_struct_get_x(const void* struct_obj, void** ptr_out);

void mode3_struct_get_y(const void* struct_obj, void** ptr_out);

void bookkeeping_state_struct_get_attributes(
    const void* struct_obj,
    int* value_out);

void bookkeeping_state_struct_get_control(
    const void* struct_obj,
    int* value_out);

void bookkeeping_state_struct_get_floor_position(
    const void* struct_obj,
    int* value_out);

void bookkeeping_state_struct_get_s_position(
    const void* struct_obj,
    int* value_out);

void bookkeeping_state_struct_get_ref_energy(
    const void* struct_obj,
    int* value_out);

void bookkeeping_state_struct_get_mat6(const void* struct_obj, int* value_out);

void bookkeeping_state_struct_get_rad_int(
    const void* struct_obj,
    int* value_out);

void bookkeeping_state_struct_get_ptc(const void* struct_obj, int* value_out);

void bookkeeping_state_struct_get_has_misalign(
    const void* struct_obj,
    bool* value_out);

void rad_map_struct_get_ref_orb_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void rad_map_struct_get_xfer_damp_vec_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void rad_map_ele_struct_get_rm0(const void* struct_obj, void** ptr_out);

void rad_map_ele_struct_get_rm1(const void* struct_obj, void** ptr_out);

void rad_map_ele_struct_get_stale(const void* struct_obj, bool* value_out);

void gen_grad1_struct_get_m(const void* struct_obj, int* value_out);

void gen_grad1_struct_get_sincos(const void* struct_obj, int* value_out);

void gen_grad1_struct_get_n_deriv_max(const void* struct_obj, int* value_out);

void gen_grad1_struct_get_deriv_info(
    const void* struct_obj,
    double** data_ptr,
    int* dim1_size,
    int* dim1_lower,
    int* dim1_upper,
    int* dim2_size,
    int* dim2_lower,
    int* dim2_upper,
    int* stride1,
    int* stride2,
    bool* is_allocated);

void gen_grad_map_struct_get_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void gen_grad_map_struct_get_gg_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void gen_grad_map_struct_get_ele_anchor_pt(
    const void* struct_obj,
    int* value_out);

void gen_grad_map_struct_get_field_type(const void* struct_obj, int* value_out);

void gen_grad_map_struct_get_iz0(const void* struct_obj, int* value_out);

void gen_grad_map_struct_get_iz1(const void* struct_obj, int* value_out);

void gen_grad_map_struct_get_dz(const void* struct_obj, double* value_out);

void gen_grad_map_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void gen_grad_map_struct_get_field_scale(
    const void* struct_obj,
    double* value_out);

void gen_grad_map_struct_get_master_parameter(
    const void* struct_obj,
    int* value_out);

void gen_grad_map_struct_get_curved_ref_frame(
    const void* struct_obj,
    bool* value_out);

void surface_segmented_pt_struct_get_x0(
    const void* struct_obj,
    double* value_out);

void surface_segmented_pt_struct_get_y0(
    const void* struct_obj,
    double* value_out);

void surface_segmented_pt_struct_get_z0(
    const void* struct_obj,
    double* value_out);

void surface_segmented_pt_struct_get_dz_dx(
    const void* struct_obj,
    double* value_out);

void surface_segmented_pt_struct_get_dz_dy(
    const void* struct_obj,
    double* value_out);

void surface_segmented_struct_get_active(
    const void* struct_obj,
    bool* value_out);

void surface_segmented_struct_get_dr_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void surface_segmented_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void surface_h_misalign_pt_struct_get_x0(
    const void* struct_obj,
    double* value_out);

void surface_h_misalign_pt_struct_get_y0(
    const void* struct_obj,
    double* value_out);

void surface_h_misalign_pt_struct_get_rot_y(
    const void* struct_obj,
    double* value_out);

void surface_h_misalign_pt_struct_get_rot_t(
    const void* struct_obj,
    double* value_out);

void surface_h_misalign_pt_struct_get_rot_y_rms(
    const void* struct_obj,
    double* value_out);

void surface_h_misalign_pt_struct_get_rot_t_rms(
    const void* struct_obj,
    double* value_out);

void surface_h_misalign_struct_get_active(
    const void* struct_obj,
    bool* value_out);

void surface_h_misalign_struct_get_dr_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void surface_h_misalign_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void surface_displacement_pt_struct_get_x0(
    const void* struct_obj,
    double* value_out);

void surface_displacement_pt_struct_get_y0(
    const void* struct_obj,
    double* value_out);

void surface_displacement_pt_struct_get_z0(
    const void* struct_obj,
    double* value_out);

void surface_displacement_pt_struct_get_dz_dx(
    const void* struct_obj,
    double* value_out);

void surface_displacement_pt_struct_get_dz_dy(
    const void* struct_obj,
    double* value_out);

void surface_displacement_pt_struct_get_d2z_dxdy(
    const void* struct_obj,
    double* value_out);

void surface_displacement_struct_get_active(
    const void* struct_obj,
    bool* value_out);

void surface_displacement_struct_get_dr_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void surface_displacement_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void target_point_struct_get_r_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void surface_curvature_struct_get_spherical(
    const void* struct_obj,
    double* value_out);

void surface_curvature_struct_get_elliptical_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void surface_curvature_struct_get_has_curvature(
    const void* struct_obj,
    bool* value_out);

void photon_target_struct_get_type(const void* struct_obj, int* value_out);

void photon_target_struct_get_n_corner(const void* struct_obj, int* value_out);

void photon_target_struct_get_ele_loc(const void* struct_obj, void** ptr_out);

void photon_target_struct_get_corner_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void photon_target_struct_get_center(const void* struct_obj, void** ptr_out);

void photon_material_struct_get_f0_m1(
    const void* struct_obj,
    std::complex<double>* value_out);

void photon_material_struct_get_f0_m2(
    const void* struct_obj,
    std::complex<double>* value_out);

void photon_material_struct_get_f_0(
    const void* struct_obj,
    std::complex<double>* value_out);

void photon_material_struct_get_f_h(
    const void* struct_obj,
    std::complex<double>* value_out);

void photon_material_struct_get_f_hbar(
    const void* struct_obj,
    std::complex<double>* value_out);

void photon_material_struct_get_f_hkl(
    const void* struct_obj,
    std::complex<double>* value_out);

void photon_material_struct_get_h_norm_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void photon_material_struct_get_l_ref_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void pixel_pt_struct_get_n_photon(const void* struct_obj, long long* value_out);

void pixel_pt_struct_get_E_x(
    const void* struct_obj,
    std::complex<double>* value_out);

void pixel_pt_struct_get_E_y(
    const void* struct_obj,
    std::complex<double>* value_out);

void pixel_pt_struct_get_intensity_x(const void* struct_obj, double* value_out);

void pixel_pt_struct_get_intensity_y(const void* struct_obj, double* value_out);

void pixel_pt_struct_get_intensity(const void* struct_obj, double* value_out);

void pixel_pt_struct_get_orbit_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void pixel_pt_struct_get_orbit_rms_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void pixel_pt_struct_get_init_orbit_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void pixel_pt_struct_get_init_orbit_rms_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void pixel_detec_struct_get_dr_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void pixel_detec_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void pixel_detec_struct_get_n_track_tot(
    const void* struct_obj,
    long long* value_out);

void pixel_detec_struct_get_n_hit_detec(
    const void* struct_obj,
    long long* value_out);

void pixel_detec_struct_get_n_hit_pixel(
    const void* struct_obj,
    long long* value_out);

void photon_element_struct_get_curvature(
    const void* struct_obj,
    void** ptr_out);

void photon_element_struct_get_target(const void* struct_obj, void** ptr_out);

void photon_element_struct_get_material(const void* struct_obj, void** ptr_out);

void photon_element_struct_get_segmented(
    const void* struct_obj,
    void** ptr_out);

void photon_element_struct_get_h_misalign(
    const void* struct_obj,
    void** ptr_out);

void photon_element_struct_get_displacement(
    const void* struct_obj,
    void** ptr_out);

void photon_element_struct_get_pixel(const void* struct_obj, void** ptr_out);

void photon_element_struct_get_reflectivity_table_type(
    const void* struct_obj,
    int* value_out);

void photon_element_struct_get_reflectivity_table_sigma(
    const void* struct_obj,
    void** ptr_out);

void photon_element_struct_get_reflectivity_table_pi(
    const void* struct_obj,
    void** ptr_out);

void photon_element_struct_get_init_energy_prob_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void photon_element_struct_get_integrated_init_energy_prob_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void wall3d_vertex_struct_get_x(const void* struct_obj, double* value_out);

void wall3d_vertex_struct_get_y(const void* struct_obj, double* value_out);

void wall3d_vertex_struct_get_radius_x(
    const void* struct_obj,
    double* value_out);

void wall3d_vertex_struct_get_radius_y(
    const void* struct_obj,
    double* value_out);

void wall3d_vertex_struct_get_tilt(const void* struct_obj, double* value_out);

void wall3d_vertex_struct_get_angle(const void* struct_obj, double* value_out);

void wall3d_vertex_struct_get_x0(const void* struct_obj, double* value_out);

void wall3d_vertex_struct_get_y0(const void* struct_obj, double* value_out);

void wall3d_vertex_struct_get_type(const void* struct_obj, int* value_out);

void wall3d_section_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_section_struct_get_material_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_section_struct_get_v_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void wall3d_section_struct_get_surface(const void* struct_obj, void** ptr_out);

void wall3d_section_struct_get_type(const void* struct_obj, int* value_out);

void wall3d_section_struct_get_n_vertex_input(
    const void* struct_obj,
    int* value_out);

void wall3d_section_struct_get_ix_ele(const void* struct_obj, int* value_out);

void wall3d_section_struct_get_ix_branch(
    const void* struct_obj,
    int* value_out);

void wall3d_section_struct_get_vertices_state(
    const void* struct_obj,
    int* value_out);

void wall3d_section_struct_get_patch_in_region(
    const void* struct_obj,
    bool* value_out);

void wall3d_section_struct_get_thickness(
    const void* struct_obj,
    double* value_out);

void wall3d_section_struct_get_s(const void* struct_obj, double* value_out);

void wall3d_section_struct_get_r0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_section_struct_get_dx0_ds(
    const void* struct_obj,
    double* value_out);

void wall3d_section_struct_get_dy0_ds(
    const void* struct_obj,
    double* value_out);

void wall3d_section_struct_get_x0_coef_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_section_struct_get_y0_coef_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_section_struct_get_dr_ds(const void* struct_obj, double* value_out);

void wall3d_section_struct_get_p1_coef_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_section_struct_get_p2_coef_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_struct_get_type(const void* struct_obj, int* value_out);

void wall3d_struct_get_ix_wall3d(const void* struct_obj, int* value_out);

void wall3d_struct_get_n_link(const void* struct_obj, int* value_out);

void wall3d_struct_get_thickness(const void* struct_obj, double* value_out);

void wall3d_struct_get_clear_material_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_struct_get_opaque_material_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void wall3d_struct_get_superimpose(const void* struct_obj, bool* value_out);

void wall3d_struct_get_ele_anchor_pt(const void* struct_obj, int* value_out);

void wall3d_struct_get_section_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void ramper_lord_struct_get_ix_ele(const void* struct_obj, int* value_out);

void ramper_lord_struct_get_ix_con(const void* struct_obj, int* value_out);

void ramper_lord_struct_get_attrib_ptr(
    const void* struct_obj,
    double** ptr_out);

void control_struct_get_value(const void* struct_obj, double* value_out);

void control_struct_get_y_knot_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void control_struct_get_stack_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void control_struct_get_slave(const void* struct_obj, void** ptr_out);

void control_struct_get_lord(const void* struct_obj, void** ptr_out);

void control_struct_get_slave_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void control_struct_get_attribute_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void control_struct_get_ix_attrib(const void* struct_obj, int* value_out);

void control_var1_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void control_var1_struct_get_value(const void* struct_obj, double* value_out);

void control_var1_struct_get_old_value(
    const void* struct_obj,
    double* value_out);

void control_ramp1_struct_get_y_knot_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void control_ramp1_struct_get_stack_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void control_ramp1_struct_get_attribute_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void control_ramp1_struct_get_slave_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void control_ramp1_struct_get_is_controller(
    const void* struct_obj,
    bool* value_out);

void controller_struct_get_var_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void controller_struct_get_ramp_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void controller_struct_get_ramper_lord_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void controller_struct_get_x_knot_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void ellipse_beam_init_struct_get_part_per_ellipse(
    const void* struct_obj,
    int* value_out);

void ellipse_beam_init_struct_get_n_ellipse(
    const void* struct_obj,
    int* value_out);

void ellipse_beam_init_struct_get_sigma_cutoff(
    const void* struct_obj,
    double* value_out);

void kv_beam_init_struct_get_part_per_phi_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void kv_beam_init_struct_get_n_I2(const void* struct_obj, int* value_out);

void kv_beam_init_struct_get_A(const void* struct_obj, double* value_out);

void grid_beam_init_struct_get_n_x(const void* struct_obj, int* value_out);

void grid_beam_init_struct_get_n_px(const void* struct_obj, int* value_out);

void grid_beam_init_struct_get_x_min(const void* struct_obj, double* value_out);

void grid_beam_init_struct_get_x_max(const void* struct_obj, double* value_out);

void grid_beam_init_struct_get_px_min(
    const void* struct_obj,
    double* value_out);

void grid_beam_init_struct_get_px_max(
    const void* struct_obj,
    double* value_out);

void beam_init_struct_get_position_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void beam_init_struct_get_spin_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void beam_init_struct_get_ellipse_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void beam_init_struct_get_KV(const void* struct_obj, void** ptr_out);

void beam_init_struct_get_grid_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void beam_init_struct_get_center_jitter_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void beam_init_struct_get_emit_jitter_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void beam_init_struct_get_sig_z_jitter(
    const void* struct_obj,
    double* value_out);

void beam_init_struct_get_sig_pz_jitter(
    const void* struct_obj,
    double* value_out);

void beam_init_struct_get_n_particle(const void* struct_obj, int* value_out);

void beam_init_struct_get_renorm_center(
    const void* struct_obj,
    bool* value_out);

void beam_init_struct_get_renorm_sigma(const void* struct_obj, bool* value_out);

void beam_init_struct_get_random_engine_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void beam_init_struct_get_random_gauss_converter_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void beam_init_struct_get_random_sigma_cutoff(
    const void* struct_obj,
    double* value_out);

void beam_init_struct_get_a_norm_emit(
    const void* struct_obj,
    double* value_out);

void beam_init_struct_get_b_norm_emit(
    const void* struct_obj,
    double* value_out);

void beam_init_struct_get_a_emit(const void* struct_obj, double* value_out);

void beam_init_struct_get_b_emit(const void* struct_obj, double* value_out);

void beam_init_struct_get_dPz_dz(const void* struct_obj, double* value_out);

void beam_init_struct_get_center_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void beam_init_struct_get_t_offset(const void* struct_obj, double* value_out);

void beam_init_struct_get_dt_bunch(const void* struct_obj, double* value_out);

void beam_init_struct_get_sig_z(const void* struct_obj, double* value_out);

void beam_init_struct_get_sig_pz(const void* struct_obj, double* value_out);

void beam_init_struct_get_bunch_charge(
    const void* struct_obj,
    double* value_out);

void beam_init_struct_get_n_bunch(const void* struct_obj, int* value_out);

void beam_init_struct_get_ix_turn(const void* struct_obj, int* value_out);

void beam_init_struct_get_species_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void beam_init_struct_get_full_6D_coupling_calc(
    const void* struct_obj,
    bool* value_out);

void beam_init_struct_get_use_particle_start(
    const void* struct_obj,
    bool* value_out);

void beam_init_struct_get_use_t_coords(const void* struct_obj, bool* value_out);

void beam_init_struct_get_use_z_as_t(const void* struct_obj, bool* value_out);

void beam_init_struct_get_file_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void lat_param_struct_get_n_part(const void* struct_obj, double* value_out);

void lat_param_struct_get_total_length(
    const void* struct_obj,
    double* value_out);

void lat_param_struct_get_unstable_factor(
    const void* struct_obj,
    double* value_out);

void lat_param_struct_get_spin_tune(const void* struct_obj, double* value_out);

void lat_param_struct_get_particle(const void* struct_obj, int* value_out);

void lat_param_struct_get_default_tracking_species(
    const void* struct_obj,
    int* value_out);

void lat_param_struct_get_geometry(const void* struct_obj, int* value_out);

void lat_param_struct_get_ixx(const void* struct_obj, int* value_out);

void lat_param_struct_get_stable(const void* struct_obj, bool* value_out);

void lat_param_struct_get_live_branch(const void* struct_obj, bool* value_out);

void lat_param_struct_get_g1_integral(
    const void* struct_obj,
    double* value_out);

void lat_param_struct_get_g2_integral(
    const void* struct_obj,
    double* value_out);

void lat_param_struct_get_g3_integral(
    const void* struct_obj,
    double* value_out);

void lat_param_struct_get_bookkeeping_state(
    const void* struct_obj,
    void** ptr_out);

void lat_param_struct_get_beam_init(const void* struct_obj, void** ptr_out);

void mode_info_struct_get_stable(const void* struct_obj, bool* value_out);

void mode_info_struct_get_tune(const void* struct_obj, double* value_out);

void mode_info_struct_get_emit(const void* struct_obj, double* value_out);

void mode_info_struct_get_chrom(const void* struct_obj, double* value_out);

void mode_info_struct_get_sigma(const void* struct_obj, double* value_out);

void mode_info_struct_get_sigmap(const void* struct_obj, double* value_out);

void pre_tracker_struct_get_who(const void* struct_obj, int* value_out);

void pre_tracker_struct_get_ix_ele_start(
    const void* struct_obj,
    int* value_out);

void pre_tracker_struct_get_ix_ele_end(const void* struct_obj, int* value_out);

void pre_tracker_struct_get_input_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void anormal_mode_struct_get_emittance(
    const void* struct_obj,
    double* value_out);

void anormal_mode_struct_get_emittance_no_vert(
    const void* struct_obj,
    double* value_out);

void anormal_mode_struct_get_synch_int_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void anormal_mode_struct_get_j_damp(const void* struct_obj, double* value_out);

void anormal_mode_struct_get_alpha_damp(
    const void* struct_obj,
    double* value_out);

void anormal_mode_struct_get_chrom(const void* struct_obj, double* value_out);

void anormal_mode_struct_get_tune(const void* struct_obj, double* value_out);

void linac_normal_mode_struct_get_i2_E4(
    const void* struct_obj,
    double* value_out);

void linac_normal_mode_struct_get_i3_E7(
    const void* struct_obj,
    double* value_out);

void linac_normal_mode_struct_get_i5a_E6(
    const void* struct_obj,
    double* value_out);

void linac_normal_mode_struct_get_i5b_E6(
    const void* struct_obj,
    double* value_out);

void linac_normal_mode_struct_get_sig_E1(
    const void* struct_obj,
    double* value_out);

void linac_normal_mode_struct_get_a_emittance_end(
    const void* struct_obj,
    double* value_out);

void linac_normal_mode_struct_get_b_emittance_end(
    const void* struct_obj,
    double* value_out);

void normal_modes_struct_get_synch_int_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void normal_modes_struct_get_sigE_E(const void* struct_obj, double* value_out);

void normal_modes_struct_get_sig_z(const void* struct_obj, double* value_out);

void normal_modes_struct_get_e_loss(const void* struct_obj, double* value_out);

void normal_modes_struct_get_rf_voltage(
    const void* struct_obj,
    double* value_out);

void normal_modes_struct_get_pz_aperture(
    const void* struct_obj,
    double* value_out);

void normal_modes_struct_get_pz_average(
    const void* struct_obj,
    double* value_out);

void normal_modes_struct_get_momentum_compaction(
    const void* struct_obj,
    double* value_out);

void normal_modes_struct_get_dpz_damp(
    const void* struct_obj,
    double* value_out);

void normal_modes_struct_get_a(const void* struct_obj, void** ptr_out);

void normal_modes_struct_get_b(const void* struct_obj, void** ptr_out);

void normal_modes_struct_get_z(const void* struct_obj, void** ptr_out);

void normal_modes_struct_get_lin(const void* struct_obj, void** ptr_out);

void em_field_struct_get_E_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void em_field_struct_get_B_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void em_field_struct_get_phi(const void* struct_obj, double* value_out);

void em_field_struct_get_phi_B(const void* struct_obj, double* value_out);

void em_field_struct_get_A_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void strong_beam_struct_get_ix_slice(const void* struct_obj, int* value_out);

void strong_beam_struct_get_x_center(const void* struct_obj, double* value_out);

void strong_beam_struct_get_y_center(const void* struct_obj, double* value_out);

void strong_beam_struct_get_x_sigma(const void* struct_obj, double* value_out);

void strong_beam_struct_get_y_sigma(const void* struct_obj, double* value_out);

void strong_beam_struct_get_dx(const void* struct_obj, double* value_out);

void strong_beam_struct_get_dy(const void* struct_obj, double* value_out);

void track_point_struct_get_s_lab(const void* struct_obj, double* value_out);

void track_point_struct_get_s_body(const void* struct_obj, double* value_out);

void track_point_struct_get_orb(const void* struct_obj, void** ptr_out);

void track_point_struct_get_field(const void* struct_obj, void** ptr_out);

void track_point_struct_get_strong_beam(const void* struct_obj, void** ptr_out);

void track_point_struct_get_vec0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void track_struct_get_pt_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void track_struct_get_ds_save(const void* struct_obj, double* value_out);

void track_struct_get_n_pt(const void* struct_obj, int* value_out);

void track_struct_get_n_bad(const void* struct_obj, int* value_out);

void track_struct_get_n_ok(const void* struct_obj, int* value_out);

void space_charge_common_struct_get_ds_track_step(
    const void* struct_obj,
    double* value_out);

void space_charge_common_struct_get_dt_track_step(
    const void* struct_obj,
    double* value_out);

void space_charge_common_struct_get_cathode_strength_cutoff(
    const void* struct_obj,
    double* value_out);

void space_charge_common_struct_get_rel_tol_tracking(
    const void* struct_obj,
    double* value_out);

void space_charge_common_struct_get_abs_tol_tracking(
    const void* struct_obj,
    double* value_out);

void space_charge_common_struct_get_beam_chamber_height(
    const void* struct_obj,
    double* value_out);

void space_charge_common_struct_get_lsc_sigma_cutoff(
    const void* struct_obj,
    double* value_out);

void space_charge_common_struct_get_particle_sigma_cutoff(
    const void* struct_obj,
    double* value_out);

void space_charge_common_struct_get_space_charge_mesh_size_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void space_charge_common_struct_get_csr3d_mesh_size_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void space_charge_common_struct_get_n_bin(
    const void* struct_obj,
    int* value_out);

void space_charge_common_struct_get_particle_bin_span(
    const void* struct_obj,
    int* value_out);

void space_charge_common_struct_get_n_shield_images(
    const void* struct_obj,
    int* value_out);

void space_charge_common_struct_get_sc_min_in_bin(
    const void* struct_obj,
    int* value_out);

void space_charge_common_struct_get_lsc_kick_transverse_dependence(
    const void* struct_obj,
    bool* value_out);

void space_charge_common_struct_get_debug(
    const void* struct_obj,
    bool* value_out);

void space_charge_common_struct_get_diagnostic_output_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void bmad_common_struct_get_max_aperture_limit(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_d_orb_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void bmad_common_struct_get_default_ds_step(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_significant_length(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_rel_tol_tracking(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_abs_tol_tracking(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_rel_tol_adaptive_tracking(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_abs_tol_adaptive_tracking(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_init_ds_adaptive_tracking(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_min_ds_adaptive_tracking(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_fatal_ds_adaptive_tracking(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_autoscale_amp_abs_tol(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_autoscale_amp_rel_tol(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_autoscale_phase_tol(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_electric_dipole_moment(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_synch_rad_scale(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_sad_eps_scale(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_sad_amp_max(
    const void* struct_obj,
    double* value_out);

void bmad_common_struct_get_sad_n_div_max(
    const void* struct_obj,
    int* value_out);

void bmad_common_struct_get_taylor_order(
    const void* struct_obj,
    int* value_out);

void bmad_common_struct_get_runge_kutta_order(
    const void* struct_obj,
    int* value_out);

void bmad_common_struct_get_default_integ_order(
    const void* struct_obj,
    int* value_out);

void bmad_common_struct_get_max_num_runge_kutta_step(
    const void* struct_obj,
    int* value_out);

void bmad_common_struct_get_rf_phase_below_transition_ref(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_sr_wakes_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_lr_wakes_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_auto_bookkeeper(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_high_energy_space_charge_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_csr_and_space_charge_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_spin_tracking_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_spin_sokolov_ternov_flipping_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_radiation_damping_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_radiation_zero_average(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_radiation_fluctuations_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_conserve_taylor_maps(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_absolute_time_tracking(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_absolute_time_ref_shift(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_convert_to_kinetic_momentum(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_normalize_twiss(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_aperture_limit_on(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_spin_n0_direction_user_set(
    const void* struct_obj,
    bool* value_out);

void bmad_common_struct_get_debug(const void* struct_obj, bool* value_out);

void rad_int1_struct_get_i0(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i1(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i2(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i3(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i4a(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i4b(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i4z(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i5a(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i5b(const void* struct_obj, double* value_out);

void rad_int1_struct_get_i6b(const void* struct_obj, double* value_out);

void rad_int1_struct_get_lin_i2_E4(const void* struct_obj, double* value_out);

void rad_int1_struct_get_lin_i3_E7(const void* struct_obj, double* value_out);

void rad_int1_struct_get_lin_i5a_E6(const void* struct_obj, double* value_out);

void rad_int1_struct_get_lin_i5b_E6(const void* struct_obj, double* value_out);

void rad_int1_struct_get_lin_norm_emit_a(
    const void* struct_obj,
    double* value_out);

void rad_int1_struct_get_lin_norm_emit_b(
    const void* struct_obj,
    double* value_out);

void rad_int1_struct_get_lin_sig_E(const void* struct_obj, double* value_out);

void rad_int1_struct_get_n_steps(const void* struct_obj, double* value_out);

void rad_int_branch_struct_get_ele_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void rad_int_all_ele_struct_get_branch_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void rf_stair_step_struct_get_E_tot0(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_E_tot1(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_p0c(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_p1c(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_dE_amp(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_scale(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_time(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_s(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_ix_step(const void* struct_obj, int* value_out);

void rf_ele_struct_get_steps_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void rf_ele_struct_get_ds_step(const void* struct_obj, double* value_out);

void ele_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_type_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_alias_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_component_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_descrip_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void ele_struct_get_a(const void* struct_obj, void** ptr_out);

void ele_struct_get_b(const void* struct_obj, void** ptr_out);

void ele_struct_get_z(const void* struct_obj, void** ptr_out);

void ele_struct_get_x(const void* struct_obj, void** ptr_out);

void ele_struct_get_y(const void* struct_obj, void** ptr_out);

void ele_struct_get_ac_kick(const void* struct_obj, void** ptr_out);

void ele_struct_get_bookkeeping_state(const void* struct_obj, void** ptr_out);

void ele_struct_get_branch(const void* struct_obj, void** ptr_out);

void ele_struct_get_control(const void* struct_obj, void** ptr_out);

void ele_struct_get_rf(const void* struct_obj, void** ptr_out);

void ele_struct_get_lord(const void* struct_obj, void** ptr_out);

void ele_struct_get_floor(const void* struct_obj, void** ptr_out);

void ele_struct_get_high_energy_space_charge(
    const void* struct_obj,
    void** ptr_out);

void ele_struct_get_mode3(const void* struct_obj, void** ptr_out);

void ele_struct_get_photon(const void* struct_obj, void** ptr_out);

void ele_struct_get_rad_map(const void* struct_obj, void** ptr_out);

void ele_struct_get_taylor_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void ele_struct_get_spin_taylor_ref_orb_in_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_spin_taylor_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void ele_struct_get_wake(const void* struct_obj, void** ptr_out);

void ele_struct_get_wall3d_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void ele_struct_get_cartesian_map_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void ele_struct_get_cylindrical_map_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void ele_struct_get_gen_grad_map_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void ele_struct_get_grid_field_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void ele_struct_get_map_ref_orb_in(const void* struct_obj, void** ptr_out);

void ele_struct_get_map_ref_orb_out(const void* struct_obj, void** ptr_out);

void ele_struct_get_time_ref_orb_in(const void* struct_obj, void** ptr_out);

void ele_struct_get_time_ref_orb_out(const void* struct_obj, void** ptr_out);

void ele_struct_get_value_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_old_value_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_vec0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_gamma_c(const void* struct_obj, double* value_out);

void ele_struct_get_s_start(const void* struct_obj, double* value_out);

void ele_struct_get_s(const void* struct_obj, double* value_out);

void ele_struct_get_ref_time(const void* struct_obj, double* value_out);

void ele_struct_get_key(const void* struct_obj, int* value_out);

void ele_struct_get_sub_key(const void* struct_obj, int* value_out);

void ele_struct_get_ix_ele(const void* struct_obj, int* value_out);

void ele_struct_get_ix_branch(const void* struct_obj, int* value_out);

void ele_struct_get_lord_status(const void* struct_obj, int* value_out);

void ele_struct_get_n_slave(const void* struct_obj, int* value_out);

void ele_struct_get_n_slave_field(const void* struct_obj, int* value_out);

void ele_struct_get_ix1_slave(const void* struct_obj, int* value_out);

void ele_struct_get_slave_status(const void* struct_obj, int* value_out);

void ele_struct_get_n_lord(const void* struct_obj, int* value_out);

void ele_struct_get_n_lord_field(const void* struct_obj, int* value_out);

void ele_struct_get_n_lord_ramper(const void* struct_obj, int* value_out);

void ele_struct_get_ic1_lord(const void* struct_obj, int* value_out);

void ele_struct_get_ix_pointer(const void* struct_obj, int* value_out);

void ele_struct_get_ixx(const void* struct_obj, int* value_out);

void ele_struct_get_iyy(const void* struct_obj, int* value_out);

void ele_struct_get_izz(const void* struct_obj, int* value_out);

void ele_struct_get_mat6_calc_method(const void* struct_obj, int* value_out);

void ele_struct_get_tracking_method(const void* struct_obj, int* value_out);

void ele_struct_get_spin_tracking_method(
    const void* struct_obj,
    int* value_out);

void ele_struct_get_csr_method(const void* struct_obj, int* value_out);

void ele_struct_get_space_charge_method(const void* struct_obj, int* value_out);

void ele_struct_get_ptc_integration_type(
    const void* struct_obj,
    int* value_out);

void ele_struct_get_field_calc(const void* struct_obj, int* value_out);

void ele_struct_get_aperture_at(const void* struct_obj, int* value_out);

void ele_struct_get_aperture_type(const void* struct_obj, int* value_out);

void ele_struct_get_ref_species(const void* struct_obj, int* value_out);

void ele_struct_get_orientation(const void* struct_obj, int* value_out);

void ele_struct_get_symplectify(const void* struct_obj, bool* value_out);

void ele_struct_get_mode_flip(const void* struct_obj, bool* value_out);

void ele_struct_get_multipoles_on(const void* struct_obj, bool* value_out);

void ele_struct_get_scale_multipoles(const void* struct_obj, bool* value_out);

void ele_struct_get_taylor_map_includes_offsets(
    const void* struct_obj,
    bool* value_out);

void ele_struct_get_field_master(const void* struct_obj, bool* value_out);

void ele_struct_get_is_on(const void* struct_obj, bool* value_out);

void ele_struct_get_logic(const void* struct_obj, bool* value_out);

void ele_struct_get_bmad_logic(const void* struct_obj, bool* value_out);

void ele_struct_get_select(const void* struct_obj, bool* value_out);

void ele_struct_get_offset_moves_aperture(
    const void* struct_obj,
    bool* value_out);

void complex_taylor_term_struct_get_coef(
    const void* struct_obj,
    std::complex<double>* value_out);

void complex_taylor_term_struct_get_expn_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void complex_taylor_struct_get_ref(
    const void* struct_obj,
    std::complex<double>* value_out);

void complex_taylor_struct_get_term_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void branch_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void branch_struct_get_ix_branch(const void* struct_obj, int* value_out);

void branch_struct_get_ix_from_branch(const void* struct_obj, int* value_out);

void branch_struct_get_ix_from_ele(const void* struct_obj, int* value_out);

void branch_struct_get_ix_to_ele(const void* struct_obj, int* value_out);

void branch_struct_get_ix_fixer(const void* struct_obj, int* value_out);

void branch_struct_get_n_ele_track(const void* struct_obj, int* value_out);

void branch_struct_get_n_ele_max(const void* struct_obj, int* value_out);

void branch_struct_get_lat(const void* struct_obj, void** ptr_out);

void branch_struct_get_a(const void* struct_obj, void** ptr_out);

void branch_struct_get_b(const void* struct_obj, void** ptr_out);

void branch_struct_get_z(const void* struct_obj, void** ptr_out);

void branch_struct_get_ele_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void branch_struct_get_param(const void* struct_obj, void** ptr_out);

void branch_struct_get_particle_start(const void* struct_obj, void** ptr_out);

void branch_struct_get_wall3d_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void lat_struct_get_use_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void lat_struct_get_lattice_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void lat_struct_get_machine_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void lat_struct_get_input_file_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void lat_struct_get_title_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void lat_struct_get_constant_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void lat_struct_get_a(const void* struct_obj, void** ptr_out);

void lat_struct_get_b(const void* struct_obj, void** ptr_out);

void lat_struct_get_z(const void* struct_obj, void** ptr_out);

void lat_struct_get_param(const void* struct_obj, void** ptr_out);

void lat_struct_get_lord_state(const void* struct_obj, void** ptr_out);

void lat_struct_get_ele_init(const void* struct_obj, void** ptr_out);

void lat_struct_get_branch_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void lat_struct_get_control_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void lat_struct_get_particle_start(const void* struct_obj, void** ptr_out);

void lat_struct_get_beam_init(const void* struct_obj, void** ptr_out);

void lat_struct_get_pre_tracker(const void* struct_obj, void** ptr_out);

void lat_struct_get_custom_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void lat_struct_get_version(const void* struct_obj, int* value_out);

void lat_struct_get_n_ele_track(const void* struct_obj, int** ptr_out);

void lat_struct_get_n_ele_max(const void* struct_obj, int** ptr_out);

void lat_struct_get_n_control_max(const void* struct_obj, int* value_out);

void lat_struct_get_n_ic_max(const void* struct_obj, int* value_out);

void lat_struct_get_input_taylor_order(const void* struct_obj, int* value_out);

void lat_struct_get_ic_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void lat_struct_get_photon_type(const void* struct_obj, int* value_out);

void lat_struct_get_creation_hash(const void* struct_obj, int* value_out);

void lat_struct_get_ramper_slave_bookkeeping(
    const void* struct_obj,
    int* value_out);

void bunch_struct_get_particle_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void bunch_struct_get_ix_z_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void bunch_struct_get_charge_tot(const void* struct_obj, double* value_out);

void bunch_struct_get_charge_live(const void* struct_obj, double* value_out);

void bunch_struct_get_z_center(const void* struct_obj, double* value_out);

void bunch_struct_get_t_center(const void* struct_obj, double* value_out);

void bunch_struct_get_t0(const void* struct_obj, double* value_out);

void bunch_struct_get_drift_between_t_and_s(
    const void* struct_obj,
    bool* value_out);

void bunch_struct_get_ix_ele(const void* struct_obj, int* value_out);

void bunch_struct_get_ix_bunch(const void* struct_obj, int* value_out);

void bunch_struct_get_ix_turn(const void* struct_obj, int* value_out);

void bunch_struct_get_n_live(const void* struct_obj, int* value_out);

void bunch_struct_get_n_good(const void* struct_obj, int* value_out);

void bunch_struct_get_n_bad(const void* struct_obj, int* value_out);

void bunch_params_struct_get_centroid(const void* struct_obj, void** ptr_out);

void bunch_params_struct_get_x(const void* struct_obj, void** ptr_out);

void bunch_params_struct_get_y(const void* struct_obj, void** ptr_out);

void bunch_params_struct_get_z(const void* struct_obj, void** ptr_out);

void bunch_params_struct_get_a(const void* struct_obj, void** ptr_out);

void bunch_params_struct_get_b(const void* struct_obj, void** ptr_out);

void bunch_params_struct_get_c(const void* struct_obj, void** ptr_out);

void bunch_params_struct_get_rel_max_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void bunch_params_struct_get_rel_min_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void bunch_params_struct_get_s(const void* struct_obj, double* value_out);

void bunch_params_struct_get_t(const void* struct_obj, double* value_out);

void bunch_params_struct_get_sigma_t(const void* struct_obj, double* value_out);

void bunch_params_struct_get_charge_live(
    const void* struct_obj,
    double* value_out);

void bunch_params_struct_get_charge_tot(
    const void* struct_obj,
    double* value_out);

void bunch_params_struct_get_n_particle_tot(
    const void* struct_obj,
    int* value_out);

void bunch_params_struct_get_n_particle_live(
    const void* struct_obj,
    int* value_out);

void bunch_params_struct_get_n_particle_lost_in_ele(
    const void* struct_obj,
    int* value_out);

void bunch_params_struct_get_n_good_steps(
    const void* struct_obj,
    int* value_out);

void bunch_params_struct_get_n_bad_steps(
    const void* struct_obj,
    int* value_out);

void bunch_params_struct_get_ix_ele(const void* struct_obj, int* value_out);

void bunch_params_struct_get_location(const void* struct_obj, int* value_out);

void bunch_params_struct_get_twiss_valid(
    const void* struct_obj,
    bool* value_out);

void beam_struct_get_bunch_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void aperture_point_struct_get_x(const void* struct_obj, double* value_out);

void aperture_point_struct_get_y(const void* struct_obj, double* value_out);

void aperture_point_struct_get_plane(const void* struct_obj, int* value_out);

void aperture_point_struct_get_ix_ele(const void* struct_obj, int* value_out);

void aperture_point_struct_get_i_turn(const void* struct_obj, int* value_out);

void aperture_param_struct_get_min_angle(
    const void* struct_obj,
    double* value_out);

void aperture_param_struct_get_max_angle(
    const void* struct_obj,
    double* value_out);

void aperture_param_struct_get_n_angle(const void* struct_obj, int* value_out);

void aperture_param_struct_get_n_turn(const void* struct_obj, int* value_out);

void aperture_param_struct_get_x_init(
    const void* struct_obj,
    double* value_out);

void aperture_param_struct_get_y_init(
    const void* struct_obj,
    double* value_out);

void aperture_param_struct_get_rel_accuracy(
    const void* struct_obj,
    double* value_out);

void aperture_param_struct_get_abs_accuracy(
    const void* struct_obj,
    double* value_out);

void aperture_param_struct_get_start_ele_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void aperture_scan_struct_get_point_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void aperture_scan_struct_get_ref_orb(const void* struct_obj, void** ptr_out);

void aperture_scan_struct_get_pz_start(
    const void* struct_obj,
    double* value_out);

void tao_spin_dn_dpz_struct_get_vec_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void resonance_h_struct_get_id_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void resonance_h_struct_get_c_val(
    const void* struct_obj,
    std::complex<double>* value_out);

void spin_orbit_map1_struct_get_vec0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void spin_axis_struct_get_l_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void spin_axis_struct_get_n0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void spin_axis_struct_get_m_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ptc_normal_form_struct_get_ele_origin(
    const void* struct_obj,
    void** ptr_out);

void ptc_normal_form_struct_get_orb0_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ptc_normal_form_struct_get_valid_map(
    const void* struct_obj,
    bool* value_out);

void bmad_normal_form_struct_get_ele_origin(
    const void* struct_obj,
    void** ptr_out);

void bmad_normal_form_struct_get_M_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void bmad_normal_form_struct_get_A_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void bmad_normal_form_struct_get_A_inv_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void bmad_normal_form_struct_get_dhdj_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void bmad_normal_form_struct_get_F_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void bmad_normal_form_struct_get_L_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    size_t* element_size);

void bmad_normal_form_struct_get_h_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void bunch_track_struct_get_pt_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void bunch_track_struct_get_ds_save(const void* struct_obj, double* value_out);

void bunch_track_struct_get_n_pt(const void* struct_obj, int* value_out);

void summation_rdt_struct_get_h11001(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h00111(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h20001(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h00201(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h10002(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h21000(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h30000(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h10110(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h10020(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h10200(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h31000(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h40000(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h20110(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h11200(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h20020(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h20200(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h00310(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h00400(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h22000(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h00220(
    const void* struct_obj,
    std::complex<double>* value_out);

void summation_rdt_struct_get_h11110(
    const void* struct_obj,
    std::complex<double>* value_out);

void lat_ele_order1_struct_get_ix_branch(
    const void* struct_obj,
    int* value_out);

void lat_ele_order1_struct_get_ix_order(const void* struct_obj, int* value_out);

void lat_ele_order_array_struct_get_ele_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_spin_ele_struct_get_dn_dpz(const void* struct_obj, void** ptr_out);

void tao_spin_ele_struct_get_orb_eigen_val_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_spin_ele_struct_get_valid(const void* struct_obj, bool* value_out);

void tao_plot_cache_struct_get_ele_to_s(const void* struct_obj, void** ptr_out);

void tao_plot_cache_struct_get_orbit(const void* struct_obj, void** ptr_out);

void tao_plot_cache_struct_get_err(const void* struct_obj, bool* value_out);

void tao_spin_polarization_struct_get_tune(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_pol_limit_st(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_pol_limit_dk(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_pol_limit_dk_partial_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_spin_polarization_struct_get_pol_limit_dk_partial2_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_spin_polarization_struct_get_pol_rate_bks(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_depol_rate(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_depol_rate_partial_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_spin_polarization_struct_get_depol_rate_partial2_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_spin_polarization_struct_get_integral_bn(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_integral_bdn(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_integral_1ns(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_integral_dn2(
    const void* struct_obj,
    double* value_out);

void tao_spin_polarization_struct_get_valid(
    const void* struct_obj,
    bool* value_out);

void tao_spin_polarization_struct_get_q_1turn(
    const void* struct_obj,
    void** ptr_out);

void tao_spin_polarization_struct_get_q_ele_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_lat_sigma_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_spin_ele_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_bunch_params_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_bunch_params_comb_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_orbit_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_plot_cache_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_spin(const void* struct_obj, void** ptr_out);

void tao_lattice_branch_struct_get_srdt(const void* struct_obj, void** ptr_out);

void tao_lattice_branch_struct_get_orb0(const void* struct_obj, void** ptr_out);

void tao_lattice_branch_struct_get_modes_ri(
    const void* struct_obj,
    void** ptr_out);

void tao_lattice_branch_struct_get_modes_6d(
    const void* struct_obj,
    void** ptr_out);

void tao_lattice_branch_struct_get_ptc_normal_form(
    const void* struct_obj,
    void** ptr_out);

void tao_lattice_branch_struct_get_bmad_normal_form(
    const void* struct_obj,
    void** ptr_out);

void tao_lattice_branch_struct_get_high_E_orb_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_low_E_orb_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_lattice_branch_struct_get_cache_x_min(
    const void* struct_obj,
    double* value_out);

void tao_lattice_branch_struct_get_cache_x_max(
    const void* struct_obj,
    double* value_out);

void tao_lattice_branch_struct_get_comb_ds_save(
    const void* struct_obj,
    double* value_out);

void tao_lattice_branch_struct_get_track_state(
    const void* struct_obj,
    int* value_out);

void tao_lattice_branch_struct_get_cache_n_pts(
    const void* struct_obj,
    int* value_out);

void tao_lattice_branch_struct_get_ix_rad_int_cache(
    const void* struct_obj,
    int* value_out);

void tao_lattice_branch_struct_get_has_open_match_element(
    const void* struct_obj,
    bool* value_out);

void tao_lattice_branch_struct_get_plot_cache_valid(
    const void* struct_obj,
    bool* value_out);

void tao_lattice_branch_struct_get_spin_map_valid(
    const void* struct_obj,
    bool* value_out);

void tao_lattice_branch_struct_get_twiss_valid(
    const void* struct_obj,
    bool* value_out);

void tao_lattice_branch_struct_get_mode_flip_here(
    const void* struct_obj,
    bool* value_out);

void tao_lattice_branch_struct_get_chrom_calc_ok(
    const void* struct_obj,
    bool* value_out);

void tao_lattice_branch_struct_get_rad_int_calc_ok(
    const void* struct_obj,
    bool* value_out);

void tao_lattice_branch_struct_get_emit_6d_calc_ok(
    const void* struct_obj,
    bool* value_out);

void tao_lattice_branch_struct_get_sigma_track_ok(
    const void* struct_obj,
    bool* value_out);

void tao_model_element_struct_get_beam(const void* struct_obj, void** ptr_out);

void tao_model_element_struct_get_save_beam_internally(
    const void* struct_obj,
    bool* value_out);

void tao_model_element_struct_get_save_beam_to_file(
    const void* struct_obj,
    bool* value_out);

void tao_beam_branch_struct_get_beam_at_start(
    const void* struct_obj,
    void** ptr_out);

void tao_beam_branch_struct_get_beam_init(
    const void* struct_obj,
    void** ptr_out);

void tao_beam_branch_struct_get_beam_init_used(
    const void* struct_obj,
    void** ptr_out);

void tao_beam_branch_struct_get_init_starting_distribution(
    const void* struct_obj,
    bool* value_out);

void tao_beam_branch_struct_get_track_start_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_beam_branch_struct_get_track_end_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_beam_branch_struct_get_ix_branch(
    const void* struct_obj,
    int* value_out);

void tao_beam_branch_struct_get_ix_track_start(
    const void* struct_obj,
    int* value_out);

void tao_beam_branch_struct_get_ix_track_end(
    const void* struct_obj,
    int* value_out);

void tao_d1_data_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_lattice_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_lattice_struct_get_lat(const void* struct_obj, void** ptr_out);

void tao_lattice_struct_get_high_E_lat(const void* struct_obj, void** ptr_out);

void tao_lattice_struct_get_low_E_lat(const void* struct_obj, void** ptr_out);

void tao_lattice_struct_get_rad_int_by_ele_ri(
    const void* struct_obj,
    void** ptr_out);

void tao_lattice_struct_get_rad_int_by_ele_6d(
    const void* struct_obj,
    void** ptr_out);

void tao_lattice_struct_get_tao_branch_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_beam_uni_struct_get_saved_at_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_beam_uni_struct_get_dump_file_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_beam_uni_struct_get_dump_at_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_beam_uni_struct_get_track_beam_in_universe(
    const void* struct_obj,
    bool* value_out);

void tao_beam_uni_struct_get_always_reinit(
    const void* struct_obj,
    bool* value_out);

void tao_dynamic_aperture_struct_get_param(
    const void* struct_obj,
    void** ptr_out);

void tao_dynamic_aperture_struct_get_scan_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_dynamic_aperture_struct_get_pz_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated);

void tao_dynamic_aperture_struct_get_ellipse_scale(
    const void* struct_obj,
    double* value_out);

void tao_dynamic_aperture_struct_get_a_emit(
    const void* struct_obj,
    double* value_out);

void tao_dynamic_aperture_struct_get_b_emit(
    const void* struct_obj,
    double* value_out);

void tao_model_branch_struct_get_ele_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_model_branch_struct_get_beam(const void* struct_obj, void** ptr_out);

void tao_d2_data_struct_get_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_d2_data_struct_get_data_file_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_d2_data_struct_get_ref_file_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_d2_data_struct_get_data_date_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_d2_data_struct_get_ref_date_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_d2_data_struct_get_d1_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_d2_data_struct_get_ix_universe(const void* struct_obj, int* value_out);

void tao_d2_data_struct_get_ix_d2_data(const void* struct_obj, int* value_out);

void tao_d2_data_struct_get_ix_ref(const void* struct_obj, int* value_out);

void tao_d2_data_struct_get_data_read_in(
    const void* struct_obj,
    bool* value_out);

void tao_d2_data_struct_get_ref_read_in(
    const void* struct_obj,
    bool* value_out);

void tao_spin_map_struct_get_valid(const void* struct_obj, bool* value_out);

void tao_spin_map_struct_get_map1(const void* struct_obj, void** ptr_out);

void tao_spin_map_struct_get_axis_input(const void* struct_obj, void** ptr_out);

void tao_spin_map_struct_get_axis0(const void* struct_obj, void** ptr_out);

void tao_spin_map_struct_get_axis1(const void* struct_obj, void** ptr_out);

void tao_spin_map_struct_get_ix_ele(const void* struct_obj, int* value_out);

void tao_spin_map_struct_get_ix_ref(const void* struct_obj, int* value_out);

void tao_spin_map_struct_get_ix_uni(const void* struct_obj, int* value_out);

void tao_spin_map_struct_get_ix_branch(const void* struct_obj, int* value_out);

void tao_data_struct_get_ele_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_data_struct_get_ele_start_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_data_struct_get_ele_ref_name_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_data_struct_get_merit_type_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_data_struct_get_id_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_data_struct_get_data_source_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_data_struct_get_why_invalid_info(
    const void* struct_obj,
    char** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void tao_data_struct_get_ix_uni(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_bunch(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_branch(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_ele(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_ele_start(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_ele_ref(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_ele_merit(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_d1(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_data(const void* struct_obj, int* value_out);

void tao_data_struct_get_ix_dModel(const void* struct_obj, int* value_out);

void tao_data_struct_get_eval_point(const void* struct_obj, int* value_out);

void tao_data_struct_get_meas_value(const void* struct_obj, double* value_out);

void tao_data_struct_get_ref_value(const void* struct_obj, double* value_out);

void tao_data_struct_get_model_value(const void* struct_obj, double* value_out);

void tao_data_struct_get_design_value(
    const void* struct_obj,
    double* value_out);

void tao_data_struct_get_old_value(const void* struct_obj, double* value_out);

void tao_data_struct_get_base_value(const void* struct_obj, double* value_out);

void tao_data_struct_get_error_rms(const void* struct_obj, double* value_out);

void tao_data_struct_get_delta_merit(const void* struct_obj, double* value_out);

void tao_data_struct_get_weight(const void* struct_obj, double* value_out);

void tao_data_struct_get_invalid_value(
    const void* struct_obj,
    double* value_out);

void tao_data_struct_get_merit(const void* struct_obj, double* value_out);

void tao_data_struct_get_s(const void* struct_obj, double* value_out);

void tao_data_struct_get_s_offset(const void* struct_obj, double* value_out);

void tao_data_struct_get_err_message_printed(
    const void* struct_obj,
    bool* value_out);

void tao_data_struct_get_exists(const void* struct_obj, bool* value_out);

void tao_data_struct_get_good_model(const void* struct_obj, bool* value_out);

void tao_data_struct_get_good_base(const void* struct_obj, bool* value_out);

void tao_data_struct_get_good_design(const void* struct_obj, bool* value_out);

void tao_data_struct_get_good_meas(const void* struct_obj, bool* value_out);

void tao_data_struct_get_good_ref(const void* struct_obj, bool* value_out);

void tao_data_struct_get_good_user(const void* struct_obj, bool* value_out);

void tao_data_struct_get_good_opt(const void* struct_obj, bool* value_out);

void tao_data_struct_get_good_plot(const void* struct_obj, bool* value_out);

void tao_data_struct_get_useit_plot(const void* struct_obj, bool* value_out);

void tao_data_struct_get_useit_opt(const void* struct_obj, bool* value_out);

void tao_data_struct_get_spin_map(const void* struct_obj, void** ptr_out);

void tao_data_struct_get_d1(const void* struct_obj, void** ptr_out);

void tao_ping_scale_struct_get_a_mode_meas(
    const void* struct_obj,
    double* value_out);

void tao_ping_scale_struct_get_a_mode_ref(
    const void* struct_obj,
    double* value_out);

void tao_ping_scale_struct_get_b_mode_meas(
    const void* struct_obj,
    double* value_out);

void tao_ping_scale_struct_get_b_mode_ref(
    const void* struct_obj,
    double* value_out);

void tao_universe_calc_struct_get_srdt_for_data(
    const void* struct_obj,
    int* value_out);

void tao_universe_calc_struct_get_rad_int_for_data(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_rad_int_for_plotting(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_chrom_for_data(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_chrom_for_plotting(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_lat_sigma_for_data(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_lat_sigma_for_plotting(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_dynamic_aperture(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_one_turn_map(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_lattice(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_twiss(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_track(
    const void* struct_obj,
    bool* value_out);

void tao_universe_calc_struct_get_spin_matrices(
    const void* struct_obj,
    bool* value_out);

void lat_ele_order_struct_get_branch_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_universe_struct_get_model(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_design(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_base(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_beam(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_dynamic_aperture(
    const void* struct_obj,
    void** ptr_out);

void tao_universe_struct_get_model_branch_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_universe_struct_get_d2_data_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_universe_struct_get_data_info(
    const void* struct_obj,
    void** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound,
    bool* is_allocated,
    size_t* element_size);

void tao_universe_struct_get_ping_scale(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_scratch_lat(
    const void* struct_obj,
    void** ptr_out);

void tao_universe_struct_get_calc(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_ele_order(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_spin_map(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_dModel_dVar_info(
    const void* struct_obj,
    double** data_ptr,
    int* dim1_size,
    int* dim1_lower,
    int* dim1_upper,
    int* dim2_size,
    int* dim2_lower,
    int* dim2_upper,
    int* stride1,
    int* stride2,
    bool* is_allocated);

void tao_universe_struct_get_ix_uni(const void* struct_obj, int* value_out);

void tao_universe_struct_get_n_d2_data_used(
    const void* struct_obj,
    int* value_out);

void tao_universe_struct_get_n_data_used(
    const void* struct_obj,
    int* value_out);

void tao_universe_struct_get_is_on(const void* struct_obj, bool* value_out);

void tao_universe_struct_get_design_same_as_previous(
    const void* struct_obj,
    bool* value_out);

void tao_universe_struct_get_picked_uni(
    const void* struct_obj,
    bool* value_out);

// Global functions (index-based, only for initial access)
int tao_get_n_universes();
void* tao_c_get_universe_ptr(int ix_uni);
void* tao_c_get_tao_lattice_ptr(int ix_uni, int ix_lat);
void* tao_c_get_lattice_ptr(int ix_uni, int ix_lat);
void* tao_c_get_branch_ptr(int ix_uni, int ix_lat, int ix_branch);
void* tao_c_get_element_ptr(int ix_uni, int ix_lat, int ix_branch, int ix_ele);

// Pointer-based functions (efficient access using C pointers)
int tao_lat_get_n_branches(void* lat_ptr);
void* tao_lat_get_branch_ptr(void* lat_ptr, int ix_branch);
int tao_branch_get_n_elements(void* branch_ptr);
void* tao_branch_get_element_ptr(void* branch_ptr, int ix_ele);
}

namespace tao {

// Lattice type enumeration
enum class LatticeType : int { MODEL = 1, DESIGN = 2, BASE = 3 };

// Exception classes

// Forward declarations
class TaoUniverseIndexProxy;
class TaoLatticeIndexProxy;
class TaoBranchIndexProxy;
class SplineProxy;
class SpinPolarProxy;
class AcKickerTimeProxy;
class AcKickerFreqProxy;
class AcKickerProxy;
class Interval1CoefProxy;
class PhotonReflectTableProxy;
class PhotonReflectSurfaceProxy;
class CoordProxy;
class CoordArrayProxy;
class BpmPhaseCouplingProxy;
class ExpressionAtomProxy;
class WakeSrZLongProxy;
class WakeSrModeProxy;
class WakeSrProxy;
class WakeLrModeProxy;
class WakeLrProxy;
class LatEleLocProxy;
class WakeProxy;
class TaylorTermProxy;
class TaylorProxy;
class EmTaylorTermProxy;
class EmTaylorProxy;
class CartesianMapTerm1Proxy;
class CartesianMapTermProxy;
class CartesianMapProxy;
class CylindricalMapTerm1Proxy;
class CylindricalMapTermProxy;
class CylindricalMapProxy;
class BicubicCmplxCoefProxy;
class TricubicCmplxCoefProxy;
class GridFieldPt1Proxy;
class GridFieldPtProxy;
class GridFieldProxy;
class FloorPositionProxy;
class HighEnergySpaceChargeProxy;
class XyDispProxy;
class TwissProxy;
class Mode3Proxy;
class BookkeepingStateProxy;
class RadMapProxy;
class RadMapEleProxy;
class GenGrad1Proxy;
class GenGradMapProxy;
class SurfaceSegmentedPtProxy;
class SurfaceSegmentedProxy;
class SurfaceHMisalignPtProxy;
class SurfaceHMisalignProxy;
class SurfaceDisplacementPtProxy;
class SurfaceDisplacementProxy;
class TargetPointProxy;
class SurfaceCurvatureProxy;
class PhotonTargetProxy;
class PhotonMaterialProxy;
class PixelPtProxy;
class PixelDetecProxy;
class PhotonElementProxy;
class Wall3dVertexProxy;
class Wall3dSectionProxy;
class Wall3dProxy;
class RamperLordProxy;
class ControlProxy;
class ControlVar1Proxy;
class ControlRamp1Proxy;
class ControllerProxy;
class EllipseBeamInitProxy;
class KvBeamInitProxy;
class GridBeamInitProxy;
class BeamInitProxy;
class LatParamProxy;
class ModeInfoProxy;
class PreTrackerProxy;
class AnormalModeProxy;
class LinacNormalModeProxy;
class NormalModesProxy;
class EmFieldProxy;
class StrongBeamProxy;
class TrackPointProxy;
class TrackProxy;
class SpaceChargeCommonProxy;
class BmadCommonProxy;
class RadInt1Proxy;
class RadIntBranchProxy;
class RadIntAllEleProxy;
class RfStairStepProxy;
class RfEleProxy;
class EleProxy;
class ComplexTaylorTermProxy;
class ComplexTaylorProxy;
class BranchProxy;
class LatProxy;
class BunchProxy;
class BunchParamsProxy;
class BeamProxy;
class AperturePointProxy;
class ApertureParamProxy;
class ApertureScanProxy;
class TaoSpinDnDpzProxy;
class ResonanceHProxy;
class SpinOrbitMap1Proxy;
class SpinAxisProxy;
class PtcNormalFormProxy;
class BmadNormalFormProxy;
class BunchTrackProxy;
class SummationRdtProxy;
class LatEleOrder1Proxy;
class LatEleOrderArrayProxy;
class TaoLatSigmaProxy;
class TaoSpinEleProxy;
class TaoPlotCacheProxy;
class TaoSpinPolarizationProxy;
class TaoLatticeBranchProxy;
class TaoModelElementProxy;
class TaoBeamBranchProxy;
class TaoD1DataProxy;
class TaoLatticeProxy;
class TaoBeamUniProxy;
class TaoDynamicApertureProxy;
class TaoModelBranchProxy;
class TaoD2DataProxy;
class TaoSpinMapProxy;
class TaoDataProxy;
class TaoPingScaleProxy;
class TaoUniverseCalcProxy;
class LatEleOrderProxy;
class TaoUniverseProxy;

extern "C" {
void* allocate_fortran_spline_struct();
void deallocate_fortran_spline_struct(void* ptr) noexcept;
void copy_fortran_spline_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SplineProxy> {
  static void* allocate() {
    return allocate_fortran_spline_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_spline_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_spline_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "spline_struct";
  }
};

class SplineProxy : public FortranProxy<SplineProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double x0() const; // 0D_NOT_real
  double y0() const; // 0D_NOT_real
  double x1() const; // 0D_NOT_real
  FortranArray1D<double> coef() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_spin_polar_struct();
void deallocate_fortran_spin_polar_struct(void* ptr) noexcept;
void copy_fortran_spin_polar_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SpinPolarProxy> {
  static void* allocate() {
    return allocate_fortran_spin_polar_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_spin_polar_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_spin_polar_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "spin_polar_struct";
  }
};

class SpinPolarProxy : public FortranProxy<SpinPolarProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double polarization() const; // 0D_NOT_real
  double theta() const; // 0D_NOT_real
  double phi() const; // 0D_NOT_real
  double xi() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_ac_kicker_time_struct();
void deallocate_fortran_ac_kicker_time_struct(void* ptr) noexcept;
void copy_fortran_ac_kicker_time_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<AcKickerTimeProxy> {
  static void* allocate() {
    return allocate_fortran_ac_kicker_time_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ac_kicker_time_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_ac_kicker_time_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "ac_kicker_time_struct";
  }
};

class AcKickerTimeProxy : public FortranProxy<AcKickerTimeProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double amp() const; // 0D_NOT_real
  double time() const; // 0D_NOT_real
  SplineProxy spline() const; // 0D_NOT_type
};

extern "C" {
void* allocate_fortran_ac_kicker_freq_struct();
void deallocate_fortran_ac_kicker_freq_struct(void* ptr) noexcept;
void copy_fortran_ac_kicker_freq_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<AcKickerFreqProxy> {
  static void* allocate() {
    return allocate_fortran_ac_kicker_freq_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ac_kicker_freq_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_ac_kicker_freq_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "ac_kicker_freq_struct";
  }
};

class AcKickerFreqProxy : public FortranProxy<AcKickerFreqProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double f() const; // 0D_NOT_real
  double amp() const; // 0D_NOT_real
  double phi() const; // 0D_NOT_real
  int rf_clock_harmonic() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_ac_kicker_struct();
void deallocate_fortran_ac_kicker_struct(void* ptr) noexcept;
void copy_fortran_ac_kicker_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<AcKickerProxy> {
  static void* allocate() {
    return allocate_fortran_ac_kicker_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ac_kicker_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_ac_kicker_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "ac_kicker_struct";
  }
};

class AcKickerProxy : public FortranProxy<AcKickerProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<AcKickerTimeProxy> amp_vs_time() const; // 1D_ALLOC_type
  FortranTypeArray1D<AcKickerFreqProxy> frequency() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_interval1_coef_struct();
void deallocate_fortran_interval1_coef_struct(void* ptr) noexcept;
void copy_fortran_interval1_coef_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<Interval1CoefProxy> {
  static void* allocate() {
    return allocate_fortran_interval1_coef_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_interval1_coef_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_interval1_coef_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "interval1_coef_struct";
  }
};

class Interval1CoefProxy : public FortranProxy<Interval1CoefProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double c0() const; // 0D_NOT_real
  double c1() const; // 0D_NOT_real
  double n_exp() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_photon_reflect_table_struct();
void deallocate_fortran_photon_reflect_table_struct(void* ptr) noexcept;
void copy_fortran_photon_reflect_table_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PhotonReflectTableProxy> {
  static void* allocate() {
    return allocate_fortran_photon_reflect_table_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_reflect_table_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_photon_reflect_table_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "photon_reflect_table_struct";
  }
};

class PhotonReflectTableProxy : public FortranProxy<PhotonReflectTableProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> angle() const; // 1D_ALLOC_real
  FortranArray1D<double> energy() const; // 1D_ALLOC_real
  FortranTypeArray1D<Interval1CoefProxy> int1() const; // 1D_ALLOC_type
  FortranArray2D<double> p_reflect() const; // 2D_ALLOC_real
  double max_energy() const; // 0D_NOT_real
  FortranArray1D<double> p_reflect_scratch() const; // 1D_ALLOC_real
  FortranArray1D<double> bragg_angle() const; // 1D_ALLOC_real
};

extern "C" {
void* allocate_fortran_photon_reflect_surface_struct();
void deallocate_fortran_photon_reflect_surface_struct(void* ptr) noexcept;
void copy_fortran_photon_reflect_surface_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PhotonReflectSurfaceProxy> {
  static void* allocate() {
    return allocate_fortran_photon_reflect_surface_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_reflect_surface_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_photon_reflect_surface_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "photon_reflect_surface_struct";
  }
};

class PhotonReflectSurfaceProxy
    : public FortranProxy<PhotonReflectSurfaceProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  std::string description() const; // 0D_NOT_character
  FortranArray1D<char> get_description_chars() const; // 0D_NOT_character
  std::string reflectivity_file() const; // 0D_NOT_character
  FortranArray1D<char> get_reflectivity_file_chars() const; // 0D_NOT_character
  FortranTypeArray1D<PhotonReflectTableProxy> table() const; // 1D_ALLOC_type
  double surface_roughness_rms() const; // 0D_NOT_real
  double roughness_correlation_len() const; // 0D_NOT_real
  int ix_surface() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_coord_struct();
void deallocate_fortran_coord_struct(void* ptr) noexcept;
void copy_fortran_coord_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<CoordProxy> {
  static void* allocate() {
    return allocate_fortran_coord_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_coord_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_coord_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "coord_struct";
  }
};

class CoordProxy : public FortranProxy<CoordProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> vec() const; // 1D_NOT_real
  double s() const; // 0D_NOT_real
  long double t() const; // 0D_NOT_real16
  FortranArray1D<double> spin() const; // 1D_NOT_real
  FortranArray1D<double> field() const; // 1D_NOT_real
  FortranArray1D<double> phase() const; // 1D_NOT_real
  double charge() const; // 0D_NOT_real
  double dt_ref() const; // 0D_NOT_real
  double r() const; // 0D_NOT_real
  double p0c() const; // 0D_NOT_real
  double E_potential() const; // 0D_NOT_real
  double beta() const; // 0D_NOT_real
  int ix_ele() const; // 0D_NOT_integer
  int ix_branch() const; // 0D_NOT_integer
  int ix_turn() const; // 0D_NOT_integer
  int ix_user() const; // 0D_NOT_integer
  int state() const; // 0D_NOT_integer
  int direction() const; // 0D_NOT_integer
  int time_dir() const; // 0D_NOT_integer
  int species() const; // 0D_NOT_integer
  int location() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_coord_array_struct();
void deallocate_fortran_coord_array_struct(void* ptr) noexcept;
void copy_fortran_coord_array_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<CoordArrayProxy> {
  static void* allocate() {
    return allocate_fortran_coord_array_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_coord_array_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_coord_array_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "coord_array_struct";
  }
};

class CoordArrayProxy : public FortranProxy<CoordArrayProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<CoordProxy> orbit() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_bpm_phase_coupling_struct();
void deallocate_fortran_bpm_phase_coupling_struct(void* ptr) noexcept;
void copy_fortran_bpm_phase_coupling_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BpmPhaseCouplingProxy> {
  static void* allocate() {
    return allocate_fortran_bpm_phase_coupling_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bpm_phase_coupling_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_bpm_phase_coupling_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "bpm_phase_coupling_struct";
  }
};

class BpmPhaseCouplingProxy : public FortranProxy<BpmPhaseCouplingProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double K_22a() const; // 0D_NOT_real
  double K_12a() const; // 0D_NOT_real
  double K_11b() const; // 0D_NOT_real
  double K_12b() const; // 0D_NOT_real
  double Cbar22_a() const; // 0D_NOT_real
  double Cbar12_a() const; // 0D_NOT_real
  double Cbar11_b() const; // 0D_NOT_real
  double Cbar12_b() const; // 0D_NOT_real
  double phi_a() const; // 0D_NOT_real
  double phi_b() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_expression_atom_struct();
void deallocate_fortran_expression_atom_struct(void* ptr) noexcept;
void copy_fortran_expression_atom_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ExpressionAtomProxy> {
  static void* allocate() {
    return allocate_fortran_expression_atom_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_expression_atom_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_expression_atom_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "expression_atom_struct";
  }
};

class ExpressionAtomProxy : public FortranProxy<ExpressionAtomProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  int type() const; // 0D_NOT_integer
  double value() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_wake_sr_z_long_struct();
void deallocate_fortran_wake_sr_z_long_struct(void* ptr) noexcept;
void copy_fortran_wake_sr_z_long_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<WakeSrZLongProxy> {
  static void* allocate() {
    return allocate_fortran_wake_sr_z_long_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_sr_z_long_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wake_sr_z_long_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wake_sr_z_long_struct";
  }
};

class WakeSrZLongProxy : public FortranProxy<WakeSrZLongProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> w() const; // 1D_ALLOC_real
  double dz() const; // 0D_NOT_real
  double z0() const; // 0D_NOT_real
  double smoothing_sigma() const; // 0D_NOT_real
  int position_dependence() const; // 0D_NOT_integer
  bool time_based() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_wake_sr_mode_struct();
void deallocate_fortran_wake_sr_mode_struct(void* ptr) noexcept;
void copy_fortran_wake_sr_mode_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<WakeSrModeProxy> {
  static void* allocate() {
    return allocate_fortran_wake_sr_mode_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_sr_mode_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wake_sr_mode_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wake_sr_mode_struct";
  }
};

class WakeSrModeProxy : public FortranProxy<WakeSrModeProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double amp() const; // 0D_NOT_real
  double damp() const; // 0D_NOT_real
  double k() const; // 0D_NOT_real
  double phi() const; // 0D_NOT_real
  double b_sin() const; // 0D_NOT_real
  double b_cos() const; // 0D_NOT_real
  double a_sin() const; // 0D_NOT_real
  double a_cos() const; // 0D_NOT_real
  int polarization() const; // 0D_NOT_integer
  int position_dependence() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_wake_sr_struct();
void deallocate_fortran_wake_sr_struct(void* ptr) noexcept;
void copy_fortran_wake_sr_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<WakeSrProxy> {
  static void* allocate() {
    return allocate_fortran_wake_sr_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_sr_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wake_sr_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wake_sr_struct";
  }
};

class WakeSrProxy : public FortranProxy<WakeSrProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string file() const; // 0D_NOT_character
  FortranArray1D<char> get_file_chars() const; // 0D_NOT_character
  WakeSrZLongProxy z_long() const; // 0D_NOT_type
  FortranTypeArray1D<WakeSrModeProxy> long_wake() const; // 1D_ALLOC_type
  FortranTypeArray1D<WakeSrModeProxy> trans_wake() const; // 1D_ALLOC_type
  double z_ref_long() const; // 0D_NOT_real
  double z_ref_trans() const; // 0D_NOT_real
  double z_max() const; // 0D_NOT_real
  double amp_scale() const; // 0D_NOT_real
  double z_scale() const; // 0D_NOT_real
  bool scale_with_length() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_wake_lr_mode_struct();
void deallocate_fortran_wake_lr_mode_struct(void* ptr) noexcept;
void copy_fortran_wake_lr_mode_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<WakeLrModeProxy> {
  static void* allocate() {
    return allocate_fortran_wake_lr_mode_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_lr_mode_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wake_lr_mode_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wake_lr_mode_struct";
  }
};

class WakeLrModeProxy : public FortranProxy<WakeLrModeProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double freq() const; // 0D_NOT_real
  double freq_in() const; // 0D_NOT_real
  double R_over_Q() const; // 0D_NOT_real
  double Q() const; // 0D_NOT_real
  double damp() const; // 0D_NOT_real
  double phi() const; // 0D_NOT_real
  double angle() const; // 0D_NOT_real
  double b_sin() const; // 0D_NOT_real
  double b_cos() const; // 0D_NOT_real
  double a_sin() const; // 0D_NOT_real
  double a_cos() const; // 0D_NOT_real
  int m() const; // 0D_NOT_integer
  bool polarized() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_wake_lr_struct();
void deallocate_fortran_wake_lr_struct(void* ptr) noexcept;
void copy_fortran_wake_lr_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<WakeLrProxy> {
  static void* allocate() {
    return allocate_fortran_wake_lr_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_lr_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wake_lr_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wake_lr_struct";
  }
};

class WakeLrProxy : public FortranProxy<WakeLrProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string file() const; // 0D_NOT_character
  FortranArray1D<char> get_file_chars() const; // 0D_NOT_character
  FortranTypeArray1D<WakeLrModeProxy> mode() const; // 1D_ALLOC_type
  double t_ref() const; // 0D_NOT_real
  double freq_spread() const; // 0D_NOT_real
  double amp_scale() const; // 0D_NOT_real
  double time_scale() const; // 0D_NOT_real
  bool self_wake_on() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_lat_ele_loc_struct();
void deallocate_fortran_lat_ele_loc_struct(void* ptr) noexcept;
void copy_fortran_lat_ele_loc_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<LatEleLocProxy> {
  static void* allocate() {
    return allocate_fortran_lat_ele_loc_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_ele_loc_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_lat_ele_loc_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "lat_ele_loc_struct";
  }
};

class LatEleLocProxy : public FortranProxy<LatEleLocProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int ix_ele() const; // 0D_NOT_integer
  int ix_branch() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_wake_struct();
void deallocate_fortran_wake_struct(void* ptr) noexcept;
void copy_fortran_wake_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<WakeProxy> {
  static void* allocate() {
    return allocate_fortran_wake_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wake_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wake_struct";
  }
};

class WakeProxy : public FortranProxy<WakeProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  WakeSrProxy sr() const; // 0D_NOT_type
  WakeLrProxy lr() const; // 0D_NOT_type
};

extern "C" {
void* allocate_fortran_taylor_term_struct();
void deallocate_fortran_taylor_term_struct(void* ptr) noexcept;
void copy_fortran_taylor_term_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaylorTermProxy> {
  static void* allocate() {
    return allocate_fortran_taylor_term_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_taylor_term_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_taylor_term_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "taylor_term_struct";
  }
};

class TaylorTermProxy : public FortranProxy<TaylorTermProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double coef() const; // 0D_NOT_real
  FortranArray1D<int> expn() const; // 1D_NOT_integer
};

extern "C" {
void* allocate_fortran_taylor_struct();
void deallocate_fortran_taylor_struct(void* ptr) noexcept;
void copy_fortran_taylor_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaylorProxy> {
  static void* allocate() {
    return allocate_fortran_taylor_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_taylor_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_taylor_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "taylor_struct";
  }
};

class TaylorProxy : public FortranProxy<TaylorProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double ref() const; // 0D_NOT_real
  FortranTypeArray1D<TaylorTermProxy> term() const; // 1D_PTR_type
};

extern "C" {
void* allocate_fortran_em_taylor_term_struct();
void deallocate_fortran_em_taylor_term_struct(void* ptr) noexcept;
void copy_fortran_em_taylor_term_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<EmTaylorTermProxy> {
  static void* allocate() {
    return allocate_fortran_em_taylor_term_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_em_taylor_term_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_em_taylor_term_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "em_taylor_term_struct";
  }
};

class EmTaylorTermProxy : public FortranProxy<EmTaylorTermProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double coef() const; // 0D_NOT_real
  FortranArray1D<int> expn() const; // 1D_NOT_integer
};

extern "C" {
void* allocate_fortran_em_taylor_struct();
void deallocate_fortran_em_taylor_struct(void* ptr) noexcept;
void copy_fortran_em_taylor_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<EmTaylorProxy> {
  static void* allocate() {
    return allocate_fortran_em_taylor_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_em_taylor_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_em_taylor_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "em_taylor_struct";
  }
};

class EmTaylorProxy : public FortranProxy<EmTaylorProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double ref() const; // 0D_NOT_real
  FortranTypeArray1D<EmTaylorTermProxy> term() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_cartesian_map_term1_struct();
void deallocate_fortran_cartesian_map_term1_struct(void* ptr) noexcept;
void copy_fortran_cartesian_map_term1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<CartesianMapTerm1Proxy> {
  static void* allocate() {
    return allocate_fortran_cartesian_map_term1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cartesian_map_term1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_cartesian_map_term1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "cartesian_map_term1_struct";
  }
};

class CartesianMapTerm1Proxy : public FortranProxy<CartesianMapTerm1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double coef() const; // 0D_NOT_real
  double kx() const; // 0D_NOT_real
  double ky() const; // 0D_NOT_real
  double kz() const; // 0D_NOT_real
  double x0() const; // 0D_NOT_real
  double y0() const; // 0D_NOT_real
  double phi_z() const; // 0D_NOT_real
  int family() const; // 0D_NOT_integer
  int form() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_cartesian_map_term_struct();
void deallocate_fortran_cartesian_map_term_struct(void* ptr) noexcept;
void copy_fortran_cartesian_map_term_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<CartesianMapTermProxy> {
  static void* allocate() {
    return allocate_fortran_cartesian_map_term_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cartesian_map_term_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_cartesian_map_term_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "cartesian_map_term_struct";
  }
};

class CartesianMapTermProxy : public FortranProxy<CartesianMapTermProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string file() const; // 0D_NOT_character
  FortranArray1D<char> get_file_chars() const; // 0D_NOT_character
  int n_link() const; // 0D_NOT_integer
  FortranTypeArray1D<CartesianMapTerm1Proxy> term() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_cartesian_map_struct();
void deallocate_fortran_cartesian_map_struct(void* ptr) noexcept;
void copy_fortran_cartesian_map_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<CartesianMapProxy> {
  static void* allocate() {
    return allocate_fortran_cartesian_map_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cartesian_map_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_cartesian_map_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "cartesian_map_struct";
  }
};

class CartesianMapProxy : public FortranProxy<CartesianMapProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double field_scale() const; // 0D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  int master_parameter() const; // 0D_NOT_integer
  int ele_anchor_pt() const; // 0D_NOT_integer
  int field_type() const; // 0D_NOT_integer
  const void* ptr() const; // 0D_PTR_type
};

extern "C" {
void* allocate_fortran_cylindrical_map_term1_struct();
void deallocate_fortran_cylindrical_map_term1_struct(void* ptr) noexcept;
void copy_fortran_cylindrical_map_term1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<CylindricalMapTerm1Proxy> {
  static void* allocate() {
    return allocate_fortran_cylindrical_map_term1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cylindrical_map_term1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_cylindrical_map_term1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "cylindrical_map_term1_struct";
  }
};

class CylindricalMapTerm1Proxy : public FortranProxy<CylindricalMapTerm1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::complex<double> e_coef() const; // 0D_NOT_complex
  std::complex<double> b_coef() const; // 0D_NOT_complex
};

extern "C" {
void* allocate_fortran_cylindrical_map_term_struct();
void deallocate_fortran_cylindrical_map_term_struct(void* ptr) noexcept;
void copy_fortran_cylindrical_map_term_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<CylindricalMapTermProxy> {
  static void* allocate() {
    return allocate_fortran_cylindrical_map_term_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cylindrical_map_term_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_cylindrical_map_term_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "cylindrical_map_term_struct";
  }
};

class CylindricalMapTermProxy : public FortranProxy<CylindricalMapTermProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string file() const; // 0D_NOT_character
  FortranArray1D<char> get_file_chars() const; // 0D_NOT_character
  int n_link() const; // 0D_NOT_integer
  FortranTypeArray1D<CylindricalMapTerm1Proxy> term() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_cylindrical_map_struct();
void deallocate_fortran_cylindrical_map_struct(void* ptr) noexcept;
void copy_fortran_cylindrical_map_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<CylindricalMapProxy> {
  static void* allocate() {
    return allocate_fortran_cylindrical_map_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cylindrical_map_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_cylindrical_map_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "cylindrical_map_struct";
  }
};

class CylindricalMapProxy : public FortranProxy<CylindricalMapProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int m() const; // 0D_NOT_integer
  int harmonic() const; // 0D_NOT_integer
  double phi0_fieldmap() const; // 0D_NOT_real
  double theta0_azimuth() const; // 0D_NOT_real
  double field_scale() const; // 0D_NOT_real
  int master_parameter() const; // 0D_NOT_integer
  int ele_anchor_pt() const; // 0D_NOT_integer
  double dz() const; // 0D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  const void* ptr() const; // 0D_PTR_type
};

extern "C" {
void* allocate_fortran_bicubic_cmplx_coef_struct();
void deallocate_fortran_bicubic_cmplx_coef_struct(void* ptr) noexcept;
void copy_fortran_bicubic_cmplx_coef_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BicubicCmplxCoefProxy> {
  static void* allocate() {
    return allocate_fortran_bicubic_cmplx_coef_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bicubic_cmplx_coef_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_bicubic_cmplx_coef_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "bicubic_cmplx_coef_struct";
  }
};

class BicubicCmplxCoefProxy : public FortranProxy<BicubicCmplxCoefProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<int> i_box() const; // 1D_NOT_integer
};

extern "C" {
void* allocate_fortran_tricubic_cmplx_coef_struct();
void deallocate_fortran_tricubic_cmplx_coef_struct(void* ptr) noexcept;
void copy_fortran_tricubic_cmplx_coef_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TricubicCmplxCoefProxy> {
  static void* allocate() {
    return allocate_fortran_tricubic_cmplx_coef_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tricubic_cmplx_coef_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tricubic_cmplx_coef_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tricubic_cmplx_coef_struct";
  }
};

class TricubicCmplxCoefProxy : public FortranProxy<TricubicCmplxCoefProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<int> i_box() const; // 1D_NOT_integer
};

extern "C" {
void* allocate_fortran_grid_field_pt1_struct();
void deallocate_fortran_grid_field_pt1_struct(void* ptr) noexcept;
void copy_fortran_grid_field_pt1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<GridFieldPt1Proxy> {
  static void* allocate() {
    return allocate_fortran_grid_field_pt1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_grid_field_pt1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_grid_field_pt1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "grid_field_pt1_struct";
  }
};

class GridFieldPt1Proxy : public FortranProxy<GridFieldPt1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<std::complex<double>> E() const; // 1D_NOT_complex
  FortranArray1D<std::complex<double>> B() const; // 1D_NOT_complex
};

extern "C" {
void* allocate_fortran_grid_field_pt_struct();
void deallocate_fortran_grid_field_pt_struct(void* ptr) noexcept;
void copy_fortran_grid_field_pt_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<GridFieldPtProxy> {
  static void* allocate() {
    return allocate_fortran_grid_field_pt_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_grid_field_pt_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_grid_field_pt_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "grid_field_pt_struct";
  }
};

class GridFieldPtProxy : public FortranProxy<GridFieldPtProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string file() const; // 0D_NOT_character
  FortranArray1D<char> get_file_chars() const; // 0D_NOT_character
  int n_link() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_grid_field_struct();
void deallocate_fortran_grid_field_struct(void* ptr) noexcept;
void copy_fortran_grid_field_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<GridFieldProxy> {
  static void* allocate() {
    return allocate_fortran_grid_field_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_grid_field_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_grid_field_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "grid_field_struct";
  }
};

class GridFieldProxy : public FortranProxy<GridFieldProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int geometry() const; // 0D_NOT_integer
  int harmonic() const; // 0D_NOT_integer
  double phi0_fieldmap() const; // 0D_NOT_real
  double field_scale() const; // 0D_NOT_real
  int field_type() const; // 0D_NOT_integer
  int master_parameter() const; // 0D_NOT_integer
  int ele_anchor_pt() const; // 0D_NOT_integer
  int interpolation_order() const; // 0D_NOT_integer
  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  bool curved_ref_frame() const; // 0D_NOT_logical
  const void* ptr() const; // 0D_PTR_type
};

extern "C" {
void* allocate_fortran_floor_position_struct();
void deallocate_fortran_floor_position_struct(void* ptr) noexcept;
void copy_fortran_floor_position_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<FloorPositionProxy> {
  static void* allocate() {
    return allocate_fortran_floor_position_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_floor_position_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_floor_position_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "floor_position_struct";
  }
};

class FloorPositionProxy : public FortranProxy<FloorPositionProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> r() const; // 1D_NOT_real
  double theta() const; // 0D_NOT_real
  double phi() const; // 0D_NOT_real
  double psi() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_high_energy_space_charge_struct();
void deallocate_fortran_high_energy_space_charge_struct(void* ptr) noexcept;
void copy_fortran_high_energy_space_charge_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<HighEnergySpaceChargeProxy> {
  static void* allocate() {
    return allocate_fortran_high_energy_space_charge_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_high_energy_space_charge_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_high_energy_space_charge_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "high_energy_space_charge_struct";
  }
};

class HighEnergySpaceChargeProxy
    : public FortranProxy<HighEnergySpaceChargeProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  CoordProxy closed_orb() const; // 0D_NOT_type
  double kick_const() const; // 0D_NOT_real
  double sig_x() const; // 0D_NOT_real
  double sig_y() const; // 0D_NOT_real
  double phi() const; // 0D_NOT_real
  double sin_phi() const; // 0D_NOT_real
  double cos_phi() const; // 0D_NOT_real
  double sig_z() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_xy_disp_struct();
void deallocate_fortran_xy_disp_struct(void* ptr) noexcept;
void copy_fortran_xy_disp_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<XyDispProxy> {
  static void* allocate() {
    return allocate_fortran_xy_disp_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_xy_disp_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_xy_disp_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "xy_disp_struct";
  }
};

class XyDispProxy : public FortranProxy<XyDispProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double eta() const; // 0D_NOT_real
  double etap() const; // 0D_NOT_real
  double deta_ds() const; // 0D_NOT_real
  double sigma() const; // 0D_NOT_real
  double deta_dpz() const; // 0D_NOT_real
  double detap_dpz() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_twiss_struct();
void deallocate_fortran_twiss_struct(void* ptr) noexcept;
void copy_fortran_twiss_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TwissProxy> {
  static void* allocate() {
    return allocate_fortran_twiss_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_twiss_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_twiss_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "twiss_struct";
  }
};

class TwissProxy : public FortranProxy<TwissProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double beta() const; // 0D_NOT_real
  double alpha() const; // 0D_NOT_real
  double gamma() const; // 0D_NOT_real
  double phi() const; // 0D_NOT_real
  double eta() const; // 0D_NOT_real
  double etap() const; // 0D_NOT_real
  double deta_ds() const; // 0D_NOT_real
  double sigma() const; // 0D_NOT_real
  double sigma_p() const; // 0D_NOT_real
  double emit() const; // 0D_NOT_real
  double norm_emit() const; // 0D_NOT_real
  double chrom() const; // 0D_NOT_real
  double dbeta_dpz() const; // 0D_NOT_real
  double dalpha_dpz() const; // 0D_NOT_real
  double deta_dpz() const; // 0D_NOT_real
  double detap_dpz() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_mode3_struct();
void deallocate_fortran_mode3_struct(void* ptr) noexcept;
void copy_fortran_mode3_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<Mode3Proxy> {
  static void* allocate() {
    return allocate_fortran_mode3_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_mode3_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_mode3_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "mode3_struct";
  }
};

class Mode3Proxy : public FortranProxy<Mode3Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  TwissProxy a() const; // 0D_NOT_type
  TwissProxy b() const; // 0D_NOT_type
  TwissProxy c() const; // 0D_NOT_type
  TwissProxy x() const; // 0D_NOT_type
  TwissProxy y() const; // 0D_NOT_type
};

extern "C" {
void* allocate_fortran_bookkeeping_state_struct();
void deallocate_fortran_bookkeeping_state_struct(void* ptr) noexcept;
void copy_fortran_bookkeeping_state_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BookkeepingStateProxy> {
  static void* allocate() {
    return allocate_fortran_bookkeeping_state_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bookkeeping_state_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_bookkeeping_state_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "bookkeeping_state_struct";
  }
};

class BookkeepingStateProxy : public FortranProxy<BookkeepingStateProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int attributes() const; // 0D_NOT_integer
  int control() const; // 0D_NOT_integer
  int floor_position() const; // 0D_NOT_integer
  int s_position() const; // 0D_NOT_integer
  int ref_energy() const; // 0D_NOT_integer
  int mat6() const; // 0D_NOT_integer
  int rad_int() const; // 0D_NOT_integer
  int ptc() const; // 0D_NOT_integer
  bool has_misalign() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_rad_map_struct();
void deallocate_fortran_rad_map_struct(void* ptr) noexcept;
void copy_fortran_rad_map_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<RadMapProxy> {
  static void* allocate() {
    return allocate_fortran_rad_map_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_map_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_rad_map_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "rad_map_struct";
  }
};

class RadMapProxy : public FortranProxy<RadMapProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> ref_orb() const; // 1D_NOT_real
  FortranArray1D<double> xfer_damp_vec() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_rad_map_ele_struct();
void deallocate_fortran_rad_map_ele_struct(void* ptr) noexcept;
void copy_fortran_rad_map_ele_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<RadMapEleProxy> {
  static void* allocate() {
    return allocate_fortran_rad_map_ele_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_map_ele_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_rad_map_ele_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "rad_map_ele_struct";
  }
};

class RadMapEleProxy : public FortranProxy<RadMapEleProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  RadMapProxy rm0() const; // 0D_NOT_type
  RadMapProxy rm1() const; // 0D_NOT_type
  bool stale() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_gen_grad1_struct();
void deallocate_fortran_gen_grad1_struct(void* ptr) noexcept;
void copy_fortran_gen_grad1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<GenGrad1Proxy> {
  static void* allocate() {
    return allocate_fortran_gen_grad1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_gen_grad1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_gen_grad1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "gen_grad1_struct";
  }
};

class GenGrad1Proxy : public FortranProxy<GenGrad1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int m() const; // 0D_NOT_integer
  int sincos() const; // 0D_NOT_integer
  int n_deriv_max() const; // 0D_NOT_integer
  FortranArray2D<double> deriv() const; // 2D_ALLOC_real
};

extern "C" {
void* allocate_fortran_gen_grad_map_struct();
void deallocate_fortran_gen_grad_map_struct(void* ptr) noexcept;
void copy_fortran_gen_grad_map_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<GenGradMapProxy> {
  static void* allocate() {
    return allocate_fortran_gen_grad_map_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_gen_grad_map_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_gen_grad_map_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "gen_grad_map_struct";
  }
};

class GenGradMapProxy : public FortranProxy<GenGradMapProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string file() const; // 0D_NOT_character
  FortranArray1D<char> get_file_chars() const; // 0D_NOT_character
  FortranTypeArray1D<GenGrad1Proxy> gg() const; // 1D_ALLOC_type
  int ele_anchor_pt() const; // 0D_NOT_integer
  int field_type() const; // 0D_NOT_integer
  int iz0() const; // 0D_NOT_integer
  int iz1() const; // 0D_NOT_integer
  double dz() const; // 0D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  double field_scale() const; // 0D_NOT_real
  int master_parameter() const; // 0D_NOT_integer
  bool curved_ref_frame() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_surface_segmented_pt_struct();
void deallocate_fortran_surface_segmented_pt_struct(void* ptr) noexcept;
void copy_fortran_surface_segmented_pt_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SurfaceSegmentedPtProxy> {
  static void* allocate() {
    return allocate_fortran_surface_segmented_pt_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_segmented_pt_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_surface_segmented_pt_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "surface_segmented_pt_struct";
  }
};

class SurfaceSegmentedPtProxy : public FortranProxy<SurfaceSegmentedPtProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double x0() const; // 0D_NOT_real
  double y0() const; // 0D_NOT_real
  double z0() const; // 0D_NOT_real
  double dz_dx() const; // 0D_NOT_real
  double dz_dy() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_surface_segmented_struct();
void deallocate_fortran_surface_segmented_struct(void* ptr) noexcept;
void copy_fortran_surface_segmented_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SurfaceSegmentedProxy> {
  static void* allocate() {
    return allocate_fortran_surface_segmented_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_segmented_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_surface_segmented_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "surface_segmented_struct";
  }
};

class SurfaceSegmentedProxy : public FortranProxy<SurfaceSegmentedProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  bool active() const; // 0D_NOT_logical
  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_surface_h_misalign_pt_struct();
void deallocate_fortran_surface_h_misalign_pt_struct(void* ptr) noexcept;
void copy_fortran_surface_h_misalign_pt_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SurfaceHMisalignPtProxy> {
  static void* allocate() {
    return allocate_fortran_surface_h_misalign_pt_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_h_misalign_pt_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_surface_h_misalign_pt_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "surface_h_misalign_pt_struct";
  }
};

class SurfaceHMisalignPtProxy : public FortranProxy<SurfaceHMisalignPtProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double x0() const; // 0D_NOT_real
  double y0() const; // 0D_NOT_real
  double rot_y() const; // 0D_NOT_real
  double rot_t() const; // 0D_NOT_real
  double rot_y_rms() const; // 0D_NOT_real
  double rot_t_rms() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_surface_h_misalign_struct();
void deallocate_fortran_surface_h_misalign_struct(void* ptr) noexcept;
void copy_fortran_surface_h_misalign_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SurfaceHMisalignProxy> {
  static void* allocate() {
    return allocate_fortran_surface_h_misalign_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_h_misalign_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_surface_h_misalign_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "surface_h_misalign_struct";
  }
};

class SurfaceHMisalignProxy : public FortranProxy<SurfaceHMisalignProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  bool active() const; // 0D_NOT_logical
  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_surface_displacement_pt_struct();
void deallocate_fortran_surface_displacement_pt_struct(void* ptr) noexcept;
void copy_fortran_surface_displacement_pt_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SurfaceDisplacementPtProxy> {
  static void* allocate() {
    return allocate_fortran_surface_displacement_pt_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_displacement_pt_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_surface_displacement_pt_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "surface_displacement_pt_struct";
  }
};

class SurfaceDisplacementPtProxy
    : public FortranProxy<SurfaceDisplacementPtProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double x0() const; // 0D_NOT_real
  double y0() const; // 0D_NOT_real
  double z0() const; // 0D_NOT_real
  double dz_dx() const; // 0D_NOT_real
  double dz_dy() const; // 0D_NOT_real
  double d2z_dxdy() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_surface_displacement_struct();
void deallocate_fortran_surface_displacement_struct(void* ptr) noexcept;
void copy_fortran_surface_displacement_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SurfaceDisplacementProxy> {
  static void* allocate() {
    return allocate_fortran_surface_displacement_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_displacement_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_surface_displacement_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "surface_displacement_struct";
  }
};

class SurfaceDisplacementProxy : public FortranProxy<SurfaceDisplacementProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  bool active() const; // 0D_NOT_logical
  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_target_point_struct();
void deallocate_fortran_target_point_struct(void* ptr) noexcept;
void copy_fortran_target_point_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TargetPointProxy> {
  static void* allocate() {
    return allocate_fortran_target_point_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_target_point_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_target_point_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "target_point_struct";
  }
};

class TargetPointProxy : public FortranProxy<TargetPointProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> r() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_surface_curvature_struct();
void deallocate_fortran_surface_curvature_struct(void* ptr) noexcept;
void copy_fortran_surface_curvature_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SurfaceCurvatureProxy> {
  static void* allocate() {
    return allocate_fortran_surface_curvature_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_curvature_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_surface_curvature_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "surface_curvature_struct";
  }
};

class SurfaceCurvatureProxy : public FortranProxy<SurfaceCurvatureProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double spherical() const; // 0D_NOT_real
  FortranArray1D<double> elliptical() const; // 1D_NOT_real
  bool has_curvature() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_photon_target_struct();
void deallocate_fortran_photon_target_struct(void* ptr) noexcept;
void copy_fortran_photon_target_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PhotonTargetProxy> {
  static void* allocate() {
    return allocate_fortran_photon_target_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_target_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_photon_target_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "photon_target_struct";
  }
};

class PhotonTargetProxy : public FortranProxy<PhotonTargetProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int type() const; // 0D_NOT_integer
  int n_corner() const; // 0D_NOT_integer
  LatEleLocProxy ele_loc() const; // 0D_NOT_type
  FortranTypeArray1D<TargetPointProxy> corner() const; // 1D_NOT_type
  TargetPointProxy center() const; // 0D_NOT_type
};

extern "C" {
void* allocate_fortran_photon_material_struct();
void deallocate_fortran_photon_material_struct(void* ptr) noexcept;
void copy_fortran_photon_material_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PhotonMaterialProxy> {
  static void* allocate() {
    return allocate_fortran_photon_material_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_material_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_photon_material_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "photon_material_struct";
  }
};

class PhotonMaterialProxy : public FortranProxy<PhotonMaterialProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::complex<double> f0_m1() const; // 0D_NOT_complex
  std::complex<double> f0_m2() const; // 0D_NOT_complex
  std::complex<double> f_0() const; // 0D_NOT_complex
  std::complex<double> f_h() const; // 0D_NOT_complex
  std::complex<double> f_hbar() const; // 0D_NOT_complex
  std::complex<double> f_hkl() const; // 0D_NOT_complex
  FortranArray1D<double> h_norm() const; // 1D_NOT_real
  FortranArray1D<double> l_ref() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_pixel_pt_struct();
void deallocate_fortran_pixel_pt_struct(void* ptr) noexcept;
void copy_fortran_pixel_pt_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PixelPtProxy> {
  static void* allocate() {
    return allocate_fortran_pixel_pt_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_pixel_pt_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_pixel_pt_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "pixel_pt_struct";
  }
};

class PixelPtProxy : public FortranProxy<PixelPtProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  long long n_photon() const; // 0D_NOT_integer8
  std::complex<double> E_x() const; // 0D_NOT_complex
  std::complex<double> E_y() const; // 0D_NOT_complex
  double intensity_x() const; // 0D_NOT_real
  double intensity_y() const; // 0D_NOT_real
  double intensity() const; // 0D_NOT_real
  FortranArray1D<double> orbit() const; // 1D_NOT_real
  FortranArray1D<double> orbit_rms() const; // 1D_NOT_real
  FortranArray1D<double> init_orbit() const; // 1D_NOT_real
  FortranArray1D<double> init_orbit_rms() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_pixel_detec_struct();
void deallocate_fortran_pixel_detec_struct(void* ptr) noexcept;
void copy_fortran_pixel_detec_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PixelDetecProxy> {
  static void* allocate() {
    return allocate_fortran_pixel_detec_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_pixel_detec_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_pixel_detec_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "pixel_detec_struct";
  }
};

class PixelDetecProxy : public FortranProxy<PixelDetecProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  long long n_track_tot() const; // 0D_NOT_integer8
  long long n_hit_detec() const; // 0D_NOT_integer8
  long long n_hit_pixel() const; // 0D_NOT_integer8
};

extern "C" {
void* allocate_fortran_photon_element_struct();
void deallocate_fortran_photon_element_struct(void* ptr) noexcept;
void copy_fortran_photon_element_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PhotonElementProxy> {
  static void* allocate() {
    return allocate_fortran_photon_element_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_element_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_photon_element_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "photon_element_struct";
  }
};

class PhotonElementProxy : public FortranProxy<PhotonElementProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  SurfaceCurvatureProxy curvature() const; // 0D_NOT_type
  PhotonTargetProxy target() const; // 0D_NOT_type
  PhotonMaterialProxy material() const; // 0D_NOT_type
  SurfaceSegmentedProxy segmented() const; // 0D_NOT_type
  SurfaceHMisalignProxy h_misalign() const; // 0D_NOT_type
  SurfaceDisplacementProxy displacement() const; // 0D_NOT_type
  PixelDetecProxy pixel() const; // 0D_NOT_type
  int reflectivity_table_type() const; // 0D_NOT_integer
  PhotonReflectTableProxy reflectivity_table_sigma() const; // 0D_NOT_type
  PhotonReflectTableProxy reflectivity_table_pi() const; // 0D_NOT_type
  FortranTypeArray1D<SplineProxy> init_energy_prob() const; // 1D_ALLOC_type
  FortranArray1D<double> integrated_init_energy_prob() const; // 1D_ALLOC_real
};

extern "C" {
void* allocate_fortran_wall3d_vertex_struct();
void deallocate_fortran_wall3d_vertex_struct(void* ptr) noexcept;
void copy_fortran_wall3d_vertex_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<Wall3dVertexProxy> {
  static void* allocate() {
    return allocate_fortran_wall3d_vertex_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wall3d_vertex_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wall3d_vertex_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wall3d_vertex_struct";
  }
};

class Wall3dVertexProxy : public FortranProxy<Wall3dVertexProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double x() const; // 0D_NOT_real
  double y() const; // 0D_NOT_real
  double radius_x() const; // 0D_NOT_real
  double radius_y() const; // 0D_NOT_real
  double tilt() const; // 0D_NOT_real
  double angle() const; // 0D_NOT_real
  double x0() const; // 0D_NOT_real
  double y0() const; // 0D_NOT_real
  int type() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_wall3d_section_struct();
void deallocate_fortran_wall3d_section_struct(void* ptr) noexcept;
void copy_fortran_wall3d_section_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<Wall3dSectionProxy> {
  static void* allocate() {
    return allocate_fortran_wall3d_section_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wall3d_section_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wall3d_section_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wall3d_section_struct";
  }
};

class Wall3dSectionProxy : public FortranProxy<Wall3dSectionProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  std::string material() const; // 0D_NOT_character
  FortranArray1D<char> get_material_chars() const; // 0D_NOT_character
  FortranTypeArray1D<Wall3dVertexProxy> v() const; // 1D_ALLOC_type
  const void* surface() const; // 0D_PTR_type
  int type() const; // 0D_NOT_integer
  int n_vertex_input() const; // 0D_NOT_integer
  int ix_ele() const; // 0D_NOT_integer
  int ix_branch() const; // 0D_NOT_integer
  int vertices_state() const; // 0D_NOT_integer
  bool patch_in_region() const; // 0D_NOT_logical
  double thickness() const; // 0D_NOT_real
  double s() const; // 0D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  double dx0_ds() const; // 0D_NOT_real
  double dy0_ds() const; // 0D_NOT_real
  FortranArray1D<double> x0_coef() const; // 1D_NOT_real
  FortranArray1D<double> y0_coef() const; // 1D_NOT_real
  double dr_ds() const; // 0D_NOT_real
  FortranArray1D<double> p1_coef() const; // 1D_NOT_real
  FortranArray1D<double> p2_coef() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_wall3d_struct();
void deallocate_fortran_wall3d_struct(void* ptr) noexcept;
void copy_fortran_wall3d_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<Wall3dProxy> {
  static void* allocate() {
    return allocate_fortran_wall3d_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wall3d_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_wall3d_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "wall3d_struct";
  }
};

class Wall3dProxy : public FortranProxy<Wall3dProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  int type() const; // 0D_NOT_integer
  int ix_wall3d() const; // 0D_NOT_integer
  int n_link() const; // 0D_NOT_integer
  double thickness() const; // 0D_NOT_real
  std::string clear_material() const; // 0D_NOT_character
  FortranArray1D<char> get_clear_material_chars() const; // 0D_NOT_character
  std::string opaque_material() const; // 0D_NOT_character
  FortranArray1D<char> get_opaque_material_chars() const; // 0D_NOT_character
  bool superimpose() const; // 0D_NOT_logical
  int ele_anchor_pt() const; // 0D_NOT_integer
  FortranTypeArray1D<Wall3dSectionProxy> section() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_ramper_lord_struct();
void deallocate_fortran_ramper_lord_struct(void* ptr) noexcept;
void copy_fortran_ramper_lord_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<RamperLordProxy> {
  static void* allocate() {
    return allocate_fortran_ramper_lord_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ramper_lord_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_ramper_lord_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "ramper_lord_struct";
  }
};

class RamperLordProxy : public FortranProxy<RamperLordProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int ix_ele() const; // 0D_NOT_integer
  int ix_con() const; // 0D_NOT_integer
  double* attrib_ptr() const; // 0D_PTR_real
};

extern "C" {
void* allocate_fortran_control_struct();
void deallocate_fortran_control_struct(void* ptr) noexcept;
void copy_fortran_control_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ControlProxy> {
  static void* allocate() {
    return allocate_fortran_control_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_control_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_control_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "control_struct";
  }
};

class ControlProxy : public FortranProxy<ControlProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double value() const; // 0D_NOT_real
  FortranArray1D<double> y_knot() const; // 1D_ALLOC_real
  FortranTypeArray1D<ExpressionAtomProxy> stack() const; // 1D_ALLOC_type
  LatEleLocProxy slave() const; // 0D_NOT_type
  LatEleLocProxy lord() const; // 0D_NOT_type
  std::string slave_name() const; // 0D_NOT_character
  FortranArray1D<char> get_slave_name_chars() const; // 0D_NOT_character
  std::string attribute() const; // 0D_NOT_character
  FortranArray1D<char> get_attribute_chars() const; // 0D_NOT_character
  int ix_attrib() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_control_var1_struct();
void deallocate_fortran_control_var1_struct(void* ptr) noexcept;
void copy_fortran_control_var1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ControlVar1Proxy> {
  static void* allocate() {
    return allocate_fortran_control_var1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_control_var1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_control_var1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "control_var1_struct";
  }
};

class ControlVar1Proxy : public FortranProxy<ControlVar1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  double value() const; // 0D_NOT_real
  double old_value() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_control_ramp1_struct();
void deallocate_fortran_control_ramp1_struct(void* ptr) noexcept;
void copy_fortran_control_ramp1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ControlRamp1Proxy> {
  static void* allocate() {
    return allocate_fortran_control_ramp1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_control_ramp1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_control_ramp1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "control_ramp1_struct";
  }
};

class ControlRamp1Proxy : public FortranProxy<ControlRamp1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> y_knot() const; // 1D_ALLOC_real
  FortranTypeArray1D<ExpressionAtomProxy> stack() const; // 1D_ALLOC_type
  std::string attribute() const; // 0D_NOT_character
  FortranArray1D<char> get_attribute_chars() const; // 0D_NOT_character
  std::string slave_name() const; // 0D_NOT_character
  FortranArray1D<char> get_slave_name_chars() const; // 0D_NOT_character
  bool is_controller() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_controller_struct();
void deallocate_fortran_controller_struct(void* ptr) noexcept;
void copy_fortran_controller_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ControllerProxy> {
  static void* allocate() {
    return allocate_fortran_controller_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_controller_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_controller_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "controller_struct";
  }
};

class ControllerProxy : public FortranProxy<ControllerProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<ControlVar1Proxy> var() const; // 1D_ALLOC_type
  FortranTypeArray1D<ControlRamp1Proxy> ramp() const; // 1D_ALLOC_type
  FortranTypeArray1D<RamperLordProxy> ramper_lord() const; // 1D_ALLOC_type
  FortranArray1D<double> x_knot() const; // 1D_ALLOC_real
};

extern "C" {
void* allocate_fortran_ellipse_beam_init_struct();
void deallocate_fortran_ellipse_beam_init_struct(void* ptr) noexcept;
void copy_fortran_ellipse_beam_init_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<EllipseBeamInitProxy> {
  static void* allocate() {
    return allocate_fortran_ellipse_beam_init_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ellipse_beam_init_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_ellipse_beam_init_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "ellipse_beam_init_struct";
  }
};

class EllipseBeamInitProxy : public FortranProxy<EllipseBeamInitProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int part_per_ellipse() const; // 0D_NOT_integer
  int n_ellipse() const; // 0D_NOT_integer
  double sigma_cutoff() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_kv_beam_init_struct();
void deallocate_fortran_kv_beam_init_struct(void* ptr) noexcept;
void copy_fortran_kv_beam_init_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<KvBeamInitProxy> {
  static void* allocate() {
    return allocate_fortran_kv_beam_init_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_kv_beam_init_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_kv_beam_init_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "kv_beam_init_struct";
  }
};

class KvBeamInitProxy : public FortranProxy<KvBeamInitProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<int> part_per_phi() const; // 1D_NOT_integer
  int n_I2() const; // 0D_NOT_integer
  double A() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_grid_beam_init_struct();
void deallocate_fortran_grid_beam_init_struct(void* ptr) noexcept;
void copy_fortran_grid_beam_init_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<GridBeamInitProxy> {
  static void* allocate() {
    return allocate_fortran_grid_beam_init_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_grid_beam_init_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_grid_beam_init_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "grid_beam_init_struct";
  }
};

class GridBeamInitProxy : public FortranProxy<GridBeamInitProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int n_x() const; // 0D_NOT_integer
  int n_px() const; // 0D_NOT_integer
  double x_min() const; // 0D_NOT_real
  double x_max() const; // 0D_NOT_real
  double px_min() const; // 0D_NOT_real
  double px_max() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_beam_init_struct();
void deallocate_fortran_beam_init_struct(void* ptr) noexcept;
void copy_fortran_beam_init_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BeamInitProxy> {
  static void* allocate() {
    return allocate_fortran_beam_init_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_beam_init_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_beam_init_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "beam_init_struct";
  }
};

class BeamInitProxy : public FortranProxy<BeamInitProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string position_file() const; // 0D_NOT_character
  FortranArray1D<char> get_position_file_chars() const; // 0D_NOT_character
  FortranArray1D<double> spin() const; // 1D_NOT_real
  FortranTypeArray1D<EllipseBeamInitProxy> ellipse() const; // 1D_NOT_type
  KvBeamInitProxy KV() const; // 0D_NOT_type
  FortranTypeArray1D<GridBeamInitProxy> grid() const; // 1D_NOT_type
  FortranArray1D<double> center_jitter() const; // 1D_NOT_real
  FortranArray1D<double> emit_jitter() const; // 1D_NOT_real
  double sig_z_jitter() const; // 0D_NOT_real
  double sig_pz_jitter() const; // 0D_NOT_real
  int n_particle() const; // 0D_NOT_integer
  bool renorm_center() const; // 0D_NOT_logical
  bool renorm_sigma() const; // 0D_NOT_logical
  std::string random_engine() const; // 0D_NOT_character
  FortranArray1D<char> get_random_engine_chars() const; // 0D_NOT_character
  std::string random_gauss_converter() const; // 0D_NOT_character
  FortranArray1D<char> get_random_gauss_converter_chars()
      const; // 0D_NOT_character
  double random_sigma_cutoff() const; // 0D_NOT_real
  double a_norm_emit() const; // 0D_NOT_real
  double b_norm_emit() const; // 0D_NOT_real
  double a_emit() const; // 0D_NOT_real
  double b_emit() const; // 0D_NOT_real
  double dPz_dz() const; // 0D_NOT_real
  FortranArray1D<double> center() const; // 1D_NOT_real
  double t_offset() const; // 0D_NOT_real
  double dt_bunch() const; // 0D_NOT_real
  double sig_z() const; // 0D_NOT_real
  double sig_pz() const; // 0D_NOT_real
  double bunch_charge() const; // 0D_NOT_real
  int n_bunch() const; // 0D_NOT_integer
  int ix_turn() const; // 0D_NOT_integer
  std::string species() const; // 0D_NOT_character
  FortranArray1D<char> get_species_chars() const; // 0D_NOT_character
  bool full_6D_coupling_calc() const; // 0D_NOT_logical
  bool use_particle_start() const; // 0D_NOT_logical
  bool use_t_coords() const; // 0D_NOT_logical
  bool use_z_as_t() const; // 0D_NOT_logical
  std::string file_name() const; // 0D_NOT_character
  FortranArray1D<char> get_file_name_chars() const; // 0D_NOT_character
};

extern "C" {
void* allocate_fortran_lat_param_struct();
void deallocate_fortran_lat_param_struct(void* ptr) noexcept;
void copy_fortran_lat_param_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<LatParamProxy> {
  static void* allocate() {
    return allocate_fortran_lat_param_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_param_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_lat_param_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "lat_param_struct";
  }
};

class LatParamProxy : public FortranProxy<LatParamProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double n_part() const; // 0D_NOT_real
  double total_length() const; // 0D_NOT_real
  double unstable_factor() const; // 0D_NOT_real
  double spin_tune() const; // 0D_NOT_real
  int particle() const; // 0D_NOT_integer
  int default_tracking_species() const; // 0D_NOT_integer
  int geometry() const; // 0D_NOT_integer
  int ixx() const; // 0D_NOT_integer
  bool stable() const; // 0D_NOT_logical
  bool live_branch() const; // 0D_NOT_logical
  double g1_integral() const; // 0D_NOT_real
  double g2_integral() const; // 0D_NOT_real
  double g3_integral() const; // 0D_NOT_real
  BookkeepingStateProxy bookkeeping_state() const; // 0D_NOT_type
  BeamInitProxy beam_init() const; // 0D_NOT_type
};

extern "C" {
void* allocate_fortran_mode_info_struct();
void deallocate_fortran_mode_info_struct(void* ptr) noexcept;
void copy_fortran_mode_info_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ModeInfoProxy> {
  static void* allocate() {
    return allocate_fortran_mode_info_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_mode_info_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_mode_info_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "mode_info_struct";
  }
};

class ModeInfoProxy : public FortranProxy<ModeInfoProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  bool stable() const; // 0D_NOT_logical
  double tune() const; // 0D_NOT_real
  double emit() const; // 0D_NOT_real
  double chrom() const; // 0D_NOT_real
  double sigma() const; // 0D_NOT_real
  double sigmap() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_pre_tracker_struct();
void deallocate_fortran_pre_tracker_struct(void* ptr) noexcept;
void copy_fortran_pre_tracker_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PreTrackerProxy> {
  static void* allocate() {
    return allocate_fortran_pre_tracker_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_pre_tracker_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_pre_tracker_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "pre_tracker_struct";
  }
};

class PreTrackerProxy : public FortranProxy<PreTrackerProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int who() const; // 0D_NOT_integer
  int ix_ele_start() const; // 0D_NOT_integer
  int ix_ele_end() const; // 0D_NOT_integer
  std::string input_file() const; // 0D_NOT_character
  FortranArray1D<char> get_input_file_chars() const; // 0D_NOT_character
};

extern "C" {
void* allocate_fortran_anormal_mode_struct();
void deallocate_fortran_anormal_mode_struct(void* ptr) noexcept;
void copy_fortran_anormal_mode_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<AnormalModeProxy> {
  static void* allocate() {
    return allocate_fortran_anormal_mode_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_anormal_mode_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_anormal_mode_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "anormal_mode_struct";
  }
};

class AnormalModeProxy : public FortranProxy<AnormalModeProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double emittance() const; // 0D_NOT_real
  double emittance_no_vert() const; // 0D_NOT_real
  FortranArray1D<double> synch_int() const; // 1D_NOT_real
  double j_damp() const; // 0D_NOT_real
  double alpha_damp() const; // 0D_NOT_real
  double chrom() const; // 0D_NOT_real
  double tune() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_linac_normal_mode_struct();
void deallocate_fortran_linac_normal_mode_struct(void* ptr) noexcept;
void copy_fortran_linac_normal_mode_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<LinacNormalModeProxy> {
  static void* allocate() {
    return allocate_fortran_linac_normal_mode_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_linac_normal_mode_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_linac_normal_mode_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "linac_normal_mode_struct";
  }
};

class LinacNormalModeProxy : public FortranProxy<LinacNormalModeProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double i2_E4() const; // 0D_NOT_real
  double i3_E7() const; // 0D_NOT_real
  double i5a_E6() const; // 0D_NOT_real
  double i5b_E6() const; // 0D_NOT_real
  double sig_E1() const; // 0D_NOT_real
  double a_emittance_end() const; // 0D_NOT_real
  double b_emittance_end() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_normal_modes_struct();
void deallocate_fortran_normal_modes_struct(void* ptr) noexcept;
void copy_fortran_normal_modes_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<NormalModesProxy> {
  static void* allocate() {
    return allocate_fortran_normal_modes_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_normal_modes_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_normal_modes_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "normal_modes_struct";
  }
};

class NormalModesProxy : public FortranProxy<NormalModesProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> synch_int() const; // 1D_NOT_real
  double sigE_E() const; // 0D_NOT_real
  double sig_z() const; // 0D_NOT_real
  double e_loss() const; // 0D_NOT_real
  double rf_voltage() const; // 0D_NOT_real
  double pz_aperture() const; // 0D_NOT_real
  double pz_average() const; // 0D_NOT_real
  double momentum_compaction() const; // 0D_NOT_real
  double dpz_damp() const; // 0D_NOT_real
  AnormalModeProxy a() const; // 0D_NOT_type
  AnormalModeProxy b() const; // 0D_NOT_type
  AnormalModeProxy z() const; // 0D_NOT_type
  LinacNormalModeProxy lin() const; // 0D_NOT_type
};

extern "C" {
void* allocate_fortran_em_field_struct();
void deallocate_fortran_em_field_struct(void* ptr) noexcept;
void copy_fortran_em_field_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<EmFieldProxy> {
  static void* allocate() {
    return allocate_fortran_em_field_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_em_field_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_em_field_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "em_field_struct";
  }
};

class EmFieldProxy : public FortranProxy<EmFieldProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> E() const; // 1D_NOT_real
  FortranArray1D<double> B() const; // 1D_NOT_real
  double phi() const; // 0D_NOT_real
  double phi_B() const; // 0D_NOT_real
  FortranArray1D<double> A() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_strong_beam_struct();
void deallocate_fortran_strong_beam_struct(void* ptr) noexcept;
void copy_fortran_strong_beam_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<StrongBeamProxy> {
  static void* allocate() {
    return allocate_fortran_strong_beam_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_strong_beam_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_strong_beam_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "strong_beam_struct";
  }
};

class StrongBeamProxy : public FortranProxy<StrongBeamProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int ix_slice() const; // 0D_NOT_integer
  double x_center() const; // 0D_NOT_real
  double y_center() const; // 0D_NOT_real
  double x_sigma() const; // 0D_NOT_real
  double y_sigma() const; // 0D_NOT_real
  double dx() const; // 0D_NOT_real
  double dy() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_track_point_struct();
void deallocate_fortran_track_point_struct(void* ptr) noexcept;
void copy_fortran_track_point_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TrackPointProxy> {
  static void* allocate() {
    return allocate_fortran_track_point_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_track_point_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_track_point_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "track_point_struct";
  }
};

class TrackPointProxy : public FortranProxy<TrackPointProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double s_lab() const; // 0D_NOT_real
  double s_body() const; // 0D_NOT_real
  CoordProxy orb() const; // 0D_NOT_type
  EmFieldProxy field() const; // 0D_NOT_type
  StrongBeamProxy strong_beam() const; // 0D_NOT_type
  FortranArray1D<double> vec0() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_track_struct();
void deallocate_fortran_track_struct(void* ptr) noexcept;
void copy_fortran_track_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TrackProxy> {
  static void* allocate() {
    return allocate_fortran_track_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_track_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_track_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "track_struct";
  }
};

class TrackProxy : public FortranProxy<TrackProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<TrackPointProxy> pt() const; // 1D_ALLOC_type
  double ds_save() const; // 0D_NOT_real
  int n_pt() const; // 0D_NOT_integer
  int n_bad() const; // 0D_NOT_integer
  int n_ok() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_space_charge_common_struct();
void deallocate_fortran_space_charge_common_struct(void* ptr) noexcept;
void copy_fortran_space_charge_common_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SpaceChargeCommonProxy> {
  static void* allocate() {
    return allocate_fortran_space_charge_common_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_space_charge_common_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_space_charge_common_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "space_charge_common_struct";
  }
};

class SpaceChargeCommonProxy : public FortranProxy<SpaceChargeCommonProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double ds_track_step() const; // 0D_NOT_real
  double dt_track_step() const; // 0D_NOT_real
  double cathode_strength_cutoff() const; // 0D_NOT_real
  double rel_tol_tracking() const; // 0D_NOT_real
  double abs_tol_tracking() const; // 0D_NOT_real
  double beam_chamber_height() const; // 0D_NOT_real
  double lsc_sigma_cutoff() const; // 0D_NOT_real
  double particle_sigma_cutoff() const; // 0D_NOT_real
  FortranArray1D<int> space_charge_mesh_size() const; // 1D_NOT_integer
  FortranArray1D<int> csr3d_mesh_size() const; // 1D_NOT_integer
  int n_bin() const; // 0D_NOT_integer
  int particle_bin_span() const; // 0D_NOT_integer
  int n_shield_images() const; // 0D_NOT_integer
  int sc_min_in_bin() const; // 0D_NOT_integer
  bool lsc_kick_transverse_dependence() const; // 0D_NOT_logical
  bool debug() const; // 0D_NOT_logical
  std::string diagnostic_output_file() const; // 0D_NOT_character
  FortranArray1D<char> get_diagnostic_output_file_chars()
      const; // 0D_NOT_character
};

extern "C" {
void* allocate_fortran_bmad_common_struct();
void deallocate_fortran_bmad_common_struct(void* ptr) noexcept;
void copy_fortran_bmad_common_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BmadCommonProxy> {
  static void* allocate() {
    return allocate_fortran_bmad_common_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bmad_common_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_bmad_common_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "bmad_common_struct";
  }
};

class BmadCommonProxy : public FortranProxy<BmadCommonProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double max_aperture_limit() const; // 0D_NOT_real
  FortranArray1D<double> d_orb() const; // 1D_NOT_real
  double default_ds_step() const; // 0D_NOT_real
  double significant_length() const; // 0D_NOT_real
  double rel_tol_tracking() const; // 0D_NOT_real
  double abs_tol_tracking() const; // 0D_NOT_real
  double rel_tol_adaptive_tracking() const; // 0D_NOT_real
  double abs_tol_adaptive_tracking() const; // 0D_NOT_real
  double init_ds_adaptive_tracking() const; // 0D_NOT_real
  double min_ds_adaptive_tracking() const; // 0D_NOT_real
  double fatal_ds_adaptive_tracking() const; // 0D_NOT_real
  double autoscale_amp_abs_tol() const; // 0D_NOT_real
  double autoscale_amp_rel_tol() const; // 0D_NOT_real
  double autoscale_phase_tol() const; // 0D_NOT_real
  double electric_dipole_moment() const; // 0D_NOT_real
  double synch_rad_scale() const; // 0D_NOT_real
  double sad_eps_scale() const; // 0D_NOT_real
  double sad_amp_max() const; // 0D_NOT_real
  int sad_n_div_max() const; // 0D_NOT_integer
  int taylor_order() const; // 0D_NOT_integer
  int runge_kutta_order() const; // 0D_NOT_integer
  int default_integ_order() const; // 0D_NOT_integer
  int max_num_runge_kutta_step() const; // 0D_NOT_integer
  bool rf_phase_below_transition_ref() const; // 0D_NOT_logical
  bool sr_wakes_on() const; // 0D_NOT_logical
  bool lr_wakes_on() const; // 0D_NOT_logical
  bool auto_bookkeeper() const; // 0D_NOT_logical
  bool high_energy_space_charge_on() const; // 0D_NOT_logical
  bool csr_and_space_charge_on() const; // 0D_NOT_logical
  bool spin_tracking_on() const; // 0D_NOT_logical
  bool spin_sokolov_ternov_flipping_on() const; // 0D_NOT_logical
  bool radiation_damping_on() const; // 0D_NOT_logical
  bool radiation_zero_average() const; // 0D_NOT_logical
  bool radiation_fluctuations_on() const; // 0D_NOT_logical
  bool conserve_taylor_maps() const; // 0D_NOT_logical
  bool absolute_time_tracking() const; // 0D_NOT_logical
  bool absolute_time_ref_shift() const; // 0D_NOT_logical
  bool convert_to_kinetic_momentum() const; // 0D_NOT_logical
  bool normalize_twiss() const; // 0D_NOT_logical
  bool aperture_limit_on() const; // 0D_NOT_logical
  bool spin_n0_direction_user_set() const; // 0D_NOT_logical
  bool debug() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_rad_int1_struct();
void deallocate_fortran_rad_int1_struct(void* ptr) noexcept;
void copy_fortran_rad_int1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<RadInt1Proxy> {
  static void* allocate() {
    return allocate_fortran_rad_int1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_int1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_rad_int1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "rad_int1_struct";
  }
};

class RadInt1Proxy : public FortranProxy<RadInt1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double i0() const; // 0D_NOT_real
  double i1() const; // 0D_NOT_real
  double i2() const; // 0D_NOT_real
  double i3() const; // 0D_NOT_real
  double i4a() const; // 0D_NOT_real
  double i4b() const; // 0D_NOT_real
  double i4z() const; // 0D_NOT_real
  double i5a() const; // 0D_NOT_real
  double i5b() const; // 0D_NOT_real
  double i6b() const; // 0D_NOT_real
  double lin_i2_E4() const; // 0D_NOT_real
  double lin_i3_E7() const; // 0D_NOT_real
  double lin_i5a_E6() const; // 0D_NOT_real
  double lin_i5b_E6() const; // 0D_NOT_real
  double lin_norm_emit_a() const; // 0D_NOT_real
  double lin_norm_emit_b() const; // 0D_NOT_real
  double lin_sig_E() const; // 0D_NOT_real
  double n_steps() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_rad_int_branch_struct();
void deallocate_fortran_rad_int_branch_struct(void* ptr) noexcept;
void copy_fortran_rad_int_branch_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<RadIntBranchProxy> {
  static void* allocate() {
    return allocate_fortran_rad_int_branch_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_int_branch_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_rad_int_branch_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "rad_int_branch_struct";
  }
};

class RadIntBranchProxy : public FortranProxy<RadIntBranchProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<RadInt1Proxy> ele() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_rad_int_all_ele_struct();
void deallocate_fortran_rad_int_all_ele_struct(void* ptr) noexcept;
void copy_fortran_rad_int_all_ele_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<RadIntAllEleProxy> {
  static void* allocate() {
    return allocate_fortran_rad_int_all_ele_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_int_all_ele_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_rad_int_all_ele_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "rad_int_all_ele_struct";
  }
};

class RadIntAllEleProxy : public FortranProxy<RadIntAllEleProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<RadIntBranchProxy> branch() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_rf_stair_step_struct();
void deallocate_fortran_rf_stair_step_struct(void* ptr) noexcept;
void copy_fortran_rf_stair_step_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<RfStairStepProxy> {
  static void* allocate() {
    return allocate_fortran_rf_stair_step_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rf_stair_step_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_rf_stair_step_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "rf_stair_step_struct";
  }
};

class RfStairStepProxy : public FortranProxy<RfStairStepProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double E_tot0() const; // 0D_NOT_real
  double E_tot1() const; // 0D_NOT_real
  double p0c() const; // 0D_NOT_real
  double p1c() const; // 0D_NOT_real
  double dE_amp() const; // 0D_NOT_real
  double scale() const; // 0D_NOT_real
  double time() const; // 0D_NOT_real
  double s() const; // 0D_NOT_real
  int ix_step() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_rf_ele_struct();
void deallocate_fortran_rf_ele_struct(void* ptr) noexcept;
void copy_fortran_rf_ele_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<RfEleProxy> {
  static void* allocate() {
    return allocate_fortran_rf_ele_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rf_ele_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_rf_ele_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "rf_ele_struct";
  }
};

class RfEleProxy : public FortranProxy<RfEleProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<RfStairStepProxy> steps() const; // 1D_ALLOC_type
  double ds_step() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_ele_struct();
void deallocate_fortran_ele_struct(void* ptr) noexcept;
void copy_fortran_ele_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<EleProxy> {
  static void* allocate() {
    return allocate_fortran_ele_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ele_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_ele_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "ele_struct";
  }
};

class EleProxy : public FortranProxy<EleProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  std::string type() const; // 0D_NOT_character
  FortranArray1D<char> get_type_chars() const; // 0D_NOT_character
  std::string alias() const; // 0D_NOT_character
  FortranArray1D<char> get_alias_chars() const; // 0D_NOT_character
  std::string component_name() const; // 0D_NOT_character
  FortranArray1D<char> get_component_name_chars() const; // 0D_NOT_character
  std::string descrip() const; // 0D_PTR_character
  FortranArray1D<char> get_descrip_chars() const; // 0D_PTR_character
  TwissProxy a() const; // 0D_NOT_type
  TwissProxy b() const; // 0D_NOT_type
  TwissProxy z() const; // 0D_NOT_type
  XyDispProxy x() const; // 0D_NOT_type
  XyDispProxy y() const; // 0D_NOT_type
  const void* ac_kick() const; // 0D_PTR_type
  BookkeepingStateProxy bookkeeping_state() const; // 0D_NOT_type
  const void* branch() const; // 0D_PTR_type
  const void* control() const; // 0D_PTR_type
  const void* rf() const; // 0D_PTR_type
  const void* lord() const; // 0D_PTR_type
  FloorPositionProxy floor() const; // 0D_NOT_type
  const void* high_energy_space_charge() const; // 0D_PTR_type
  const void* mode3() const; // 0D_PTR_type
  const void* photon() const; // 0D_PTR_type
  const void* rad_map() const; // 0D_PTR_type
  FortranTypeArray1D<TaylorProxy> taylor() const; // 1D_NOT_type
  FortranArray1D<double> spin_taylor_ref_orb_in() const; // 1D_NOT_real
  FortranTypeArray1D<TaylorProxy> spin_taylor() const; // 1D_NOT_type
  const void* wake() const; // 0D_PTR_type
  FortranTypeArray1D<Wall3dProxy> wall3d() const; // 1D_PTR_type
  FortranTypeArray1D<CartesianMapProxy> cartesian_map() const; // 1D_PTR_type
  FortranTypeArray1D<CylindricalMapProxy> cylindrical_map()
      const; // 1D_PTR_type
  FortranTypeArray1D<GenGradMapProxy> gen_grad_map() const; // 1D_PTR_type
  FortranTypeArray1D<GridFieldProxy> grid_field() const; // 1D_PTR_type
  CoordProxy map_ref_orb_in() const; // 0D_NOT_type
  CoordProxy map_ref_orb_out() const; // 0D_NOT_type
  CoordProxy time_ref_orb_in() const; // 0D_NOT_type
  CoordProxy time_ref_orb_out() const; // 0D_NOT_type
  FortranArray1D<double> value() const; // 1D_NOT_real
  FortranArray1D<double> old_value() const; // 1D_NOT_real
  FortranArray1D<double> vec0() const; // 1D_NOT_real
  double gamma_c() const; // 0D_NOT_real
  double s_start() const; // 0D_NOT_real
  double s() const; // 0D_NOT_real
  double ref_time() const; // 0D_NOT_real
  int key() const; // 0D_NOT_integer
  int sub_key() const; // 0D_NOT_integer
  int ix_ele() const; // 0D_NOT_integer
  int ix_branch() const; // 0D_NOT_integer
  int lord_status() const; // 0D_NOT_integer
  int n_slave() const; // 0D_NOT_integer
  int n_slave_field() const; // 0D_NOT_integer
  int ix1_slave() const; // 0D_NOT_integer
  int slave_status() const; // 0D_NOT_integer
  int n_lord() const; // 0D_NOT_integer
  int n_lord_field() const; // 0D_NOT_integer
  int n_lord_ramper() const; // 0D_NOT_integer
  int ic1_lord() const; // 0D_NOT_integer
  int ix_pointer() const; // 0D_NOT_integer
  int ixx() const; // 0D_NOT_integer
  int iyy() const; // 0D_NOT_integer
  int izz() const; // 0D_NOT_integer
  int mat6_calc_method() const; // 0D_NOT_integer
  int tracking_method() const; // 0D_NOT_integer
  int spin_tracking_method() const; // 0D_NOT_integer
  int csr_method() const; // 0D_NOT_integer
  int space_charge_method() const; // 0D_NOT_integer
  int ptc_integration_type() const; // 0D_NOT_integer
  int field_calc() const; // 0D_NOT_integer
  int aperture_at() const; // 0D_NOT_integer
  int aperture_type() const; // 0D_NOT_integer
  int ref_species() const; // 0D_NOT_integer
  int orientation() const; // 0D_NOT_integer
  bool symplectify() const; // 0D_NOT_logical
  bool mode_flip() const; // 0D_NOT_logical
  bool multipoles_on() const; // 0D_NOT_logical
  bool scale_multipoles() const; // 0D_NOT_logical
  bool taylor_map_includes_offsets() const; // 0D_NOT_logical
  bool field_master() const; // 0D_NOT_logical
  bool is_on() const; // 0D_NOT_logical
  bool logic() const; // 0D_NOT_logical
  bool bmad_logic() const; // 0D_NOT_logical
  bool select() const; // 0D_NOT_logical
  bool offset_moves_aperture() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_complex_taylor_term_struct();
void deallocate_fortran_complex_taylor_term_struct(void* ptr) noexcept;
void copy_fortran_complex_taylor_term_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ComplexTaylorTermProxy> {
  static void* allocate() {
    return allocate_fortran_complex_taylor_term_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_complex_taylor_term_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_complex_taylor_term_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "complex_taylor_term_struct";
  }
};

class ComplexTaylorTermProxy : public FortranProxy<ComplexTaylorTermProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::complex<double> coef() const; // 0D_NOT_complex
  FortranArray1D<int> expn() const; // 1D_NOT_integer
};

extern "C" {
void* allocate_fortran_complex_taylor_struct();
void deallocate_fortran_complex_taylor_struct(void* ptr) noexcept;
void copy_fortran_complex_taylor_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ComplexTaylorProxy> {
  static void* allocate() {
    return allocate_fortran_complex_taylor_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_complex_taylor_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_complex_taylor_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "complex_taylor_struct";
  }
};

class ComplexTaylorProxy : public FortranProxy<ComplexTaylorProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::complex<double> ref() const; // 0D_NOT_complex
  FortranTypeArray1D<ComplexTaylorTermProxy> term() const; // 1D_PTR_type
};

extern "C" {
void* allocate_fortran_branch_struct();
void deallocate_fortran_branch_struct(void* ptr) noexcept;
void copy_fortran_branch_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BranchProxy> {
  static void* allocate() {
    return allocate_fortran_branch_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_branch_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_branch_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "branch_struct";
  }
};

class BranchProxy : public FortranProxy<BranchProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  int ix_branch() const; // 0D_NOT_integer
  int ix_from_branch() const; // 0D_NOT_integer
  int ix_from_ele() const; // 0D_NOT_integer
  int ix_to_ele() const; // 0D_NOT_integer
  int ix_fixer() const; // 0D_NOT_integer
  int n_ele_track() const; // 0D_NOT_integer
  int n_ele_max() const; // 0D_NOT_integer
  const void* lat() const; // 0D_PTR_type
  ModeInfoProxy a() const; // 0D_NOT_type
  ModeInfoProxy b() const; // 0D_NOT_type
  ModeInfoProxy z() const; // 0D_NOT_type
  FortranTypeArray1D<EleProxy> ele() const; // 1D_PTR_type
  LatParamProxy param() const; // 0D_NOT_type
  CoordProxy particle_start() const; // 0D_NOT_type
  FortranTypeArray1D<Wall3dProxy> wall3d() const; // 1D_PTR_type
};

extern "C" {
void* allocate_fortran_lat_struct();
void deallocate_fortran_lat_struct(void* ptr) noexcept;
void copy_fortran_lat_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<LatProxy> {
  static void* allocate() {
    return allocate_fortran_lat_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_lat_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "lat_struct";
  }
};

class LatProxy : public FortranProxy<LatProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string use_name() const; // 0D_NOT_character
  FortranArray1D<char> get_use_name_chars() const; // 0D_NOT_character
  std::string lattice() const; // 0D_NOT_character
  FortranArray1D<char> get_lattice_chars() const; // 0D_NOT_character
  std::string machine() const; // 0D_NOT_character
  FortranArray1D<char> get_machine_chars() const; // 0D_NOT_character
  std::string input_file_name() const; // 0D_NOT_character
  FortranArray1D<char> get_input_file_name_chars() const; // 0D_NOT_character
  std::string title() const; // 0D_NOT_character
  FortranArray1D<char> get_title_chars() const; // 0D_NOT_character
  FortranTypeArray1D<ExpressionAtomProxy> constant() const; // 1D_ALLOC_type
  const void* a() const; // 0D_PTR_type
  const void* b() const; // 0D_PTR_type
  const void* z() const; // 0D_PTR_type
  const void* param() const; // 0D_PTR_type
  BookkeepingStateProxy lord_state() const; // 0D_NOT_type
  EleProxy ele_init() const; // 0D_NOT_type
  FortranTypeArray1D<BranchProxy> branch() const; // 1D_ALLOC_type
  FortranTypeArray1D<ControlProxy> control() const; // 1D_ALLOC_type
  const void* particle_start() const; // 0D_PTR_type
  BeamInitProxy beam_init() const; // 0D_NOT_type
  PreTrackerProxy pre_tracker() const; // 0D_NOT_type
  FortranArray1D<double> custom() const; // 1D_ALLOC_real
  int version() const; // 0D_NOT_integer
  int* n_ele_track() const; // 0D_PTR_integer
  int* n_ele_max() const; // 0D_PTR_integer
  int n_control_max() const; // 0D_NOT_integer
  int n_ic_max() const; // 0D_NOT_integer
  int input_taylor_order() const; // 0D_NOT_integer
  FortranArray1D<int> ic() const; // 1D_ALLOC_integer
  int photon_type() const; // 0D_NOT_integer
  int creation_hash() const; // 0D_NOT_integer
  int ramper_slave_bookkeeping() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_bunch_struct();
void deallocate_fortran_bunch_struct(void* ptr) noexcept;
void copy_fortran_bunch_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BunchProxy> {
  static void* allocate() {
    return allocate_fortran_bunch_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bunch_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_bunch_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "bunch_struct";
  }
};

class BunchProxy : public FortranProxy<BunchProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<CoordProxy> particle() const; // 1D_ALLOC_type
  FortranArray1D<int> ix_z() const; // 1D_ALLOC_integer
  double charge_tot() const; // 0D_NOT_real
  double charge_live() const; // 0D_NOT_real
  double z_center() const; // 0D_NOT_real
  double t_center() const; // 0D_NOT_real
  double t0() const; // 0D_NOT_real
  bool drift_between_t_and_s() const; // 0D_NOT_logical
  int ix_ele() const; // 0D_NOT_integer
  int ix_bunch() const; // 0D_NOT_integer
  int ix_turn() const; // 0D_NOT_integer
  int n_live() const; // 0D_NOT_integer
  int n_good() const; // 0D_NOT_integer
  int n_bad() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_bunch_params_struct();
void deallocate_fortran_bunch_params_struct(void* ptr) noexcept;
void copy_fortran_bunch_params_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BunchParamsProxy> {
  static void* allocate() {
    return allocate_fortran_bunch_params_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bunch_params_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_bunch_params_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "bunch_params_struct";
  }
};

class BunchParamsProxy : public FortranProxy<BunchParamsProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  CoordProxy centroid() const; // 0D_NOT_type
  TwissProxy x() const; // 0D_NOT_type
  TwissProxy y() const; // 0D_NOT_type
  TwissProxy z() const; // 0D_NOT_type
  TwissProxy a() const; // 0D_NOT_type
  TwissProxy b() const; // 0D_NOT_type
  TwissProxy c() const; // 0D_NOT_type
  FortranArray1D<double> rel_max() const; // 1D_NOT_real
  FortranArray1D<double> rel_min() const; // 1D_NOT_real
  double s() const; // 0D_NOT_real
  double t() const; // 0D_NOT_real
  double sigma_t() const; // 0D_NOT_real
  double charge_live() const; // 0D_NOT_real
  double charge_tot() const; // 0D_NOT_real
  int n_particle_tot() const; // 0D_NOT_integer
  int n_particle_live() const; // 0D_NOT_integer
  int n_particle_lost_in_ele() const; // 0D_NOT_integer
  int n_good_steps() const; // 0D_NOT_integer
  int n_bad_steps() const; // 0D_NOT_integer
  int ix_ele() const; // 0D_NOT_integer
  int location() const; // 0D_NOT_integer
  bool twiss_valid() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_beam_struct();
void deallocate_fortran_beam_struct(void* ptr) noexcept;
void copy_fortran_beam_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BeamProxy> {
  static void* allocate() {
    return allocate_fortran_beam_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_beam_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_beam_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "beam_struct";
  }
};

class BeamProxy : public FortranProxy<BeamProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<BunchProxy> bunch() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_aperture_point_struct();
void deallocate_fortran_aperture_point_struct(void* ptr) noexcept;
void copy_fortran_aperture_point_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<AperturePointProxy> {
  static void* allocate() {
    return allocate_fortran_aperture_point_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_aperture_point_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_aperture_point_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "aperture_point_struct";
  }
};

class AperturePointProxy : public FortranProxy<AperturePointProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double x() const; // 0D_NOT_real
  double y() const; // 0D_NOT_real
  int plane() const; // 0D_NOT_integer
  int ix_ele() const; // 0D_NOT_integer
  int i_turn() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_aperture_param_struct();
void deallocate_fortran_aperture_param_struct(void* ptr) noexcept;
void copy_fortran_aperture_param_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ApertureParamProxy> {
  static void* allocate() {
    return allocate_fortran_aperture_param_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_aperture_param_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_aperture_param_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "aperture_param_struct";
  }
};

class ApertureParamProxy : public FortranProxy<ApertureParamProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double min_angle() const; // 0D_NOT_real
  double max_angle() const; // 0D_NOT_real
  int n_angle() const; // 0D_NOT_integer
  int n_turn() const; // 0D_NOT_integer
  double x_init() const; // 0D_NOT_real
  double y_init() const; // 0D_NOT_real
  double rel_accuracy() const; // 0D_NOT_real
  double abs_accuracy() const; // 0D_NOT_real
  std::string start_ele() const; // 0D_NOT_character
  FortranArray1D<char> get_start_ele_chars() const; // 0D_NOT_character
};

extern "C" {
void* allocate_fortran_aperture_scan_struct();
void deallocate_fortran_aperture_scan_struct(void* ptr) noexcept;
void copy_fortran_aperture_scan_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ApertureScanProxy> {
  static void* allocate() {
    return allocate_fortran_aperture_scan_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_aperture_scan_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_aperture_scan_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "aperture_scan_struct";
  }
};

class ApertureScanProxy : public FortranProxy<ApertureScanProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<AperturePointProxy> point() const; // 1D_ALLOC_type
  CoordProxy ref_orb() const; // 0D_NOT_type
  double pz_start() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_tao_spin_dn_dpz_struct();
void deallocate_fortran_tao_spin_dn_dpz_struct(void* ptr) noexcept;
void copy_fortran_tao_spin_dn_dpz_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoSpinDnDpzProxy> {
  static void* allocate() {
    return allocate_fortran_tao_spin_dn_dpz_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_spin_dn_dpz_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_spin_dn_dpz_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_spin_dn_dpz_struct";
  }
};

class TaoSpinDnDpzProxy : public FortranProxy<TaoSpinDnDpzProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> vec() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_resonance_h_struct();
void deallocate_fortran_resonance_h_struct(void* ptr) noexcept;
void copy_fortran_resonance_h_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<ResonanceHProxy> {
  static void* allocate() {
    return allocate_fortran_resonance_h_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_resonance_h_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_resonance_h_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "resonance_h_struct";
  }
};

class ResonanceHProxy : public FortranProxy<ResonanceHProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string id() const; // 0D_NOT_character
  FortranArray1D<char> get_id_chars() const; // 0D_NOT_character
  std::complex<double> c_val() const; // 0D_NOT_complex
};

extern "C" {
void* allocate_fortran_spin_orbit_map1_struct();
void deallocate_fortran_spin_orbit_map1_struct(void* ptr) noexcept;
void copy_fortran_spin_orbit_map1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SpinOrbitMap1Proxy> {
  static void* allocate() {
    return allocate_fortran_spin_orbit_map1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_spin_orbit_map1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_spin_orbit_map1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "spin_orbit_map1_struct";
  }
};

class SpinOrbitMap1Proxy : public FortranProxy<SpinOrbitMap1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> vec0() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_spin_axis_struct();
void deallocate_fortran_spin_axis_struct(void* ptr) noexcept;
void copy_fortran_spin_axis_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SpinAxisProxy> {
  static void* allocate() {
    return allocate_fortran_spin_axis_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_spin_axis_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_spin_axis_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "spin_axis_struct";
  }
};

class SpinAxisProxy : public FortranProxy<SpinAxisProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranArray1D<double> l() const; // 1D_NOT_real
  FortranArray1D<double> n0() const; // 1D_NOT_real
  FortranArray1D<double> m() const; // 1D_NOT_real
};

extern "C" {
void* allocate_fortran_ptc_normal_form_struct();
void deallocate_fortran_ptc_normal_form_struct(void* ptr) noexcept;
void copy_fortran_ptc_normal_form_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<PtcNormalFormProxy> {
  static void* allocate() {
    return allocate_fortran_ptc_normal_form_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ptc_normal_form_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_ptc_normal_form_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "ptc_normal_form_struct";
  }
};

class PtcNormalFormProxy : public FortranProxy<PtcNormalFormProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  const void* ele_origin() const; // 0D_PTR_type
  FortranArray1D<double> orb0() const; // 1D_NOT_real
  bool valid_map() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_bmad_normal_form_struct();
void deallocate_fortran_bmad_normal_form_struct(void* ptr) noexcept;
void copy_fortran_bmad_normal_form_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BmadNormalFormProxy> {
  static void* allocate() {
    return allocate_fortran_bmad_normal_form_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bmad_normal_form_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_bmad_normal_form_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "bmad_normal_form_struct";
  }
};

class BmadNormalFormProxy : public FortranProxy<BmadNormalFormProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  const void* ele_origin() const; // 0D_PTR_type
  FortranTypeArray1D<TaylorProxy> M() const; // 1D_NOT_type
  FortranTypeArray1D<TaylorProxy> A() const; // 1D_NOT_type
  FortranTypeArray1D<TaylorProxy> A_inv() const; // 1D_NOT_type
  FortranTypeArray1D<TaylorProxy> dhdj() const; // 1D_NOT_type
  FortranTypeArray1D<ComplexTaylorProxy> F() const; // 1D_NOT_type
  FortranTypeArray1D<ComplexTaylorProxy> L() const; // 1D_NOT_type
  FortranTypeArray1D<ResonanceHProxy> h() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_bunch_track_struct();
void deallocate_fortran_bunch_track_struct(void* ptr) noexcept;
void copy_fortran_bunch_track_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<BunchTrackProxy> {
  static void* allocate() {
    return allocate_fortran_bunch_track_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bunch_track_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_bunch_track_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "bunch_track_struct";
  }
};

class BunchTrackProxy : public FortranProxy<BunchTrackProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<BunchParamsProxy> pt() const; // 1D_ALLOC_type
  double ds_save() const; // 0D_NOT_real
  int n_pt() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_summation_rdt_struct();
void deallocate_fortran_summation_rdt_struct(void* ptr) noexcept;
void copy_fortran_summation_rdt_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<SummationRdtProxy> {
  static void* allocate() {
    return allocate_fortran_summation_rdt_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_summation_rdt_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_summation_rdt_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "summation_rdt_struct";
  }
};

class SummationRdtProxy : public FortranProxy<SummationRdtProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::complex<double> h11001() const; // 0D_NOT_complex
  std::complex<double> h00111() const; // 0D_NOT_complex
  std::complex<double> h20001() const; // 0D_NOT_complex
  std::complex<double> h00201() const; // 0D_NOT_complex
  std::complex<double> h10002() const; // 0D_NOT_complex
  std::complex<double> h21000() const; // 0D_NOT_complex
  std::complex<double> h30000() const; // 0D_NOT_complex
  std::complex<double> h10110() const; // 0D_NOT_complex
  std::complex<double> h10020() const; // 0D_NOT_complex
  std::complex<double> h10200() const; // 0D_NOT_complex
  std::complex<double> h31000() const; // 0D_NOT_complex
  std::complex<double> h40000() const; // 0D_NOT_complex
  std::complex<double> h20110() const; // 0D_NOT_complex
  std::complex<double> h11200() const; // 0D_NOT_complex
  std::complex<double> h20020() const; // 0D_NOT_complex
  std::complex<double> h20200() const; // 0D_NOT_complex
  std::complex<double> h00310() const; // 0D_NOT_complex
  std::complex<double> h00400() const; // 0D_NOT_complex
  std::complex<double> h22000() const; // 0D_NOT_complex
  std::complex<double> h00220() const; // 0D_NOT_complex
  std::complex<double> h11110() const; // 0D_NOT_complex
};

extern "C" {
void* allocate_fortran_lat_ele_order1_struct();
void deallocate_fortran_lat_ele_order1_struct(void* ptr) noexcept;
void copy_fortran_lat_ele_order1_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<LatEleOrder1Proxy> {
  static void* allocate() {
    return allocate_fortran_lat_ele_order1_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_ele_order1_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_lat_ele_order1_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "lat_ele_order1_struct";
  }
};

class LatEleOrder1Proxy : public FortranProxy<LatEleOrder1Proxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int ix_branch() const; // 0D_NOT_integer
  int ix_order() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_lat_ele_order_array_struct();
void deallocate_fortran_lat_ele_order_array_struct(void* ptr) noexcept;
void copy_fortran_lat_ele_order_array_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<LatEleOrderArrayProxy> {
  static void* allocate() {
    return allocate_fortran_lat_ele_order_array_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_ele_order_array_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_lat_ele_order_array_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "lat_ele_order_array_struct";
  }
};

class LatEleOrderArrayProxy : public FortranProxy<LatEleOrderArrayProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<LatEleOrder1Proxy> ele() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_tao_lat_sigma_struct();
void deallocate_fortran_tao_lat_sigma_struct(void* ptr) noexcept;
void copy_fortran_tao_lat_sigma_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoLatSigmaProxy> {
  static void* allocate() {
    return allocate_fortran_tao_lat_sigma_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_lat_sigma_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_lat_sigma_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_lat_sigma_struct";
  }
};

class TaoLatSigmaProxy : public FortranProxy<TaoLatSigmaProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;
};

extern "C" {
void* allocate_fortran_tao_spin_ele_struct();
void deallocate_fortran_tao_spin_ele_struct(void* ptr) noexcept;
void copy_fortran_tao_spin_ele_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoSpinEleProxy> {
  static void* allocate() {
    return allocate_fortran_tao_spin_ele_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_spin_ele_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_spin_ele_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_spin_ele_struct";
  }
};

class TaoSpinEleProxy : public FortranProxy<TaoSpinEleProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  TaoSpinDnDpzProxy dn_dpz() const; // 0D_NOT_type
  FortranArray1D<double> orb_eigen_val() const; // 1D_NOT_real
  bool valid() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_tao_plot_cache_struct();
void deallocate_fortran_tao_plot_cache_struct(void* ptr) noexcept;
void copy_fortran_tao_plot_cache_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoPlotCacheProxy> {
  static void* allocate() {
    return allocate_fortran_tao_plot_cache_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_plot_cache_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_plot_cache_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_plot_cache_struct";
  }
};

class TaoPlotCacheProxy : public FortranProxy<TaoPlotCacheProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  EleProxy ele_to_s() const; // 0D_NOT_type
  CoordProxy orbit() const; // 0D_NOT_type
  bool err() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_tao_spin_polarization_struct();
void deallocate_fortran_tao_spin_polarization_struct(void* ptr) noexcept;
void copy_fortran_tao_spin_polarization_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoSpinPolarizationProxy> {
  static void* allocate() {
    return allocate_fortran_tao_spin_polarization_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_spin_polarization_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_spin_polarization_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_spin_polarization_struct";
  }
};

class TaoSpinPolarizationProxy : public FortranProxy<TaoSpinPolarizationProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double tune() const; // 0D_NOT_real
  double pol_limit_st() const; // 0D_NOT_real
  double pol_limit_dk() const; // 0D_NOT_real
  FortranArray1D<double> pol_limit_dk_partial() const; // 1D_NOT_real
  FortranArray1D<double> pol_limit_dk_partial2() const; // 1D_NOT_real
  double pol_rate_bks() const; // 0D_NOT_real
  double depol_rate() const; // 0D_NOT_real
  FortranArray1D<double> depol_rate_partial() const; // 1D_NOT_real
  FortranArray1D<double> depol_rate_partial2() const; // 1D_NOT_real
  double integral_bn() const; // 0D_NOT_real
  double integral_bdn() const; // 0D_NOT_real
  double integral_1ns() const; // 0D_NOT_real
  double integral_dn2() const; // 0D_NOT_real
  bool valid() const; // 0D_NOT_logical
  SpinOrbitMap1Proxy q_1turn() const; // 0D_NOT_type
  FortranTypeArray1D<SpinOrbitMap1Proxy> q_ele() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_tao_lattice_branch_struct();
void deallocate_fortran_tao_lattice_branch_struct(void* ptr) noexcept;
void copy_fortran_tao_lattice_branch_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoLatticeBranchProxy> {
  static void* allocate() {
    return allocate_fortran_tao_lattice_branch_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_lattice_branch_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_lattice_branch_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_lattice_branch_struct";
  }
};

class TaoLatticeBranchProxy : public FortranProxy<TaoLatticeBranchProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<TaoLatSigmaProxy> lat_sigma() const; // 1D_ALLOC_type
  FortranTypeArray1D<TaoSpinEleProxy> spin_ele() const; // 1D_ALLOC_type
  FortranTypeArray1D<BunchParamsProxy> bunch_params() const; // 1D_ALLOC_type
  FortranTypeArray1D<BunchTrackProxy> bunch_params_comb()
      const; // 1D_ALLOC_type
  FortranTypeArray1D<CoordProxy> orbit() const; // 1D_ALLOC_type
  FortranTypeArray1D<TaoPlotCacheProxy> plot_cache() const; // 1D_ALLOC_type
  TaoSpinPolarizationProxy spin() const; // 0D_NOT_type
  SummationRdtProxy srdt() const; // 0D_NOT_type
  CoordProxy orb0() const; // 0D_NOT_type
  NormalModesProxy modes_ri() const; // 0D_NOT_type
  NormalModesProxy modes_6d() const; // 0D_NOT_type
  PtcNormalFormProxy ptc_normal_form() const; // 0D_NOT_type
  BmadNormalFormProxy bmad_normal_form() const; // 0D_NOT_type
  FortranTypeArray1D<CoordProxy> high_E_orb() const; // 1D_ALLOC_type
  FortranTypeArray1D<CoordProxy> low_E_orb() const; // 1D_ALLOC_type
  double cache_x_min() const; // 0D_NOT_real
  double cache_x_max() const; // 0D_NOT_real
  double comb_ds_save() const; // 0D_NOT_real
  int track_state() const; // 0D_NOT_integer
  int cache_n_pts() const; // 0D_NOT_integer
  int ix_rad_int_cache() const; // 0D_NOT_integer
  bool has_open_match_element() const; // 0D_NOT_logical
  bool plot_cache_valid() const; // 0D_NOT_logical
  bool spin_map_valid() const; // 0D_NOT_logical
  bool twiss_valid() const; // 0D_NOT_logical
  bool mode_flip_here() const; // 0D_NOT_logical
  bool chrom_calc_ok() const; // 0D_NOT_logical
  bool rad_int_calc_ok() const; // 0D_NOT_logical
  bool emit_6d_calc_ok() const; // 0D_NOT_logical
  bool sigma_track_ok() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_tao_model_element_struct();
void deallocate_fortran_tao_model_element_struct(void* ptr) noexcept;
void copy_fortran_tao_model_element_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoModelElementProxy> {
  static void* allocate() {
    return allocate_fortran_tao_model_element_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_model_element_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_model_element_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_model_element_struct";
  }
};

class TaoModelElementProxy : public FortranProxy<TaoModelElementProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  BeamProxy beam() const; // 0D_NOT_type
  bool save_beam_internally() const; // 0D_NOT_logical
  bool save_beam_to_file() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_tao_beam_branch_struct();
void deallocate_fortran_tao_beam_branch_struct(void* ptr) noexcept;
void copy_fortran_tao_beam_branch_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoBeamBranchProxy> {
  static void* allocate() {
    return allocate_fortran_tao_beam_branch_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_beam_branch_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_beam_branch_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_beam_branch_struct";
  }
};

class TaoBeamBranchProxy : public FortranProxy<TaoBeamBranchProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  BeamProxy beam_at_start() const; // 0D_NOT_type
  BeamInitProxy beam_init() const; // 0D_NOT_type
  BeamInitProxy beam_init_used() const; // 0D_NOT_type
  bool init_starting_distribution() const; // 0D_NOT_logical
  std::string track_start() const; // 0D_NOT_character
  FortranArray1D<char> get_track_start_chars() const; // 0D_NOT_character
  std::string track_end() const; // 0D_NOT_character
  FortranArray1D<char> get_track_end_chars() const; // 0D_NOT_character
  int ix_branch() const; // 0D_NOT_integer
  int ix_track_start() const; // 0D_NOT_integer
  int ix_track_end() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_tao_d1_data_struct();
void deallocate_fortran_tao_d1_data_struct(void* ptr) noexcept;
void copy_fortran_tao_d1_data_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoD1DataProxy> {
  static void* allocate() {
    return allocate_fortran_tao_d1_data_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_d1_data_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_d1_data_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_d1_data_struct";
  }
};

class TaoD1DataProxy : public FortranProxy<TaoD1DataProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
};

extern "C" {
void* allocate_fortran_tao_lattice_struct();
void deallocate_fortran_tao_lattice_struct(void* ptr) noexcept;
void copy_fortran_tao_lattice_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoLatticeProxy> {
  static void* allocate() {
    return allocate_fortran_tao_lattice_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_lattice_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_lattice_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_lattice_struct";
  }
};

class TaoLatticeProxy : public FortranProxy<TaoLatticeProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  LatProxy lat() const; // 0D_NOT_type
  LatProxy high_E_lat() const; // 0D_NOT_type
  LatProxy low_E_lat() const; // 0D_NOT_type
  RadIntAllEleProxy rad_int_by_ele_ri() const; // 0D_NOT_type
  RadIntAllEleProxy rad_int_by_ele_6d() const; // 0D_NOT_type
  FortranTypeArray1D<TaoLatticeBranchProxy> tao_branch() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_tao_beam_uni_struct();
void deallocate_fortran_tao_beam_uni_struct(void* ptr) noexcept;
void copy_fortran_tao_beam_uni_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoBeamUniProxy> {
  static void* allocate() {
    return allocate_fortran_tao_beam_uni_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_beam_uni_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_beam_uni_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_beam_uni_struct";
  }
};

class TaoBeamUniProxy : public FortranProxy<TaoBeamUniProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string saved_at() const; // 0D_NOT_character
  FortranArray1D<char> get_saved_at_chars() const; // 0D_NOT_character
  std::string dump_file() const; // 0D_NOT_character
  FortranArray1D<char> get_dump_file_chars() const; // 0D_NOT_character
  std::string dump_at() const; // 0D_NOT_character
  FortranArray1D<char> get_dump_at_chars() const; // 0D_NOT_character
  bool track_beam_in_universe() const; // 0D_NOT_logical
  bool always_reinit() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_tao_dynamic_aperture_struct();
void deallocate_fortran_tao_dynamic_aperture_struct(void* ptr) noexcept;
void copy_fortran_tao_dynamic_aperture_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoDynamicApertureProxy> {
  static void* allocate() {
    return allocate_fortran_tao_dynamic_aperture_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_dynamic_aperture_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_dynamic_aperture_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_dynamic_aperture_struct";
  }
};

class TaoDynamicApertureProxy : public FortranProxy<TaoDynamicApertureProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  ApertureParamProxy param() const; // 0D_NOT_type
  FortranTypeArray1D<ApertureScanProxy> scan() const; // 1D_ALLOC_type
  FortranArray1D<double> pz() const; // 1D_ALLOC_real
  double ellipse_scale() const; // 0D_NOT_real
  double a_emit() const; // 0D_NOT_real
  double b_emit() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_tao_model_branch_struct();
void deallocate_fortran_tao_model_branch_struct(void* ptr) noexcept;
void copy_fortran_tao_model_branch_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoModelBranchProxy> {
  static void* allocate() {
    return allocate_fortran_tao_model_branch_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_model_branch_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_model_branch_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_model_branch_struct";
  }
};

class TaoModelBranchProxy : public FortranProxy<TaoModelBranchProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<TaoModelElementProxy> ele() const; // 1D_ALLOC_type
  TaoBeamBranchProxy beam() const; // 0D_NOT_type
};

extern "C" {
void* allocate_fortran_tao_d2_data_struct();
void deallocate_fortran_tao_d2_data_struct(void* ptr) noexcept;
void copy_fortran_tao_d2_data_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoD2DataProxy> {
  static void* allocate() {
    return allocate_fortran_tao_d2_data_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_d2_data_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_d2_data_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_d2_data_struct";
  }
};

class TaoD2DataProxy : public FortranProxy<TaoD2DataProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string name() const; // 0D_NOT_character
  FortranArray1D<char> get_name_chars() const; // 0D_NOT_character
  std::string data_file_name() const; // 0D_NOT_character
  FortranArray1D<char> get_data_file_name_chars() const; // 0D_NOT_character
  std::string ref_file_name() const; // 0D_NOT_character
  FortranArray1D<char> get_ref_file_name_chars() const; // 0D_NOT_character
  std::string data_date() const; // 0D_NOT_character
  FortranArray1D<char> get_data_date_chars() const; // 0D_NOT_character
  std::string ref_date() const; // 0D_NOT_character
  FortranArray1D<char> get_ref_date_chars() const; // 0D_NOT_character
  FortranTypeArray1D<TaoD1DataProxy> d1() const; // 1D_ALLOC_type
  int ix_universe() const; // 0D_NOT_integer
  int ix_d2_data() const; // 0D_NOT_integer
  int ix_ref() const; // 0D_NOT_integer
  bool data_read_in() const; // 0D_NOT_logical
  bool ref_read_in() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_tao_spin_map_struct();
void deallocate_fortran_tao_spin_map_struct(void* ptr) noexcept;
void copy_fortran_tao_spin_map_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoSpinMapProxy> {
  static void* allocate() {
    return allocate_fortran_tao_spin_map_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_spin_map_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_spin_map_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_spin_map_struct";
  }
};

class TaoSpinMapProxy : public FortranProxy<TaoSpinMapProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  bool valid() const; // 0D_NOT_logical
  SpinOrbitMap1Proxy map1() const; // 0D_NOT_type
  SpinAxisProxy axis_input() const; // 0D_NOT_type
  SpinAxisProxy axis0() const; // 0D_NOT_type
  SpinAxisProxy axis1() const; // 0D_NOT_type
  int ix_ele() const; // 0D_NOT_integer
  int ix_ref() const; // 0D_NOT_integer
  int ix_uni() const; // 0D_NOT_integer
  int ix_branch() const; // 0D_NOT_integer
};

extern "C" {
void* allocate_fortran_tao_data_struct();
void deallocate_fortran_tao_data_struct(void* ptr) noexcept;
void copy_fortran_tao_data_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoDataProxy> {
  static void* allocate() {
    return allocate_fortran_tao_data_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_data_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_data_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_data_struct";
  }
};

class TaoDataProxy : public FortranProxy<TaoDataProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  std::string ele_name() const; // 0D_NOT_character
  FortranArray1D<char> get_ele_name_chars() const; // 0D_NOT_character
  std::string ele_start_name() const; // 0D_NOT_character
  FortranArray1D<char> get_ele_start_name_chars() const; // 0D_NOT_character
  std::string ele_ref_name() const; // 0D_NOT_character
  FortranArray1D<char> get_ele_ref_name_chars() const; // 0D_NOT_character
  std::string merit_type() const; // 0D_NOT_character
  FortranArray1D<char> get_merit_type_chars() const; // 0D_NOT_character
  std::string id() const; // 0D_NOT_character
  FortranArray1D<char> get_id_chars() const; // 0D_NOT_character
  std::string data_source() const; // 0D_NOT_character
  FortranArray1D<char> get_data_source_chars() const; // 0D_NOT_character
  std::string why_invalid() const; // 0D_NOT_character
  FortranArray1D<char> get_why_invalid_chars() const; // 0D_NOT_character
  int ix_uni() const; // 0D_NOT_integer
  int ix_bunch() const; // 0D_NOT_integer
  int ix_branch() const; // 0D_NOT_integer
  int ix_ele() const; // 0D_NOT_integer
  int ix_ele_start() const; // 0D_NOT_integer
  int ix_ele_ref() const; // 0D_NOT_integer
  int ix_ele_merit() const; // 0D_NOT_integer
  int ix_d1() const; // 0D_NOT_integer
  int ix_data() const; // 0D_NOT_integer
  int ix_dModel() const; // 0D_NOT_integer
  int eval_point() const; // 0D_NOT_integer
  double meas_value() const; // 0D_NOT_real
  double ref_value() const; // 0D_NOT_real
  double model_value() const; // 0D_NOT_real
  double design_value() const; // 0D_NOT_real
  double old_value() const; // 0D_NOT_real
  double base_value() const; // 0D_NOT_real
  double error_rms() const; // 0D_NOT_real
  double delta_merit() const; // 0D_NOT_real
  double weight() const; // 0D_NOT_real
  double invalid_value() const; // 0D_NOT_real
  double merit() const; // 0D_NOT_real
  double s() const; // 0D_NOT_real
  double s_offset() const; // 0D_NOT_real
  bool err_message_printed() const; // 0D_NOT_logical
  bool exists() const; // 0D_NOT_logical
  bool good_model() const; // 0D_NOT_logical
  bool good_base() const; // 0D_NOT_logical
  bool good_design() const; // 0D_NOT_logical
  bool good_meas() const; // 0D_NOT_logical
  bool good_ref() const; // 0D_NOT_logical
  bool good_user() const; // 0D_NOT_logical
  bool good_opt() const; // 0D_NOT_logical
  bool good_plot() const; // 0D_NOT_logical
  bool useit_plot() const; // 0D_NOT_logical
  bool useit_opt() const; // 0D_NOT_logical
  TaoSpinMapProxy spin_map() const; // 0D_NOT_type
  const void* d1() const; // 0D_PTR_type
};

extern "C" {
void* allocate_fortran_tao_ping_scale_struct();
void deallocate_fortran_tao_ping_scale_struct(void* ptr) noexcept;
void copy_fortran_tao_ping_scale_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoPingScaleProxy> {
  static void* allocate() {
    return allocate_fortran_tao_ping_scale_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_ping_scale_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_ping_scale_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_ping_scale_struct";
  }
};

class TaoPingScaleProxy : public FortranProxy<TaoPingScaleProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  double a_mode_meas() const; // 0D_NOT_real
  double a_mode_ref() const; // 0D_NOT_real
  double b_mode_meas() const; // 0D_NOT_real
  double b_mode_ref() const; // 0D_NOT_real
};

extern "C" {
void* allocate_fortran_tao_universe_calc_struct();
void deallocate_fortran_tao_universe_calc_struct(void* ptr) noexcept;
void copy_fortran_tao_universe_calc_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoUniverseCalcProxy> {
  static void* allocate() {
    return allocate_fortran_tao_universe_calc_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_universe_calc_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_universe_calc_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_universe_calc_struct";
  }
};

class TaoUniverseCalcProxy : public FortranProxy<TaoUniverseCalcProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  int srdt_for_data() const; // 0D_NOT_integer
  bool rad_int_for_data() const; // 0D_NOT_logical
  bool rad_int_for_plotting() const; // 0D_NOT_logical
  bool chrom_for_data() const; // 0D_NOT_logical
  bool chrom_for_plotting() const; // 0D_NOT_logical
  bool lat_sigma_for_data() const; // 0D_NOT_logical
  bool lat_sigma_for_plotting() const; // 0D_NOT_logical
  bool dynamic_aperture() const; // 0D_NOT_logical
  bool one_turn_map() const; // 0D_NOT_logical
  bool lattice() const; // 0D_NOT_logical
  bool twiss() const; // 0D_NOT_logical
  bool track() const; // 0D_NOT_logical
  bool spin_matrices() const; // 0D_NOT_logical
};

extern "C" {
void* allocate_fortran_lat_ele_order_struct();
void deallocate_fortran_lat_ele_order_struct(void* ptr) noexcept;
void copy_fortran_lat_ele_order_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<LatEleOrderProxy> {
  static void* allocate() {
    return allocate_fortran_lat_ele_order_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_ele_order_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_lat_ele_order_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "lat_ele_order_struct";
  }
};

class LatEleOrderProxy : public FortranProxy<LatEleOrderProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  FortranTypeArray1D<LatEleOrderArrayProxy> branch() const; // 1D_ALLOC_type
};

extern "C" {
void* allocate_fortran_tao_universe_struct();
void deallocate_fortran_tao_universe_struct(void* ptr) noexcept;
void copy_fortran_tao_universe_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<TaoUniverseProxy> {
  static void* allocate() {
    return allocate_fortran_tao_universe_struct();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_universe_struct(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_tao_universe_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "tao_universe_struct";
  }
};

class TaoUniverseProxy : public FortranProxy<TaoUniverseProxy> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  const void* model() const; // 0D_PTR_type
  const void* design() const; // 0D_PTR_type
  const void* base() const; // 0D_PTR_type
  TaoBeamUniProxy beam() const; // 0D_NOT_type
  TaoDynamicApertureProxy dynamic_aperture() const; // 0D_NOT_type
  FortranTypeArray1D<TaoModelBranchProxy> model_branch() const; // 1D_PTR_type
  FortranTypeArray1D<TaoD2DataProxy> d2_data() const; // 1D_ALLOC_type
  FortranTypeArray1D<TaoDataProxy> data() const; // 1D_ALLOC_type
  TaoPingScaleProxy ping_scale() const; // 0D_NOT_type
  LatProxy scratch_lat() const; // 0D_NOT_type
  TaoUniverseCalcProxy calc() const; // 0D_NOT_type
  LatEleOrderProxy ele_order() const; // 0D_NOT_type
  TaoSpinMapProxy spin_map() const; // 0D_NOT_type
  FortranArray2D<double> dModel_dVar() const; // 2D_ALLOC_real
  int ix_uni() const; // 0D_NOT_integer
  int n_d2_data_used() const; // 0D_NOT_integer
  int n_data_used() const; // 0D_NOT_integer
  bool is_on() const; // 0D_NOT_logical
  bool design_same_as_previous() const; // 0D_NOT_logical
  bool picked_uni() const; // 0D_NOT_logical
};

// Tao proxy classes for navigating the hierarchy
// TaoElementIndexProxy does not map onto a specific Tao struct
// TaoUniverseProxy maps onto tao_universe_struct
class TaoElementIndexProxy {
 private:
  int ix_uni_, ix_lat_, ix_branch_, ix_ele_;

  // void* get_fortran_ptr_() const {
  //   return fortran_ptr_;
  // }

 public:
  TaoElementIndexProxy(
      int ix_uni,
      LatticeType lattice_type,
      int ix_branch,
      int ix_ele)
      : ix_uni_(ix_uni),
        ix_lat_(static_cast<int>(lattice_type)),
        ix_branch_(ix_branch),
        ix_ele_(ix_ele) {}

  EleProxy operator*() const {
    void* ele_ptr =
        tao_c_get_element_ptr(ix_uni_, ix_lat_, ix_branch_, ix_ele_);
    if (!ele_ptr) {
      throw NullPointerException(
          "TaoElementIndexProxy dereference for ix_uni=" +
          std::to_string(ix_uni_) + " ix_lat=" + std::to_string(ix_lat_) +
          " ix_branch=" + std::to_string(ix_branch_) +
          " ix_ele=" + std::to_string(ix_ele_) + "");
    }
    return EleProxy(ele_ptr);
  }

  std::unique_ptr<EleProxy> operator->() const {
    return std::make_unique<EleProxy>(**this);
  }
};

class TaoBranchIndexProxy {
 private:
  int ix_uni_, ix_lat_, ix_branch_;

 public:
  TaoBranchIndexProxy(int ix_uni, LatticeType lattice_type, int ix_branch)
      : ix_uni_(ix_uni),
        ix_lat_(static_cast<int>(lattice_type)),
        ix_branch_(ix_branch) {}

  BranchProxy operator*() const {
    void* branch_ptr = tao_c_get_branch_ptr(ix_uni_, ix_lat_, ix_branch_);
    if (!branch_ptr) {
      throw NullPointerException(
          "TaoBranchIndexProxy dereference for [" + std::to_string(ix_uni_) +
          "," + std::to_string(ix_lat_) + "," + std::to_string(ix_branch_) +
          "]");
    }
    return BranchProxy(branch_ptr);
  }

  std::unique_ptr<BranchProxy> operator->() const {
    return std::make_unique<BranchProxy>(**this);
  }

  TaoElementIndexProxy get_element(int ix_ele) const {
    return TaoElementIndexProxy(
        ix_uni_, static_cast<LatticeType>(ix_lat_), ix_branch_, ix_ele);
  }
};

class TaoLatticeIndexProxy {
 private:
  int ix_uni_, ix_lat_;

  void* get_fortran_ptr_() const {
    void* lat_ptr = tao_c_get_tao_lattice_ptr(ix_uni_, ix_lat_);
    if (!lat_ptr) {
      throw NullPointerException(
          "TaoLatticeIndexProxy dereference for [" + std::to_string(ix_uni_) +
          "," + std::to_string(ix_lat_) + "]");
    }
    return lat_ptr;
  }

 public:
  TaoLatticeIndexProxy(int ix_uni, LatticeType lattice_type)
      : ix_uni_(ix_uni), ix_lat_(static_cast<int>(lattice_type)) {}

  TaoBranchIndexProxy get_branch(int ix_branch) const {
    return TaoBranchIndexProxy(
        ix_uni_, static_cast<LatticeType>(ix_lat_), ix_branch);
  }

  TaoLatticeProxy operator*() const {
    void* lat_ptr = tao_c_get_lattice_ptr(ix_uni_, ix_lat_);
    if (!lat_ptr) {
      throw NullPointerException(
          "TaoLatticeProxy dereference for [" + std::to_string(ix_uni_) + "," +
          std::to_string(ix_lat_) + "]");
    }
    return TaoLatticeProxy(lat_ptr);
  }
  std::unique_ptr<TaoLatticeProxy> operator->() const {
    return std::make_unique<TaoLatticeProxy>(**this);
  }
};

class TaoUniverseIndexProxy {
 private:
  int ix_uni_;

  void* get_fortran_ptr_() const {
    void* uni_ptr = tao_c_get_universe_ptr(ix_uni_);
    if (!uni_ptr) {
      throw NullPointerException(
          "TaoUniverseIndexProxy dereference for universe " +
          std::to_string(ix_uni_));
    }
    return uni_ptr;
  }

 public:
  explicit TaoUniverseIndexProxy(int ix_uni) : ix_uni_(ix_uni) {}

  TaoUniverseProxy operator*() const;
  std::unique_ptr<TaoUniverseProxy> operator->() const {
    return std::make_unique<TaoUniverseProxy>(**this);
  }

  TaoLatticeIndexProxy get_lattice(LatticeType lattice_type) const {
    return TaoLatticeIndexProxy(ix_uni_, lattice_type);
  }
};

} // namespace tao
