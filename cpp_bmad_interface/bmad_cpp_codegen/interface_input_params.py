"""
Configuration file for C++ code generation.
"""

from __future__ import annotations

# Paths are relative to ACC_ROOT_DIR.
struct_def_files = [
    "sim_utils/math/spline_mod.f90",
    "bmad/modules/bmad_struct.f90",
    "bmad/modules/taylor_mod.f90",
    "bmad/space_charge/csr_and_space_charge_mod.f90",
    "bmad/modules/complex_taylor_mod.f90",
]

# Paths are relative to ACC_ROOT_DIR.
struct_def_json_files = [
    "structs/json/bmad_structs.json",
    "structs/json/forest_structs.json",
    "structs/json/sim_utils_structs.json",
    "structs/json/tao_structs.json",
]

# List of use statements needed in various Fortran modules.

equality_use_statements = [
    "use bmad_struct",
    # "use tao_struct",
]
test_use_statements = [
    "use bmad_json",
    "use sim_utils_json",
    "use tao_json",
]

# List of structures to setup interfaces for.
# List must be in ordered such that if struct A is a component of struct B,
# then A must be before B in the list.

struct_list = [
    "spline_struct",
    "spin_polar_struct",
    "ac_kicker_time_struct",
    "ac_kicker_freq_struct",
    "ac_kicker_struct",
    "interval1_coef_struct",
    "photon_reflect_table_struct",
    "photon_reflect_surface_struct",
    "coord_struct",
    "coord_array_struct",
    "bpm_phase_coupling_struct",
    "expression_atom_struct",
    "wake_sr_z_long_struct",
    "wake_sr_mode_struct",
    "wake_sr_struct",
    "wake_lr_mode_struct",
    "wake_lr_struct",
    "lat_ele_loc_struct",
    "wake_struct",
    "taylor_term_struct",
    "taylor_struct",
    "em_taylor_term_struct",
    "em_taylor_struct",
    "cartesian_map_term1_struct",
    "cartesian_map_term_struct",
    "cartesian_map_struct",
    "cylindrical_map_term1_struct",
    "cylindrical_map_term_struct",
    "cylindrical_map_struct",
    "bicubic_cmplx_coef_struct",
    "tricubic_cmplx_coef_struct",
    "grid_field_pt1_struct",
    "grid_field_pt_struct",
    "grid_field_struct",
    "floor_position_struct",
    "high_energy_space_charge_struct",
    "xy_disp_struct",
    "twiss_struct",
    "mode3_struct",
    "bookkeeping_state_struct",
    "rad_map_struct",
    "rad_map_ele_struct",
    "gen_grad1_struct",
    "gen_grad_map_struct",
    "surface_segmented_pt_struct",
    "surface_segmented_struct",
    "surface_h_misalign_pt_struct",
    "surface_h_misalign_struct",
    "surface_displacement_pt_struct",
    "surface_displacement_struct",
    "target_point_struct",
    "surface_curvature_struct",
    "photon_target_struct",
    "photon_material_struct",
    "pixel_pt_struct",
    "pixel_detec_struct",
    "photon_element_struct",
    "wall3d_vertex_struct",
    "wall3d_section_struct",
    "wall3d_struct",
    "ramper_lord_struct",
    "control_struct",
    "control_var1_struct",
    "control_ramp1_struct",
    "controller_struct",
    "ellipse_beam_init_struct",
    "kv_beam_init_struct",
    "grid_beam_init_struct",
    "beam_init_struct",
    "lat_param_struct",
    "mode_info_struct",
    "pre_tracker_struct",
    "anormal_mode_struct",
    "linac_normal_mode_struct",
    "normal_modes_struct",
    "em_field_struct",
    "strong_beam_struct",
    "track_point_struct",
    "track_struct",
    "space_charge_common_struct",
    "bmad_common_struct",
    "rad_int1_struct",
    "rad_int_branch_struct",
    "rad_int_all_ele_struct",
    "rf_stair_step_struct",
    "rf_ele_struct",
    "ele_struct",
    "complex_taylor_term_struct",
    "complex_taylor_struct",
    "branch_struct",
    "lat_struct",
    "bunch_struct",
    "bunch_params_struct",
    "beam_struct",
    "aperture_point_struct",
    "aperture_param_struct",
    "aperture_scan_struct",
    # Tao
    "tao_spin_dn_dpz_struct",
    # "probe_8",
    # "c_normal_form",
    # "c_taylor",
    # "c_quaternion",
    # "internal_state",
    "resonance_h_struct",
    "spin_orbit_map1_struct",
    "spin_axis_struct",
    "ptc_normal_form_struct",
    "bmad_normal_form_struct",
    "bunch_track_struct",
    "summation_rdt_struct",
    "lat_ele_order1_struct",
    "lat_ele_order_array_struct",
    "tao_lat_sigma_struct",
    "tao_spin_ele_struct",
    "tao_plot_cache_struct",
    "tao_spin_polarization_struct",
    "tao_lattice_branch_struct",
    "tao_model_element_struct",
    "tao_beam_branch_struct",
    "tao_d1_data_struct",
    "tao_lattice_struct",
    "tao_beam_uni_struct",
    "tao_dynamic_aperture_struct",
    "tao_model_branch_struct",
    "tao_d2_data_struct",
    "tao_spin_map_struct",
    "tao_data_struct",
    "tao_ping_scale_struct",
    "tao_universe_calc_struct",
    "lat_ele_order_struct",
    "tao_universe_struct",
]

# List of structure components to not translate.
# Can specify these using the syntax:
#   <component_struct_name>        or
#   <struct>%<component_name>

component_no_translate_list = {
    # NOTE: 'ptc' may be required for taylor map info (polymorphic tracking)
    "fibre",
    "layout",
    "ptc_branch1_info_struct",
    "branch_struct%ptc",
    # end PTC
    # forest
    "probe_8",
    "c_normal_form",
    "c_taylor",
    "c_quaternion",
    "internal_state",
    # end forest
    "exact_bend_multipole_struct",
    "ele_struct%converter",  # Should be simple data? Check this
    "ele_struct%multipole_cache",
    "ele_struct%foil",
    "lat_struct%nametable",
    "normal_form_struct",
    # This is merely a reference to lat_struct%branch(0). Avoid copying unnecessarily.
    # "lat_struct%ele",
    # TODO: this copies information unnecessarily; we need a reference type
    # "branch_struct%lat",
    # "ele_struct%lord",
    # "ele_struct%branch",
    # TODO: we need some sort workaround for grid field data:
    # "grid_field_pt_struct%pt",
    # tao
    # "tao_data_struct%data_type",  # TODO: 0D_ALLOC_character
    # TODO parent ref
    # "tao_lattice_branch_struct%tao_lat",
    # "tao_d1_data_struct%d2",
    "tao_lattice_struct%u",
    # TODO test pattern debugging
    # "tao_d1_data_struct%d",
    # end tao
}

# List of structure components links:
# Structure components that are just links to other structures are handled differently.
#   1) Ignore in Fortran and C++ equality tests (could go around in circles).
#   2) Do not create a test pattern in interface test code.

interface_ignore_list = {
    # "ele_struct%branch",
    # "branch_struct%lat",
    # TODO pointers in the test suite
    # "tao_universe_struct%base",
    # "tao_universe_struct%model",
    # "tao_universe_struct%design",
    # "tao_universe_struct%model_branch",
}

# List of structure components that are structures and are defined externally.
# There are no such structures for the cpp_bmad_interface library but there
# are for the cpp_tao_interface library.

structs_defined_externally = set()

# Translations on C++ side to avoid clash with reserved words

c_side_name_translation = {
    "wake_sr_struct%long": "long_wake",
    "wake_sr_struct%trans": "trans_wake",
}

# Include header files for main header file

include_header_files = [
    '#include "bmad_enums.h"',
    '#include "bmad_std_typedef.h"',
]


# Lower bounds for allocatable and pointer arrays on the fortran side


def f_side_lbound(id_name):
    if id_name == "lat%branch":
        return "0"
    if id_name == "branch%ele":
        return "0"
    return "1"
