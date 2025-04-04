#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>
#include <pybind11/stl.h>
#include <pybind11/complex.h>
#include <string>
#include <vector>
#include <complex>
#include <optional>
#include <iostream>

#include "bmad_std_typedef.h"
#include "cpp_bmad_classes.h"

namespace py = pybind11;

// Forward declaration of the C function
extern "C" bool cpp_bmad_parser(
    const char* lat_file,
    void *lat
   // ,
   // bool make_mats6,
   // bool digested_read_ok,
   // const char* use_line,
   // void *parse_lat
);


namespace py = pybind11;

// Wrapper function that handles Python types and optional arguments
shared_ptr<CPP_lat> bmad_parser_wrapper(
    const std::string& lat_file,
    py::object make_mats6_obj = py::none(),
    py::object digested_read_ok_obj = py::none(),
    py::object use_line_obj = py::none()
) {
    auto lat = std::make_shared<CPP_lat>();
    void* parse_lat_ptr = nullptr;
    
    bool make_mats6 = make_mats6_obj.is_none() ? false : make_mats6_obj.cast<bool>();
    bool digested_read_ok = digested_read_ok_obj.is_none() ? true : digested_read_ok_obj.cast<bool>();
    // const char* use_line = use_line_obj.is_none() ? nullptr : use_line_obj.cast<std::string>().c_str();
   
    bool error = cpp_bmad_parser(
        lat_file.c_str(), 
        lat.get()
        // , make_mats6, 
        // digested_read_ok, 
        // use_line, 
        // &parse_lat_ptr
    );
  
    return lat;

    // py::dict result;
    // result["error"] = error;
    // result["lattice"] = lat;
    //
    // if (parse_lat_ptr) {
    //     result["parse_lattice"] = parse_lat_ptr;
    // } else {
    //     result["parse_lattice"] = py::none();
    // }
    //
    // return result;
}


PYBIND11_MODULE(bmad, m) {
    m.doc() = "pybind11 bmad plugin: auto-generated from struct definitions";

    py::class_<CPP_spline>(m, "spline", "Fortran struct: spline_struct")
        .def(py::init<>())
        .def_property_readonly("x0",
            [](const CPP_spline &self) { return self.x0; },
            "Point at start of spline")
        .def_property_readonly("y0",
            [](const CPP_spline &self) { return self.y0; },
            "Point at start of spline")
        .def_property_readonly("x1",
            [](const CPP_spline &self) { return self.x1; },
            "Point at end of spline")
        // Array property: coef, type: Real_ARRAY
        .def_property("coef",
            [](const CPP_spline &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.coef;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_spline &self, py::array arr) {
                // Set coef from numpy array
                
                return arr;
    
            },
            "coefficients for cubic spline")
        ;

    py::class_<CPP_spin_polar>(m, "spin_polar", "Fortran struct: spin_polar_struct")
        .def(py::init<>())
        .def_property_readonly("polarization",
            [](const CPP_spin_polar &self) { return self.polarization; },
            "Property from Fortran struct")
        .def_property_readonly("theta",
            [](const CPP_spin_polar &self) { return self.theta; },
            "Spherical coords: Angle from z-axis.")
        .def_property_readonly("phi",
            [](const CPP_spin_polar &self) { return self.phi; },
            "Spherical coords: Angle in (x,y) plane.")
        .def_property_readonly("xi",
            [](const CPP_spin_polar &self) { return self.xi; },
            "Spinor phase angle (See Bmad manual).")
        ;

    py::class_<CPP_ac_kicker_time>(m, "ac_kicker_time", "Fortran struct: ac_kicker_time_struct")
        .def(py::init<>())
        .def_property_readonly("amp",
            [](const CPP_ac_kicker_time &self) { return self.amp; },
            "Property from Fortran struct")
        .def_property_readonly("time",
            [](const CPP_ac_kicker_time &self) { return self.time; },
            "Property from Fortran struct")
        .def_property_readonly("spline",
            [](const CPP_ac_kicker_time &self) { return self.spline; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_ac_kicker_freq>(m, "ac_kicker_freq", "Fortran struct: ac_kicker_freq_struct")
        .def(py::init<>())
        .def_property_readonly("f",
            [](const CPP_ac_kicker_freq &self) { return self.f; },
            "Property from Fortran struct")
        .def_property_readonly("amp",
            [](const CPP_ac_kicker_freq &self) { return self.amp; },
            "Property from Fortran struct")
        .def_property_readonly("phi",
            [](const CPP_ac_kicker_freq &self) { return self.phi; },
            "Property from Fortran struct")
        .def_property_readonly("rf_clock_harmonic",
            [](const CPP_ac_kicker_freq &self) { return self.rf_clock_harmonic; },
            "When RF clock is used.")
        ;

    py::class_<CPP_ac_kicker>(m, "ac_kicker", "Fortran struct: ac_kicker_struct")
        .def(py::init<>())
        // Array property: amp_vs_time, type: CPP_ac_kicker_time_ARRAY
        .def_property("amp_vs_time",
            [](const CPP_ac_kicker &self) {
                // Get list of struct objects
                
                return self.amp_vs_time;
                
            },
            [](CPP_ac_kicker &self, py::object obj) {
                // Set amp_vs_time from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.amp_vs_time;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_ac_kicker_time>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ac_kicker_time objects");
                // }
                
            },
            "Property from Fortran struct")
        // Array property: frequency, type: CPP_ac_kicker_freq_ARRAY
        .def_property("frequency",
            [](const CPP_ac_kicker &self) {
                // Get list of struct objects
                
                return self.frequency;
                
            },
            [](CPP_ac_kicker &self, py::object obj) {
                // Set frequency from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.frequency;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_ac_kicker_freq>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ac_kicker_freq objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_interval1_coef>(m, "interval1_coef", "Fortran struct: interval1_coef_struct")
        .def(py::init<>())
        .def_property_readonly("c0",
            [](const CPP_interval1_coef &self) { return self.c0; },
            "Property from Fortran struct")
        .def_property_readonly("c1",
            [](const CPP_interval1_coef &self) { return self.c1; },
            "Property from Fortran struct")
        .def_property_readonly("n_exp",
            [](const CPP_interval1_coef &self) { return self.n_exp; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_photon_reflect_table>(m, "photon_reflect_table", "Fortran struct: photon_reflect_table_struct")
        .def(py::init<>())
        // Array property: angle, type: Real_ARRAY
        .def_property("angle",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.angle;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set angle from numpy array
                
                return arr;
    
            },
            "Vector of angle values for %p_reflect")
        // Array property: energy, type: Real_ARRAY
        .def_property("energy",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.energy;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set energy from numpy array
                
                return arr;
    
            },
            "Vector of energy values for %p_reflect")
        // Array property: int1, type: CPP_interval1_coef_ARRAY
        .def_property("int1",
            [](const CPP_photon_reflect_table &self) {
                // Get list of struct objects
                
                return self.int1;
                
            },
            [](CPP_photon_reflect_table &self, py::object obj) {
                // Set int1 from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.int1;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_interval1_coef>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_interval1_coef objects");
                // }
                
            },
            "Property from Fortran struct")
        // Array property: p_reflect, type: Real_MATRIX
        .def_property("p_reflect",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.p_reflect;
                
                return py::str("not implemented");
        
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set p_reflect from numpy array
                
                return arr;
    
            },
            "(angle, ev) probability. Log used for smooth surface reflection")
        .def_property_readonly("max_energy",
            [](const CPP_photon_reflect_table &self) { return self.max_energy; },
            "maximum energy for this table")
        // Array property: p_reflect_scratch, type: Real_ARRAY
        .def_property("p_reflect_scratch",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.p_reflect_scratch;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set p_reflect_scratch from numpy array
                
                return arr;
    
            },
            "Scratch space")
        // Array property: bragg_angle, type: Real_ARRAY
        .def_property("bragg_angle",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.bragg_angle;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set bragg_angle from numpy array
                
                return arr;
    
            },
            "Bragg angle at energy values.")
        ;

    py::class_<CPP_photon_reflect_surface>(m, "photon_reflect_surface", "Fortran struct: photon_reflect_surface_struct")
        .def(py::init<>())
        .def_property_readonly("name",
            [](const CPP_photon_reflect_surface &self) { return self.name; },
            "Property from Fortran struct")
        .def_property_readonly("description",
            [](const CPP_photon_reflect_surface &self) { return self.description; },
            "Descriptive name")
        .def_property_readonly("reflectivity_file",
            [](const CPP_photon_reflect_surface &self) { return self.reflectivity_file; },
            "Property from Fortran struct")
        // Array property: table, type: CPP_photon_reflect_table_ARRAY
        .def_property("table",
            [](const CPP_photon_reflect_surface &self) {
                // Get list of struct objects
                
                return self.table;
                
            },
            [](CPP_photon_reflect_surface &self, py::object obj) {
                // Set table from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.table;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_photon_reflect_table>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_photon_reflect_table objects");
                // }
                
            },
            "Property from Fortran struct")
        .def_property_readonly("surface_roughness_rms",
            [](const CPP_photon_reflect_surface &self) { return self.surface_roughness_rms; },
            "sigma in Dugan's notation")
        .def_property_readonly("roughness_correlation_len",
            [](const CPP_photon_reflect_surface &self) { return self.roughness_correlation_len; },
            "T in Dugan's notation")
        .def_property_readonly("ix_surface",
            [](const CPP_photon_reflect_surface &self) { return self.ix_surface; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_coord>(m, "coord", "Fortran struct: coord_struct")
        .def(py::init<>())
        // Array property: vec, type: Real_ARRAY
        .def_property("vec",
            [](const CPP_coord &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.vec;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_coord &self, py::array arr) {
                // Set vec from numpy array
                
                return arr;
    
            },
            "(x, px, y, py, z, pz). Generally phase space for charged particles. See Bmad manual.")
        .def_property_readonly("s",
            [](const CPP_coord &self) { return self.s; },
            "Longitudinal position")
        .def_property_readonly("t",
            [](const CPP_coord &self) { return self.t; },
            "Absolute time (not relative to reference). If bmad_private%rf_clock_frequency is")
        // Array property: spin, type: Real_ARRAY
        .def_property("spin",
            [](const CPP_coord &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.spin;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_coord &self, py::array arr) {
                // Set spin from numpy array
                
                return arr;
    
            },
            "Spin.")
        // Array property: field, type: Real_ARRAY
        .def_property("field",
            [](const CPP_coord &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.field;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_coord &self, py::array arr) {
                // Set field from numpy array
                
                return arr;
    
            },
            "Photon E-field intensity (x,y).")
        // Array property: phase, type: Real_ARRAY
        .def_property("phase",
            [](const CPP_coord &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.phase;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_coord &self, py::array arr) {
                // Set phase from numpy array
                
                return arr;
    
            },
            "Photon E-field phase (x,y). phase(1) is also used with")
        .def_property_readonly("charge",
            [](const CPP_coord &self) { return self.charge; },
            "Macroparticle weight (which is different from particle species charge).")
        .def_property_readonly("dt_ref",
            [](const CPP_coord &self) { return self.dt_ref; },
            "Used in:")
        .def_property_readonly("r",
            [](const CPP_coord &self) { return self.r; },
            "For general use. Not used by Bmad.")
        .def_property_readonly("p0c",
            [](const CPP_coord &self) { return self.p0c; },
            "For non-photons: Reference momentum.")
        .def_property_readonly("e_potential",
            [](const CPP_coord &self) { return self.e_potential; },
            "Potential energy.")
        .def_property_readonly("beta",
            [](const CPP_coord &self) { return self.beta; },
            "Velocity / c_light.")
        .def_property_readonly("ix_ele",
            [](const CPP_coord &self) { return self.ix_ele; },
            "Index of the lattice element the particle is in.")
        .def_property_readonly("ix_branch",
            [](const CPP_coord &self) { return self.ix_branch; },
            "Index of the lattice branch the particle is in.")
        .def_property_readonly("ix_turn",
            [](const CPP_coord &self) { return self.ix_turn; },
            "Turn index for multiturn tracking.")
        .def_property_readonly("ix_user",
            [](const CPP_coord &self) { return self.ix_user; },
            "For general use, not used by Bmad.")
        .def_property_readonly("state",
            [](const CPP_coord &self) { return self.state; },
            "alive$, lost$, lost_neg_x_aperture$, lost_pz$, etc.")
        .def_property_readonly("direction",
            [](const CPP_coord &self) { return self.direction; },
            "+1 or -1. Sign of longitudinal direction of motion (ds/dt).")
        .def_property_readonly("time_dir",
            [](const CPP_coord &self) { return self.time_dir; },
            "+1 or -1. Time direction. -1 => Traveling backwards in time.")
        .def_property_readonly("species",
            [](const CPP_coord &self) { return self.species; },
            "positron$, proton$, etc.")
        .def_property_readonly("location",
            [](const CPP_coord &self) { return self.location; },
            "upstream_end$, inside$, or downstream_end$")
        ;

    py::class_<CPP_coord_array>(m, "coord_array", "Fortran struct: coord_array_struct")
        .def(py::init<>())
        // Array property: orbit, type: CPP_coord_ARRAY
        .def_property("orbit",
            [](const CPP_coord_array &self) {
                // Get list of struct objects
                
                return self.orbit;
                
            },
            [](CPP_coord_array &self, py::object obj) {
                // Set orbit from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.orbit;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_coord>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_coord objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_bpm_phase_coupling>(m, "bpm_phase_coupling", "Fortran struct: bpm_phase_coupling_struct")
        .def(py::init<>())
        .def_property_readonly("k_22a",
            [](const CPP_bpm_phase_coupling &self) { return self.k_22a; },
            "In-phase y/x for a-mode oscillations.")
        .def_property_readonly("k_12a",
            [](const CPP_bpm_phase_coupling &self) { return self.k_12a; },
            "Out-of-phase y/x for a-mode oscillations.")
        .def_property_readonly("k_11b",
            [](const CPP_bpm_phase_coupling &self) { return self.k_11b; },
            "In-phase x/y for b-mode oscillations.")
        .def_property_readonly("k_12b",
            [](const CPP_bpm_phase_coupling &self) { return self.k_12b; },
            "Out-of-phase x/y for b-mode oscillations.")
        .def_property_readonly("cbar22_a",
            [](const CPP_bpm_phase_coupling &self) { return self.cbar22_a; },
            "Cbar22 as calculated from K_22a.")
        .def_property_readonly("cbar12_a",
            [](const CPP_bpm_phase_coupling &self) { return self.cbar12_a; },
            "Cbar12 as calculated from K_12a.")
        .def_property_readonly("cbar11_b",
            [](const CPP_bpm_phase_coupling &self) { return self.cbar11_b; },
            "Cbar11 as calculated from K_11b.")
        .def_property_readonly("cbar12_b",
            [](const CPP_bpm_phase_coupling &self) { return self.cbar12_b; },
            "Cbar12 as calculated from K_12b.")
        .def_property_readonly("phi_a",
            [](const CPP_bpm_phase_coupling &self) { return self.phi_a; },
            "a-mode betatron phase.")
        .def_property_readonly("phi_b",
            [](const CPP_bpm_phase_coupling &self) { return self.phi_b; },
            "b-mode betatron phase.")
        ;

    py::class_<CPP_expression_atom>(m, "expression_atom", "Fortran struct: expression_atom_struct")
        .def(py::init<>())
        .def_property_readonly("name",
            [](const CPP_expression_atom &self) { return self.name; },
            "Property from Fortran struct")
        .def_property_readonly("type",
            [](const CPP_expression_atom &self) { return self.type; },
            "plus$, minum$, sin$, cos$, etc. To convert to string use: expression_op_name")
        .def_property_readonly("value",
            [](const CPP_expression_atom &self) { return self.value; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_wake_sr_z_long>(m, "wake_sr_z_long", "Fortran struct: wake_sr_z_long_struct")
        .def(py::init<>())
        // Array property: w, type: Real_ARRAY
        .def_property("w",
            [](const CPP_wake_sr_z_long &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.w;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wake_sr_z_long &self, py::array arr) {
                // Set w from numpy array
                
                return arr;
    
            },
            "Input single particle Wake. Indexed from 1.")
        // Array property: fw, type: Complex_ARRAY
        .def_property("fw",
            [](const CPP_wake_sr_z_long &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.fw;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wake_sr_z_long &self, py::array arr) {
                // Set fw from numpy array
                
                return arr;
    
            },
            "Fourier transform of w.")
        // Array property: fbunch, type: Complex_ARRAY
        .def_property("fbunch",
            [](const CPP_wake_sr_z_long &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.fbunch;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wake_sr_z_long &self, py::array arr) {
                // Set fbunch from numpy array
                
                return arr;
    
            },
            "Scratch space.")
        // Array property: w_out, type: Complex_ARRAY
        .def_property("w_out",
            [](const CPP_wake_sr_z_long &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.w_out;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wake_sr_z_long &self, py::array arr) {
                // Set w_out from numpy array
                
                return arr;
    
            },
            "Scratch space.")
        .def_property_readonly("dz",
            [](const CPP_wake_sr_z_long &self) { return self.dz; },
            "Distance between points. If zero there is no wake.")
        .def_property_readonly("z0",
            [](const CPP_wake_sr_z_long &self) { return self.z0; },
            "Wake extent is [-z0, z0].")
        .def_property_readonly("smoothing_sigma",
            [](const CPP_wake_sr_z_long &self) { return self.smoothing_sigma; },
            "0 => No smoothing.")
        .def_property_readonly("position_dependence",
            [](const CPP_wake_sr_z_long &self) { return self.position_dependence; },
            "Transverse: leading$, trailing$, none$")
        .def_property_readonly("time_based",
            [](const CPP_wake_sr_z_long &self) { return self.time_based; },
            "Was input time based?")
        ;

    py::class_<CPP_wake_sr_mode>(m, "wake_sr_mode", "Fortran struct: wake_sr_mode_struct")
        .def(py::init<>())
        .def_property_readonly("amp",
            [](const CPP_wake_sr_mode &self) { return self.amp; },
            "Amplitude")
        .def_property_readonly("damp",
            [](const CPP_wake_sr_mode &self) { return self.damp; },
            "Dampling factor.")
        .def_property_readonly("k",
            [](const CPP_wake_sr_mode &self) { return self.k; },
            "k factor")
        .def_property_readonly("phi",
            [](const CPP_wake_sr_mode &self) { return self.phi; },
            "Phase in radians/2pi")
        .def_property_readonly("b_sin",
            [](const CPP_wake_sr_mode &self) { return self.b_sin; },
            "non-skew (x) sin-like component of the wake")
        .def_property_readonly("b_cos",
            [](const CPP_wake_sr_mode &self) { return self.b_cos; },
            "non-skew (x) cos-like component of the wake")
        .def_property_readonly("a_sin",
            [](const CPP_wake_sr_mode &self) { return self.a_sin; },
            "skew (y) sin-like component of the wake")
        .def_property_readonly("a_cos",
            [](const CPP_wake_sr_mode &self) { return self.a_cos; },
            "skew (y) cos-like component of the wake")
        .def_property_readonly("polarization",
            [](const CPP_wake_sr_mode &self) { return self.polarization; },
            "Transverse: none$, x_axis$, y_axis$. Not used for longitudinal.")
        .def_property_readonly("position_dependence",
            [](const CPP_wake_sr_mode &self) { return self.position_dependence; },
            "Transverse: leading$, trailing$, none$")
        ;

    py::class_<CPP_wake_sr>(m, "wake_sr", "Fortran struct: wake_sr_struct")
        .def(py::init<>())
        .def_property_readonly("file",
            [](const CPP_wake_sr &self) { return self.file; },
            "Property from Fortran struct")
        .def_property_readonly("z_long",
            [](const CPP_wake_sr &self) { return self.z_long; },
            "Property from Fortran struct")
        // Array property: long_wake, type: CPP_wake_sr_mode_ARRAY
        .def_property("long_wake",
            [](const CPP_wake_sr &self) {
                // Get list of struct objects
                
                return self.long_wake;
                
            },
            [](CPP_wake_sr &self, py::object obj) {
                // Set long_wake from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.long_wake;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_wake_sr_mode>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wake_sr_mode objects");
                // }
                
            },
            "Property from Fortran struct")
        // Array property: trans_wake, type: CPP_wake_sr_mode_ARRAY
        .def_property("trans_wake",
            [](const CPP_wake_sr &self) {
                // Get list of struct objects
                
                return self.trans_wake;
                
            },
            [](CPP_wake_sr &self, py::object obj) {
                // Set trans_wake from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.trans_wake;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_wake_sr_mode>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wake_sr_mode objects");
                // }
                
            },
            "Property from Fortran struct")
        .def_property_readonly("z_ref_long",
            [](const CPP_wake_sr &self) { return self.z_ref_long; },
            "z reference value for computing the wake amplitude.")
        .def_property_readonly("z_ref_trans",
            [](const CPP_wake_sr &self) { return self.z_ref_trans; },
            "This is used to prevent value overflow with long bunches.")
        .def_property_readonly("z_max",
            [](const CPP_wake_sr &self) { return self.z_max; },
            "Max allowable z value. 0-> ignore")
        .def_property_readonly("amp_scale",
            [](const CPP_wake_sr &self) { return self.amp_scale; },
            "Wake amplitude scale factor.")
        .def_property_readonly("z_scale",
            [](const CPP_wake_sr &self) { return self.z_scale; },
            "z-distance scale factor.")
        .def_property_readonly("scale_with_length",
            [](const CPP_wake_sr &self) { return self.scale_with_length; },
            "Scale wake with element length?")
        ;

    py::class_<CPP_wake_lr_mode>(m, "wake_lr_mode", "Fortran struct: wake_lr_mode_struct")
        .def(py::init<>())
        .def_property_readonly("freq",
            [](const CPP_wake_lr_mode &self) { return self.freq; },
            "Actual Frequency in Hz.")
        .def_property_readonly("freq_in",
            [](const CPP_wake_lr_mode &self) { return self.freq_in; },
            "Input frequency in Hz.")
        .def_property_readonly("r_over_q",
            [](const CPP_wake_lr_mode &self) { return self.r_over_q; },
            "Strength in V/C/m^(2*m_mode).")
        .def_property_readonly("q",
            [](const CPP_wake_lr_mode &self) { return self.q; },
            "Used for backwards compatability.")
        .def_property_readonly("damp",
            [](const CPP_wake_lr_mode &self) { return self.damp; },
            "Damping factor = omega / 2 * Q = pi * freq / Q")
        .def_property_readonly("phi",
            [](const CPP_wake_lr_mode &self) { return self.phi; },
            "Phase in radians/2pi.")
        .def_property_readonly("angle",
            [](const CPP_wake_lr_mode &self) { return self.angle; },
            "polarization angle (radians/2pi).")
        .def_property_readonly("b_sin",
            [](const CPP_wake_lr_mode &self) { return self.b_sin; },
            "non-skew sin-like component of the wake.")
        .def_property_readonly("b_cos",
            [](const CPP_wake_lr_mode &self) { return self.b_cos; },
            "non-skew cos-like component of the wake.")
        .def_property_readonly("a_sin",
            [](const CPP_wake_lr_mode &self) { return self.a_sin; },
            "skew sin-like component of the wake.")
        .def_property_readonly("a_cos",
            [](const CPP_wake_lr_mode &self) { return self.a_cos; },
            "skew cos-like component of the wake.")
        .def_property_readonly("m",
            [](const CPP_wake_lr_mode &self) { return self.m; },
            "Mode order (1 = dipole, 2 = quad, etc.)")
        .def_property_readonly("polarized",
            [](const CPP_wake_lr_mode &self) { return self.polarized; },
            "Polaraized mode?")
        ;

    py::class_<CPP_wake_lr>(m, "wake_lr", "Fortran struct: wake_lr_struct")
        .def(py::init<>())
        .def_property_readonly("file",
            [](const CPP_wake_lr &self) { return self.file; },
            "Property from Fortran struct")
        // Array property: mode, type: CPP_wake_lr_mode_ARRAY
        .def_property("mode",
            [](const CPP_wake_lr &self) {
                // Get list of struct objects
                
                return self.mode;
                
            },
            [](CPP_wake_lr &self, py::object obj) {
                // Set mode from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.mode;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_wake_lr_mode>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wake_lr_mode objects");
                // }
                
            },
            "Property from Fortran struct")
        .def_property_readonly("t_ref",
            [](const CPP_wake_lr &self) { return self.t_ref; },
            "time reference value for computing the wake amplitude.")
        .def_property_readonly("freq_spread",
            [](const CPP_wake_lr &self) { return self.freq_spread; },
            "Random frequency spread of long range modes.")
        .def_property_readonly("amp_scale",
            [](const CPP_wake_lr &self) { return self.amp_scale; },
            "Wake amplitude scale factor.")
        .def_property_readonly("time_scale",
            [](const CPP_wake_lr &self) { return self.time_scale; },
            "time scale factor.")
        .def_property_readonly("self_wake_on",
            [](const CPP_wake_lr &self) { return self.self_wake_on; },
            "Long range self-wake used in tracking?")
        ;

    py::class_<CPP_lat_ele_loc>(m, "lat_ele_loc", "Fortran struct: lat_ele_loc_struct")
        .def(py::init<>())
        .def_property_readonly("ix_ele",
            [](const CPP_lat_ele_loc &self) { return self.ix_ele; },
            "Property from Fortran struct")
        .def_property_readonly("ix_branch",
            [](const CPP_lat_ele_loc &self) { return self.ix_branch; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_wake>(m, "wake", "Fortran struct: wake_struct")
        .def(py::init<>())
        .def_property_readonly("sr",
            [](const CPP_wake &self) { return self.sr; },
            "Short-range wake")
        .def_property_readonly("lr",
            [](const CPP_wake &self) { return self.lr; },
            "Long-range wake")
        ;

    py::class_<CPP_taylor_term>(m, "taylor_term", "Fortran struct: taylor_term_struct")
        .def(py::init<>())
        .def_property_readonly("coef",
            [](const CPP_taylor_term &self) { return self.coef; },
            "Property from Fortran struct")
        // Array property: expn, type: Int_ARRAY
        .def_property("expn",
            [](const CPP_taylor_term &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.expn;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_taylor_term &self, py::array arr) {
                // Set expn from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_taylor>(m, "taylor", "Fortran struct: taylor_struct")
        .def(py::init<>())
        .def_property_readonly("ref",
            [](const CPP_taylor &self) { return self.ref; },
            "Property from Fortran struct")
        // Array property: term, type: CPP_taylor_term_ARRAY
        .def_property("term",
            [](const CPP_taylor &self) {
                // Get list of struct objects
                
                return self.term;
                
            },
            [](CPP_taylor &self, py::object obj) {
                // Set term from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.term;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_taylor_term>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_taylor_term objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_em_taylor_term>(m, "em_taylor_term", "Fortran struct: em_taylor_term_struct")
        .def(py::init<>())
        .def_property_readonly("coef",
            [](const CPP_em_taylor_term &self) { return self.coef; },
            "Property from Fortran struct")
        // Array property: expn, type: Int_ARRAY
        .def_property("expn",
            [](const CPP_em_taylor_term &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.expn;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_em_taylor_term &self, py::array arr) {
                // Set expn from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_em_taylor>(m, "em_taylor", "Fortran struct: em_taylor_struct")
        .def(py::init<>())
        .def_property_readonly("ref",
            [](const CPP_em_taylor &self) { return self.ref; },
            "Property from Fortran struct")
        // Array property: term, type: CPP_em_taylor_term_ARRAY
        .def_property("term",
            [](const CPP_em_taylor &self) {
                // Get list of struct objects
                
                return self.term;
                
            },
            [](CPP_em_taylor &self, py::object obj) {
                // Set term from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.term;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_em_taylor_term>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_em_taylor_term objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cartesian_map_term1>(m, "cartesian_map_term1", "Fortran struct: cartesian_map_term1_struct")
        .def(py::init<>())
        .def_property_readonly("coef",
            [](const CPP_cartesian_map_term1 &self) { return self.coef; },
            "Property from Fortran struct")
        .def_property_readonly("kx",
            [](const CPP_cartesian_map_term1 &self) { return self.kx; },
            "Property from Fortran struct")
        .def_property_readonly("ky",
            [](const CPP_cartesian_map_term1 &self) { return self.ky; },
            "Property from Fortran struct")
        .def_property_readonly("kz",
            [](const CPP_cartesian_map_term1 &self) { return self.kz; },
            "Property from Fortran struct")
        .def_property_readonly("x0",
            [](const CPP_cartesian_map_term1 &self) { return self.x0; },
            "Property from Fortran struct")
        .def_property_readonly("y0",
            [](const CPP_cartesian_map_term1 &self) { return self.y0; },
            "Property from Fortran struct")
        .def_property_readonly("phi_z",
            [](const CPP_cartesian_map_term1 &self) { return self.phi_z; },
            "Property from Fortran struct")
        .def_property_readonly("family",
            [](const CPP_cartesian_map_term1 &self) { return self.family; },
            "family_x$, etc.")
        .def_property_readonly("form",
            [](const CPP_cartesian_map_term1 &self) { return self.form; },
            "hyper_y$, etc.")
        ;

    py::class_<CPP_cartesian_map_term>(m, "cartesian_map_term", "Fortran struct: cartesian_map_term_struct")
        .def(py::init<>())
        .def_property_readonly("file",
            [](const CPP_cartesian_map_term &self) { return self.file; },
            "Input file name. Used also as ID for instances.")
        .def_property_readonly("n_link",
            [](const CPP_cartesian_map_term &self) { return self.n_link; },
            "For memory management of %term")
        // Array property: term, type: CPP_cartesian_map_term1_ARRAY
        .def_property("term",
            [](const CPP_cartesian_map_term &self) {
                // Get list of struct objects
                
                return self.term;
                
            },
            [](CPP_cartesian_map_term &self, py::object obj) {
                // Set term from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.term;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_cartesian_map_term1>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_cartesian_map_term1 objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cartesian_map>(m, "cartesian_map", "Fortran struct: cartesian_map_struct")
        .def(py::init<>())
        .def_property_readonly("field_scale",
            [](const CPP_cartesian_map &self) { return self.field_scale; },
            "Factor to scale the fields by")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_cartesian_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_cartesian_map &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "Field origin offset.")
        .def_property_readonly("master_parameter",
            [](const CPP_cartesian_map &self) { return self.master_parameter; },
            "Master parameter in ele%value(:) array to use for scaling the field.")
        .def_property_readonly("ele_anchor_pt",
            [](const CPP_cartesian_map &self) { return self.ele_anchor_pt; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        .def_property_readonly("field_type",
            [](const CPP_cartesian_map &self) { return self.field_type; },
            "or electric$")
        .def_property_readonly("ptr",
            [](const CPP_cartesian_map &self) { return self.ptr; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cylindrical_map_term1>(m, "cylindrical_map_term1", "Fortran struct: cylindrical_map_term1_struct")
        .def(py::init<>())
        .def_property_readonly("e_coef",
            [](const CPP_cylindrical_map_term1 &self) { return self.e_coef; },
            "Property from Fortran struct")
        .def_property_readonly("b_coef",
            [](const CPP_cylindrical_map_term1 &self) { return self.b_coef; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cylindrical_map_term>(m, "cylindrical_map_term", "Fortran struct: cylindrical_map_term_struct")
        .def(py::init<>())
        .def_property_readonly("file",
            [](const CPP_cylindrical_map_term &self) { return self.file; },
            "Input file name. Used also as ID for instances.")
        .def_property_readonly("n_link",
            [](const CPP_cylindrical_map_term &self) { return self.n_link; },
            "For memory management of this structure")
        // Array property: term, type: CPP_cylindrical_map_term1_ARRAY
        .def_property("term",
            [](const CPP_cylindrical_map_term &self) {
                // Get list of struct objects
                
                return self.term;
                
            },
            [](CPP_cylindrical_map_term &self, py::object obj) {
                // Set term from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.term;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_cylindrical_map_term1>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_cylindrical_map_term1 objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cylindrical_map>(m, "cylindrical_map", "Fortran struct: cylindrical_map_struct")
        .def(py::init<>())
        .def_property_readonly("m",
            [](const CPP_cylindrical_map &self) { return self.m; },
            "Azimuthal Mode: varies as cos(m*phi - theta0_azimuth)")
        .def_property_readonly("harmonic",
            [](const CPP_cylindrical_map &self) { return self.harmonic; },
            "Harmonic of fundamental")
        .def_property_readonly("phi0_fieldmap",
            [](const CPP_cylindrical_map &self) { return self.phi0_fieldmap; },
            "Mode oscillates as: twopi * (f * t + phi0_fieldmap)")
        .def_property_readonly("theta0_azimuth",
            [](const CPP_cylindrical_map &self) { return self.theta0_azimuth; },
            "Azimuthal ((x, y) plane) orientation of mode.")
        .def_property_readonly("field_scale",
            [](const CPP_cylindrical_map &self) { return self.field_scale; },
            "Factor to scale the fields by")
        .def_property_readonly("master_parameter",
            [](const CPP_cylindrical_map &self) { return self.master_parameter; },
            "Master parameter in ele%value(:) array to use for scaling the field.")
        .def_property_readonly("ele_anchor_pt",
            [](const CPP_cylindrical_map &self) { return self.ele_anchor_pt; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        .def_property_readonly("dz",
            [](const CPP_cylindrical_map &self) { return self.dz; },
            "Distance between sampled field points.")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_cylindrical_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_cylindrical_map &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "Field origin offset.")
        .def_property_readonly("ptr",
            [](const CPP_cylindrical_map &self) { return self.ptr; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_grid_field_pt1>(m, "grid_field_pt1", "Fortran struct: grid_field_pt1_struct")
        .def(py::init<>())
        // Array property: e, type: Complex_ARRAY
        .def_property("e",
            [](const CPP_grid_field_pt1 &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.e;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_grid_field_pt1 &self, py::array arr) {
                // Set e from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: b, type: Complex_ARRAY
        .def_property("b",
            [](const CPP_grid_field_pt1 &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.b;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_grid_field_pt1 &self, py::array arr) {
                // Set b from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_grid_field_pt>(m, "grid_field_pt", "Fortran struct: grid_field_pt_struct")
        .def(py::init<>())
        .def_property_readonly("file",
            [](const CPP_grid_field_pt &self) { return self.file; },
            "Input file name. Used also as ID for instances.")
        .def_property_readonly("n_link",
            [](const CPP_grid_field_pt &self) { return self.n_link; },
            "For memory management of this structure")
        // Array property: pt, type: CPP_grid_field_pt1_TENSOR
        .def_property("pt",
            [](const CPP_grid_field_pt &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_grid_field_pt &self, py::object obj) {
                // Set pt from list of structs
                // Unsupported dimensions for struct arrays
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_grid_field>(m, "grid_field", "Fortran struct: grid_field_struct")
        .def(py::init<>())
        .def_property_readonly("geometry",
            [](const CPP_grid_field &self) { return self.geometry; },
            "Type of grid: xyz$, or rotationally_symmetric_rz$")
        .def_property_readonly("harmonic",
            [](const CPP_grid_field &self) { return self.harmonic; },
            "Harmonic of fundamental for AC fields.")
        .def_property_readonly("phi0_fieldmap",
            [](const CPP_grid_field &self) { return self.phi0_fieldmap; },
            "Mode oscillates as: twopi * (f * t + phi0_fieldmap)")
        .def_property_readonly("field_scale",
            [](const CPP_grid_field &self) { return self.field_scale; },
            "Factor to scale the fields by")
        .def_property_readonly("field_type",
            [](const CPP_grid_field &self) { return self.field_type; },
            "or magnetic$ or electric$")
        .def_property_readonly("master_parameter",
            [](const CPP_grid_field &self) { return self.master_parameter; },
            "Master parameter in ele%value(:) array to use for scaling the field.")
        .def_property_readonly("ele_anchor_pt",
            [](const CPP_grid_field &self) { return self.ele_anchor_pt; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        .def_property_readonly("interpolation_order",
            [](const CPP_grid_field &self) { return self.interpolation_order; },
            "Possibilities are 1 or 3.")
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_grid_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_grid_field &self, py::array arr) {
                // Set dr from numpy array
                
                return arr;
    
            },
            "Grid spacing.")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_grid_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_grid_field &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "Field origin relative to ele_anchor_pt.")
        .def_property_readonly("curved_ref_frame",
            [](const CPP_grid_field &self) { return self.curved_ref_frame; },
            "Property from Fortran struct")
        .def_property_readonly("ptr",
            [](const CPP_grid_field &self) { return self.ptr; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_floor_position>(m, "floor_position", "Fortran struct: floor_position_struct")
        .def(py::init<>())
        // Array property: r, type: Real_ARRAY
        .def_property("r",
            [](const CPP_floor_position &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_floor_position &self, py::array arr) {
                // Set r from numpy array
                
                return arr;
    
            },
            "(x, y, z) offset from origin")
        // Array property: w, type: Real_MATRIX
        .def_property("w",
            [](const CPP_floor_position &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.w;
                
                return py::str("not implemented");
        
            },
            [](CPP_floor_position &self, py::array arr) {
                // Set w from numpy array
                
                return arr;
    
            },
            "W matrix. Columns are unit vectors of the frame axes.")
        .def_property_readonly("theta",
            [](const CPP_floor_position &self) { return self.theta; },
            "angular orientation consistent with W matrix")
        .def_property_readonly("phi",
            [](const CPP_floor_position &self) { return self.phi; },
            "angular orientation consistent with W matrix")
        .def_property_readonly("psi",
            [](const CPP_floor_position &self) { return self.psi; },
            "angular orientation consistent with W matrix")
        ;

    py::class_<CPP_high_energy_space_charge>(m, "high_energy_space_charge", "Fortran struct: high_energy_space_charge_struct")
        .def(py::init<>())
        .def_property_readonly("closed_orb",
            [](const CPP_high_energy_space_charge &self) { return self.closed_orb; },
            "beam orbit")
        .def_property_readonly("kick_const",
            [](const CPP_high_energy_space_charge &self) { return self.kick_const; },
            "Property from Fortran struct")
        .def_property_readonly("sig_x",
            [](const CPP_high_energy_space_charge &self) { return self.sig_x; },
            "Property from Fortran struct")
        .def_property_readonly("sig_y",
            [](const CPP_high_energy_space_charge &self) { return self.sig_y; },
            "Property from Fortran struct")
        .def_property_readonly("phi",
            [](const CPP_high_energy_space_charge &self) { return self.phi; },
            "Rotation angle to go from lab frame to rotated frame.")
        .def_property_readonly("sin_phi",
            [](const CPP_high_energy_space_charge &self) { return self.sin_phi; },
            "Property from Fortran struct")
        .def_property_readonly("cos_phi",
            [](const CPP_high_energy_space_charge &self) { return self.cos_phi; },
            "Property from Fortran struct")
        .def_property_readonly("sig_z",
            [](const CPP_high_energy_space_charge &self) { return self.sig_z; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_xy_disp>(m, "xy_disp", "Fortran struct: xy_disp_struct")
        .def(py::init<>())
        .def_property_readonly("eta",
            [](const CPP_xy_disp &self) { return self.eta; },
            "Property from Fortran struct")
        .def_property_readonly("etap",
            [](const CPP_xy_disp &self) { return self.etap; },
            "Property from Fortran struct")
        .def_property_readonly("deta_ds",
            [](const CPP_xy_disp &self) { return self.deta_ds; },
            "Property from Fortran struct")
        .def_property_readonly("sigma",
            [](const CPP_xy_disp &self) { return self.sigma; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_twiss>(m, "twiss", "Fortran struct: twiss_struct")
        .def(py::init<>())
        .def_property_readonly("beta",
            [](const CPP_twiss &self) { return self.beta; },
            "Property from Fortran struct")
        .def_property_readonly("alpha",
            [](const CPP_twiss &self) { return self.alpha; },
            "Property from Fortran struct")
        .def_property_readonly("gamma",
            [](const CPP_twiss &self) { return self.gamma; },
            "Property from Fortran struct")
        .def_property_readonly("phi",
            [](const CPP_twiss &self) { return self.phi; },
            "Property from Fortran struct")
        .def_property_readonly("eta",
            [](const CPP_twiss &self) { return self.eta; },
            "Property from Fortran struct")
        .def_property_readonly("etap",
            [](const CPP_twiss &self) { return self.etap; },
            "Property from Fortran struct")
        .def_property_readonly("deta_ds",
            [](const CPP_twiss &self) { return self.deta_ds; },
            "Property from Fortran struct")
        .def_property_readonly("sigma",
            [](const CPP_twiss &self) { return self.sigma; },
            "Property from Fortran struct")
        .def_property_readonly("sigma_p",
            [](const CPP_twiss &self) { return self.sigma_p; },
            "Property from Fortran struct")
        .def_property_readonly("emit",
            [](const CPP_twiss &self) { return self.emit; },
            "Property from Fortran struct")
        .def_property_readonly("norm_emit",
            [](const CPP_twiss &self) { return self.norm_emit; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_mode3>(m, "mode3", "Fortran struct: mode3_struct")
        .def(py::init<>())
        // Array property: v, type: Real_MATRIX
        .def_property("v",
            [](const CPP_mode3 &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.v;
                
                return py::str("not implemented");
        
            },
            [](CPP_mode3 &self, py::array arr) {
                // Set v from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        .def_property_readonly("a",
            [](const CPP_mode3 &self) { return self.a; },
            "Property from Fortran struct")
        .def_property_readonly("b",
            [](const CPP_mode3 &self) { return self.b; },
            "Property from Fortran struct")
        .def_property_readonly("c",
            [](const CPP_mode3 &self) { return self.c; },
            "Property from Fortran struct")
        .def_property_readonly("x",
            [](const CPP_mode3 &self) { return self.x; },
            "Property from Fortran struct")
        .def_property_readonly("y",
            [](const CPP_mode3 &self) { return self.y; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_bookkeeping_state>(m, "bookkeeping_state", "Fortran struct: bookkeeping_state_struct")
        .def(py::init<>())
        .def_property_readonly("attributes",
            [](const CPP_bookkeeping_state &self) { return self.attributes; },
            "Element dependent attributes: super_ok$, ok$ or stale$")
        .def_property_readonly("control",
            [](const CPP_bookkeeping_state &self) { return self.control; },
            "Lord/slave bookkeeping status: super_ok$, ok$ or stale$")
        .def_property_readonly("floor_position",
            [](const CPP_bookkeeping_state &self) { return self.floor_position; },
            "Global (floor) geometry: super_ok$, ok$ or stale$")
        .def_property_readonly("s_position",
            [](const CPP_bookkeeping_state &self) { return self.s_position; },
            "Longitudinal position & element length: super_ok$, ok$ or stale$")
        .def_property_readonly("ref_energy",
            [](const CPP_bookkeeping_state &self) { return self.ref_energy; },
            "Reference energy and ref time: super_ok$, ok$ or stale$")
        .def_property_readonly("mat6",
            [](const CPP_bookkeeping_state &self) { return self.mat6; },
            "Linear transfer map status: super_ok$, ok$ or stale$")
        .def_property_readonly("rad_int",
            [](const CPP_bookkeeping_state &self) { return self.rad_int; },
            "Radiation integrals cache status")
        .def_property_readonly("ptc",
            [](const CPP_bookkeeping_state &self) { return self.ptc; },
            "Associated PTC fibre (or layout) status.")
        .def_property_readonly("has_misalign",
            [](const CPP_bookkeeping_state &self) { return self.has_misalign; },
            "Used to avoid unnecessary calls to offset_particle.")
        ;

    py::class_<CPP_rad_map>(m, "rad_map", "Fortran struct: rad_map_struct")
        .def(py::init<>())
        // Array property: ref_orb, type: Real_ARRAY
        .def_property("ref_orb",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.ref_orb;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set ref_orb from numpy array
                
                return arr;
    
            },
            "Reference point around which damp_mat is calculated.")
        // Array property: damp_dmat, type: Real_MATRIX
        .def_property("damp_dmat",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.damp_dmat;
                
                return py::str("not implemented");
        
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set damp_dmat from numpy array
                
                return arr;
    
            },
            "damp_correction = xfer_mat_with_damping - xfer_mat_without_damping.")
        // Array property: xfer_damp_vec, type: Real_ARRAY
        .def_property("xfer_damp_vec",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.xfer_damp_vec;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set xfer_damp_vec from numpy array
                
                return arr;
    
            },
            "Transfer map with damping 0th order vector.")
        // Array property: xfer_damp_mat, type: Real_MATRIX
        .def_property("xfer_damp_mat",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.xfer_damp_mat;
                
                return py::str("not implemented");
        
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set xfer_damp_mat from numpy array
                
                return arr;
    
            },
            "1st order matrix: xfer_no_damp_mat + xfer_damp_correction.")
        // Array property: stoc_mat, type: Real_MATRIX
        .def_property("stoc_mat",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.stoc_mat;
                
                return py::str("not implemented");
        
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set stoc_mat from numpy array
                
                return arr;
    
            },
            "Stochastic variance or 'kick' (Cholesky decomposed) matrix.")
        ;

    py::class_<CPP_rad_map_ele>(m, "rad_map_ele", "Fortran struct: rad_map_ele_struct")
        .def(py::init<>())
        .def_property_readonly("rm0",
            [](const CPP_rad_map_ele &self) { return self.rm0; },
            "Upstream half and downstream half matrices for an element.")
        .def_property_readonly("rm1",
            [](const CPP_rad_map_ele &self) { return self.rm1; },
            "Upstream half and downstream half matrices for an element.")
        .def_property_readonly("stale",
            [](const CPP_rad_map_ele &self) { return self.stale; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_gen_grad1>(m, "gen_grad1", "Fortran struct: gen_grad1_struct")
        .def(py::init<>())
        .def_property_readonly("m",
            [](const CPP_gen_grad1 &self) { return self.m; },
            "Azimuthal index")
        .def_property_readonly("sincos",
            [](const CPP_gen_grad1 &self) { return self.sincos; },
            "sin$ or cos$")
        .def_property_readonly("n_deriv_max",
            [](const CPP_gen_grad1 &self) { return self.n_deriv_max; },
            "Max GG derivative")
        // Array property: deriv, type: Real_MATRIX
        .def_property("deriv",
            [](const CPP_gen_grad1 &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.deriv;
                
                return py::str("not implemented");
        
            },
            [](CPP_gen_grad1 &self, py::array arr) {
                // Set deriv from numpy array
                
                return arr;
    
            },
            "Range: (iz0:iz1, 0:2*n_deriv_max+1)")
        ;

    py::class_<CPP_gen_grad_map>(m, "gen_grad_map", "Fortran struct: gen_grad_map_struct")
        .def(py::init<>())
        .def_property_readonly("file",
            [](const CPP_gen_grad_map &self) { return self.file; },
            "Input file name. Used also as ID for instances.")
        // Array property: gg, type: CPP_gen_grad1_ARRAY
        .def_property("gg",
            [](const CPP_gen_grad_map &self) {
                // Get list of struct objects
                
                return self.gg;
                
            },
            [](CPP_gen_grad_map &self, py::object obj) {
                // Set gg from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.gg;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_gen_grad1>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_gen_grad1 objects");
                // }
                
            },
            "Property from Fortran struct")
        .def_property_readonly("ele_anchor_pt",
            [](const CPP_gen_grad_map &self) { return self.ele_anchor_pt; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        .def_property_readonly("field_type",
            [](const CPP_gen_grad_map &self) { return self.field_type; },
            "or electric$")
        .def_property_readonly("iz0",
            [](const CPP_gen_grad_map &self) { return self.iz0; },
            "gg%deriv(iz0:iz1, :) lower bound.")
        .def_property_readonly("iz1",
            [](const CPP_gen_grad_map &self) { return self.iz1; },
            "gg%deriv(iz0:iz1, :) upper bound.")
        .def_property_readonly("dz",
            [](const CPP_gen_grad_map &self) { return self.dz; },
            "Point spacing.")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_gen_grad_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_gen_grad_map &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "field origin relative to ele_anchor_pt.")
        .def_property_readonly("field_scale",
            [](const CPP_gen_grad_map &self) { return self.field_scale; },
            "Factor to scale the fields by")
        .def_property_readonly("master_parameter",
            [](const CPP_gen_grad_map &self) { return self.master_parameter; },
            "Master parameter in ele%value(:) array to use for scaling the field.")
        .def_property_readonly("curved_ref_frame",
            [](const CPP_gen_grad_map &self) { return self.curved_ref_frame; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_surface_segmented_pt>(m, "surface_segmented_pt", "Fortran struct: surface_segmented_pt_struct")
        .def(py::init<>())
        .def_property_readonly("x0",
            [](const CPP_surface_segmented_pt &self) { return self.x0; },
            "Position at center")
        .def_property_readonly("y0",
            [](const CPP_surface_segmented_pt &self) { return self.y0; },
            "Position at center")
        .def_property_readonly("z0",
            [](const CPP_surface_segmented_pt &self) { return self.z0; },
            "Position at center")
        .def_property_readonly("dz_dx",
            [](const CPP_surface_segmented_pt &self) { return self.dz_dx; },
            "Slope at center")
        .def_property_readonly("dz_dy",
            [](const CPP_surface_segmented_pt &self) { return self.dz_dy; },
            "Slope at center")
        ;

    py::class_<CPP_surface_segmented>(m, "surface_segmented", "Fortran struct: surface_segmented_struct")
        .def(py::init<>())
        .def_property_readonly("active",
            [](const CPP_surface_segmented &self) { return self.active; },
            "Property from Fortran struct")
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_surface_segmented &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_surface_segmented &self, py::array arr) {
                // Set dr from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_surface_segmented &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_surface_segmented &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: pt, type: CPP_surface_segmented_pt_MATRIX
        .def_property("pt",
            [](const CPP_surface_segmented &self) {
                // Get list of struct objects
                
                return self.pt;
                // const auto& matrix = self.pt;
                // py::list result;
                // for (size_t i = 0; i < matrix.size(); ++i) {
                //     py::list row;
                //     for (size_t j = 0; j < matrix[i].size(); ++j) {
                //         row.append(py::cast(matrix[i][j]));
                //     }
                //     result.append(row);
                // }
                // return result;
                
            },
            [](CPP_surface_segmented &self, py::object obj) {
                // Set pt from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.pt;
                //     matrix.resize(outer_list.size());
                //     
                //     for (size_t i = 0; i < outer_list.size(); ++i) {
                //         py::list inner_list = outer_list[i].cast<py::list>();
                //         matrix[i].resize(inner_list.size());
                //         
                //         for (size_t j = 0; j < inner_list.size(); ++j) {
                //             // matrix[i][j] = inner_list[j];
                //             // TODO
                //         }
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of lists of CPP_surface_segmented_pt objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_surface_h_misalign_pt>(m, "surface_h_misalign_pt", "Fortran struct: surface_h_misalign_pt_struct")
        .def(py::init<>())
        .def_property_readonly("x0",
            [](const CPP_surface_h_misalign_pt &self) { return self.x0; },
            "Position at center")
        .def_property_readonly("y0",
            [](const CPP_surface_h_misalign_pt &self) { return self.y0; },
            "Position at center")
        .def_property_readonly("rot_y",
            [](const CPP_surface_h_misalign_pt &self) { return self.rot_y; },
            "rot_t = x-rotation for Bragg and z-rotation for Laue.")
        .def_property_readonly("rot_t",
            [](const CPP_surface_h_misalign_pt &self) { return self.rot_t; },
            "rot_t = x-rotation for Bragg and z-rotation for Laue.")
        .def_property_readonly("rot_y_rms",
            [](const CPP_surface_h_misalign_pt &self) { return self.rot_y_rms; },
            "rot_t = x-rotation for Bragg and z-rotation for Laue.")
        .def_property_readonly("rot_t_rms",
            [](const CPP_surface_h_misalign_pt &self) { return self.rot_t_rms; },
            "rot_t = x-rotation for Bragg and z-rotation for Laue.")
        ;

    py::class_<CPP_surface_h_misalign>(m, "surface_h_misalign", "Fortran struct: surface_h_misalign_struct")
        .def(py::init<>())
        .def_property_readonly("active",
            [](const CPP_surface_h_misalign &self) { return self.active; },
            "Property from Fortran struct")
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_surface_h_misalign &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_surface_h_misalign &self, py::array arr) {
                // Set dr from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_surface_h_misalign &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_surface_h_misalign &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: pt, type: CPP_surface_h_misalign_pt_MATRIX
        .def_property("pt",
            [](const CPP_surface_h_misalign &self) {
                // Get list of struct objects
                
                return self.pt;
                // const auto& matrix = self.pt;
                // py::list result;
                // for (size_t i = 0; i < matrix.size(); ++i) {
                //     py::list row;
                //     for (size_t j = 0; j < matrix[i].size(); ++j) {
                //         row.append(py::cast(matrix[i][j]));
                //     }
                //     result.append(row);
                // }
                // return result;
                
            },
            [](CPP_surface_h_misalign &self, py::object obj) {
                // Set pt from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.pt;
                //     matrix.resize(outer_list.size());
                //     
                //     for (size_t i = 0; i < outer_list.size(); ++i) {
                //         py::list inner_list = outer_list[i].cast<py::list>();
                //         matrix[i].resize(inner_list.size());
                //         
                //         for (size_t j = 0; j < inner_list.size(); ++j) {
                //             // matrix[i][j] = inner_list[j];
                //             // TODO
                //         }
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of lists of CPP_surface_h_misalign_pt objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_surface_displacement_pt>(m, "surface_displacement_pt", "Fortran struct: surface_displacement_pt_struct")
        .def(py::init<>())
        .def_property_readonly("x0",
            [](const CPP_surface_displacement_pt &self) { return self.x0; },
            "Position at center")
        .def_property_readonly("y0",
            [](const CPP_surface_displacement_pt &self) { return self.y0; },
            "Position at center")
        .def_property_readonly("z0",
            [](const CPP_surface_displacement_pt &self) { return self.z0; },
            "Property from Fortran struct")
        .def_property_readonly("dz_dx",
            [](const CPP_surface_displacement_pt &self) { return self.dz_dx; },
            "Property from Fortran struct")
        .def_property_readonly("dz_dy",
            [](const CPP_surface_displacement_pt &self) { return self.dz_dy; },
            "Property from Fortran struct")
        .def_property_readonly("d2z_dxdy",
            [](const CPP_surface_displacement_pt &self) { return self.d2z_dxdy; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_surface_displacement>(m, "surface_displacement", "Fortran struct: surface_displacement_struct")
        .def(py::init<>())
        .def_property_readonly("active",
            [](const CPP_surface_displacement &self) { return self.active; },
            "Property from Fortran struct")
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_surface_displacement &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_surface_displacement &self, py::array arr) {
                // Set dr from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_surface_displacement &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_surface_displacement &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: pt, type: CPP_surface_displacement_pt_MATRIX
        .def_property("pt",
            [](const CPP_surface_displacement &self) {
                // Get list of struct objects
                
                return self.pt;
                // const auto& matrix = self.pt;
                // py::list result;
                // for (size_t i = 0; i < matrix.size(); ++i) {
                //     py::list row;
                //     for (size_t j = 0; j < matrix[i].size(); ++j) {
                //         row.append(py::cast(matrix[i][j]));
                //     }
                //     result.append(row);
                // }
                // return result;
                
            },
            [](CPP_surface_displacement &self, py::object obj) {
                // Set pt from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.pt;
                //     matrix.resize(outer_list.size());
                //     
                //     for (size_t i = 0; i < outer_list.size(); ++i) {
                //         py::list inner_list = outer_list[i].cast<py::list>();
                //         matrix[i].resize(inner_list.size());
                //         
                //         for (size_t j = 0; j < inner_list.size(); ++j) {
                //             // matrix[i][j] = inner_list[j];
                //             // TODO
                //         }
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of lists of CPP_surface_displacement_pt objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_target_point>(m, "target_point", "Fortran struct: target_point_struct")
        .def(py::init<>())
        // Array property: r, type: Real_ARRAY
        .def_property("r",
            [](const CPP_target_point &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_target_point &self, py::array arr) {
                // Set r from numpy array
                
                return arr;
    
            },
            "(x, y, z)")
        ;

    py::class_<CPP_surface_curvature>(m, "surface_curvature", "Fortran struct: surface_curvature_struct")
        .def(py::init<>())
        // Array property: xy, type: Real_MATRIX
        .def_property("xy",
            [](const CPP_surface_curvature &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.xy;
                
                return py::str("not implemented");
        
            },
            [](CPP_surface_curvature &self, py::array arr) {
                // Set xy from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        .def_property_readonly("spherical",
            [](const CPP_surface_curvature &self) { return self.spherical; },
            "Property from Fortran struct")
        // Array property: elliptical, type: Real_ARRAY
        .def_property("elliptical",
            [](const CPP_surface_curvature &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.elliptical;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_surface_curvature &self, py::array arr) {
                // Set elliptical from numpy array
                
                return arr;
    
            },
            "Total curvature = elliptical + spherical")
        .def_property_readonly("has_curvature",
            [](const CPP_surface_curvature &self) { return self.has_curvature; },
            "Dependent var. Will be set by Bmad")
        ;

    py::class_<CPP_photon_target>(m, "photon_target", "Fortran struct: photon_target_struct")
        .def(py::init<>())
        .def_property_readonly("type",
            [](const CPP_photon_target &self) { return self.type; },
            "or rectangular$")
        .def_property_readonly("n_corner",
            [](const CPP_photon_target &self) { return self.n_corner; },
            "Property from Fortran struct")
        .def_property_readonly("ele_loc",
            [](const CPP_photon_target &self) { return self.ele_loc; },
            "Property from Fortran struct")
        // Array property: corner, type: CPP_target_point_ARRAY
        .def_property("corner",
            [](const CPP_photon_target &self) {
                // Get list of struct objects
                
                return self.corner;
                
            },
            [](CPP_photon_target &self, py::object obj) {
                // Set corner from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.corner;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_target_point>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_target_point objects");
                // }
                
            },
            "Property from Fortran struct")
        .def_property_readonly("center",
            [](const CPP_photon_target &self) { return self.center; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_photon_material>(m, "photon_material", "Fortran struct: photon_material_struct")
        .def(py::init<>())
        .def_property_readonly("f0_m1",
            [](const CPP_photon_material &self) { return self.f0_m1; },
            "For multilayer_mirror only.")
        .def_property_readonly("f0_m2",
            [](const CPP_photon_material &self) { return self.f0_m2; },
            "For multilayer_mirror only.")
        .def_property_readonly("f_0",
            [](const CPP_photon_material &self) { return self.f_0; },
            "Property from Fortran struct")
        .def_property_readonly("f_h",
            [](const CPP_photon_material &self) { return self.f_h; },
            "Structure factor for H direction.")
        .def_property_readonly("f_hbar",
            [](const CPP_photon_material &self) { return self.f_hbar; },
            "Structure factor for -H direction.")
        .def_property_readonly("f_hkl",
            [](const CPP_photon_material &self) { return self.f_hkl; },
            "= sqrt(f_h * f_hbar)")
        // Array property: h_norm, type: Real_ARRAY
        .def_property("h_norm",
            [](const CPP_photon_material &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.h_norm;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_photon_material &self, py::array arr) {
                // Set h_norm from numpy array
                
                return arr;
    
            },
            "Normalized H vector for crystals.")
        // Array property: l_ref, type: Real_ARRAY
        .def_property("l_ref",
            [](const CPP_photon_material &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.l_ref;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_photon_material &self, py::array arr) {
                // Set l_ref from numpy array
                
                return arr;
    
            },
            "Crystal reference orbit displacement vector in element coords.")
        ;

    py::class_<CPP_pixel_pt>(m, "pixel_pt", "Fortran struct: pixel_pt_struct")
        .def(py::init<>())
        .def_property_readonly("n_photon",
            [](const CPP_pixel_pt &self) { return self.n_photon; },
            "Property from Fortran struct")
        .def_property_readonly("e_x",
            [](const CPP_pixel_pt &self) { return self.e_x; },
            "Property from Fortran struct")
        .def_property_readonly("e_y",
            [](const CPP_pixel_pt &self) { return self.e_y; },
            "Property from Fortran struct")
        .def_property_readonly("intensity_x",
            [](const CPP_pixel_pt &self) { return self.intensity_x; },
            "Property from Fortran struct")
        .def_property_readonly("intensity_y",
            [](const CPP_pixel_pt &self) { return self.intensity_y; },
            "Property from Fortran struct")
        .def_property_readonly("intensity",
            [](const CPP_pixel_pt &self) { return self.intensity; },
            "Property from Fortran struct")
        // Array property: orbit, type: Real_ARRAY
        .def_property("orbit",
            [](const CPP_pixel_pt &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.orbit;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_pixel_pt &self, py::array arr) {
                // Set orbit from numpy array
                
                return arr;
    
            },
            "x, Vx/c, y, Vy/c, dummy, E - E_ref.")
        // Array property: orbit_rms, type: Real_ARRAY
        .def_property("orbit_rms",
            [](const CPP_pixel_pt &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.orbit_rms;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_pixel_pt &self, py::array arr) {
                // Set orbit_rms from numpy array
                
                return arr;
    
            },
            "RMS statistics.")
        // Array property: init_orbit, type: Real_ARRAY
        .def_property("init_orbit",
            [](const CPP_pixel_pt &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.init_orbit;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_pixel_pt &self, py::array arr) {
                // Set init_orbit from numpy array
                
                return arr;
    
            },
            "Initial orbit at start of lattice statistics.")
        // Array property: init_orbit_rms, type: Real_ARRAY
        .def_property("init_orbit_rms",
            [](const CPP_pixel_pt &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.init_orbit_rms;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_pixel_pt &self, py::array arr) {
                // Set init_orbit_rms from numpy array
                
                return arr;
    
            },
            "Initial orbit at start of lattice RMS statistics.")
        ;

    py::class_<CPP_pixel_detec>(m, "pixel_detec", "Fortran struct: pixel_detec_struct")
        .def(py::init<>())
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_pixel_detec &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_pixel_detec &self, py::array arr) {
                // Set dr from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_pixel_detec &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_pixel_detec &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        .def_property_readonly("n_track_tot",
            [](const CPP_pixel_detec &self) { return self.n_track_tot; },
            "How many photons were launched from source element.")
        .def_property_readonly("n_hit_detec",
            [](const CPP_pixel_detec &self) { return self.n_hit_detec; },
            "How many photons hit the detector.")
        .def_property_readonly("n_hit_pixel",
            [](const CPP_pixel_detec &self) { return self.n_hit_pixel; },
            "How many photons hit the pixel grid of the detector.")
        // Array property: pt, type: CPP_pixel_pt_MATRIX
        .def_property("pt",
            [](const CPP_pixel_detec &self) {
                // Get list of struct objects
                
                return self.pt;
                // const auto& matrix = self.pt;
                // py::list result;
                // for (size_t i = 0; i < matrix.size(); ++i) {
                //     py::list row;
                //     for (size_t j = 0; j < matrix[i].size(); ++j) {
                //         row.append(py::cast(matrix[i][j]));
                //     }
                //     result.append(row);
                // }
                // return result;
                
            },
            [](CPP_pixel_detec &self, py::object obj) {
                // Set pt from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.pt;
                //     matrix.resize(outer_list.size());
                //     
                //     for (size_t i = 0; i < outer_list.size(); ++i) {
                //         py::list inner_list = outer_list[i].cast<py::list>();
                //         matrix[i].resize(inner_list.size());
                //         
                //         for (size_t j = 0; j < inner_list.size(); ++j) {
                //             // matrix[i][j] = inner_list[j];
                //             // TODO
                //         }
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of lists of CPP_pixel_pt objects");
                // }
                
            },
            "Grid of pixels")
        ;

    py::class_<CPP_photon_element>(m, "photon_element", "Fortran struct: photon_element_struct")
        .def(py::init<>())
        .def_property_readonly("curvature",
            [](const CPP_photon_element &self) { return self.curvature; },
            "Property from Fortran struct")
        .def_property_readonly("target",
            [](const CPP_photon_element &self) { return self.target; },
            "Property from Fortran struct")
        .def_property_readonly("material",
            [](const CPP_photon_element &self) { return self.material; },
            "Property from Fortran struct")
        .def_property_readonly("segmented",
            [](const CPP_photon_element &self) { return self.segmented; },
            "Property from Fortran struct")
        .def_property_readonly("h_misalign",
            [](const CPP_photon_element &self) { return self.h_misalign; },
            "Property from Fortran struct")
        .def_property_readonly("displacement",
            [](const CPP_photon_element &self) { return self.displacement; },
            "Property from Fortran struct")
        .def_property_readonly("pixel",
            [](const CPP_photon_element &self) { return self.pixel; },
            "Property from Fortran struct")
        .def_property_readonly("reflectivity_table_type",
            [](const CPP_photon_element &self) { return self.reflectivity_table_type; },
            "Property from Fortran struct")
        .def_property_readonly("reflectivity_table_sigma",
            [](const CPP_photon_element &self) { return self.reflectivity_table_sigma; },
            "If polarization is ignored use sigma table.")
        .def_property_readonly("reflectivity_table_pi",
            [](const CPP_photon_element &self) { return self.reflectivity_table_pi; },
            "Property from Fortran struct")
        // Array property: init_energy_prob, type: CPP_spline_ARRAY
        .def_property("init_energy_prob",
            [](const CPP_photon_element &self) {
                // Get list of struct objects
                
                return self.init_energy_prob;
                
            },
            [](CPP_photon_element &self, py::object obj) {
                // Set init_energy_prob from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.init_energy_prob;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_spline>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_spline objects");
                // }
                
            },
            "Initial energy probability density")
        // Array property: integrated_init_energy_prob, type: Real_ARRAY
        .def_property("integrated_init_energy_prob",
            [](const CPP_photon_element &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.integrated_init_energy_prob;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_photon_element &self, py::array arr) {
                // Set integrated_init_energy_prob from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_wall3d_vertex>(m, "wall3d_vertex", "Fortran struct: wall3d_vertex_struct")
        .def(py::init<>())
        .def_property_readonly("x",
            [](const CPP_wall3d_vertex &self) { return self.x; },
            "Coordinates of the vertex.")
        .def_property_readonly("y",
            [](const CPP_wall3d_vertex &self) { return self.y; },
            "Coordinates of the vertex.")
        .def_property_readonly("radius_x",
            [](const CPP_wall3d_vertex &self) { return self.radius_x; },
            "Radius of arc or ellipse x-axis half width. 0 => Straight line.")
        .def_property_readonly("radius_y",
            [](const CPP_wall3d_vertex &self) { return self.radius_y; },
            "Ellipse y-axis half height.")
        .def_property_readonly("tilt",
            [](const CPP_wall3d_vertex &self) { return self.tilt; },
            "Tilt of ellipse")
        .def_property_readonly("angle",
            [](const CPP_wall3d_vertex &self) { return self.angle; },
            "Angle of (x, y) point.")
        .def_property_readonly("x0",
            [](const CPP_wall3d_vertex &self) { return self.x0; },
            "Center of ellipse")
        .def_property_readonly("y0",
            [](const CPP_wall3d_vertex &self) { return self.y0; },
            "Center of ellipse")
        .def_property_readonly("type",
            [](const CPP_wall3d_vertex &self) { return self.type; },
            "No longer used.")
        ;

    py::class_<CPP_wall3d_section>(m, "wall3d_section", "Fortran struct: wall3d_section_struct")
        .def(py::init<>())
        .def_property_readonly("name",
            [](const CPP_wall3d_section &self) { return self.name; },
            "Identifying name")
        .def_property_readonly("material",
            [](const CPP_wall3d_section &self) { return self.material; },
            "Material.")
        // Array property: v, type: CPP_wall3d_vertex_ARRAY
        .def_property("v",
            [](const CPP_wall3d_section &self) {
                // Get list of struct objects
                
                return self.v;
                
            },
            [](CPP_wall3d_section &self, py::object obj) {
                // Set v from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.v;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_wall3d_vertex>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wall3d_vertex objects");
                // }
                
            },
            "Array of vertices. Always stored relative.")
        .def_property_readonly("surface",
            [](const CPP_wall3d_section &self) { return self.surface; },
            "Property from Fortran struct")
        .def_property_readonly("type",
            [](const CPP_wall3d_section &self) { return self.type; },
            "normal$, clear$, opaque$, wall_start$, wall_end$")
        .def_property_readonly("n_vertex_input",
            [](const CPP_wall3d_section &self) { return self.n_vertex_input; },
            "Number of vertices specified by the user.")
        .def_property_readonly("ix_ele",
            [](const CPP_wall3d_section &self) { return self.ix_ele; },
            "index of lattice element containing section")
        .def_property_readonly("ix_branch",
            [](const CPP_wall3d_section &self) { return self.ix_branch; },
            "Index of branch lattice element is in.")
        .def_property_readonly("vertices_state",
            [](const CPP_wall3d_section &self) { return self.vertices_state; },
            "absolute$, or shifted_to_relative$. If set to absolute$ on input,")
        .def_property_readonly("patch_in_region",
            [](const CPP_wall3d_section &self) { return self.patch_in_region; },
            "Patch element exists between this section and previous one?")
        .def_property_readonly("thickness",
            [](const CPP_wall3d_section &self) { return self.thickness; },
            "Material thickness.")
        .def_property_readonly("s",
            [](const CPP_wall3d_section &self) { return self.s; },
            "Longitudinal position")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set r0 from numpy array
                
                return arr;
    
            },
            "Center of section")
        .def_property_readonly("dx0_ds",
            [](const CPP_wall3d_section &self) { return self.dx0_ds; },
            "Center of wall derivative")
        .def_property_readonly("dy0_ds",
            [](const CPP_wall3d_section &self) { return self.dy0_ds; },
            "Center of wall derivative")
        // Array property: x0_coef, type: Real_ARRAY
        .def_property("x0_coef",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.x0_coef;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set x0_coef from numpy array
                
                return arr;
    
            },
            "Spline coefs for x-center")
        // Array property: y0_coef, type: Real_ARRAY
        .def_property("y0_coef",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.y0_coef;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set y0_coef from numpy array
                
                return arr;
    
            },
            "Spline coefs for y-center")
        .def_property_readonly("dr_ds",
            [](const CPP_wall3d_section &self) { return self.dr_ds; },
            "derivative of wall radius")
        // Array property: p1_coef, type: Real_ARRAY
        .def_property("p1_coef",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.p1_coef;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set p1_coef from numpy array
                
                return arr;
    
            },
            "Spline coefs for p0 function")
        // Array property: p2_coef, type: Real_ARRAY
        .def_property("p2_coef",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.p2_coef;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set p2_coef from numpy array
                
                return arr;
    
            },
            "Spline coefs for p1 function")
        ;

    py::class_<CPP_wall3d>(m, "wall3d", "Fortran struct: wall3d_struct")
        .def(py::init<>())
        .def_property_readonly("name",
            [](const CPP_wall3d &self) { return self.name; },
            "Property from Fortran struct")
        .def_property_readonly("type",
            [](const CPP_wall3d &self) { return self.type; },
            "or mask_plate$")
        .def_property_readonly("ix_wall3d",
            [](const CPP_wall3d &self) { return self.ix_wall3d; },
            "Index in branch%wall3d(:) array.")
        .def_property_readonly("n_link",
            [](const CPP_wall3d &self) { return self.n_link; },
            "For memory management of ele%wall3d")
        .def_property_readonly("thickness",
            [](const CPP_wall3d &self) { return self.thickness; },
            "For diffraction_plate elements")
        .def_property_readonly("clear_material",
            [](const CPP_wall3d &self) { return self.clear_material; },
            "Property from Fortran struct")
        .def_property_readonly("opaque_material",
            [](const CPP_wall3d &self) { return self.opaque_material; },
            "Property from Fortran struct")
        .def_property_readonly("superimpose",
            [](const CPP_wall3d &self) { return self.superimpose; },
            "Can overlap another wall")
        .def_property_readonly("ele_anchor_pt",
            [](const CPP_wall3d &self) { return self.ele_anchor_pt; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        // Array property: section, type: CPP_wall3d_section_ARRAY
        .def_property("section",
            [](const CPP_wall3d &self) {
                // Get list of struct objects
                
                return self.section;
                
            },
            [](CPP_wall3d &self, py::object obj) {
                // Set section from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.section;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_wall3d_section>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wall3d_section objects");
                // }
                
            },
            "Indexed from 1.")
        ;

    py::class_<CPP_ramper_lord>(m, "ramper_lord", "Fortran struct: ramper_lord_struct")
        .def(py::init<>())
        .def_property_readonly("ix_ele",
            [](const CPP_ramper_lord &self) { return self.ix_ele; },
            "Lord index")
        .def_property_readonly("ix_con",
            [](const CPP_ramper_lord &self) { return self.ix_con; },
            "Index in lord%control%ramp(:) array")
        .def_property_readonly("attrib_ptr",
            [](const CPP_ramper_lord &self) { return self.attrib_ptr ? py::cast(*self.attrib_ptr) : py::none(); },
            "Pointer to attribute in this element.")
        ;

    py::class_<CPP_control>(m, "control", "Fortran struct: control_struct")
        .def(py::init<>())
        .def_property_readonly("value",
            [](const CPP_control &self) { return self.value; },
            "Used by group, and overlay elements.")
        // Array property: y_knot, type: Real_ARRAY
        .def_property("y_knot",
            [](const CPP_control &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.y_knot;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_control &self, py::array arr) {
                // Set y_knot from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: stack, type: CPP_expression_atom_ARRAY
        .def_property("stack",
            [](const CPP_control &self) {
                // Get list of struct objects
                
                return self.stack;
                
            },
            [](CPP_control &self, py::object obj) {
                // Set stack from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.stack;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_expression_atom>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_expression_atom objects");
                // }
                
            },
            "Evaluation stack")
        .def_property_readonly("slave",
            [](const CPP_control &self) { return self.slave; },
            "Property from Fortran struct")
        .def_property_readonly("lord",
            [](const CPP_control &self) { return self.lord; },
            "Property from Fortran struct")
        .def_property_readonly("slave_name",
            [](const CPP_control &self) { return self.slave_name; },
            "Name of slave.")
        .def_property_readonly("attribute",
            [](const CPP_control &self) { return self.attribute; },
            "Name of attribute controlled. Set to 'FIELD_OVERLAPS' for field overlaps.")
        .def_property_readonly("ix_attrib",
            [](const CPP_control &self) { return self.ix_attrib; },
            "Index of attribute controlled. See note above!")
        ;

    py::class_<CPP_control_var1>(m, "control_var1", "Fortran struct: control_var1_struct")
        .def(py::init<>())
        .def_property_readonly("name",
            [](const CPP_control_var1 &self) { return self.name; },
            "Property from Fortran struct")
        .def_property_readonly("value",
            [](const CPP_control_var1 &self) { return self.value; },
            "Property from Fortran struct")
        .def_property_readonly("old_value",
            [](const CPP_control_var1 &self) { return self.old_value; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_control_ramp1>(m, "control_ramp1", "Fortran struct: control_ramp1_struct")
        .def(py::init<>())
        // Array property: y_knot, type: Real_ARRAY
        .def_property("y_knot",
            [](const CPP_control_ramp1 &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.y_knot;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_control_ramp1 &self, py::array arr) {
                // Set y_knot from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: stack, type: CPP_expression_atom_ARRAY
        .def_property("stack",
            [](const CPP_control_ramp1 &self) {
                // Get list of struct objects
                
                return self.stack;
                
            },
            [](CPP_control_ramp1 &self, py::object obj) {
                // Set stack from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.stack;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_expression_atom>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_expression_atom objects");
                // }
                
            },
            "Evaluation stack")
        .def_property_readonly("attribute",
            [](const CPP_control_ramp1 &self) { return self.attribute; },
            "Name of attribute controlled. Set to 'FIELD_OVERLAPS' for field overlaps.")
        .def_property_readonly("slave_name",
            [](const CPP_control_ramp1 &self) { return self.slave_name; },
            "Name of slave.")
        .def_property_readonly("is_controller",
            [](const CPP_control_ramp1 &self) { return self.is_controller; },
            "Is the slave a controller? If so bookkeeping is different.")
        ;

    py::class_<CPP_controller>(m, "controller", "Fortran struct: controller_struct")
        .def(py::init<>())
        // Array property: var, type: CPP_control_var1_ARRAY
        .def_property("var",
            [](const CPP_controller &self) {
                // Get list of struct objects
                
                return self.var;
                
            },
            [](CPP_controller &self, py::object obj) {
                // Set var from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.var;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_control_var1>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_control_var1 objects");
                // }
                
            },
            "Property from Fortran struct")
        // Array property: ramp, type: CPP_control_ramp1_ARRAY
        .def_property("ramp",
            [](const CPP_controller &self) {
                // Get list of struct objects
                
                return self.ramp;
                
            },
            [](CPP_controller &self, py::object obj) {
                // Set ramp from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.ramp;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_control_ramp1>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_control_ramp1 objects");
                // }
                
            },
            "For ramper lord elements")
        // Array property: ramper_lord, type: CPP_ramper_lord_ARRAY
        .def_property("ramper_lord",
            [](const CPP_controller &self) {
                // Get list of struct objects
                
                return self.ramper_lord;
                
            },
            [](CPP_controller &self, py::object obj) {
                // Set ramper_lord from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.ramper_lord;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_ramper_lord>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ramper_lord objects");
                // }
                
            },
            "Ramper lord info for this slave")
        // Array property: x_knot, type: Real_ARRAY
        .def_property("x_knot",
            [](const CPP_controller &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.x_knot;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_controller &self, py::array arr) {
                // Set x_knot from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_ellipse_beam_init>(m, "ellipse_beam_init", "Fortran struct: ellipse_beam_init_struct")
        .def(py::init<>())
        .def_property_readonly("part_per_ellipse",
            [](const CPP_ellipse_beam_init &self) { return self.part_per_ellipse; },
            "number of particles per ellipse")
        .def_property_readonly("n_ellipse",
            [](const CPP_ellipse_beam_init &self) { return self.n_ellipse; },
            "number of ellipses (>= 1)")
        .def_property_readonly("sigma_cutoff",
            [](const CPP_ellipse_beam_init &self) { return self.sigma_cutoff; },
            "sigma cutoff of the representation")
        ;

    py::class_<CPP_kv_beam_init>(m, "kv_beam_init", "Fortran struct: kv_beam_init_struct")
        .def(py::init<>())
        // Array property: part_per_phi, type: Int_ARRAY
        .def_property("part_per_phi",
            [](const CPP_kv_beam_init &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.part_per_phi;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_kv_beam_init &self, py::array arr) {
                // Set part_per_phi from numpy array
                
                return arr;
    
            },
            "number of particles per angle variable.")
        .def_property_readonly("n_i2",
            [](const CPP_kv_beam_init &self) { return self.n_i2; },
            "number of I2")
        .def_property_readonly("a",
            [](const CPP_kv_beam_init &self) { return self.a; },
            "A = I1/e")
        ;

    py::class_<CPP_grid_beam_init>(m, "grid_beam_init", "Fortran struct: grid_beam_init_struct")
        .def(py::init<>())
        .def_property_readonly("n_x",
            [](const CPP_grid_beam_init &self) { return self.n_x; },
            "Number of columns.")
        .def_property_readonly("n_px",
            [](const CPP_grid_beam_init &self) { return self.n_px; },
            "Number of rows.")
        .def_property_readonly("x_min",
            [](const CPP_grid_beam_init &self) { return self.x_min; },
            "Lower x limit.")
        .def_property_readonly("x_max",
            [](const CPP_grid_beam_init &self) { return self.x_max; },
            "Upper x limit.")
        .def_property_readonly("px_min",
            [](const CPP_grid_beam_init &self) { return self.px_min; },
            "Lower px limit.")
        .def_property_readonly("px_max",
            [](const CPP_grid_beam_init &self) { return self.px_max; },
            "Upper px limit.")
        ;

    py::class_<CPP_beam_init>(m, "beam_init", "Fortran struct: beam_init_struct")
        .def(py::init<>())
        .def_property_readonly("position_file",
            [](const CPP_beam_init &self) { return self.position_file; },
            "File with particle positions.")
        // Array property: distribution_type, type: String_ARRAY
        .def_property("distribution_type",
            [](const CPP_beam_init &self) {
                // Get numpy array from String_ARRAY
                const auto& arr = self.distribution_type;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set distribution_type from numpy array
                
                return arr;
    
            },
            "distribution type (in x-px, y-py, and z-pz planes)")
        // Array property: spin, type: Real_ARRAY
        .def_property("spin",
            [](const CPP_beam_init &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.spin;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set spin from numpy array
                
                return arr;
    
            },
            "Spin (x, y, z)")
        // Array property: ellipse, type: CPP_ellipse_beam_init_ARRAY
        .def_property("ellipse",
            [](const CPP_beam_init &self) {
                // Get list of struct objects
                
                return self.ellipse;
                
            },
            [](CPP_beam_init &self, py::object obj) {
                // Set ellipse from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.ellipse;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_ellipse_beam_init>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ellipse_beam_init objects");
                // }
                
            },
            "Ellipse beam distribution")
        .def_property_readonly("kv",
            [](const CPP_beam_init &self) { return self.kv; },
            "KV beam distribution")
        // Array property: grid, type: CPP_grid_beam_init_ARRAY
        .def_property("grid",
            [](const CPP_beam_init &self) {
                // Get list of struct objects
                
                return self.grid;
                
            },
            [](CPP_beam_init &self, py::object obj) {
                // Set grid from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.grid;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_grid_beam_init>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_grid_beam_init objects");
                // }
                
            },
            "Grid beam distribution")
        // Array property: center_jitter, type: Real_ARRAY
        .def_property("center_jitter",
            [](const CPP_beam_init &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.center_jitter;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set center_jitter from numpy array
                
                return arr;
    
            },
            "Bunch center rms jitter")
        // Array property: emit_jitter, type: Real_ARRAY
        .def_property("emit_jitter",
            [](const CPP_beam_init &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.emit_jitter;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set emit_jitter from numpy array
                
                return arr;
    
            },
            "a and b bunch emittance rms jitter normalized to emittance")
        .def_property_readonly("sig_z_jitter",
            [](const CPP_beam_init &self) { return self.sig_z_jitter; },
            "bunch length RMS jitter")
        .def_property_readonly("sig_pz_jitter",
            [](const CPP_beam_init &self) { return self.sig_pz_jitter; },
            "RMS pz spread jitter")
        .def_property_readonly("n_particle",
            [](const CPP_beam_init &self) { return self.n_particle; },
            "Number of particles per bunch.")
        .def_property_readonly("renorm_center",
            [](const CPP_beam_init &self) { return self.renorm_center; },
            "Renormalize centroid?")
        .def_property_readonly("renorm_sigma",
            [](const CPP_beam_init &self) { return self.renorm_sigma; },
            "Renormalize sigma?")
        .def_property_readonly("random_engine",
            [](const CPP_beam_init &self) { return self.random_engine; },
            "Or 'quasi'. Random number engine to use.")
        .def_property_readonly("random_gauss_converter",
            [](const CPP_beam_init &self) { return self.random_gauss_converter; },
            "Property from Fortran struct")
        .def_property_readonly("random_sigma_cutoff",
            [](const CPP_beam_init &self) { return self.random_sigma_cutoff; },
            "Cut-off in sigmas.")
        .def_property_readonly("a_norm_emit",
            [](const CPP_beam_init &self) { return self.a_norm_emit; },
            "a-mode normalized emittance (emit * beta * gamma)")
        .def_property_readonly("b_norm_emit",
            [](const CPP_beam_init &self) { return self.b_norm_emit; },
            "b-mode normalized emittance (emit * beta * gamma)")
        .def_property_readonly("a_emit",
            [](const CPP_beam_init &self) { return self.a_emit; },
            "a-mode emittance")
        .def_property_readonly("b_emit",
            [](const CPP_beam_init &self) { return self.b_emit; },
            "b-mode emittance")
        .def_property_readonly("dpz_dz",
            [](const CPP_beam_init &self) { return self.dpz_dz; },
            "Correlation of Pz with long position.")
        // Array property: center, type: Real_ARRAY
        .def_property("center",
            [](const CPP_beam_init &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.center;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set center from numpy array
                
                return arr;
    
            },
            "Bench phase space center offset relative to reference.")
        .def_property_readonly("t_offset",
            [](const CPP_beam_init &self) { return self.t_offset; },
            "Time center offset")
        .def_property_readonly("dt_bunch",
            [](const CPP_beam_init &self) { return self.dt_bunch; },
            "Time between bunches.")
        .def_property_readonly("sig_z",
            [](const CPP_beam_init &self) { return self.sig_z; },
            "Z sigma in m.")
        .def_property_readonly("sig_pz",
            [](const CPP_beam_init &self) { return self.sig_pz; },
            "pz sigma")
        .def_property_readonly("bunch_charge",
            [](const CPP_beam_init &self) { return self.bunch_charge; },
            "charge (Coul) in a bunch.")
        .def_property_readonly("n_bunch",
            [](const CPP_beam_init &self) { return self.n_bunch; },
            "Number of bunches.")
        .def_property_readonly("ix_turn",
            [](const CPP_beam_init &self) { return self.ix_turn; },
            "Turn index used to adjust particles time if needed.")
        .def_property_readonly("species",
            [](const CPP_beam_init &self) { return self.species; },
            "'positron', etc. '' => use referece particle.")
        .def_property_readonly("full_6d_coupling_calc",
            [](const CPP_beam_init &self) { return self.full_6d_coupling_calc; },
            "Use V from 6x6 1-turn mat to match distribution?")
        .def_property_readonly("use_particle_start",
            [](const CPP_beam_init &self) { return self.use_particle_start; },
            "Use lat%particle_start instead of beam_init%center, %spin?")
        .def_property_readonly("use_t_coords",
            [](const CPP_beam_init &self) { return self.use_t_coords; },
            "If true, the distributions will be taken as in t-coordinates")
        .def_property_readonly("use_z_as_t",
            [](const CPP_beam_init &self) { return self.use_z_as_t; },
            "Only used if  use_t_coords = .true.")
        .def_property_readonly("file_name",
            [](const CPP_beam_init &self) { return self.file_name; },
            "OLD!! DO NOT USE!!")
        ;

    py::class_<CPP_lat_param>(m, "lat_param", "Fortran struct: lat_param_struct")
        .def(py::init<>())
        .def_property_readonly("n_part",
            [](const CPP_lat_param &self) { return self.n_part; },
            "Particles/bunch (for BeamBeam elements).")
        .def_property_readonly("total_length",
            [](const CPP_lat_param &self) { return self.total_length; },
            "total_length of branch. Warning: branch may not start at s = 0.")
        .def_property_readonly("unstable_factor",
            [](const CPP_lat_param &self) { return self.unstable_factor; },
            "If positive: Growth rate/turn if unstable in closed branches or")
        // Array property: t1_with_rf, type: Real_MATRIX
        .def_property("t1_with_rf",
            [](const CPP_lat_param &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.t1_with_rf;
                
                return py::str("not implemented");
        
            },
            [](CPP_lat_param &self, py::array arr) {
                // Set t1_with_rf from numpy array
                
                return arr;
    
            },
            "Full 1-turn matrix with RF on.")
        // Array property: t1_no_rf, type: Real_MATRIX
        .def_property("t1_no_rf",
            [](const CPP_lat_param &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.t1_no_rf;
                
                return py::str("not implemented");
        
            },
            [](CPP_lat_param &self, py::array arr) {
                // Set t1_no_rf from numpy array
                
                return arr;
    
            },
            "Full 1-turn matrix with RF off.")
        .def_property_readonly("spin_tune",
            [](const CPP_lat_param &self) { return self.spin_tune; },
            "Closed orbit spin tune.")
        .def_property_readonly("particle",
            [](const CPP_lat_param &self) { return self.particle; },
            "Reference particle: positron$, electron$, etc.")
        .def_property_readonly("default_tracking_species",
            [](const CPP_lat_param &self) { return self.default_tracking_species; },
            "Default particle type to use in tracking.")
        .def_property_readonly("geometry",
            [](const CPP_lat_param &self) { return self.geometry; },
            "open$ or closed$")
        .def_property_readonly("ixx",
            [](const CPP_lat_param &self) { return self.ixx; },
            "Integer for general use")
        .def_property_readonly("stable",
            [](const CPP_lat_param &self) { return self.stable; },
            "is closed lat stable?")
        .def_property_readonly("live_branch",
            [](const CPP_lat_param &self) { return self.live_branch; },
            "Should tracking be done on the branch?")
        .def_property_readonly("g1_integral",
            [](const CPP_lat_param &self) { return self.g1_integral; },
            "Approximate |g| (bending strength) integral of branch.")
        .def_property_readonly("g2_integral",
            [](const CPP_lat_param &self) { return self.g2_integral; },
            "Approximate g^2 integral of branch.")
        .def_property_readonly("g3_integral",
            [](const CPP_lat_param &self) { return self.g3_integral; },
            "Approximate g^2 integral of branch.")
        .def_property_readonly("bookkeeping_state",
            [](const CPP_lat_param &self) { return self.bookkeeping_state; },
            "Property from Fortran struct")
        .def_property_readonly("beam_init",
            [](const CPP_lat_param &self) { return self.beam_init; },
            "For beam initialization.")
        ;

    py::class_<CPP_mode_info>(m, "mode_info", "Fortran struct: mode_info_struct")
        .def(py::init<>())
        .def_property_readonly("stable",
            [](const CPP_mode_info &self) { return self.stable; },
            "Is the mode stable?")
        .def_property_readonly("tune",
            [](const CPP_mode_info &self) { return self.tune; },
            "'fractional' tune in radians")
        .def_property_readonly("emit",
            [](const CPP_mode_info &self) { return self.emit; },
            "Emittance (unnormalized).")
        .def_property_readonly("chrom",
            [](const CPP_mode_info &self) { return self.chrom; },
            "Chromaticity.")
        .def_property_readonly("sigma",
            [](const CPP_mode_info &self) { return self.sigma; },
            "Beam size.")
        .def_property_readonly("sigmap",
            [](const CPP_mode_info &self) { return self.sigmap; },
            "Beam divergence.")
        ;

    py::class_<CPP_pre_tracker>(m, "pre_tracker", "Fortran struct: pre_tracker_struct")
        .def(py::init<>())
        .def_property_readonly("who",
            [](const CPP_pre_tracker &self) { return self.who; },
            "Can be opal$, or impactt$")
        .def_property_readonly("ix_ele_start",
            [](const CPP_pre_tracker &self) { return self.ix_ele_start; },
            "Property from Fortran struct")
        .def_property_readonly("ix_ele_end",
            [](const CPP_pre_tracker &self) { return self.ix_ele_end; },
            "Property from Fortran struct")
        .def_property_readonly("input_file",
            [](const CPP_pre_tracker &self) { return self.input_file; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_anormal_mode>(m, "anormal_mode", "Fortran struct: anormal_mode_struct")
        .def(py::init<>())
        .def_property_readonly("emittance",
            [](const CPP_anormal_mode &self) { return self.emittance; },
            "Beam emittance (unnormalized). Includes vertical photon opening angle.")
        .def_property_readonly("emittance_no_vert",
            [](const CPP_anormal_mode &self) { return self.emittance_no_vert; },
            "Unnormalized beam emittance without the vertical photon opening angle taken into account.")
        // Array property: synch_int, type: Real_ARRAY
        .def_property("synch_int",
            [](const CPP_anormal_mode &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.synch_int;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_anormal_mode &self, py::array arr) {
                // Set synch_int from numpy array
                
                return arr;
    
            },
            "Synchrotron integrals")
        .def_property_readonly("j_damp",
            [](const CPP_anormal_mode &self) { return self.j_damp; },
            "damping partition number")
        .def_property_readonly("alpha_damp",
            [](const CPP_anormal_mode &self) { return self.alpha_damp; },
            "damping per turn")
        .def_property_readonly("chrom",
            [](const CPP_anormal_mode &self) { return self.chrom; },
            "Chromaticity")
        .def_property_readonly("tune",
            [](const CPP_anormal_mode &self) { return self.tune; },
            "'Fractional' tune in radians")
        ;

    py::class_<CPP_linac_normal_mode>(m, "linac_normal_mode", "Fortran struct: linac_normal_mode_struct")
        .def(py::init<>())
        .def_property_readonly("i2_e4",
            [](const CPP_linac_normal_mode &self) { return self.i2_e4; },
            "Integral: g^2 * gamma^4")
        .def_property_readonly("i3_e7",
            [](const CPP_linac_normal_mode &self) { return self.i3_e7; },
            "Integral: g^3 * gamma^7")
        .def_property_readonly("i5a_e6",
            [](const CPP_linac_normal_mode &self) { return self.i5a_e6; },
            "Integral: (g^3 * H_a) * gamma^6")
        .def_property_readonly("i5b_e6",
            [](const CPP_linac_normal_mode &self) { return self.i5b_e6; },
            "Integral: (g^3 * H_b) * gamma^6")
        .def_property_readonly("sig_e1",
            [](const CPP_linac_normal_mode &self) { return self.sig_e1; },
            "Energy spread after 1 pass (eV)")
        .def_property_readonly("a_emittance_end",
            [](const CPP_linac_normal_mode &self) { return self.a_emittance_end; },
            "a mode emittance at end of linac")
        .def_property_readonly("b_emittance_end",
            [](const CPP_linac_normal_mode &self) { return self.b_emittance_end; },
            "b mode emittance at end of linac")
        ;

    py::class_<CPP_normal_modes>(m, "normal_modes", "Fortran struct: normal_modes_struct")
        .def(py::init<>())
        // Array property: synch_int, type: Real_ARRAY
        .def_property("synch_int",
            [](const CPP_normal_modes &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.synch_int;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_normal_modes &self, py::array arr) {
                // Set synch_int from numpy array
                
                return arr;
    
            },
            "Synchrotron integrals I0, I1, I2, and I3")
        .def_property_readonly("sige_e",
            [](const CPP_normal_modes &self) { return self.sige_e; },
            "SigmaE/E")
        .def_property_readonly("sig_z",
            [](const CPP_normal_modes &self) { return self.sig_z; },
            "Sigma_Z")
        .def_property_readonly("e_loss",
            [](const CPP_normal_modes &self) { return self.e_loss; },
            "Energy loss / turn (eV)")
        .def_property_readonly("rf_voltage",
            [](const CPP_normal_modes &self) { return self.rf_voltage; },
            "Total rfcavity voltage (eV)")
        .def_property_readonly("pz_aperture",
            [](const CPP_normal_modes &self) { return self.pz_aperture; },
            "pz aperture limit. Used with Touschek calculations.")
        .def_property_readonly("pz_average",
            [](const CPP_normal_modes &self) { return self.pz_average; },
            "Average over branch due to damping.")
        .def_property_readonly("momentum_compaction",
            [](const CPP_normal_modes &self) { return self.momentum_compaction; },
            "Property from Fortran struct")
        .def_property_readonly("dpz_damp",
            [](const CPP_normal_modes &self) { return self.dpz_damp; },
            "Change in pz without RF")
        .def_property_readonly("a",
            [](const CPP_normal_modes &self) { return self.a; },
            "Property from Fortran struct")
        .def_property_readonly("b",
            [](const CPP_normal_modes &self) { return self.b; },
            "Property from Fortran struct")
        .def_property_readonly("z",
            [](const CPP_normal_modes &self) { return self.z; },
            "Property from Fortran struct")
        .def_property_readonly("lin",
            [](const CPP_normal_modes &self) { return self.lin; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_em_field>(m, "em_field", "Fortran struct: em_field_struct")
        .def(py::init<>())
        // Array property: e, type: Real_ARRAY
        .def_property("e",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.e;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_em_field &self, py::array arr) {
                // Set e from numpy array
                
                return arr;
    
            },
            "electric field.")
        // Array property: b, type: Real_ARRAY
        .def_property("b",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.b;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_em_field &self, py::array arr) {
                // Set b from numpy array
                
                return arr;
    
            },
            "magnetic field.")
        // Array property: de, type: Real_MATRIX
        .def_property("de",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.de;
                
                return py::str("not implemented");
        
            },
            [](CPP_em_field &self, py::array arr) {
                // Set de from numpy array
                
                return arr;
    
            },
            "electric field gradient.")
        // Array property: db, type: Real_MATRIX
        .def_property("db",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.db;
                
                return py::str("not implemented");
        
            },
            [](CPP_em_field &self, py::array arr) {
                // Set db from numpy array
                
                return arr;
    
            },
            "magnetic field gradient.")
        .def_property_readonly("phi",
            [](const CPP_em_field &self) { return self.phi; },
            "Electric scalar potential.")
        .def_property_readonly("phi_b",
            [](const CPP_em_field &self) { return self.phi_b; },
            "Magnetic scalar potential.")
        // Array property: a, type: Real_ARRAY
        .def_property("a",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.a;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_em_field &self, py::array arr) {
                // Set a from numpy array
                
                return arr;
    
            },
            "Magnetic vector potential.")
        ;

    py::class_<CPP_strong_beam>(m, "strong_beam", "Fortran struct: strong_beam_struct")
        .def(py::init<>())
        .def_property_readonly("ix_slice",
            [](const CPP_strong_beam &self) { return self.ix_slice; },
            "0 -> at element center and not at slice.")
        .def_property_readonly("x_center",
            [](const CPP_strong_beam &self) { return self.x_center; },
            "Strong beam slice center.")
        .def_property_readonly("y_center",
            [](const CPP_strong_beam &self) { return self.y_center; },
            "Strong beam slice center.")
        .def_property_readonly("x_sigma",
            [](const CPP_strong_beam &self) { return self.x_sigma; },
            "Strong beam slice sigma.")
        .def_property_readonly("y_sigma",
            [](const CPP_strong_beam &self) { return self.y_sigma; },
            "Strong beam slice sigma.")
        .def_property_readonly("dx",
            [](const CPP_strong_beam &self) { return self.dx; },
            "Particle - beam slice distance.")
        .def_property_readonly("dy",
            [](const CPP_strong_beam &self) { return self.dy; },
            "Particle - beam slice distance.")
        ;

    py::class_<CPP_track_point>(m, "track_point", "Fortran struct: track_point_struct")
        .def(py::init<>())
        .def_property_readonly("s_body",
            [](const CPP_track_point &self) { return self.s_body; },
            "Longitudinal coords within the element body.")
        .def_property_readonly("orb",
            [](const CPP_track_point &self) { return self.orb; },
            "An array of track points indexed from 0 (%orb(0:)).")
        .def_property_readonly("field",
            [](const CPP_track_point &self) { return self.field; },
            "An array of em fields indexed from 0 (%field(0:)).")
        .def_property_readonly("strong_beam",
            [](const CPP_track_point &self) { return self.strong_beam; },
            "Strong beam info for beambeam element.")
        // Array property: vec0, type: Real_ARRAY
        .def_property("vec0",
            [](const CPP_track_point &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.vec0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_track_point &self, py::array arr) {
                // Set vec0 from numpy array
                
                return arr;
    
            },
            "0th order part of xfer map from the beginning.")
        // Array property: mat6, type: Real_MATRIX
        .def_property("mat6",
            [](const CPP_track_point &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.mat6;
                
                return py::str("not implemented");
        
            },
            [](CPP_track_point &self, py::array arr) {
                // Set mat6 from numpy array
                
                return arr;
    
            },
            "1st order part of xfer map (transfer matrix).")
        ;

    py::class_<CPP_track>(m, "track", "Fortran struct: track_struct")
        .def(py::init<>())
        // Array property: pt, type: CPP_track_point_ARRAY
        .def_property("pt",
            [](const CPP_track &self) {
                // Get list of struct objects
                
                return self.pt;
                
            },
            [](CPP_track &self, py::object obj) {
                // Set pt from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.pt;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_track_point>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_track_point objects");
                // }
                
            },
            "Array of track points indexed from 0.")
        .def_property_readonly("ds_save",
            [](const CPP_track &self) { return self.ds_save; },
            "Min distance between points. Not positive => Save at all points.")
        .def_property_readonly("n_pt",
            [](const CPP_track &self) { return self.n_pt; },
            "Track upper bound for %pt(0:) array.")
        .def_property_readonly("n_bad",
            [](const CPP_track &self) { return self.n_bad; },
            "Number of 'bad' steps where the step length was shortened.")
        .def_property_readonly("n_ok",
            [](const CPP_track &self) { return self.n_ok; },
            "Number of 'good' steps where the step length was not shortened.")
        ;

    py::class_<CPP_space_charge_common>(m, "space_charge_common", "Fortran struct: space_charge_common_struct")
        .def(py::init<>())
        .def_property_readonly("ds_track_step",
            [](const CPP_space_charge_common &self) { return self.ds_track_step; },
            "CSR tracking step size")
        .def_property_readonly("dt_track_step",
            [](const CPP_space_charge_common &self) { return self.dt_track_step; },
            "Time Runge kutta initial step.")
        .def_property_readonly("cathode_strength_cutoff",
            [](const CPP_space_charge_common &self) { return self.cathode_strength_cutoff; },
            "Cutoff for the cathode field calc.")
        .def_property_readonly("rel_tol_tracking",
            [](const CPP_space_charge_common &self) { return self.rel_tol_tracking; },
            "Relative tolerance for tracking.")
        .def_property_readonly("abs_tol_tracking",
            [](const CPP_space_charge_common &self) { return self.abs_tol_tracking; },
            "Absolute tolerance for tracking.")
        .def_property_readonly("beam_chamber_height",
            [](const CPP_space_charge_common &self) { return self.beam_chamber_height; },
            "Used in shielding calculation.")
        .def_property_readonly("lsc_sigma_cutoff",
            [](const CPP_space_charge_common &self) { return self.lsc_sigma_cutoff; },
            "Cutoff for the 1-dim longitudinal SC calc.")
        .def_property_readonly("particle_sigma_cutoff",
            [](const CPP_space_charge_common &self) { return self.particle_sigma_cutoff; },
            "3D SC calc cutoff for particles with (x,y,z) position far from the center.")
        // Array property: space_charge_mesh_size, type: Int_ARRAY
        .def_property("space_charge_mesh_size",
            [](const CPP_space_charge_common &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.space_charge_mesh_size;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_space_charge_common &self, py::array arr) {
                // Set space_charge_mesh_size from numpy array
                
                return arr;
    
            },
            "Gird size for fft_3d space charge calc.")
        // Array property: csr3d_mesh_size, type: Int_ARRAY
        .def_property("csr3d_mesh_size",
            [](const CPP_space_charge_common &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.csr3d_mesh_size;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_space_charge_common &self, py::array arr) {
                // Set csr3d_mesh_size from numpy array
                
                return arr;
    
            },
            "Gird size for CSR.")
        .def_property_readonly("n_bin",
            [](const CPP_space_charge_common &self) { return self.n_bin; },
            "Number of bins used")
        .def_property_readonly("particle_bin_span",
            [](const CPP_space_charge_common &self) { return self.particle_bin_span; },
            "Longitudinal particle length / dz_bin")
        .def_property_readonly("n_shield_images",
            [](const CPP_space_charge_common &self) { return self.n_shield_images; },
            "Chamber wall shielding. 0 = no shielding.")
        .def_property_readonly("sc_min_in_bin",
            [](const CPP_space_charge_common &self) { return self.sc_min_in_bin; },
            "Minimum number of particles in a bin for sigmas to be valid.")
        .def_property_readonly("lsc_kick_transverse_dependence",
            [](const CPP_space_charge_common &self) { return self.lsc_kick_transverse_dependence; },
            "Property from Fortran struct")
        .def_property_readonly("debug",
            [](const CPP_space_charge_common &self) { return self.debug; },
            "Property from Fortran struct")
        .def_property_readonly("diagnostic_output_file",
            [](const CPP_space_charge_common &self) { return self.diagnostic_output_file; },
            "If non-blank write a diagnostic (EG wake) file")
        ;

    py::class_<CPP_bmad_common>(m, "bmad_common", "Fortran struct: bmad_common_struct")
        .def(py::init<>())
        .def_property_readonly("max_aperture_limit",
            [](const CPP_bmad_common &self) { return self.max_aperture_limit; },
            "Max Aperture.")
        // Array property: d_orb, type: Real_ARRAY
        .def_property("d_orb",
            [](const CPP_bmad_common &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.d_orb;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_bmad_common &self, py::array arr) {
                // Set d_orb from numpy array
                
                return arr;
    
            },
            "Orbit deltas for the mat6 via tracking calc.")
        .def_property_readonly("default_ds_step",
            [](const CPP_bmad_common &self) { return self.default_ds_step; },
            "Default integration step for eles without an explicit step calc.")
        .def_property_readonly("significant_length",
            [](const CPP_bmad_common &self) { return self.significant_length; },
            "meter")
        .def_property_readonly("rel_tol_tracking",
            [](const CPP_bmad_common &self) { return self.rel_tol_tracking; },
            "Closed orbit relative tolerance.")
        .def_property_readonly("abs_tol_tracking",
            [](const CPP_bmad_common &self) { return self.abs_tol_tracking; },
            "Closed orbit absolute tolerance.")
        .def_property_readonly("rel_tol_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.rel_tol_adaptive_tracking; },
            "Runge-Kutta tracking relative tolerance.")
        .def_property_readonly("abs_tol_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.abs_tol_adaptive_tracking; },
            "Runge-Kutta tracking absolute tolerance.")
        .def_property_readonly("init_ds_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.init_ds_adaptive_tracking; },
            "Initial step size")
        .def_property_readonly("min_ds_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.min_ds_adaptive_tracking; },
            "Min step size to take.")
        .def_property_readonly("fatal_ds_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.fatal_ds_adaptive_tracking; },
            "If actual step size is below this particle is lost.")
        .def_property_readonly("autoscale_amp_abs_tol",
            [](const CPP_bmad_common &self) { return self.autoscale_amp_abs_tol; },
            "Autoscale absolute amplitude tolerance (eV).")
        .def_property_readonly("autoscale_amp_rel_tol",
            [](const CPP_bmad_common &self) { return self.autoscale_amp_rel_tol; },
            "Autoscale relative amplitude tolerance")
        .def_property_readonly("autoscale_phase_tol",
            [](const CPP_bmad_common &self) { return self.autoscale_phase_tol; },
            "Autoscale phase tolerance.")
        .def_property_readonly("electric_dipole_moment",
            [](const CPP_bmad_common &self) { return self.electric_dipole_moment; },
            "Particle's EDM. Call set_ptc to transfer value to PTC.")
        .def_property_readonly("synch_rad_scale",
            [](const CPP_bmad_common &self) { return self.synch_rad_scale; },
            "Synch radiation kick scale. 1 => normal, 0 => no kicks.")
        .def_property_readonly("sad_eps_scale",
            [](const CPP_bmad_common &self) { return self.sad_eps_scale; },
            "Used in sad_mult step length calc.")
        .def_property_readonly("sad_amp_max",
            [](const CPP_bmad_common &self) { return self.sad_amp_max; },
            "Used in sad_mult step length calc.")
        .def_property_readonly("sad_n_div_max",
            [](const CPP_bmad_common &self) { return self.sad_n_div_max; },
            "Used in sad_mult step length calc.")
        .def_property_readonly("taylor_order",
            [](const CPP_bmad_common &self) { return self.taylor_order; },
            "Taylor order to use. 0 -> default = ptc_private%taylor_order_saved.")
        .def_property_readonly("runge_kutta_order",
            [](const CPP_bmad_common &self) { return self.runge_kutta_order; },
            "Runge Kutta order.")
        .def_property_readonly("default_integ_order",
            [](const CPP_bmad_common &self) { return self.default_integ_order; },
            "PTC integration order.")
        .def_property_readonly("max_num_runge_kutta_step",
            [](const CPP_bmad_common &self) { return self.max_num_runge_kutta_step; },
            "Maximum number of RK steps before particle is considered lost.")
        .def_property_readonly("rf_phase_below_transition_ref",
            [](const CPP_bmad_common &self) { return self.rf_phase_below_transition_ref; },
            "Autoscale uses below transition stable point for RFCavities?")
        .def_property_readonly("sr_wakes_on",
            [](const CPP_bmad_common &self) { return self.sr_wakes_on; },
            "Short range wakefields?")
        .def_property_readonly("lr_wakes_on",
            [](const CPP_bmad_common &self) { return self.lr_wakes_on; },
            "Long range wakefields")
        .def_property_readonly("auto_bookkeeper",
            [](const CPP_bmad_common &self) { return self.auto_bookkeeper; },
            "Automatic bookkeeping?")
        .def_property_readonly("high_energy_space_charge_on",
            [](const CPP_bmad_common &self) { return self.high_energy_space_charge_on; },
            "High energy space charge effect switch.")
        .def_property_readonly("csr_and_space_charge_on",
            [](const CPP_bmad_common &self) { return self.csr_and_space_charge_on; },
            "Space charge switch.")
        .def_property_readonly("spin_tracking_on",
            [](const CPP_bmad_common &self) { return self.spin_tracking_on; },
            "spin tracking?")
        .def_property_readonly("spin_sokolov_ternov_flipping_on",
            [](const CPP_bmad_common &self) { return self.spin_sokolov_ternov_flipping_on; },
            "Spin flipping during synchrotron radiation emission?")
        .def_property_readonly("radiation_damping_on",
            [](const CPP_bmad_common &self) { return self.radiation_damping_on; },
            "Radiation damping toggle.")
        .def_property_readonly("radiation_zero_average",
            [](const CPP_bmad_common &self) { return self.radiation_zero_average; },
            "Shift damping to be zero on the zero orbit to get rid of sawtooth?")
        .def_property_readonly("radiation_fluctuations_on",
            [](const CPP_bmad_common &self) { return self.radiation_fluctuations_on; },
            "Radiation fluctuations toggle.")
        .def_property_readonly("conserve_taylor_maps",
            [](const CPP_bmad_common &self) { return self.conserve_taylor_maps; },
            "Enable bookkeeper to set ele%taylor_map_includes_offsets = F?")
        .def_property_readonly("absolute_time_tracking",
            [](const CPP_bmad_common &self) { return self.absolute_time_tracking; },
            "Absolute or relative time tracking?")
        .def_property_readonly("absolute_time_ref_shift",
            [](const CPP_bmad_common &self) { return self.absolute_time_ref_shift; },
            "Apply reference time shift when using absolute time tracking?")
        .def_property_readonly("convert_to_kinetic_momentum",
            [](const CPP_bmad_common &self) { return self.convert_to_kinetic_momentum; },
            "Cancel kicks due to finite vector potential when doing symplectic tracking?")
        .def_property_readonly("aperture_limit_on",
            [](const CPP_bmad_common &self) { return self.aperture_limit_on; },
            "use apertures in tracking?")
        .def_property_readonly("debug",
            [](const CPP_bmad_common &self) { return self.debug; },
            "Used for code debugging.")
        ;

    py::class_<CPP_rad_int1>(m, "rad_int1", "Fortran struct: rad_int1_struct")
        .def(py::init<>())
        .def_property_readonly("i0",
            [](const CPP_rad_int1 &self) { return self.i0; },
            "Property from Fortran struct")
        .def_property_readonly("i1",
            [](const CPP_rad_int1 &self) { return self.i1; },
            "Property from Fortran struct")
        .def_property_readonly("i2",
            [](const CPP_rad_int1 &self) { return self.i2; },
            "Property from Fortran struct")
        .def_property_readonly("i3",
            [](const CPP_rad_int1 &self) { return self.i3; },
            "Property from Fortran struct")
        .def_property_readonly("i4a",
            [](const CPP_rad_int1 &self) { return self.i4a; },
            "Property from Fortran struct")
        .def_property_readonly("i4b",
            [](const CPP_rad_int1 &self) { return self.i4b; },
            "Property from Fortran struct")
        .def_property_readonly("i4z",
            [](const CPP_rad_int1 &self) { return self.i4z; },
            "Property from Fortran struct")
        .def_property_readonly("i5a",
            [](const CPP_rad_int1 &self) { return self.i5a; },
            "Property from Fortran struct")
        .def_property_readonly("i5b",
            [](const CPP_rad_int1 &self) { return self.i5b; },
            "Property from Fortran struct")
        .def_property_readonly("i6b",
            [](const CPP_rad_int1 &self) { return self.i6b; },
            "Property from Fortran struct")
        .def_property_readonly("lin_i2_e4",
            [](const CPP_rad_int1 &self) { return self.lin_i2_e4; },
            "Property from Fortran struct")
        .def_property_readonly("lin_i3_e7",
            [](const CPP_rad_int1 &self) { return self.lin_i3_e7; },
            "Property from Fortran struct")
        .def_property_readonly("lin_i5a_e6",
            [](const CPP_rad_int1 &self) { return self.lin_i5a_e6; },
            "Property from Fortran struct")
        .def_property_readonly("lin_i5b_e6",
            [](const CPP_rad_int1 &self) { return self.lin_i5b_e6; },
            "Property from Fortran struct")
        .def_property_readonly("lin_norm_emit_a",
            [](const CPP_rad_int1 &self) { return self.lin_norm_emit_a; },
            "Running sum")
        .def_property_readonly("lin_norm_emit_b",
            [](const CPP_rad_int1 &self) { return self.lin_norm_emit_b; },
            "Running sum")
        .def_property_readonly("lin_sig_e",
            [](const CPP_rad_int1 &self) { return self.lin_sig_e; },
            "Running sum")
        .def_property_readonly("n_steps",
            [](const CPP_rad_int1 &self) { return self.n_steps; },
            "number of qromb steps needed")
        ;

    py::class_<CPP_rad_int_branch>(m, "rad_int_branch", "Fortran struct: rad_int_branch_struct")
        .def(py::init<>())
        // Array property: ele, type: CPP_rad_int1_ARRAY
        .def_property("ele",
            [](const CPP_rad_int_branch &self) {
                // Get list of struct objects
                
                return self.ele;
                
            },
            [](CPP_rad_int_branch &self, py::object obj) {
                // Set ele from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.ele;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_rad_int1>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_rad_int1 objects");
                // }
                
            },
            "Array is indexed from 0")
        ;

    py::class_<CPP_rad_int_all_ele>(m, "rad_int_all_ele", "Fortran struct: rad_int_all_ele_struct")
        .def(py::init<>())
        // Array property: branch, type: CPP_rad_int_branch_ARRAY
        .def_property("branch",
            [](const CPP_rad_int_all_ele &self) {
                // Get list of struct objects
                
                return self.branch;
                
            },
            [](CPP_rad_int_all_ele &self, py::object obj) {
                // Set branch from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.branch;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_rad_int_branch>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_rad_int_branch objects");
                // }
                
            },
            "Array is indexed from 0")
        ;

    py::class_<CPP_ele>(m, "ele", "Fortran struct: ele_struct")
        // TODO: .def(py::init<const int key_ = 0>())
        .def(py::init<>())
        .def_property_readonly("name",
            [](const CPP_ele &self) { return self.name; },
            "name of element.")
        .def_property_readonly("type",
            [](const CPP_ele &self) { return self.type; },
            "type name.")
        .def_property_readonly("alias",
            [](const CPP_ele &self) { return self.alias; },
            "Another name.")
        .def_property_readonly("component_name",
            [](const CPP_ele &self) { return self.component_name; },
            "Used by overlays, multipass patch, etc.")
        .def_property_readonly("descrip",
            [](const CPP_ele &self) { return self.descrip ? py::cast(*self.descrip) : py::none(); },
            "Description string.")
        .def_property_readonly("a",
            [](const CPP_ele &self) { return self.a; },
            "Twiss parameters at end of element")
        .def_property_readonly("b",
            [](const CPP_ele &self) { return self.b; },
            "Twiss parameters at end of element")
        .def_property_readonly("z",
            [](const CPP_ele &self) { return self.z; },
            "Twiss parameters at end of element")
        .def_property_readonly("x",
            [](const CPP_ele &self) { return self.x; },
            "Projected dispersions.")
        .def_property_readonly("y",
            [](const CPP_ele &self) { return self.y; },
            "Projected dispersions.")
        .def_property_readonly("ac_kick",
            [](const CPP_ele &self) { return self.ac_kick; },
            "ac_kicker element parameters.")
        .def_property_readonly("bookkeeping_state",
            [](const CPP_ele &self) { return self.bookkeeping_state; },
            "Attribute bookkeeping")
        .def_property_readonly("control",
            [](const CPP_ele &self) { return self.control; },
            "group & overlay variables.")
        .def_property_readonly("floor",
            [](const CPP_ele &self) { return self.floor; },
            "Property from Fortran struct")
        .def_property_readonly("high_energy_space_charge",
            [](const CPP_ele &self) { return self.high_energy_space_charge; },
            "Property from Fortran struct")
        .def_property_readonly("mode3",
            [](const CPP_ele &self) { return self.mode3; },
            "6D normal mode structure.")
        .def_property_readonly("photon",
            [](const CPP_ele &self) { return self.photon; },
            "Property from Fortran struct")
        .def_property_readonly("rad_map",
            [](const CPP_ele &self) { return self.rad_map; },
            "Radiation kick parameters")
        // Array property: taylor, type: CPP_taylor_ARRAY
        .def_property("taylor",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                return self.taylor;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set taylor from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.taylor;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_taylor>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_taylor objects");
                // }
                
            },
            "Phase space Taylor map.")
        // Array property: spin_taylor_ref_orb_in, type: Real_ARRAY
        .def_property("spin_taylor_ref_orb_in",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.spin_taylor_ref_orb_in;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set spin_taylor_ref_orb_in from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        // Array property: spin_taylor, type: CPP_taylor_ARRAY
        .def_property("spin_taylor",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                return self.spin_taylor;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set spin_taylor from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.spin_taylor;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_taylor>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_taylor objects");
                // }
                
            },
            "Quaternion Spin Taylor map.")
        .def_property_readonly("wake",
            [](const CPP_ele &self) { return self.wake; },
            "Wakes")
        // Array property: wall3d, type: CPP_wall3d_ARRAY
        .def_property("wall3d",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                return self.wall3d;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set wall3d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.wall3d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_wall3d>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wall3d objects");
                // }
                
            },
            "Chamber or capillary wall")
        // Array property: cartesian_map, type: CPP_cartesian_map_ARRAY
        .def_property("cartesian_map",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                return self.cartesian_map;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set cartesian_map from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.cartesian_map;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_cartesian_map>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_cartesian_map objects");
                // }
                
            },
            "Used to define E/M fields")
        // Array property: cylindrical_map, type: CPP_cylindrical_map_ARRAY
        .def_property("cylindrical_map",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                return self.cylindrical_map;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set cylindrical_map from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.cylindrical_map;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_cylindrical_map>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_cylindrical_map objects");
                // }
                
            },
            "Used to define E/M fields")
        // Array property: gen_grad_map, type: CPP_gen_grad_map_ARRAY
        .def_property("gen_grad_map",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                return self.gen_grad_map;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set gen_grad_map from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.gen_grad_map;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_gen_grad_map>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_gen_grad_map objects");
                // }
                
            },
            "Used to define E/M fields.")
        // Array property: grid_field, type: CPP_grid_field_ARRAY
        .def_property("grid_field",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                return self.grid_field;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set grid_field from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.grid_field;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_grid_field>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_grid_field objects");
                // }
                
            },
            "Used to define E/M fields.")
        .def_property_readonly("map_ref_orb_in",
            [](const CPP_ele &self) { return self.map_ref_orb_in; },
            "Entrance end transfer map ref orbit")
        .def_property_readonly("map_ref_orb_out",
            [](const CPP_ele &self) { return self.map_ref_orb_out; },
            "Exit end transfer map ref orbit")
        .def_property_readonly("time_ref_orb_in",
            [](const CPP_ele &self) { return self.time_ref_orb_in; },
            "Reference orbit at entrance end for ref_time calc.")
        .def_property_readonly("time_ref_orb_out",
            [](const CPP_ele &self) { return self.time_ref_orb_out; },
            "Reference orbit at exit end for ref_time calc.")
        // Array property: value, type: Real_ARRAY
        .def_property("value",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.value;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set value from numpy array
                
                return arr;
    
            },
            "attribute values.")
        // Array property: old_value, type: Real_ARRAY
        .def_property("old_value",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.old_value;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set old_value from numpy array
                
                return arr;
    
            },
            "Used to see if %value(:) array has changed.")
        // Array property: spin_q, type: Real_MATRIX
        .def_property("spin_q",
            [](const CPP_ele &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.spin_q;
                
                return py::str("not implemented");
        
            },
            [](CPP_ele &self, py::array arr) {
                // Set spin_q from numpy array
                
                return arr;
    
            },
            "0th and 1st order Spin transport quaternion.")
        // Array property: vec0, type: Real_ARRAY
        .def_property("vec0",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.vec0;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set vec0 from numpy array
                
                return arr;
    
            },
            "0th order transport vector.")
        // Array property: mat6, type: Real_MATRIX
        .def_property("mat6",
            [](const CPP_ele &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.mat6;
                
                return py::str("not implemented");
        
            },
            [](CPP_ele &self, py::array arr) {
                // Set mat6 from numpy array
                
                return arr;
    
            },
            "1st order transport matrix.")
        // Array property: c_mat, type: Real_MATRIX
        .def_property("c_mat",
            [](const CPP_ele &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.c_mat;
                
                return py::str("not implemented");
        
            },
            [](CPP_ele &self, py::array arr) {
                // Set c_mat from numpy array
                
                return arr;
    
            },
            "2x2 C coupling matrix")
        .def_property_readonly("gamma_c",
            [](const CPP_ele &self) { return self.gamma_c; },
            "gamma associated with C matrix")
        .def_property_readonly("s_start",
            [](const CPP_ele &self) { return self.s_start; },
            "longitudinal ref position at entrance_end")
        .def_property_readonly("s",
            [](const CPP_ele &self) { return self.s; },
            "longitudinal ref position at the exit end.")
        .def_property_readonly("ref_time",
            [](const CPP_ele &self) { return self.ref_time; },
            "Time ref particle passes exit end.")
        // Array property: a_pole, type: Real_ARRAY
        .def_property("a_pole",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.a_pole;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set a_pole from numpy array
                
                return arr;
    
            },
            "knl for multipole elements.")
        // Array property: b_pole, type: Real_ARRAY
        .def_property("b_pole",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.b_pole;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set b_pole from numpy array
                
                return arr;
    
            },
            "tilt for multipole elements.")
        // Array property: a_pole_elec, type: Real_ARRAY
        .def_property("a_pole_elec",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.a_pole_elec;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set a_pole_elec from numpy array
                
                return arr;
    
            },
            "Electrostatic multipoles. ksnl for multipole elements.")
        // Array property: b_pole_elec, type: Real_ARRAY
        .def_property("b_pole_elec",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.b_pole_elec;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set b_pole_elec from numpy array
                
                return arr;
    
            },
            "Electrostatic multipoles.")
        // Array property: custom, type: Real_ARRAY
        .def_property("custom",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.custom;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set custom from numpy array
                
                return arr;
    
            },
            "Custom attributes.")
        // Array property: r, type: Real_TENSOR
        .def_property("r",
            [](const CPP_ele &self) {
                // Get numpy array from Real_TENSOR
                const auto& tensor = self.r;
                
                return py::str("not implemented");
        
            },
            [](CPP_ele &self, py::array arr) {
                // Set r from numpy array
                
                return arr;
    
            },
            "For general use. Not used by Bmad.")
        .def_property_readonly("key",
            [](const CPP_ele &self) { return self.key; },
            "Element class (quadrupole, etc.).")
        .def_property_readonly("sub_key",
            [](const CPP_ele &self) { return self.sub_key; },
            "Records bend input type.")
        .def_property_readonly("ix_ele",
            [](const CPP_ele &self) { return self.ix_ele; },
            "Index in branch ele(0:) array. Set to ix_slice_slave$ = -2 for slice_slave$ elements.")
        .def_property_readonly("ix_branch",
            [](const CPP_ele &self) { return self.ix_branch; },
            "Index in lat%branch(:) array. Note: lat%ele => lat%branch(0).")
        .def_property_readonly("lord_status",
            [](const CPP_ele &self) { return self.lord_status; },
            "Type of lord element this is. overlay_lord$, etc.")
        .def_property_readonly("n_slave",
            [](const CPP_ele &self) { return self.n_slave; },
            "Number of slaves (except field overlap slaves) of this element.")
        .def_property_readonly("n_slave_field",
            [](const CPP_ele &self) { return self.n_slave_field; },
            "Number of field slaves of this element.")
        .def_property_readonly("ix1_slave",
            [](const CPP_ele &self) { return self.ix1_slave; },
            "Pointer index to this element's slaves.")
        .def_property_readonly("slave_status",
            [](const CPP_ele &self) { return self.slave_status; },
            "Type of slave element this is. multipass_slave$, slice_slave$, etc.")
        .def_property_readonly("n_lord",
            [](const CPP_ele &self) { return self.n_lord; },
            "Number of lords (except field overlap and ramper lords).")
        .def_property_readonly("n_lord_field",
            [](const CPP_ele &self) { return self.n_lord_field; },
            "Number of field lords of this element.")
        .def_property_readonly("n_lord_ramper",
            [](const CPP_ele &self) { return self.n_lord_ramper; },
            "Number of ramper lords.")
        .def_property_readonly("ic1_lord",
            [](const CPP_ele &self) { return self.ic1_lord; },
            "Pointer index to this element's lords.")
        .def_property_readonly("ix_pointer",
            [](const CPP_ele &self) { return self.ix_pointer; },
            "For general use. Not used by Bmad.")
        .def_property_readonly("ixx",
            [](const CPP_ele &self) { return self.ixx; },
            "Index for Bmad internal use.")
        .def_property_readonly("iyy",
            [](const CPP_ele &self) { return self.iyy; },
            "Index for Bmad internal use.")
        .def_property_readonly("izz",
            [](const CPP_ele &self) { return self.izz; },
            "Index for Bmad internal use.")
        .def_property_readonly("mat6_calc_method",
            [](const CPP_ele &self) { return self.mat6_calc_method; },
            "taylor$, symp_lie_ptc$, etc.")
        .def_property_readonly("tracking_method",
            [](const CPP_ele &self) { return self.tracking_method; },
            "taylor$, linear$, etc.")
        .def_property_readonly("spin_tracking_method",
            [](const CPP_ele &self) { return self.spin_tracking_method; },
            "symp_lie_ptc$, etc.")
        .def_property_readonly("csr_method",
            [](const CPP_ele &self) { return self.csr_method; },
            "or one_dim$ ('1_dim'), steady_state_3d$")
        .def_property_readonly("space_charge_method",
            [](const CPP_ele &self) { return self.space_charge_method; },
            "slice$, slice_longitudinal$, slice_transverse$, fft_3D$, cathode_fft_3d$")
        .def_property_readonly("ptc_integration_type",
            [](const CPP_ele &self) { return self.ptc_integration_type; },
            "drift_kick$, matrix_kick$, or ripken_kick$")
        .def_property_readonly("field_calc",
            [](const CPP_ele &self) { return self.field_calc; },
            "no_field$, fieldmap$, refer_to_lords$, or custom$")
        .def_property_readonly("aperture_at",
            [](const CPP_ele &self) { return self.aperture_at; },
            "Aperture location: entrance_end$, ...")
        .def_property_readonly("aperture_type",
            [](const CPP_ele &self) { return self.aperture_type; },
            "rectangular$, elliptical$, auto_aperture$, ...")
        .def_property_readonly("ref_species",
            [](const CPP_ele &self) { return self.ref_species; },
            "Reference species")
        .def_property_readonly("orientation",
            [](const CPP_ele &self) { return self.orientation; },
            "-1 -> Element is longitudinally reversed. +1 -> Normal.")
        .def_property_readonly("symplectify",
            [](const CPP_ele &self) { return self.symplectify; },
            "Symplectify mat6 matrices.")
        .def_property_readonly("mode_flip",
            [](const CPP_ele &self) { return self.mode_flip; },
            "Have the normal modes traded places?")
        .def_property_readonly("multipoles_on",
            [](const CPP_ele &self) { return self.multipoles_on; },
            "For turning multipoles on/off")
        .def_property_readonly("scale_multipoles",
            [](const CPP_ele &self) { return self.scale_multipoles; },
            "Are ab_multipoles within other elements (EG: quads, etc.)")
        .def_property_readonly("taylor_map_includes_offsets",
            [](const CPP_ele &self) { return self.taylor_map_includes_offsets; },
            "Taylor map calculated with element misalignments?")
        .def_property_readonly("field_master",
            [](const CPP_ele &self) { return self.field_master; },
            "Calculate strength from the field value?")
        .def_property_readonly("is_on",
            [](const CPP_ele &self) { return self.is_on; },
            "For turning element on/off.")
        .def_property_readonly("logic",
            [](const CPP_ele &self) { return self.logic; },
            "For general use. Not used by Bmad (except during lattice parsing).")
        .def_property_readonly("bmad_logic",
            [](const CPP_ele &self) { return self.bmad_logic; },
            "For Bmad internal use only.")
        .def_property_readonly("select",
            [](const CPP_ele &self) { return self.select; },
            "For Bmad internal use only.")
        .def_property_readonly("offset_moves_aperture",
            [](const CPP_ele &self) { return self.offset_moves_aperture; },
            "element offsets affects aperture?")
        // Custom methods
        // Additional methods would be bound here
        ;

    py::class_<CPP_complex_taylor_term>(m, "complex_taylor_term", "Fortran struct: complex_taylor_term_struct")
        .def(py::init<>())
        .def_property_readonly("coef",
            [](const CPP_complex_taylor_term &self) { return self.coef; },
            "Property from Fortran struct")
        // Array property: expn, type: Int_ARRAY
        .def_property("expn",
            [](const CPP_complex_taylor_term &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.expn;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_complex_taylor_term &self, py::array arr) {
                // Set expn from numpy array
                
                return arr;
    
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_complex_taylor>(m, "complex_taylor", "Fortran struct: complex_taylor_struct")
        .def(py::init<>())
        .def_property_readonly("ref",
            [](const CPP_complex_taylor &self) { return self.ref; },
            "Property from Fortran struct")
        // Array property: term, type: CPP_complex_taylor_term_ARRAY
        .def_property("term",
            [](const CPP_complex_taylor &self) {
                // Get list of struct objects
                
                return self.term;
                
            },
            [](CPP_complex_taylor &self, py::object obj) {
                // Set term from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.term;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_complex_taylor_term>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_complex_taylor_term objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_branch>(m, "branch", "Fortran struct: branch_struct")
        .def(py::init<>())
        .def_property_readonly("name",
            [](const CPP_branch &self) { return self.name; },
            "Name of line that defines the branch.")
        .def_property_readonly("ix_branch",
            [](const CPP_branch &self) { return self.ix_branch; },
            "Index of this branch. 0 => Main branch")
        .def_property_readonly("ix_from_branch",
            [](const CPP_branch &self) { return self.ix_from_branch; },
            "-1 => No creating fork element to this branch.")
        .def_property_readonly("ix_from_ele",
            [](const CPP_branch &self) { return self.ix_from_ele; },
            "Index of creating fork element which forks to this branch.")
        .def_property_readonly("ix_to_ele",
            [](const CPP_branch &self) { return self.ix_to_ele; },
            "Index of element in this branch that creating fork element forks to.")
        .def_property_readonly("n_ele_track",
            [](const CPP_branch &self) { return self.n_ele_track; },
            "Property from Fortran struct")
        .def_property_readonly("n_ele_max",
            [](const CPP_branch &self) { return self.n_ele_max; },
            "Property from Fortran struct")
        .def_property_readonly("a",
            [](const CPP_branch &self) { return self.a; },
            "Note: Tunes are the fractional part.")
        .def_property_readonly("b",
            [](const CPP_branch &self) { return self.b; },
            "Note: Tunes are the fractional part.")
        .def_property_readonly("z",
            [](const CPP_branch &self) { return self.z; },
            "Note: Tunes are the fractional part.")
        // Array property: ele, type: CPP_ele_ARRAY
        .def_property("ele",
            [](const CPP_branch &self) {
                // Get list of struct objects
                
                return self.ele;
                
            },
            [](CPP_branch &self, py::object obj) {
                // Set ele from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.ele;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_ele>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ele objects");
                // }
                
            },
            "Property from Fortran struct")
        .def_property_readonly("param",
            [](const CPP_branch &self) { return self.param; },
            "Property from Fortran struct")
        // Array property: wall3d, type: CPP_wall3d_ARRAY
        .def_property("wall3d",
            [](const CPP_branch &self) {
                // Get list of struct objects
                
                return self.wall3d;
                
            },
            [](CPP_branch &self, py::object obj) {
                // Set wall3d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.wall3d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_wall3d>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wall3d objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_lat>(m, "lat", "Fortran struct: lat_struct")
        .def(py::init<>())
        .def_property_readonly("use_name",
            [](const CPP_lat &self) { return self.use_name; },
            "Name of lat given by USE statement")
        .def_property_readonly("lattice",
            [](const CPP_lat &self) { return self.lattice; },
            "Lattice")
        .def_property_readonly("machine",
            [](const CPP_lat &self) { return self.machine; },
            "Name of the machine the lattice is for ('LHC', etc).")
        .def_property_readonly("input_file_name",
            [](const CPP_lat &self) { return self.input_file_name; },
            "Name of the lattice input file")
        .def_property_readonly("title",
            [](const CPP_lat &self) { return self.title; },
            "General title")
        // Array property: print_str, type: String_ARRAY
        .def_property("print_str",
            [](const CPP_lat &self) {
                // Get numpy array from String_ARRAY
                const auto& arr = self.print_str;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_lat &self, py::array arr) {
                // Set print_str from numpy array
                
                return arr;
    
            },
            "Saved print statements.")
        // Array property: constant, type: CPP_expression_atom_ARRAY
        .def_property("constant",
            [](const CPP_lat &self) {
                // Get list of struct objects
                
                return self.constant;
                
            },
            [](CPP_lat &self, py::object obj) {
                // Set constant from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.constant;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_expression_atom>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_expression_atom objects");
                // }
                
            },
            "Constants defined in the lattice")
        .def_property_readonly("a",
            [](const CPP_lat &self) { return self.a; },
            "Tunes (fractional part), etc.")
        .def_property_readonly("b",
            [](const CPP_lat &self) { return self.b; },
            "Tunes (fractional part), etc.")
        .def_property_readonly("z",
            [](const CPP_lat &self) { return self.z; },
            "Tunes (fractional part), etc.")
        .def_property_readonly("param",
            [](const CPP_lat &self) { return self.param; },
            "Parameters")
        .def_property_readonly("lord_state",
            [](const CPP_lat &self) { return self.lord_state; },
            "lord bookkeeping status.")
        .def_property_readonly("ele_init",
            [](const CPP_lat &self) { return self.ele_init; },
            "For use by any program")
        // Array property: ele, type: CPP_ele_ARRAY
        .def_property("ele",
            [](const CPP_lat &self) {
                // Get list of struct objects
                
                return self.ele;
                
            },
            [](CPP_lat &self, py::object obj) {
                // Set ele from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.ele;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_ele>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ele objects");
                // }
                
            },
            "Array of elements [=> branch(0)].")
        // Array property: branch, type: CPP_branch_ARRAY
        .def_property("branch",
            [](const CPP_lat &self) {
                // Get list of struct objects
                
                return self.branch;
                
            },
            [](CPP_lat &self, py::object obj) {
                // Set branch from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.branch;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_branch>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_branch objects");
                // }
                
            },
            "Branch(0:) array")
        // Array property: control, type: CPP_control_ARRAY
        .def_property("control",
            [](const CPP_lat &self) {
                // Get list of struct objects
                
                return self.control;
                
            },
            [](CPP_lat &self, py::object obj) {
                // Set control from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.control;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_control>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_control objects");
                // }
                
            },
            "Control list")
        .def_property_readonly("particle_start",
            [](const CPP_lat &self) { return self.particle_start; },
            "Starting particle_coords.")
        .def_property_readonly("beam_init",
            [](const CPP_lat &self) { return self.beam_init; },
            "Beam initialization.")
        .def_property_readonly("pre_tracker",
            [](const CPP_lat &self) { return self.pre_tracker; },
            "For OPAL/IMPACT-T")
        // Array property: custom, type: Real_ARRAY
        .def_property("custom",
            [](const CPP_lat &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.custom;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_lat &self, py::array arr) {
                // Set custom from numpy array
                
                return arr;
    
            },
            "Custom attributes.")
        .def_property_readonly("version",
            [](const CPP_lat &self) { return self.version; },
            "Version number")
        .def_property_readonly("n_ele_track",
            [](const CPP_lat &self) { return self.n_ele_track ? py::cast(*self.n_ele_track) : py::none(); },
            "Number of lat elements to track through.")
        .def_property_readonly("n_ele_max",
            [](const CPP_lat &self) { return self.n_ele_max ? py::cast(*self.n_ele_max) : py::none(); },
            "Index of last valid element in %ele(:) array")
        .def_property_readonly("n_control_max",
            [](const CPP_lat &self) { return self.n_control_max; },
            "Last index used in control_array")
        .def_property_readonly("n_ic_max",
            [](const CPP_lat &self) { return self.n_ic_max; },
            "Last index used in ic_array")
        .def_property_readonly("input_taylor_order",
            [](const CPP_lat &self) { return self.input_taylor_order; },
            "As set in the input file")
        // Array property: ic, type: Int_ARRAY
        .def_property("ic",
            [](const CPP_lat &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.ic;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_lat &self, py::array arr) {
                // Set ic from numpy array
                
                return arr;
    
            },
            "Index to %control(:) from slaves.")
        .def_property_readonly("photon_type",
            [](const CPP_lat &self) { return self.photon_type; },
            "Or coherent$. For X-ray simulations.")
        .def_property_readonly("creation_hash",
            [](const CPP_lat &self) { return self.creation_hash; },
            "Set by bmad_parser. creation_hash will vary if")
        .def_property_readonly("ramper_slave_bookkeeping",
            [](const CPP_lat &self) { return self.ramper_slave_bookkeeping; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_bunch>(m, "bunch", "Fortran struct: bunch_struct")
        .def(py::init<>())
        // Array property: particle, type: CPP_coord_ARRAY
        .def_property("particle",
            [](const CPP_bunch &self) {
                // Get list of struct objects
                
                return self.particle;
                
            },
            [](CPP_bunch &self, py::object obj) {
                // Set particle from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.particle;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_coord>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_coord objects");
                // }
                
            },
            "Property from Fortran struct")
        // Array property: ix_z, type: Int_ARRAY
        .def_property("ix_z",
            [](const CPP_bunch &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.ix_z;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_bunch &self, py::array arr) {
                // Set ix_z from numpy array
                
                return arr;
    
            },
            "bunch%ix_z(1) is index of head particle, etc.")
        .def_property_readonly("charge_tot",
            [](const CPP_bunch &self) { return self.charge_tot; },
            "Total charge in a bunch (Coul).")
        .def_property_readonly("charge_live",
            [](const CPP_bunch &self) { return self.charge_live; },
            "Charge of live particles (Coul).")
        .def_property_readonly("z_center",
            [](const CPP_bunch &self) { return self.z_center; },
            "Longitudinal center of bunch at creation time. Note: Generally, z_center of")
        .def_property_readonly("t_center",
            [](const CPP_bunch &self) { return self.t_center; },
            "Center of bunch at creation time relative to head bunch.")
        .def_property_readonly("t0",
            [](const CPP_bunch &self) { return self.t0; },
            "Used by track1_bunch_space_charge for tracking so particles have constant t.")
        .def_property_readonly("drift_between_t_and_s",
            [](const CPP_bunch &self) { return self.drift_between_t_and_s; },
            "Property from Fortran struct")
        .def_property_readonly("ix_ele",
            [](const CPP_bunch &self) { return self.ix_ele; },
            "Nominal element bunch is at. But, EG, dead particles can be someplace else.")
        .def_property_readonly("ix_bunch",
            [](const CPP_bunch &self) { return self.ix_bunch; },
            "Bunch index. Head bunch = 1, etc.")
        .def_property_readonly("ix_turn",
            [](const CPP_bunch &self) { return self.ix_turn; },
            "Turn index for long term tracking. ix_turn = 0 before end of first turn, etc.")
        .def_property_readonly("n_live",
            [](const CPP_bunch &self) { return self.n_live; },
            "Property from Fortran struct")
        .def_property_readonly("n_good",
            [](const CPP_bunch &self) { return self.n_good; },
            "Number of accepted steps when using adaptive step size control.")
        .def_property_readonly("n_bad",
            [](const CPP_bunch &self) { return self.n_bad; },
            "Number of rejected steps when using adaptive step size control.")
        ;

    py::class_<CPP_bunch_params>(m, "bunch_params", "Fortran struct: bunch_params_struct")
        .def(py::init<>())
        .def_property_readonly("centroid",
            [](const CPP_bunch_params &self) { return self.centroid; },
            "Lab frame")
        .def_property_readonly("x",
            [](const CPP_bunch_params &self) { return self.x; },
            "Projected Twiss parameters")
        .def_property_readonly("y",
            [](const CPP_bunch_params &self) { return self.y; },
            "Projected Twiss parameters")
        .def_property_readonly("z",
            [](const CPP_bunch_params &self) { return self.z; },
            "Projected Twiss parameters")
        .def_property_readonly("a",
            [](const CPP_bunch_params &self) { return self.a; },
            "Normal mode twiss parameters")
        .def_property_readonly("b",
            [](const CPP_bunch_params &self) { return self.b; },
            "Normal mode twiss parameters")
        .def_property_readonly("c",
            [](const CPP_bunch_params &self) { return self.c; },
            "Normal mode twiss parameters")
        // Array property: sigma, type: Real_MATRIX
        .def_property("sigma",
            [](const CPP_bunch_params &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.sigma;
                
                return py::str("not implemented");
        
            },
            [](CPP_bunch_params &self, py::array arr) {
                // Set sigma from numpy array
                
                return arr;
    
            },
            "beam size matrix")
        // Array property: rel_max, type: Real_ARRAY
        .def_property("rel_max",
            [](const CPP_bunch_params &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.rel_max;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_bunch_params &self, py::array arr) {
                // Set rel_max from numpy array
                
                return arr;
    
            },
            "Max orbit relative to centroid. 7 -> time.")
        // Array property: rel_min, type: Real_ARRAY
        .def_property("rel_min",
            [](const CPP_bunch_params &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.rel_min;
                auto size = arr.size();
                
                return arr;
                
            },
            [](CPP_bunch_params &self, py::array arr) {
                // Set rel_min from numpy array
                
                return arr;
    
            },
            "Min orbit relative to_centroid. 7 -> time.")
        .def_property_readonly("s",
            [](const CPP_bunch_params &self) { return self.s; },
            "Longitudinal position.")
        .def_property_readonly("t",
            [](const CPP_bunch_params &self) { return self.t; },
            "Time.")
        .def_property_readonly("sigma_t",
            [](const CPP_bunch_params &self) { return self.sigma_t; },
            "RMS of time spread.")
        .def_property_readonly("charge_live",
            [](const CPP_bunch_params &self) { return self.charge_live; },
            "Charge of all non-lost particle")
        .def_property_readonly("charge_tot",
            [](const CPP_bunch_params &self) { return self.charge_tot; },
            "Charge of all particles.")
        .def_property_readonly("n_particle_tot",
            [](const CPP_bunch_params &self) { return self.n_particle_tot; },
            "Total number of particles")
        .def_property_readonly("n_particle_live",
            [](const CPP_bunch_params &self) { return self.n_particle_live; },
            "Number of non-lost particles")
        .def_property_readonly("n_particle_lost_in_ele",
            [](const CPP_bunch_params &self) { return self.n_particle_lost_in_ele; },
            "Number lost in element (not calculated by Bmad)")
        .def_property_readonly("n_good_steps",
            [](const CPP_bunch_params &self) { return self.n_good_steps; },
            "Number of good steps (set when tracking with space charge)")
        .def_property_readonly("n_bad_steps",
            [](const CPP_bunch_params &self) { return self.n_bad_steps; },
            "Number of bad steps (set when tracking with space charge)")
        .def_property_readonly("ix_ele",
            [](const CPP_bunch_params &self) { return self.ix_ele; },
            "Lattice element where params evaluated at.")
        .def_property_readonly("location",
            [](const CPP_bunch_params &self) { return self.location; },
            "Location in element: upstream_end$, inside$, or downstream_end$")
        .def_property_readonly("twiss_valid",
            [](const CPP_bunch_params &self) { return self.twiss_valid; },
            "Is the data here valid? Note: IF there is no energy")
        ;

    py::class_<CPP_beam>(m, "beam", "Fortran struct: beam_struct")
        .def(py::init<>())
        // Array property: bunch, type: CPP_bunch_ARRAY
        .def_property("bunch",
            [](const CPP_beam &self) {
                // Get list of struct objects
                
                return self.bunch;
                
            },
            [](CPP_beam &self, py::object obj) {
                // Set bunch from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.bunch;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_bunch>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_bunch objects");
                // }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_aperture_point>(m, "aperture_point", "Fortran struct: aperture_point_struct")
        .def(py::init<>())
        .def_property_readonly("x",
            [](const CPP_aperture_point &self) { return self.x; },
            "(x,y) aperture point with respect to the reference orbit.")
        .def_property_readonly("y",
            [](const CPP_aperture_point &self) { return self.y; },
            "(x,y) aperture point with respect to the reference orbit.")
        .def_property_readonly("plane",
            [](const CPP_aperture_point &self) { return self.plane; },
            "plane determining loss")
        .def_property_readonly("ix_ele",
            [](const CPP_aperture_point &self) { return self.ix_ele; },
            "ele index particle lost at")
        .def_property_readonly("i_turn",
            [](const CPP_aperture_point &self) { return self.i_turn; },
            "turn particle lost at")
        ;

    py::class_<CPP_aperture_param>(m, "aperture_param", "Fortran struct: aperture_param_struct")
        .def(py::init<>())
        .def_property_readonly("min_angle",
            [](const CPP_aperture_param &self) { return self.min_angle; },
            "Property from Fortran struct")
        .def_property_readonly("max_angle",
            [](const CPP_aperture_param &self) { return self.max_angle; },
            "Property from Fortran struct")
        .def_property_readonly("n_angle",
            [](const CPP_aperture_param &self) { return self.n_angle; },
            "Property from Fortran struct")
        .def_property_readonly("n_turn",
            [](const CPP_aperture_param &self) { return self.n_turn; },
            "Number of turns a particle must survive.")
        .def_property_readonly("x_init",
            [](const CPP_aperture_param &self) { return self.x_init; },
            "Initial x coordinate to start with for theta_xy = 0.")
        .def_property_readonly("y_init",
            [](const CPP_aperture_param &self) { return self.y_init; },
            "Initial y coordinate to start with for theta_xy = pi/2.")
        .def_property_readonly("rel_accuracy",
            [](const CPP_aperture_param &self) { return self.rel_accuracy; },
            "Relative resolution of bracketed aperture.")
        .def_property_readonly("abs_accuracy",
            [](const CPP_aperture_param &self) { return self.abs_accuracy; },
            "Absolute resolution of bracketed aperture (meters).")
        .def_property_readonly("start_ele",
            [](const CPP_aperture_param &self) { return self.start_ele; },
            "Element to start tracking at.")
        ;

    py::class_<CPP_aperture_scan>(m, "aperture_scan", "Fortran struct: aperture_scan_struct")
        .def(py::init<>())
        // Array property: point, type: CPP_aperture_point_ARRAY
        .def_property("point",
            [](const CPP_aperture_scan &self) {
                // Get list of struct objects
                
                return self.point;
                
            },
            [](CPP_aperture_scan &self, py::object obj) {
                // Set point from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.point;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_aperture_point>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_aperture_point objects");
                // }
                
            },
            "Set of aperture points at different angles.")
        .def_property_readonly("ref_orb",
            [](const CPP_aperture_scan &self) { return self.ref_orb; },
            "Ref orbit around which the scan is made.")
        .def_property_readonly("pz_start",
            [](const CPP_aperture_scan &self) { return self.pz_start; },
            "Starting pz.")
        ;


    m.def("bmad_parser", &bmad_parser_wrapper, 
        py::arg("lat_file"),
        py::arg("make_mats6") = py::none(),
        py::arg("digested_read_ok") = py::none(), 
        py::arg("use_line") = py::none(),
        "Parse a Bmad lattice file.\n\n"
        "Parameters:\n"
        "    lat_file (str): Path to the lattice file\n"
        "    make_mats6 (bool, optional): Whether to make 6x6 matrices\n"
        "    digested_read_ok (bool, optional): Whether to allow reading from digested file\n"
        "    use_line (str, optional): Name of line to use\n\n"
        "Returns:\n"
        "    dict: Dictionary containing 'error', 'lattice', and optionally 'parse_lattice'"
    );

}

