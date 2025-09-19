#pragma once

#include "cpp_bmad_classes.h"
#include "fortran_arrays.hpp"
#include "tao_proxies.hpp"

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

void em_taylor_term_struct_get_coef(const void* struct_obj, double* value_out);

void em_taylor_term_struct_get_expn_info(
    const void* struct_obj,
    int** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void em_taylor_struct_get_ref(const void* struct_obj, double* value_out);

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

void beam_init_struct_get_KV(const void* struct_obj, void** ptr_out);

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

void rf_stair_step_struct_get_E_tot0(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_E_tot1(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_p0c(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_p1c(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_dE_amp(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_scale(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_time(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_s(const void* struct_obj, double* value_out);

void rf_stair_step_struct_get_ix_step(const void* struct_obj, int* value_out);

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

void ele_struct_get_spin_taylor_ref_orb_in_info(
    const void* struct_obj,
    double** data_ptr,
    int* size_out,
    int* lower_bound,
    int* upper_bound);

void ele_struct_get_wake(const void* struct_obj, void** ptr_out);

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

void branch_struct_get_param(const void* struct_obj, void** ptr_out);

void branch_struct_get_particle_start(const void* struct_obj, void** ptr_out);

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

void lat_struct_get_a(const void* struct_obj, void** ptr_out);

void lat_struct_get_b(const void* struct_obj, void** ptr_out);

void lat_struct_get_z(const void* struct_obj, void** ptr_out);

void lat_struct_get_param(const void* struct_obj, void** ptr_out);

void lat_struct_get_lord_state(const void* struct_obj, void** ptr_out);

void lat_struct_get_ele_init(const void* struct_obj, void** ptr_out);

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

void tao_universe_struct_get_model(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_design(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_base(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_beam(const void* struct_obj, void** ptr_out);

void tao_universe_struct_get_dynamic_aperture(
    const void* struct_obj,
    void** ptr_out);

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
class TaoException : public std::runtime_error {
 public:
  explicit TaoException(const std::string& message)
      : std::runtime_error(message) {}
};

class InvalidIndexException : public TaoException {
 public:
  InvalidIndexException(const std::string& index_type, int index, int max_value)
      : TaoException(
            "Invalid " + index_type + " index " + std::to_string(index) +
            " (valid range: 0-" + std::to_string(max_value - 1) + ")") {}
};

class NullPointerException : public TaoException {
 public:
  NullPointerException(const std::string& context)
      : TaoException("Null pointer encountered in " + context) {}
};

// Forward declarations
class TaoUniverseProxy;
class LatticeProxy;
class BranchProxy;
class EleProxy;
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

// Non-Tao proxy classes that directly reference Fortran memory
class EleProxy {
 private:
  void* fortran_ptr_;

  void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit EleProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("EleProxy constructor");
    }
  }

  std::shared_ptr<CPP_ele> deepcopy() const {
    auto ele = std::make_shared<CPP_ele>();
    ele_to_c(static_cast<Opaque_ele_class*>(fortran_ptr_), *ele);
    return ele;
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  std::string type() const;
  FortranArray1D<char> get_type_chars() const;
  std::string alias() const;
  FortranArray1D<char> get_alias_chars() const;
  std::string component_name() const;
  FortranArray1D<char> get_component_name_chars() const;
  std::string descrip() const;
  FortranArray1D<char> get_descrip_chars() const;
  TwissProxy a() const;
  TwissProxy b() const;
  TwissProxy z() const;
  XyDispProxy x() const;
  XyDispProxy y() const;
  const void* ac_kick() const;
  BookkeepingStateProxy bookkeeping_state() const;
  const void* branch() const;
  const void* control() const;
  const void* rf() const;
  const void* lord() const;
  FloorPositionProxy floor() const;
  const void* high_energy_space_charge() const;
  const void* mode3() const;
  const void* photon() const;
  const void* rad_map() const;
  FortranArray1D<double> spin_taylor_ref_orb_in() const;
  const void* wake() const;
  CoordProxy map_ref_orb_in() const;
  CoordProxy map_ref_orb_out() const;
  CoordProxy time_ref_orb_in() const;
  CoordProxy time_ref_orb_out() const;
  FortranArray1D<double> value() const;
  FortranArray1D<double> old_value() const;
  FortranArray1D<double> vec0() const;
  double gamma_c() const;
  double s_start() const;
  double s() const;
  double ref_time() const;
  int key() const;
  int sub_key() const;
  int ix_ele() const;
  int ix_branch() const;
  int lord_status() const;
  int n_slave() const;
  int n_slave_field() const;
  int ix1_slave() const;
  int slave_status() const;
  int n_lord() const;
  int n_lord_field() const;
  int n_lord_ramper() const;
  int ic1_lord() const;
  int ix_pointer() const;
  int ixx() const;
  int iyy() const;
  int izz() const;
  int mat6_calc_method() const;
  int tracking_method() const;
  int spin_tracking_method() const;
  int csr_method() const;
  int space_charge_method() const;
  int ptc_integration_type() const;
  int field_calc() const;
  int aperture_at() const;
  int aperture_type() const;
  int ref_species() const;
  int orientation() const;
  bool symplectify() const;
  bool mode_flip() const;
  bool multipoles_on() const;
  bool scale_multipoles() const;
  bool taylor_map_includes_offsets() const;
  bool field_master() const;
  bool is_on() const;
  bool logic() const;
  bool bmad_logic() const;
  bool select() const;
  bool offset_moves_aperture() const;
};

class BranchProxy {
 private:
  void* fortran_ptr_;

  void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BranchProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  EleProxy get_element(int ix_ele) const {
    int n_elements = tao_branch_get_n_elements(fortran_ptr_);
    if (n_elements < 0) {
      throw TaoException("Failed to get number of elements from branch");
    }
    if (ix_ele < 0 || ix_ele >= n_elements) {
      throw InvalidIndexException("element", ix_ele, n_elements);
    }

    void* ele_ptr = tao_branch_get_element_ptr(fortran_ptr_, ix_ele);
    if (!ele_ptr) {
      throw NullPointerException(
          "get_element for index " + std::to_string(ix_ele));
    }
    return EleProxy(ele_ptr);
  }

  int get_n_elements() const {
    int n = tao_branch_get_n_elements(fortran_ptr_);
    if (n < 0) {
      throw TaoException("Failed to get number of elements from branch");
    }
    return n;
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  int ix_branch() const;
  int ix_from_branch() const;
  int ix_from_ele() const;
  int ix_to_ele() const;
  int ix_fixer() const;
  int n_ele_track() const;
  int n_ele_max() const;
  const void* lat() const;
  ModeInfoProxy a() const;
  ModeInfoProxy b() const;
  ModeInfoProxy z() const;
  LatParamProxy param() const;
  CoordProxy particle_start() const;
};

class LatticeProxy {
 private:
  void* fortran_ptr_;

  void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LatticeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("LatticeProxy constructor");
    }
  }

  BranchProxy get_branch(int ix_branch) const {
    int n_branches = tao_lat_get_n_branches(fortran_ptr_);
    if (n_branches < 0) {
      throw TaoException("Failed to get number of branches from lattice");
    }
    if (ix_branch < 0 || ix_branch >= n_branches) {
      throw InvalidIndexException("branch", ix_branch, n_branches);
    }

    void* branch_ptr = tao_lat_get_branch_ptr(fortran_ptr_, ix_branch);
    if (!branch_ptr) {
      throw NullPointerException(
          "get_branch for index " + std::to_string(ix_branch));
    }
    return BranchProxy(branch_ptr);
  }

  int get_n_branches() const {
    int n = tao_lat_get_n_branches(fortran_ptr_);
    if (n < 0) {
      throw TaoException("Failed to get number of branches from lattice");
    }
    return n;
  }

  std::string use_name() const;
  FortranArray1D<char> get_use_name_chars() const;
  std::string lattice() const;
  FortranArray1D<char> get_lattice_chars() const;
  std::string machine() const;
  FortranArray1D<char> get_machine_chars() const;
  std::string input_file_name() const;
  FortranArray1D<char> get_input_file_name_chars() const;
  std::string title() const;
  FortranArray1D<char> get_title_chars() const;
  const void* a() const;
  const void* b() const;
  const void* z() const;
  const void* param() const;
  BookkeepingStateProxy lord_state() const;
  EleProxy ele_init() const;
  const void* particle_start() const;
  BeamInitProxy beam_init() const;
  PreTrackerProxy pre_tracker() const;
  FortranArray1D<double> custom() const;
  int version() const;
  int* n_ele_track() const;
  int* n_ele_max() const;
  int n_control_max() const;
  int n_ic_max() const;
  int input_taylor_order() const;
  FortranArray1D<int> ic() const;
  int photon_type() const;
  int creation_hash() const;
  int ramper_slave_bookkeeping() const;
};

class SplineProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SplineProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double x0() const;
  double y0() const;
  double x1() const;
  FortranArray1D<double> coef() const;
};

class SpinPolarProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SpinPolarProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double polarization() const;
  double theta() const;
  double phi() const;
  double xi() const;
};

class AcKickerTimeProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit AcKickerTimeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double amp() const;
  double time() const;
  SplineProxy spline() const;
};

class AcKickerFreqProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit AcKickerFreqProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double f() const;
  double amp() const;
  double phi() const;
  int rf_clock_harmonic() const;
};

class AcKickerProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit AcKickerProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }
};

class Interval1CoefProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit Interval1CoefProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double c0() const;
  double c1() const;
  double n_exp() const;
};

class PhotonReflectTableProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PhotonReflectTableProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> angle() const;
  FortranArray1D<double> energy() const;
  FortranArray2D<double> p_reflect() const;
  double max_energy() const;
  FortranArray1D<double> p_reflect_scratch() const;
  FortranArray1D<double> bragg_angle() const;
};

class PhotonReflectSurfaceProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PhotonReflectSurfaceProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  std::string description() const;
  FortranArray1D<char> get_description_chars() const;
  std::string reflectivity_file() const;
  FortranArray1D<char> get_reflectivity_file_chars() const;
  double surface_roughness_rms() const;
  double roughness_correlation_len() const;
  int ix_surface() const;
};

class CoordProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit CoordProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> vec() const;
  double s() const;
  long double t() const;
  FortranArray1D<double> spin() const;
  FortranArray1D<double> field() const;
  FortranArray1D<double> phase() const;
  double charge() const;
  double dt_ref() const;
  double r() const;
  double p0c() const;
  double E_potential() const;
  double beta() const;
  int ix_ele() const;
  int ix_branch() const;
  int ix_turn() const;
  int ix_user() const;
  int state() const;
  int direction() const;
  int time_dir() const;
  int species() const;
  int location() const;
};

class CoordArrayProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit CoordArrayProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }
};

class BpmPhaseCouplingProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BpmPhaseCouplingProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double K_22a() const;
  double K_12a() const;
  double K_11b() const;
  double K_12b() const;
  double Cbar22_a() const;
  double Cbar12_a() const;
  double Cbar11_b() const;
  double Cbar12_b() const;
  double phi_a() const;
  double phi_b() const;
};

class ExpressionAtomProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ExpressionAtomProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  int type() const;
  double value() const;
};

class WakeSrZLongProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit WakeSrZLongProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> w() const;
  double dz() const;
  double z0() const;
  double smoothing_sigma() const;
  int position_dependence() const;
  bool time_based() const;
};

class WakeSrModeProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit WakeSrModeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double amp() const;
  double damp() const;
  double k() const;
  double phi() const;
  double b_sin() const;
  double b_cos() const;
  double a_sin() const;
  double a_cos() const;
  int polarization() const;
  int position_dependence() const;
};

class WakeSrProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit WakeSrProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string file() const;
  FortranArray1D<char> get_file_chars() const;
  WakeSrZLongProxy z_long() const;
  double z_ref_long() const;
  double z_ref_trans() const;
  double z_max() const;
  double amp_scale() const;
  double z_scale() const;
  bool scale_with_length() const;
};

class WakeLrModeProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit WakeLrModeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double freq() const;
  double freq_in() const;
  double R_over_Q() const;
  double Q() const;
  double damp() const;
  double phi() const;
  double angle() const;
  double b_sin() const;
  double b_cos() const;
  double a_sin() const;
  double a_cos() const;
  int m() const;
  bool polarized() const;
};

class WakeLrProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit WakeLrProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string file() const;
  FortranArray1D<char> get_file_chars() const;
  double t_ref() const;
  double freq_spread() const;
  double amp_scale() const;
  double time_scale() const;
  bool self_wake_on() const;
};

class LatEleLocProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LatEleLocProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int ix_ele() const;
  int ix_branch() const;
};

class WakeProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit WakeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  WakeSrProxy sr() const;
  WakeLrProxy lr() const;
};

class TaylorTermProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaylorTermProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double coef() const;
  FortranArray1D<int> expn() const;
};

class TaylorProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaylorProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double ref() const;
};

class EmTaylorTermProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit EmTaylorTermProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double coef() const;
  FortranArray1D<int> expn() const;
};

class EmTaylorProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit EmTaylorProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double ref() const;
};

class CartesianMapTerm1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit CartesianMapTerm1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double coef() const;
  double kx() const;
  double ky() const;
  double kz() const;
  double x0() const;
  double y0() const;
  double phi_z() const;
  int family() const;
  int form() const;
};

class CartesianMapTermProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit CartesianMapTermProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string file() const;
  FortranArray1D<char> get_file_chars() const;
  int n_link() const;
};

class CartesianMapProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit CartesianMapProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double field_scale() const;
  FortranArray1D<double> r0() const;
  int master_parameter() const;
  int ele_anchor_pt() const;
  int field_type() const;
  const void* ptr() const;
};

class CylindricalMapTerm1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit CylindricalMapTerm1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::complex<double> e_coef() const;
  std::complex<double> b_coef() const;
};

class CylindricalMapTermProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit CylindricalMapTermProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string file() const;
  FortranArray1D<char> get_file_chars() const;
  int n_link() const;
};

class CylindricalMapProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit CylindricalMapProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int m() const;
  int harmonic() const;
  double phi0_fieldmap() const;
  double theta0_azimuth() const;
  double field_scale() const;
  int master_parameter() const;
  int ele_anchor_pt() const;
  double dz() const;
  FortranArray1D<double> r0() const;
  const void* ptr() const;
};

class BicubicCmplxCoefProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BicubicCmplxCoefProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<int> i_box() const;
};

class TricubicCmplxCoefProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TricubicCmplxCoefProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<int> i_box() const;
};

class GridFieldPt1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit GridFieldPt1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<std::complex<double>> E() const;
  FortranArray1D<std::complex<double>> B() const;
};

class GridFieldPtProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit GridFieldPtProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string file() const;
  FortranArray1D<char> get_file_chars() const;
  int n_link() const;
};

class GridFieldProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit GridFieldProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int geometry() const;
  int harmonic() const;
  double phi0_fieldmap() const;
  double field_scale() const;
  int field_type() const;
  int master_parameter() const;
  int ele_anchor_pt() const;
  int interpolation_order() const;
  FortranArray1D<double> dr() const;
  FortranArray1D<double> r0() const;
  bool curved_ref_frame() const;
  const void* ptr() const;
};

class FloorPositionProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit FloorPositionProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> r() const;
  double theta() const;
  double phi() const;
  double psi() const;
};

class HighEnergySpaceChargeProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit HighEnergySpaceChargeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  CoordProxy closed_orb() const;
  double kick_const() const;
  double sig_x() const;
  double sig_y() const;
  double phi() const;
  double sin_phi() const;
  double cos_phi() const;
  double sig_z() const;
};

class XyDispProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit XyDispProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double eta() const;
  double etap() const;
  double deta_ds() const;
  double sigma() const;
  double deta_dpz() const;
  double detap_dpz() const;
};

class TwissProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TwissProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double beta() const;
  double alpha() const;
  double gamma() const;
  double phi() const;
  double eta() const;
  double etap() const;
  double deta_ds() const;
  double sigma() const;
  double sigma_p() const;
  double emit() const;
  double norm_emit() const;
  double chrom() const;
  double dbeta_dpz() const;
  double dalpha_dpz() const;
  double deta_dpz() const;
  double detap_dpz() const;
};

class Mode3Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit Mode3Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  TwissProxy a() const;
  TwissProxy b() const;
  TwissProxy c() const;
  TwissProxy x() const;
  TwissProxy y() const;
};

class BookkeepingStateProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BookkeepingStateProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int attributes() const;
  int control() const;
  int floor_position() const;
  int s_position() const;
  int ref_energy() const;
  int mat6() const;
  int rad_int() const;
  int ptc() const;
  bool has_misalign() const;
};

class RadMapProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit RadMapProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> ref_orb() const;
  FortranArray1D<double> xfer_damp_vec() const;
};

class RadMapEleProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit RadMapEleProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  RadMapProxy rm0() const;
  RadMapProxy rm1() const;
  bool stale() const;
};

class GenGrad1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit GenGrad1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int m() const;
  int sincos() const;
  int n_deriv_max() const;
  FortranArray2D<double> deriv() const;
};

class GenGradMapProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit GenGradMapProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string file() const;
  FortranArray1D<char> get_file_chars() const;
  int ele_anchor_pt() const;
  int field_type() const;
  int iz0() const;
  int iz1() const;
  double dz() const;
  FortranArray1D<double> r0() const;
  double field_scale() const;
  int master_parameter() const;
  bool curved_ref_frame() const;
};

class SurfaceSegmentedPtProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SurfaceSegmentedPtProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double x0() const;
  double y0() const;
  double z0() const;
  double dz_dx() const;
  double dz_dy() const;
};

class SurfaceSegmentedProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SurfaceSegmentedProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  bool active() const;
  FortranArray1D<double> dr() const;
  FortranArray1D<double> r0() const;
};

class SurfaceHMisalignPtProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SurfaceHMisalignPtProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double x0() const;
  double y0() const;
  double rot_y() const;
  double rot_t() const;
  double rot_y_rms() const;
  double rot_t_rms() const;
};

class SurfaceHMisalignProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SurfaceHMisalignProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  bool active() const;
  FortranArray1D<double> dr() const;
  FortranArray1D<double> r0() const;
};

class SurfaceDisplacementPtProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SurfaceDisplacementPtProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double x0() const;
  double y0() const;
  double z0() const;
  double dz_dx() const;
  double dz_dy() const;
  double d2z_dxdy() const;
};

class SurfaceDisplacementProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SurfaceDisplacementProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  bool active() const;
  FortranArray1D<double> dr() const;
  FortranArray1D<double> r0() const;
};

class TargetPointProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TargetPointProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> r() const;
};

class SurfaceCurvatureProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SurfaceCurvatureProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double spherical() const;
  FortranArray1D<double> elliptical() const;
  bool has_curvature() const;
};

class PhotonTargetProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PhotonTargetProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int type() const;
  int n_corner() const;
  LatEleLocProxy ele_loc() const;
  TargetPointProxy center() const;
};

class PhotonMaterialProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PhotonMaterialProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::complex<double> f0_m1() const;
  std::complex<double> f0_m2() const;
  std::complex<double> f_0() const;
  std::complex<double> f_h() const;
  std::complex<double> f_hbar() const;
  std::complex<double> f_hkl() const;
  FortranArray1D<double> h_norm() const;
  FortranArray1D<double> l_ref() const;
};

class PixelPtProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PixelPtProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  long long n_photon() const;
  std::complex<double> E_x() const;
  std::complex<double> E_y() const;
  double intensity_x() const;
  double intensity_y() const;
  double intensity() const;
  FortranArray1D<double> orbit() const;
  FortranArray1D<double> orbit_rms() const;
  FortranArray1D<double> init_orbit() const;
  FortranArray1D<double> init_orbit_rms() const;
};

class PixelDetecProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PixelDetecProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> dr() const;
  FortranArray1D<double> r0() const;
  long long n_track_tot() const;
  long long n_hit_detec() const;
  long long n_hit_pixel() const;
};

class PhotonElementProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PhotonElementProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  SurfaceCurvatureProxy curvature() const;
  PhotonTargetProxy target() const;
  PhotonMaterialProxy material() const;
  SurfaceSegmentedProxy segmented() const;
  SurfaceHMisalignProxy h_misalign() const;
  SurfaceDisplacementProxy displacement() const;
  PixelDetecProxy pixel() const;
  int reflectivity_table_type() const;
  PhotonReflectTableProxy reflectivity_table_sigma() const;
  PhotonReflectTableProxy reflectivity_table_pi() const;
  FortranArray1D<double> integrated_init_energy_prob() const;
};

class Wall3dVertexProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit Wall3dVertexProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double x() const;
  double y() const;
  double radius_x() const;
  double radius_y() const;
  double tilt() const;
  double angle() const;
  double x0() const;
  double y0() const;
  int type() const;
};

class Wall3dSectionProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit Wall3dSectionProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  std::string material() const;
  FortranArray1D<char> get_material_chars() const;
  const void* surface() const;
  int type() const;
  int n_vertex_input() const;
  int ix_ele() const;
  int ix_branch() const;
  int vertices_state() const;
  bool patch_in_region() const;
  double thickness() const;
  double s() const;
  FortranArray1D<double> r0() const;
  double dx0_ds() const;
  double dy0_ds() const;
  FortranArray1D<double> x0_coef() const;
  FortranArray1D<double> y0_coef() const;
  double dr_ds() const;
  FortranArray1D<double> p1_coef() const;
  FortranArray1D<double> p2_coef() const;
};

class Wall3dProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit Wall3dProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  int type() const;
  int ix_wall3d() const;
  int n_link() const;
  double thickness() const;
  std::string clear_material() const;
  FortranArray1D<char> get_clear_material_chars() const;
  std::string opaque_material() const;
  FortranArray1D<char> get_opaque_material_chars() const;
  bool superimpose() const;
  int ele_anchor_pt() const;
};

class RamperLordProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit RamperLordProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int ix_ele() const;
  int ix_con() const;
  double* attrib_ptr() const;
};

class ControlProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ControlProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double value() const;
  FortranArray1D<double> y_knot() const;
  LatEleLocProxy slave() const;
  LatEleLocProxy lord() const;
  std::string slave_name() const;
  FortranArray1D<char> get_slave_name_chars() const;
  std::string attribute() const;
  FortranArray1D<char> get_attribute_chars() const;
  int ix_attrib() const;
};

class ControlVar1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ControlVar1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  double value() const;
  double old_value() const;
};

class ControlRamp1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ControlRamp1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> y_knot() const;
  std::string attribute() const;
  FortranArray1D<char> get_attribute_chars() const;
  std::string slave_name() const;
  FortranArray1D<char> get_slave_name_chars() const;
  bool is_controller() const;
};

class ControllerProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ControllerProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> x_knot() const;
};

class EllipseBeamInitProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit EllipseBeamInitProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int part_per_ellipse() const;
  int n_ellipse() const;
  double sigma_cutoff() const;
};

class KvBeamInitProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit KvBeamInitProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<int> part_per_phi() const;
  int n_I2() const;
  double A() const;
};

class GridBeamInitProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit GridBeamInitProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int n_x() const;
  int n_px() const;
  double x_min() const;
  double x_max() const;
  double px_min() const;
  double px_max() const;
};

class BeamInitProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BeamInitProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string position_file() const;
  FortranArray1D<char> get_position_file_chars() const;
  FortranArray1D<double> spin() const;
  KvBeamInitProxy KV() const;
  FortranArray1D<double> center_jitter() const;
  FortranArray1D<double> emit_jitter() const;
  double sig_z_jitter() const;
  double sig_pz_jitter() const;
  int n_particle() const;
  bool renorm_center() const;
  bool renorm_sigma() const;
  std::string random_engine() const;
  FortranArray1D<char> get_random_engine_chars() const;
  std::string random_gauss_converter() const;
  FortranArray1D<char> get_random_gauss_converter_chars() const;
  double random_sigma_cutoff() const;
  double a_norm_emit() const;
  double b_norm_emit() const;
  double a_emit() const;
  double b_emit() const;
  double dPz_dz() const;
  FortranArray1D<double> center() const;
  double t_offset() const;
  double dt_bunch() const;
  double sig_z() const;
  double sig_pz() const;
  double bunch_charge() const;
  int n_bunch() const;
  int ix_turn() const;
  std::string species() const;
  FortranArray1D<char> get_species_chars() const;
  bool full_6D_coupling_calc() const;
  bool use_particle_start() const;
  bool use_t_coords() const;
  bool use_z_as_t() const;
  std::string file_name() const;
  FortranArray1D<char> get_file_name_chars() const;
};

class LatParamProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LatParamProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double n_part() const;
  double total_length() const;
  double unstable_factor() const;
  double spin_tune() const;
  int particle() const;
  int default_tracking_species() const;
  int geometry() const;
  int ixx() const;
  bool stable() const;
  bool live_branch() const;
  double g1_integral() const;
  double g2_integral() const;
  double g3_integral() const;
  BookkeepingStateProxy bookkeeping_state() const;
  BeamInitProxy beam_init() const;
};

class ModeInfoProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ModeInfoProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  bool stable() const;
  double tune() const;
  double emit() const;
  double chrom() const;
  double sigma() const;
  double sigmap() const;
};

class PreTrackerProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PreTrackerProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int who() const;
  int ix_ele_start() const;
  int ix_ele_end() const;
  std::string input_file() const;
  FortranArray1D<char> get_input_file_chars() const;
};

class AnormalModeProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit AnormalModeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double emittance() const;
  double emittance_no_vert() const;
  FortranArray1D<double> synch_int() const;
  double j_damp() const;
  double alpha_damp() const;
  double chrom() const;
  double tune() const;
};

class LinacNormalModeProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LinacNormalModeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double i2_E4() const;
  double i3_E7() const;
  double i5a_E6() const;
  double i5b_E6() const;
  double sig_E1() const;
  double a_emittance_end() const;
  double b_emittance_end() const;
};

class NormalModesProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit NormalModesProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> synch_int() const;
  double sigE_E() const;
  double sig_z() const;
  double e_loss() const;
  double rf_voltage() const;
  double pz_aperture() const;
  double pz_average() const;
  double momentum_compaction() const;
  double dpz_damp() const;
  AnormalModeProxy a() const;
  AnormalModeProxy b() const;
  AnormalModeProxy z() const;
  LinacNormalModeProxy lin() const;
};

class EmFieldProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit EmFieldProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> E() const;
  FortranArray1D<double> B() const;
  double phi() const;
  double phi_B() const;
  FortranArray1D<double> A() const;
};

class StrongBeamProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit StrongBeamProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int ix_slice() const;
  double x_center() const;
  double y_center() const;
  double x_sigma() const;
  double y_sigma() const;
  double dx() const;
  double dy() const;
};

class TrackPointProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TrackPointProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double s_lab() const;
  double s_body() const;
  CoordProxy orb() const;
  EmFieldProxy field() const;
  StrongBeamProxy strong_beam() const;
  FortranArray1D<double> vec0() const;
};

class TrackProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TrackProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double ds_save() const;
  int n_pt() const;
  int n_bad() const;
  int n_ok() const;
};

class SpaceChargeCommonProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SpaceChargeCommonProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double ds_track_step() const;
  double dt_track_step() const;
  double cathode_strength_cutoff() const;
  double rel_tol_tracking() const;
  double abs_tol_tracking() const;
  double beam_chamber_height() const;
  double lsc_sigma_cutoff() const;
  double particle_sigma_cutoff() const;
  FortranArray1D<int> space_charge_mesh_size() const;
  FortranArray1D<int> csr3d_mesh_size() const;
  int n_bin() const;
  int particle_bin_span() const;
  int n_shield_images() const;
  int sc_min_in_bin() const;
  bool lsc_kick_transverse_dependence() const;
  bool debug() const;
  std::string diagnostic_output_file() const;
  FortranArray1D<char> get_diagnostic_output_file_chars() const;
};

class BmadCommonProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BmadCommonProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double max_aperture_limit() const;
  FortranArray1D<double> d_orb() const;
  double default_ds_step() const;
  double significant_length() const;
  double rel_tol_tracking() const;
  double abs_tol_tracking() const;
  double rel_tol_adaptive_tracking() const;
  double abs_tol_adaptive_tracking() const;
  double init_ds_adaptive_tracking() const;
  double min_ds_adaptive_tracking() const;
  double fatal_ds_adaptive_tracking() const;
  double autoscale_amp_abs_tol() const;
  double autoscale_amp_rel_tol() const;
  double autoscale_phase_tol() const;
  double electric_dipole_moment() const;
  double synch_rad_scale() const;
  double sad_eps_scale() const;
  double sad_amp_max() const;
  int sad_n_div_max() const;
  int taylor_order() const;
  int runge_kutta_order() const;
  int default_integ_order() const;
  int max_num_runge_kutta_step() const;
  bool rf_phase_below_transition_ref() const;
  bool sr_wakes_on() const;
  bool lr_wakes_on() const;
  bool auto_bookkeeper() const;
  bool high_energy_space_charge_on() const;
  bool csr_and_space_charge_on() const;
  bool spin_tracking_on() const;
  bool spin_sokolov_ternov_flipping_on() const;
  bool radiation_damping_on() const;
  bool radiation_zero_average() const;
  bool radiation_fluctuations_on() const;
  bool conserve_taylor_maps() const;
  bool absolute_time_tracking() const;
  bool absolute_time_ref_shift() const;
  bool convert_to_kinetic_momentum() const;
  bool normalize_twiss() const;
  bool aperture_limit_on() const;
  bool spin_n0_direction_user_set() const;
  bool debug() const;
};

class RadInt1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit RadInt1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double i0() const;
  double i1() const;
  double i2() const;
  double i3() const;
  double i4a() const;
  double i4b() const;
  double i4z() const;
  double i5a() const;
  double i5b() const;
  double i6b() const;
  double lin_i2_E4() const;
  double lin_i3_E7() const;
  double lin_i5a_E6() const;
  double lin_i5b_E6() const;
  double lin_norm_emit_a() const;
  double lin_norm_emit_b() const;
  double lin_sig_E() const;
  double n_steps() const;
};

class RadIntBranchProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit RadIntBranchProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }
};

class RadIntAllEleProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit RadIntAllEleProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }
};

class RfStairStepProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit RfStairStepProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double E_tot0() const;
  double E_tot1() const;
  double p0c() const;
  double p1c() const;
  double dE_amp() const;
  double scale() const;
  double time() const;
  double s() const;
  int ix_step() const;
};

class RfEleProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit RfEleProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double ds_step() const;
};

class ComplexTaylorTermProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ComplexTaylorTermProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::complex<double> coef() const;
  FortranArray1D<int> expn() const;
};

class ComplexTaylorProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ComplexTaylorProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::complex<double> ref() const;
};

class LatProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LatProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string use_name() const;
  FortranArray1D<char> get_use_name_chars() const;
  std::string lattice() const;
  FortranArray1D<char> get_lattice_chars() const;
  std::string machine() const;
  FortranArray1D<char> get_machine_chars() const;
  std::string input_file_name() const;
  FortranArray1D<char> get_input_file_name_chars() const;
  std::string title() const;
  FortranArray1D<char> get_title_chars() const;
  const void* a() const;
  const void* b() const;
  const void* z() const;
  const void* param() const;
  BookkeepingStateProxy lord_state() const;
  EleProxy ele_init() const;
  const void* particle_start() const;
  BeamInitProxy beam_init() const;
  PreTrackerProxy pre_tracker() const;
  FortranArray1D<double> custom() const;
  int version() const;
  int* n_ele_track() const;
  int* n_ele_max() const;
  int n_control_max() const;
  int n_ic_max() const;
  int input_taylor_order() const;
  FortranArray1D<int> ic() const;
  int photon_type() const;
  int creation_hash() const;
  int ramper_slave_bookkeeping() const;
};

class BunchProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BunchProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<int> ix_z() const;
  double charge_tot() const;
  double charge_live() const;
  double z_center() const;
  double t_center() const;
  double t0() const;
  bool drift_between_t_and_s() const;
  int ix_ele() const;
  int ix_bunch() const;
  int ix_turn() const;
  int n_live() const;
  int n_good() const;
  int n_bad() const;
};

class BunchParamsProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BunchParamsProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  CoordProxy centroid() const;
  TwissProxy x() const;
  TwissProxy y() const;
  TwissProxy z() const;
  TwissProxy a() const;
  TwissProxy b() const;
  TwissProxy c() const;
  FortranArray1D<double> rel_max() const;
  FortranArray1D<double> rel_min() const;
  double s() const;
  double t() const;
  double sigma_t() const;
  double charge_live() const;
  double charge_tot() const;
  int n_particle_tot() const;
  int n_particle_live() const;
  int n_particle_lost_in_ele() const;
  int n_good_steps() const;
  int n_bad_steps() const;
  int ix_ele() const;
  int location() const;
  bool twiss_valid() const;
};

class BeamProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BeamProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }
};

class AperturePointProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit AperturePointProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double x() const;
  double y() const;
  int plane() const;
  int ix_ele() const;
  int i_turn() const;
};

class ApertureParamProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ApertureParamProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double min_angle() const;
  double max_angle() const;
  int n_angle() const;
  int n_turn() const;
  double x_init() const;
  double y_init() const;
  double rel_accuracy() const;
  double abs_accuracy() const;
  std::string start_ele() const;
  FortranArray1D<char> get_start_ele_chars() const;
};

class ApertureScanProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ApertureScanProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  CoordProxy ref_orb() const;
  double pz_start() const;
};

class TaoSpinDnDpzProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoSpinDnDpzProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> vec() const;
};

class ResonanceHProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit ResonanceHProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string id() const;
  FortranArray1D<char> get_id_chars() const;
  std::complex<double> c_val() const;
};

class SpinOrbitMap1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SpinOrbitMap1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> vec0() const;
};

class SpinAxisProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SpinAxisProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  FortranArray1D<double> l() const;
  FortranArray1D<double> n0() const;
  FortranArray1D<double> m() const;
};

class PtcNormalFormProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit PtcNormalFormProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  const void* ele_origin() const;
  FortranArray1D<double> orb0() const;
  bool valid_map() const;
};

class BmadNormalFormProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BmadNormalFormProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  const void* ele_origin() const;
};

class BunchTrackProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit BunchTrackProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double ds_save() const;
  int n_pt() const;
};

class SummationRdtProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit SummationRdtProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::complex<double> h11001() const;
  std::complex<double> h00111() const;
  std::complex<double> h20001() const;
  std::complex<double> h00201() const;
  std::complex<double> h10002() const;
  std::complex<double> h21000() const;
  std::complex<double> h30000() const;
  std::complex<double> h10110() const;
  std::complex<double> h10020() const;
  std::complex<double> h10200() const;
  std::complex<double> h31000() const;
  std::complex<double> h40000() const;
  std::complex<double> h20110() const;
  std::complex<double> h11200() const;
  std::complex<double> h20020() const;
  std::complex<double> h20200() const;
  std::complex<double> h00310() const;
  std::complex<double> h00400() const;
  std::complex<double> h22000() const;
  std::complex<double> h00220() const;
  std::complex<double> h11110() const;
};

class LatEleOrder1Proxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LatEleOrder1Proxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int ix_branch() const;
  int ix_order() const;
};

class LatEleOrderArrayProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LatEleOrderArrayProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }
};

class TaoLatSigmaProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoLatSigmaProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }
};

class TaoSpinEleProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoSpinEleProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  TaoSpinDnDpzProxy dn_dpz() const;
  FortranArray1D<double> orb_eigen_val() const;
  bool valid() const;
};

class TaoPlotCacheProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoPlotCacheProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  EleProxy ele_to_s() const;
  CoordProxy orbit() const;
  bool err() const;
};

class TaoSpinPolarizationProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoSpinPolarizationProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double tune() const;
  double pol_limit_st() const;
  double pol_limit_dk() const;
  FortranArray1D<double> pol_limit_dk_partial() const;
  FortranArray1D<double> pol_limit_dk_partial2() const;
  double pol_rate_bks() const;
  double depol_rate() const;
  FortranArray1D<double> depol_rate_partial() const;
  FortranArray1D<double> depol_rate_partial2() const;
  double integral_bn() const;
  double integral_bdn() const;
  double integral_1ns() const;
  double integral_dn2() const;
  bool valid() const;
  SpinOrbitMap1Proxy q_1turn() const;
};

class TaoLatticeBranchProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoLatticeBranchProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  TaoSpinPolarizationProxy spin() const;
  SummationRdtProxy srdt() const;
  CoordProxy orb0() const;
  NormalModesProxy modes_ri() const;
  NormalModesProxy modes_6d() const;
  PtcNormalFormProxy ptc_normal_form() const;
  BmadNormalFormProxy bmad_normal_form() const;
  double cache_x_min() const;
  double cache_x_max() const;
  double comb_ds_save() const;
  int track_state() const;
  int cache_n_pts() const;
  int ix_rad_int_cache() const;
  bool has_open_match_element() const;
  bool plot_cache_valid() const;
  bool spin_map_valid() const;
  bool twiss_valid() const;
  bool mode_flip_here() const;
  bool chrom_calc_ok() const;
  bool rad_int_calc_ok() const;
  bool emit_6d_calc_ok() const;
  bool sigma_track_ok() const;
};

class TaoModelElementProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoModelElementProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  BeamProxy beam() const;
  bool save_beam_internally() const;
  bool save_beam_to_file() const;
};

class TaoBeamBranchProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoBeamBranchProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  BeamProxy beam_at_start() const;
  BeamInitProxy beam_init() const;
  BeamInitProxy beam_init_used() const;
  bool init_starting_distribution() const;
  std::string track_start() const;
  FortranArray1D<char> get_track_start_chars() const;
  std::string track_end() const;
  FortranArray1D<char> get_track_end_chars() const;
  int ix_branch() const;
  int ix_track_start() const;
  int ix_track_end() const;
};

class TaoD1DataProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoD1DataProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
};

class TaoLatticeProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoLatticeProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  LatProxy lat() const;
  LatProxy high_E_lat() const;
  LatProxy low_E_lat() const;
  RadIntAllEleProxy rad_int_by_ele_ri() const;
  RadIntAllEleProxy rad_int_by_ele_6d() const;
};

class TaoBeamUniProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoBeamUniProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string saved_at() const;
  FortranArray1D<char> get_saved_at_chars() const;
  std::string dump_file() const;
  FortranArray1D<char> get_dump_file_chars() const;
  std::string dump_at() const;
  FortranArray1D<char> get_dump_at_chars() const;
  bool track_beam_in_universe() const;
  bool always_reinit() const;
};

class TaoDynamicApertureProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoDynamicApertureProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  ApertureParamProxy param() const;
  FortranArray1D<double> pz() const;
  double ellipse_scale() const;
  double a_emit() const;
  double b_emit() const;
};

class TaoModelBranchProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoModelBranchProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  TaoBeamBranchProxy beam() const;
};

class TaoD2DataProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoD2DataProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string name() const;
  FortranArray1D<char> get_name_chars() const;
  std::string data_file_name() const;
  FortranArray1D<char> get_data_file_name_chars() const;
  std::string ref_file_name() const;
  FortranArray1D<char> get_ref_file_name_chars() const;
  std::string data_date() const;
  FortranArray1D<char> get_data_date_chars() const;
  std::string ref_date() const;
  FortranArray1D<char> get_ref_date_chars() const;
  int ix_universe() const;
  int ix_d2_data() const;
  int ix_ref() const;
  bool data_read_in() const;
  bool ref_read_in() const;
};

class TaoSpinMapProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoSpinMapProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  bool valid() const;
  SpinOrbitMap1Proxy map1() const;
  SpinAxisProxy axis_input() const;
  SpinAxisProxy axis0() const;
  SpinAxisProxy axis1() const;
  int ix_ele() const;
  int ix_ref() const;
  int ix_uni() const;
  int ix_branch() const;
};

class TaoDataProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoDataProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  std::string ele_name() const;
  FortranArray1D<char> get_ele_name_chars() const;
  std::string ele_start_name() const;
  FortranArray1D<char> get_ele_start_name_chars() const;
  std::string ele_ref_name() const;
  FortranArray1D<char> get_ele_ref_name_chars() const;
  std::string merit_type() const;
  FortranArray1D<char> get_merit_type_chars() const;
  std::string id() const;
  FortranArray1D<char> get_id_chars() const;
  std::string data_source() const;
  FortranArray1D<char> get_data_source_chars() const;
  std::string why_invalid() const;
  FortranArray1D<char> get_why_invalid_chars() const;
  int ix_uni() const;
  int ix_bunch() const;
  int ix_branch() const;
  int ix_ele() const;
  int ix_ele_start() const;
  int ix_ele_ref() const;
  int ix_ele_merit() const;
  int ix_d1() const;
  int ix_data() const;
  int ix_dModel() const;
  int eval_point() const;
  double meas_value() const;
  double ref_value() const;
  double model_value() const;
  double design_value() const;
  double old_value() const;
  double base_value() const;
  double error_rms() const;
  double delta_merit() const;
  double weight() const;
  double invalid_value() const;
  double merit() const;
  double s() const;
  double s_offset() const;
  bool err_message_printed() const;
  bool exists() const;
  bool good_model() const;
  bool good_base() const;
  bool good_design() const;
  bool good_meas() const;
  bool good_ref() const;
  bool good_user() const;
  bool good_opt() const;
  bool good_plot() const;
  bool useit_plot() const;
  bool useit_opt() const;
  TaoSpinMapProxy spin_map() const;
  const void* d1() const;
};

class TaoPingScaleProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoPingScaleProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  double a_mode_meas() const;
  double a_mode_ref() const;
  double b_mode_meas() const;
  double b_mode_ref() const;
};

class TaoUniverseCalcProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoUniverseCalcProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  int srdt_for_data() const;
  bool rad_int_for_data() const;
  bool rad_int_for_plotting() const;
  bool chrom_for_data() const;
  bool chrom_for_plotting() const;
  bool lat_sigma_for_data() const;
  bool lat_sigma_for_plotting() const;
  bool dynamic_aperture() const;
  bool one_turn_map() const;
  bool lattice() const;
  bool twiss() const;
  bool track() const;
  bool spin_matrices() const;
};

class LatEleOrderProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit LatEleOrderProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }
};

class TaoUniverseProxy {
 private:
  void* fortran_ptr_;

  inline void* get_fortran_ptr_() const {
    return fortran_ptr_;
  }

 public:
  explicit TaoUniverseProxy(void* ptr) : fortran_ptr_(ptr) {
    if (!ptr) {
      throw NullPointerException("BranchProxy constructor");
    }
  }

  const void* model() const;
  const void* design() const;
  const void* base() const;
  TaoBeamUniProxy beam() const;
  TaoDynamicApertureProxy dynamic_aperture() const;
  TaoPingScaleProxy ping_scale() const;
  LatProxy scratch_lat() const;
  TaoUniverseCalcProxy calc() const;
  LatEleOrderProxy ele_order() const;
  TaoSpinMapProxy spin_map() const;
  FortranArray2D<double> dModel_dVar() const;
  int ix_uni() const;
  int n_d2_data_used() const;
  int n_data_used() const;
  bool is_on() const;
  bool design_same_as_previous() const;
  bool picked_uni() const;
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
