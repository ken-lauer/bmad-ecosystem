#pragma once

#include "fortran_arrays.hpp"
#include "proxy_base.hpp"

#include <complex>
#include <memory>
#include <string>

extern "C" {
// Forward declarations for Fortran interface
void spline_struct_get_x0(const void* struct_obj, double* value_out);
void spline_struct_set_x0(void* struct_obj, double value_in);
void spline_struct_get_y0(const void* struct_obj, double* value_out);
void spline_struct_set_y0(void* struct_obj, double value_in);
void spline_struct_get_x1(const void* struct_obj, double* value_out);
void spline_struct_set_x1(void* struct_obj, double value_in);
void spline_struct_get_coef_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void spin_polar_struct_get_polarization(
    const void* struct_obj,
    double* value_out);
void spin_polar_struct_set_polarization(void* struct_obj, double value_in);
void spin_polar_struct_get_theta(const void* struct_obj, double* value_out);
void spin_polar_struct_set_theta(void* struct_obj, double value_in);
void spin_polar_struct_get_phi(const void* struct_obj, double* value_out);
void spin_polar_struct_set_phi(void* struct_obj, double value_in);
void spin_polar_struct_get_xi(const void* struct_obj, double* value_out);
void spin_polar_struct_set_xi(void* struct_obj, double value_in);
void ac_kicker_time_struct_get_amp(const void* struct_obj, double* value_out);
void ac_kicker_time_struct_set_amp(void* struct_obj, double value_in);
void ac_kicker_time_struct_get_time(const void* struct_obj, double* value_out);
void ac_kicker_time_struct_set_time(void* struct_obj, double value_in);
void ac_kicker_time_struct_get_spline(const void* struct_obj, void** ptr_out);
void ac_kicker_time_struct_set_spline(void* struct_obj, const void* src_ptr);
void ac_kicker_freq_struct_get_f(const void* struct_obj, double* value_out);
void ac_kicker_freq_struct_set_f(void* struct_obj, double value_in);
void ac_kicker_freq_struct_get_amp(const void* struct_obj, double* value_out);
void ac_kicker_freq_struct_set_amp(void* struct_obj, double value_in);
void ac_kicker_freq_struct_get_phi(const void* struct_obj, double* value_out);
void ac_kicker_freq_struct_set_phi(void* struct_obj, double value_in);
void ac_kicker_freq_struct_get_rf_clock_harmonic(
    const void* struct_obj,
    int* value_out);
void ac_kicker_freq_struct_set_rf_clock_harmonic(
    void* struct_obj,
    int value_in);

void ac_kicker_struct_get_amp_vs_time_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ac_kicker_struct_get_frequency_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void interval1_coef_struct_get_c0(const void* struct_obj, double* value_out);
void interval1_coef_struct_set_c0(void* struct_obj, double value_in);
void interval1_coef_struct_get_c1(const void* struct_obj, double* value_out);
void interval1_coef_struct_set_c1(void* struct_obj, double value_in);
void interval1_coef_struct_get_n_exp(const void* struct_obj, double* value_out);
void interval1_coef_struct_set_n_exp(void* struct_obj, double value_in);
void photon_reflect_table_struct_get_angle_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void photon_reflect_table_struct_get_energy_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);

void photon_reflect_table_struct_get_int1_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void photon_reflect_table_struct_get_p_reflect_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void photon_reflect_table_struct_get_max_energy(
    const void* struct_obj,
    double* value_out);
void photon_reflect_table_struct_set_max_energy(
    void* struct_obj,
    double value_in);
void photon_reflect_table_struct_get_p_reflect_scratch_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void photon_reflect_table_struct_get_bragg_angle_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void photon_reflect_surface_struct_get_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void photon_reflect_surface_struct_set_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void photon_reflect_surface_struct_get_description_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void photon_reflect_surface_struct_set_description(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void photon_reflect_surface_struct_get_reflectivity_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void photon_reflect_surface_struct_set_reflectivity_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void photon_reflect_surface_struct_get_table_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void photon_reflect_surface_struct_get_surface_roughness_rms(
    const void* struct_obj,
    double* value_out);
void photon_reflect_surface_struct_set_surface_roughness_rms(
    void* struct_obj,
    double value_in);
void photon_reflect_surface_struct_get_roughness_correlation_len(
    const void* struct_obj,
    double* value_out);
void photon_reflect_surface_struct_set_roughness_correlation_len(
    void* struct_obj,
    double value_in);
void photon_reflect_surface_struct_get_ix_surface(
    const void* struct_obj,
    int* value_out);
void photon_reflect_surface_struct_set_ix_surface(
    void* struct_obj,
    int value_in);
void coord_struct_get_vec_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void coord_struct_get_s(const void* struct_obj, double* value_out);
void coord_struct_set_s(void* struct_obj, double value_in);
void coord_struct_get_t(const void* struct_obj, long double* value_out);
void coord_struct_set_t(void* struct_obj, long double value_in);
void coord_struct_get_spin_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void coord_struct_get_field_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void coord_struct_get_phase_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void coord_struct_get_charge(const void* struct_obj, double* value_out);
void coord_struct_set_charge(void* struct_obj, double value_in);
void coord_struct_get_dt_ref(const void* struct_obj, double* value_out);
void coord_struct_set_dt_ref(void* struct_obj, double value_in);
void coord_struct_get_r(const void* struct_obj, double* value_out);
void coord_struct_set_r(void* struct_obj, double value_in);
void coord_struct_get_p0c(const void* struct_obj, double* value_out);
void coord_struct_set_p0c(void* struct_obj, double value_in);
void coord_struct_get_E_potential(const void* struct_obj, double* value_out);
void coord_struct_set_E_potential(void* struct_obj, double value_in);
void coord_struct_get_beta(const void* struct_obj, double* value_out);
void coord_struct_set_beta(void* struct_obj, double value_in);
void coord_struct_get_ix_ele(const void* struct_obj, int* value_out);
void coord_struct_set_ix_ele(void* struct_obj, int value_in);
void coord_struct_get_ix_branch(const void* struct_obj, int* value_out);
void coord_struct_set_ix_branch(void* struct_obj, int value_in);
void coord_struct_get_ix_turn(const void* struct_obj, int* value_out);
void coord_struct_set_ix_turn(void* struct_obj, int value_in);
void coord_struct_get_ix_user(const void* struct_obj, int* value_out);
void coord_struct_set_ix_user(void* struct_obj, int value_in);
void coord_struct_get_state(const void* struct_obj, int* value_out);
void coord_struct_set_state(void* struct_obj, int value_in);
void coord_struct_get_direction(const void* struct_obj, int* value_out);
void coord_struct_set_direction(void* struct_obj, int value_in);
void coord_struct_get_time_dir(const void* struct_obj, int* value_out);
void coord_struct_set_time_dir(void* struct_obj, int value_in);
void coord_struct_get_species(const void* struct_obj, int* value_out);
void coord_struct_set_species(void* struct_obj, int value_in);
void coord_struct_get_location(const void* struct_obj, int* value_out);
void coord_struct_set_location(void* struct_obj, int value_in);

void coord_array_struct_get_orbit_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bpm_phase_coupling_struct_get_K_22a(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_K_22a(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_K_12a(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_K_12a(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_K_11b(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_K_11b(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_K_12b(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_K_12b(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_Cbar22_a(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_Cbar22_a(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_Cbar12_a(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_Cbar12_a(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_Cbar11_b(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_Cbar11_b(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_Cbar12_b(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_Cbar12_b(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_phi_a(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_phi_a(void* struct_obj, double value_in);
void bpm_phase_coupling_struct_get_phi_b(
    const void* struct_obj,
    double* value_out);
void bpm_phase_coupling_struct_set_phi_b(void* struct_obj, double value_in);
void expression_atom_struct_get_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void expression_atom_struct_set_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void expression_atom_struct_get_type(const void* struct_obj, int* value_out);
void expression_atom_struct_set_type(void* struct_obj, int value_in);
void expression_atom_struct_get_value(
    const void* struct_obj,
    double* value_out);
void expression_atom_struct_set_value(void* struct_obj, double value_in);
void wake_sr_z_long_struct_get_w_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void wake_sr_z_long_struct_get_fw_info(
    const void* s,
    std::complex<double>** d,
    int* bounds,
    bool* is_alloc);
void wake_sr_z_long_struct_get_fbunch_info(
    const void* s,
    std::complex<double>** d,
    int* bounds,
    bool* is_alloc);
void wake_sr_z_long_struct_get_w_out_info(
    const void* s,
    std::complex<double>** d,
    int* bounds,
    bool* is_alloc);
void wake_sr_z_long_struct_get_dz(const void* struct_obj, double* value_out);
void wake_sr_z_long_struct_set_dz(void* struct_obj, double value_in);
void wake_sr_z_long_struct_get_z0(const void* struct_obj, double* value_out);
void wake_sr_z_long_struct_set_z0(void* struct_obj, double value_in);
void wake_sr_z_long_struct_get_smoothing_sigma(
    const void* struct_obj,
    double* value_out);
void wake_sr_z_long_struct_set_smoothing_sigma(
    void* struct_obj,
    double value_in);
void wake_sr_z_long_struct_get_position_dependence(
    const void* struct_obj,
    int* value_out);
void wake_sr_z_long_struct_set_position_dependence(
    void* struct_obj,
    int value_in);
void wake_sr_z_long_struct_get_time_based(
    const void* struct_obj,
    bool* value_out);
void wake_sr_z_long_struct_set_time_based(void* struct_obj, bool value_in);
void wake_sr_mode_struct_get_amp(const void* struct_obj, double* value_out);
void wake_sr_mode_struct_set_amp(void* struct_obj, double value_in);
void wake_sr_mode_struct_get_damp(const void* struct_obj, double* value_out);
void wake_sr_mode_struct_set_damp(void* struct_obj, double value_in);
void wake_sr_mode_struct_get_k(const void* struct_obj, double* value_out);
void wake_sr_mode_struct_set_k(void* struct_obj, double value_in);
void wake_sr_mode_struct_get_phi(const void* struct_obj, double* value_out);
void wake_sr_mode_struct_set_phi(void* struct_obj, double value_in);
void wake_sr_mode_struct_get_b_sin(const void* struct_obj, double* value_out);
void wake_sr_mode_struct_set_b_sin(void* struct_obj, double value_in);
void wake_sr_mode_struct_get_b_cos(const void* struct_obj, double* value_out);
void wake_sr_mode_struct_set_b_cos(void* struct_obj, double value_in);
void wake_sr_mode_struct_get_a_sin(const void* struct_obj, double* value_out);
void wake_sr_mode_struct_set_a_sin(void* struct_obj, double value_in);
void wake_sr_mode_struct_get_a_cos(const void* struct_obj, double* value_out);
void wake_sr_mode_struct_set_a_cos(void* struct_obj, double value_in);
void wake_sr_mode_struct_get_polarization(
    const void* struct_obj,
    int* value_out);
void wake_sr_mode_struct_set_polarization(void* struct_obj, int value_in);
void wake_sr_mode_struct_get_position_dependence(
    const void* struct_obj,
    int* value_out);
void wake_sr_mode_struct_set_position_dependence(
    void* struct_obj,
    int value_in);
void wake_sr_struct_get_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void wake_sr_struct_set_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void wake_sr_struct_get_z_long(const void* struct_obj, void** ptr_out);
void wake_sr_struct_set_z_long(void* struct_obj, const void* src_ptr);

void wake_sr_struct_get_long_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void wake_sr_struct_get_trans_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void wake_sr_struct_get_z_ref_long(const void* struct_obj, double* value_out);
void wake_sr_struct_set_z_ref_long(void* struct_obj, double value_in);
void wake_sr_struct_get_z_ref_trans(const void* struct_obj, double* value_out);
void wake_sr_struct_set_z_ref_trans(void* struct_obj, double value_in);
void wake_sr_struct_get_z_max(const void* struct_obj, double* value_out);
void wake_sr_struct_set_z_max(void* struct_obj, double value_in);
void wake_sr_struct_get_amp_scale(const void* struct_obj, double* value_out);
void wake_sr_struct_set_amp_scale(void* struct_obj, double value_in);
void wake_sr_struct_get_z_scale(const void* struct_obj, double* value_out);
void wake_sr_struct_set_z_scale(void* struct_obj, double value_in);
void wake_sr_struct_get_scale_with_length(
    const void* struct_obj,
    bool* value_out);
void wake_sr_struct_set_scale_with_length(void* struct_obj, bool value_in);
void wake_lr_mode_struct_get_freq(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_freq(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_freq_in(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_freq_in(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_R_over_Q(
    const void* struct_obj,
    double* value_out);
void wake_lr_mode_struct_set_R_over_Q(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_Q(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_Q(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_damp(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_damp(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_phi(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_phi(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_angle(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_angle(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_b_sin(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_b_sin(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_b_cos(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_b_cos(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_a_sin(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_a_sin(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_a_cos(const void* struct_obj, double* value_out);
void wake_lr_mode_struct_set_a_cos(void* struct_obj, double value_in);
void wake_lr_mode_struct_get_m(const void* struct_obj, int* value_out);
void wake_lr_mode_struct_set_m(void* struct_obj, int value_in);
void wake_lr_mode_struct_get_polarized(const void* struct_obj, bool* value_out);
void wake_lr_mode_struct_set_polarized(void* struct_obj, bool value_in);
void wake_lr_struct_get_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void wake_lr_struct_set_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void wake_lr_struct_get_mode_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void wake_lr_struct_get_t_ref(const void* struct_obj, double* value_out);
void wake_lr_struct_set_t_ref(void* struct_obj, double value_in);
void wake_lr_struct_get_freq_spread(const void* struct_obj, double* value_out);
void wake_lr_struct_set_freq_spread(void* struct_obj, double value_in);
void wake_lr_struct_get_amp_scale(const void* struct_obj, double* value_out);
void wake_lr_struct_set_amp_scale(void* struct_obj, double value_in);
void wake_lr_struct_get_time_scale(const void* struct_obj, double* value_out);
void wake_lr_struct_set_time_scale(void* struct_obj, double value_in);
void wake_lr_struct_get_self_wake_on(const void* struct_obj, bool* value_out);
void wake_lr_struct_set_self_wake_on(void* struct_obj, bool value_in);
void lat_ele_loc_struct_get_ix_ele(const void* struct_obj, int* value_out);
void lat_ele_loc_struct_set_ix_ele(void* struct_obj, int value_in);
void lat_ele_loc_struct_get_ix_branch(const void* struct_obj, int* value_out);
void lat_ele_loc_struct_set_ix_branch(void* struct_obj, int value_in);
void wake_struct_get_sr(const void* struct_obj, void** ptr_out);
void wake_struct_set_sr(void* struct_obj, const void* src_ptr);
void wake_struct_get_lr(const void* struct_obj, void** ptr_out);
void wake_struct_set_lr(void* struct_obj, const void* src_ptr);
void taylor_term_struct_get_coef(const void* struct_obj, double* value_out);
void taylor_term_struct_set_coef(void* struct_obj, double value_in);
void taylor_term_struct_get_expn_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void taylor_struct_get_ref(const void* struct_obj, double* value_out);
void taylor_struct_set_ref(void* struct_obj, double value_in);

void taylor_struct_get_term_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void em_taylor_term_struct_get_coef(const void* struct_obj, double* value_out);
void em_taylor_term_struct_set_coef(void* struct_obj, double value_in);
void em_taylor_term_struct_get_expn_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void em_taylor_struct_get_ref(const void* struct_obj, double* value_out);
void em_taylor_struct_set_ref(void* struct_obj, double value_in);

void em_taylor_struct_get_term_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void cartesian_map_term1_struct_get_coef(
    const void* struct_obj,
    double* value_out);
void cartesian_map_term1_struct_set_coef(void* struct_obj, double value_in);
void cartesian_map_term1_struct_get_kx(
    const void* struct_obj,
    double* value_out);
void cartesian_map_term1_struct_set_kx(void* struct_obj, double value_in);
void cartesian_map_term1_struct_get_ky(
    const void* struct_obj,
    double* value_out);
void cartesian_map_term1_struct_set_ky(void* struct_obj, double value_in);
void cartesian_map_term1_struct_get_kz(
    const void* struct_obj,
    double* value_out);
void cartesian_map_term1_struct_set_kz(void* struct_obj, double value_in);
void cartesian_map_term1_struct_get_x0(
    const void* struct_obj,
    double* value_out);
void cartesian_map_term1_struct_set_x0(void* struct_obj, double value_in);
void cartesian_map_term1_struct_get_y0(
    const void* struct_obj,
    double* value_out);
void cartesian_map_term1_struct_set_y0(void* struct_obj, double value_in);
void cartesian_map_term1_struct_get_phi_z(
    const void* struct_obj,
    double* value_out);
void cartesian_map_term1_struct_set_phi_z(void* struct_obj, double value_in);
void cartesian_map_term1_struct_get_family(
    const void* struct_obj,
    int* value_out);
void cartesian_map_term1_struct_set_family(void* struct_obj, int value_in);
void cartesian_map_term1_struct_get_form(
    const void* struct_obj,
    int* value_out);
void cartesian_map_term1_struct_set_form(void* struct_obj, int value_in);
void cartesian_map_term_struct_get_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void cartesian_map_term_struct_set_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void cartesian_map_term_struct_get_n_link(
    const void* struct_obj,
    int* value_out);
void cartesian_map_term_struct_set_n_link(void* struct_obj, int value_in);

void cartesian_map_term_struct_get_term_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void cartesian_map_struct_get_field_scale(
    const void* struct_obj,
    double* value_out);
void cartesian_map_struct_set_field_scale(void* struct_obj, double value_in);
void cartesian_map_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void cartesian_map_struct_get_master_parameter(
    const void* struct_obj,
    int* value_out);
void cartesian_map_struct_set_master_parameter(void* struct_obj, int value_in);
void cartesian_map_struct_get_ele_anchor_pt(
    const void* struct_obj,
    int* value_out);
void cartesian_map_struct_set_ele_anchor_pt(void* struct_obj, int value_in);
void cartesian_map_struct_get_field_type(
    const void* struct_obj,
    int* value_out);
void cartesian_map_struct_set_field_type(void* struct_obj, int value_in);
void cartesian_map_struct_get_ptr(const void* struct_obj, void** ptr_out);
void cartesian_map_struct_set_ptr(void* struct_obj, const void* src_ptr);
void cylindrical_map_term1_struct_get_e_coef(
    const void* struct_obj,
    std::complex<double>* value_out);
void cylindrical_map_term1_struct_set_e_coef(
    void* struct_obj,
    std::complex<double> value_in);
void cylindrical_map_term1_struct_get_b_coef(
    const void* struct_obj,
    std::complex<double>* value_out);
void cylindrical_map_term1_struct_set_b_coef(
    void* struct_obj,
    std::complex<double> value_in);
void cylindrical_map_term_struct_get_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void cylindrical_map_term_struct_set_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void cylindrical_map_term_struct_get_n_link(
    const void* struct_obj,
    int* value_out);
void cylindrical_map_term_struct_set_n_link(void* struct_obj, int value_in);

void cylindrical_map_term_struct_get_term_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void cylindrical_map_struct_get_m(const void* struct_obj, int* value_out);
void cylindrical_map_struct_set_m(void* struct_obj, int value_in);
void cylindrical_map_struct_get_harmonic(
    const void* struct_obj,
    int* value_out);
void cylindrical_map_struct_set_harmonic(void* struct_obj, int value_in);
void cylindrical_map_struct_get_phi0_fieldmap(
    const void* struct_obj,
    double* value_out);
void cylindrical_map_struct_set_phi0_fieldmap(
    void* struct_obj,
    double value_in);
void cylindrical_map_struct_get_theta0_azimuth(
    const void* struct_obj,
    double* value_out);
void cylindrical_map_struct_set_theta0_azimuth(
    void* struct_obj,
    double value_in);
void cylindrical_map_struct_get_field_scale(
    const void* struct_obj,
    double* value_out);
void cylindrical_map_struct_set_field_scale(void* struct_obj, double value_in);
void cylindrical_map_struct_get_master_parameter(
    const void* struct_obj,
    int* value_out);
void cylindrical_map_struct_set_master_parameter(
    void* struct_obj,
    int value_in);
void cylindrical_map_struct_get_ele_anchor_pt(
    const void* struct_obj,
    int* value_out);
void cylindrical_map_struct_set_ele_anchor_pt(void* struct_obj, int value_in);
void cylindrical_map_struct_get_dz(const void* struct_obj, double* value_out);
void cylindrical_map_struct_set_dz(void* struct_obj, double value_in);
void cylindrical_map_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void cylindrical_map_struct_get_ptr(const void* struct_obj, void** ptr_out);
void cylindrical_map_struct_set_ptr(void* struct_obj, const void* src_ptr);
void bicubic_cmplx_coef_struct_get_coef_info(
    const void* s,
    std::complex<double>** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void bicubic_cmplx_coef_struct_get_i_box_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void tricubic_cmplx_coef_struct_get_coef_info(
    const void* s,
    std::complex<double>** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void tricubic_cmplx_coef_struct_get_i_box_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void grid_field_pt1_struct_get_E_info(
    const void* s,
    std::complex<double>** d,
    int* bounds,
    bool* is_alloc);
void grid_field_pt1_struct_get_B_info(
    const void* s,
    std::complex<double>** d,
    int* bounds,
    bool* is_alloc);
void grid_field_pt_struct_get_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void grid_field_pt_struct_set_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void grid_field_pt_struct_get_n_link(const void* struct_obj, int* value_out);
void grid_field_pt_struct_set_n_link(void* struct_obj, int value_in);

void grid_field_pt_struct_get_pt_info(
    const void* s,
    void** d,
    int* bounds,
    int* strides,
    bool* a,
    size_t* es);

void grid_field_struct_get_geometry(const void* struct_obj, int* value_out);
void grid_field_struct_set_geometry(void* struct_obj, int value_in);
void grid_field_struct_get_harmonic(const void* struct_obj, int* value_out);
void grid_field_struct_set_harmonic(void* struct_obj, int value_in);
void grid_field_struct_get_phi0_fieldmap(
    const void* struct_obj,
    double* value_out);
void grid_field_struct_set_phi0_fieldmap(void* struct_obj, double value_in);
void grid_field_struct_get_field_scale(
    const void* struct_obj,
    double* value_out);
void grid_field_struct_set_field_scale(void* struct_obj, double value_in);
void grid_field_struct_get_field_type(const void* struct_obj, int* value_out);
void grid_field_struct_set_field_type(void* struct_obj, int value_in);
void grid_field_struct_get_master_parameter(
    const void* struct_obj,
    int* value_out);
void grid_field_struct_set_master_parameter(void* struct_obj, int value_in);
void grid_field_struct_get_ele_anchor_pt(
    const void* struct_obj,
    int* value_out);
void grid_field_struct_set_ele_anchor_pt(void* struct_obj, int value_in);
void grid_field_struct_get_interpolation_order(
    const void* struct_obj,
    int* value_out);
void grid_field_struct_set_interpolation_order(void* struct_obj, int value_in);
void grid_field_struct_get_dr_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void grid_field_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void grid_field_struct_get_curved_ref_frame(
    const void* struct_obj,
    bool* value_out);
void grid_field_struct_set_curved_ref_frame(void* struct_obj, bool value_in);
void grid_field_struct_get_ptr(const void* struct_obj, void** ptr_out);
void grid_field_struct_set_ptr(void* struct_obj, const void* src_ptr);

void grid_field_struct_get_bi_coef_info(
    const void* s,
    void** d,
    int* bounds,
    int* strides,
    bool* a,
    size_t* es);

void grid_field_struct_get_tri_coef_info(
    const void* s,
    void** d,
    int* bounds,
    int* strides,
    bool* a,
    size_t* es);

void floor_position_struct_get_r_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void floor_position_struct_get_w_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void floor_position_struct_get_theta(const void* struct_obj, double* value_out);
void floor_position_struct_set_theta(void* struct_obj, double value_in);
void floor_position_struct_get_phi(const void* struct_obj, double* value_out);
void floor_position_struct_set_phi(void* struct_obj, double value_in);
void floor_position_struct_get_psi(const void* struct_obj, double* value_out);
void floor_position_struct_set_psi(void* struct_obj, double value_in);
void high_energy_space_charge_struct_get_closed_orb(
    const void* struct_obj,
    void** ptr_out);
void high_energy_space_charge_struct_set_closed_orb(
    void* struct_obj,
    const void* src_ptr);
void high_energy_space_charge_struct_get_kick_const(
    const void* struct_obj,
    double* value_out);
void high_energy_space_charge_struct_set_kick_const(
    void* struct_obj,
    double value_in);
void high_energy_space_charge_struct_get_sig_x(
    const void* struct_obj,
    double* value_out);
void high_energy_space_charge_struct_set_sig_x(
    void* struct_obj,
    double value_in);
void high_energy_space_charge_struct_get_sig_y(
    const void* struct_obj,
    double* value_out);
void high_energy_space_charge_struct_set_sig_y(
    void* struct_obj,
    double value_in);
void high_energy_space_charge_struct_get_phi(
    const void* struct_obj,
    double* value_out);
void high_energy_space_charge_struct_set_phi(void* struct_obj, double value_in);
void high_energy_space_charge_struct_get_sin_phi(
    const void* struct_obj,
    double* value_out);
void high_energy_space_charge_struct_set_sin_phi(
    void* struct_obj,
    double value_in);
void high_energy_space_charge_struct_get_cos_phi(
    const void* struct_obj,
    double* value_out);
void high_energy_space_charge_struct_set_cos_phi(
    void* struct_obj,
    double value_in);
void high_energy_space_charge_struct_get_sig_z(
    const void* struct_obj,
    double* value_out);
void high_energy_space_charge_struct_set_sig_z(
    void* struct_obj,
    double value_in);
void xy_disp_struct_get_eta(const void* struct_obj, double* value_out);
void xy_disp_struct_set_eta(void* struct_obj, double value_in);
void xy_disp_struct_get_etap(const void* struct_obj, double* value_out);
void xy_disp_struct_set_etap(void* struct_obj, double value_in);
void xy_disp_struct_get_deta_ds(const void* struct_obj, double* value_out);
void xy_disp_struct_set_deta_ds(void* struct_obj, double value_in);
void xy_disp_struct_get_sigma(const void* struct_obj, double* value_out);
void xy_disp_struct_set_sigma(void* struct_obj, double value_in);
void xy_disp_struct_get_deta_dpz(const void* struct_obj, double* value_out);
void xy_disp_struct_set_deta_dpz(void* struct_obj, double value_in);
void xy_disp_struct_get_detap_dpz(const void* struct_obj, double* value_out);
void xy_disp_struct_set_detap_dpz(void* struct_obj, double value_in);
void twiss_struct_get_beta(const void* struct_obj, double* value_out);
void twiss_struct_set_beta(void* struct_obj, double value_in);
void twiss_struct_get_alpha(const void* struct_obj, double* value_out);
void twiss_struct_set_alpha(void* struct_obj, double value_in);
void twiss_struct_get_gamma(const void* struct_obj, double* value_out);
void twiss_struct_set_gamma(void* struct_obj, double value_in);
void twiss_struct_get_phi(const void* struct_obj, double* value_out);
void twiss_struct_set_phi(void* struct_obj, double value_in);
void twiss_struct_get_eta(const void* struct_obj, double* value_out);
void twiss_struct_set_eta(void* struct_obj, double value_in);
void twiss_struct_get_etap(const void* struct_obj, double* value_out);
void twiss_struct_set_etap(void* struct_obj, double value_in);
void twiss_struct_get_deta_ds(const void* struct_obj, double* value_out);
void twiss_struct_set_deta_ds(void* struct_obj, double value_in);
void twiss_struct_get_sigma(const void* struct_obj, double* value_out);
void twiss_struct_set_sigma(void* struct_obj, double value_in);
void twiss_struct_get_sigma_p(const void* struct_obj, double* value_out);
void twiss_struct_set_sigma_p(void* struct_obj, double value_in);
void twiss_struct_get_emit(const void* struct_obj, double* value_out);
void twiss_struct_set_emit(void* struct_obj, double value_in);
void twiss_struct_get_norm_emit(const void* struct_obj, double* value_out);
void twiss_struct_set_norm_emit(void* struct_obj, double value_in);
void twiss_struct_get_chrom(const void* struct_obj, double* value_out);
void twiss_struct_set_chrom(void* struct_obj, double value_in);
void twiss_struct_get_dbeta_dpz(const void* struct_obj, double* value_out);
void twiss_struct_set_dbeta_dpz(void* struct_obj, double value_in);
void twiss_struct_get_dalpha_dpz(const void* struct_obj, double* value_out);
void twiss_struct_set_dalpha_dpz(void* struct_obj, double value_in);
void twiss_struct_get_deta_dpz(const void* struct_obj, double* value_out);
void twiss_struct_set_deta_dpz(void* struct_obj, double value_in);
void twiss_struct_get_detap_dpz(const void* struct_obj, double* value_out);
void twiss_struct_set_detap_dpz(void* struct_obj, double value_in);
void mode3_struct_get_v_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void mode3_struct_get_a(const void* struct_obj, void** ptr_out);
void mode3_struct_set_a(void* struct_obj, const void* src_ptr);
void mode3_struct_get_b(const void* struct_obj, void** ptr_out);
void mode3_struct_set_b(void* struct_obj, const void* src_ptr);
void mode3_struct_get_c(const void* struct_obj, void** ptr_out);
void mode3_struct_set_c(void* struct_obj, const void* src_ptr);
void mode3_struct_get_x(const void* struct_obj, void** ptr_out);
void mode3_struct_set_x(void* struct_obj, const void* src_ptr);
void mode3_struct_get_y(const void* struct_obj, void** ptr_out);
void mode3_struct_set_y(void* struct_obj, const void* src_ptr);
void bookkeeping_state_struct_get_attributes(
    const void* struct_obj,
    int* value_out);
void bookkeeping_state_struct_set_attributes(void* struct_obj, int value_in);
void bookkeeping_state_struct_get_control(
    const void* struct_obj,
    int* value_out);
void bookkeeping_state_struct_set_control(void* struct_obj, int value_in);
void bookkeeping_state_struct_get_floor_position(
    const void* struct_obj,
    int* value_out);
void bookkeeping_state_struct_set_floor_position(
    void* struct_obj,
    int value_in);
void bookkeeping_state_struct_get_s_position(
    const void* struct_obj,
    int* value_out);
void bookkeeping_state_struct_set_s_position(void* struct_obj, int value_in);
void bookkeeping_state_struct_get_ref_energy(
    const void* struct_obj,
    int* value_out);
void bookkeeping_state_struct_set_ref_energy(void* struct_obj, int value_in);
void bookkeeping_state_struct_get_mat6(const void* struct_obj, int* value_out);
void bookkeeping_state_struct_set_mat6(void* struct_obj, int value_in);
void bookkeeping_state_struct_get_rad_int(
    const void* struct_obj,
    int* value_out);
void bookkeeping_state_struct_set_rad_int(void* struct_obj, int value_in);
void bookkeeping_state_struct_get_ptc(const void* struct_obj, int* value_out);
void bookkeeping_state_struct_set_ptc(void* struct_obj, int value_in);
void bookkeeping_state_struct_get_has_misalign(
    const void* struct_obj,
    bool* value_out);
void bookkeeping_state_struct_set_has_misalign(void* struct_obj, bool value_in);
void rad_map_struct_get_ref_orb_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void rad_map_struct_get_damp_dmat_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void rad_map_struct_get_xfer_damp_vec_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void rad_map_struct_get_xfer_damp_mat_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void rad_map_struct_get_stoc_mat_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void rad_map_ele_struct_get_rm0(const void* struct_obj, void** ptr_out);
void rad_map_ele_struct_set_rm0(void* struct_obj, const void* src_ptr);
void rad_map_ele_struct_get_rm1(const void* struct_obj, void** ptr_out);
void rad_map_ele_struct_set_rm1(void* struct_obj, const void* src_ptr);
void rad_map_ele_struct_get_stale(const void* struct_obj, bool* value_out);
void rad_map_ele_struct_set_stale(void* struct_obj, bool value_in);
void gen_grad1_struct_get_m(const void* struct_obj, int* value_out);
void gen_grad1_struct_set_m(void* struct_obj, int value_in);
void gen_grad1_struct_get_sincos(const void* struct_obj, int* value_out);
void gen_grad1_struct_set_sincos(void* struct_obj, int value_in);
void gen_grad1_struct_get_n_deriv_max(const void* struct_obj, int* value_out);
void gen_grad1_struct_set_n_deriv_max(void* struct_obj, int value_in);
void gen_grad1_struct_get_deriv_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void gen_grad_map_struct_get_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void gen_grad_map_struct_set_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void gen_grad_map_struct_get_gg_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void gen_grad_map_struct_get_ele_anchor_pt(
    const void* struct_obj,
    int* value_out);
void gen_grad_map_struct_set_ele_anchor_pt(void* struct_obj, int value_in);
void gen_grad_map_struct_get_field_type(const void* struct_obj, int* value_out);
void gen_grad_map_struct_set_field_type(void* struct_obj, int value_in);
void gen_grad_map_struct_get_iz0(const void* struct_obj, int* value_out);
void gen_grad_map_struct_set_iz0(void* struct_obj, int value_in);
void gen_grad_map_struct_get_iz1(const void* struct_obj, int* value_out);
void gen_grad_map_struct_set_iz1(void* struct_obj, int value_in);
void gen_grad_map_struct_get_dz(const void* struct_obj, double* value_out);
void gen_grad_map_struct_set_dz(void* struct_obj, double value_in);
void gen_grad_map_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void gen_grad_map_struct_get_field_scale(
    const void* struct_obj,
    double* value_out);
void gen_grad_map_struct_set_field_scale(void* struct_obj, double value_in);
void gen_grad_map_struct_get_master_parameter(
    const void* struct_obj,
    int* value_out);
void gen_grad_map_struct_set_master_parameter(void* struct_obj, int value_in);
void gen_grad_map_struct_get_curved_ref_frame(
    const void* struct_obj,
    bool* value_out);
void gen_grad_map_struct_set_curved_ref_frame(void* struct_obj, bool value_in);
void surface_segmented_pt_struct_get_x0(
    const void* struct_obj,
    double* value_out);
void surface_segmented_pt_struct_set_x0(void* struct_obj, double value_in);
void surface_segmented_pt_struct_get_y0(
    const void* struct_obj,
    double* value_out);
void surface_segmented_pt_struct_set_y0(void* struct_obj, double value_in);
void surface_segmented_pt_struct_get_z0(
    const void* struct_obj,
    double* value_out);
void surface_segmented_pt_struct_set_z0(void* struct_obj, double value_in);
void surface_segmented_pt_struct_get_dz_dx(
    const void* struct_obj,
    double* value_out);
void surface_segmented_pt_struct_set_dz_dx(void* struct_obj, double value_in);
void surface_segmented_pt_struct_get_dz_dy(
    const void* struct_obj,
    double* value_out);
void surface_segmented_pt_struct_set_dz_dy(void* struct_obj, double value_in);
void surface_segmented_struct_get_active(
    const void* struct_obj,
    bool* value_out);
void surface_segmented_struct_set_active(void* struct_obj, bool value_in);
void surface_segmented_struct_get_dr_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void surface_segmented_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);

void surface_segmented_struct_get_pt_info(
    const void* s,
    void** d,
    int* bounds,
    int* strides,
    bool* a,
    size_t* es);

void surface_h_misalign_pt_struct_get_x0(
    const void* struct_obj,
    double* value_out);
void surface_h_misalign_pt_struct_set_x0(void* struct_obj, double value_in);
void surface_h_misalign_pt_struct_get_y0(
    const void* struct_obj,
    double* value_out);
void surface_h_misalign_pt_struct_set_y0(void* struct_obj, double value_in);
void surface_h_misalign_pt_struct_get_rot_y(
    const void* struct_obj,
    double* value_out);
void surface_h_misalign_pt_struct_set_rot_y(void* struct_obj, double value_in);
void surface_h_misalign_pt_struct_get_rot_t(
    const void* struct_obj,
    double* value_out);
void surface_h_misalign_pt_struct_set_rot_t(void* struct_obj, double value_in);
void surface_h_misalign_pt_struct_get_rot_y_rms(
    const void* struct_obj,
    double* value_out);
void surface_h_misalign_pt_struct_set_rot_y_rms(
    void* struct_obj,
    double value_in);
void surface_h_misalign_pt_struct_get_rot_t_rms(
    const void* struct_obj,
    double* value_out);
void surface_h_misalign_pt_struct_set_rot_t_rms(
    void* struct_obj,
    double value_in);
void surface_h_misalign_struct_get_active(
    const void* struct_obj,
    bool* value_out);
void surface_h_misalign_struct_set_active(void* struct_obj, bool value_in);
void surface_h_misalign_struct_get_dr_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void surface_h_misalign_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);

void surface_h_misalign_struct_get_pt_info(
    const void* s,
    void** d,
    int* bounds,
    int* strides,
    bool* a,
    size_t* es);

void surface_displacement_pt_struct_get_x0(
    const void* struct_obj,
    double* value_out);
void surface_displacement_pt_struct_set_x0(void* struct_obj, double value_in);
void surface_displacement_pt_struct_get_y0(
    const void* struct_obj,
    double* value_out);
void surface_displacement_pt_struct_set_y0(void* struct_obj, double value_in);
void surface_displacement_pt_struct_get_z0(
    const void* struct_obj,
    double* value_out);
void surface_displacement_pt_struct_set_z0(void* struct_obj, double value_in);
void surface_displacement_pt_struct_get_dz_dx(
    const void* struct_obj,
    double* value_out);
void surface_displacement_pt_struct_set_dz_dx(
    void* struct_obj,
    double value_in);
void surface_displacement_pt_struct_get_dz_dy(
    const void* struct_obj,
    double* value_out);
void surface_displacement_pt_struct_set_dz_dy(
    void* struct_obj,
    double value_in);
void surface_displacement_pt_struct_get_d2z_dxdy(
    const void* struct_obj,
    double* value_out);
void surface_displacement_pt_struct_set_d2z_dxdy(
    void* struct_obj,
    double value_in);
void surface_displacement_struct_get_active(
    const void* struct_obj,
    bool* value_out);
void surface_displacement_struct_set_active(void* struct_obj, bool value_in);
void surface_displacement_struct_get_dr_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void surface_displacement_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);

void surface_displacement_struct_get_pt_info(
    const void* s,
    void** d,
    int* bounds,
    int* strides,
    bool* a,
    size_t* es);

void target_point_struct_get_r_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void surface_curvature_struct_get_xy_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void surface_curvature_struct_get_spherical(
    const void* struct_obj,
    double* value_out);
void surface_curvature_struct_set_spherical(void* struct_obj, double value_in);
void surface_curvature_struct_get_elliptical_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void surface_curvature_struct_get_has_curvature(
    const void* struct_obj,
    bool* value_out);
void surface_curvature_struct_set_has_curvature(
    void* struct_obj,
    bool value_in);
void photon_target_struct_get_type(const void* struct_obj, int* value_out);
void photon_target_struct_set_type(void* struct_obj, int value_in);
void photon_target_struct_get_n_corner(const void* struct_obj, int* value_out);
void photon_target_struct_set_n_corner(void* struct_obj, int value_in);
void photon_target_struct_get_ele_loc(const void* struct_obj, void** ptr_out);
void photon_target_struct_set_ele_loc(void* struct_obj, const void* src_ptr);

void photon_target_struct_get_corner_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void photon_target_struct_get_center(const void* struct_obj, void** ptr_out);
void photon_target_struct_set_center(void* struct_obj, const void* src_ptr);
void photon_material_struct_get_f0_m1(
    const void* struct_obj,
    std::complex<double>* value_out);
void photon_material_struct_set_f0_m1(
    void* struct_obj,
    std::complex<double> value_in);
void photon_material_struct_get_f0_m2(
    const void* struct_obj,
    std::complex<double>* value_out);
void photon_material_struct_set_f0_m2(
    void* struct_obj,
    std::complex<double> value_in);
void photon_material_struct_get_f_0(
    const void* struct_obj,
    std::complex<double>* value_out);
void photon_material_struct_set_f_0(
    void* struct_obj,
    std::complex<double> value_in);
void photon_material_struct_get_f_h(
    const void* struct_obj,
    std::complex<double>* value_out);
void photon_material_struct_set_f_h(
    void* struct_obj,
    std::complex<double> value_in);
void photon_material_struct_get_f_hbar(
    const void* struct_obj,
    std::complex<double>* value_out);
void photon_material_struct_set_f_hbar(
    void* struct_obj,
    std::complex<double> value_in);
void photon_material_struct_get_f_hkl(
    const void* struct_obj,
    std::complex<double>* value_out);
void photon_material_struct_set_f_hkl(
    void* struct_obj,
    std::complex<double> value_in);
void photon_material_struct_get_h_norm_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void photon_material_struct_get_l_ref_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void pixel_pt_struct_get_n_photon(const void* struct_obj, long long* value_out);
void pixel_pt_struct_set_n_photon(void* struct_obj, long long value_in);
void pixel_pt_struct_get_E_x(
    const void* struct_obj,
    std::complex<double>* value_out);
void pixel_pt_struct_set_E_x(void* struct_obj, std::complex<double> value_in);
void pixel_pt_struct_get_E_y(
    const void* struct_obj,
    std::complex<double>* value_out);
void pixel_pt_struct_set_E_y(void* struct_obj, std::complex<double> value_in);
void pixel_pt_struct_get_intensity_x(const void* struct_obj, double* value_out);
void pixel_pt_struct_set_intensity_x(void* struct_obj, double value_in);
void pixel_pt_struct_get_intensity_y(const void* struct_obj, double* value_out);
void pixel_pt_struct_set_intensity_y(void* struct_obj, double value_in);
void pixel_pt_struct_get_intensity(const void* struct_obj, double* value_out);
void pixel_pt_struct_set_intensity(void* struct_obj, double value_in);
void pixel_pt_struct_get_orbit_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void pixel_pt_struct_get_orbit_rms_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void pixel_pt_struct_get_init_orbit_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void pixel_pt_struct_get_init_orbit_rms_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void pixel_detec_struct_get_dr_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void pixel_detec_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void pixel_detec_struct_get_n_track_tot(
    const void* struct_obj,
    long long* value_out);
void pixel_detec_struct_set_n_track_tot(void* struct_obj, long long value_in);
void pixel_detec_struct_get_n_hit_detec(
    const void* struct_obj,
    long long* value_out);
void pixel_detec_struct_set_n_hit_detec(void* struct_obj, long long value_in);
void pixel_detec_struct_get_n_hit_pixel(
    const void* struct_obj,
    long long* value_out);
void pixel_detec_struct_set_n_hit_pixel(void* struct_obj, long long value_in);

void pixel_detec_struct_get_pt_info(
    const void* s,
    void** d,
    int* bounds,
    int* strides,
    bool* a,
    size_t* es);

void photon_element_struct_get_curvature(
    const void* struct_obj,
    void** ptr_out);
void photon_element_struct_set_curvature(void* struct_obj, const void* src_ptr);
void photon_element_struct_get_target(const void* struct_obj, void** ptr_out);
void photon_element_struct_set_target(void* struct_obj, const void* src_ptr);
void photon_element_struct_get_material(const void* struct_obj, void** ptr_out);
void photon_element_struct_set_material(void* struct_obj, const void* src_ptr);
void photon_element_struct_get_segmented(
    const void* struct_obj,
    void** ptr_out);
void photon_element_struct_set_segmented(void* struct_obj, const void* src_ptr);
void photon_element_struct_get_h_misalign(
    const void* struct_obj,
    void** ptr_out);
void photon_element_struct_set_h_misalign(
    void* struct_obj,
    const void* src_ptr);
void photon_element_struct_get_displacement(
    const void* struct_obj,
    void** ptr_out);
void photon_element_struct_set_displacement(
    void* struct_obj,
    const void* src_ptr);
void photon_element_struct_get_pixel(const void* struct_obj, void** ptr_out);
void photon_element_struct_set_pixel(void* struct_obj, const void* src_ptr);
void photon_element_struct_get_reflectivity_table_type(
    const void* struct_obj,
    int* value_out);
void photon_element_struct_set_reflectivity_table_type(
    void* struct_obj,
    int value_in);
void photon_element_struct_get_reflectivity_table_sigma(
    const void* struct_obj,
    void** ptr_out);
void photon_element_struct_set_reflectivity_table_sigma(
    void* struct_obj,
    const void* src_ptr);
void photon_element_struct_get_reflectivity_table_pi(
    const void* struct_obj,
    void** ptr_out);
void photon_element_struct_set_reflectivity_table_pi(
    void* struct_obj,
    const void* src_ptr);

void photon_element_struct_get_init_energy_prob_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void photon_element_struct_get_integrated_init_energy_prob_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void wall3d_vertex_struct_get_x(const void* struct_obj, double* value_out);
void wall3d_vertex_struct_set_x(void* struct_obj, double value_in);
void wall3d_vertex_struct_get_y(const void* struct_obj, double* value_out);
void wall3d_vertex_struct_set_y(void* struct_obj, double value_in);
void wall3d_vertex_struct_get_radius_x(
    const void* struct_obj,
    double* value_out);
void wall3d_vertex_struct_set_radius_x(void* struct_obj, double value_in);
void wall3d_vertex_struct_get_radius_y(
    const void* struct_obj,
    double* value_out);
void wall3d_vertex_struct_set_radius_y(void* struct_obj, double value_in);
void wall3d_vertex_struct_get_tilt(const void* struct_obj, double* value_out);
void wall3d_vertex_struct_set_tilt(void* struct_obj, double value_in);
void wall3d_vertex_struct_get_angle(const void* struct_obj, double* value_out);
void wall3d_vertex_struct_set_angle(void* struct_obj, double value_in);
void wall3d_vertex_struct_get_x0(const void* struct_obj, double* value_out);
void wall3d_vertex_struct_set_x0(void* struct_obj, double value_in);
void wall3d_vertex_struct_get_y0(const void* struct_obj, double* value_out);
void wall3d_vertex_struct_set_y0(void* struct_obj, double value_in);
void wall3d_vertex_struct_get_type(const void* struct_obj, int* value_out);
void wall3d_vertex_struct_set_type(void* struct_obj, int value_in);
void wall3d_section_struct_get_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void wall3d_section_struct_set_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void wall3d_section_struct_get_material_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void wall3d_section_struct_set_material(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void wall3d_section_struct_get_v_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void wall3d_section_struct_get_surface(const void* struct_obj, void** ptr_out);
void wall3d_section_struct_set_surface(void* struct_obj, const void* src_ptr);
void wall3d_section_struct_get_type(const void* struct_obj, int* value_out);
void wall3d_section_struct_set_type(void* struct_obj, int value_in);
void wall3d_section_struct_get_n_vertex_input(
    const void* struct_obj,
    int* value_out);
void wall3d_section_struct_set_n_vertex_input(void* struct_obj, int value_in);
void wall3d_section_struct_get_ix_ele(const void* struct_obj, int* value_out);
void wall3d_section_struct_set_ix_ele(void* struct_obj, int value_in);
void wall3d_section_struct_get_ix_branch(
    const void* struct_obj,
    int* value_out);
void wall3d_section_struct_set_ix_branch(void* struct_obj, int value_in);
void wall3d_section_struct_get_vertices_state(
    const void* struct_obj,
    int* value_out);
void wall3d_section_struct_set_vertices_state(void* struct_obj, int value_in);
void wall3d_section_struct_get_patch_in_region(
    const void* struct_obj,
    bool* value_out);
void wall3d_section_struct_set_patch_in_region(void* struct_obj, bool value_in);
void wall3d_section_struct_get_thickness(
    const void* struct_obj,
    double* value_out);
void wall3d_section_struct_set_thickness(void* struct_obj, double value_in);
void wall3d_section_struct_get_s(const void* struct_obj, double* value_out);
void wall3d_section_struct_set_s(void* struct_obj, double value_in);
void wall3d_section_struct_get_r0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void wall3d_section_struct_get_dx0_ds(
    const void* struct_obj,
    double* value_out);
void wall3d_section_struct_set_dx0_ds(void* struct_obj, double value_in);
void wall3d_section_struct_get_dy0_ds(
    const void* struct_obj,
    double* value_out);
void wall3d_section_struct_set_dy0_ds(void* struct_obj, double value_in);
void wall3d_section_struct_get_x0_coef_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void wall3d_section_struct_get_y0_coef_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void wall3d_section_struct_get_dr_ds(const void* struct_obj, double* value_out);
void wall3d_section_struct_set_dr_ds(void* struct_obj, double value_in);
void wall3d_section_struct_get_p1_coef_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void wall3d_section_struct_get_p2_coef_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void wall3d_struct_get_name_info(const void* s, char** d, int* bounds, bool* a);
void wall3d_struct_set_name(void* struct_obj, const char* str_ptr, int str_len);
void wall3d_struct_get_type(const void* struct_obj, int* value_out);
void wall3d_struct_set_type(void* struct_obj, int value_in);
void wall3d_struct_get_ix_wall3d(const void* struct_obj, int* value_out);
void wall3d_struct_set_ix_wall3d(void* struct_obj, int value_in);
void wall3d_struct_get_n_link(const void* struct_obj, int* value_out);
void wall3d_struct_set_n_link(void* struct_obj, int value_in);
void wall3d_struct_get_thickness(const void* struct_obj, double* value_out);
void wall3d_struct_set_thickness(void* struct_obj, double value_in);
void wall3d_struct_get_clear_material_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void wall3d_struct_set_clear_material(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void wall3d_struct_get_opaque_material_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void wall3d_struct_set_opaque_material(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void wall3d_struct_get_superimpose(const void* struct_obj, bool* value_out);
void wall3d_struct_set_superimpose(void* struct_obj, bool value_in);
void wall3d_struct_get_ele_anchor_pt(const void* struct_obj, int* value_out);
void wall3d_struct_set_ele_anchor_pt(void* struct_obj, int value_in);

void wall3d_struct_get_section_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ramper_lord_struct_get_ix_ele(const void* struct_obj, int* value_out);
void ramper_lord_struct_set_ix_ele(void* struct_obj, int value_in);
void ramper_lord_struct_get_ix_con(const void* struct_obj, int* value_out);
void ramper_lord_struct_set_ix_con(void* struct_obj, int value_in);
void ramper_lord_struct_get_attrib_ptr(
    const void* struct_obj,
    double** ptr_out);
void ramper_lord_struct_set_attrib_ptr(void* struct_obj, double value_in);
void control_struct_get_value(const void* struct_obj, double* value_out);
void control_struct_set_value(void* struct_obj, double value_in);
void control_struct_get_y_knot_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);

void control_struct_get_stack_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void control_struct_get_slave(const void* struct_obj, void** ptr_out);
void control_struct_set_slave(void* struct_obj, const void* src_ptr);
void control_struct_get_lord(const void* struct_obj, void** ptr_out);
void control_struct_set_lord(void* struct_obj, const void* src_ptr);
void control_struct_get_slave_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void control_struct_set_slave_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void control_struct_get_attribute_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void control_struct_set_attribute(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void control_struct_get_ix_attrib(const void* struct_obj, int* value_out);
void control_struct_set_ix_attrib(void* struct_obj, int value_in);
void control_var1_struct_get_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void control_var1_struct_set_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void control_var1_struct_get_value(const void* struct_obj, double* value_out);
void control_var1_struct_set_value(void* struct_obj, double value_in);
void control_var1_struct_get_old_value(
    const void* struct_obj,
    double* value_out);
void control_var1_struct_set_old_value(void* struct_obj, double value_in);
void control_ramp1_struct_get_y_knot_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);

void control_ramp1_struct_get_stack_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void control_ramp1_struct_get_attribute_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void control_ramp1_struct_set_attribute(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void control_ramp1_struct_get_slave_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void control_ramp1_struct_set_slave_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void control_ramp1_struct_get_is_controller(
    const void* struct_obj,
    bool* value_out);
void control_ramp1_struct_set_is_controller(void* struct_obj, bool value_in);

void controller_struct_get_var_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void controller_struct_get_ramp_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void controller_struct_get_ramper_lord_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void controller_struct_get_x_knot_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ellipse_beam_init_struct_get_part_per_ellipse(
    const void* struct_obj,
    int* value_out);
void ellipse_beam_init_struct_set_part_per_ellipse(
    void* struct_obj,
    int value_in);
void ellipse_beam_init_struct_get_n_ellipse(
    const void* struct_obj,
    int* value_out);
void ellipse_beam_init_struct_set_n_ellipse(void* struct_obj, int value_in);
void ellipse_beam_init_struct_get_sigma_cutoff(
    const void* struct_obj,
    double* value_out);
void ellipse_beam_init_struct_set_sigma_cutoff(
    void* struct_obj,
    double value_in);
void kv_beam_init_struct_get_part_per_phi_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void kv_beam_init_struct_get_n_I2(const void* struct_obj, int* value_out);
void kv_beam_init_struct_set_n_I2(void* struct_obj, int value_in);
void kv_beam_init_struct_get_A(const void* struct_obj, double* value_out);
void kv_beam_init_struct_set_A(void* struct_obj, double value_in);
void grid_beam_init_struct_get_n_x(const void* struct_obj, int* value_out);
void grid_beam_init_struct_set_n_x(void* struct_obj, int value_in);
void grid_beam_init_struct_get_n_px(const void* struct_obj, int* value_out);
void grid_beam_init_struct_set_n_px(void* struct_obj, int value_in);
void grid_beam_init_struct_get_x_min(const void* struct_obj, double* value_out);
void grid_beam_init_struct_set_x_min(void* struct_obj, double value_in);
void grid_beam_init_struct_get_x_max(const void* struct_obj, double* value_out);
void grid_beam_init_struct_set_x_max(void* struct_obj, double value_in);
void grid_beam_init_struct_get_px_min(
    const void* struct_obj,
    double* value_out);
void grid_beam_init_struct_set_px_min(void* struct_obj, double value_in);
void grid_beam_init_struct_get_px_max(
    const void* struct_obj,
    double* value_out);
void grid_beam_init_struct_set_px_max(void* struct_obj, double value_in);
void beam_init_struct_get_position_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void beam_init_struct_set_position_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void beam_init_struct_get_distribution_type_info(
    const void* s,
    char** d,
    int* bounds, // [lower, upper]
    int* str_len,
    bool* is_alloc);

void beam_init_struct_get_spin_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);

void beam_init_struct_get_ellipse_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void beam_init_struct_get_KV(const void* struct_obj, void** ptr_out);
void beam_init_struct_set_KV(void* struct_obj, const void* src_ptr);

void beam_init_struct_get_grid_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void beam_init_struct_get_center_jitter_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void beam_init_struct_get_emit_jitter_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void beam_init_struct_get_sig_z_jitter(
    const void* struct_obj,
    double* value_out);
void beam_init_struct_set_sig_z_jitter(void* struct_obj, double value_in);
void beam_init_struct_get_sig_pz_jitter(
    const void* struct_obj,
    double* value_out);
void beam_init_struct_set_sig_pz_jitter(void* struct_obj, double value_in);
void beam_init_struct_get_n_particle(const void* struct_obj, int* value_out);
void beam_init_struct_set_n_particle(void* struct_obj, int value_in);
void beam_init_struct_get_renorm_center(
    const void* struct_obj,
    bool* value_out);
void beam_init_struct_set_renorm_center(void* struct_obj, bool value_in);
void beam_init_struct_get_renorm_sigma(const void* struct_obj, bool* value_out);
void beam_init_struct_set_renorm_sigma(void* struct_obj, bool value_in);
void beam_init_struct_get_random_engine_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void beam_init_struct_set_random_engine(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void beam_init_struct_get_random_gauss_converter_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void beam_init_struct_set_random_gauss_converter(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void beam_init_struct_get_random_sigma_cutoff(
    const void* struct_obj,
    double* value_out);
void beam_init_struct_set_random_sigma_cutoff(
    void* struct_obj,
    double value_in);
void beam_init_struct_get_a_norm_emit(
    const void* struct_obj,
    double* value_out);
void beam_init_struct_set_a_norm_emit(void* struct_obj, double value_in);
void beam_init_struct_get_b_norm_emit(
    const void* struct_obj,
    double* value_out);
void beam_init_struct_set_b_norm_emit(void* struct_obj, double value_in);
void beam_init_struct_get_a_emit(const void* struct_obj, double* value_out);
void beam_init_struct_set_a_emit(void* struct_obj, double value_in);
void beam_init_struct_get_b_emit(const void* struct_obj, double* value_out);
void beam_init_struct_set_b_emit(void* struct_obj, double value_in);
void beam_init_struct_get_dPz_dz(const void* struct_obj, double* value_out);
void beam_init_struct_set_dPz_dz(void* struct_obj, double value_in);
void beam_init_struct_get_center_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void beam_init_struct_get_t_offset(const void* struct_obj, double* value_out);
void beam_init_struct_set_t_offset(void* struct_obj, double value_in);
void beam_init_struct_get_dt_bunch(const void* struct_obj, double* value_out);
void beam_init_struct_set_dt_bunch(void* struct_obj, double value_in);
void beam_init_struct_get_sig_z(const void* struct_obj, double* value_out);
void beam_init_struct_set_sig_z(void* struct_obj, double value_in);
void beam_init_struct_get_sig_pz(const void* struct_obj, double* value_out);
void beam_init_struct_set_sig_pz(void* struct_obj, double value_in);
void beam_init_struct_get_bunch_charge(
    const void* struct_obj,
    double* value_out);
void beam_init_struct_set_bunch_charge(void* struct_obj, double value_in);
void beam_init_struct_get_n_bunch(const void* struct_obj, int* value_out);
void beam_init_struct_set_n_bunch(void* struct_obj, int value_in);
void beam_init_struct_get_ix_turn(const void* struct_obj, int* value_out);
void beam_init_struct_set_ix_turn(void* struct_obj, int value_in);
void beam_init_struct_get_species_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void beam_init_struct_set_species(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void beam_init_struct_get_full_6D_coupling_calc(
    const void* struct_obj,
    bool* value_out);
void beam_init_struct_set_full_6D_coupling_calc(
    void* struct_obj,
    bool value_in);
void beam_init_struct_get_use_particle_start(
    const void* struct_obj,
    bool* value_out);
void beam_init_struct_set_use_particle_start(void* struct_obj, bool value_in);
void beam_init_struct_get_use_t_coords(const void* struct_obj, bool* value_out);
void beam_init_struct_set_use_t_coords(void* struct_obj, bool value_in);
void beam_init_struct_get_use_z_as_t(const void* struct_obj, bool* value_out);
void beam_init_struct_set_use_z_as_t(void* struct_obj, bool value_in);
void beam_init_struct_get_file_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void beam_init_struct_set_file_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void lat_param_struct_get_n_part(const void* struct_obj, double* value_out);
void lat_param_struct_set_n_part(void* struct_obj, double value_in);
void lat_param_struct_get_total_length(
    const void* struct_obj,
    double* value_out);
void lat_param_struct_set_total_length(void* struct_obj, double value_in);
void lat_param_struct_get_unstable_factor(
    const void* struct_obj,
    double* value_out);
void lat_param_struct_set_unstable_factor(void* struct_obj, double value_in);
void lat_param_struct_get_t1_with_RF_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void lat_param_struct_get_t1_no_RF_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void lat_param_struct_get_spin_tune(const void* struct_obj, double* value_out);
void lat_param_struct_set_spin_tune(void* struct_obj, double value_in);
void lat_param_struct_get_particle(const void* struct_obj, int* value_out);
void lat_param_struct_set_particle(void* struct_obj, int value_in);
void lat_param_struct_get_default_tracking_species(
    const void* struct_obj,
    int* value_out);
void lat_param_struct_set_default_tracking_species(
    void* struct_obj,
    int value_in);
void lat_param_struct_get_geometry(const void* struct_obj, int* value_out);
void lat_param_struct_set_geometry(void* struct_obj, int value_in);
void lat_param_struct_get_ixx(const void* struct_obj, int* value_out);
void lat_param_struct_set_ixx(void* struct_obj, int value_in);
void lat_param_struct_get_stable(const void* struct_obj, bool* value_out);
void lat_param_struct_set_stable(void* struct_obj, bool value_in);
void lat_param_struct_get_live_branch(const void* struct_obj, bool* value_out);
void lat_param_struct_set_live_branch(void* struct_obj, bool value_in);
void lat_param_struct_get_g1_integral(
    const void* struct_obj,
    double* value_out);
void lat_param_struct_set_g1_integral(void* struct_obj, double value_in);
void lat_param_struct_get_g2_integral(
    const void* struct_obj,
    double* value_out);
void lat_param_struct_set_g2_integral(void* struct_obj, double value_in);
void lat_param_struct_get_g3_integral(
    const void* struct_obj,
    double* value_out);
void lat_param_struct_set_g3_integral(void* struct_obj, double value_in);
void lat_param_struct_get_bookkeeping_state(
    const void* struct_obj,
    void** ptr_out);
void lat_param_struct_set_bookkeeping_state(
    void* struct_obj,
    const void* src_ptr);
void lat_param_struct_get_beam_init(const void* struct_obj, void** ptr_out);
void lat_param_struct_set_beam_init(void* struct_obj, const void* src_ptr);
void mode_info_struct_get_stable(const void* struct_obj, bool* value_out);
void mode_info_struct_set_stable(void* struct_obj, bool value_in);
void mode_info_struct_get_tune(const void* struct_obj, double* value_out);
void mode_info_struct_set_tune(void* struct_obj, double value_in);
void mode_info_struct_get_emit(const void* struct_obj, double* value_out);
void mode_info_struct_set_emit(void* struct_obj, double value_in);
void mode_info_struct_get_chrom(const void* struct_obj, double* value_out);
void mode_info_struct_set_chrom(void* struct_obj, double value_in);
void mode_info_struct_get_sigma(const void* struct_obj, double* value_out);
void mode_info_struct_set_sigma(void* struct_obj, double value_in);
void mode_info_struct_get_sigmap(const void* struct_obj, double* value_out);
void mode_info_struct_set_sigmap(void* struct_obj, double value_in);
void pre_tracker_struct_get_who(const void* struct_obj, int* value_out);
void pre_tracker_struct_set_who(void* struct_obj, int value_in);
void pre_tracker_struct_get_ix_ele_start(
    const void* struct_obj,
    int* value_out);
void pre_tracker_struct_set_ix_ele_start(void* struct_obj, int value_in);
void pre_tracker_struct_get_ix_ele_end(const void* struct_obj, int* value_out);
void pre_tracker_struct_set_ix_ele_end(void* struct_obj, int value_in);
void pre_tracker_struct_get_input_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void pre_tracker_struct_set_input_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void anormal_mode_struct_get_emittance(
    const void* struct_obj,
    double* value_out);
void anormal_mode_struct_set_emittance(void* struct_obj, double value_in);
void anormal_mode_struct_get_emittance_no_vert(
    const void* struct_obj,
    double* value_out);
void anormal_mode_struct_set_emittance_no_vert(
    void* struct_obj,
    double value_in);
void anormal_mode_struct_get_synch_int_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void anormal_mode_struct_get_j_damp(const void* struct_obj, double* value_out);
void anormal_mode_struct_set_j_damp(void* struct_obj, double value_in);
void anormal_mode_struct_get_alpha_damp(
    const void* struct_obj,
    double* value_out);
void anormal_mode_struct_set_alpha_damp(void* struct_obj, double value_in);
void anormal_mode_struct_get_chrom(const void* struct_obj, double* value_out);
void anormal_mode_struct_set_chrom(void* struct_obj, double value_in);
void anormal_mode_struct_get_tune(const void* struct_obj, double* value_out);
void anormal_mode_struct_set_tune(void* struct_obj, double value_in);
void linac_normal_mode_struct_get_i2_E4(
    const void* struct_obj,
    double* value_out);
void linac_normal_mode_struct_set_i2_E4(void* struct_obj, double value_in);
void linac_normal_mode_struct_get_i3_E7(
    const void* struct_obj,
    double* value_out);
void linac_normal_mode_struct_set_i3_E7(void* struct_obj, double value_in);
void linac_normal_mode_struct_get_i5a_E6(
    const void* struct_obj,
    double* value_out);
void linac_normal_mode_struct_set_i5a_E6(void* struct_obj, double value_in);
void linac_normal_mode_struct_get_i5b_E6(
    const void* struct_obj,
    double* value_out);
void linac_normal_mode_struct_set_i5b_E6(void* struct_obj, double value_in);
void linac_normal_mode_struct_get_sig_E1(
    const void* struct_obj,
    double* value_out);
void linac_normal_mode_struct_set_sig_E1(void* struct_obj, double value_in);
void linac_normal_mode_struct_get_a_emittance_end(
    const void* struct_obj,
    double* value_out);
void linac_normal_mode_struct_set_a_emittance_end(
    void* struct_obj,
    double value_in);
void linac_normal_mode_struct_get_b_emittance_end(
    const void* struct_obj,
    double* value_out);
void linac_normal_mode_struct_set_b_emittance_end(
    void* struct_obj,
    double value_in);
void normal_modes_struct_get_synch_int_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void normal_modes_struct_get_sigE_E(const void* struct_obj, double* value_out);
void normal_modes_struct_set_sigE_E(void* struct_obj, double value_in);
void normal_modes_struct_get_sig_z(const void* struct_obj, double* value_out);
void normal_modes_struct_set_sig_z(void* struct_obj, double value_in);
void normal_modes_struct_get_e_loss(const void* struct_obj, double* value_out);
void normal_modes_struct_set_e_loss(void* struct_obj, double value_in);
void normal_modes_struct_get_rf_voltage(
    const void* struct_obj,
    double* value_out);
void normal_modes_struct_set_rf_voltage(void* struct_obj, double value_in);
void normal_modes_struct_get_pz_aperture(
    const void* struct_obj,
    double* value_out);
void normal_modes_struct_set_pz_aperture(void* struct_obj, double value_in);
void normal_modes_struct_get_pz_average(
    const void* struct_obj,
    double* value_out);
void normal_modes_struct_set_pz_average(void* struct_obj, double value_in);
void normal_modes_struct_get_momentum_compaction(
    const void* struct_obj,
    double* value_out);
void normal_modes_struct_set_momentum_compaction(
    void* struct_obj,
    double value_in);
void normal_modes_struct_get_dpz_damp(
    const void* struct_obj,
    double* value_out);
void normal_modes_struct_set_dpz_damp(void* struct_obj, double value_in);
void normal_modes_struct_get_a(const void* struct_obj, void** ptr_out);
void normal_modes_struct_set_a(void* struct_obj, const void* src_ptr);
void normal_modes_struct_get_b(const void* struct_obj, void** ptr_out);
void normal_modes_struct_set_b(void* struct_obj, const void* src_ptr);
void normal_modes_struct_get_z(const void* struct_obj, void** ptr_out);
void normal_modes_struct_set_z(void* struct_obj, const void* src_ptr);
void normal_modes_struct_get_lin(const void* struct_obj, void** ptr_out);
void normal_modes_struct_set_lin(void* struct_obj, const void* src_ptr);
void em_field_struct_get_E_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void em_field_struct_get_B_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void em_field_struct_get_dE_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void em_field_struct_get_dB_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void em_field_struct_get_phi(const void* struct_obj, double* value_out);
void em_field_struct_set_phi(void* struct_obj, double value_in);
void em_field_struct_get_phi_B(const void* struct_obj, double* value_out);
void em_field_struct_set_phi_B(void* struct_obj, double value_in);
void em_field_struct_get_A_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void strong_beam_struct_get_ix_slice(const void* struct_obj, int* value_out);
void strong_beam_struct_set_ix_slice(void* struct_obj, int value_in);
void strong_beam_struct_get_x_center(const void* struct_obj, double* value_out);
void strong_beam_struct_set_x_center(void* struct_obj, double value_in);
void strong_beam_struct_get_y_center(const void* struct_obj, double* value_out);
void strong_beam_struct_set_y_center(void* struct_obj, double value_in);
void strong_beam_struct_get_x_sigma(const void* struct_obj, double* value_out);
void strong_beam_struct_set_x_sigma(void* struct_obj, double value_in);
void strong_beam_struct_get_y_sigma(const void* struct_obj, double* value_out);
void strong_beam_struct_set_y_sigma(void* struct_obj, double value_in);
void strong_beam_struct_get_dx(const void* struct_obj, double* value_out);
void strong_beam_struct_set_dx(void* struct_obj, double value_in);
void strong_beam_struct_get_dy(const void* struct_obj, double* value_out);
void strong_beam_struct_set_dy(void* struct_obj, double value_in);
void track_point_struct_get_s_lab(const void* struct_obj, double* value_out);
void track_point_struct_set_s_lab(void* struct_obj, double value_in);
void track_point_struct_get_s_body(const void* struct_obj, double* value_out);
void track_point_struct_set_s_body(void* struct_obj, double value_in);
void track_point_struct_get_orb(const void* struct_obj, void** ptr_out);
void track_point_struct_set_orb(void* struct_obj, const void* src_ptr);
void track_point_struct_get_field(const void* struct_obj, void** ptr_out);
void track_point_struct_set_field(void* struct_obj, const void* src_ptr);
void track_point_struct_get_strong_beam(const void* struct_obj, void** ptr_out);
void track_point_struct_set_strong_beam(void* struct_obj, const void* src_ptr);
void track_point_struct_get_vec0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void track_point_struct_get_mat6_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);

void track_struct_get_pt_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void track_struct_get_ds_save(const void* struct_obj, double* value_out);
void track_struct_set_ds_save(void* struct_obj, double value_in);
void track_struct_get_n_pt(const void* struct_obj, int* value_out);
void track_struct_set_n_pt(void* struct_obj, int value_in);
void track_struct_get_n_bad(const void* struct_obj, int* value_out);
void track_struct_set_n_bad(void* struct_obj, int value_in);
void track_struct_get_n_ok(const void* struct_obj, int* value_out);
void track_struct_set_n_ok(void* struct_obj, int value_in);
void space_charge_common_struct_get_ds_track_step(
    const void* struct_obj,
    double* value_out);
void space_charge_common_struct_set_ds_track_step(
    void* struct_obj,
    double value_in);
void space_charge_common_struct_get_dt_track_step(
    const void* struct_obj,
    double* value_out);
void space_charge_common_struct_set_dt_track_step(
    void* struct_obj,
    double value_in);
void space_charge_common_struct_get_cathode_strength_cutoff(
    const void* struct_obj,
    double* value_out);
void space_charge_common_struct_set_cathode_strength_cutoff(
    void* struct_obj,
    double value_in);
void space_charge_common_struct_get_rel_tol_tracking(
    const void* struct_obj,
    double* value_out);
void space_charge_common_struct_set_rel_tol_tracking(
    void* struct_obj,
    double value_in);
void space_charge_common_struct_get_abs_tol_tracking(
    const void* struct_obj,
    double* value_out);
void space_charge_common_struct_set_abs_tol_tracking(
    void* struct_obj,
    double value_in);
void space_charge_common_struct_get_beam_chamber_height(
    const void* struct_obj,
    double* value_out);
void space_charge_common_struct_set_beam_chamber_height(
    void* struct_obj,
    double value_in);
void space_charge_common_struct_get_lsc_sigma_cutoff(
    const void* struct_obj,
    double* value_out);
void space_charge_common_struct_set_lsc_sigma_cutoff(
    void* struct_obj,
    double value_in);
void space_charge_common_struct_get_particle_sigma_cutoff(
    const void* struct_obj,
    double* value_out);
void space_charge_common_struct_set_particle_sigma_cutoff(
    void* struct_obj,
    double value_in);
void space_charge_common_struct_get_space_charge_mesh_size_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void space_charge_common_struct_get_csr3d_mesh_size_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void space_charge_common_struct_get_n_bin(
    const void* struct_obj,
    int* value_out);
void space_charge_common_struct_set_n_bin(void* struct_obj, int value_in);
void space_charge_common_struct_get_particle_bin_span(
    const void* struct_obj,
    int* value_out);
void space_charge_common_struct_set_particle_bin_span(
    void* struct_obj,
    int value_in);
void space_charge_common_struct_get_n_shield_images(
    const void* struct_obj,
    int* value_out);
void space_charge_common_struct_set_n_shield_images(
    void* struct_obj,
    int value_in);
void space_charge_common_struct_get_sc_min_in_bin(
    const void* struct_obj,
    int* value_out);
void space_charge_common_struct_set_sc_min_in_bin(
    void* struct_obj,
    int value_in);
void space_charge_common_struct_get_lsc_kick_transverse_dependence(
    const void* struct_obj,
    bool* value_out);
void space_charge_common_struct_set_lsc_kick_transverse_dependence(
    void* struct_obj,
    bool value_in);
void space_charge_common_struct_get_debug(
    const void* struct_obj,
    bool* value_out);
void space_charge_common_struct_set_debug(void* struct_obj, bool value_in);
void space_charge_common_struct_get_diagnostic_output_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void space_charge_common_struct_set_diagnostic_output_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void bmad_common_struct_get_max_aperture_limit(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_max_aperture_limit(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_d_orb_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void bmad_common_struct_get_default_ds_step(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_default_ds_step(void* struct_obj, double value_in);
void bmad_common_struct_get_significant_length(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_significant_length(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_rel_tol_tracking(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_rel_tol_tracking(void* struct_obj, double value_in);
void bmad_common_struct_get_abs_tol_tracking(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_abs_tol_tracking(void* struct_obj, double value_in);
void bmad_common_struct_get_rel_tol_adaptive_tracking(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_rel_tol_adaptive_tracking(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_abs_tol_adaptive_tracking(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_abs_tol_adaptive_tracking(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_init_ds_adaptive_tracking(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_init_ds_adaptive_tracking(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_min_ds_adaptive_tracking(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_min_ds_adaptive_tracking(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_fatal_ds_adaptive_tracking(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_fatal_ds_adaptive_tracking(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_autoscale_amp_abs_tol(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_autoscale_amp_abs_tol(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_autoscale_amp_rel_tol(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_autoscale_amp_rel_tol(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_autoscale_phase_tol(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_autoscale_phase_tol(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_electric_dipole_moment(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_electric_dipole_moment(
    void* struct_obj,
    double value_in);
void bmad_common_struct_get_synch_rad_scale(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_synch_rad_scale(void* struct_obj, double value_in);
void bmad_common_struct_get_sad_eps_scale(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_sad_eps_scale(void* struct_obj, double value_in);
void bmad_common_struct_get_sad_amp_max(
    const void* struct_obj,
    double* value_out);
void bmad_common_struct_set_sad_amp_max(void* struct_obj, double value_in);
void bmad_common_struct_get_sad_n_div_max(
    const void* struct_obj,
    int* value_out);
void bmad_common_struct_set_sad_n_div_max(void* struct_obj, int value_in);
void bmad_common_struct_get_taylor_order(
    const void* struct_obj,
    int* value_out);
void bmad_common_struct_set_taylor_order(void* struct_obj, int value_in);
void bmad_common_struct_get_runge_kutta_order(
    const void* struct_obj,
    int* value_out);
void bmad_common_struct_set_runge_kutta_order(void* struct_obj, int value_in);
void bmad_common_struct_get_default_integ_order(
    const void* struct_obj,
    int* value_out);
void bmad_common_struct_set_default_integ_order(void* struct_obj, int value_in);
void bmad_common_struct_get_max_num_runge_kutta_step(
    const void* struct_obj,
    int* value_out);
void bmad_common_struct_set_max_num_runge_kutta_step(
    void* struct_obj,
    int value_in);
void bmad_common_struct_get_rf_phase_below_transition_ref(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_rf_phase_below_transition_ref(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_sr_wakes_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_sr_wakes_on(void* struct_obj, bool value_in);
void bmad_common_struct_get_lr_wakes_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_lr_wakes_on(void* struct_obj, bool value_in);
void bmad_common_struct_get_auto_bookkeeper(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_auto_bookkeeper(void* struct_obj, bool value_in);
void bmad_common_struct_get_high_energy_space_charge_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_high_energy_space_charge_on(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_csr_and_space_charge_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_csr_and_space_charge_on(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_spin_tracking_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_spin_tracking_on(void* struct_obj, bool value_in);
void bmad_common_struct_get_spin_sokolov_ternov_flipping_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_spin_sokolov_ternov_flipping_on(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_radiation_damping_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_radiation_damping_on(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_radiation_zero_average(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_radiation_zero_average(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_radiation_fluctuations_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_radiation_fluctuations_on(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_conserve_taylor_maps(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_conserve_taylor_maps(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_absolute_time_tracking(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_absolute_time_tracking(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_absolute_time_ref_shift(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_absolute_time_ref_shift(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_convert_to_kinetic_momentum(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_convert_to_kinetic_momentum(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_normalize_twiss(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_normalize_twiss(void* struct_obj, bool value_in);
void bmad_common_struct_get_aperture_limit_on(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_aperture_limit_on(void* struct_obj, bool value_in);
void bmad_common_struct_get_spin_n0_direction_user_set(
    const void* struct_obj,
    bool* value_out);
void bmad_common_struct_set_spin_n0_direction_user_set(
    void* struct_obj,
    bool value_in);
void bmad_common_struct_get_debug(const void* struct_obj, bool* value_out);
void bmad_common_struct_set_debug(void* struct_obj, bool value_in);
void rad_int1_struct_get_i0(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i0(void* struct_obj, double value_in);
void rad_int1_struct_get_i1(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i1(void* struct_obj, double value_in);
void rad_int1_struct_get_i2(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i2(void* struct_obj, double value_in);
void rad_int1_struct_get_i3(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i3(void* struct_obj, double value_in);
void rad_int1_struct_get_i4a(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i4a(void* struct_obj, double value_in);
void rad_int1_struct_get_i4b(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i4b(void* struct_obj, double value_in);
void rad_int1_struct_get_i4z(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i4z(void* struct_obj, double value_in);
void rad_int1_struct_get_i5a(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i5a(void* struct_obj, double value_in);
void rad_int1_struct_get_i5b(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i5b(void* struct_obj, double value_in);
void rad_int1_struct_get_i6b(const void* struct_obj, double* value_out);
void rad_int1_struct_set_i6b(void* struct_obj, double value_in);
void rad_int1_struct_get_lin_i2_E4(const void* struct_obj, double* value_out);
void rad_int1_struct_set_lin_i2_E4(void* struct_obj, double value_in);
void rad_int1_struct_get_lin_i3_E7(const void* struct_obj, double* value_out);
void rad_int1_struct_set_lin_i3_E7(void* struct_obj, double value_in);
void rad_int1_struct_get_lin_i5a_E6(const void* struct_obj, double* value_out);
void rad_int1_struct_set_lin_i5a_E6(void* struct_obj, double value_in);
void rad_int1_struct_get_lin_i5b_E6(const void* struct_obj, double* value_out);
void rad_int1_struct_set_lin_i5b_E6(void* struct_obj, double value_in);
void rad_int1_struct_get_lin_norm_emit_a(
    const void* struct_obj,
    double* value_out);
void rad_int1_struct_set_lin_norm_emit_a(void* struct_obj, double value_in);
void rad_int1_struct_get_lin_norm_emit_b(
    const void* struct_obj,
    double* value_out);
void rad_int1_struct_set_lin_norm_emit_b(void* struct_obj, double value_in);
void rad_int1_struct_get_lin_sig_E(const void* struct_obj, double* value_out);
void rad_int1_struct_set_lin_sig_E(void* struct_obj, double value_in);
void rad_int1_struct_get_n_steps(const void* struct_obj, double* value_out);
void rad_int1_struct_set_n_steps(void* struct_obj, double value_in);

void rad_int_branch_struct_get_ele_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void rad_int_all_ele_struct_get_branch_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void rf_stair_step_struct_get_E_tot0(const void* struct_obj, double* value_out);
void rf_stair_step_struct_set_E_tot0(void* struct_obj, double value_in);
void rf_stair_step_struct_get_E_tot1(const void* struct_obj, double* value_out);
void rf_stair_step_struct_set_E_tot1(void* struct_obj, double value_in);
void rf_stair_step_struct_get_p0c(const void* struct_obj, double* value_out);
void rf_stair_step_struct_set_p0c(void* struct_obj, double value_in);
void rf_stair_step_struct_get_p1c(const void* struct_obj, double* value_out);
void rf_stair_step_struct_set_p1c(void* struct_obj, double value_in);
void rf_stair_step_struct_get_dE_amp(const void* struct_obj, double* value_out);
void rf_stair_step_struct_set_dE_amp(void* struct_obj, double value_in);
void rf_stair_step_struct_get_scale(const void* struct_obj, double* value_out);
void rf_stair_step_struct_set_scale(void* struct_obj, double value_in);
void rf_stair_step_struct_get_time(const void* struct_obj, double* value_out);
void rf_stair_step_struct_set_time(void* struct_obj, double value_in);
void rf_stair_step_struct_get_s(const void* struct_obj, double* value_out);
void rf_stair_step_struct_set_s(void* struct_obj, double value_in);
void rf_stair_step_struct_get_ix_step(const void* struct_obj, int* value_out);
void rf_stair_step_struct_set_ix_step(void* struct_obj, int value_in);

void rf_ele_struct_get_steps_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void rf_ele_struct_get_ds_step(const void* struct_obj, double* value_out);
void rf_ele_struct_set_ds_step(void* struct_obj, double value_in);
void ele_struct_get_name_info(const void* s, char** d, int* bounds, bool* a);
void ele_struct_set_name(void* struct_obj, const char* str_ptr, int str_len);
void ele_struct_get_type_info(const void* s, char** d, int* bounds, bool* a);
void ele_struct_set_type(void* struct_obj, const char* str_ptr, int str_len);
void ele_struct_get_alias_info(const void* s, char** d, int* bounds, bool* a);
void ele_struct_set_alias(void* struct_obj, const char* str_ptr, int str_len);
void ele_struct_get_component_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void ele_struct_set_component_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void ele_struct_get_descrip_info(
    const void* s,
    char** d,
    int* len,
    bool* is_alloc);

void ele_struct_set_descrip(void* struct_obj, const char* str_ptr, int str_len);
void ele_struct_get_a(const void* struct_obj, void** ptr_out);
void ele_struct_set_a(void* struct_obj, const void* src_ptr);
void ele_struct_get_b(const void* struct_obj, void** ptr_out);
void ele_struct_set_b(void* struct_obj, const void* src_ptr);
void ele_struct_get_z(const void* struct_obj, void** ptr_out);
void ele_struct_set_z(void* struct_obj, const void* src_ptr);
void ele_struct_get_x(const void* struct_obj, void** ptr_out);
void ele_struct_set_x(void* struct_obj, const void* src_ptr);
void ele_struct_get_y(const void* struct_obj, void** ptr_out);
void ele_struct_set_y(void* struct_obj, const void* src_ptr);
void ele_struct_get_ac_kick(const void* struct_obj, void** ptr_out);
void ele_struct_set_ac_kick(void* struct_obj, const void* src_ptr);
void ele_struct_get_bookkeeping_state(const void* struct_obj, void** ptr_out);
void ele_struct_set_bookkeeping_state(void* struct_obj, const void* src_ptr);
void ele_struct_get_branch(const void* struct_obj, void** ptr_out);
void ele_struct_set_branch(void* struct_obj, const void* src_ptr);
void ele_struct_get_control(const void* struct_obj, void** ptr_out);
void ele_struct_set_control(void* struct_obj, const void* src_ptr);
void ele_struct_get_rf(const void* struct_obj, void** ptr_out);
void ele_struct_set_rf(void* struct_obj, const void* src_ptr);
void ele_struct_get_lord(const void* struct_obj, void** ptr_out);
void ele_struct_set_lord(void* struct_obj, const void* src_ptr);
void ele_struct_get_floor(const void* struct_obj, void** ptr_out);
void ele_struct_set_floor(void* struct_obj, const void* src_ptr);
void ele_struct_get_high_energy_space_charge(
    const void* struct_obj,
    void** ptr_out);
void ele_struct_set_high_energy_space_charge(
    void* struct_obj,
    const void* src_ptr);
void ele_struct_get_mode3(const void* struct_obj, void** ptr_out);
void ele_struct_set_mode3(void* struct_obj, const void* src_ptr);
void ele_struct_get_photon(const void* struct_obj, void** ptr_out);
void ele_struct_set_photon(void* struct_obj, const void* src_ptr);
void ele_struct_get_rad_map(const void* struct_obj, void** ptr_out);
void ele_struct_set_rad_map(void* struct_obj, const void* src_ptr);

void ele_struct_get_taylor_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ele_struct_get_spin_taylor_ref_orb_in_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);

void ele_struct_get_spin_taylor_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ele_struct_get_wake(const void* struct_obj, void** ptr_out);
void ele_struct_set_wake(void* struct_obj, const void* src_ptr);

void ele_struct_get_wall3d_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ele_struct_get_cartesian_map_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ele_struct_get_cylindrical_map_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ele_struct_get_gen_grad_map_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ele_struct_get_grid_field_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void ele_struct_get_map_ref_orb_in(const void* struct_obj, void** ptr_out);
void ele_struct_set_map_ref_orb_in(void* struct_obj, const void* src_ptr);
void ele_struct_get_map_ref_orb_out(const void* struct_obj, void** ptr_out);
void ele_struct_set_map_ref_orb_out(void* struct_obj, const void* src_ptr);
void ele_struct_get_time_ref_orb_in(const void* struct_obj, void** ptr_out);
void ele_struct_set_time_ref_orb_in(void* struct_obj, const void* src_ptr);
void ele_struct_get_time_ref_orb_out(const void* struct_obj, void** ptr_out);
void ele_struct_set_time_ref_orb_out(void* struct_obj, const void* src_ptr);
void ele_struct_get_value_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ele_struct_get_old_value_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ele_struct_get_spin_q_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void ele_struct_get_vec0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ele_struct_get_mat6_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void ele_struct_get_c_mat_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void ele_struct_get_gamma_c(const void* struct_obj, double* value_out);
void ele_struct_set_gamma_c(void* struct_obj, double value_in);
void ele_struct_get_s_start(const void* struct_obj, double* value_out);
void ele_struct_set_s_start(void* struct_obj, double value_in);
void ele_struct_get_s(const void* struct_obj, double* value_out);
void ele_struct_set_s(void* struct_obj, double value_in);
void ele_struct_get_ref_time(const void* struct_obj, double* value_out);
void ele_struct_set_ref_time(void* struct_obj, double value_in);
void ele_struct_get_a_pole_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ele_struct_get_b_pole_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ele_struct_get_a_pole_elec_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ele_struct_get_b_pole_elec_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ele_struct_get_custom_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ele_struct_get_r_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void ele_struct_get_key(const void* struct_obj, int* value_out);
void ele_struct_set_key(void* struct_obj, int value_in);
void ele_struct_get_sub_key(const void* struct_obj, int* value_out);
void ele_struct_set_sub_key(void* struct_obj, int value_in);
void ele_struct_get_ix_ele(const void* struct_obj, int* value_out);
void ele_struct_set_ix_ele(void* struct_obj, int value_in);
void ele_struct_get_ix_branch(const void* struct_obj, int* value_out);
void ele_struct_set_ix_branch(void* struct_obj, int value_in);
void ele_struct_get_lord_status(const void* struct_obj, int* value_out);
void ele_struct_set_lord_status(void* struct_obj, int value_in);
void ele_struct_get_n_slave(const void* struct_obj, int* value_out);
void ele_struct_set_n_slave(void* struct_obj, int value_in);
void ele_struct_get_n_slave_field(const void* struct_obj, int* value_out);
void ele_struct_set_n_slave_field(void* struct_obj, int value_in);
void ele_struct_get_ix1_slave(const void* struct_obj, int* value_out);
void ele_struct_set_ix1_slave(void* struct_obj, int value_in);
void ele_struct_get_slave_status(const void* struct_obj, int* value_out);
void ele_struct_set_slave_status(void* struct_obj, int value_in);
void ele_struct_get_n_lord(const void* struct_obj, int* value_out);
void ele_struct_set_n_lord(void* struct_obj, int value_in);
void ele_struct_get_n_lord_field(const void* struct_obj, int* value_out);
void ele_struct_set_n_lord_field(void* struct_obj, int value_in);
void ele_struct_get_n_lord_ramper(const void* struct_obj, int* value_out);
void ele_struct_set_n_lord_ramper(void* struct_obj, int value_in);
void ele_struct_get_ic1_lord(const void* struct_obj, int* value_out);
void ele_struct_set_ic1_lord(void* struct_obj, int value_in);
void ele_struct_get_ix_pointer(const void* struct_obj, int* value_out);
void ele_struct_set_ix_pointer(void* struct_obj, int value_in);
void ele_struct_get_ixx(const void* struct_obj, int* value_out);
void ele_struct_set_ixx(void* struct_obj, int value_in);
void ele_struct_get_iyy(const void* struct_obj, int* value_out);
void ele_struct_set_iyy(void* struct_obj, int value_in);
void ele_struct_get_izz(const void* struct_obj, int* value_out);
void ele_struct_set_izz(void* struct_obj, int value_in);
void ele_struct_get_mat6_calc_method(const void* struct_obj, int* value_out);
void ele_struct_set_mat6_calc_method(void* struct_obj, int value_in);
void ele_struct_get_tracking_method(const void* struct_obj, int* value_out);
void ele_struct_set_tracking_method(void* struct_obj, int value_in);
void ele_struct_get_spin_tracking_method(
    const void* struct_obj,
    int* value_out);
void ele_struct_set_spin_tracking_method(void* struct_obj, int value_in);
void ele_struct_get_csr_method(const void* struct_obj, int* value_out);
void ele_struct_set_csr_method(void* struct_obj, int value_in);
void ele_struct_get_space_charge_method(const void* struct_obj, int* value_out);
void ele_struct_set_space_charge_method(void* struct_obj, int value_in);
void ele_struct_get_ptc_integration_type(
    const void* struct_obj,
    int* value_out);
void ele_struct_set_ptc_integration_type(void* struct_obj, int value_in);
void ele_struct_get_field_calc(const void* struct_obj, int* value_out);
void ele_struct_set_field_calc(void* struct_obj, int value_in);
void ele_struct_get_aperture_at(const void* struct_obj, int* value_out);
void ele_struct_set_aperture_at(void* struct_obj, int value_in);
void ele_struct_get_aperture_type(const void* struct_obj, int* value_out);
void ele_struct_set_aperture_type(void* struct_obj, int value_in);
void ele_struct_get_ref_species(const void* struct_obj, int* value_out);
void ele_struct_set_ref_species(void* struct_obj, int value_in);
void ele_struct_get_orientation(const void* struct_obj, int* value_out);
void ele_struct_set_orientation(void* struct_obj, int value_in);
void ele_struct_get_symplectify(const void* struct_obj, bool* value_out);
void ele_struct_set_symplectify(void* struct_obj, bool value_in);
void ele_struct_get_mode_flip(const void* struct_obj, bool* value_out);
void ele_struct_set_mode_flip(void* struct_obj, bool value_in);
void ele_struct_get_multipoles_on(const void* struct_obj, bool* value_out);
void ele_struct_set_multipoles_on(void* struct_obj, bool value_in);
void ele_struct_get_scale_multipoles(const void* struct_obj, bool* value_out);
void ele_struct_set_scale_multipoles(void* struct_obj, bool value_in);
void ele_struct_get_taylor_map_includes_offsets(
    const void* struct_obj,
    bool* value_out);
void ele_struct_set_taylor_map_includes_offsets(
    void* struct_obj,
    bool value_in);
void ele_struct_get_field_master(const void* struct_obj, bool* value_out);
void ele_struct_set_field_master(void* struct_obj, bool value_in);
void ele_struct_get_is_on(const void* struct_obj, bool* value_out);
void ele_struct_set_is_on(void* struct_obj, bool value_in);
void ele_struct_get_logic(const void* struct_obj, bool* value_out);
void ele_struct_set_logic(void* struct_obj, bool value_in);
void ele_struct_get_bmad_logic(const void* struct_obj, bool* value_out);
void ele_struct_set_bmad_logic(void* struct_obj, bool value_in);
void ele_struct_get_select(const void* struct_obj, bool* value_out);
void ele_struct_set_select(void* struct_obj, bool value_in);
void ele_struct_get_offset_moves_aperture(
    const void* struct_obj,
    bool* value_out);
void ele_struct_set_offset_moves_aperture(void* struct_obj, bool value_in);
void complex_taylor_term_struct_get_coef(
    const void* struct_obj,
    std::complex<double>* value_out);
void complex_taylor_term_struct_set_coef(
    void* struct_obj,
    std::complex<double> value_in);
void complex_taylor_term_struct_get_expn_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void complex_taylor_struct_get_ref(
    const void* struct_obj,
    std::complex<double>* value_out);
void complex_taylor_struct_set_ref(
    void* struct_obj,
    std::complex<double> value_in);

void complex_taylor_struct_get_term_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void branch_struct_get_name_info(const void* s, char** d, int* bounds, bool* a);
void branch_struct_set_name(void* struct_obj, const char* str_ptr, int str_len);
void branch_struct_get_ix_branch(const void* struct_obj, int* value_out);
void branch_struct_set_ix_branch(void* struct_obj, int value_in);
void branch_struct_get_ix_from_branch(const void* struct_obj, int* value_out);
void branch_struct_set_ix_from_branch(void* struct_obj, int value_in);
void branch_struct_get_ix_from_ele(const void* struct_obj, int* value_out);
void branch_struct_set_ix_from_ele(void* struct_obj, int value_in);
void branch_struct_get_ix_to_ele(const void* struct_obj, int* value_out);
void branch_struct_set_ix_to_ele(void* struct_obj, int value_in);
void branch_struct_get_ix_fixer(const void* struct_obj, int* value_out);
void branch_struct_set_ix_fixer(void* struct_obj, int value_in);
void branch_struct_get_n_ele_track(const void* struct_obj, int* value_out);
void branch_struct_set_n_ele_track(void* struct_obj, int value_in);
void branch_struct_get_n_ele_max(const void* struct_obj, int* value_out);
void branch_struct_set_n_ele_max(void* struct_obj, int value_in);
void branch_struct_get_lat(const void* struct_obj, void** ptr_out);
void branch_struct_set_lat(void* struct_obj, const void* src_ptr);
void branch_struct_get_a(const void* struct_obj, void** ptr_out);
void branch_struct_set_a(void* struct_obj, const void* src_ptr);
void branch_struct_get_b(const void* struct_obj, void** ptr_out);
void branch_struct_set_b(void* struct_obj, const void* src_ptr);
void branch_struct_get_z(const void* struct_obj, void** ptr_out);
void branch_struct_set_z(void* struct_obj, const void* src_ptr);

void branch_struct_get_ele_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void branch_struct_get_param(const void* struct_obj, void** ptr_out);
void branch_struct_set_param(void* struct_obj, const void* src_ptr);
void branch_struct_get_particle_start(const void* struct_obj, void** ptr_out);
void branch_struct_set_particle_start(void* struct_obj, const void* src_ptr);

void branch_struct_get_wall3d_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void lat_struct_get_use_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void lat_struct_set_use_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void lat_struct_get_lattice_info(const void* s, char** d, int* bounds, bool* a);
void lat_struct_set_lattice(void* struct_obj, const char* str_ptr, int str_len);
void lat_struct_get_machine_info(const void* s, char** d, int* bounds, bool* a);
void lat_struct_set_machine(void* struct_obj, const char* str_ptr, int str_len);
void lat_struct_get_input_file_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void lat_struct_set_input_file_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void lat_struct_get_title_info(const void* s, char** d, int* bounds, bool* a);
void lat_struct_set_title(void* struct_obj, const char* str_ptr, int str_len);

void lat_struct_get_print_str_info(
    const void* s,
    char** d,
    int* bounds, // [lower, upper]
    int* str_len,
    bool* is_alloc);

void lat_struct_get_constant_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void lat_struct_get_a(const void* struct_obj, void** ptr_out);
void lat_struct_set_a(void* struct_obj, const void* src_ptr);
void lat_struct_get_b(const void* struct_obj, void** ptr_out);
void lat_struct_set_b(void* struct_obj, const void* src_ptr);
void lat_struct_get_z(const void* struct_obj, void** ptr_out);
void lat_struct_set_z(void* struct_obj, const void* src_ptr);
void lat_struct_get_param(const void* struct_obj, void** ptr_out);
void lat_struct_set_param(void* struct_obj, const void* src_ptr);
void lat_struct_get_lord_state(const void* struct_obj, void** ptr_out);
void lat_struct_set_lord_state(void* struct_obj, const void* src_ptr);
void lat_struct_get_ele_init(const void* struct_obj, void** ptr_out);
void lat_struct_set_ele_init(void* struct_obj, const void* src_ptr);

void lat_struct_get_ele_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void lat_struct_get_branch_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void lat_struct_get_control_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void lat_struct_get_particle_start(const void* struct_obj, void** ptr_out);
void lat_struct_set_particle_start(void* struct_obj, const void* src_ptr);
void lat_struct_get_beam_init(const void* struct_obj, void** ptr_out);
void lat_struct_set_beam_init(void* struct_obj, const void* src_ptr);
void lat_struct_get_pre_tracker(const void* struct_obj, void** ptr_out);
void lat_struct_set_pre_tracker(void* struct_obj, const void* src_ptr);
void lat_struct_get_custom_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void lat_struct_get_version(const void* struct_obj, int* value_out);
void lat_struct_set_version(void* struct_obj, int value_in);
void lat_struct_get_n_ele_track(const void* struct_obj, int** ptr_out);
void lat_struct_set_n_ele_track(void* struct_obj, int value_in);
void lat_struct_get_n_ele_max(const void* struct_obj, int** ptr_out);
void lat_struct_set_n_ele_max(void* struct_obj, int value_in);
void lat_struct_get_n_control_max(const void* struct_obj, int* value_out);
void lat_struct_set_n_control_max(void* struct_obj, int value_in);
void lat_struct_get_n_ic_max(const void* struct_obj, int* value_out);
void lat_struct_set_n_ic_max(void* struct_obj, int value_in);
void lat_struct_get_input_taylor_order(const void* struct_obj, int* value_out);
void lat_struct_set_input_taylor_order(void* struct_obj, int value_in);
void lat_struct_get_ic_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void lat_struct_get_photon_type(const void* struct_obj, int* value_out);
void lat_struct_set_photon_type(void* struct_obj, int value_in);
void lat_struct_get_creation_hash(const void* struct_obj, int* value_out);
void lat_struct_set_creation_hash(void* struct_obj, int value_in);
void lat_struct_get_ramper_slave_bookkeeping(
    const void* struct_obj,
    int* value_out);
void lat_struct_set_ramper_slave_bookkeeping(void* struct_obj, int value_in);

void bunch_struct_get_particle_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bunch_struct_get_ix_z_info(
    const void* s,
    int** d,
    int* bounds,
    bool* is_alloc);
void bunch_struct_get_charge_tot(const void* struct_obj, double* value_out);
void bunch_struct_set_charge_tot(void* struct_obj, double value_in);
void bunch_struct_get_charge_live(const void* struct_obj, double* value_out);
void bunch_struct_set_charge_live(void* struct_obj, double value_in);
void bunch_struct_get_z_center(const void* struct_obj, double* value_out);
void bunch_struct_set_z_center(void* struct_obj, double value_in);
void bunch_struct_get_t_center(const void* struct_obj, double* value_out);
void bunch_struct_set_t_center(void* struct_obj, double value_in);
void bunch_struct_get_t0(const void* struct_obj, double* value_out);
void bunch_struct_set_t0(void* struct_obj, double value_in);
void bunch_struct_get_drift_between_t_and_s(
    const void* struct_obj,
    bool* value_out);
void bunch_struct_set_drift_between_t_and_s(void* struct_obj, bool value_in);
void bunch_struct_get_ix_ele(const void* struct_obj, int* value_out);
void bunch_struct_set_ix_ele(void* struct_obj, int value_in);
void bunch_struct_get_ix_bunch(const void* struct_obj, int* value_out);
void bunch_struct_set_ix_bunch(void* struct_obj, int value_in);
void bunch_struct_get_ix_turn(const void* struct_obj, int* value_out);
void bunch_struct_set_ix_turn(void* struct_obj, int value_in);
void bunch_struct_get_n_live(const void* struct_obj, int* value_out);
void bunch_struct_set_n_live(void* struct_obj, int value_in);
void bunch_struct_get_n_good(const void* struct_obj, int* value_out);
void bunch_struct_set_n_good(void* struct_obj, int value_in);
void bunch_struct_get_n_bad(const void* struct_obj, int* value_out);
void bunch_struct_set_n_bad(void* struct_obj, int value_in);
void bunch_params_struct_get_centroid(const void* struct_obj, void** ptr_out);
void bunch_params_struct_set_centroid(void* struct_obj, const void* src_ptr);
void bunch_params_struct_get_x(const void* struct_obj, void** ptr_out);
void bunch_params_struct_set_x(void* struct_obj, const void* src_ptr);
void bunch_params_struct_get_y(const void* struct_obj, void** ptr_out);
void bunch_params_struct_set_y(void* struct_obj, const void* src_ptr);
void bunch_params_struct_get_z(const void* struct_obj, void** ptr_out);
void bunch_params_struct_set_z(void* struct_obj, const void* src_ptr);
void bunch_params_struct_get_a(const void* struct_obj, void** ptr_out);
void bunch_params_struct_set_a(void* struct_obj, const void* src_ptr);
void bunch_params_struct_get_b(const void* struct_obj, void** ptr_out);
void bunch_params_struct_set_b(void* struct_obj, const void* src_ptr);
void bunch_params_struct_get_c(const void* struct_obj, void** ptr_out);
void bunch_params_struct_set_c(void* struct_obj, const void* src_ptr);
void bunch_params_struct_get_sigma_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void bunch_params_struct_get_rel_max_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void bunch_params_struct_get_rel_min_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void bunch_params_struct_get_s(const void* struct_obj, double* value_out);
void bunch_params_struct_set_s(void* struct_obj, double value_in);
void bunch_params_struct_get_t(const void* struct_obj, double* value_out);
void bunch_params_struct_set_t(void* struct_obj, double value_in);
void bunch_params_struct_get_sigma_t(const void* struct_obj, double* value_out);
void bunch_params_struct_set_sigma_t(void* struct_obj, double value_in);
void bunch_params_struct_get_charge_live(
    const void* struct_obj,
    double* value_out);
void bunch_params_struct_set_charge_live(void* struct_obj, double value_in);
void bunch_params_struct_get_charge_tot(
    const void* struct_obj,
    double* value_out);
void bunch_params_struct_set_charge_tot(void* struct_obj, double value_in);
void bunch_params_struct_get_n_particle_tot(
    const void* struct_obj,
    int* value_out);
void bunch_params_struct_set_n_particle_tot(void* struct_obj, int value_in);
void bunch_params_struct_get_n_particle_live(
    const void* struct_obj,
    int* value_out);
void bunch_params_struct_set_n_particle_live(void* struct_obj, int value_in);
void bunch_params_struct_get_n_particle_lost_in_ele(
    const void* struct_obj,
    int* value_out);
void bunch_params_struct_set_n_particle_lost_in_ele(
    void* struct_obj,
    int value_in);
void bunch_params_struct_get_n_good_steps(
    const void* struct_obj,
    int* value_out);
void bunch_params_struct_set_n_good_steps(void* struct_obj, int value_in);
void bunch_params_struct_get_n_bad_steps(
    const void* struct_obj,
    int* value_out);
void bunch_params_struct_set_n_bad_steps(void* struct_obj, int value_in);
void bunch_params_struct_get_ix_ele(const void* struct_obj, int* value_out);
void bunch_params_struct_set_ix_ele(void* struct_obj, int value_in);
void bunch_params_struct_get_location(const void* struct_obj, int* value_out);
void bunch_params_struct_set_location(void* struct_obj, int value_in);
void bunch_params_struct_get_twiss_valid(
    const void* struct_obj,
    bool* value_out);
void bunch_params_struct_set_twiss_valid(void* struct_obj, bool value_in);

void beam_struct_get_bunch_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void aperture_point_struct_get_x(const void* struct_obj, double* value_out);
void aperture_point_struct_set_x(void* struct_obj, double value_in);
void aperture_point_struct_get_y(const void* struct_obj, double* value_out);
void aperture_point_struct_set_y(void* struct_obj, double value_in);
void aperture_point_struct_get_plane(const void* struct_obj, int* value_out);
void aperture_point_struct_set_plane(void* struct_obj, int value_in);
void aperture_point_struct_get_ix_ele(const void* struct_obj, int* value_out);
void aperture_point_struct_set_ix_ele(void* struct_obj, int value_in);
void aperture_point_struct_get_i_turn(const void* struct_obj, int* value_out);
void aperture_point_struct_set_i_turn(void* struct_obj, int value_in);
void aperture_param_struct_get_min_angle(
    const void* struct_obj,
    double* value_out);
void aperture_param_struct_set_min_angle(void* struct_obj, double value_in);
void aperture_param_struct_get_max_angle(
    const void* struct_obj,
    double* value_out);
void aperture_param_struct_set_max_angle(void* struct_obj, double value_in);
void aperture_param_struct_get_n_angle(const void* struct_obj, int* value_out);
void aperture_param_struct_set_n_angle(void* struct_obj, int value_in);
void aperture_param_struct_get_n_turn(const void* struct_obj, int* value_out);
void aperture_param_struct_set_n_turn(void* struct_obj, int value_in);
void aperture_param_struct_get_x_init(
    const void* struct_obj,
    double* value_out);
void aperture_param_struct_set_x_init(void* struct_obj, double value_in);
void aperture_param_struct_get_y_init(
    const void* struct_obj,
    double* value_out);
void aperture_param_struct_set_y_init(void* struct_obj, double value_in);
void aperture_param_struct_get_rel_accuracy(
    const void* struct_obj,
    double* value_out);
void aperture_param_struct_set_rel_accuracy(void* struct_obj, double value_in);
void aperture_param_struct_get_abs_accuracy(
    const void* struct_obj,
    double* value_out);
void aperture_param_struct_set_abs_accuracy(void* struct_obj, double value_in);
void aperture_param_struct_get_start_ele_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void aperture_param_struct_set_start_ele(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void aperture_scan_struct_get_point_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void aperture_scan_struct_get_ref_orb(const void* struct_obj, void** ptr_out);
void aperture_scan_struct_set_ref_orb(void* struct_obj, const void* src_ptr);
void aperture_scan_struct_get_pz_start(
    const void* struct_obj,
    double* value_out);
void aperture_scan_struct_set_pz_start(void* struct_obj, double value_in);
void tao_spin_dn_dpz_struct_get_vec_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void tao_spin_dn_dpz_struct_get_partial_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void tao_spin_dn_dpz_struct_get_partial2_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void resonance_h_struct_get_id_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void resonance_h_struct_set_id(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void resonance_h_struct_get_c_val(
    const void* struct_obj,
    std::complex<double>* value_out);
void resonance_h_struct_set_c_val(
    void* struct_obj,
    std::complex<double> value_in);
void spin_orbit_map1_struct_get_orb_mat_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void spin_orbit_map1_struct_get_vec0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void spin_orbit_map1_struct_get_spin_q_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void spin_axis_struct_get_l_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void spin_axis_struct_get_n0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void spin_axis_struct_get_m_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ptc_normal_form_struct_get_ele_origin(
    const void* struct_obj,
    void** ptr_out);
void ptc_normal_form_struct_set_ele_origin(
    void* struct_obj,
    const void* src_ptr);
void ptc_normal_form_struct_get_orb0_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void ptc_normal_form_struct_get_valid_map(
    const void* struct_obj,
    bool* value_out);
void ptc_normal_form_struct_set_valid_map(void* struct_obj, bool value_in);
void bmad_normal_form_struct_get_ele_origin(
    const void* struct_obj,
    void** ptr_out);
void bmad_normal_form_struct_set_ele_origin(
    void* struct_obj,
    const void* src_ptr);

void bmad_normal_form_struct_get_M_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bmad_normal_form_struct_get_A_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bmad_normal_form_struct_get_A_inv_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bmad_normal_form_struct_get_dhdj_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bmad_normal_form_struct_get_F_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bmad_normal_form_struct_get_L_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bmad_normal_form_struct_get_h_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bunch_track_struct_get_pt_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void bunch_track_struct_get_ds_save(const void* struct_obj, double* value_out);
void bunch_track_struct_set_ds_save(void* struct_obj, double value_in);
void bunch_track_struct_get_n_pt(const void* struct_obj, int* value_out);
void bunch_track_struct_set_n_pt(void* struct_obj, int value_in);
void summation_rdt_struct_get_h11001(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h11001(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h00111(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h00111(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h20001(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h20001(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h00201(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h00201(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h10002(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h10002(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h21000(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h21000(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h30000(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h30000(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h10110(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h10110(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h10020(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h10020(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h10200(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h10200(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h31000(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h31000(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h40000(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h40000(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h20110(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h20110(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h11200(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h11200(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h20020(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h20020(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h20200(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h20200(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h00310(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h00310(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h00400(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h00400(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h22000(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h22000(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h00220(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h00220(
    void* struct_obj,
    std::complex<double> value_in);
void summation_rdt_struct_get_h11110(
    const void* struct_obj,
    std::complex<double>* value_out);
void summation_rdt_struct_set_h11110(
    void* struct_obj,
    std::complex<double> value_in);
void lat_ele_order1_struct_get_ix_branch(
    const void* struct_obj,
    int* value_out);
void lat_ele_order1_struct_set_ix_branch(void* struct_obj, int value_in);
void lat_ele_order1_struct_get_ix_order(const void* struct_obj, int* value_out);
void lat_ele_order1_struct_set_ix_order(void* struct_obj, int value_in);

void lat_ele_order_array_struct_get_ele_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lat_sigma_struct_get_mat_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void tao_spin_ele_struct_get_dn_dpz(const void* struct_obj, void** ptr_out);
void tao_spin_ele_struct_set_dn_dpz(void* struct_obj, const void* src_ptr);
void tao_spin_ele_struct_get_orb_eigen_val_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void tao_spin_ele_struct_get_orb_eigen_vec_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void tao_spin_ele_struct_get_spin_eigen_vec_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void tao_spin_ele_struct_get_valid(const void* struct_obj, bool* value_out);
void tao_spin_ele_struct_set_valid(void* struct_obj, bool value_in);
void tao_plot_cache_struct_get_ele_to_s(const void* struct_obj, void** ptr_out);
void tao_plot_cache_struct_set_ele_to_s(void* struct_obj, const void* src_ptr);
void tao_plot_cache_struct_get_orbit(const void* struct_obj, void** ptr_out);
void tao_plot_cache_struct_set_orbit(void* struct_obj, const void* src_ptr);
void tao_plot_cache_struct_get_err(const void* struct_obj, bool* value_out);
void tao_plot_cache_struct_set_err(void* struct_obj, bool value_in);
void tao_spin_polarization_struct_get_tune(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_tune(void* struct_obj, double value_in);
void tao_spin_polarization_struct_get_pol_limit_st(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_pol_limit_st(
    void* struct_obj,
    double value_in);
void tao_spin_polarization_struct_get_pol_limit_dk(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_pol_limit_dk(
    void* struct_obj,
    double value_in);
void tao_spin_polarization_struct_get_pol_limit_dk_partial_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void tao_spin_polarization_struct_get_pol_limit_dk_partial2_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void tao_spin_polarization_struct_get_pol_rate_bks(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_pol_rate_bks(
    void* struct_obj,
    double value_in);
void tao_spin_polarization_struct_get_depol_rate(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_depol_rate(
    void* struct_obj,
    double value_in);
void tao_spin_polarization_struct_get_depol_rate_partial_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void tao_spin_polarization_struct_get_depol_rate_partial2_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void tao_spin_polarization_struct_get_integral_bn(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_integral_bn(
    void* struct_obj,
    double value_in);
void tao_spin_polarization_struct_get_integral_bdn(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_integral_bdn(
    void* struct_obj,
    double value_in);
void tao_spin_polarization_struct_get_integral_1ns(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_integral_1ns(
    void* struct_obj,
    double value_in);
void tao_spin_polarization_struct_get_integral_dn2(
    const void* struct_obj,
    double* value_out);
void tao_spin_polarization_struct_set_integral_dn2(
    void* struct_obj,
    double value_in);
void tao_spin_polarization_struct_get_valid(
    const void* struct_obj,
    bool* value_out);
void tao_spin_polarization_struct_set_valid(void* struct_obj, bool value_in);
void tao_spin_polarization_struct_get_q_1turn(
    const void* struct_obj,
    void** ptr_out);
void tao_spin_polarization_struct_set_q_1turn(
    void* struct_obj,
    const void* src_ptr);

void tao_spin_polarization_struct_get_q_ele_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_tao_lat(
    const void* struct_obj,
    void** ptr_out);
void tao_lattice_branch_struct_set_tao_lat(
    void* struct_obj,
    const void* src_ptr);

void tao_lattice_branch_struct_get_lat_sigma_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_spin_ele_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_bunch_params_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_bunch_params_comb_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_orbit_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_plot_cache_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_spin(const void* struct_obj, void** ptr_out);
void tao_lattice_branch_struct_set_spin(void* struct_obj, const void* src_ptr);
void tao_lattice_branch_struct_get_srdt(const void* struct_obj, void** ptr_out);
void tao_lattice_branch_struct_set_srdt(void* struct_obj, const void* src_ptr);
void tao_lattice_branch_struct_get_orb0(const void* struct_obj, void** ptr_out);
void tao_lattice_branch_struct_set_orb0(void* struct_obj, const void* src_ptr);
void tao_lattice_branch_struct_get_modes_ri(
    const void* struct_obj,
    void** ptr_out);
void tao_lattice_branch_struct_set_modes_ri(
    void* struct_obj,
    const void* src_ptr);
void tao_lattice_branch_struct_get_modes_6d(
    const void* struct_obj,
    void** ptr_out);
void tao_lattice_branch_struct_set_modes_6d(
    void* struct_obj,
    const void* src_ptr);
void tao_lattice_branch_struct_get_ptc_normal_form(
    const void* struct_obj,
    void** ptr_out);
void tao_lattice_branch_struct_set_ptc_normal_form(
    void* struct_obj,
    const void* src_ptr);
void tao_lattice_branch_struct_get_bmad_normal_form(
    const void* struct_obj,
    void** ptr_out);
void tao_lattice_branch_struct_set_bmad_normal_form(
    void* struct_obj,
    const void* src_ptr);

void tao_lattice_branch_struct_get_high_E_orb_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_low_E_orb_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_branch_struct_get_cache_x_min(
    const void* struct_obj,
    double* value_out);
void tao_lattice_branch_struct_set_cache_x_min(
    void* struct_obj,
    double value_in);
void tao_lattice_branch_struct_get_cache_x_max(
    const void* struct_obj,
    double* value_out);
void tao_lattice_branch_struct_set_cache_x_max(
    void* struct_obj,
    double value_in);
void tao_lattice_branch_struct_get_comb_ds_save(
    const void* struct_obj,
    double* value_out);
void tao_lattice_branch_struct_set_comb_ds_save(
    void* struct_obj,
    double value_in);
void tao_lattice_branch_struct_get_track_state(
    const void* struct_obj,
    int* value_out);
void tao_lattice_branch_struct_set_track_state(void* struct_obj, int value_in);
void tao_lattice_branch_struct_get_cache_n_pts(
    const void* struct_obj,
    int* value_out);
void tao_lattice_branch_struct_set_cache_n_pts(void* struct_obj, int value_in);
void tao_lattice_branch_struct_get_ix_rad_int_cache(
    const void* struct_obj,
    int* value_out);
void tao_lattice_branch_struct_set_ix_rad_int_cache(
    void* struct_obj,
    int value_in);
void tao_lattice_branch_struct_get_has_open_match_element(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_has_open_match_element(
    void* struct_obj,
    bool value_in);
void tao_lattice_branch_struct_get_plot_cache_valid(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_plot_cache_valid(
    void* struct_obj,
    bool value_in);
void tao_lattice_branch_struct_get_spin_map_valid(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_spin_map_valid(
    void* struct_obj,
    bool value_in);
void tao_lattice_branch_struct_get_twiss_valid(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_twiss_valid(void* struct_obj, bool value_in);
void tao_lattice_branch_struct_get_mode_flip_here(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_mode_flip_here(
    void* struct_obj,
    bool value_in);
void tao_lattice_branch_struct_get_chrom_calc_ok(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_chrom_calc_ok(
    void* struct_obj,
    bool value_in);
void tao_lattice_branch_struct_get_rad_int_calc_ok(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_rad_int_calc_ok(
    void* struct_obj,
    bool value_in);
void tao_lattice_branch_struct_get_emit_6d_calc_ok(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_emit_6d_calc_ok(
    void* struct_obj,
    bool value_in);
void tao_lattice_branch_struct_get_sigma_track_ok(
    const void* struct_obj,
    bool* value_out);
void tao_lattice_branch_struct_set_sigma_track_ok(
    void* struct_obj,
    bool value_in);
void tao_model_element_struct_get_beam(const void* struct_obj, void** ptr_out);
void tao_model_element_struct_set_beam(void* struct_obj, const void* src_ptr);
void tao_model_element_struct_get_save_beam_internally(
    const void* struct_obj,
    bool* value_out);
void tao_model_element_struct_set_save_beam_internally(
    void* struct_obj,
    bool value_in);
void tao_model_element_struct_get_save_beam_to_file(
    const void* struct_obj,
    bool* value_out);
void tao_model_element_struct_set_save_beam_to_file(
    void* struct_obj,
    bool value_in);
void tao_beam_branch_struct_get_beam_at_start(
    const void* struct_obj,
    void** ptr_out);
void tao_beam_branch_struct_set_beam_at_start(
    void* struct_obj,
    const void* src_ptr);
void tao_beam_branch_struct_get_beam_init(
    const void* struct_obj,
    void** ptr_out);
void tao_beam_branch_struct_set_beam_init(
    void* struct_obj,
    const void* src_ptr);
void tao_beam_branch_struct_get_beam_init_used(
    const void* struct_obj,
    void** ptr_out);
void tao_beam_branch_struct_set_beam_init_used(
    void* struct_obj,
    const void* src_ptr);
void tao_beam_branch_struct_get_init_starting_distribution(
    const void* struct_obj,
    bool* value_out);
void tao_beam_branch_struct_set_init_starting_distribution(
    void* struct_obj,
    bool value_in);
void tao_beam_branch_struct_get_track_start_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_beam_branch_struct_set_track_start(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_beam_branch_struct_get_track_end_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_beam_branch_struct_set_track_end(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_beam_branch_struct_get_ix_branch(
    const void* struct_obj,
    int* value_out);
void tao_beam_branch_struct_set_ix_branch(void* struct_obj, int value_in);
void tao_beam_branch_struct_get_ix_track_start(
    const void* struct_obj,
    int* value_out);
void tao_beam_branch_struct_set_ix_track_start(void* struct_obj, int value_in);
void tao_beam_branch_struct_get_ix_track_end(
    const void* struct_obj,
    int* value_out);
void tao_beam_branch_struct_set_ix_track_end(void* struct_obj, int value_in);
void tao_d1_data_struct_get_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_d1_data_struct_set_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_d1_data_struct_get_d2(const void* struct_obj, void** ptr_out);
void tao_d1_data_struct_set_d2(void* struct_obj, const void* src_ptr);

void tao_d1_data_struct_get_d_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_lattice_struct_get_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_lattice_struct_set_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_lattice_struct_get_lat(const void* struct_obj, void** ptr_out);
void tao_lattice_struct_set_lat(void* struct_obj, const void* src_ptr);
void tao_lattice_struct_get_high_E_lat(const void* struct_obj, void** ptr_out);
void tao_lattice_struct_set_high_E_lat(void* struct_obj, const void* src_ptr);
void tao_lattice_struct_get_low_E_lat(const void* struct_obj, void** ptr_out);
void tao_lattice_struct_set_low_E_lat(void* struct_obj, const void* src_ptr);
void tao_lattice_struct_get_rad_int_by_ele_ri(
    const void* struct_obj,
    void** ptr_out);
void tao_lattice_struct_set_rad_int_by_ele_ri(
    void* struct_obj,
    const void* src_ptr);
void tao_lattice_struct_get_rad_int_by_ele_6d(
    const void* struct_obj,
    void** ptr_out);
void tao_lattice_struct_set_rad_int_by_ele_6d(
    void* struct_obj,
    const void* src_ptr);

void tao_lattice_struct_get_tao_branch_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_beam_uni_struct_get_saved_at_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_beam_uni_struct_set_saved_at(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_beam_uni_struct_get_dump_file_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_beam_uni_struct_set_dump_file(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_beam_uni_struct_get_dump_at_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_beam_uni_struct_set_dump_at(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_beam_uni_struct_get_track_beam_in_universe(
    const void* struct_obj,
    bool* value_out);
void tao_beam_uni_struct_set_track_beam_in_universe(
    void* struct_obj,
    bool value_in);
void tao_beam_uni_struct_get_always_reinit(
    const void* struct_obj,
    bool* value_out);
void tao_beam_uni_struct_set_always_reinit(void* struct_obj, bool value_in);
void tao_dynamic_aperture_struct_get_param(
    const void* struct_obj,
    void** ptr_out);
void tao_dynamic_aperture_struct_set_param(
    void* struct_obj,
    const void* src_ptr);

void tao_dynamic_aperture_struct_get_scan_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_dynamic_aperture_struct_get_pz_info(
    const void* s,
    double** d,
    int* bounds,
    bool* is_alloc);
void tao_dynamic_aperture_struct_get_ellipse_scale(
    const void* struct_obj,
    double* value_out);
void tao_dynamic_aperture_struct_set_ellipse_scale(
    void* struct_obj,
    double value_in);
void tao_dynamic_aperture_struct_get_a_emit(
    const void* struct_obj,
    double* value_out);
void tao_dynamic_aperture_struct_set_a_emit(void* struct_obj, double value_in);
void tao_dynamic_aperture_struct_get_b_emit(
    const void* struct_obj,
    double* value_out);
void tao_dynamic_aperture_struct_set_b_emit(void* struct_obj, double value_in);

void tao_model_branch_struct_get_ele_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_model_branch_struct_get_beam(const void* struct_obj, void** ptr_out);
void tao_model_branch_struct_set_beam(void* struct_obj, const void* src_ptr);
void tao_d2_data_struct_get_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_d2_data_struct_set_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_d2_data_struct_get_data_file_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_d2_data_struct_set_data_file_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_d2_data_struct_get_ref_file_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_d2_data_struct_set_ref_file_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_d2_data_struct_get_data_date_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_d2_data_struct_set_data_date(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_d2_data_struct_get_ref_date_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_d2_data_struct_set_ref_date(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void tao_d2_data_struct_get_descrip_info(
    const void* s,
    char** d,
    int* bounds, // [lower, upper]
    int* str_len,
    bool* is_alloc);

void tao_d2_data_struct_get_d1_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_d2_data_struct_get_ix_universe(const void* struct_obj, int* value_out);
void tao_d2_data_struct_set_ix_universe(void* struct_obj, int value_in);
void tao_d2_data_struct_get_ix_d2_data(const void* struct_obj, int* value_out);
void tao_d2_data_struct_set_ix_d2_data(void* struct_obj, int value_in);
void tao_d2_data_struct_get_ix_ref(const void* struct_obj, int* value_out);
void tao_d2_data_struct_set_ix_ref(void* struct_obj, int value_in);
void tao_d2_data_struct_get_data_read_in(
    const void* struct_obj,
    bool* value_out);
void tao_d2_data_struct_set_data_read_in(void* struct_obj, bool value_in);
void tao_d2_data_struct_get_ref_read_in(
    const void* struct_obj,
    bool* value_out);
void tao_d2_data_struct_set_ref_read_in(void* struct_obj, bool value_in);
void tao_spin_map_struct_get_valid(const void* struct_obj, bool* value_out);
void tao_spin_map_struct_set_valid(void* struct_obj, bool value_in);
void tao_spin_map_struct_get_map1(const void* struct_obj, void** ptr_out);
void tao_spin_map_struct_set_map1(void* struct_obj, const void* src_ptr);
void tao_spin_map_struct_get_axis_input(const void* struct_obj, void** ptr_out);
void tao_spin_map_struct_set_axis_input(void* struct_obj, const void* src_ptr);
void tao_spin_map_struct_get_axis0(const void* struct_obj, void** ptr_out);
void tao_spin_map_struct_set_axis0(void* struct_obj, const void* src_ptr);
void tao_spin_map_struct_get_axis1(const void* struct_obj, void** ptr_out);
void tao_spin_map_struct_set_axis1(void* struct_obj, const void* src_ptr);
void tao_spin_map_struct_get_ix_ele(const void* struct_obj, int* value_out);
void tao_spin_map_struct_set_ix_ele(void* struct_obj, int value_in);
void tao_spin_map_struct_get_ix_ref(const void* struct_obj, int* value_out);
void tao_spin_map_struct_set_ix_ref(void* struct_obj, int value_in);
void tao_spin_map_struct_get_ix_uni(const void* struct_obj, int* value_out);
void tao_spin_map_struct_set_ix_uni(void* struct_obj, int value_in);
void tao_spin_map_struct_get_ix_branch(const void* struct_obj, int* value_out);
void tao_spin_map_struct_set_ix_branch(void* struct_obj, int value_in);
void tao_spin_map_struct_get_mat8_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void tao_data_struct_get_ele_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_data_struct_set_ele_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_data_struct_get_ele_start_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_data_struct_set_ele_start_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_data_struct_get_ele_ref_name_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_data_struct_set_ele_ref_name(
    void* struct_obj,
    const char* str_ptr,
    int str_len);

void tao_data_struct_get_data_type_info(
    const void* s,
    char** d,
    int* len,
    bool* is_alloc);

void tao_data_struct_set_data_type(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_data_struct_get_merit_type_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_data_struct_set_merit_type(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_data_struct_get_id_info(const void* s, char** d, int* bounds, bool* a);
void tao_data_struct_set_id(void* struct_obj, const char* str_ptr, int str_len);
void tao_data_struct_get_data_source_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_data_struct_set_data_source(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_data_struct_get_why_invalid_info(
    const void* s,
    char** d,
    int* bounds,
    bool* a);
void tao_data_struct_set_why_invalid(
    void* struct_obj,
    const char* str_ptr,
    int str_len);
void tao_data_struct_get_ix_uni(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_uni(void* struct_obj, int value_in);
void tao_data_struct_get_ix_bunch(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_bunch(void* struct_obj, int value_in);
void tao_data_struct_get_ix_branch(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_branch(void* struct_obj, int value_in);
void tao_data_struct_get_ix_ele(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_ele(void* struct_obj, int value_in);
void tao_data_struct_get_ix_ele_start(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_ele_start(void* struct_obj, int value_in);
void tao_data_struct_get_ix_ele_ref(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_ele_ref(void* struct_obj, int value_in);
void tao_data_struct_get_ix_ele_merit(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_ele_merit(void* struct_obj, int value_in);
void tao_data_struct_get_ix_d1(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_d1(void* struct_obj, int value_in);
void tao_data_struct_get_ix_data(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_data(void* struct_obj, int value_in);
void tao_data_struct_get_ix_dModel(const void* struct_obj, int* value_out);
void tao_data_struct_set_ix_dModel(void* struct_obj, int value_in);
void tao_data_struct_get_eval_point(const void* struct_obj, int* value_out);
void tao_data_struct_set_eval_point(void* struct_obj, int value_in);
void tao_data_struct_get_meas_value(const void* struct_obj, double* value_out);
void tao_data_struct_set_meas_value(void* struct_obj, double value_in);
void tao_data_struct_get_ref_value(const void* struct_obj, double* value_out);
void tao_data_struct_set_ref_value(void* struct_obj, double value_in);
void tao_data_struct_get_model_value(const void* struct_obj, double* value_out);
void tao_data_struct_set_model_value(void* struct_obj, double value_in);
void tao_data_struct_get_design_value(
    const void* struct_obj,
    double* value_out);
void tao_data_struct_set_design_value(void* struct_obj, double value_in);
void tao_data_struct_get_old_value(const void* struct_obj, double* value_out);
void tao_data_struct_set_old_value(void* struct_obj, double value_in);
void tao_data_struct_get_base_value(const void* struct_obj, double* value_out);
void tao_data_struct_set_base_value(void* struct_obj, double value_in);
void tao_data_struct_get_error_rms(const void* struct_obj, double* value_out);
void tao_data_struct_set_error_rms(void* struct_obj, double value_in);
void tao_data_struct_get_delta_merit(const void* struct_obj, double* value_out);
void tao_data_struct_set_delta_merit(void* struct_obj, double value_in);
void tao_data_struct_get_weight(const void* struct_obj, double* value_out);
void tao_data_struct_set_weight(void* struct_obj, double value_in);
void tao_data_struct_get_invalid_value(
    const void* struct_obj,
    double* value_out);
void tao_data_struct_set_invalid_value(void* struct_obj, double value_in);
void tao_data_struct_get_merit(const void* struct_obj, double* value_out);
void tao_data_struct_set_merit(void* struct_obj, double value_in);
void tao_data_struct_get_s(const void* struct_obj, double* value_out);
void tao_data_struct_set_s(void* struct_obj, double value_in);
void tao_data_struct_get_s_offset(const void* struct_obj, double* value_out);
void tao_data_struct_set_s_offset(void* struct_obj, double value_in);
void tao_data_struct_get_err_message_printed(
    const void* struct_obj,
    bool* value_out);
void tao_data_struct_set_err_message_printed(void* struct_obj, bool value_in);
void tao_data_struct_get_exists(const void* struct_obj, bool* value_out);
void tao_data_struct_set_exists(void* struct_obj, bool value_in);
void tao_data_struct_get_good_model(const void* struct_obj, bool* value_out);
void tao_data_struct_set_good_model(void* struct_obj, bool value_in);
void tao_data_struct_get_good_base(const void* struct_obj, bool* value_out);
void tao_data_struct_set_good_base(void* struct_obj, bool value_in);
void tao_data_struct_get_good_design(const void* struct_obj, bool* value_out);
void tao_data_struct_set_good_design(void* struct_obj, bool value_in);
void tao_data_struct_get_good_meas(const void* struct_obj, bool* value_out);
void tao_data_struct_set_good_meas(void* struct_obj, bool value_in);
void tao_data_struct_get_good_ref(const void* struct_obj, bool* value_out);
void tao_data_struct_set_good_ref(void* struct_obj, bool value_in);
void tao_data_struct_get_good_user(const void* struct_obj, bool* value_out);
void tao_data_struct_set_good_user(void* struct_obj, bool value_in);
void tao_data_struct_get_good_opt(const void* struct_obj, bool* value_out);
void tao_data_struct_set_good_opt(void* struct_obj, bool value_in);
void tao_data_struct_get_good_plot(const void* struct_obj, bool* value_out);
void tao_data_struct_set_good_plot(void* struct_obj, bool value_in);
void tao_data_struct_get_useit_plot(const void* struct_obj, bool* value_out);
void tao_data_struct_set_useit_plot(void* struct_obj, bool value_in);
void tao_data_struct_get_useit_opt(const void* struct_obj, bool* value_out);
void tao_data_struct_set_useit_opt(void* struct_obj, bool value_in);
void tao_data_struct_get_spin_map(const void* struct_obj, void** ptr_out);
void tao_data_struct_set_spin_map(void* struct_obj, const void* src_ptr);
void tao_data_struct_get_d1(const void* struct_obj, void** ptr_out);
void tao_data_struct_set_d1(void* struct_obj, const void* src_ptr);
void tao_ping_scale_struct_get_a_mode_meas(
    const void* struct_obj,
    double* value_out);
void tao_ping_scale_struct_set_a_mode_meas(void* struct_obj, double value_in);
void tao_ping_scale_struct_get_a_mode_ref(
    const void* struct_obj,
    double* value_out);
void tao_ping_scale_struct_set_a_mode_ref(void* struct_obj, double value_in);
void tao_ping_scale_struct_get_b_mode_meas(
    const void* struct_obj,
    double* value_out);
void tao_ping_scale_struct_set_b_mode_meas(void* struct_obj, double value_in);
void tao_ping_scale_struct_get_b_mode_ref(
    const void* struct_obj,
    double* value_out);
void tao_ping_scale_struct_set_b_mode_ref(void* struct_obj, double value_in);
void tao_universe_calc_struct_get_srdt_for_data(
    const void* struct_obj,
    int* value_out);
void tao_universe_calc_struct_set_srdt_for_data(void* struct_obj, int value_in);
void tao_universe_calc_struct_get_rad_int_for_data(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_rad_int_for_data(
    void* struct_obj,
    bool value_in);
void tao_universe_calc_struct_get_rad_int_for_plotting(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_rad_int_for_plotting(
    void* struct_obj,
    bool value_in);
void tao_universe_calc_struct_get_chrom_for_data(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_chrom_for_data(
    void* struct_obj,
    bool value_in);
void tao_universe_calc_struct_get_chrom_for_plotting(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_chrom_for_plotting(
    void* struct_obj,
    bool value_in);
void tao_universe_calc_struct_get_lat_sigma_for_data(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_lat_sigma_for_data(
    void* struct_obj,
    bool value_in);
void tao_universe_calc_struct_get_lat_sigma_for_plotting(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_lat_sigma_for_plotting(
    void* struct_obj,
    bool value_in);
void tao_universe_calc_struct_get_dynamic_aperture(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_dynamic_aperture(
    void* struct_obj,
    bool value_in);
void tao_universe_calc_struct_get_one_turn_map(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_one_turn_map(void* struct_obj, bool value_in);
void tao_universe_calc_struct_get_lattice(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_lattice(void* struct_obj, bool value_in);
void tao_universe_calc_struct_get_twiss(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_twiss(void* struct_obj, bool value_in);
void tao_universe_calc_struct_get_track(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_track(void* struct_obj, bool value_in);
void tao_universe_calc_struct_get_spin_matrices(
    const void* struct_obj,
    bool* value_out);
void tao_universe_calc_struct_set_spin_matrices(
    void* struct_obj,
    bool value_in);

void lat_ele_order_struct_get_branch_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_universe_struct_get_model(const void* struct_obj, void** ptr_out);
void tao_universe_struct_set_model(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_design(const void* struct_obj, void** ptr_out);
void tao_universe_struct_set_design(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_base(const void* struct_obj, void** ptr_out);
void tao_universe_struct_set_base(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_beam(const void* struct_obj, void** ptr_out);
void tao_universe_struct_set_beam(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_dynamic_aperture(
    const void* struct_obj,
    void** ptr_out);
void tao_universe_struct_set_dynamic_aperture(
    void* struct_obj,
    const void* src_ptr);

void tao_universe_struct_get_model_branch_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_universe_struct_get_d2_data_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_universe_struct_get_data_info(
    const void* s,
    void** d,
    int* bounds,
    bool* is_alloc,
    size_t* el_size);

void tao_universe_struct_get_ping_scale(const void* struct_obj, void** ptr_out);
void tao_universe_struct_set_ping_scale(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_scratch_lat(
    const void* struct_obj,
    void** ptr_out);
void tao_universe_struct_set_scratch_lat(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_calc(const void* struct_obj, void** ptr_out);
void tao_universe_struct_set_calc(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_ele_order(const void* struct_obj, void** ptr_out);
void tao_universe_struct_set_ele_order(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_spin_map(const void* struct_obj, void** ptr_out);
void tao_universe_struct_set_spin_map(void* struct_obj, const void* src_ptr);
void tao_universe_struct_get_dModel_dVar_info(
    const void* s,
    double** d,
    int* bounds,
    int* strides,
    bool* is_alloc);
void tao_universe_struct_get_ix_uni(const void* struct_obj, int* value_out);
void tao_universe_struct_set_ix_uni(void* struct_obj, int value_in);
void tao_universe_struct_get_n_d2_data_used(
    const void* struct_obj,
    int* value_out);
void tao_universe_struct_set_n_d2_data_used(void* struct_obj, int value_in);
void tao_universe_struct_get_n_data_used(
    const void* struct_obj,
    int* value_out);
void tao_universe_struct_set_n_data_used(void* struct_obj, int value_in);
void tao_universe_struct_get_is_on(const void* struct_obj, bool* value_out);
void tao_universe_struct_set_is_on(void* struct_obj, bool value_in);
void tao_universe_struct_get_design_same_as_previous(
    const void* struct_obj,
    bool* value_out);
void tao_universe_struct_set_design_same_as_previous(
    void* struct_obj,
    bool value_in);
void tao_universe_struct_get_picked_uni(
    const void* struct_obj,
    bool* value_out);
void tao_universe_struct_set_picked_uni(void* struct_obj, bool value_in);

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

// Forward declarations
class TaoUniverseIndexProxy;
class TaoLatticeIndexProxy;
class TaoBranchIndexProxy;
extern "C" {

void* allocate_fortran_spline_struct(int n, size_t* element_size);
void deallocate_fortran_spline_struct(void* ptr, int n) noexcept;
void copy_fortran_spline_struct(const void* src, void* dst);

void* allocate_fortran_spin_polar_struct(int n, size_t* element_size);
void deallocate_fortran_spin_polar_struct(void* ptr, int n) noexcept;
void copy_fortran_spin_polar_struct(const void* src, void* dst);

void* allocate_fortran_ac_kicker_time_struct(int n, size_t* element_size);
void deallocate_fortran_ac_kicker_time_struct(void* ptr, int n) noexcept;
void copy_fortran_ac_kicker_time_struct(const void* src, void* dst);

void* allocate_fortran_ac_kicker_freq_struct(int n, size_t* element_size);
void deallocate_fortran_ac_kicker_freq_struct(void* ptr, int n) noexcept;
void copy_fortran_ac_kicker_freq_struct(const void* src, void* dst);

void* allocate_fortran_ac_kicker_struct(int n, size_t* element_size);
void deallocate_fortran_ac_kicker_struct(void* ptr, int n) noexcept;
void copy_fortran_ac_kicker_struct(const void* src, void* dst);

void* allocate_fortran_interval1_coef_struct(int n, size_t* element_size);
void deallocate_fortran_interval1_coef_struct(void* ptr, int n) noexcept;
void copy_fortran_interval1_coef_struct(const void* src, void* dst);

void* allocate_fortran_photon_reflect_table_struct(int n, size_t* element_size);
void deallocate_fortran_photon_reflect_table_struct(void* ptr, int n) noexcept;
void copy_fortran_photon_reflect_table_struct(const void* src, void* dst);

void* allocate_fortran_photon_reflect_surface_struct(
    int n,
    size_t* element_size);
void deallocate_fortran_photon_reflect_surface_struct(
    void* ptr,
    int n) noexcept;
void copy_fortran_photon_reflect_surface_struct(const void* src, void* dst);

void* allocate_fortran_coord_struct(int n, size_t* element_size);
void deallocate_fortran_coord_struct(void* ptr, int n) noexcept;
void copy_fortran_coord_struct(const void* src, void* dst);

void* allocate_fortran_coord_array_struct(int n, size_t* element_size);
void deallocate_fortran_coord_array_struct(void* ptr, int n) noexcept;
void copy_fortran_coord_array_struct(const void* src, void* dst);

void* allocate_fortran_bpm_phase_coupling_struct(int n, size_t* element_size);
void deallocate_fortran_bpm_phase_coupling_struct(void* ptr, int n) noexcept;
void copy_fortran_bpm_phase_coupling_struct(const void* src, void* dst);

void* allocate_fortran_expression_atom_struct(int n, size_t* element_size);
void deallocate_fortran_expression_atom_struct(void* ptr, int n) noexcept;
void copy_fortran_expression_atom_struct(const void* src, void* dst);

void* allocate_fortran_wake_sr_z_long_struct(int n, size_t* element_size);
void deallocate_fortran_wake_sr_z_long_struct(void* ptr, int n) noexcept;
void copy_fortran_wake_sr_z_long_struct(const void* src, void* dst);

void* allocate_fortran_wake_sr_mode_struct(int n, size_t* element_size);
void deallocate_fortran_wake_sr_mode_struct(void* ptr, int n) noexcept;
void copy_fortran_wake_sr_mode_struct(const void* src, void* dst);

void* allocate_fortran_wake_sr_struct(int n, size_t* element_size);
void deallocate_fortran_wake_sr_struct(void* ptr, int n) noexcept;
void copy_fortran_wake_sr_struct(const void* src, void* dst);

void* allocate_fortran_wake_lr_mode_struct(int n, size_t* element_size);
void deallocate_fortran_wake_lr_mode_struct(void* ptr, int n) noexcept;
void copy_fortran_wake_lr_mode_struct(const void* src, void* dst);

void* allocate_fortran_wake_lr_struct(int n, size_t* element_size);
void deallocate_fortran_wake_lr_struct(void* ptr, int n) noexcept;
void copy_fortran_wake_lr_struct(const void* src, void* dst);

void* allocate_fortran_lat_ele_loc_struct(int n, size_t* element_size);
void deallocate_fortran_lat_ele_loc_struct(void* ptr, int n) noexcept;
void copy_fortran_lat_ele_loc_struct(const void* src, void* dst);

void* allocate_fortran_wake_struct(int n, size_t* element_size);
void deallocate_fortran_wake_struct(void* ptr, int n) noexcept;
void copy_fortran_wake_struct(const void* src, void* dst);

void* allocate_fortran_taylor_term_struct(int n, size_t* element_size);
void deallocate_fortran_taylor_term_struct(void* ptr, int n) noexcept;
void copy_fortran_taylor_term_struct(const void* src, void* dst);

void* allocate_fortran_taylor_struct(int n, size_t* element_size);
void deallocate_fortran_taylor_struct(void* ptr, int n) noexcept;
void copy_fortran_taylor_struct(const void* src, void* dst);

void* allocate_fortran_em_taylor_term_struct(int n, size_t* element_size);
void deallocate_fortran_em_taylor_term_struct(void* ptr, int n) noexcept;
void copy_fortran_em_taylor_term_struct(const void* src, void* dst);

void* allocate_fortran_em_taylor_struct(int n, size_t* element_size);
void deallocate_fortran_em_taylor_struct(void* ptr, int n) noexcept;
void copy_fortran_em_taylor_struct(const void* src, void* dst);

void* allocate_fortran_cartesian_map_term1_struct(int n, size_t* element_size);
void deallocate_fortran_cartesian_map_term1_struct(void* ptr, int n) noexcept;
void copy_fortran_cartesian_map_term1_struct(const void* src, void* dst);

void* allocate_fortran_cartesian_map_term_struct(int n, size_t* element_size);
void deallocate_fortran_cartesian_map_term_struct(void* ptr, int n) noexcept;
void copy_fortran_cartesian_map_term_struct(const void* src, void* dst);

void* allocate_fortran_cartesian_map_struct(int n, size_t* element_size);
void deallocate_fortran_cartesian_map_struct(void* ptr, int n) noexcept;
void copy_fortran_cartesian_map_struct(const void* src, void* dst);

void* allocate_fortran_cylindrical_map_term1_struct(
    int n,
    size_t* element_size);
void deallocate_fortran_cylindrical_map_term1_struct(void* ptr, int n) noexcept;
void copy_fortran_cylindrical_map_term1_struct(const void* src, void* dst);

void* allocate_fortran_cylindrical_map_term_struct(int n, size_t* element_size);
void deallocate_fortran_cylindrical_map_term_struct(void* ptr, int n) noexcept;
void copy_fortran_cylindrical_map_term_struct(const void* src, void* dst);

void* allocate_fortran_cylindrical_map_struct(int n, size_t* element_size);
void deallocate_fortran_cylindrical_map_struct(void* ptr, int n) noexcept;
void copy_fortran_cylindrical_map_struct(const void* src, void* dst);

void* allocate_fortran_bicubic_cmplx_coef_struct(int n, size_t* element_size);
void deallocate_fortran_bicubic_cmplx_coef_struct(void* ptr, int n) noexcept;
void copy_fortran_bicubic_cmplx_coef_struct(const void* src, void* dst);

void* allocate_fortran_tricubic_cmplx_coef_struct(int n, size_t* element_size);
void deallocate_fortran_tricubic_cmplx_coef_struct(void* ptr, int n) noexcept;
void copy_fortran_tricubic_cmplx_coef_struct(const void* src, void* dst);

void* allocate_fortran_grid_field_pt1_struct(int n, size_t* element_size);
void deallocate_fortran_grid_field_pt1_struct(void* ptr, int n) noexcept;
void copy_fortran_grid_field_pt1_struct(const void* src, void* dst);

void* allocate_fortran_grid_field_pt_struct(int n, size_t* element_size);
void deallocate_fortran_grid_field_pt_struct(void* ptr, int n) noexcept;
void copy_fortran_grid_field_pt_struct(const void* src, void* dst);

void* allocate_fortran_grid_field_struct(int n, size_t* element_size);
void deallocate_fortran_grid_field_struct(void* ptr, int n) noexcept;
void copy_fortran_grid_field_struct(const void* src, void* dst);

void* allocate_fortran_floor_position_struct(int n, size_t* element_size);
void deallocate_fortran_floor_position_struct(void* ptr, int n) noexcept;
void copy_fortran_floor_position_struct(const void* src, void* dst);

void* allocate_fortran_high_energy_space_charge_struct(
    int n,
    size_t* element_size);
void deallocate_fortran_high_energy_space_charge_struct(
    void* ptr,
    int n) noexcept;
void copy_fortran_high_energy_space_charge_struct(const void* src, void* dst);

void* allocate_fortran_xy_disp_struct(int n, size_t* element_size);
void deallocate_fortran_xy_disp_struct(void* ptr, int n) noexcept;
void copy_fortran_xy_disp_struct(const void* src, void* dst);

void* allocate_fortran_twiss_struct(int n, size_t* element_size);
void deallocate_fortran_twiss_struct(void* ptr, int n) noexcept;
void copy_fortran_twiss_struct(const void* src, void* dst);

void* allocate_fortran_mode3_struct(int n, size_t* element_size);
void deallocate_fortran_mode3_struct(void* ptr, int n) noexcept;
void copy_fortran_mode3_struct(const void* src, void* dst);

void* allocate_fortran_bookkeeping_state_struct(int n, size_t* element_size);
void deallocate_fortran_bookkeeping_state_struct(void* ptr, int n) noexcept;
void copy_fortran_bookkeeping_state_struct(const void* src, void* dst);

void* allocate_fortran_rad_map_struct(int n, size_t* element_size);
void deallocate_fortran_rad_map_struct(void* ptr, int n) noexcept;
void copy_fortran_rad_map_struct(const void* src, void* dst);

void* allocate_fortran_rad_map_ele_struct(int n, size_t* element_size);
void deallocate_fortran_rad_map_ele_struct(void* ptr, int n) noexcept;
void copy_fortran_rad_map_ele_struct(const void* src, void* dst);

void* allocate_fortran_gen_grad1_struct(int n, size_t* element_size);
void deallocate_fortran_gen_grad1_struct(void* ptr, int n) noexcept;
void copy_fortran_gen_grad1_struct(const void* src, void* dst);

void* allocate_fortran_gen_grad_map_struct(int n, size_t* element_size);
void deallocate_fortran_gen_grad_map_struct(void* ptr, int n) noexcept;
void copy_fortran_gen_grad_map_struct(const void* src, void* dst);

void* allocate_fortran_surface_segmented_pt_struct(int n, size_t* element_size);
void deallocate_fortran_surface_segmented_pt_struct(void* ptr, int n) noexcept;
void copy_fortran_surface_segmented_pt_struct(const void* src, void* dst);

void* allocate_fortran_surface_segmented_struct(int n, size_t* element_size);
void deallocate_fortran_surface_segmented_struct(void* ptr, int n) noexcept;
void copy_fortran_surface_segmented_struct(const void* src, void* dst);

void* allocate_fortran_surface_h_misalign_pt_struct(
    int n,
    size_t* element_size);
void deallocate_fortran_surface_h_misalign_pt_struct(void* ptr, int n) noexcept;
void copy_fortran_surface_h_misalign_pt_struct(const void* src, void* dst);

void* allocate_fortran_surface_h_misalign_struct(int n, size_t* element_size);
void deallocate_fortran_surface_h_misalign_struct(void* ptr, int n) noexcept;
void copy_fortran_surface_h_misalign_struct(const void* src, void* dst);

void* allocate_fortran_surface_displacement_pt_struct(
    int n,
    size_t* element_size);
void deallocate_fortran_surface_displacement_pt_struct(
    void* ptr,
    int n) noexcept;
void copy_fortran_surface_displacement_pt_struct(const void* src, void* dst);

void* allocate_fortran_surface_displacement_struct(int n, size_t* element_size);
void deallocate_fortran_surface_displacement_struct(void* ptr, int n) noexcept;
void copy_fortran_surface_displacement_struct(const void* src, void* dst);

void* allocate_fortran_target_point_struct(int n, size_t* element_size);
void deallocate_fortran_target_point_struct(void* ptr, int n) noexcept;
void copy_fortran_target_point_struct(const void* src, void* dst);

void* allocate_fortran_surface_curvature_struct(int n, size_t* element_size);
void deallocate_fortran_surface_curvature_struct(void* ptr, int n) noexcept;
void copy_fortran_surface_curvature_struct(const void* src, void* dst);

void* allocate_fortran_photon_target_struct(int n, size_t* element_size);
void deallocate_fortran_photon_target_struct(void* ptr, int n) noexcept;
void copy_fortran_photon_target_struct(const void* src, void* dst);

void* allocate_fortran_photon_material_struct(int n, size_t* element_size);
void deallocate_fortran_photon_material_struct(void* ptr, int n) noexcept;
void copy_fortran_photon_material_struct(const void* src, void* dst);

void* allocate_fortran_pixel_pt_struct(int n, size_t* element_size);
void deallocate_fortran_pixel_pt_struct(void* ptr, int n) noexcept;
void copy_fortran_pixel_pt_struct(const void* src, void* dst);

void* allocate_fortran_pixel_detec_struct(int n, size_t* element_size);
void deallocate_fortran_pixel_detec_struct(void* ptr, int n) noexcept;
void copy_fortran_pixel_detec_struct(const void* src, void* dst);

void* allocate_fortran_photon_element_struct(int n, size_t* element_size);
void deallocate_fortran_photon_element_struct(void* ptr, int n) noexcept;
void copy_fortran_photon_element_struct(const void* src, void* dst);

void* allocate_fortran_wall3d_vertex_struct(int n, size_t* element_size);
void deallocate_fortran_wall3d_vertex_struct(void* ptr, int n) noexcept;
void copy_fortran_wall3d_vertex_struct(const void* src, void* dst);

void* allocate_fortran_wall3d_section_struct(int n, size_t* element_size);
void deallocate_fortran_wall3d_section_struct(void* ptr, int n) noexcept;
void copy_fortran_wall3d_section_struct(const void* src, void* dst);

void* allocate_fortran_wall3d_struct(int n, size_t* element_size);
void deallocate_fortran_wall3d_struct(void* ptr, int n) noexcept;
void copy_fortran_wall3d_struct(const void* src, void* dst);

void* allocate_fortran_ramper_lord_struct(int n, size_t* element_size);
void deallocate_fortran_ramper_lord_struct(void* ptr, int n) noexcept;
void copy_fortran_ramper_lord_struct(const void* src, void* dst);

void* allocate_fortran_control_struct(int n, size_t* element_size);
void deallocate_fortran_control_struct(void* ptr, int n) noexcept;
void copy_fortran_control_struct(const void* src, void* dst);

void* allocate_fortran_control_var1_struct(int n, size_t* element_size);
void deallocate_fortran_control_var1_struct(void* ptr, int n) noexcept;
void copy_fortran_control_var1_struct(const void* src, void* dst);

void* allocate_fortran_control_ramp1_struct(int n, size_t* element_size);
void deallocate_fortran_control_ramp1_struct(void* ptr, int n) noexcept;
void copy_fortran_control_ramp1_struct(const void* src, void* dst);

void* allocate_fortran_controller_struct(int n, size_t* element_size);
void deallocate_fortran_controller_struct(void* ptr, int n) noexcept;
void copy_fortran_controller_struct(const void* src, void* dst);

void* allocate_fortran_ellipse_beam_init_struct(int n, size_t* element_size);
void deallocate_fortran_ellipse_beam_init_struct(void* ptr, int n) noexcept;
void copy_fortran_ellipse_beam_init_struct(const void* src, void* dst);

void* allocate_fortran_kv_beam_init_struct(int n, size_t* element_size);
void deallocate_fortran_kv_beam_init_struct(void* ptr, int n) noexcept;
void copy_fortran_kv_beam_init_struct(const void* src, void* dst);

void* allocate_fortran_grid_beam_init_struct(int n, size_t* element_size);
void deallocate_fortran_grid_beam_init_struct(void* ptr, int n) noexcept;
void copy_fortran_grid_beam_init_struct(const void* src, void* dst);

void* allocate_fortran_beam_init_struct(int n, size_t* element_size);
void deallocate_fortran_beam_init_struct(void* ptr, int n) noexcept;
void copy_fortran_beam_init_struct(const void* src, void* dst);

void* allocate_fortran_lat_param_struct(int n, size_t* element_size);
void deallocate_fortran_lat_param_struct(void* ptr, int n) noexcept;
void copy_fortran_lat_param_struct(const void* src, void* dst);

void* allocate_fortran_mode_info_struct(int n, size_t* element_size);
void deallocate_fortran_mode_info_struct(void* ptr, int n) noexcept;
void copy_fortran_mode_info_struct(const void* src, void* dst);

void* allocate_fortran_pre_tracker_struct(int n, size_t* element_size);
void deallocate_fortran_pre_tracker_struct(void* ptr, int n) noexcept;
void copy_fortran_pre_tracker_struct(const void* src, void* dst);

void* allocate_fortran_anormal_mode_struct(int n, size_t* element_size);
void deallocate_fortran_anormal_mode_struct(void* ptr, int n) noexcept;
void copy_fortran_anormal_mode_struct(const void* src, void* dst);

void* allocate_fortran_linac_normal_mode_struct(int n, size_t* element_size);
void deallocate_fortran_linac_normal_mode_struct(void* ptr, int n) noexcept;
void copy_fortran_linac_normal_mode_struct(const void* src, void* dst);

void* allocate_fortran_normal_modes_struct(int n, size_t* element_size);
void deallocate_fortran_normal_modes_struct(void* ptr, int n) noexcept;
void copy_fortran_normal_modes_struct(const void* src, void* dst);

void* allocate_fortran_em_field_struct(int n, size_t* element_size);
void deallocate_fortran_em_field_struct(void* ptr, int n) noexcept;
void copy_fortran_em_field_struct(const void* src, void* dst);

void* allocate_fortran_strong_beam_struct(int n, size_t* element_size);
void deallocate_fortran_strong_beam_struct(void* ptr, int n) noexcept;
void copy_fortran_strong_beam_struct(const void* src, void* dst);

void* allocate_fortran_track_point_struct(int n, size_t* element_size);
void deallocate_fortran_track_point_struct(void* ptr, int n) noexcept;
void copy_fortran_track_point_struct(const void* src, void* dst);

void* allocate_fortran_track_struct(int n, size_t* element_size);
void deallocate_fortran_track_struct(void* ptr, int n) noexcept;
void copy_fortran_track_struct(const void* src, void* dst);

void* allocate_fortran_space_charge_common_struct(int n, size_t* element_size);
void deallocate_fortran_space_charge_common_struct(void* ptr, int n) noexcept;
void copy_fortran_space_charge_common_struct(const void* src, void* dst);

void* allocate_fortran_bmad_common_struct(int n, size_t* element_size);
void deallocate_fortran_bmad_common_struct(void* ptr, int n) noexcept;
void copy_fortran_bmad_common_struct(const void* src, void* dst);

void* allocate_fortran_rad_int1_struct(int n, size_t* element_size);
void deallocate_fortran_rad_int1_struct(void* ptr, int n) noexcept;
void copy_fortran_rad_int1_struct(const void* src, void* dst);

void* allocate_fortran_rad_int_branch_struct(int n, size_t* element_size);
void deallocate_fortran_rad_int_branch_struct(void* ptr, int n) noexcept;
void copy_fortran_rad_int_branch_struct(const void* src, void* dst);

void* allocate_fortran_rad_int_all_ele_struct(int n, size_t* element_size);
void deallocate_fortran_rad_int_all_ele_struct(void* ptr, int n) noexcept;
void copy_fortran_rad_int_all_ele_struct(const void* src, void* dst);

void* allocate_fortran_rf_stair_step_struct(int n, size_t* element_size);
void deallocate_fortran_rf_stair_step_struct(void* ptr, int n) noexcept;
void copy_fortran_rf_stair_step_struct(const void* src, void* dst);

void* allocate_fortran_rf_ele_struct(int n, size_t* element_size);
void deallocate_fortran_rf_ele_struct(void* ptr, int n) noexcept;
void copy_fortran_rf_ele_struct(const void* src, void* dst);

void* allocate_fortran_ele_struct(int n, size_t* element_size);
void deallocate_fortran_ele_struct(void* ptr, int n) noexcept;
void copy_fortran_ele_struct(const void* src, void* dst);

void* allocate_fortran_complex_taylor_term_struct(int n, size_t* element_size);
void deallocate_fortran_complex_taylor_term_struct(void* ptr, int n) noexcept;
void copy_fortran_complex_taylor_term_struct(const void* src, void* dst);

void* allocate_fortran_complex_taylor_struct(int n, size_t* element_size);
void deallocate_fortran_complex_taylor_struct(void* ptr, int n) noexcept;
void copy_fortran_complex_taylor_struct(const void* src, void* dst);

void* allocate_fortran_branch_struct(int n, size_t* element_size);
void deallocate_fortran_branch_struct(void* ptr, int n) noexcept;
void copy_fortran_branch_struct(const void* src, void* dst);

void* allocate_fortran_lat_struct(int n, size_t* element_size);
void deallocate_fortran_lat_struct(void* ptr, int n) noexcept;
void copy_fortran_lat_struct(const void* src, void* dst);

void* allocate_fortran_bunch_struct(int n, size_t* element_size);
void deallocate_fortran_bunch_struct(void* ptr, int n) noexcept;
void copy_fortran_bunch_struct(const void* src, void* dst);

void* allocate_fortran_bunch_params_struct(int n, size_t* element_size);
void deallocate_fortran_bunch_params_struct(void* ptr, int n) noexcept;
void copy_fortran_bunch_params_struct(const void* src, void* dst);

void* allocate_fortran_beam_struct(int n, size_t* element_size);
void deallocate_fortran_beam_struct(void* ptr, int n) noexcept;
void copy_fortran_beam_struct(const void* src, void* dst);

void* allocate_fortran_aperture_point_struct(int n, size_t* element_size);
void deallocate_fortran_aperture_point_struct(void* ptr, int n) noexcept;
void copy_fortran_aperture_point_struct(const void* src, void* dst);

void* allocate_fortran_aperture_param_struct(int n, size_t* element_size);
void deallocate_fortran_aperture_param_struct(void* ptr, int n) noexcept;
void copy_fortran_aperture_param_struct(const void* src, void* dst);

void* allocate_fortran_aperture_scan_struct(int n, size_t* element_size);
void deallocate_fortran_aperture_scan_struct(void* ptr, int n) noexcept;
void copy_fortran_aperture_scan_struct(const void* src, void* dst);

void* allocate_fortran_tao_spin_dn_dpz_struct(int n, size_t* element_size);
void deallocate_fortran_tao_spin_dn_dpz_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_spin_dn_dpz_struct(const void* src, void* dst);

void* allocate_fortran_resonance_h_struct(int n, size_t* element_size);
void deallocate_fortran_resonance_h_struct(void* ptr, int n) noexcept;
void copy_fortran_resonance_h_struct(const void* src, void* dst);

void* allocate_fortran_spin_orbit_map1_struct(int n, size_t* element_size);
void deallocate_fortran_spin_orbit_map1_struct(void* ptr, int n) noexcept;
void copy_fortran_spin_orbit_map1_struct(const void* src, void* dst);

void* allocate_fortran_spin_axis_struct(int n, size_t* element_size);
void deallocate_fortran_spin_axis_struct(void* ptr, int n) noexcept;
void copy_fortran_spin_axis_struct(const void* src, void* dst);

void* allocate_fortran_ptc_normal_form_struct(int n, size_t* element_size);
void deallocate_fortran_ptc_normal_form_struct(void* ptr, int n) noexcept;
void copy_fortran_ptc_normal_form_struct(const void* src, void* dst);

void* allocate_fortran_bmad_normal_form_struct(int n, size_t* element_size);
void deallocate_fortran_bmad_normal_form_struct(void* ptr, int n) noexcept;
void copy_fortran_bmad_normal_form_struct(const void* src, void* dst);

void* allocate_fortran_bunch_track_struct(int n, size_t* element_size);
void deallocate_fortran_bunch_track_struct(void* ptr, int n) noexcept;
void copy_fortran_bunch_track_struct(const void* src, void* dst);

void* allocate_fortran_summation_rdt_struct(int n, size_t* element_size);
void deallocate_fortran_summation_rdt_struct(void* ptr, int n) noexcept;
void copy_fortran_summation_rdt_struct(const void* src, void* dst);

void* allocate_fortran_lat_ele_order1_struct(int n, size_t* element_size);
void deallocate_fortran_lat_ele_order1_struct(void* ptr, int n) noexcept;
void copy_fortran_lat_ele_order1_struct(const void* src, void* dst);

void* allocate_fortran_lat_ele_order_array_struct(int n, size_t* element_size);
void deallocate_fortran_lat_ele_order_array_struct(void* ptr, int n) noexcept;
void copy_fortran_lat_ele_order_array_struct(const void* src, void* dst);

void* allocate_fortran_tao_lat_sigma_struct(int n, size_t* element_size);
void deallocate_fortran_tao_lat_sigma_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_lat_sigma_struct(const void* src, void* dst);

void* allocate_fortran_tao_spin_ele_struct(int n, size_t* element_size);
void deallocate_fortran_tao_spin_ele_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_spin_ele_struct(const void* src, void* dst);

void* allocate_fortran_tao_plot_cache_struct(int n, size_t* element_size);
void deallocate_fortran_tao_plot_cache_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_plot_cache_struct(const void* src, void* dst);

void* allocate_fortran_tao_spin_polarization_struct(
    int n,
    size_t* element_size);
void deallocate_fortran_tao_spin_polarization_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_spin_polarization_struct(const void* src, void* dst);

void* allocate_fortran_tao_lattice_branch_struct(int n, size_t* element_size);
void deallocate_fortran_tao_lattice_branch_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_lattice_branch_struct(const void* src, void* dst);

void* allocate_fortran_tao_model_element_struct(int n, size_t* element_size);
void deallocate_fortran_tao_model_element_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_model_element_struct(const void* src, void* dst);

void* allocate_fortran_tao_beam_branch_struct(int n, size_t* element_size);
void deallocate_fortran_tao_beam_branch_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_beam_branch_struct(const void* src, void* dst);

void* allocate_fortran_tao_d1_data_struct(int n, size_t* element_size);
void deallocate_fortran_tao_d1_data_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_d1_data_struct(const void* src, void* dst);

void* allocate_fortran_tao_lattice_struct(int n, size_t* element_size);
void deallocate_fortran_tao_lattice_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_lattice_struct(const void* src, void* dst);

void* allocate_fortran_tao_beam_uni_struct(int n, size_t* element_size);
void deallocate_fortran_tao_beam_uni_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_beam_uni_struct(const void* src, void* dst);

void* allocate_fortran_tao_dynamic_aperture_struct(int n, size_t* element_size);
void deallocate_fortran_tao_dynamic_aperture_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_dynamic_aperture_struct(const void* src, void* dst);

void* allocate_fortran_tao_model_branch_struct(int n, size_t* element_size);
void deallocate_fortran_tao_model_branch_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_model_branch_struct(const void* src, void* dst);

void* allocate_fortran_tao_d2_data_struct(int n, size_t* element_size);
void deallocate_fortran_tao_d2_data_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_d2_data_struct(const void* src, void* dst);

void* allocate_fortran_tao_spin_map_struct(int n, size_t* element_size);
void deallocate_fortran_tao_spin_map_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_spin_map_struct(const void* src, void* dst);

void* allocate_fortran_tao_data_struct(int n, size_t* element_size);
void deallocate_fortran_tao_data_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_data_struct(const void* src, void* dst);

void* allocate_fortran_tao_ping_scale_struct(int n, size_t* element_size);
void deallocate_fortran_tao_ping_scale_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_ping_scale_struct(const void* src, void* dst);

void* allocate_fortran_tao_universe_calc_struct(int n, size_t* element_size);
void deallocate_fortran_tao_universe_calc_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_universe_calc_struct(const void* src, void* dst);

void* allocate_fortran_lat_ele_order_struct(int n, size_t* element_size);
void deallocate_fortran_lat_ele_order_struct(void* ptr, int n) noexcept;
void copy_fortran_lat_ele_order_struct(const void* src, void* dst);

void* allocate_fortran_tao_universe_struct(int n, size_t* element_size);
void deallocate_fortran_tao_universe_struct(void* ptr, int n) noexcept;
void copy_fortran_tao_universe_struct(const void* src, void* dst);
}
class SplineProxy;

using SplineProxyArray1D = FortranTypeArray1D<
    SplineProxy,
    allocate_fortran_spline_struct,
    deallocate_fortran_spline_struct>;
using SplineProxyArray2D = FortranTypeArray2D<SplineProxy>;
using SplineProxyArray3D = FortranTypeArray3D<SplineProxy>;

class SpinPolarProxy;

using SpinPolarProxyArray1D = FortranTypeArray1D<
    SpinPolarProxy,
    allocate_fortran_spin_polar_struct,
    deallocate_fortran_spin_polar_struct>;
using SpinPolarProxyArray2D = FortranTypeArray2D<SpinPolarProxy>;
using SpinPolarProxyArray3D = FortranTypeArray3D<SpinPolarProxy>;

class AcKickerTimeProxy;

using AcKickerTimeProxyArray1D = FortranTypeArray1D<
    AcKickerTimeProxy,
    allocate_fortran_ac_kicker_time_struct,
    deallocate_fortran_ac_kicker_time_struct>;
using AcKickerTimeProxyArray2D = FortranTypeArray2D<AcKickerTimeProxy>;
using AcKickerTimeProxyArray3D = FortranTypeArray3D<AcKickerTimeProxy>;

class AcKickerFreqProxy;

using AcKickerFreqProxyArray1D = FortranTypeArray1D<
    AcKickerFreqProxy,
    allocate_fortran_ac_kicker_freq_struct,
    deallocate_fortran_ac_kicker_freq_struct>;
using AcKickerFreqProxyArray2D = FortranTypeArray2D<AcKickerFreqProxy>;
using AcKickerFreqProxyArray3D = FortranTypeArray3D<AcKickerFreqProxy>;

class AcKickerProxy;

using AcKickerProxyArray1D = FortranTypeArray1D<
    AcKickerProxy,
    allocate_fortran_ac_kicker_struct,
    deallocate_fortran_ac_kicker_struct>;
using AcKickerProxyArray2D = FortranTypeArray2D<AcKickerProxy>;
using AcKickerProxyArray3D = FortranTypeArray3D<AcKickerProxy>;

class Interval1CoefProxy;

using Interval1CoefProxyArray1D = FortranTypeArray1D<
    Interval1CoefProxy,
    allocate_fortran_interval1_coef_struct,
    deallocate_fortran_interval1_coef_struct>;
using Interval1CoefProxyArray2D = FortranTypeArray2D<Interval1CoefProxy>;
using Interval1CoefProxyArray3D = FortranTypeArray3D<Interval1CoefProxy>;

class PhotonReflectTableProxy;

using PhotonReflectTableProxyArray1D = FortranTypeArray1D<
    PhotonReflectTableProxy,
    allocate_fortran_photon_reflect_table_struct,
    deallocate_fortran_photon_reflect_table_struct>;
using PhotonReflectTableProxyArray2D =
    FortranTypeArray2D<PhotonReflectTableProxy>;
using PhotonReflectTableProxyArray3D =
    FortranTypeArray3D<PhotonReflectTableProxy>;

class PhotonReflectSurfaceProxy;

using PhotonReflectSurfaceProxyArray1D = FortranTypeArray1D<
    PhotonReflectSurfaceProxy,
    allocate_fortran_photon_reflect_surface_struct,
    deallocate_fortran_photon_reflect_surface_struct>;
using PhotonReflectSurfaceProxyArray2D =
    FortranTypeArray2D<PhotonReflectSurfaceProxy>;
using PhotonReflectSurfaceProxyArray3D =
    FortranTypeArray3D<PhotonReflectSurfaceProxy>;

class CoordProxy;

using CoordProxyArray1D = FortranTypeArray1D<
    CoordProxy,
    allocate_fortran_coord_struct,
    deallocate_fortran_coord_struct>;
using CoordProxyArray2D = FortranTypeArray2D<CoordProxy>;
using CoordProxyArray3D = FortranTypeArray3D<CoordProxy>;

class CoordArrayProxy;

using CoordArrayProxyArray1D = FortranTypeArray1D<
    CoordArrayProxy,
    allocate_fortran_coord_array_struct,
    deallocate_fortran_coord_array_struct>;
using CoordArrayProxyArray2D = FortranTypeArray2D<CoordArrayProxy>;
using CoordArrayProxyArray3D = FortranTypeArray3D<CoordArrayProxy>;

class BpmPhaseCouplingProxy;

using BpmPhaseCouplingProxyArray1D = FortranTypeArray1D<
    BpmPhaseCouplingProxy,
    allocate_fortran_bpm_phase_coupling_struct,
    deallocate_fortran_bpm_phase_coupling_struct>;
using BpmPhaseCouplingProxyArray2D = FortranTypeArray2D<BpmPhaseCouplingProxy>;
using BpmPhaseCouplingProxyArray3D = FortranTypeArray3D<BpmPhaseCouplingProxy>;

class ExpressionAtomProxy;

using ExpressionAtomProxyArray1D = FortranTypeArray1D<
    ExpressionAtomProxy,
    allocate_fortran_expression_atom_struct,
    deallocate_fortran_expression_atom_struct>;
using ExpressionAtomProxyArray2D = FortranTypeArray2D<ExpressionAtomProxy>;
using ExpressionAtomProxyArray3D = FortranTypeArray3D<ExpressionAtomProxy>;

class WakeSrZLongProxy;

using WakeSrZLongProxyArray1D = FortranTypeArray1D<
    WakeSrZLongProxy,
    allocate_fortran_wake_sr_z_long_struct,
    deallocate_fortran_wake_sr_z_long_struct>;
using WakeSrZLongProxyArray2D = FortranTypeArray2D<WakeSrZLongProxy>;
using WakeSrZLongProxyArray3D = FortranTypeArray3D<WakeSrZLongProxy>;

class WakeSrModeProxy;

using WakeSrModeProxyArray1D = FortranTypeArray1D<
    WakeSrModeProxy,
    allocate_fortran_wake_sr_mode_struct,
    deallocate_fortran_wake_sr_mode_struct>;
using WakeSrModeProxyArray2D = FortranTypeArray2D<WakeSrModeProxy>;
using WakeSrModeProxyArray3D = FortranTypeArray3D<WakeSrModeProxy>;

class WakeSrProxy;

using WakeSrProxyArray1D = FortranTypeArray1D<
    WakeSrProxy,
    allocate_fortran_wake_sr_struct,
    deallocate_fortran_wake_sr_struct>;
using WakeSrProxyArray2D = FortranTypeArray2D<WakeSrProxy>;
using WakeSrProxyArray3D = FortranTypeArray3D<WakeSrProxy>;

class WakeLrModeProxy;

using WakeLrModeProxyArray1D = FortranTypeArray1D<
    WakeLrModeProxy,
    allocate_fortran_wake_lr_mode_struct,
    deallocate_fortran_wake_lr_mode_struct>;
using WakeLrModeProxyArray2D = FortranTypeArray2D<WakeLrModeProxy>;
using WakeLrModeProxyArray3D = FortranTypeArray3D<WakeLrModeProxy>;

class WakeLrProxy;

using WakeLrProxyArray1D = FortranTypeArray1D<
    WakeLrProxy,
    allocate_fortran_wake_lr_struct,
    deallocate_fortran_wake_lr_struct>;
using WakeLrProxyArray2D = FortranTypeArray2D<WakeLrProxy>;
using WakeLrProxyArray3D = FortranTypeArray3D<WakeLrProxy>;

class LatEleLocProxy;

using LatEleLocProxyArray1D = FortranTypeArray1D<
    LatEleLocProxy,
    allocate_fortran_lat_ele_loc_struct,
    deallocate_fortran_lat_ele_loc_struct>;
using LatEleLocProxyArray2D = FortranTypeArray2D<LatEleLocProxy>;
using LatEleLocProxyArray3D = FortranTypeArray3D<LatEleLocProxy>;

class WakeProxy;

using WakeProxyArray1D = FortranTypeArray1D<
    WakeProxy,
    allocate_fortran_wake_struct,
    deallocate_fortran_wake_struct>;
using WakeProxyArray2D = FortranTypeArray2D<WakeProxy>;
using WakeProxyArray3D = FortranTypeArray3D<WakeProxy>;

class TaylorTermProxy;

using TaylorTermProxyArray1D = FortranTypeArray1D<
    TaylorTermProxy,
    allocate_fortran_taylor_term_struct,
    deallocate_fortran_taylor_term_struct>;
using TaylorTermProxyArray2D = FortranTypeArray2D<TaylorTermProxy>;
using TaylorTermProxyArray3D = FortranTypeArray3D<TaylorTermProxy>;

class TaylorProxy;

using TaylorProxyArray1D = FortranTypeArray1D<
    TaylorProxy,
    allocate_fortran_taylor_struct,
    deallocate_fortran_taylor_struct>;
using TaylorProxyArray2D = FortranTypeArray2D<TaylorProxy>;
using TaylorProxyArray3D = FortranTypeArray3D<TaylorProxy>;

class EmTaylorTermProxy;

using EmTaylorTermProxyArray1D = FortranTypeArray1D<
    EmTaylorTermProxy,
    allocate_fortran_em_taylor_term_struct,
    deallocate_fortran_em_taylor_term_struct>;
using EmTaylorTermProxyArray2D = FortranTypeArray2D<EmTaylorTermProxy>;
using EmTaylorTermProxyArray3D = FortranTypeArray3D<EmTaylorTermProxy>;

class EmTaylorProxy;

using EmTaylorProxyArray1D = FortranTypeArray1D<
    EmTaylorProxy,
    allocate_fortran_em_taylor_struct,
    deallocate_fortran_em_taylor_struct>;
using EmTaylorProxyArray2D = FortranTypeArray2D<EmTaylorProxy>;
using EmTaylorProxyArray3D = FortranTypeArray3D<EmTaylorProxy>;

class CartesianMapTerm1Proxy;

using CartesianMapTerm1ProxyArray1D = FortranTypeArray1D<
    CartesianMapTerm1Proxy,
    allocate_fortran_cartesian_map_term1_struct,
    deallocate_fortran_cartesian_map_term1_struct>;
using CartesianMapTerm1ProxyArray2D =
    FortranTypeArray2D<CartesianMapTerm1Proxy>;
using CartesianMapTerm1ProxyArray3D =
    FortranTypeArray3D<CartesianMapTerm1Proxy>;

class CartesianMapTermProxy;

using CartesianMapTermProxyArray1D = FortranTypeArray1D<
    CartesianMapTermProxy,
    allocate_fortran_cartesian_map_term_struct,
    deallocate_fortran_cartesian_map_term_struct>;
using CartesianMapTermProxyArray2D = FortranTypeArray2D<CartesianMapTermProxy>;
using CartesianMapTermProxyArray3D = FortranTypeArray3D<CartesianMapTermProxy>;

class CartesianMapProxy;

using CartesianMapProxyArray1D = FortranTypeArray1D<
    CartesianMapProxy,
    allocate_fortran_cartesian_map_struct,
    deallocate_fortran_cartesian_map_struct>;
using CartesianMapProxyArray2D = FortranTypeArray2D<CartesianMapProxy>;
using CartesianMapProxyArray3D = FortranTypeArray3D<CartesianMapProxy>;

class CylindricalMapTerm1Proxy;

using CylindricalMapTerm1ProxyArray1D = FortranTypeArray1D<
    CylindricalMapTerm1Proxy,
    allocate_fortran_cylindrical_map_term1_struct,
    deallocate_fortran_cylindrical_map_term1_struct>;
using CylindricalMapTerm1ProxyArray2D =
    FortranTypeArray2D<CylindricalMapTerm1Proxy>;
using CylindricalMapTerm1ProxyArray3D =
    FortranTypeArray3D<CylindricalMapTerm1Proxy>;

class CylindricalMapTermProxy;

using CylindricalMapTermProxyArray1D = FortranTypeArray1D<
    CylindricalMapTermProxy,
    allocate_fortran_cylindrical_map_term_struct,
    deallocate_fortran_cylindrical_map_term_struct>;
using CylindricalMapTermProxyArray2D =
    FortranTypeArray2D<CylindricalMapTermProxy>;
using CylindricalMapTermProxyArray3D =
    FortranTypeArray3D<CylindricalMapTermProxy>;

class CylindricalMapProxy;

using CylindricalMapProxyArray1D = FortranTypeArray1D<
    CylindricalMapProxy,
    allocate_fortran_cylindrical_map_struct,
    deallocate_fortran_cylindrical_map_struct>;
using CylindricalMapProxyArray2D = FortranTypeArray2D<CylindricalMapProxy>;
using CylindricalMapProxyArray3D = FortranTypeArray3D<CylindricalMapProxy>;

class BicubicCmplxCoefProxy;

using BicubicCmplxCoefProxyArray1D = FortranTypeArray1D<
    BicubicCmplxCoefProxy,
    allocate_fortran_bicubic_cmplx_coef_struct,
    deallocate_fortran_bicubic_cmplx_coef_struct>;
using BicubicCmplxCoefProxyArray2D = FortranTypeArray2D<BicubicCmplxCoefProxy>;
using BicubicCmplxCoefProxyArray3D = FortranTypeArray3D<BicubicCmplxCoefProxy>;

class TricubicCmplxCoefProxy;

using TricubicCmplxCoefProxyArray1D = FortranTypeArray1D<
    TricubicCmplxCoefProxy,
    allocate_fortran_tricubic_cmplx_coef_struct,
    deallocate_fortran_tricubic_cmplx_coef_struct>;
using TricubicCmplxCoefProxyArray2D =
    FortranTypeArray2D<TricubicCmplxCoefProxy>;
using TricubicCmplxCoefProxyArray3D =
    FortranTypeArray3D<TricubicCmplxCoefProxy>;

class GridFieldPt1Proxy;

using GridFieldPt1ProxyArray1D = FortranTypeArray1D<
    GridFieldPt1Proxy,
    allocate_fortran_grid_field_pt1_struct,
    deallocate_fortran_grid_field_pt1_struct>;
using GridFieldPt1ProxyArray2D = FortranTypeArray2D<GridFieldPt1Proxy>;
using GridFieldPt1ProxyArray3D = FortranTypeArray3D<GridFieldPt1Proxy>;

class GridFieldPtProxy;

using GridFieldPtProxyArray1D = FortranTypeArray1D<
    GridFieldPtProxy,
    allocate_fortran_grid_field_pt_struct,
    deallocate_fortran_grid_field_pt_struct>;
using GridFieldPtProxyArray2D = FortranTypeArray2D<GridFieldPtProxy>;
using GridFieldPtProxyArray3D = FortranTypeArray3D<GridFieldPtProxy>;

class GridFieldProxy;

using GridFieldProxyArray1D = FortranTypeArray1D<
    GridFieldProxy,
    allocate_fortran_grid_field_struct,
    deallocate_fortran_grid_field_struct>;
using GridFieldProxyArray2D = FortranTypeArray2D<GridFieldProxy>;
using GridFieldProxyArray3D = FortranTypeArray3D<GridFieldProxy>;

class FloorPositionProxy;

using FloorPositionProxyArray1D = FortranTypeArray1D<
    FloorPositionProxy,
    allocate_fortran_floor_position_struct,
    deallocate_fortran_floor_position_struct>;
using FloorPositionProxyArray2D = FortranTypeArray2D<FloorPositionProxy>;
using FloorPositionProxyArray3D = FortranTypeArray3D<FloorPositionProxy>;

class HighEnergySpaceChargeProxy;

using HighEnergySpaceChargeProxyArray1D = FortranTypeArray1D<
    HighEnergySpaceChargeProxy,
    allocate_fortran_high_energy_space_charge_struct,
    deallocate_fortran_high_energy_space_charge_struct>;
using HighEnergySpaceChargeProxyArray2D =
    FortranTypeArray2D<HighEnergySpaceChargeProxy>;
using HighEnergySpaceChargeProxyArray3D =
    FortranTypeArray3D<HighEnergySpaceChargeProxy>;

class XyDispProxy;

using XyDispProxyArray1D = FortranTypeArray1D<
    XyDispProxy,
    allocate_fortran_xy_disp_struct,
    deallocate_fortran_xy_disp_struct>;
using XyDispProxyArray2D = FortranTypeArray2D<XyDispProxy>;
using XyDispProxyArray3D = FortranTypeArray3D<XyDispProxy>;

class TwissProxy;

using TwissProxyArray1D = FortranTypeArray1D<
    TwissProxy,
    allocate_fortran_twiss_struct,
    deallocate_fortran_twiss_struct>;
using TwissProxyArray2D = FortranTypeArray2D<TwissProxy>;
using TwissProxyArray3D = FortranTypeArray3D<TwissProxy>;

class Mode3Proxy;

using Mode3ProxyArray1D = FortranTypeArray1D<
    Mode3Proxy,
    allocate_fortran_mode3_struct,
    deallocate_fortran_mode3_struct>;
using Mode3ProxyArray2D = FortranTypeArray2D<Mode3Proxy>;
using Mode3ProxyArray3D = FortranTypeArray3D<Mode3Proxy>;

class BookkeepingStateProxy;

using BookkeepingStateProxyArray1D = FortranTypeArray1D<
    BookkeepingStateProxy,
    allocate_fortran_bookkeeping_state_struct,
    deallocate_fortran_bookkeeping_state_struct>;
using BookkeepingStateProxyArray2D = FortranTypeArray2D<BookkeepingStateProxy>;
using BookkeepingStateProxyArray3D = FortranTypeArray3D<BookkeepingStateProxy>;

class RadMapProxy;

using RadMapProxyArray1D = FortranTypeArray1D<
    RadMapProxy,
    allocate_fortran_rad_map_struct,
    deallocate_fortran_rad_map_struct>;
using RadMapProxyArray2D = FortranTypeArray2D<RadMapProxy>;
using RadMapProxyArray3D = FortranTypeArray3D<RadMapProxy>;

class RadMapEleProxy;

using RadMapEleProxyArray1D = FortranTypeArray1D<
    RadMapEleProxy,
    allocate_fortran_rad_map_ele_struct,
    deallocate_fortran_rad_map_ele_struct>;
using RadMapEleProxyArray2D = FortranTypeArray2D<RadMapEleProxy>;
using RadMapEleProxyArray3D = FortranTypeArray3D<RadMapEleProxy>;

class GenGrad1Proxy;

using GenGrad1ProxyArray1D = FortranTypeArray1D<
    GenGrad1Proxy,
    allocate_fortran_gen_grad1_struct,
    deallocate_fortran_gen_grad1_struct>;
using GenGrad1ProxyArray2D = FortranTypeArray2D<GenGrad1Proxy>;
using GenGrad1ProxyArray3D = FortranTypeArray3D<GenGrad1Proxy>;

class GenGradMapProxy;

using GenGradMapProxyArray1D = FortranTypeArray1D<
    GenGradMapProxy,
    allocate_fortran_gen_grad_map_struct,
    deallocate_fortran_gen_grad_map_struct>;
using GenGradMapProxyArray2D = FortranTypeArray2D<GenGradMapProxy>;
using GenGradMapProxyArray3D = FortranTypeArray3D<GenGradMapProxy>;

class SurfaceSegmentedPtProxy;

using SurfaceSegmentedPtProxyArray1D = FortranTypeArray1D<
    SurfaceSegmentedPtProxy,
    allocate_fortran_surface_segmented_pt_struct,
    deallocate_fortran_surface_segmented_pt_struct>;
using SurfaceSegmentedPtProxyArray2D =
    FortranTypeArray2D<SurfaceSegmentedPtProxy>;
using SurfaceSegmentedPtProxyArray3D =
    FortranTypeArray3D<SurfaceSegmentedPtProxy>;

class SurfaceSegmentedProxy;

using SurfaceSegmentedProxyArray1D = FortranTypeArray1D<
    SurfaceSegmentedProxy,
    allocate_fortran_surface_segmented_struct,
    deallocate_fortran_surface_segmented_struct>;
using SurfaceSegmentedProxyArray2D = FortranTypeArray2D<SurfaceSegmentedProxy>;
using SurfaceSegmentedProxyArray3D = FortranTypeArray3D<SurfaceSegmentedProxy>;

class SurfaceHMisalignPtProxy;

using SurfaceHMisalignPtProxyArray1D = FortranTypeArray1D<
    SurfaceHMisalignPtProxy,
    allocate_fortran_surface_h_misalign_pt_struct,
    deallocate_fortran_surface_h_misalign_pt_struct>;
using SurfaceHMisalignPtProxyArray2D =
    FortranTypeArray2D<SurfaceHMisalignPtProxy>;
using SurfaceHMisalignPtProxyArray3D =
    FortranTypeArray3D<SurfaceHMisalignPtProxy>;

class SurfaceHMisalignProxy;

using SurfaceHMisalignProxyArray1D = FortranTypeArray1D<
    SurfaceHMisalignProxy,
    allocate_fortran_surface_h_misalign_struct,
    deallocate_fortran_surface_h_misalign_struct>;
using SurfaceHMisalignProxyArray2D = FortranTypeArray2D<SurfaceHMisalignProxy>;
using SurfaceHMisalignProxyArray3D = FortranTypeArray3D<SurfaceHMisalignProxy>;

class SurfaceDisplacementPtProxy;

using SurfaceDisplacementPtProxyArray1D = FortranTypeArray1D<
    SurfaceDisplacementPtProxy,
    allocate_fortran_surface_displacement_pt_struct,
    deallocate_fortran_surface_displacement_pt_struct>;
using SurfaceDisplacementPtProxyArray2D =
    FortranTypeArray2D<SurfaceDisplacementPtProxy>;
using SurfaceDisplacementPtProxyArray3D =
    FortranTypeArray3D<SurfaceDisplacementPtProxy>;

class SurfaceDisplacementProxy;

using SurfaceDisplacementProxyArray1D = FortranTypeArray1D<
    SurfaceDisplacementProxy,
    allocate_fortran_surface_displacement_struct,
    deallocate_fortran_surface_displacement_struct>;
using SurfaceDisplacementProxyArray2D =
    FortranTypeArray2D<SurfaceDisplacementProxy>;
using SurfaceDisplacementProxyArray3D =
    FortranTypeArray3D<SurfaceDisplacementProxy>;

class TargetPointProxy;

using TargetPointProxyArray1D = FortranTypeArray1D<
    TargetPointProxy,
    allocate_fortran_target_point_struct,
    deallocate_fortran_target_point_struct>;
using TargetPointProxyArray2D = FortranTypeArray2D<TargetPointProxy>;
using TargetPointProxyArray3D = FortranTypeArray3D<TargetPointProxy>;

class SurfaceCurvatureProxy;

using SurfaceCurvatureProxyArray1D = FortranTypeArray1D<
    SurfaceCurvatureProxy,
    allocate_fortran_surface_curvature_struct,
    deallocate_fortran_surface_curvature_struct>;
using SurfaceCurvatureProxyArray2D = FortranTypeArray2D<SurfaceCurvatureProxy>;
using SurfaceCurvatureProxyArray3D = FortranTypeArray3D<SurfaceCurvatureProxy>;

class PhotonTargetProxy;

using PhotonTargetProxyArray1D = FortranTypeArray1D<
    PhotonTargetProxy,
    allocate_fortran_photon_target_struct,
    deallocate_fortran_photon_target_struct>;
using PhotonTargetProxyArray2D = FortranTypeArray2D<PhotonTargetProxy>;
using PhotonTargetProxyArray3D = FortranTypeArray3D<PhotonTargetProxy>;

class PhotonMaterialProxy;

using PhotonMaterialProxyArray1D = FortranTypeArray1D<
    PhotonMaterialProxy,
    allocate_fortran_photon_material_struct,
    deallocate_fortran_photon_material_struct>;
using PhotonMaterialProxyArray2D = FortranTypeArray2D<PhotonMaterialProxy>;
using PhotonMaterialProxyArray3D = FortranTypeArray3D<PhotonMaterialProxy>;

class PixelPtProxy;

using PixelPtProxyArray1D = FortranTypeArray1D<
    PixelPtProxy,
    allocate_fortran_pixel_pt_struct,
    deallocate_fortran_pixel_pt_struct>;
using PixelPtProxyArray2D = FortranTypeArray2D<PixelPtProxy>;
using PixelPtProxyArray3D = FortranTypeArray3D<PixelPtProxy>;

class PixelDetecProxy;

using PixelDetecProxyArray1D = FortranTypeArray1D<
    PixelDetecProxy,
    allocate_fortran_pixel_detec_struct,
    deallocate_fortran_pixel_detec_struct>;
using PixelDetecProxyArray2D = FortranTypeArray2D<PixelDetecProxy>;
using PixelDetecProxyArray3D = FortranTypeArray3D<PixelDetecProxy>;

class PhotonElementProxy;

using PhotonElementProxyArray1D = FortranTypeArray1D<
    PhotonElementProxy,
    allocate_fortran_photon_element_struct,
    deallocate_fortran_photon_element_struct>;
using PhotonElementProxyArray2D = FortranTypeArray2D<PhotonElementProxy>;
using PhotonElementProxyArray3D = FortranTypeArray3D<PhotonElementProxy>;

class Wall3dVertexProxy;

using Wall3dVertexProxyArray1D = FortranTypeArray1D<
    Wall3dVertexProxy,
    allocate_fortran_wall3d_vertex_struct,
    deallocate_fortran_wall3d_vertex_struct>;
using Wall3dVertexProxyArray2D = FortranTypeArray2D<Wall3dVertexProxy>;
using Wall3dVertexProxyArray3D = FortranTypeArray3D<Wall3dVertexProxy>;

class Wall3dSectionProxy;

using Wall3dSectionProxyArray1D = FortranTypeArray1D<
    Wall3dSectionProxy,
    allocate_fortran_wall3d_section_struct,
    deallocate_fortran_wall3d_section_struct>;
using Wall3dSectionProxyArray2D = FortranTypeArray2D<Wall3dSectionProxy>;
using Wall3dSectionProxyArray3D = FortranTypeArray3D<Wall3dSectionProxy>;

class Wall3dProxy;

using Wall3dProxyArray1D = FortranTypeArray1D<
    Wall3dProxy,
    allocate_fortran_wall3d_struct,
    deallocate_fortran_wall3d_struct>;
using Wall3dProxyArray2D = FortranTypeArray2D<Wall3dProxy>;
using Wall3dProxyArray3D = FortranTypeArray3D<Wall3dProxy>;

class RamperLordProxy;

using RamperLordProxyArray1D = FortranTypeArray1D<
    RamperLordProxy,
    allocate_fortran_ramper_lord_struct,
    deallocate_fortran_ramper_lord_struct>;
using RamperLordProxyArray2D = FortranTypeArray2D<RamperLordProxy>;
using RamperLordProxyArray3D = FortranTypeArray3D<RamperLordProxy>;

class ControlProxy;

using ControlProxyArray1D = FortranTypeArray1D<
    ControlProxy,
    allocate_fortran_control_struct,
    deallocate_fortran_control_struct>;
using ControlProxyArray2D = FortranTypeArray2D<ControlProxy>;
using ControlProxyArray3D = FortranTypeArray3D<ControlProxy>;

class ControlVar1Proxy;

using ControlVar1ProxyArray1D = FortranTypeArray1D<
    ControlVar1Proxy,
    allocate_fortran_control_var1_struct,
    deallocate_fortran_control_var1_struct>;
using ControlVar1ProxyArray2D = FortranTypeArray2D<ControlVar1Proxy>;
using ControlVar1ProxyArray3D = FortranTypeArray3D<ControlVar1Proxy>;

class ControlRamp1Proxy;

using ControlRamp1ProxyArray1D = FortranTypeArray1D<
    ControlRamp1Proxy,
    allocate_fortran_control_ramp1_struct,
    deallocate_fortran_control_ramp1_struct>;
using ControlRamp1ProxyArray2D = FortranTypeArray2D<ControlRamp1Proxy>;
using ControlRamp1ProxyArray3D = FortranTypeArray3D<ControlRamp1Proxy>;

class ControllerProxy;

using ControllerProxyArray1D = FortranTypeArray1D<
    ControllerProxy,
    allocate_fortran_controller_struct,
    deallocate_fortran_controller_struct>;
using ControllerProxyArray2D = FortranTypeArray2D<ControllerProxy>;
using ControllerProxyArray3D = FortranTypeArray3D<ControllerProxy>;

class EllipseBeamInitProxy;

using EllipseBeamInitProxyArray1D = FortranTypeArray1D<
    EllipseBeamInitProxy,
    allocate_fortran_ellipse_beam_init_struct,
    deallocate_fortran_ellipse_beam_init_struct>;
using EllipseBeamInitProxyArray2D = FortranTypeArray2D<EllipseBeamInitProxy>;
using EllipseBeamInitProxyArray3D = FortranTypeArray3D<EllipseBeamInitProxy>;

class KvBeamInitProxy;

using KvBeamInitProxyArray1D = FortranTypeArray1D<
    KvBeamInitProxy,
    allocate_fortran_kv_beam_init_struct,
    deallocate_fortran_kv_beam_init_struct>;
using KvBeamInitProxyArray2D = FortranTypeArray2D<KvBeamInitProxy>;
using KvBeamInitProxyArray3D = FortranTypeArray3D<KvBeamInitProxy>;

class GridBeamInitProxy;

using GridBeamInitProxyArray1D = FortranTypeArray1D<
    GridBeamInitProxy,
    allocate_fortran_grid_beam_init_struct,
    deallocate_fortran_grid_beam_init_struct>;
using GridBeamInitProxyArray2D = FortranTypeArray2D<GridBeamInitProxy>;
using GridBeamInitProxyArray3D = FortranTypeArray3D<GridBeamInitProxy>;

class BeamInitProxy;

using BeamInitProxyArray1D = FortranTypeArray1D<
    BeamInitProxy,
    allocate_fortran_beam_init_struct,
    deallocate_fortran_beam_init_struct>;
using BeamInitProxyArray2D = FortranTypeArray2D<BeamInitProxy>;
using BeamInitProxyArray3D = FortranTypeArray3D<BeamInitProxy>;

class LatParamProxy;

using LatParamProxyArray1D = FortranTypeArray1D<
    LatParamProxy,
    allocate_fortran_lat_param_struct,
    deallocate_fortran_lat_param_struct>;
using LatParamProxyArray2D = FortranTypeArray2D<LatParamProxy>;
using LatParamProxyArray3D = FortranTypeArray3D<LatParamProxy>;

class ModeInfoProxy;

using ModeInfoProxyArray1D = FortranTypeArray1D<
    ModeInfoProxy,
    allocate_fortran_mode_info_struct,
    deallocate_fortran_mode_info_struct>;
using ModeInfoProxyArray2D = FortranTypeArray2D<ModeInfoProxy>;
using ModeInfoProxyArray3D = FortranTypeArray3D<ModeInfoProxy>;

class PreTrackerProxy;

using PreTrackerProxyArray1D = FortranTypeArray1D<
    PreTrackerProxy,
    allocate_fortran_pre_tracker_struct,
    deallocate_fortran_pre_tracker_struct>;
using PreTrackerProxyArray2D = FortranTypeArray2D<PreTrackerProxy>;
using PreTrackerProxyArray3D = FortranTypeArray3D<PreTrackerProxy>;

class AnormalModeProxy;

using AnormalModeProxyArray1D = FortranTypeArray1D<
    AnormalModeProxy,
    allocate_fortran_anormal_mode_struct,
    deallocate_fortran_anormal_mode_struct>;
using AnormalModeProxyArray2D = FortranTypeArray2D<AnormalModeProxy>;
using AnormalModeProxyArray3D = FortranTypeArray3D<AnormalModeProxy>;

class LinacNormalModeProxy;

using LinacNormalModeProxyArray1D = FortranTypeArray1D<
    LinacNormalModeProxy,
    allocate_fortran_linac_normal_mode_struct,
    deallocate_fortran_linac_normal_mode_struct>;
using LinacNormalModeProxyArray2D = FortranTypeArray2D<LinacNormalModeProxy>;
using LinacNormalModeProxyArray3D = FortranTypeArray3D<LinacNormalModeProxy>;

class NormalModesProxy;

using NormalModesProxyArray1D = FortranTypeArray1D<
    NormalModesProxy,
    allocate_fortran_normal_modes_struct,
    deallocate_fortran_normal_modes_struct>;
using NormalModesProxyArray2D = FortranTypeArray2D<NormalModesProxy>;
using NormalModesProxyArray3D = FortranTypeArray3D<NormalModesProxy>;

class EmFieldProxy;

using EmFieldProxyArray1D = FortranTypeArray1D<
    EmFieldProxy,
    allocate_fortran_em_field_struct,
    deallocate_fortran_em_field_struct>;
using EmFieldProxyArray2D = FortranTypeArray2D<EmFieldProxy>;
using EmFieldProxyArray3D = FortranTypeArray3D<EmFieldProxy>;

class StrongBeamProxy;

using StrongBeamProxyArray1D = FortranTypeArray1D<
    StrongBeamProxy,
    allocate_fortran_strong_beam_struct,
    deallocate_fortran_strong_beam_struct>;
using StrongBeamProxyArray2D = FortranTypeArray2D<StrongBeamProxy>;
using StrongBeamProxyArray3D = FortranTypeArray3D<StrongBeamProxy>;

class TrackPointProxy;

using TrackPointProxyArray1D = FortranTypeArray1D<
    TrackPointProxy,
    allocate_fortran_track_point_struct,
    deallocate_fortran_track_point_struct>;
using TrackPointProxyArray2D = FortranTypeArray2D<TrackPointProxy>;
using TrackPointProxyArray3D = FortranTypeArray3D<TrackPointProxy>;

class TrackProxy;

using TrackProxyArray1D = FortranTypeArray1D<
    TrackProxy,
    allocate_fortran_track_struct,
    deallocate_fortran_track_struct>;
using TrackProxyArray2D = FortranTypeArray2D<TrackProxy>;
using TrackProxyArray3D = FortranTypeArray3D<TrackProxy>;

class SpaceChargeCommonProxy;

using SpaceChargeCommonProxyArray1D = FortranTypeArray1D<
    SpaceChargeCommonProxy,
    allocate_fortran_space_charge_common_struct,
    deallocate_fortran_space_charge_common_struct>;
using SpaceChargeCommonProxyArray2D =
    FortranTypeArray2D<SpaceChargeCommonProxy>;
using SpaceChargeCommonProxyArray3D =
    FortranTypeArray3D<SpaceChargeCommonProxy>;

class BmadCommonProxy;

using BmadCommonProxyArray1D = FortranTypeArray1D<
    BmadCommonProxy,
    allocate_fortran_bmad_common_struct,
    deallocate_fortran_bmad_common_struct>;
using BmadCommonProxyArray2D = FortranTypeArray2D<BmadCommonProxy>;
using BmadCommonProxyArray3D = FortranTypeArray3D<BmadCommonProxy>;

class RadInt1Proxy;

using RadInt1ProxyArray1D = FortranTypeArray1D<
    RadInt1Proxy,
    allocate_fortran_rad_int1_struct,
    deallocate_fortran_rad_int1_struct>;
using RadInt1ProxyArray2D = FortranTypeArray2D<RadInt1Proxy>;
using RadInt1ProxyArray3D = FortranTypeArray3D<RadInt1Proxy>;

class RadIntBranchProxy;

using RadIntBranchProxyArray1D = FortranTypeArray1D<
    RadIntBranchProxy,
    allocate_fortran_rad_int_branch_struct,
    deallocate_fortran_rad_int_branch_struct>;
using RadIntBranchProxyArray2D = FortranTypeArray2D<RadIntBranchProxy>;
using RadIntBranchProxyArray3D = FortranTypeArray3D<RadIntBranchProxy>;

class RadIntAllEleProxy;

using RadIntAllEleProxyArray1D = FortranTypeArray1D<
    RadIntAllEleProxy,
    allocate_fortran_rad_int_all_ele_struct,
    deallocate_fortran_rad_int_all_ele_struct>;
using RadIntAllEleProxyArray2D = FortranTypeArray2D<RadIntAllEleProxy>;
using RadIntAllEleProxyArray3D = FortranTypeArray3D<RadIntAllEleProxy>;

class RfStairStepProxy;

using RfStairStepProxyArray1D = FortranTypeArray1D<
    RfStairStepProxy,
    allocate_fortran_rf_stair_step_struct,
    deallocate_fortran_rf_stair_step_struct>;
using RfStairStepProxyArray2D = FortranTypeArray2D<RfStairStepProxy>;
using RfStairStepProxyArray3D = FortranTypeArray3D<RfStairStepProxy>;

class RfEleProxy;

using RfEleProxyArray1D = FortranTypeArray1D<
    RfEleProxy,
    allocate_fortran_rf_ele_struct,
    deallocate_fortran_rf_ele_struct>;
using RfEleProxyArray2D = FortranTypeArray2D<RfEleProxy>;
using RfEleProxyArray3D = FortranTypeArray3D<RfEleProxy>;

class EleProxy;

using EleProxyArray1D = FortranTypeArray1D<
    EleProxy,
    allocate_fortran_ele_struct,
    deallocate_fortran_ele_struct>;
using EleProxyArray2D = FortranTypeArray2D<EleProxy>;
using EleProxyArray3D = FortranTypeArray3D<EleProxy>;

class ComplexTaylorTermProxy;

using ComplexTaylorTermProxyArray1D = FortranTypeArray1D<
    ComplexTaylorTermProxy,
    allocate_fortran_complex_taylor_term_struct,
    deallocate_fortran_complex_taylor_term_struct>;
using ComplexTaylorTermProxyArray2D =
    FortranTypeArray2D<ComplexTaylorTermProxy>;
using ComplexTaylorTermProxyArray3D =
    FortranTypeArray3D<ComplexTaylorTermProxy>;

class ComplexTaylorProxy;

using ComplexTaylorProxyArray1D = FortranTypeArray1D<
    ComplexTaylorProxy,
    allocate_fortran_complex_taylor_struct,
    deallocate_fortran_complex_taylor_struct>;
using ComplexTaylorProxyArray2D = FortranTypeArray2D<ComplexTaylorProxy>;
using ComplexTaylorProxyArray3D = FortranTypeArray3D<ComplexTaylorProxy>;

class BranchProxy;

using BranchProxyArray1D = FortranTypeArray1D<
    BranchProxy,
    allocate_fortran_branch_struct,
    deallocate_fortran_branch_struct>;
using BranchProxyArray2D = FortranTypeArray2D<BranchProxy>;
using BranchProxyArray3D = FortranTypeArray3D<BranchProxy>;

class LatProxy;

using LatProxyArray1D = FortranTypeArray1D<
    LatProxy,
    allocate_fortran_lat_struct,
    deallocate_fortran_lat_struct>;
using LatProxyArray2D = FortranTypeArray2D<LatProxy>;
using LatProxyArray3D = FortranTypeArray3D<LatProxy>;

class BunchProxy;

using BunchProxyArray1D = FortranTypeArray1D<
    BunchProxy,
    allocate_fortran_bunch_struct,
    deallocate_fortran_bunch_struct>;
using BunchProxyArray2D = FortranTypeArray2D<BunchProxy>;
using BunchProxyArray3D = FortranTypeArray3D<BunchProxy>;

class BunchParamsProxy;

using BunchParamsProxyArray1D = FortranTypeArray1D<
    BunchParamsProxy,
    allocate_fortran_bunch_params_struct,
    deallocate_fortran_bunch_params_struct>;
using BunchParamsProxyArray2D = FortranTypeArray2D<BunchParamsProxy>;
using BunchParamsProxyArray3D = FortranTypeArray3D<BunchParamsProxy>;

class BeamProxy;

using BeamProxyArray1D = FortranTypeArray1D<
    BeamProxy,
    allocate_fortran_beam_struct,
    deallocate_fortran_beam_struct>;
using BeamProxyArray2D = FortranTypeArray2D<BeamProxy>;
using BeamProxyArray3D = FortranTypeArray3D<BeamProxy>;

class AperturePointProxy;

using AperturePointProxyArray1D = FortranTypeArray1D<
    AperturePointProxy,
    allocate_fortran_aperture_point_struct,
    deallocate_fortran_aperture_point_struct>;
using AperturePointProxyArray2D = FortranTypeArray2D<AperturePointProxy>;
using AperturePointProxyArray3D = FortranTypeArray3D<AperturePointProxy>;

class ApertureParamProxy;

using ApertureParamProxyArray1D = FortranTypeArray1D<
    ApertureParamProxy,
    allocate_fortran_aperture_param_struct,
    deallocate_fortran_aperture_param_struct>;
using ApertureParamProxyArray2D = FortranTypeArray2D<ApertureParamProxy>;
using ApertureParamProxyArray3D = FortranTypeArray3D<ApertureParamProxy>;

class ApertureScanProxy;

using ApertureScanProxyArray1D = FortranTypeArray1D<
    ApertureScanProxy,
    allocate_fortran_aperture_scan_struct,
    deallocate_fortran_aperture_scan_struct>;
using ApertureScanProxyArray2D = FortranTypeArray2D<ApertureScanProxy>;
using ApertureScanProxyArray3D = FortranTypeArray3D<ApertureScanProxy>;

class TaoSpinDnDpzProxy;

using TaoSpinDnDpzProxyArray1D = FortranTypeArray1D<
    TaoSpinDnDpzProxy,
    allocate_fortran_tao_spin_dn_dpz_struct,
    deallocate_fortran_tao_spin_dn_dpz_struct>;
using TaoSpinDnDpzProxyArray2D = FortranTypeArray2D<TaoSpinDnDpzProxy>;
using TaoSpinDnDpzProxyArray3D = FortranTypeArray3D<TaoSpinDnDpzProxy>;

class ResonanceHProxy;

using ResonanceHProxyArray1D = FortranTypeArray1D<
    ResonanceHProxy,
    allocate_fortran_resonance_h_struct,
    deallocate_fortran_resonance_h_struct>;
using ResonanceHProxyArray2D = FortranTypeArray2D<ResonanceHProxy>;
using ResonanceHProxyArray3D = FortranTypeArray3D<ResonanceHProxy>;

class SpinOrbitMap1Proxy;

using SpinOrbitMap1ProxyArray1D = FortranTypeArray1D<
    SpinOrbitMap1Proxy,
    allocate_fortran_spin_orbit_map1_struct,
    deallocate_fortran_spin_orbit_map1_struct>;
using SpinOrbitMap1ProxyArray2D = FortranTypeArray2D<SpinOrbitMap1Proxy>;
using SpinOrbitMap1ProxyArray3D = FortranTypeArray3D<SpinOrbitMap1Proxy>;

class SpinAxisProxy;

using SpinAxisProxyArray1D = FortranTypeArray1D<
    SpinAxisProxy,
    allocate_fortran_spin_axis_struct,
    deallocate_fortran_spin_axis_struct>;
using SpinAxisProxyArray2D = FortranTypeArray2D<SpinAxisProxy>;
using SpinAxisProxyArray3D = FortranTypeArray3D<SpinAxisProxy>;

class PtcNormalFormProxy;

using PtcNormalFormProxyArray1D = FortranTypeArray1D<
    PtcNormalFormProxy,
    allocate_fortran_ptc_normal_form_struct,
    deallocate_fortran_ptc_normal_form_struct>;
using PtcNormalFormProxyArray2D = FortranTypeArray2D<PtcNormalFormProxy>;
using PtcNormalFormProxyArray3D = FortranTypeArray3D<PtcNormalFormProxy>;

class BmadNormalFormProxy;

using BmadNormalFormProxyArray1D = FortranTypeArray1D<
    BmadNormalFormProxy,
    allocate_fortran_bmad_normal_form_struct,
    deallocate_fortran_bmad_normal_form_struct>;
using BmadNormalFormProxyArray2D = FortranTypeArray2D<BmadNormalFormProxy>;
using BmadNormalFormProxyArray3D = FortranTypeArray3D<BmadNormalFormProxy>;

class BunchTrackProxy;

using BunchTrackProxyArray1D = FortranTypeArray1D<
    BunchTrackProxy,
    allocate_fortran_bunch_track_struct,
    deallocate_fortran_bunch_track_struct>;
using BunchTrackProxyArray2D = FortranTypeArray2D<BunchTrackProxy>;
using BunchTrackProxyArray3D = FortranTypeArray3D<BunchTrackProxy>;

class SummationRdtProxy;

using SummationRdtProxyArray1D = FortranTypeArray1D<
    SummationRdtProxy,
    allocate_fortran_summation_rdt_struct,
    deallocate_fortran_summation_rdt_struct>;
using SummationRdtProxyArray2D = FortranTypeArray2D<SummationRdtProxy>;
using SummationRdtProxyArray3D = FortranTypeArray3D<SummationRdtProxy>;

class LatEleOrder1Proxy;

using LatEleOrder1ProxyArray1D = FortranTypeArray1D<
    LatEleOrder1Proxy,
    allocate_fortran_lat_ele_order1_struct,
    deallocate_fortran_lat_ele_order1_struct>;
using LatEleOrder1ProxyArray2D = FortranTypeArray2D<LatEleOrder1Proxy>;
using LatEleOrder1ProxyArray3D = FortranTypeArray3D<LatEleOrder1Proxy>;

class LatEleOrderArrayProxy;

using LatEleOrderArrayProxyArray1D = FortranTypeArray1D<
    LatEleOrderArrayProxy,
    allocate_fortran_lat_ele_order_array_struct,
    deallocate_fortran_lat_ele_order_array_struct>;
using LatEleOrderArrayProxyArray2D = FortranTypeArray2D<LatEleOrderArrayProxy>;
using LatEleOrderArrayProxyArray3D = FortranTypeArray3D<LatEleOrderArrayProxy>;

class TaoLatSigmaProxy;

using TaoLatSigmaProxyArray1D = FortranTypeArray1D<
    TaoLatSigmaProxy,
    allocate_fortran_tao_lat_sigma_struct,
    deallocate_fortran_tao_lat_sigma_struct>;
using TaoLatSigmaProxyArray2D = FortranTypeArray2D<TaoLatSigmaProxy>;
using TaoLatSigmaProxyArray3D = FortranTypeArray3D<TaoLatSigmaProxy>;

class TaoSpinEleProxy;

using TaoSpinEleProxyArray1D = FortranTypeArray1D<
    TaoSpinEleProxy,
    allocate_fortran_tao_spin_ele_struct,
    deallocate_fortran_tao_spin_ele_struct>;
using TaoSpinEleProxyArray2D = FortranTypeArray2D<TaoSpinEleProxy>;
using TaoSpinEleProxyArray3D = FortranTypeArray3D<TaoSpinEleProxy>;

class TaoPlotCacheProxy;

using TaoPlotCacheProxyArray1D = FortranTypeArray1D<
    TaoPlotCacheProxy,
    allocate_fortran_tao_plot_cache_struct,
    deallocate_fortran_tao_plot_cache_struct>;
using TaoPlotCacheProxyArray2D = FortranTypeArray2D<TaoPlotCacheProxy>;
using TaoPlotCacheProxyArray3D = FortranTypeArray3D<TaoPlotCacheProxy>;

class TaoSpinPolarizationProxy;

using TaoSpinPolarizationProxyArray1D = FortranTypeArray1D<
    TaoSpinPolarizationProxy,
    allocate_fortran_tao_spin_polarization_struct,
    deallocate_fortran_tao_spin_polarization_struct>;
using TaoSpinPolarizationProxyArray2D =
    FortranTypeArray2D<TaoSpinPolarizationProxy>;
using TaoSpinPolarizationProxyArray3D =
    FortranTypeArray3D<TaoSpinPolarizationProxy>;

class TaoLatticeBranchProxy;

using TaoLatticeBranchProxyArray1D = FortranTypeArray1D<
    TaoLatticeBranchProxy,
    allocate_fortran_tao_lattice_branch_struct,
    deallocate_fortran_tao_lattice_branch_struct>;
using TaoLatticeBranchProxyArray2D = FortranTypeArray2D<TaoLatticeBranchProxy>;
using TaoLatticeBranchProxyArray3D = FortranTypeArray3D<TaoLatticeBranchProxy>;

class TaoModelElementProxy;

using TaoModelElementProxyArray1D = FortranTypeArray1D<
    TaoModelElementProxy,
    allocate_fortran_tao_model_element_struct,
    deallocate_fortran_tao_model_element_struct>;
using TaoModelElementProxyArray2D = FortranTypeArray2D<TaoModelElementProxy>;
using TaoModelElementProxyArray3D = FortranTypeArray3D<TaoModelElementProxy>;

class TaoBeamBranchProxy;

using TaoBeamBranchProxyArray1D = FortranTypeArray1D<
    TaoBeamBranchProxy,
    allocate_fortran_tao_beam_branch_struct,
    deallocate_fortran_tao_beam_branch_struct>;
using TaoBeamBranchProxyArray2D = FortranTypeArray2D<TaoBeamBranchProxy>;
using TaoBeamBranchProxyArray3D = FortranTypeArray3D<TaoBeamBranchProxy>;

class TaoD1DataProxy;

using TaoD1DataProxyArray1D = FortranTypeArray1D<
    TaoD1DataProxy,
    allocate_fortran_tao_d1_data_struct,
    deallocate_fortran_tao_d1_data_struct>;
using TaoD1DataProxyArray2D = FortranTypeArray2D<TaoD1DataProxy>;
using TaoD1DataProxyArray3D = FortranTypeArray3D<TaoD1DataProxy>;

class TaoLatticeProxy;

using TaoLatticeProxyArray1D = FortranTypeArray1D<
    TaoLatticeProxy,
    allocate_fortran_tao_lattice_struct,
    deallocate_fortran_tao_lattice_struct>;
using TaoLatticeProxyArray2D = FortranTypeArray2D<TaoLatticeProxy>;
using TaoLatticeProxyArray3D = FortranTypeArray3D<TaoLatticeProxy>;

class TaoBeamUniProxy;

using TaoBeamUniProxyArray1D = FortranTypeArray1D<
    TaoBeamUniProxy,
    allocate_fortran_tao_beam_uni_struct,
    deallocate_fortran_tao_beam_uni_struct>;
using TaoBeamUniProxyArray2D = FortranTypeArray2D<TaoBeamUniProxy>;
using TaoBeamUniProxyArray3D = FortranTypeArray3D<TaoBeamUniProxy>;

class TaoDynamicApertureProxy;

using TaoDynamicApertureProxyArray1D = FortranTypeArray1D<
    TaoDynamicApertureProxy,
    allocate_fortran_tao_dynamic_aperture_struct,
    deallocate_fortran_tao_dynamic_aperture_struct>;
using TaoDynamicApertureProxyArray2D =
    FortranTypeArray2D<TaoDynamicApertureProxy>;
using TaoDynamicApertureProxyArray3D =
    FortranTypeArray3D<TaoDynamicApertureProxy>;

class TaoModelBranchProxy;

using TaoModelBranchProxyArray1D = FortranTypeArray1D<
    TaoModelBranchProxy,
    allocate_fortran_tao_model_branch_struct,
    deallocate_fortran_tao_model_branch_struct>;
using TaoModelBranchProxyArray2D = FortranTypeArray2D<TaoModelBranchProxy>;
using TaoModelBranchProxyArray3D = FortranTypeArray3D<TaoModelBranchProxy>;

class TaoD2DataProxy;

using TaoD2DataProxyArray1D = FortranTypeArray1D<
    TaoD2DataProxy,
    allocate_fortran_tao_d2_data_struct,
    deallocate_fortran_tao_d2_data_struct>;
using TaoD2DataProxyArray2D = FortranTypeArray2D<TaoD2DataProxy>;
using TaoD2DataProxyArray3D = FortranTypeArray3D<TaoD2DataProxy>;

class TaoSpinMapProxy;

using TaoSpinMapProxyArray1D = FortranTypeArray1D<
    TaoSpinMapProxy,
    allocate_fortran_tao_spin_map_struct,
    deallocate_fortran_tao_spin_map_struct>;
using TaoSpinMapProxyArray2D = FortranTypeArray2D<TaoSpinMapProxy>;
using TaoSpinMapProxyArray3D = FortranTypeArray3D<TaoSpinMapProxy>;

class TaoDataProxy;

using TaoDataProxyArray1D = FortranTypeArray1D<
    TaoDataProxy,
    allocate_fortran_tao_data_struct,
    deallocate_fortran_tao_data_struct>;
using TaoDataProxyArray2D = FortranTypeArray2D<TaoDataProxy>;
using TaoDataProxyArray3D = FortranTypeArray3D<TaoDataProxy>;

class TaoPingScaleProxy;

using TaoPingScaleProxyArray1D = FortranTypeArray1D<
    TaoPingScaleProxy,
    allocate_fortran_tao_ping_scale_struct,
    deallocate_fortran_tao_ping_scale_struct>;
using TaoPingScaleProxyArray2D = FortranTypeArray2D<TaoPingScaleProxy>;
using TaoPingScaleProxyArray3D = FortranTypeArray3D<TaoPingScaleProxy>;

class TaoUniverseCalcProxy;

using TaoUniverseCalcProxyArray1D = FortranTypeArray1D<
    TaoUniverseCalcProxy,
    allocate_fortran_tao_universe_calc_struct,
    deallocate_fortran_tao_universe_calc_struct>;
using TaoUniverseCalcProxyArray2D = FortranTypeArray2D<TaoUniverseCalcProxy>;
using TaoUniverseCalcProxyArray3D = FortranTypeArray3D<TaoUniverseCalcProxy>;

class LatEleOrderProxy;

using LatEleOrderProxyArray1D = FortranTypeArray1D<
    LatEleOrderProxy,
    allocate_fortran_lat_ele_order_struct,
    deallocate_fortran_lat_ele_order_struct>;
using LatEleOrderProxyArray2D = FortranTypeArray2D<LatEleOrderProxy>;
using LatEleOrderProxyArray3D = FortranTypeArray3D<LatEleOrderProxy>;

class TaoUniverseProxy;

using TaoUniverseProxyArray1D = FortranTypeArray1D<
    TaoUniverseProxy,
    allocate_fortran_tao_universe_struct,
    deallocate_fortran_tao_universe_struct>;
using TaoUniverseProxyArray2D = FortranTypeArray2D<TaoUniverseProxy>;
using TaoUniverseProxyArray3D = FortranTypeArray3D<TaoUniverseProxy>;

template <>
struct FortranTraits<SplineProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_spline_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_spline_struct(ptr, 0);
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
  void set_x0(double value);
  double y0() const; // 0D_NOT_real
  void set_y0(double value);
  double x1() const; // 0D_NOT_real
  void set_x1(double value);
  FortranArray1D<double> coef() const; // 1D_NOT_real
};

template <>
struct FortranTraits<SpinPolarProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_spin_polar_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_spin_polar_struct(ptr, 0);
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
  void set_polarization(double value);
  double theta() const; // 0D_NOT_real
  void set_theta(double value);
  double phi() const; // 0D_NOT_real
  void set_phi(double value);
  double xi() const; // 0D_NOT_real
  void set_xi(double value);
};

template <>
struct FortranTraits<AcKickerTimeProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_ac_kicker_time_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ac_kicker_time_struct(ptr, 0);
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
  void set_amp(double value);
  double time() const; // 0D_NOT_real
  void set_time(double value);
  SplineProxy spline() const; // 0D_NOT_type
  void set_spline(const SplineProxy& src);
};

template <>
struct FortranTraits<AcKickerFreqProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_ac_kicker_freq_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ac_kicker_freq_struct(ptr, 0);
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
  void set_f(double value);
  double amp() const; // 0D_NOT_real
  void set_amp(double value);
  double phi() const; // 0D_NOT_real
  void set_phi(double value);
  int rf_clock_harmonic() const; // 0D_NOT_integer
  void set_rf_clock_harmonic(int value);
};

template <>
struct FortranTraits<AcKickerProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_ac_kicker_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ac_kicker_struct(ptr, 0);
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

  AcKickerTimeProxyArray1D amp_vs_time() const; // 1D_ALLOC_type
  AcKickerFreqProxyArray1D frequency() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<Interval1CoefProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_interval1_coef_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_interval1_coef_struct(ptr, 0);
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
  void set_c0(double value);
  double c1() const; // 0D_NOT_real
  void set_c1(double value);
  double n_exp() const; // 0D_NOT_real
  void set_n_exp(double value);
};

template <>
struct FortranTraits<PhotonReflectTableProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_photon_reflect_table_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_reflect_table_struct(ptr, 0);
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
  Interval1CoefProxyArray1D int1() const; // 1D_ALLOC_type
  FortranArray2D<double> p_reflect() const; // 2D_ALLOC_real
  double max_energy() const; // 0D_NOT_real
  void set_max_energy(double value);
  FortranArray1D<double> p_reflect_scratch() const; // 1D_ALLOC_real
  FortranArray1D<double> bragg_angle() const; // 1D_ALLOC_real
};

template <>
struct FortranTraits<PhotonReflectSurfaceProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_photon_reflect_surface_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_reflect_surface_struct(ptr, 0);
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
  void set_name(const std::string& value);
  std::string description() const; // 0D_NOT_character
  void set_description(const std::string& value);
  std::string reflectivity_file() const; // 0D_NOT_character
  void set_reflectivity_file(const std::string& value);
  PhotonReflectTableProxyArray1D table() const; // 1D_ALLOC_type
  double surface_roughness_rms() const; // 0D_NOT_real
  void set_surface_roughness_rms(double value);
  double roughness_correlation_len() const; // 0D_NOT_real
  void set_roughness_correlation_len(double value);
  int ix_surface() const; // 0D_NOT_integer
  void set_ix_surface(int value);
};

template <>
struct FortranTraits<CoordProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_coord_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_coord_struct(ptr, 0);
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
  void set_s(double value);
  long double t() const; // 0D_NOT_real16
  void set_t(long double value);
  FortranArray1D<double> spin() const; // 1D_NOT_real
  FortranArray1D<double> field() const; // 1D_NOT_real
  FortranArray1D<double> phase() const; // 1D_NOT_real
  double charge() const; // 0D_NOT_real
  void set_charge(double value);
  double dt_ref() const; // 0D_NOT_real
  void set_dt_ref(double value);
  double r() const; // 0D_NOT_real
  void set_r(double value);
  double p0c() const; // 0D_NOT_real
  void set_p0c(double value);
  double E_potential() const; // 0D_NOT_real
  void set_E_potential(double value);
  double beta() const; // 0D_NOT_real
  void set_beta(double value);
  int ix_ele() const; // 0D_NOT_integer
  void set_ix_ele(int value);
  int ix_branch() const; // 0D_NOT_integer
  void set_ix_branch(int value);
  int ix_turn() const; // 0D_NOT_integer
  void set_ix_turn(int value);
  int ix_user() const; // 0D_NOT_integer
  void set_ix_user(int value);
  int state() const; // 0D_NOT_integer
  void set_state(int value);
  int direction() const; // 0D_NOT_integer
  void set_direction(int value);
  int time_dir() const; // 0D_NOT_integer
  void set_time_dir(int value);
  int species() const; // 0D_NOT_integer
  void set_species(int value);
  int location() const; // 0D_NOT_integer
  void set_location(int value);
};

template <>
struct FortranTraits<CoordArrayProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_coord_array_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_coord_array_struct(ptr, 0);
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

  CoordProxyArray1D orbit() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<BpmPhaseCouplingProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_bpm_phase_coupling_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bpm_phase_coupling_struct(ptr, 0);
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
  void set_K_22a(double value);
  double K_12a() const; // 0D_NOT_real
  void set_K_12a(double value);
  double K_11b() const; // 0D_NOT_real
  void set_K_11b(double value);
  double K_12b() const; // 0D_NOT_real
  void set_K_12b(double value);
  double Cbar22_a() const; // 0D_NOT_real
  void set_Cbar22_a(double value);
  double Cbar12_a() const; // 0D_NOT_real
  void set_Cbar12_a(double value);
  double Cbar11_b() const; // 0D_NOT_real
  void set_Cbar11_b(double value);
  double Cbar12_b() const; // 0D_NOT_real
  void set_Cbar12_b(double value);
  double phi_a() const; // 0D_NOT_real
  void set_phi_a(double value);
  double phi_b() const; // 0D_NOT_real
  void set_phi_b(double value);
};

template <>
struct FortranTraits<ExpressionAtomProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_expression_atom_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_expression_atom_struct(ptr, 0);
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
  void set_name(const std::string& value);
  int type() const; // 0D_NOT_integer
  void set_type(int value);
  double value() const; // 0D_NOT_real
  void set_value(double value);
};

template <>
struct FortranTraits<WakeSrZLongProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wake_sr_z_long_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_sr_z_long_struct(ptr, 0);
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
  FortranArray1D<std::complex<double>> fw() const; // 1D_ALLOC_complex
  FortranArray1D<std::complex<double>> fbunch() const; // 1D_ALLOC_complex
  FortranArray1D<std::complex<double>> w_out() const; // 1D_ALLOC_complex
  double dz() const; // 0D_NOT_real
  void set_dz(double value);
  double z0() const; // 0D_NOT_real
  void set_z0(double value);
  double smoothing_sigma() const; // 0D_NOT_real
  void set_smoothing_sigma(double value);
  int position_dependence() const; // 0D_NOT_integer
  void set_position_dependence(int value);
  bool time_based() const; // 0D_NOT_logical
  void set_time_based(bool value);
};

template <>
struct FortranTraits<WakeSrModeProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wake_sr_mode_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_sr_mode_struct(ptr, 0);
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
  void set_amp(double value);
  double damp() const; // 0D_NOT_real
  void set_damp(double value);
  double k() const; // 0D_NOT_real
  void set_k(double value);
  double phi() const; // 0D_NOT_real
  void set_phi(double value);
  double b_sin() const; // 0D_NOT_real
  void set_b_sin(double value);
  double b_cos() const; // 0D_NOT_real
  void set_b_cos(double value);
  double a_sin() const; // 0D_NOT_real
  void set_a_sin(double value);
  double a_cos() const; // 0D_NOT_real
  void set_a_cos(double value);
  int polarization() const; // 0D_NOT_integer
  void set_polarization(int value);
  int position_dependence() const; // 0D_NOT_integer
  void set_position_dependence(int value);
};

template <>
struct FortranTraits<WakeSrProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wake_sr_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_sr_struct(ptr, 0);
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
  void set_file(const std::string& value);
  WakeSrZLongProxy z_long() const; // 0D_NOT_type
  void set_z_long(const WakeSrZLongProxy& src);
  WakeSrModeProxyArray1D long_wake() const; // 1D_ALLOC_type
  WakeSrModeProxyArray1D trans_wake() const; // 1D_ALLOC_type
  double z_ref_long() const; // 0D_NOT_real
  void set_z_ref_long(double value);
  double z_ref_trans() const; // 0D_NOT_real
  void set_z_ref_trans(double value);
  double z_max() const; // 0D_NOT_real
  void set_z_max(double value);
  double amp_scale() const; // 0D_NOT_real
  void set_amp_scale(double value);
  double z_scale() const; // 0D_NOT_real
  void set_z_scale(double value);
  bool scale_with_length() const; // 0D_NOT_logical
  void set_scale_with_length(bool value);
};

template <>
struct FortranTraits<WakeLrModeProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wake_lr_mode_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_lr_mode_struct(ptr, 0);
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
  void set_freq(double value);
  double freq_in() const; // 0D_NOT_real
  void set_freq_in(double value);
  double R_over_Q() const; // 0D_NOT_real
  void set_R_over_Q(double value);
  double Q() const; // 0D_NOT_real
  void set_Q(double value);
  double damp() const; // 0D_NOT_real
  void set_damp(double value);
  double phi() const; // 0D_NOT_real
  void set_phi(double value);
  double angle() const; // 0D_NOT_real
  void set_angle(double value);
  double b_sin() const; // 0D_NOT_real
  void set_b_sin(double value);
  double b_cos() const; // 0D_NOT_real
  void set_b_cos(double value);
  double a_sin() const; // 0D_NOT_real
  void set_a_sin(double value);
  double a_cos() const; // 0D_NOT_real
  void set_a_cos(double value);
  int m() const; // 0D_NOT_integer
  void set_m(int value);
  bool polarized() const; // 0D_NOT_logical
  void set_polarized(bool value);
};

template <>
struct FortranTraits<WakeLrProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wake_lr_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_lr_struct(ptr, 0);
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
  void set_file(const std::string& value);
  WakeLrModeProxyArray1D mode() const; // 1D_ALLOC_type
  double t_ref() const; // 0D_NOT_real
  void set_t_ref(double value);
  double freq_spread() const; // 0D_NOT_real
  void set_freq_spread(double value);
  double amp_scale() const; // 0D_NOT_real
  void set_amp_scale(double value);
  double time_scale() const; // 0D_NOT_real
  void set_time_scale(double value);
  bool self_wake_on() const; // 0D_NOT_logical
  void set_self_wake_on(bool value);
};

template <>
struct FortranTraits<LatEleLocProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_lat_ele_loc_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_ele_loc_struct(ptr, 0);
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
  void set_ix_ele(int value);
  int ix_branch() const; // 0D_NOT_integer
  void set_ix_branch(int value);
};

template <>
struct FortranTraits<WakeProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wake_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wake_struct(ptr, 0);
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
  void set_sr(const WakeSrProxy& src);
  WakeLrProxy lr() const; // 0D_NOT_type
  void set_lr(const WakeLrProxy& src);
};

template <>
struct FortranTraits<TaylorTermProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_taylor_term_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_taylor_term_struct(ptr, 0);
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
  void set_coef(double value);
  FortranArray1D<int> expn() const; // 1D_NOT_integer
};

template <>
struct FortranTraits<TaylorProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_taylor_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_taylor_struct(ptr, 0);
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
  void set_ref(double value);
  TaylorTermProxyArray1D term() const; // 1D_PTR_type
};

template <>
struct FortranTraits<EmTaylorTermProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_em_taylor_term_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_em_taylor_term_struct(ptr, 0);
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
  void set_coef(double value);
  FortranArray1D<int> expn() const; // 1D_NOT_integer
};

template <>
struct FortranTraits<EmTaylorProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_em_taylor_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_em_taylor_struct(ptr, 0);
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
  void set_ref(double value);
  EmTaylorTermProxyArray1D term() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<CartesianMapTerm1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_cartesian_map_term1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cartesian_map_term1_struct(ptr, 0);
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
  void set_coef(double value);
  double kx() const; // 0D_NOT_real
  void set_kx(double value);
  double ky() const; // 0D_NOT_real
  void set_ky(double value);
  double kz() const; // 0D_NOT_real
  void set_kz(double value);
  double x0() const; // 0D_NOT_real
  void set_x0(double value);
  double y0() const; // 0D_NOT_real
  void set_y0(double value);
  double phi_z() const; // 0D_NOT_real
  void set_phi_z(double value);
  int family() const; // 0D_NOT_integer
  void set_family(int value);
  int form() const; // 0D_NOT_integer
  void set_form(int value);
};

template <>
struct FortranTraits<CartesianMapTermProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_cartesian_map_term_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cartesian_map_term_struct(ptr, 0);
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
  void set_file(const std::string& value);
  int n_link() const; // 0D_NOT_integer
  void set_n_link(int value);
  CartesianMapTerm1ProxyArray1D term() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<CartesianMapProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_cartesian_map_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cartesian_map_struct(ptr, 0);
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
  void set_field_scale(double value);
  FortranArray1D<double> r0() const; // 1D_NOT_real
  int master_parameter() const; // 0D_NOT_integer
  void set_master_parameter(int value);
  int ele_anchor_pt() const; // 0D_NOT_integer
  void set_ele_anchor_pt(int value);
  int field_type() const; // 0D_NOT_integer
  void set_field_type(int value);
  std::optional<CartesianMapTermProxy> ptr() const; // 0D_PTR_type
  void set_ptr(const CartesianMapTermProxy& src);
};

template <>
struct FortranTraits<CylindricalMapTerm1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_cylindrical_map_term1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cylindrical_map_term1_struct(ptr, 0);
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
  void set_e_coef(std::complex<double> value);
  std::complex<double> b_coef() const; // 0D_NOT_complex
  void set_b_coef(std::complex<double> value);
};

template <>
struct FortranTraits<CylindricalMapTermProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_cylindrical_map_term_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cylindrical_map_term_struct(ptr, 0);
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
  void set_file(const std::string& value);
  int n_link() const; // 0D_NOT_integer
  void set_n_link(int value);
  CylindricalMapTerm1ProxyArray1D term() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<CylindricalMapProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_cylindrical_map_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_cylindrical_map_struct(ptr, 0);
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
  void set_m(int value);
  int harmonic() const; // 0D_NOT_integer
  void set_harmonic(int value);
  double phi0_fieldmap() const; // 0D_NOT_real
  void set_phi0_fieldmap(double value);
  double theta0_azimuth() const; // 0D_NOT_real
  void set_theta0_azimuth(double value);
  double field_scale() const; // 0D_NOT_real
  void set_field_scale(double value);
  int master_parameter() const; // 0D_NOT_integer
  void set_master_parameter(int value);
  int ele_anchor_pt() const; // 0D_NOT_integer
  void set_ele_anchor_pt(int value);
  double dz() const; // 0D_NOT_real
  void set_dz(double value);
  FortranArray1D<double> r0() const; // 1D_NOT_real
  std::optional<CylindricalMapTermProxy> ptr() const; // 0D_PTR_type
  void set_ptr(const CylindricalMapTermProxy& src);
};

template <>
struct FortranTraits<BicubicCmplxCoefProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_bicubic_cmplx_coef_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bicubic_cmplx_coef_struct(ptr, 0);
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

  FortranArray2D<std::complex<double>> coef() const; // 2D_NOT_complex
  FortranArray1D<int> i_box() const; // 1D_NOT_integer
};

template <>
struct FortranTraits<TricubicCmplxCoefProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tricubic_cmplx_coef_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tricubic_cmplx_coef_struct(ptr, 0);
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

  FortranArray3D<std::complex<double>> coef() const; // 3D_NOT_complex
  FortranArray1D<int> i_box() const; // 1D_NOT_integer
};

template <>
struct FortranTraits<GridFieldPt1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_grid_field_pt1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_grid_field_pt1_struct(ptr, 0);
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

template <>
struct FortranTraits<GridFieldPtProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_grid_field_pt_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_grid_field_pt_struct(ptr, 0);
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
  void set_file(const std::string& value);
  int n_link() const; // 0D_NOT_integer
  void set_n_link(int value);
  GridFieldPt1ProxyArray3D pt() const; // 3D_ALLOC_type
};

template <>
struct FortranTraits<GridFieldProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_grid_field_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_grid_field_struct(ptr, 0);
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
  void set_geometry(int value);
  int harmonic() const; // 0D_NOT_integer
  void set_harmonic(int value);
  double phi0_fieldmap() const; // 0D_NOT_real
  void set_phi0_fieldmap(double value);
  double field_scale() const; // 0D_NOT_real
  void set_field_scale(double value);
  int field_type() const; // 0D_NOT_integer
  void set_field_type(int value);
  int master_parameter() const; // 0D_NOT_integer
  void set_master_parameter(int value);
  int ele_anchor_pt() const; // 0D_NOT_integer
  void set_ele_anchor_pt(int value);
  int interpolation_order() const; // 0D_NOT_integer
  void set_interpolation_order(int value);
  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  bool curved_ref_frame() const; // 0D_NOT_logical
  void set_curved_ref_frame(bool value);
  std::optional<GridFieldPtProxy> ptr() const; // 0D_PTR_type
  void set_ptr(const GridFieldPtProxy& src);
  BicubicCmplxCoefProxyArray3D bi_coef() const; // 3D_NOT_type
  TricubicCmplxCoefProxyArray3D tri_coef() const; // 3D_NOT_type
};

template <>
struct FortranTraits<FloorPositionProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_floor_position_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_floor_position_struct(ptr, 0);
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
  FortranArray2D<double> w() const; // 2D_NOT_real
  double theta() const; // 0D_NOT_real
  void set_theta(double value);
  double phi() const; // 0D_NOT_real
  void set_phi(double value);
  double psi() const; // 0D_NOT_real
  void set_psi(double value);
};

template <>
struct FortranTraits<HighEnergySpaceChargeProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_high_energy_space_charge_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_high_energy_space_charge_struct(ptr, 0);
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
  void set_closed_orb(const CoordProxy& src);
  double kick_const() const; // 0D_NOT_real
  void set_kick_const(double value);
  double sig_x() const; // 0D_NOT_real
  void set_sig_x(double value);
  double sig_y() const; // 0D_NOT_real
  void set_sig_y(double value);
  double phi() const; // 0D_NOT_real
  void set_phi(double value);
  double sin_phi() const; // 0D_NOT_real
  void set_sin_phi(double value);
  double cos_phi() const; // 0D_NOT_real
  void set_cos_phi(double value);
  double sig_z() const; // 0D_NOT_real
  void set_sig_z(double value);
};

template <>
struct FortranTraits<XyDispProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_xy_disp_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_xy_disp_struct(ptr, 0);
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
  void set_eta(double value);
  double etap() const; // 0D_NOT_real
  void set_etap(double value);
  double deta_ds() const; // 0D_NOT_real
  void set_deta_ds(double value);
  double sigma() const; // 0D_NOT_real
  void set_sigma(double value);
  double deta_dpz() const; // 0D_NOT_real
  void set_deta_dpz(double value);
  double detap_dpz() const; // 0D_NOT_real
  void set_detap_dpz(double value);
};

template <>
struct FortranTraits<TwissProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_twiss_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_twiss_struct(ptr, 0);
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
  void set_beta(double value);
  double alpha() const; // 0D_NOT_real
  void set_alpha(double value);
  double gamma() const; // 0D_NOT_real
  void set_gamma(double value);
  double phi() const; // 0D_NOT_real
  void set_phi(double value);
  double eta() const; // 0D_NOT_real
  void set_eta(double value);
  double etap() const; // 0D_NOT_real
  void set_etap(double value);
  double deta_ds() const; // 0D_NOT_real
  void set_deta_ds(double value);
  double sigma() const; // 0D_NOT_real
  void set_sigma(double value);
  double sigma_p() const; // 0D_NOT_real
  void set_sigma_p(double value);
  double emit() const; // 0D_NOT_real
  void set_emit(double value);
  double norm_emit() const; // 0D_NOT_real
  void set_norm_emit(double value);
  double chrom() const; // 0D_NOT_real
  void set_chrom(double value);
  double dbeta_dpz() const; // 0D_NOT_real
  void set_dbeta_dpz(double value);
  double dalpha_dpz() const; // 0D_NOT_real
  void set_dalpha_dpz(double value);
  double deta_dpz() const; // 0D_NOT_real
  void set_deta_dpz(double value);
  double detap_dpz() const; // 0D_NOT_real
  void set_detap_dpz(double value);
};

template <>
struct FortranTraits<Mode3Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_mode3_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_mode3_struct(ptr, 0);
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

  FortranArray2D<double> v() const; // 2D_NOT_real
  TwissProxy a() const; // 0D_NOT_type
  void set_a(const TwissProxy& src);
  TwissProxy b() const; // 0D_NOT_type
  void set_b(const TwissProxy& src);
  TwissProxy c() const; // 0D_NOT_type
  void set_c(const TwissProxy& src);
  TwissProxy x() const; // 0D_NOT_type
  void set_x(const TwissProxy& src);
  TwissProxy y() const; // 0D_NOT_type
  void set_y(const TwissProxy& src);
};

template <>
struct FortranTraits<BookkeepingStateProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_bookkeeping_state_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bookkeeping_state_struct(ptr, 0);
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
  void set_attributes(int value);
  int control() const; // 0D_NOT_integer
  void set_control(int value);
  int floor_position() const; // 0D_NOT_integer
  void set_floor_position(int value);
  int s_position() const; // 0D_NOT_integer
  void set_s_position(int value);
  int ref_energy() const; // 0D_NOT_integer
  void set_ref_energy(int value);
  int mat6() const; // 0D_NOT_integer
  void set_mat6(int value);
  int rad_int() const; // 0D_NOT_integer
  void set_rad_int(int value);
  int ptc() const; // 0D_NOT_integer
  void set_ptc(int value);
  bool has_misalign() const; // 0D_NOT_logical
  void set_has_misalign(bool value);
};

template <>
struct FortranTraits<RadMapProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_rad_map_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_map_struct(ptr, 0);
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
  FortranArray2D<double> damp_dmat() const; // 2D_NOT_real
  FortranArray1D<double> xfer_damp_vec() const; // 1D_NOT_real
  FortranArray2D<double> xfer_damp_mat() const; // 2D_NOT_real
  FortranArray2D<double> stoc_mat() const; // 2D_NOT_real
};

template <>
struct FortranTraits<RadMapEleProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_rad_map_ele_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_map_ele_struct(ptr, 0);
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
  void set_rm0(const RadMapProxy& src);
  RadMapProxy rm1() const; // 0D_NOT_type
  void set_rm1(const RadMapProxy& src);
  bool stale() const; // 0D_NOT_logical
  void set_stale(bool value);
};

template <>
struct FortranTraits<GenGrad1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_gen_grad1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_gen_grad1_struct(ptr, 0);
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
  void set_m(int value);
  int sincos() const; // 0D_NOT_integer
  void set_sincos(int value);
  int n_deriv_max() const; // 0D_NOT_integer
  void set_n_deriv_max(int value);
  FortranArray2D<double> deriv() const; // 2D_ALLOC_real
};

template <>
struct FortranTraits<GenGradMapProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_gen_grad_map_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_gen_grad_map_struct(ptr, 0);
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
  void set_file(const std::string& value);
  GenGrad1ProxyArray1D gg() const; // 1D_ALLOC_type
  int ele_anchor_pt() const; // 0D_NOT_integer
  void set_ele_anchor_pt(int value);
  int field_type() const; // 0D_NOT_integer
  void set_field_type(int value);
  int iz0() const; // 0D_NOT_integer
  void set_iz0(int value);
  int iz1() const; // 0D_NOT_integer
  void set_iz1(int value);
  double dz() const; // 0D_NOT_real
  void set_dz(double value);
  FortranArray1D<double> r0() const; // 1D_NOT_real
  double field_scale() const; // 0D_NOT_real
  void set_field_scale(double value);
  int master_parameter() const; // 0D_NOT_integer
  void set_master_parameter(int value);
  bool curved_ref_frame() const; // 0D_NOT_logical
  void set_curved_ref_frame(bool value);
};

template <>
struct FortranTraits<SurfaceSegmentedPtProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_surface_segmented_pt_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_segmented_pt_struct(ptr, 0);
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
  void set_x0(double value);
  double y0() const; // 0D_NOT_real
  void set_y0(double value);
  double z0() const; // 0D_NOT_real
  void set_z0(double value);
  double dz_dx() const; // 0D_NOT_real
  void set_dz_dx(double value);
  double dz_dy() const; // 0D_NOT_real
  void set_dz_dy(double value);
};

template <>
struct FortranTraits<SurfaceSegmentedProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_surface_segmented_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_segmented_struct(ptr, 0);
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
  void set_active(bool value);
  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  SurfaceSegmentedPtProxyArray2D pt() const; // 2D_ALLOC_type
};

template <>
struct FortranTraits<SurfaceHMisalignPtProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_surface_h_misalign_pt_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_h_misalign_pt_struct(ptr, 0);
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
  void set_x0(double value);
  double y0() const; // 0D_NOT_real
  void set_y0(double value);
  double rot_y() const; // 0D_NOT_real
  void set_rot_y(double value);
  double rot_t() const; // 0D_NOT_real
  void set_rot_t(double value);
  double rot_y_rms() const; // 0D_NOT_real
  void set_rot_y_rms(double value);
  double rot_t_rms() const; // 0D_NOT_real
  void set_rot_t_rms(double value);
};

template <>
struct FortranTraits<SurfaceHMisalignProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_surface_h_misalign_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_h_misalign_struct(ptr, 0);
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
  void set_active(bool value);
  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  SurfaceHMisalignPtProxyArray2D pt() const; // 2D_ALLOC_type
};

template <>
struct FortranTraits<SurfaceDisplacementPtProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_surface_displacement_pt_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_displacement_pt_struct(ptr, 0);
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
  void set_x0(double value);
  double y0() const; // 0D_NOT_real
  void set_y0(double value);
  double z0() const; // 0D_NOT_real
  void set_z0(double value);
  double dz_dx() const; // 0D_NOT_real
  void set_dz_dx(double value);
  double dz_dy() const; // 0D_NOT_real
  void set_dz_dy(double value);
  double d2z_dxdy() const; // 0D_NOT_real
  void set_d2z_dxdy(double value);
};

template <>
struct FortranTraits<SurfaceDisplacementProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_surface_displacement_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_displacement_struct(ptr, 0);
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
  void set_active(bool value);
  FortranArray1D<double> dr() const; // 1D_NOT_real
  FortranArray1D<double> r0() const; // 1D_NOT_real
  SurfaceDisplacementPtProxyArray2D pt() const; // 2D_ALLOC_type
};

template <>
struct FortranTraits<TargetPointProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_target_point_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_target_point_struct(ptr, 0);
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

template <>
struct FortranTraits<SurfaceCurvatureProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_surface_curvature_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_surface_curvature_struct(ptr, 0);
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

  FortranArray2D<double> xy() const; // 2D_NOT_real
  double spherical() const; // 0D_NOT_real
  void set_spherical(double value);
  FortranArray1D<double> elliptical() const; // 1D_NOT_real
  bool has_curvature() const; // 0D_NOT_logical
  void set_has_curvature(bool value);
};

template <>
struct FortranTraits<PhotonTargetProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_photon_target_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_target_struct(ptr, 0);
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
  void set_type(int value);
  int n_corner() const; // 0D_NOT_integer
  void set_n_corner(int value);
  LatEleLocProxy ele_loc() const; // 0D_NOT_type
  void set_ele_loc(const LatEleLocProxy& src);
  TargetPointProxyArray1D corner() const; // 1D_NOT_type
  TargetPointProxy center() const; // 0D_NOT_type
  void set_center(const TargetPointProxy& src);
};

template <>
struct FortranTraits<PhotonMaterialProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_photon_material_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_material_struct(ptr, 0);
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
  void set_f0_m1(std::complex<double> value);
  std::complex<double> f0_m2() const; // 0D_NOT_complex
  void set_f0_m2(std::complex<double> value);
  std::complex<double> f_0() const; // 0D_NOT_complex
  void set_f_0(std::complex<double> value);
  std::complex<double> f_h() const; // 0D_NOT_complex
  void set_f_h(std::complex<double> value);
  std::complex<double> f_hbar() const; // 0D_NOT_complex
  void set_f_hbar(std::complex<double> value);
  std::complex<double> f_hkl() const; // 0D_NOT_complex
  void set_f_hkl(std::complex<double> value);
  FortranArray1D<double> h_norm() const; // 1D_NOT_real
  FortranArray1D<double> l_ref() const; // 1D_NOT_real
};

template <>
struct FortranTraits<PixelPtProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_pixel_pt_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_pixel_pt_struct(ptr, 0);
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
  void set_n_photon(long long value);
  std::complex<double> E_x() const; // 0D_NOT_complex
  void set_E_x(std::complex<double> value);
  std::complex<double> E_y() const; // 0D_NOT_complex
  void set_E_y(std::complex<double> value);
  double intensity_x() const; // 0D_NOT_real
  void set_intensity_x(double value);
  double intensity_y() const; // 0D_NOT_real
  void set_intensity_y(double value);
  double intensity() const; // 0D_NOT_real
  void set_intensity(double value);
  FortranArray1D<double> orbit() const; // 1D_NOT_real
  FortranArray1D<double> orbit_rms() const; // 1D_NOT_real
  FortranArray1D<double> init_orbit() const; // 1D_NOT_real
  FortranArray1D<double> init_orbit_rms() const; // 1D_NOT_real
};

template <>
struct FortranTraits<PixelDetecProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_pixel_detec_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_pixel_detec_struct(ptr, 0);
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
  void set_n_track_tot(long long value);
  long long n_hit_detec() const; // 0D_NOT_integer8
  void set_n_hit_detec(long long value);
  long long n_hit_pixel() const; // 0D_NOT_integer8
  void set_n_hit_pixel(long long value);
  PixelPtProxyArray2D pt() const; // 2D_ALLOC_type
};

template <>
struct FortranTraits<PhotonElementProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_photon_element_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_photon_element_struct(ptr, 0);
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
  void set_curvature(const SurfaceCurvatureProxy& src);
  PhotonTargetProxy target() const; // 0D_NOT_type
  void set_target(const PhotonTargetProxy& src);
  PhotonMaterialProxy material() const; // 0D_NOT_type
  void set_material(const PhotonMaterialProxy& src);
  SurfaceSegmentedProxy segmented() const; // 0D_NOT_type
  void set_segmented(const SurfaceSegmentedProxy& src);
  SurfaceHMisalignProxy h_misalign() const; // 0D_NOT_type
  void set_h_misalign(const SurfaceHMisalignProxy& src);
  SurfaceDisplacementProxy displacement() const; // 0D_NOT_type
  void set_displacement(const SurfaceDisplacementProxy& src);
  PixelDetecProxy pixel() const; // 0D_NOT_type
  void set_pixel(const PixelDetecProxy& src);
  int reflectivity_table_type() const; // 0D_NOT_integer
  void set_reflectivity_table_type(int value);
  PhotonReflectTableProxy reflectivity_table_sigma() const; // 0D_NOT_type
  void set_reflectivity_table_sigma(const PhotonReflectTableProxy& src);
  PhotonReflectTableProxy reflectivity_table_pi() const; // 0D_NOT_type
  void set_reflectivity_table_pi(const PhotonReflectTableProxy& src);
  SplineProxyArray1D init_energy_prob() const; // 1D_ALLOC_type
  FortranArray1D<double> integrated_init_energy_prob() const; // 1D_ALLOC_real
};

template <>
struct FortranTraits<Wall3dVertexProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wall3d_vertex_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wall3d_vertex_struct(ptr, 0);
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
  void set_x(double value);
  double y() const; // 0D_NOT_real
  void set_y(double value);
  double radius_x() const; // 0D_NOT_real
  void set_radius_x(double value);
  double radius_y() const; // 0D_NOT_real
  void set_radius_y(double value);
  double tilt() const; // 0D_NOT_real
  void set_tilt(double value);
  double angle() const; // 0D_NOT_real
  void set_angle(double value);
  double x0() const; // 0D_NOT_real
  void set_x0(double value);
  double y0() const; // 0D_NOT_real
  void set_y0(double value);
  int type() const; // 0D_NOT_integer
  void set_type(int value);
};

template <>
struct FortranTraits<Wall3dSectionProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wall3d_section_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wall3d_section_struct(ptr, 0);
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
  void set_name(const std::string& value);
  std::string material() const; // 0D_NOT_character
  void set_material(const std::string& value);
  Wall3dVertexProxyArray1D v() const; // 1D_ALLOC_type
  std::optional<PhotonReflectSurfaceProxy> surface() const; // 0D_PTR_type
  void set_surface(const PhotonReflectSurfaceProxy& src);
  int type() const; // 0D_NOT_integer
  void set_type(int value);
  int n_vertex_input() const; // 0D_NOT_integer
  void set_n_vertex_input(int value);
  int ix_ele() const; // 0D_NOT_integer
  void set_ix_ele(int value);
  int ix_branch() const; // 0D_NOT_integer
  void set_ix_branch(int value);
  int vertices_state() const; // 0D_NOT_integer
  void set_vertices_state(int value);
  bool patch_in_region() const; // 0D_NOT_logical
  void set_patch_in_region(bool value);
  double thickness() const; // 0D_NOT_real
  void set_thickness(double value);
  double s() const; // 0D_NOT_real
  void set_s(double value);
  FortranArray1D<double> r0() const; // 1D_NOT_real
  double dx0_ds() const; // 0D_NOT_real
  void set_dx0_ds(double value);
  double dy0_ds() const; // 0D_NOT_real
  void set_dy0_ds(double value);
  FortranArray1D<double> x0_coef() const; // 1D_NOT_real
  FortranArray1D<double> y0_coef() const; // 1D_NOT_real
  double dr_ds() const; // 0D_NOT_real
  void set_dr_ds(double value);
  FortranArray1D<double> p1_coef() const; // 1D_NOT_real
  FortranArray1D<double> p2_coef() const; // 1D_NOT_real
};

template <>
struct FortranTraits<Wall3dProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_wall3d_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_wall3d_struct(ptr, 0);
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
  void set_name(const std::string& value);
  int type() const; // 0D_NOT_integer
  void set_type(int value);
  int ix_wall3d() const; // 0D_NOT_integer
  void set_ix_wall3d(int value);
  int n_link() const; // 0D_NOT_integer
  void set_n_link(int value);
  double thickness() const; // 0D_NOT_real
  void set_thickness(double value);
  std::string clear_material() const; // 0D_NOT_character
  void set_clear_material(const std::string& value);
  std::string opaque_material() const; // 0D_NOT_character
  void set_opaque_material(const std::string& value);
  bool superimpose() const; // 0D_NOT_logical
  void set_superimpose(bool value);
  int ele_anchor_pt() const; // 0D_NOT_integer
  void set_ele_anchor_pt(int value);
  Wall3dSectionProxyArray1D section() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<RamperLordProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_ramper_lord_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ramper_lord_struct(ptr, 0);
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
  void set_ix_ele(int value);
  int ix_con() const; // 0D_NOT_integer
  void set_ix_con(int value);
  double* attrib_ptr() const; // 0D_PTR_real
  void set_attrib_ptr(double value);
};

template <>
struct FortranTraits<ControlProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_control_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_control_struct(ptr, 0);
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
  void set_value(double value);
  FortranArray1D<double> y_knot() const; // 1D_ALLOC_real
  ExpressionAtomProxyArray1D stack() const; // 1D_ALLOC_type
  LatEleLocProxy slave() const; // 0D_NOT_type
  void set_slave(const LatEleLocProxy& src);
  LatEleLocProxy lord() const; // 0D_NOT_type
  void set_lord(const LatEleLocProxy& src);
  std::string slave_name() const; // 0D_NOT_character
  void set_slave_name(const std::string& value);
  std::string attribute() const; // 0D_NOT_character
  void set_attribute(const std::string& value);
  int ix_attrib() const; // 0D_NOT_integer
  void set_ix_attrib(int value);
};

template <>
struct FortranTraits<ControlVar1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_control_var1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_control_var1_struct(ptr, 0);
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
  void set_name(const std::string& value);
  double value() const; // 0D_NOT_real
  void set_value(double value);
  double old_value() const; // 0D_NOT_real
  void set_old_value(double value);
};

template <>
struct FortranTraits<ControlRamp1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_control_ramp1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_control_ramp1_struct(ptr, 0);
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
  ExpressionAtomProxyArray1D stack() const; // 1D_ALLOC_type
  std::string attribute() const; // 0D_NOT_character
  void set_attribute(const std::string& value);
  std::string slave_name() const; // 0D_NOT_character
  void set_slave_name(const std::string& value);
  bool is_controller() const; // 0D_NOT_logical
  void set_is_controller(bool value);
};

template <>
struct FortranTraits<ControllerProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_controller_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_controller_struct(ptr, 0);
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

  ControlVar1ProxyArray1D var() const; // 1D_ALLOC_type
  ControlRamp1ProxyArray1D ramp() const; // 1D_ALLOC_type
  RamperLordProxyArray1D ramper_lord() const; // 1D_ALLOC_type
  FortranArray1D<double> x_knot() const; // 1D_ALLOC_real
};

template <>
struct FortranTraits<EllipseBeamInitProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_ellipse_beam_init_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ellipse_beam_init_struct(ptr, 0);
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
  void set_part_per_ellipse(int value);
  int n_ellipse() const; // 0D_NOT_integer
  void set_n_ellipse(int value);
  double sigma_cutoff() const; // 0D_NOT_real
  void set_sigma_cutoff(double value);
};

template <>
struct FortranTraits<KvBeamInitProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_kv_beam_init_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_kv_beam_init_struct(ptr, 0);
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
  void set_n_I2(int value);
  double A() const; // 0D_NOT_real
  void set_A(double value);
};

template <>
struct FortranTraits<GridBeamInitProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_grid_beam_init_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_grid_beam_init_struct(ptr, 0);
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
  void set_n_x(int value);
  int n_px() const; // 0D_NOT_integer
  void set_n_px(int value);
  double x_min() const; // 0D_NOT_real
  void set_x_min(double value);
  double x_max() const; // 0D_NOT_real
  void set_x_max(double value);
  double px_min() const; // 0D_NOT_real
  void set_px_min(double value);
  double px_max() const; // 0D_NOT_real
  void set_px_max(double value);
};

template <>
struct FortranTraits<BeamInitProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_beam_init_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_beam_init_struct(ptr, 0);
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
  void set_position_file(const std::string& value);
  FortranCharArray1D distribution_type() const; // 1D_NOT_character
  FortranArray1D<double> spin() const; // 1D_NOT_real
  EllipseBeamInitProxyArray1D ellipse() const; // 1D_NOT_type
  KvBeamInitProxy KV() const; // 0D_NOT_type
  void set_KV(const KvBeamInitProxy& src);
  GridBeamInitProxyArray1D grid() const; // 1D_NOT_type
  FortranArray1D<double> center_jitter() const; // 1D_NOT_real
  FortranArray1D<double> emit_jitter() const; // 1D_NOT_real
  double sig_z_jitter() const; // 0D_NOT_real
  void set_sig_z_jitter(double value);
  double sig_pz_jitter() const; // 0D_NOT_real
  void set_sig_pz_jitter(double value);
  int n_particle() const; // 0D_NOT_integer
  void set_n_particle(int value);
  bool renorm_center() const; // 0D_NOT_logical
  void set_renorm_center(bool value);
  bool renorm_sigma() const; // 0D_NOT_logical
  void set_renorm_sigma(bool value);
  std::string random_engine() const; // 0D_NOT_character
  void set_random_engine(const std::string& value);
  std::string random_gauss_converter() const; // 0D_NOT_character
  void set_random_gauss_converter(const std::string& value);
  double random_sigma_cutoff() const; // 0D_NOT_real
  void set_random_sigma_cutoff(double value);
  double a_norm_emit() const; // 0D_NOT_real
  void set_a_norm_emit(double value);
  double b_norm_emit() const; // 0D_NOT_real
  void set_b_norm_emit(double value);
  double a_emit() const; // 0D_NOT_real
  void set_a_emit(double value);
  double b_emit() const; // 0D_NOT_real
  void set_b_emit(double value);
  double dPz_dz() const; // 0D_NOT_real
  void set_dPz_dz(double value);
  FortranArray1D<double> center() const; // 1D_NOT_real
  double t_offset() const; // 0D_NOT_real
  void set_t_offset(double value);
  double dt_bunch() const; // 0D_NOT_real
  void set_dt_bunch(double value);
  double sig_z() const; // 0D_NOT_real
  void set_sig_z(double value);
  double sig_pz() const; // 0D_NOT_real
  void set_sig_pz(double value);
  double bunch_charge() const; // 0D_NOT_real
  void set_bunch_charge(double value);
  int n_bunch() const; // 0D_NOT_integer
  void set_n_bunch(int value);
  int ix_turn() const; // 0D_NOT_integer
  void set_ix_turn(int value);
  std::string species() const; // 0D_NOT_character
  void set_species(const std::string& value);
  bool full_6D_coupling_calc() const; // 0D_NOT_logical
  void set_full_6D_coupling_calc(bool value);
  bool use_particle_start() const; // 0D_NOT_logical
  void set_use_particle_start(bool value);
  bool use_t_coords() const; // 0D_NOT_logical
  void set_use_t_coords(bool value);
  bool use_z_as_t() const; // 0D_NOT_logical
  void set_use_z_as_t(bool value);
  std::string file_name() const; // 0D_NOT_character
  void set_file_name(const std::string& value);
};

template <>
struct FortranTraits<LatParamProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_lat_param_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_param_struct(ptr, 0);
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
  void set_n_part(double value);
  double total_length() const; // 0D_NOT_real
  void set_total_length(double value);
  double unstable_factor() const; // 0D_NOT_real
  void set_unstable_factor(double value);
  FortranArray2D<double> t1_with_RF() const; // 2D_NOT_real
  FortranArray2D<double> t1_no_RF() const; // 2D_NOT_real
  double spin_tune() const; // 0D_NOT_real
  void set_spin_tune(double value);
  int particle() const; // 0D_NOT_integer
  void set_particle(int value);
  int default_tracking_species() const; // 0D_NOT_integer
  void set_default_tracking_species(int value);
  int geometry() const; // 0D_NOT_integer
  void set_geometry(int value);
  int ixx() const; // 0D_NOT_integer
  void set_ixx(int value);
  bool stable() const; // 0D_NOT_logical
  void set_stable(bool value);
  bool live_branch() const; // 0D_NOT_logical
  void set_live_branch(bool value);
  double g1_integral() const; // 0D_NOT_real
  void set_g1_integral(double value);
  double g2_integral() const; // 0D_NOT_real
  void set_g2_integral(double value);
  double g3_integral() const; // 0D_NOT_real
  void set_g3_integral(double value);
  BookkeepingStateProxy bookkeeping_state() const; // 0D_NOT_type
  void set_bookkeeping_state(const BookkeepingStateProxy& src);
  BeamInitProxy beam_init() const; // 0D_NOT_type
  void set_beam_init(const BeamInitProxy& src);
};

template <>
struct FortranTraits<ModeInfoProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_mode_info_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_mode_info_struct(ptr, 0);
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
  void set_stable(bool value);
  double tune() const; // 0D_NOT_real
  void set_tune(double value);
  double emit() const; // 0D_NOT_real
  void set_emit(double value);
  double chrom() const; // 0D_NOT_real
  void set_chrom(double value);
  double sigma() const; // 0D_NOT_real
  void set_sigma(double value);
  double sigmap() const; // 0D_NOT_real
  void set_sigmap(double value);
};

template <>
struct FortranTraits<PreTrackerProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_pre_tracker_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_pre_tracker_struct(ptr, 0);
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
  void set_who(int value);
  int ix_ele_start() const; // 0D_NOT_integer
  void set_ix_ele_start(int value);
  int ix_ele_end() const; // 0D_NOT_integer
  void set_ix_ele_end(int value);
  std::string input_file() const; // 0D_NOT_character
  void set_input_file(const std::string& value);
};

template <>
struct FortranTraits<AnormalModeProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_anormal_mode_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_anormal_mode_struct(ptr, 0);
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
  void set_emittance(double value);
  double emittance_no_vert() const; // 0D_NOT_real
  void set_emittance_no_vert(double value);
  FortranArray1D<double> synch_int() const; // 1D_NOT_real
  double j_damp() const; // 0D_NOT_real
  void set_j_damp(double value);
  double alpha_damp() const; // 0D_NOT_real
  void set_alpha_damp(double value);
  double chrom() const; // 0D_NOT_real
  void set_chrom(double value);
  double tune() const; // 0D_NOT_real
  void set_tune(double value);
};

template <>
struct FortranTraits<LinacNormalModeProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_linac_normal_mode_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_linac_normal_mode_struct(ptr, 0);
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
  void set_i2_E4(double value);
  double i3_E7() const; // 0D_NOT_real
  void set_i3_E7(double value);
  double i5a_E6() const; // 0D_NOT_real
  void set_i5a_E6(double value);
  double i5b_E6() const; // 0D_NOT_real
  void set_i5b_E6(double value);
  double sig_E1() const; // 0D_NOT_real
  void set_sig_E1(double value);
  double a_emittance_end() const; // 0D_NOT_real
  void set_a_emittance_end(double value);
  double b_emittance_end() const; // 0D_NOT_real
  void set_b_emittance_end(double value);
};

template <>
struct FortranTraits<NormalModesProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_normal_modes_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_normal_modes_struct(ptr, 0);
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
  void set_sigE_E(double value);
  double sig_z() const; // 0D_NOT_real
  void set_sig_z(double value);
  double e_loss() const; // 0D_NOT_real
  void set_e_loss(double value);
  double rf_voltage() const; // 0D_NOT_real
  void set_rf_voltage(double value);
  double pz_aperture() const; // 0D_NOT_real
  void set_pz_aperture(double value);
  double pz_average() const; // 0D_NOT_real
  void set_pz_average(double value);
  double momentum_compaction() const; // 0D_NOT_real
  void set_momentum_compaction(double value);
  double dpz_damp() const; // 0D_NOT_real
  void set_dpz_damp(double value);
  AnormalModeProxy a() const; // 0D_NOT_type
  void set_a(const AnormalModeProxy& src);
  AnormalModeProxy b() const; // 0D_NOT_type
  void set_b(const AnormalModeProxy& src);
  AnormalModeProxy z() const; // 0D_NOT_type
  void set_z(const AnormalModeProxy& src);
  LinacNormalModeProxy lin() const; // 0D_NOT_type
  void set_lin(const LinacNormalModeProxy& src);
};

template <>
struct FortranTraits<EmFieldProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_em_field_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_em_field_struct(ptr, 0);
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
  FortranArray2D<double> dE() const; // 2D_NOT_real
  FortranArray2D<double> dB() const; // 2D_NOT_real
  double phi() const; // 0D_NOT_real
  void set_phi(double value);
  double phi_B() const; // 0D_NOT_real
  void set_phi_B(double value);
  FortranArray1D<double> A() const; // 1D_NOT_real
};

template <>
struct FortranTraits<StrongBeamProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_strong_beam_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_strong_beam_struct(ptr, 0);
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
  void set_ix_slice(int value);
  double x_center() const; // 0D_NOT_real
  void set_x_center(double value);
  double y_center() const; // 0D_NOT_real
  void set_y_center(double value);
  double x_sigma() const; // 0D_NOT_real
  void set_x_sigma(double value);
  double y_sigma() const; // 0D_NOT_real
  void set_y_sigma(double value);
  double dx() const; // 0D_NOT_real
  void set_dx(double value);
  double dy() const; // 0D_NOT_real
  void set_dy(double value);
};

template <>
struct FortranTraits<TrackPointProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_track_point_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_track_point_struct(ptr, 0);
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
  void set_s_lab(double value);
  double s_body() const; // 0D_NOT_real
  void set_s_body(double value);
  CoordProxy orb() const; // 0D_NOT_type
  void set_orb(const CoordProxy& src);
  EmFieldProxy field() const; // 0D_NOT_type
  void set_field(const EmFieldProxy& src);
  StrongBeamProxy strong_beam() const; // 0D_NOT_type
  void set_strong_beam(const StrongBeamProxy& src);
  FortranArray1D<double> vec0() const; // 1D_NOT_real
  FortranArray2D<double> mat6() const; // 2D_NOT_real
};

template <>
struct FortranTraits<TrackProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_track_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_track_struct(ptr, 0);
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

  TrackPointProxyArray1D pt() const; // 1D_ALLOC_type
  double ds_save() const; // 0D_NOT_real
  void set_ds_save(double value);
  int n_pt() const; // 0D_NOT_integer
  void set_n_pt(int value);
  int n_bad() const; // 0D_NOT_integer
  void set_n_bad(int value);
  int n_ok() const; // 0D_NOT_integer
  void set_n_ok(int value);
};

template <>
struct FortranTraits<SpaceChargeCommonProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_space_charge_common_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_space_charge_common_struct(ptr, 0);
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
  void set_ds_track_step(double value);
  double dt_track_step() const; // 0D_NOT_real
  void set_dt_track_step(double value);
  double cathode_strength_cutoff() const; // 0D_NOT_real
  void set_cathode_strength_cutoff(double value);
  double rel_tol_tracking() const; // 0D_NOT_real
  void set_rel_tol_tracking(double value);
  double abs_tol_tracking() const; // 0D_NOT_real
  void set_abs_tol_tracking(double value);
  double beam_chamber_height() const; // 0D_NOT_real
  void set_beam_chamber_height(double value);
  double lsc_sigma_cutoff() const; // 0D_NOT_real
  void set_lsc_sigma_cutoff(double value);
  double particle_sigma_cutoff() const; // 0D_NOT_real
  void set_particle_sigma_cutoff(double value);
  FortranArray1D<int> space_charge_mesh_size() const; // 1D_NOT_integer
  FortranArray1D<int> csr3d_mesh_size() const; // 1D_NOT_integer
  int n_bin() const; // 0D_NOT_integer
  void set_n_bin(int value);
  int particle_bin_span() const; // 0D_NOT_integer
  void set_particle_bin_span(int value);
  int n_shield_images() const; // 0D_NOT_integer
  void set_n_shield_images(int value);
  int sc_min_in_bin() const; // 0D_NOT_integer
  void set_sc_min_in_bin(int value);
  bool lsc_kick_transverse_dependence() const; // 0D_NOT_logical
  void set_lsc_kick_transverse_dependence(bool value);
  bool debug() const; // 0D_NOT_logical
  void set_debug(bool value);
  std::string diagnostic_output_file() const; // 0D_NOT_character
  void set_diagnostic_output_file(const std::string& value);
};

template <>
struct FortranTraits<BmadCommonProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_bmad_common_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bmad_common_struct(ptr, 0);
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
  void set_max_aperture_limit(double value);
  FortranArray1D<double> d_orb() const; // 1D_NOT_real
  double default_ds_step() const; // 0D_NOT_real
  void set_default_ds_step(double value);
  double significant_length() const; // 0D_NOT_real
  void set_significant_length(double value);
  double rel_tol_tracking() const; // 0D_NOT_real
  void set_rel_tol_tracking(double value);
  double abs_tol_tracking() const; // 0D_NOT_real
  void set_abs_tol_tracking(double value);
  double rel_tol_adaptive_tracking() const; // 0D_NOT_real
  void set_rel_tol_adaptive_tracking(double value);
  double abs_tol_adaptive_tracking() const; // 0D_NOT_real
  void set_abs_tol_adaptive_tracking(double value);
  double init_ds_adaptive_tracking() const; // 0D_NOT_real
  void set_init_ds_adaptive_tracking(double value);
  double min_ds_adaptive_tracking() const; // 0D_NOT_real
  void set_min_ds_adaptive_tracking(double value);
  double fatal_ds_adaptive_tracking() const; // 0D_NOT_real
  void set_fatal_ds_adaptive_tracking(double value);
  double autoscale_amp_abs_tol() const; // 0D_NOT_real
  void set_autoscale_amp_abs_tol(double value);
  double autoscale_amp_rel_tol() const; // 0D_NOT_real
  void set_autoscale_amp_rel_tol(double value);
  double autoscale_phase_tol() const; // 0D_NOT_real
  void set_autoscale_phase_tol(double value);
  double electric_dipole_moment() const; // 0D_NOT_real
  void set_electric_dipole_moment(double value);
  double synch_rad_scale() const; // 0D_NOT_real
  void set_synch_rad_scale(double value);
  double sad_eps_scale() const; // 0D_NOT_real
  void set_sad_eps_scale(double value);
  double sad_amp_max() const; // 0D_NOT_real
  void set_sad_amp_max(double value);
  int sad_n_div_max() const; // 0D_NOT_integer
  void set_sad_n_div_max(int value);
  int taylor_order() const; // 0D_NOT_integer
  void set_taylor_order(int value);
  int runge_kutta_order() const; // 0D_NOT_integer
  void set_runge_kutta_order(int value);
  int default_integ_order() const; // 0D_NOT_integer
  void set_default_integ_order(int value);
  int max_num_runge_kutta_step() const; // 0D_NOT_integer
  void set_max_num_runge_kutta_step(int value);
  bool rf_phase_below_transition_ref() const; // 0D_NOT_logical
  void set_rf_phase_below_transition_ref(bool value);
  bool sr_wakes_on() const; // 0D_NOT_logical
  void set_sr_wakes_on(bool value);
  bool lr_wakes_on() const; // 0D_NOT_logical
  void set_lr_wakes_on(bool value);
  bool auto_bookkeeper() const; // 0D_NOT_logical
  void set_auto_bookkeeper(bool value);
  bool high_energy_space_charge_on() const; // 0D_NOT_logical
  void set_high_energy_space_charge_on(bool value);
  bool csr_and_space_charge_on() const; // 0D_NOT_logical
  void set_csr_and_space_charge_on(bool value);
  bool spin_tracking_on() const; // 0D_NOT_logical
  void set_spin_tracking_on(bool value);
  bool spin_sokolov_ternov_flipping_on() const; // 0D_NOT_logical
  void set_spin_sokolov_ternov_flipping_on(bool value);
  bool radiation_damping_on() const; // 0D_NOT_logical
  void set_radiation_damping_on(bool value);
  bool radiation_zero_average() const; // 0D_NOT_logical
  void set_radiation_zero_average(bool value);
  bool radiation_fluctuations_on() const; // 0D_NOT_logical
  void set_radiation_fluctuations_on(bool value);
  bool conserve_taylor_maps() const; // 0D_NOT_logical
  void set_conserve_taylor_maps(bool value);
  bool absolute_time_tracking() const; // 0D_NOT_logical
  void set_absolute_time_tracking(bool value);
  bool absolute_time_ref_shift() const; // 0D_NOT_logical
  void set_absolute_time_ref_shift(bool value);
  bool convert_to_kinetic_momentum() const; // 0D_NOT_logical
  void set_convert_to_kinetic_momentum(bool value);
  bool normalize_twiss() const; // 0D_NOT_logical
  void set_normalize_twiss(bool value);
  bool aperture_limit_on() const; // 0D_NOT_logical
  void set_aperture_limit_on(bool value);
  bool spin_n0_direction_user_set() const; // 0D_NOT_logical
  void set_spin_n0_direction_user_set(bool value);
  bool debug() const; // 0D_NOT_logical
  void set_debug(bool value);
};

template <>
struct FortranTraits<RadInt1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_rad_int1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_int1_struct(ptr, 0);
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
  void set_i0(double value);
  double i1() const; // 0D_NOT_real
  void set_i1(double value);
  double i2() const; // 0D_NOT_real
  void set_i2(double value);
  double i3() const; // 0D_NOT_real
  void set_i3(double value);
  double i4a() const; // 0D_NOT_real
  void set_i4a(double value);
  double i4b() const; // 0D_NOT_real
  void set_i4b(double value);
  double i4z() const; // 0D_NOT_real
  void set_i4z(double value);
  double i5a() const; // 0D_NOT_real
  void set_i5a(double value);
  double i5b() const; // 0D_NOT_real
  void set_i5b(double value);
  double i6b() const; // 0D_NOT_real
  void set_i6b(double value);
  double lin_i2_E4() const; // 0D_NOT_real
  void set_lin_i2_E4(double value);
  double lin_i3_E7() const; // 0D_NOT_real
  void set_lin_i3_E7(double value);
  double lin_i5a_E6() const; // 0D_NOT_real
  void set_lin_i5a_E6(double value);
  double lin_i5b_E6() const; // 0D_NOT_real
  void set_lin_i5b_E6(double value);
  double lin_norm_emit_a() const; // 0D_NOT_real
  void set_lin_norm_emit_a(double value);
  double lin_norm_emit_b() const; // 0D_NOT_real
  void set_lin_norm_emit_b(double value);
  double lin_sig_E() const; // 0D_NOT_real
  void set_lin_sig_E(double value);
  double n_steps() const; // 0D_NOT_real
  void set_n_steps(double value);
};

template <>
struct FortranTraits<RadIntBranchProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_rad_int_branch_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_int_branch_struct(ptr, 0);
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

  RadInt1ProxyArray1D ele() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<RadIntAllEleProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_rad_int_all_ele_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rad_int_all_ele_struct(ptr, 0);
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

  RadIntBranchProxyArray1D branch() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<RfStairStepProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_rf_stair_step_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rf_stair_step_struct(ptr, 0);
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
  void set_E_tot0(double value);
  double E_tot1() const; // 0D_NOT_real
  void set_E_tot1(double value);
  double p0c() const; // 0D_NOT_real
  void set_p0c(double value);
  double p1c() const; // 0D_NOT_real
  void set_p1c(double value);
  double dE_amp() const; // 0D_NOT_real
  void set_dE_amp(double value);
  double scale() const; // 0D_NOT_real
  void set_scale(double value);
  double time() const; // 0D_NOT_real
  void set_time(double value);
  double s() const; // 0D_NOT_real
  void set_s(double value);
  int ix_step() const; // 0D_NOT_integer
  void set_ix_step(int value);
};

template <>
struct FortranTraits<RfEleProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_rf_ele_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_rf_ele_struct(ptr, 0);
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

  RfStairStepProxyArray1D steps() const; // 1D_ALLOC_type
  double ds_step() const; // 0D_NOT_real
  void set_ds_step(double value);
};

template <>
struct FortranTraits<EleProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_ele_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ele_struct(ptr, 0);
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
  void set_name(const std::string& value);
  std::string type() const; // 0D_NOT_character
  void set_type(const std::string& value);
  std::string alias() const; // 0D_NOT_character
  void set_alias(const std::string& value);
  std::string component_name() const; // 0D_NOT_character
  void set_component_name(const std::string& value);
  std::string descrip() const; // 0D_PTR_character
  void set_descrip(const std::string& value);
  TwissProxy a() const; // 0D_NOT_type
  void set_a(const TwissProxy& src);
  TwissProxy b() const; // 0D_NOT_type
  void set_b(const TwissProxy& src);
  TwissProxy z() const; // 0D_NOT_type
  void set_z(const TwissProxy& src);
  XyDispProxy x() const; // 0D_NOT_type
  void set_x(const XyDispProxy& src);
  XyDispProxy y() const; // 0D_NOT_type
  void set_y(const XyDispProxy& src);
  std::optional<AcKickerProxy> ac_kick() const; // 0D_PTR_type
  void set_ac_kick(const AcKickerProxy& src);
  BookkeepingStateProxy bookkeeping_state() const; // 0D_NOT_type
  void set_bookkeeping_state(const BookkeepingStateProxy& src);
  std::optional<BranchProxy> branch() const; // 0D_PTR_type
  void set_branch(const BranchProxy& src);
  std::optional<ControllerProxy> control() const; // 0D_PTR_type
  void set_control(const ControllerProxy& src);
  std::optional<RfEleProxy> rf() const; // 0D_PTR_type
  void set_rf(const RfEleProxy& src);
  std::optional<EleProxy> lord() const; // 0D_PTR_type
  void set_lord(const EleProxy& src);
  FloorPositionProxy floor() const; // 0D_NOT_type
  void set_floor(const FloorPositionProxy& src);
  std::optional<HighEnergySpaceChargeProxy> high_energy_space_charge()
      const; // 0D_PTR_type
  void set_high_energy_space_charge(const HighEnergySpaceChargeProxy& src);
  std::optional<Mode3Proxy> mode3() const; // 0D_PTR_type
  void set_mode3(const Mode3Proxy& src);
  std::optional<PhotonElementProxy> photon() const; // 0D_PTR_type
  void set_photon(const PhotonElementProxy& src);
  std::optional<RadMapEleProxy> rad_map() const; // 0D_PTR_type
  void set_rad_map(const RadMapEleProxy& src);
  TaylorProxyArray1D taylor() const; // 1D_NOT_type
  FortranArray1D<double> spin_taylor_ref_orb_in() const; // 1D_NOT_real
  TaylorProxyArray1D spin_taylor() const; // 1D_NOT_type
  std::optional<WakeProxy> wake() const; // 0D_PTR_type
  void set_wake(const WakeProxy& src);
  Wall3dProxyArray1D wall3d() const; // 1D_PTR_type
  CartesianMapProxyArray1D cartesian_map() const; // 1D_PTR_type
  CylindricalMapProxyArray1D cylindrical_map() const; // 1D_PTR_type
  GenGradMapProxyArray1D gen_grad_map() const; // 1D_PTR_type
  GridFieldProxyArray1D grid_field() const; // 1D_PTR_type
  CoordProxy map_ref_orb_in() const; // 0D_NOT_type
  void set_map_ref_orb_in(const CoordProxy& src);
  CoordProxy map_ref_orb_out() const; // 0D_NOT_type
  void set_map_ref_orb_out(const CoordProxy& src);
  CoordProxy time_ref_orb_in() const; // 0D_NOT_type
  void set_time_ref_orb_in(const CoordProxy& src);
  CoordProxy time_ref_orb_out() const; // 0D_NOT_type
  void set_time_ref_orb_out(const CoordProxy& src);
  FortranArray1D<double> value() const; // 1D_NOT_real
  FortranArray1D<double> old_value() const; // 1D_NOT_real
  FortranArray2D<double> spin_q() const; // 2D_NOT_real
  FortranArray1D<double> vec0() const; // 1D_NOT_real
  FortranArray2D<double> mat6() const; // 2D_NOT_real
  FortranArray2D<double> c_mat() const; // 2D_NOT_real
  double gamma_c() const; // 0D_NOT_real
  void set_gamma_c(double value);
  double s_start() const; // 0D_NOT_real
  void set_s_start(double value);
  double s() const; // 0D_NOT_real
  void set_s(double value);
  double ref_time() const; // 0D_NOT_real
  void set_ref_time(double value);
  FortranArray1D<double> a_pole() const; // 1D_PTR_real
  FortranArray1D<double> b_pole() const; // 1D_PTR_real
  FortranArray1D<double> a_pole_elec() const; // 1D_PTR_real
  FortranArray1D<double> b_pole_elec() const; // 1D_PTR_real
  FortranArray1D<double> custom() const; // 1D_PTR_real
  FortranArray3D<double> r() const; // 3D_PTR_real
  int key() const; // 0D_NOT_integer
  void set_key(int value);
  int sub_key() const; // 0D_NOT_integer
  void set_sub_key(int value);
  int ix_ele() const; // 0D_NOT_integer
  void set_ix_ele(int value);
  int ix_branch() const; // 0D_NOT_integer
  void set_ix_branch(int value);
  int lord_status() const; // 0D_NOT_integer
  void set_lord_status(int value);
  int n_slave() const; // 0D_NOT_integer
  void set_n_slave(int value);
  int n_slave_field() const; // 0D_NOT_integer
  void set_n_slave_field(int value);
  int ix1_slave() const; // 0D_NOT_integer
  void set_ix1_slave(int value);
  int slave_status() const; // 0D_NOT_integer
  void set_slave_status(int value);
  int n_lord() const; // 0D_NOT_integer
  void set_n_lord(int value);
  int n_lord_field() const; // 0D_NOT_integer
  void set_n_lord_field(int value);
  int n_lord_ramper() const; // 0D_NOT_integer
  void set_n_lord_ramper(int value);
  int ic1_lord() const; // 0D_NOT_integer
  void set_ic1_lord(int value);
  int ix_pointer() const; // 0D_NOT_integer
  void set_ix_pointer(int value);
  int ixx() const; // 0D_NOT_integer
  void set_ixx(int value);
  int iyy() const; // 0D_NOT_integer
  void set_iyy(int value);
  int izz() const; // 0D_NOT_integer
  void set_izz(int value);
  int mat6_calc_method() const; // 0D_NOT_integer
  void set_mat6_calc_method(int value);
  int tracking_method() const; // 0D_NOT_integer
  void set_tracking_method(int value);
  int spin_tracking_method() const; // 0D_NOT_integer
  void set_spin_tracking_method(int value);
  int csr_method() const; // 0D_NOT_integer
  void set_csr_method(int value);
  int space_charge_method() const; // 0D_NOT_integer
  void set_space_charge_method(int value);
  int ptc_integration_type() const; // 0D_NOT_integer
  void set_ptc_integration_type(int value);
  int field_calc() const; // 0D_NOT_integer
  void set_field_calc(int value);
  int aperture_at() const; // 0D_NOT_integer
  void set_aperture_at(int value);
  int aperture_type() const; // 0D_NOT_integer
  void set_aperture_type(int value);
  int ref_species() const; // 0D_NOT_integer
  void set_ref_species(int value);
  int orientation() const; // 0D_NOT_integer
  void set_orientation(int value);
  bool symplectify() const; // 0D_NOT_logical
  void set_symplectify(bool value);
  bool mode_flip() const; // 0D_NOT_logical
  void set_mode_flip(bool value);
  bool multipoles_on() const; // 0D_NOT_logical
  void set_multipoles_on(bool value);
  bool scale_multipoles() const; // 0D_NOT_logical
  void set_scale_multipoles(bool value);
  bool taylor_map_includes_offsets() const; // 0D_NOT_logical
  void set_taylor_map_includes_offsets(bool value);
  bool field_master() const; // 0D_NOT_logical
  void set_field_master(bool value);
  bool is_on() const; // 0D_NOT_logical
  void set_is_on(bool value);
  bool logic() const; // 0D_NOT_logical
  void set_logic(bool value);
  bool bmad_logic() const; // 0D_NOT_logical
  void set_bmad_logic(bool value);
  bool select() const; // 0D_NOT_logical
  void set_select(bool value);
  bool offset_moves_aperture() const; // 0D_NOT_logical
  void set_offset_moves_aperture(bool value);
};

template <>
struct FortranTraits<ComplexTaylorTermProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_complex_taylor_term_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_complex_taylor_term_struct(ptr, 0);
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
  void set_coef(std::complex<double> value);
  FortranArray1D<int> expn() const; // 1D_NOT_integer
};

template <>
struct FortranTraits<ComplexTaylorProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_complex_taylor_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_complex_taylor_struct(ptr, 0);
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
  void set_ref(std::complex<double> value);
  ComplexTaylorTermProxyArray1D term() const; // 1D_PTR_type
};

template <>
struct FortranTraits<BranchProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_branch_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_branch_struct(ptr, 0);
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
  void set_name(const std::string& value);
  int ix_branch() const; // 0D_NOT_integer
  void set_ix_branch(int value);
  int ix_from_branch() const; // 0D_NOT_integer
  void set_ix_from_branch(int value);
  int ix_from_ele() const; // 0D_NOT_integer
  void set_ix_from_ele(int value);
  int ix_to_ele() const; // 0D_NOT_integer
  void set_ix_to_ele(int value);
  int ix_fixer() const; // 0D_NOT_integer
  void set_ix_fixer(int value);
  int n_ele_track() const; // 0D_NOT_integer
  void set_n_ele_track(int value);
  int n_ele_max() const; // 0D_NOT_integer
  void set_n_ele_max(int value);
  std::optional<LatProxy> lat() const; // 0D_PTR_type
  void set_lat(const LatProxy& src);
  ModeInfoProxy a() const; // 0D_NOT_type
  void set_a(const ModeInfoProxy& src);
  ModeInfoProxy b() const; // 0D_NOT_type
  void set_b(const ModeInfoProxy& src);
  ModeInfoProxy z() const; // 0D_NOT_type
  void set_z(const ModeInfoProxy& src);
  EleProxyArray1D ele() const; // 1D_PTR_type
  LatParamProxy param() const; // 0D_NOT_type
  void set_param(const LatParamProxy& src);
  CoordProxy particle_start() const; // 0D_NOT_type
  void set_particle_start(const CoordProxy& src);
  Wall3dProxyArray1D wall3d() const; // 1D_PTR_type
};

template <>
struct FortranTraits<LatProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_lat_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_struct(ptr, 0);
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
  void set_use_name(const std::string& value);
  std::string lattice() const; // 0D_NOT_character
  void set_lattice(const std::string& value);
  std::string machine() const; // 0D_NOT_character
  void set_machine(const std::string& value);
  std::string input_file_name() const; // 0D_NOT_character
  void set_input_file_name(const std::string& value);
  std::string title() const; // 0D_NOT_character
  void set_title(const std::string& value);
  FortranCharArray1D print_str() const; // 1D_ALLOC_character
  ExpressionAtomProxyArray1D constant() const; // 1D_ALLOC_type
  std::optional<ModeInfoProxy> a() const; // 0D_PTR_type
  void set_a(const ModeInfoProxy& src);
  std::optional<ModeInfoProxy> b() const; // 0D_PTR_type
  void set_b(const ModeInfoProxy& src);
  std::optional<ModeInfoProxy> z() const; // 0D_PTR_type
  void set_z(const ModeInfoProxy& src);
  std::optional<LatParamProxy> param() const; // 0D_PTR_type
  void set_param(const LatParamProxy& src);
  BookkeepingStateProxy lord_state() const; // 0D_NOT_type
  void set_lord_state(const BookkeepingStateProxy& src);
  EleProxy ele_init() const; // 0D_NOT_type
  void set_ele_init(const EleProxy& src);
  EleProxyArray1D ele() const; // 1D_PTR_type
  BranchProxyArray1D branch() const; // 1D_ALLOC_type
  ControlProxyArray1D control() const; // 1D_ALLOC_type
  std::optional<CoordProxy> particle_start() const; // 0D_PTR_type
  void set_particle_start(const CoordProxy& src);
  BeamInitProxy beam_init() const; // 0D_NOT_type
  void set_beam_init(const BeamInitProxy& src);
  PreTrackerProxy pre_tracker() const; // 0D_NOT_type
  void set_pre_tracker(const PreTrackerProxy& src);
  FortranArray1D<double> custom() const; // 1D_ALLOC_real
  int version() const; // 0D_NOT_integer
  void set_version(int value);
  int* n_ele_track() const; // 0D_PTR_integer
  void set_n_ele_track(int value);
  int* n_ele_max() const; // 0D_PTR_integer
  void set_n_ele_max(int value);
  int n_control_max() const; // 0D_NOT_integer
  void set_n_control_max(int value);
  int n_ic_max() const; // 0D_NOT_integer
  void set_n_ic_max(int value);
  int input_taylor_order() const; // 0D_NOT_integer
  void set_input_taylor_order(int value);
  FortranArray1D<int> ic() const; // 1D_ALLOC_integer
  int photon_type() const; // 0D_NOT_integer
  void set_photon_type(int value);
  int creation_hash() const; // 0D_NOT_integer
  void set_creation_hash(int value);
  int ramper_slave_bookkeeping() const; // 0D_NOT_integer
  void set_ramper_slave_bookkeeping(int value);
};

template <>
struct FortranTraits<BunchProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_bunch_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bunch_struct(ptr, 0);
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

  CoordProxyArray1D particle() const; // 1D_ALLOC_type
  FortranArray1D<int> ix_z() const; // 1D_ALLOC_integer
  double charge_tot() const; // 0D_NOT_real
  void set_charge_tot(double value);
  double charge_live() const; // 0D_NOT_real
  void set_charge_live(double value);
  double z_center() const; // 0D_NOT_real
  void set_z_center(double value);
  double t_center() const; // 0D_NOT_real
  void set_t_center(double value);
  double t0() const; // 0D_NOT_real
  void set_t0(double value);
  bool drift_between_t_and_s() const; // 0D_NOT_logical
  void set_drift_between_t_and_s(bool value);
  int ix_ele() const; // 0D_NOT_integer
  void set_ix_ele(int value);
  int ix_bunch() const; // 0D_NOT_integer
  void set_ix_bunch(int value);
  int ix_turn() const; // 0D_NOT_integer
  void set_ix_turn(int value);
  int n_live() const; // 0D_NOT_integer
  void set_n_live(int value);
  int n_good() const; // 0D_NOT_integer
  void set_n_good(int value);
  int n_bad() const; // 0D_NOT_integer
  void set_n_bad(int value);
};

template <>
struct FortranTraits<BunchParamsProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_bunch_params_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bunch_params_struct(ptr, 0);
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
  void set_centroid(const CoordProxy& src);
  TwissProxy x() const; // 0D_NOT_type
  void set_x(const TwissProxy& src);
  TwissProxy y() const; // 0D_NOT_type
  void set_y(const TwissProxy& src);
  TwissProxy z() const; // 0D_NOT_type
  void set_z(const TwissProxy& src);
  TwissProxy a() const; // 0D_NOT_type
  void set_a(const TwissProxy& src);
  TwissProxy b() const; // 0D_NOT_type
  void set_b(const TwissProxy& src);
  TwissProxy c() const; // 0D_NOT_type
  void set_c(const TwissProxy& src);
  FortranArray2D<double> sigma() const; // 2D_NOT_real
  FortranArray1D<double> rel_max() const; // 1D_NOT_real
  FortranArray1D<double> rel_min() const; // 1D_NOT_real
  double s() const; // 0D_NOT_real
  void set_s(double value);
  double t() const; // 0D_NOT_real
  void set_t(double value);
  double sigma_t() const; // 0D_NOT_real
  void set_sigma_t(double value);
  double charge_live() const; // 0D_NOT_real
  void set_charge_live(double value);
  double charge_tot() const; // 0D_NOT_real
  void set_charge_tot(double value);
  int n_particle_tot() const; // 0D_NOT_integer
  void set_n_particle_tot(int value);
  int n_particle_live() const; // 0D_NOT_integer
  void set_n_particle_live(int value);
  int n_particle_lost_in_ele() const; // 0D_NOT_integer
  void set_n_particle_lost_in_ele(int value);
  int n_good_steps() const; // 0D_NOT_integer
  void set_n_good_steps(int value);
  int n_bad_steps() const; // 0D_NOT_integer
  void set_n_bad_steps(int value);
  int ix_ele() const; // 0D_NOT_integer
  void set_ix_ele(int value);
  int location() const; // 0D_NOT_integer
  void set_location(int value);
  bool twiss_valid() const; // 0D_NOT_logical
  void set_twiss_valid(bool value);
};

template <>
struct FortranTraits<BeamProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_beam_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_beam_struct(ptr, 0);
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

  BunchProxyArray1D bunch() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<AperturePointProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_aperture_point_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_aperture_point_struct(ptr, 0);
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
  void set_x(double value);
  double y() const; // 0D_NOT_real
  void set_y(double value);
  int plane() const; // 0D_NOT_integer
  void set_plane(int value);
  int ix_ele() const; // 0D_NOT_integer
  void set_ix_ele(int value);
  int i_turn() const; // 0D_NOT_integer
  void set_i_turn(int value);
};

template <>
struct FortranTraits<ApertureParamProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_aperture_param_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_aperture_param_struct(ptr, 0);
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
  void set_min_angle(double value);
  double max_angle() const; // 0D_NOT_real
  void set_max_angle(double value);
  int n_angle() const; // 0D_NOT_integer
  void set_n_angle(int value);
  int n_turn() const; // 0D_NOT_integer
  void set_n_turn(int value);
  double x_init() const; // 0D_NOT_real
  void set_x_init(double value);
  double y_init() const; // 0D_NOT_real
  void set_y_init(double value);
  double rel_accuracy() const; // 0D_NOT_real
  void set_rel_accuracy(double value);
  double abs_accuracy() const; // 0D_NOT_real
  void set_abs_accuracy(double value);
  std::string start_ele() const; // 0D_NOT_character
  void set_start_ele(const std::string& value);
};

template <>
struct FortranTraits<ApertureScanProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_aperture_scan_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_aperture_scan_struct(ptr, 0);
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

  AperturePointProxyArray1D point() const; // 1D_ALLOC_type
  CoordProxy ref_orb() const; // 0D_NOT_type
  void set_ref_orb(const CoordProxy& src);
  double pz_start() const; // 0D_NOT_real
  void set_pz_start(double value);
};

template <>
struct FortranTraits<TaoSpinDnDpzProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_spin_dn_dpz_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_spin_dn_dpz_struct(ptr, 0);
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
  FortranArray2D<double> partial() const; // 2D_NOT_real
  FortranArray2D<double> partial2() const; // 2D_NOT_real
};

template <>
struct FortranTraits<ResonanceHProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_resonance_h_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_resonance_h_struct(ptr, 0);
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
  void set_id(const std::string& value);
  std::complex<double> c_val() const; // 0D_NOT_complex
  void set_c_val(std::complex<double> value);
};

template <>
struct FortranTraits<SpinOrbitMap1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_spin_orbit_map1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_spin_orbit_map1_struct(ptr, 0);
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

  FortranArray2D<double> orb_mat() const; // 2D_NOT_real
  FortranArray1D<double> vec0() const; // 1D_NOT_real
  FortranArray2D<double> spin_q() const; // 2D_NOT_real
};

template <>
struct FortranTraits<SpinAxisProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_spin_axis_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_spin_axis_struct(ptr, 0);
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

template <>
struct FortranTraits<PtcNormalFormProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_ptc_normal_form_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_ptc_normal_form_struct(ptr, 0);
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

  std::optional<EleProxy> ele_origin() const; // 0D_PTR_type
  void set_ele_origin(const EleProxy& src);
  FortranArray1D<double> orb0() const; // 1D_NOT_real
  bool valid_map() const; // 0D_NOT_logical
  void set_valid_map(bool value);
};

template <>
struct FortranTraits<BmadNormalFormProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_bmad_normal_form_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bmad_normal_form_struct(ptr, 0);
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

  std::optional<EleProxy> ele_origin() const; // 0D_PTR_type
  void set_ele_origin(const EleProxy& src);
  TaylorProxyArray1D M() const; // 1D_NOT_type
  TaylorProxyArray1D A() const; // 1D_NOT_type
  TaylorProxyArray1D A_inv() const; // 1D_NOT_type
  TaylorProxyArray1D dhdj() const; // 1D_NOT_type
  ComplexTaylorProxyArray1D F() const; // 1D_NOT_type
  ComplexTaylorProxyArray1D L() const; // 1D_NOT_type
  ResonanceHProxyArray1D h() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<BunchTrackProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_bunch_track_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_bunch_track_struct(ptr, 0);
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

  BunchParamsProxyArray1D pt() const; // 1D_ALLOC_type
  double ds_save() const; // 0D_NOT_real
  void set_ds_save(double value);
  int n_pt() const; // 0D_NOT_integer
  void set_n_pt(int value);
};

template <>
struct FortranTraits<SummationRdtProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_summation_rdt_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_summation_rdt_struct(ptr, 0);
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
  void set_h11001(std::complex<double> value);
  std::complex<double> h00111() const; // 0D_NOT_complex
  void set_h00111(std::complex<double> value);
  std::complex<double> h20001() const; // 0D_NOT_complex
  void set_h20001(std::complex<double> value);
  std::complex<double> h00201() const; // 0D_NOT_complex
  void set_h00201(std::complex<double> value);
  std::complex<double> h10002() const; // 0D_NOT_complex
  void set_h10002(std::complex<double> value);
  std::complex<double> h21000() const; // 0D_NOT_complex
  void set_h21000(std::complex<double> value);
  std::complex<double> h30000() const; // 0D_NOT_complex
  void set_h30000(std::complex<double> value);
  std::complex<double> h10110() const; // 0D_NOT_complex
  void set_h10110(std::complex<double> value);
  std::complex<double> h10020() const; // 0D_NOT_complex
  void set_h10020(std::complex<double> value);
  std::complex<double> h10200() const; // 0D_NOT_complex
  void set_h10200(std::complex<double> value);
  std::complex<double> h31000() const; // 0D_NOT_complex
  void set_h31000(std::complex<double> value);
  std::complex<double> h40000() const; // 0D_NOT_complex
  void set_h40000(std::complex<double> value);
  std::complex<double> h20110() const; // 0D_NOT_complex
  void set_h20110(std::complex<double> value);
  std::complex<double> h11200() const; // 0D_NOT_complex
  void set_h11200(std::complex<double> value);
  std::complex<double> h20020() const; // 0D_NOT_complex
  void set_h20020(std::complex<double> value);
  std::complex<double> h20200() const; // 0D_NOT_complex
  void set_h20200(std::complex<double> value);
  std::complex<double> h00310() const; // 0D_NOT_complex
  void set_h00310(std::complex<double> value);
  std::complex<double> h00400() const; // 0D_NOT_complex
  void set_h00400(std::complex<double> value);
  std::complex<double> h22000() const; // 0D_NOT_complex
  void set_h22000(std::complex<double> value);
  std::complex<double> h00220() const; // 0D_NOT_complex
  void set_h00220(std::complex<double> value);
  std::complex<double> h11110() const; // 0D_NOT_complex
  void set_h11110(std::complex<double> value);
};

template <>
struct FortranTraits<LatEleOrder1Proxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_lat_ele_order1_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_ele_order1_struct(ptr, 0);
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
  void set_ix_branch(int value);
  int ix_order() const; // 0D_NOT_integer
  void set_ix_order(int value);
};

template <>
struct FortranTraits<LatEleOrderArrayProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_lat_ele_order_array_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_ele_order_array_struct(ptr, 0);
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

  LatEleOrder1ProxyArray1D ele() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<TaoLatSigmaProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_lat_sigma_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_lat_sigma_struct(ptr, 0);
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

  FortranArray2D<double> mat() const; // 2D_NOT_real
};

template <>
struct FortranTraits<TaoSpinEleProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_spin_ele_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_spin_ele_struct(ptr, 0);
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
  void set_dn_dpz(const TaoSpinDnDpzProxy& src);
  FortranArray1D<double> orb_eigen_val() const; // 1D_NOT_real
  FortranArray2D<double> orb_eigen_vec() const; // 2D_NOT_real
  FortranArray2D<double> spin_eigen_vec() const; // 2D_NOT_real
  bool valid() const; // 0D_NOT_logical
  void set_valid(bool value);
};

template <>
struct FortranTraits<TaoPlotCacheProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_plot_cache_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_plot_cache_struct(ptr, 0);
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
  void set_ele_to_s(const EleProxy& src);
  CoordProxy orbit() const; // 0D_NOT_type
  void set_orbit(const CoordProxy& src);
  bool err() const; // 0D_NOT_logical
  void set_err(bool value);
};

template <>
struct FortranTraits<TaoSpinPolarizationProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_spin_polarization_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_spin_polarization_struct(ptr, 0);
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
  void set_tune(double value);
  double pol_limit_st() const; // 0D_NOT_real
  void set_pol_limit_st(double value);
  double pol_limit_dk() const; // 0D_NOT_real
  void set_pol_limit_dk(double value);
  FortranArray1D<double> pol_limit_dk_partial() const; // 1D_NOT_real
  FortranArray1D<double> pol_limit_dk_partial2() const; // 1D_NOT_real
  double pol_rate_bks() const; // 0D_NOT_real
  void set_pol_rate_bks(double value);
  double depol_rate() const; // 0D_NOT_real
  void set_depol_rate(double value);
  FortranArray1D<double> depol_rate_partial() const; // 1D_NOT_real
  FortranArray1D<double> depol_rate_partial2() const; // 1D_NOT_real
  double integral_bn() const; // 0D_NOT_real
  void set_integral_bn(double value);
  double integral_bdn() const; // 0D_NOT_real
  void set_integral_bdn(double value);
  double integral_1ns() const; // 0D_NOT_real
  void set_integral_1ns(double value);
  double integral_dn2() const; // 0D_NOT_real
  void set_integral_dn2(double value);
  bool valid() const; // 0D_NOT_logical
  void set_valid(bool value);
  SpinOrbitMap1Proxy q_1turn() const; // 0D_NOT_type
  void set_q_1turn(const SpinOrbitMap1Proxy& src);
  SpinOrbitMap1ProxyArray1D q_ele() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<TaoLatticeBranchProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_lattice_branch_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_lattice_branch_struct(ptr, 0);
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

  std::optional<TaoLatticeProxy> tao_lat() const; // 0D_PTR_type
  void set_tao_lat(const TaoLatticeProxy& src);
  TaoLatSigmaProxyArray1D lat_sigma() const; // 1D_ALLOC_type
  TaoSpinEleProxyArray1D spin_ele() const; // 1D_ALLOC_type
  BunchParamsProxyArray1D bunch_params() const; // 1D_ALLOC_type
  BunchTrackProxyArray1D bunch_params_comb() const; // 1D_ALLOC_type
  CoordProxyArray1D orbit() const; // 1D_ALLOC_type
  TaoPlotCacheProxyArray1D plot_cache() const; // 1D_ALLOC_type
  TaoSpinPolarizationProxy spin() const; // 0D_NOT_type
  void set_spin(const TaoSpinPolarizationProxy& src);
  SummationRdtProxy srdt() const; // 0D_NOT_type
  void set_srdt(const SummationRdtProxy& src);
  CoordProxy orb0() const; // 0D_NOT_type
  void set_orb0(const CoordProxy& src);
  NormalModesProxy modes_ri() const; // 0D_NOT_type
  void set_modes_ri(const NormalModesProxy& src);
  NormalModesProxy modes_6d() const; // 0D_NOT_type
  void set_modes_6d(const NormalModesProxy& src);
  PtcNormalFormProxy ptc_normal_form() const; // 0D_NOT_type
  void set_ptc_normal_form(const PtcNormalFormProxy& src);
  BmadNormalFormProxy bmad_normal_form() const; // 0D_NOT_type
  void set_bmad_normal_form(const BmadNormalFormProxy& src);
  CoordProxyArray1D high_E_orb() const; // 1D_ALLOC_type
  CoordProxyArray1D low_E_orb() const; // 1D_ALLOC_type
  double cache_x_min() const; // 0D_NOT_real
  void set_cache_x_min(double value);
  double cache_x_max() const; // 0D_NOT_real
  void set_cache_x_max(double value);
  double comb_ds_save() const; // 0D_NOT_real
  void set_comb_ds_save(double value);
  int track_state() const; // 0D_NOT_integer
  void set_track_state(int value);
  int cache_n_pts() const; // 0D_NOT_integer
  void set_cache_n_pts(int value);
  int ix_rad_int_cache() const; // 0D_NOT_integer
  void set_ix_rad_int_cache(int value);
  bool has_open_match_element() const; // 0D_NOT_logical
  void set_has_open_match_element(bool value);
  bool plot_cache_valid() const; // 0D_NOT_logical
  void set_plot_cache_valid(bool value);
  bool spin_map_valid() const; // 0D_NOT_logical
  void set_spin_map_valid(bool value);
  bool twiss_valid() const; // 0D_NOT_logical
  void set_twiss_valid(bool value);
  bool mode_flip_here() const; // 0D_NOT_logical
  void set_mode_flip_here(bool value);
  bool chrom_calc_ok() const; // 0D_NOT_logical
  void set_chrom_calc_ok(bool value);
  bool rad_int_calc_ok() const; // 0D_NOT_logical
  void set_rad_int_calc_ok(bool value);
  bool emit_6d_calc_ok() const; // 0D_NOT_logical
  void set_emit_6d_calc_ok(bool value);
  bool sigma_track_ok() const; // 0D_NOT_logical
  void set_sigma_track_ok(bool value);
};

template <>
struct FortranTraits<TaoModelElementProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_model_element_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_model_element_struct(ptr, 0);
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
  void set_beam(const BeamProxy& src);
  bool save_beam_internally() const; // 0D_NOT_logical
  void set_save_beam_internally(bool value);
  bool save_beam_to_file() const; // 0D_NOT_logical
  void set_save_beam_to_file(bool value);
};

template <>
struct FortranTraits<TaoBeamBranchProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_beam_branch_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_beam_branch_struct(ptr, 0);
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
  void set_beam_at_start(const BeamProxy& src);
  BeamInitProxy beam_init() const; // 0D_NOT_type
  void set_beam_init(const BeamInitProxy& src);
  BeamInitProxy beam_init_used() const; // 0D_NOT_type
  void set_beam_init_used(const BeamInitProxy& src);
  bool init_starting_distribution() const; // 0D_NOT_logical
  void set_init_starting_distribution(bool value);
  std::string track_start() const; // 0D_NOT_character
  void set_track_start(const std::string& value);
  std::string track_end() const; // 0D_NOT_character
  void set_track_end(const std::string& value);
  int ix_branch() const; // 0D_NOT_integer
  void set_ix_branch(int value);
  int ix_track_start() const; // 0D_NOT_integer
  void set_ix_track_start(int value);
  int ix_track_end() const; // 0D_NOT_integer
  void set_ix_track_end(int value);
};

template <>
struct FortranTraits<TaoD1DataProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_d1_data_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_d1_data_struct(ptr, 0);
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
  void set_name(const std::string& value);
  std::optional<TaoD2DataProxy> d2() const; // 0D_PTR_type
  void set_d2(const TaoD2DataProxy& src);
  TaoDataProxyArray1D d() const; // 1D_PTR_type
};

template <>
struct FortranTraits<TaoLatticeProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_lattice_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_lattice_struct(ptr, 0);
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
  void set_name(const std::string& value);
  LatProxy lat() const; // 0D_NOT_type
  void set_lat(const LatProxy& src);
  LatProxy high_E_lat() const; // 0D_NOT_type
  void set_high_E_lat(const LatProxy& src);
  LatProxy low_E_lat() const; // 0D_NOT_type
  void set_low_E_lat(const LatProxy& src);
  RadIntAllEleProxy rad_int_by_ele_ri() const; // 0D_NOT_type
  void set_rad_int_by_ele_ri(const RadIntAllEleProxy& src);
  RadIntAllEleProxy rad_int_by_ele_6d() const; // 0D_NOT_type
  void set_rad_int_by_ele_6d(const RadIntAllEleProxy& src);
  TaoLatticeBranchProxyArray1D tao_branch() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<TaoBeamUniProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_beam_uni_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_beam_uni_struct(ptr, 0);
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
  void set_saved_at(const std::string& value);
  std::string dump_file() const; // 0D_NOT_character
  void set_dump_file(const std::string& value);
  std::string dump_at() const; // 0D_NOT_character
  void set_dump_at(const std::string& value);
  bool track_beam_in_universe() const; // 0D_NOT_logical
  void set_track_beam_in_universe(bool value);
  bool always_reinit() const; // 0D_NOT_logical
  void set_always_reinit(bool value);
};

template <>
struct FortranTraits<TaoDynamicApertureProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_dynamic_aperture_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_dynamic_aperture_struct(ptr, 0);
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
  void set_param(const ApertureParamProxy& src);
  ApertureScanProxyArray1D scan() const; // 1D_ALLOC_type
  FortranArray1D<double> pz() const; // 1D_ALLOC_real
  double ellipse_scale() const; // 0D_NOT_real
  void set_ellipse_scale(double value);
  double a_emit() const; // 0D_NOT_real
  void set_a_emit(double value);
  double b_emit() const; // 0D_NOT_real
  void set_b_emit(double value);
};

template <>
struct FortranTraits<TaoModelBranchProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_model_branch_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_model_branch_struct(ptr, 0);
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

  TaoModelElementProxyArray1D ele() const; // 1D_ALLOC_type
  TaoBeamBranchProxy beam() const; // 0D_NOT_type
  void set_beam(const TaoBeamBranchProxy& src);
};

template <>
struct FortranTraits<TaoD2DataProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_d2_data_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_d2_data_struct(ptr, 0);
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
  void set_name(const std::string& value);
  std::string data_file_name() const; // 0D_NOT_character
  void set_data_file_name(const std::string& value);
  std::string ref_file_name() const; // 0D_NOT_character
  void set_ref_file_name(const std::string& value);
  std::string data_date() const; // 0D_NOT_character
  void set_data_date(const std::string& value);
  std::string ref_date() const; // 0D_NOT_character
  void set_ref_date(const std::string& value);
  FortranCharArray1D descrip() const; // 1D_NOT_character
  TaoD1DataProxyArray1D d1() const; // 1D_ALLOC_type
  int ix_universe() const; // 0D_NOT_integer
  void set_ix_universe(int value);
  int ix_d2_data() const; // 0D_NOT_integer
  void set_ix_d2_data(int value);
  int ix_ref() const; // 0D_NOT_integer
  void set_ix_ref(int value);
  bool data_read_in() const; // 0D_NOT_logical
  void set_data_read_in(bool value);
  bool ref_read_in() const; // 0D_NOT_logical
  void set_ref_read_in(bool value);
};

template <>
struct FortranTraits<TaoSpinMapProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_spin_map_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_spin_map_struct(ptr, 0);
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
  void set_valid(bool value);
  SpinOrbitMap1Proxy map1() const; // 0D_NOT_type
  void set_map1(const SpinOrbitMap1Proxy& src);
  SpinAxisProxy axis_input() const; // 0D_NOT_type
  void set_axis_input(const SpinAxisProxy& src);
  SpinAxisProxy axis0() const; // 0D_NOT_type
  void set_axis0(const SpinAxisProxy& src);
  SpinAxisProxy axis1() const; // 0D_NOT_type
  void set_axis1(const SpinAxisProxy& src);
  int ix_ele() const; // 0D_NOT_integer
  void set_ix_ele(int value);
  int ix_ref() const; // 0D_NOT_integer
  void set_ix_ref(int value);
  int ix_uni() const; // 0D_NOT_integer
  void set_ix_uni(int value);
  int ix_branch() const; // 0D_NOT_integer
  void set_ix_branch(int value);
  FortranArray2D<double> mat8() const; // 2D_NOT_real
};

template <>
struct FortranTraits<TaoDataProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_data_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_data_struct(ptr, 0);
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
  void set_ele_name(const std::string& value);
  std::string ele_start_name() const; // 0D_NOT_character
  void set_ele_start_name(const std::string& value);
  std::string ele_ref_name() const; // 0D_NOT_character
  void set_ele_ref_name(const std::string& value);
  std::string data_type() const; // 0D_ALLOC_character
  void set_data_type(const std::string& value);
  std::string merit_type() const; // 0D_NOT_character
  void set_merit_type(const std::string& value);
  std::string id() const; // 0D_NOT_character
  void set_id(const std::string& value);
  std::string data_source() const; // 0D_NOT_character
  void set_data_source(const std::string& value);
  std::string why_invalid() const; // 0D_NOT_character
  void set_why_invalid(const std::string& value);
  int ix_uni() const; // 0D_NOT_integer
  void set_ix_uni(int value);
  int ix_bunch() const; // 0D_NOT_integer
  void set_ix_bunch(int value);
  int ix_branch() const; // 0D_NOT_integer
  void set_ix_branch(int value);
  int ix_ele() const; // 0D_NOT_integer
  void set_ix_ele(int value);
  int ix_ele_start() const; // 0D_NOT_integer
  void set_ix_ele_start(int value);
  int ix_ele_ref() const; // 0D_NOT_integer
  void set_ix_ele_ref(int value);
  int ix_ele_merit() const; // 0D_NOT_integer
  void set_ix_ele_merit(int value);
  int ix_d1() const; // 0D_NOT_integer
  void set_ix_d1(int value);
  int ix_data() const; // 0D_NOT_integer
  void set_ix_data(int value);
  int ix_dModel() const; // 0D_NOT_integer
  void set_ix_dModel(int value);
  int eval_point() const; // 0D_NOT_integer
  void set_eval_point(int value);
  double meas_value() const; // 0D_NOT_real
  void set_meas_value(double value);
  double ref_value() const; // 0D_NOT_real
  void set_ref_value(double value);
  double model_value() const; // 0D_NOT_real
  void set_model_value(double value);
  double design_value() const; // 0D_NOT_real
  void set_design_value(double value);
  double old_value() const; // 0D_NOT_real
  void set_old_value(double value);
  double base_value() const; // 0D_NOT_real
  void set_base_value(double value);
  double error_rms() const; // 0D_NOT_real
  void set_error_rms(double value);
  double delta_merit() const; // 0D_NOT_real
  void set_delta_merit(double value);
  double weight() const; // 0D_NOT_real
  void set_weight(double value);
  double invalid_value() const; // 0D_NOT_real
  void set_invalid_value(double value);
  double merit() const; // 0D_NOT_real
  void set_merit(double value);
  double s() const; // 0D_NOT_real
  void set_s(double value);
  double s_offset() const; // 0D_NOT_real
  void set_s_offset(double value);
  bool err_message_printed() const; // 0D_NOT_logical
  void set_err_message_printed(bool value);
  bool exists() const; // 0D_NOT_logical
  void set_exists(bool value);
  bool good_model() const; // 0D_NOT_logical
  void set_good_model(bool value);
  bool good_base() const; // 0D_NOT_logical
  void set_good_base(bool value);
  bool good_design() const; // 0D_NOT_logical
  void set_good_design(bool value);
  bool good_meas() const; // 0D_NOT_logical
  void set_good_meas(bool value);
  bool good_ref() const; // 0D_NOT_logical
  void set_good_ref(bool value);
  bool good_user() const; // 0D_NOT_logical
  void set_good_user(bool value);
  bool good_opt() const; // 0D_NOT_logical
  void set_good_opt(bool value);
  bool good_plot() const; // 0D_NOT_logical
  void set_good_plot(bool value);
  bool useit_plot() const; // 0D_NOT_logical
  void set_useit_plot(bool value);
  bool useit_opt() const; // 0D_NOT_logical
  void set_useit_opt(bool value);
  TaoSpinMapProxy spin_map() const; // 0D_NOT_type
  void set_spin_map(const TaoSpinMapProxy& src);
  std::optional<TaoD1DataProxy> d1() const; // 0D_PTR_type
  void set_d1(const TaoD1DataProxy& src);
};

template <>
struct FortranTraits<TaoPingScaleProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_ping_scale_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_ping_scale_struct(ptr, 0);
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
  void set_a_mode_meas(double value);
  double a_mode_ref() const; // 0D_NOT_real
  void set_a_mode_ref(double value);
  double b_mode_meas() const; // 0D_NOT_real
  void set_b_mode_meas(double value);
  double b_mode_ref() const; // 0D_NOT_real
  void set_b_mode_ref(double value);
};

template <>
struct FortranTraits<TaoUniverseCalcProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_universe_calc_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_universe_calc_struct(ptr, 0);
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
  void set_srdt_for_data(int value);
  bool rad_int_for_data() const; // 0D_NOT_logical
  void set_rad_int_for_data(bool value);
  bool rad_int_for_plotting() const; // 0D_NOT_logical
  void set_rad_int_for_plotting(bool value);
  bool chrom_for_data() const; // 0D_NOT_logical
  void set_chrom_for_data(bool value);
  bool chrom_for_plotting() const; // 0D_NOT_logical
  void set_chrom_for_plotting(bool value);
  bool lat_sigma_for_data() const; // 0D_NOT_logical
  void set_lat_sigma_for_data(bool value);
  bool lat_sigma_for_plotting() const; // 0D_NOT_logical
  void set_lat_sigma_for_plotting(bool value);
  bool dynamic_aperture() const; // 0D_NOT_logical
  void set_dynamic_aperture(bool value);
  bool one_turn_map() const; // 0D_NOT_logical
  void set_one_turn_map(bool value);
  bool lattice() const; // 0D_NOT_logical
  void set_lattice(bool value);
  bool twiss() const; // 0D_NOT_logical
  void set_twiss(bool value);
  bool track() const; // 0D_NOT_logical
  void set_track(bool value);
  bool spin_matrices() const; // 0D_NOT_logical
  void set_spin_matrices(bool value);
};

template <>
struct FortranTraits<LatEleOrderProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_lat_ele_order_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_lat_ele_order_struct(ptr, 0);
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

  LatEleOrderArrayProxyArray1D branch() const; // 1D_ALLOC_type
};

template <>
struct FortranTraits<TaoUniverseProxy> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_tao_universe_struct(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_tao_universe_struct(ptr, 0);
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

  std::optional<TaoLatticeProxy> model() const; // 0D_PTR_type
  void set_model(const TaoLatticeProxy& src);
  std::optional<TaoLatticeProxy> design() const; // 0D_PTR_type
  void set_design(const TaoLatticeProxy& src);
  std::optional<TaoLatticeProxy> base() const; // 0D_PTR_type
  void set_base(const TaoLatticeProxy& src);
  TaoBeamUniProxy beam() const; // 0D_NOT_type
  void set_beam(const TaoBeamUniProxy& src);
  TaoDynamicApertureProxy dynamic_aperture() const; // 0D_NOT_type
  void set_dynamic_aperture(const TaoDynamicApertureProxy& src);
  TaoModelBranchProxyArray1D model_branch() const; // 1D_PTR_type
  TaoD2DataProxyArray1D d2_data() const; // 1D_ALLOC_type
  TaoDataProxyArray1D data() const; // 1D_ALLOC_type
  TaoPingScaleProxy ping_scale() const; // 0D_NOT_type
  void set_ping_scale(const TaoPingScaleProxy& src);
  LatProxy scratch_lat() const; // 0D_NOT_type
  void set_scratch_lat(const LatProxy& src);
  TaoUniverseCalcProxy calc() const; // 0D_NOT_type
  void set_calc(const TaoUniverseCalcProxy& src);
  LatEleOrderProxy ele_order() const; // 0D_NOT_type
  void set_ele_order(const LatEleOrderProxy& src);
  TaoSpinMapProxy spin_map() const; // 0D_NOT_type
  void set_spin_map(const TaoSpinMapProxy& src);
  FortranArray2D<double> dModel_dVar() const; // 2D_ALLOC_real
  int ix_uni() const; // 0D_NOT_integer
  void set_ix_uni(int value);
  int n_d2_data_used() const; // 0D_NOT_integer
  void set_n_d2_data_used(int value);
  int n_data_used() const; // 0D_NOT_integer
  void set_n_data_used(int value);
  bool is_on() const; // 0D_NOT_logical
  void set_is_on(bool value);
  bool design_same_as_previous() const; // 0D_NOT_logical
  void set_design_same_as_previous(bool value);
  bool picked_uni() const; // 0D_NOT_logical
  void set_picked_uni(bool value);
};

// Tao proxy classes for navigating the hierarchy
// TaoElementIndexProxy does not map onto a specific Tao struct
// TaoUniverseProxy maps onto tao_universe_struct
class TaoElementIndexProxy {
 private:
  int ix_uni_, ix_lat_, ix_branch_, ix_ele_;

  void* get_fortran_ptr_() const {
    void* ele_ptr =
        tao_c_get_element_ptr(ix_uni_, ix_lat_, ix_branch_, ix_ele_);
    if (!ele_ptr) {
      throw NullPointerException(
          "TaoElementIndexProxy dereference for ix_uni=" +
          std::to_string(ix_uni_) + " ix_lat=" + std::to_string(ix_lat_) +
          " ix_branch=" + std::to_string(ix_branch_) +
          " ix_ele=" + std::to_string(ix_ele_) + "");
    }
    return ele_ptr;
  }

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
    return EleProxy(get_fortran_ptr_());
  }

  std::unique_ptr<EleProxy> operator->() const {
    return std::make_unique<EleProxy>(get_fortran_ptr_());
  }
};

class TaoBranchIndexProxy {
 private:
  int ix_uni_, ix_lat_, ix_branch_;

  void* get_fortran_ptr_() const {
    void* branch_ptr = tao_c_get_branch_ptr(ix_uni_, ix_lat_, ix_branch_);
    if (!branch_ptr) {
      throw NullPointerException(
          "TaoBranchIndexProxy dereference for [" + std::to_string(ix_uni_) +
          "," + std::to_string(ix_lat_) + "," + std::to_string(ix_branch_) +
          "]");
    }
    return branch_ptr;
  }

 public:
  TaoBranchIndexProxy(int ix_uni, LatticeType lattice_type, int ix_branch)
      : ix_uni_(ix_uni),
        ix_lat_(static_cast<int>(lattice_type)),
        ix_branch_(ix_branch) {}

  BranchProxy operator*() const {
    return BranchProxy(get_fortran_ptr_());
  }

  std::unique_ptr<BranchProxy> operator->() const {
    return std::make_unique<BranchProxy>(get_fortran_ptr_());
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
    return TaoLatticeProxy(get_fortran_ptr_());
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
    return std::make_unique<TaoUniverseProxy>(get_fortran_ptr_());
  }

  TaoLatticeIndexProxy get_lattice(LatticeType lattice_type) const {
    return TaoLatticeIndexProxy(ix_uni_, lattice_type);
  }
};

} // namespace tao
