#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>
#include <pybind11/stl.h>
#include <pybind11/complex.h>
#include <string>
#include <vector>
#include <valarray>
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
py::object bmad_parser_wrapper(
    const std::string& lat_file,
    py::object make_mats6_obj = py::none(),
    py::object digested_read_ok_obj = py::none(),
    py::object use_line_obj = py::none()
) {
    auto lat_ptr = new CPP_lat;
    // auto lat_ptr = std::make_shared<CPP_lat>();
    void* parse_lat_ptr = nullptr;
    
    bool make_mats6 = make_mats6_obj.is_none() ? false : make_mats6_obj.cast<bool>();
    bool digested_read_ok = digested_read_ok_obj.is_none() ? true : digested_read_ok_obj.cast<bool>();
    const char* use_line = use_line_obj.is_none() ? nullptr : use_line_obj.cast<std::string>().c_str();
    
    bool error = cpp_bmad_parser(
        lat_file.c_str(), 
        static_cast<void*>(&lat_ptr)
        // , make_mats6, 
        // digested_read_ok, 
        // use_line, 
        // &parse_lat_ptr
    );
   
    py::dict result;
    result["error"] = error;
    
    if (lat_ptr) {
        result["lattice"] = lat_ptr;
    } else {
        result["lattice"] = py::none();
    }

    if (parse_lat_ptr) {
        result["parse_lattice"] = parse_lat_ptr;
    } else {
        result["parse_lattice"] = py::none();
    }
    
    return result;
}


PYBIND11_MODULE(bmad, m) {
    m.doc() = "pybind11 bmad plugin: auto-generated from struct definitions";

    py::class_<CPP_spline>(m, "spline", "Fortran struct: spline_struct")
        .def(py::init<>())
        .def_property("x0",
            [](const CPP_spline &self) { return self.x0; },
            [](CPP_spline &self, double val) { self.x0 = val; },
            "Point at start of spline")
        .def_property("y0",
            [](const CPP_spline &self) { return self.y0; },
            [](CPP_spline &self, double val) { self.y0 = val; },
            "Point at start of spline")
        .def_property("x1",
            [](const CPP_spline &self) { return self.x1; },
            [](CPP_spline &self, double val) { self.x1 = val; },
            "Point at end of spline")
        // Array property: coef, type: Real_ARRAY
        .def_property("coef",
            [](const CPP_spline &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.coef;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_spline &self, py::array arr) {
                // Set coef from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.coef.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.coef[i] = data[i];
                }
                
            },
            "coefficients for cubic spline")
        ;

    py::class_<CPP_spin_polar>(m, "spin_polar", "Fortran struct: spin_polar_struct")
        .def(py::init<>())
        .def_property("polarization",
            [](const CPP_spin_polar &self) { return self.polarization; },
            [](CPP_spin_polar &self, double val) { self.polarization = val; },
            "Property from Fortran struct")
        .def_property("theta",
            [](const CPP_spin_polar &self) { return self.theta; },
            [](CPP_spin_polar &self, double val) { self.theta = val; },
            "Spherical coords: Angle from z-axis.")
        .def_property("phi",
            [](const CPP_spin_polar &self) { return self.phi; },
            [](CPP_spin_polar &self, double val) { self.phi = val; },
            "Spherical coords: Angle in (x,y) plane.")
        .def_property("xi",
            [](const CPP_spin_polar &self) { return self.xi; },
            [](CPP_spin_polar &self, double val) { self.xi = val; },
            "Spinor phase angle (See Bmad manual).")
        ;

    py::class_<CPP_ac_kicker_time>(m, "ac_kicker_time", "Fortran struct: ac_kicker_time_struct")
        .def(py::init<>())
        .def_property("amp",
            [](const CPP_ac_kicker_time &self) { return self.amp; },
            [](CPP_ac_kicker_time &self, double val) { self.amp = val; },
            "Property from Fortran struct")
        .def_property("time",
            [](const CPP_ac_kicker_time &self) { return self.time; },
            [](CPP_ac_kicker_time &self, double val) { self.time = val; },
            "Property from Fortran struct")
        .def_property("spline",
            [](const CPP_ac_kicker_time &self) { return self.spline; },
            [](CPP_ac_kicker_time &self, CPP_spline val) { self.spline = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_ac_kicker_freq>(m, "ac_kicker_freq", "Fortran struct: ac_kicker_freq_struct")
        .def(py::init<>())
        .def_property("f",
            [](const CPP_ac_kicker_freq &self) { return self.f; },
            [](CPP_ac_kicker_freq &self, double val) { self.f = val; },
            "Property from Fortran struct")
        .def_property("amp",
            [](const CPP_ac_kicker_freq &self) { return self.amp; },
            [](CPP_ac_kicker_freq &self, double val) { self.amp = val; },
            "Property from Fortran struct")
        .def_property("phi",
            [](const CPP_ac_kicker_freq &self) { return self.phi; },
            [](CPP_ac_kicker_freq &self, double val) { self.phi = val; },
            "Property from Fortran struct")
        .def_property("rf_clock_harmonic",
            [](const CPP_ac_kicker_freq &self) { return self.rf_clock_harmonic; },
            [](CPP_ac_kicker_freq &self, int val) { self.rf_clock_harmonic = val; },
            "When RF clock is used.")
        ;

    py::class_<CPP_ac_kicker>(m, "ac_kicker", "Fortran struct: ac_kicker_struct")
        .def(py::init<>())
        // Array property: amp_vs_time, type: CPP_ac_kicker_time_ARRAY
        .def_property("amp_vs_time",
            [](const CPP_ac_kicker &self) {
                // Get list of struct objects
                
                const auto& arr = self.amp_vs_time;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ac_kicker &self, py::object obj) {
                // Set amp_vs_time from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.amp_vs_time;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_ac_kicker_time>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_ac_kicker_time objects");
                }
                
            },
            "Property from Fortran struct")
        // Array property: frequency, type: CPP_ac_kicker_freq_ARRAY
        .def_property("frequency",
            [](const CPP_ac_kicker &self) {
                // Get list of struct objects
                
                const auto& arr = self.frequency;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ac_kicker &self, py::object obj) {
                // Set frequency from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.frequency;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_ac_kicker_freq>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_ac_kicker_freq objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_interval1_coef>(m, "interval1_coef", "Fortran struct: interval1_coef_struct")
        .def(py::init<>())
        .def_property("c0",
            [](const CPP_interval1_coef &self) { return self.c0; },
            [](CPP_interval1_coef &self, double val) { self.c0 = val; },
            "Property from Fortran struct")
        .def_property("c1",
            [](const CPP_interval1_coef &self) { return self.c1; },
            [](CPP_interval1_coef &self, double val) { self.c1 = val; },
            "Property from Fortran struct")
        .def_property("n_exp",
            [](const CPP_interval1_coef &self) { return self.n_exp; },
            [](CPP_interval1_coef &self, double val) { self.n_exp = val; },
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set angle from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.angle.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.angle[i] = data[i];
                }
                
            },
            "Vector of angle values for %p_reflect")
        // Array property: energy, type: Real_ARRAY
        .def_property("energy",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.energy;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set energy from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.energy.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.energy[i] = data[i];
                }
                
            },
            "Vector of energy values for %p_reflect")
        // Array property: int1, type: CPP_interval1_coef_ARRAY
        .def_property("int1",
            [](const CPP_photon_reflect_table &self) {
                // Get list of struct objects
                
                const auto& arr = self.int1;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_photon_reflect_table &self, py::object obj) {
                // Set int1 from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.int1;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_interval1_coef>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_interval1_coef objects");
                }
                
            },
            "Property from Fortran struct")
        // Array property: p_reflect, type: Real_MATRIX
        .def_property("p_reflect",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.p_reflect;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set p_reflect from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.p_reflect.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.p_reflect[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.p_reflect[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "(angle, ev) probability. Log used for smooth surface reflection")
        .def_property("max_energy",
            [](const CPP_photon_reflect_table &self) { return self.max_energy; },
            [](CPP_photon_reflect_table &self, double val) { self.max_energy = val; },
            "maximum energy for this table")
        // Array property: p_reflect_scratch, type: Real_ARRAY
        .def_property("p_reflect_scratch",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.p_reflect_scratch;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set p_reflect_scratch from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.p_reflect_scratch.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.p_reflect_scratch[i] = data[i];
                }
                
            },
            "Scratch space")
        // Array property: bragg_angle, type: Real_ARRAY
        .def_property("bragg_angle",
            [](const CPP_photon_reflect_table &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.bragg_angle;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_photon_reflect_table &self, py::array arr) {
                // Set bragg_angle from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.bragg_angle.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.bragg_angle[i] = data[i];
                }
                
            },
            "Bragg angle at energy values.")
        ;

    py::class_<CPP_photon_reflect_surface>(m, "photon_reflect_surface", "Fortran struct: photon_reflect_surface_struct")
        .def(py::init<>())
        .def_property("name",
            [](const CPP_photon_reflect_surface &self) { return self.name; },
            [](CPP_photon_reflect_surface &self, std::string val) { self.name = val; },
            "Property from Fortran struct")
        .def_property("description",
            [](const CPP_photon_reflect_surface &self) { return self.description; },
            [](CPP_photon_reflect_surface &self, std::string val) { self.description = val; },
            "Descriptive name")
        .def_property("reflectivity_file",
            [](const CPP_photon_reflect_surface &self) { return self.reflectivity_file; },
            [](CPP_photon_reflect_surface &self, std::string val) { self.reflectivity_file = val; },
            "Property from Fortran struct")
        // Array property: table, type: CPP_photon_reflect_table_ARRAY
        .def_property("table",
            [](const CPP_photon_reflect_surface &self) {
                // Get list of struct objects
                
                const auto& arr = self.table;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_photon_reflect_surface &self, py::object obj) {
                // Set table from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.table;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_photon_reflect_table>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_photon_reflect_table objects");
                }
                
            },
            "Property from Fortran struct")
        .def_property("surface_roughness_rms",
            [](const CPP_photon_reflect_surface &self) { return self.surface_roughness_rms; },
            [](CPP_photon_reflect_surface &self, double val) { self.surface_roughness_rms = val; },
            "sigma in Dugan's notation")
        .def_property("roughness_correlation_len",
            [](const CPP_photon_reflect_surface &self) { return self.roughness_correlation_len; },
            [](CPP_photon_reflect_surface &self, double val) { self.roughness_correlation_len = val; },
            "T in Dugan's notation")
        .def_property("ix_surface",
            [](const CPP_photon_reflect_surface &self) { return self.ix_surface; },
            [](CPP_photon_reflect_surface &self, int val) { self.ix_surface = val; },
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_coord &self, py::array arr) {
                // Set vec from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.vec.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.vec[i] = data[i];
                }
                
            },
            "(x, px, y, py, z, pz). Generally phase space for charged particles. See Bmad manual.")
        .def_property("s",
            [](const CPP_coord &self) { return self.s; },
            [](CPP_coord &self, double val) { self.s = val; },
            "Longitudinal position")
        .def_property("t",
            [](const CPP_coord &self) { return self.t; },
            [](CPP_coord &self, double val) { self.t = val; },
            "Absolute time (not relative to reference). If bmad_private%rf_clock_frequency is")
        // Array property: spin, type: Real_ARRAY
        .def_property("spin",
            [](const CPP_coord &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.spin;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_coord &self, py::array arr) {
                // Set spin from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.spin.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.spin[i] = data[i];
                }
                
            },
            "Spin.")
        // Array property: field, type: Real_ARRAY
        .def_property("field",
            [](const CPP_coord &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.field;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_coord &self, py::array arr) {
                // Set field from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.field.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.field[i] = data[i];
                }
                
            },
            "Photon E-field intensity (x,y).")
        // Array property: phase, type: Real_ARRAY
        .def_property("phase",
            [](const CPP_coord &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.phase;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_coord &self, py::array arr) {
                // Set phase from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.phase.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.phase[i] = data[i];
                }
                
            },
            "Photon E-field phase (x,y). phase(1) is also used with")
        .def_property("charge",
            [](const CPP_coord &self) { return self.charge; },
            [](CPP_coord &self, double val) { self.charge = val; },
            "Macroparticle weight (which is different from particle species charge).")
        .def_property("dt_ref",
            [](const CPP_coord &self) { return self.dt_ref; },
            [](CPP_coord &self, double val) { self.dt_ref = val; },
            "Used in:")
        .def_property("r",
            [](const CPP_coord &self) { return self.r; },
            [](CPP_coord &self, double val) { self.r = val; },
            "For general use. Not used by Bmad.")
        .def_property("p0c",
            [](const CPP_coord &self) { return self.p0c; },
            [](CPP_coord &self, double val) { self.p0c = val; },
            "For non-photons: Reference momentum.")
        .def_property("e_potential",
            [](const CPP_coord &self) { return self.e_potential; },
            [](CPP_coord &self, double val) { self.e_potential = val; },
            "Potential energy.")
        .def_property("beta",
            [](const CPP_coord &self) { return self.beta; },
            [](CPP_coord &self, double val) { self.beta = val; },
            "Velocity / c_light.")
        .def_property("ix_ele",
            [](const CPP_coord &self) { return self.ix_ele; },
            [](CPP_coord &self, int val) { self.ix_ele = val; },
            "Index of the lattice element the particle is in.")
        .def_property("ix_branch",
            [](const CPP_coord &self) { return self.ix_branch; },
            [](CPP_coord &self, int val) { self.ix_branch = val; },
            "Index of the lattice branch the particle is in.")
        .def_property("ix_turn",
            [](const CPP_coord &self) { return self.ix_turn; },
            [](CPP_coord &self, int val) { self.ix_turn = val; },
            "Turn index for multiturn tracking.")
        .def_property("ix_user",
            [](const CPP_coord &self) { return self.ix_user; },
            [](CPP_coord &self, int val) { self.ix_user = val; },
            "For general use, not used by Bmad.")
        .def_property("state",
            [](const CPP_coord &self) { return self.state; },
            [](CPP_coord &self, int val) { self.state = val; },
            "alive$, lost$, lost_neg_x_aperture$, lost_pz$, etc.")
        .def_property("direction",
            [](const CPP_coord &self) { return self.direction; },
            [](CPP_coord &self, int val) { self.direction = val; },
            "+1 or -1. Sign of longitudinal direction of motion (ds/dt).")
        .def_property("time_dir",
            [](const CPP_coord &self) { return self.time_dir; },
            [](CPP_coord &self, int val) { self.time_dir = val; },
            "+1 or -1. Time direction. -1 => Traveling backwards in time.")
        .def_property("species",
            [](const CPP_coord &self) { return self.species; },
            [](CPP_coord &self, int val) { self.species = val; },
            "positron$, proton$, etc.")
        .def_property("location",
            [](const CPP_coord &self) { return self.location; },
            [](CPP_coord &self, int val) { self.location = val; },
            "upstream_end$, inside$, or downstream_end$")
        ;

    py::class_<CPP_coord_array>(m, "coord_array", "Fortran struct: coord_array_struct")
        .def(py::init<>())
        // Array property: orbit, type: CPP_coord_ARRAY
        .def_property("orbit",
            [](const CPP_coord_array &self) {
                // Get list of struct objects
                
                const auto& arr = self.orbit;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_coord_array &self, py::object obj) {
                // Set orbit from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.orbit;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_coord>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_coord objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_bpm_phase_coupling>(m, "bpm_phase_coupling", "Fortran struct: bpm_phase_coupling_struct")
        .def(py::init<>())
        .def_property("k_22a",
            [](const CPP_bpm_phase_coupling &self) { return self.k_22a; },
            [](CPP_bpm_phase_coupling &self, double val) { self.k_22a = val; },
            "In-phase y/x for a-mode oscillations.")
        .def_property("k_12a",
            [](const CPP_bpm_phase_coupling &self) { return self.k_12a; },
            [](CPP_bpm_phase_coupling &self, double val) { self.k_12a = val; },
            "Out-of-phase y/x for a-mode oscillations.")
        .def_property("k_11b",
            [](const CPP_bpm_phase_coupling &self) { return self.k_11b; },
            [](CPP_bpm_phase_coupling &self, double val) { self.k_11b = val; },
            "In-phase x/y for b-mode oscillations.")
        .def_property("k_12b",
            [](const CPP_bpm_phase_coupling &self) { return self.k_12b; },
            [](CPP_bpm_phase_coupling &self, double val) { self.k_12b = val; },
            "Out-of-phase x/y for b-mode oscillations.")
        .def_property("cbar22_a",
            [](const CPP_bpm_phase_coupling &self) { return self.cbar22_a; },
            [](CPP_bpm_phase_coupling &self, double val) { self.cbar22_a = val; },
            "Cbar22 as calculated from K_22a.")
        .def_property("cbar12_a",
            [](const CPP_bpm_phase_coupling &self) { return self.cbar12_a; },
            [](CPP_bpm_phase_coupling &self, double val) { self.cbar12_a = val; },
            "Cbar12 as calculated from K_12a.")
        .def_property("cbar11_b",
            [](const CPP_bpm_phase_coupling &self) { return self.cbar11_b; },
            [](CPP_bpm_phase_coupling &self, double val) { self.cbar11_b = val; },
            "Cbar11 as calculated from K_11b.")
        .def_property("cbar12_b",
            [](const CPP_bpm_phase_coupling &self) { return self.cbar12_b; },
            [](CPP_bpm_phase_coupling &self, double val) { self.cbar12_b = val; },
            "Cbar12 as calculated from K_12b.")
        .def_property("phi_a",
            [](const CPP_bpm_phase_coupling &self) { return self.phi_a; },
            [](CPP_bpm_phase_coupling &self, double val) { self.phi_a = val; },
            "a-mode betatron phase.")
        .def_property("phi_b",
            [](const CPP_bpm_phase_coupling &self) { return self.phi_b; },
            [](CPP_bpm_phase_coupling &self, double val) { self.phi_b = val; },
            "b-mode betatron phase.")
        ;

    py::class_<CPP_expression_atom>(m, "expression_atom", "Fortran struct: expression_atom_struct")
        .def(py::init<>())
        .def_property("name",
            [](const CPP_expression_atom &self) { return self.name; },
            [](CPP_expression_atom &self, std::string val) { self.name = val; },
            "Property from Fortran struct")
        .def_property("type",
            [](const CPP_expression_atom &self) { return self.type; },
            [](CPP_expression_atom &self, int val) { self.type = val; },
            "plus$, minum$, sin$, cos$, etc. To convert to string use: expression_op_name")
        .def_property("value",
            [](const CPP_expression_atom &self) { return self.value; },
            [](CPP_expression_atom &self, double val) { self.value = val; },
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_wake_sr_z_long &self, py::array arr) {
                // Set w from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.w.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.w[i] = data[i];
                }
                
            },
            "Input single particle Wake. Indexed from 1.")
        // Array property: fw, type: Complex_ARRAY
        .def_property("fw",
            [](const CPP_wake_sr_z_long &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.fw;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new std::complex<double>[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<std::complex<double>*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<std::complex<double>>(), {size}, {sizeof(std::complex<double>)}, data, capsule);
                
            },
            [](CPP_wake_sr_z_long &self, py::array arr) {
                // Set fw from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.fw.resize(size);
                auto* data = static_cast<std::complex<double>*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.fw[i] = data[i];
                }
                
            },
            "Fourier transform of w.")
        // Array property: fbunch, type: Complex_ARRAY
        .def_property("fbunch",
            [](const CPP_wake_sr_z_long &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.fbunch;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new std::complex<double>[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<std::complex<double>*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<std::complex<double>>(), {size}, {sizeof(std::complex<double>)}, data, capsule);
                
            },
            [](CPP_wake_sr_z_long &self, py::array arr) {
                // Set fbunch from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.fbunch.resize(size);
                auto* data = static_cast<std::complex<double>*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.fbunch[i] = data[i];
                }
                
            },
            "Scratch space.")
        // Array property: w_out, type: Complex_ARRAY
        .def_property("w_out",
            [](const CPP_wake_sr_z_long &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.w_out;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new std::complex<double>[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<std::complex<double>*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<std::complex<double>>(), {size}, {sizeof(std::complex<double>)}, data, capsule);
                
            },
            [](CPP_wake_sr_z_long &self, py::array arr) {
                // Set w_out from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.w_out.resize(size);
                auto* data = static_cast<std::complex<double>*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.w_out[i] = data[i];
                }
                
            },
            "Scratch space.")
        .def_property("dz",
            [](const CPP_wake_sr_z_long &self) { return self.dz; },
            [](CPP_wake_sr_z_long &self, double val) { self.dz = val; },
            "Distance between points. If zero there is no wake.")
        .def_property("z0",
            [](const CPP_wake_sr_z_long &self) { return self.z0; },
            [](CPP_wake_sr_z_long &self, double val) { self.z0 = val; },
            "Wake extent is [-z0, z0].")
        .def_property("smoothing_sigma",
            [](const CPP_wake_sr_z_long &self) { return self.smoothing_sigma; },
            [](CPP_wake_sr_z_long &self, double val) { self.smoothing_sigma = val; },
            "0 => No smoothing.")
        .def_property("position_dependence",
            [](const CPP_wake_sr_z_long &self) { return self.position_dependence; },
            [](CPP_wake_sr_z_long &self, int val) { self.position_dependence = val; },
            "Transverse: leading$, trailing$, none$")
        .def_property("time_based",
            [](const CPP_wake_sr_z_long &self) { return self.time_based; },
            [](CPP_wake_sr_z_long &self, bool val) { self.time_based = val; },
            "Was input time based?")
        ;

    py::class_<CPP_wake_sr_mode>(m, "wake_sr_mode", "Fortran struct: wake_sr_mode_struct")
        .def(py::init<>())
        .def_property("amp",
            [](const CPP_wake_sr_mode &self) { return self.amp; },
            [](CPP_wake_sr_mode &self, double val) { self.amp = val; },
            "Amplitude")
        .def_property("damp",
            [](const CPP_wake_sr_mode &self) { return self.damp; },
            [](CPP_wake_sr_mode &self, double val) { self.damp = val; },
            "Dampling factor.")
        .def_property("k",
            [](const CPP_wake_sr_mode &self) { return self.k; },
            [](CPP_wake_sr_mode &self, double val) { self.k = val; },
            "k factor")
        .def_property("phi",
            [](const CPP_wake_sr_mode &self) { return self.phi; },
            [](CPP_wake_sr_mode &self, double val) { self.phi = val; },
            "Phase in radians/2pi")
        .def_property("b_sin",
            [](const CPP_wake_sr_mode &self) { return self.b_sin; },
            [](CPP_wake_sr_mode &self, double val) { self.b_sin = val; },
            "non-skew (x) sin-like component of the wake")
        .def_property("b_cos",
            [](const CPP_wake_sr_mode &self) { return self.b_cos; },
            [](CPP_wake_sr_mode &self, double val) { self.b_cos = val; },
            "non-skew (x) cos-like component of the wake")
        .def_property("a_sin",
            [](const CPP_wake_sr_mode &self) { return self.a_sin; },
            [](CPP_wake_sr_mode &self, double val) { self.a_sin = val; },
            "skew (y) sin-like component of the wake")
        .def_property("a_cos",
            [](const CPP_wake_sr_mode &self) { return self.a_cos; },
            [](CPP_wake_sr_mode &self, double val) { self.a_cos = val; },
            "skew (y) cos-like component of the wake")
        .def_property("polarization",
            [](const CPP_wake_sr_mode &self) { return self.polarization; },
            [](CPP_wake_sr_mode &self, int val) { self.polarization = val; },
            "Transverse: none$, x_axis$, y_axis$. Not used for longitudinal.")
        .def_property("position_dependence",
            [](const CPP_wake_sr_mode &self) { return self.position_dependence; },
            [](CPP_wake_sr_mode &self, int val) { self.position_dependence = val; },
            "Transverse: leading$, trailing$, none$")
        ;

    py::class_<CPP_wake_sr>(m, "wake_sr", "Fortran struct: wake_sr_struct")
        .def(py::init<>())
        .def_property("file",
            [](const CPP_wake_sr &self) { return self.file; },
            [](CPP_wake_sr &self, std::string val) { self.file = val; },
            "Property from Fortran struct")
        .def_property("z_long",
            [](const CPP_wake_sr &self) { return self.z_long; },
            [](CPP_wake_sr &self, CPP_wake_sr_z_long val) { self.z_long = val; },
            "Property from Fortran struct")
        // Array property: long_wake, type: CPP_wake_sr_mode_ARRAY
        .def_property("long_wake",
            [](const CPP_wake_sr &self) {
                // Get list of struct objects
                
                const auto& arr = self.long_wake;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_wake_sr &self, py::object obj) {
                // Set long_wake from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.long_wake;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_wake_sr_mode>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_wake_sr_mode objects");
                }
                
            },
            "Property from Fortran struct")
        // Array property: trans_wake, type: CPP_wake_sr_mode_ARRAY
        .def_property("trans_wake",
            [](const CPP_wake_sr &self) {
                // Get list of struct objects
                
                const auto& arr = self.trans_wake;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_wake_sr &self, py::object obj) {
                // Set trans_wake from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.trans_wake;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_wake_sr_mode>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_wake_sr_mode objects");
                }
                
            },
            "Property from Fortran struct")
        .def_property("z_ref_long",
            [](const CPP_wake_sr &self) { return self.z_ref_long; },
            [](CPP_wake_sr &self, double val) { self.z_ref_long = val; },
            "z reference value for computing the wake amplitude.")
        .def_property("z_ref_trans",
            [](const CPP_wake_sr &self) { return self.z_ref_trans; },
            [](CPP_wake_sr &self, double val) { self.z_ref_trans = val; },
            "This is used to prevent value overflow with long bunches.")
        .def_property("z_max",
            [](const CPP_wake_sr &self) { return self.z_max; },
            [](CPP_wake_sr &self, double val) { self.z_max = val; },
            "Max allowable z value. 0-> ignore")
        .def_property("amp_scale",
            [](const CPP_wake_sr &self) { return self.amp_scale; },
            [](CPP_wake_sr &self, double val) { self.amp_scale = val; },
            "Wake amplitude scale factor.")
        .def_property("z_scale",
            [](const CPP_wake_sr &self) { return self.z_scale; },
            [](CPP_wake_sr &self, double val) { self.z_scale = val; },
            "z-distance scale factor.")
        .def_property("scale_with_length",
            [](const CPP_wake_sr &self) { return self.scale_with_length; },
            [](CPP_wake_sr &self, bool val) { self.scale_with_length = val; },
            "Scale wake with element length?")
        ;

    py::class_<CPP_wake_lr_mode>(m, "wake_lr_mode", "Fortran struct: wake_lr_mode_struct")
        .def(py::init<>())
        .def_property("freq",
            [](const CPP_wake_lr_mode &self) { return self.freq; },
            [](CPP_wake_lr_mode &self, double val) { self.freq = val; },
            "Actual Frequency in Hz.")
        .def_property("freq_in",
            [](const CPP_wake_lr_mode &self) { return self.freq_in; },
            [](CPP_wake_lr_mode &self, double val) { self.freq_in = val; },
            "Input frequency in Hz.")
        .def_property("r_over_q",
            [](const CPP_wake_lr_mode &self) { return self.r_over_q; },
            [](CPP_wake_lr_mode &self, double val) { self.r_over_q = val; },
            "Strength in V/C/m^(2*m_mode).")
        .def_property("q",
            [](const CPP_wake_lr_mode &self) { return self.q; },
            [](CPP_wake_lr_mode &self, double val) { self.q = val; },
            "Used for backwards compatability.")
        .def_property("damp",
            [](const CPP_wake_lr_mode &self) { return self.damp; },
            [](CPP_wake_lr_mode &self, double val) { self.damp = val; },
            "Damping factor = omega / 2 * Q = pi * freq / Q")
        .def_property("phi",
            [](const CPP_wake_lr_mode &self) { return self.phi; },
            [](CPP_wake_lr_mode &self, double val) { self.phi = val; },
            "Phase in radians/2pi.")
        .def_property("angle",
            [](const CPP_wake_lr_mode &self) { return self.angle; },
            [](CPP_wake_lr_mode &self, double val) { self.angle = val; },
            "polarization angle (radians/2pi).")
        .def_property("b_sin",
            [](const CPP_wake_lr_mode &self) { return self.b_sin; },
            [](CPP_wake_lr_mode &self, double val) { self.b_sin = val; },
            "non-skew sin-like component of the wake.")
        .def_property("b_cos",
            [](const CPP_wake_lr_mode &self) { return self.b_cos; },
            [](CPP_wake_lr_mode &self, double val) { self.b_cos = val; },
            "non-skew cos-like component of the wake.")
        .def_property("a_sin",
            [](const CPP_wake_lr_mode &self) { return self.a_sin; },
            [](CPP_wake_lr_mode &self, double val) { self.a_sin = val; },
            "skew sin-like component of the wake.")
        .def_property("a_cos",
            [](const CPP_wake_lr_mode &self) { return self.a_cos; },
            [](CPP_wake_lr_mode &self, double val) { self.a_cos = val; },
            "skew cos-like component of the wake.")
        .def_property("m",
            [](const CPP_wake_lr_mode &self) { return self.m; },
            [](CPP_wake_lr_mode &self, int val) { self.m = val; },
            "Mode order (1 = dipole, 2 = quad, etc.)")
        .def_property("polarized",
            [](const CPP_wake_lr_mode &self) { return self.polarized; },
            [](CPP_wake_lr_mode &self, bool val) { self.polarized = val; },
            "Polaraized mode?")
        ;

    py::class_<CPP_wake_lr>(m, "wake_lr", "Fortran struct: wake_lr_struct")
        .def(py::init<>())
        .def_property("file",
            [](const CPP_wake_lr &self) { return self.file; },
            [](CPP_wake_lr &self, std::string val) { self.file = val; },
            "Property from Fortran struct")
        // Array property: mode, type: CPP_wake_lr_mode_ARRAY
        .def_property("mode",
            [](const CPP_wake_lr &self) {
                // Get list of struct objects
                
                const auto& arr = self.mode;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_wake_lr &self, py::object obj) {
                // Set mode from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.mode;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_wake_lr_mode>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_wake_lr_mode objects");
                }
                
            },
            "Property from Fortran struct")
        .def_property("t_ref",
            [](const CPP_wake_lr &self) { return self.t_ref; },
            [](CPP_wake_lr &self, double val) { self.t_ref = val; },
            "time reference value for computing the wake amplitude.")
        .def_property("freq_spread",
            [](const CPP_wake_lr &self) { return self.freq_spread; },
            [](CPP_wake_lr &self, double val) { self.freq_spread = val; },
            "Random frequency spread of long range modes.")
        .def_property("amp_scale",
            [](const CPP_wake_lr &self) { return self.amp_scale; },
            [](CPP_wake_lr &self, double val) { self.amp_scale = val; },
            "Wake amplitude scale factor.")
        .def_property("time_scale",
            [](const CPP_wake_lr &self) { return self.time_scale; },
            [](CPP_wake_lr &self, double val) { self.time_scale = val; },
            "time scale factor.")
        .def_property("self_wake_on",
            [](const CPP_wake_lr &self) { return self.self_wake_on; },
            [](CPP_wake_lr &self, bool val) { self.self_wake_on = val; },
            "Long range self-wake used in tracking?")
        ;

    py::class_<CPP_lat_ele_loc>(m, "lat_ele_loc", "Fortran struct: lat_ele_loc_struct")
        .def(py::init<>())
        .def_property("ix_ele",
            [](const CPP_lat_ele_loc &self) { return self.ix_ele; },
            [](CPP_lat_ele_loc &self, int val) { self.ix_ele = val; },
            "Property from Fortran struct")
        .def_property("ix_branch",
            [](const CPP_lat_ele_loc &self) { return self.ix_branch; },
            [](CPP_lat_ele_loc &self, int val) { self.ix_branch = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_wake>(m, "wake", "Fortran struct: wake_struct")
        .def(py::init<>())
        .def_property("sr",
            [](const CPP_wake &self) { return self.sr; },
            [](CPP_wake &self, CPP_wake_sr val) { self.sr = val; },
            "Short-range wake")
        .def_property("lr",
            [](const CPP_wake &self) { return self.lr; },
            [](CPP_wake &self, CPP_wake_lr val) { self.lr = val; },
            "Long-range wake")
        ;

    py::class_<CPP_taylor_term>(m, "taylor_term", "Fortran struct: taylor_term_struct")
        .def(py::init<>())
        .def_property("coef",
            [](const CPP_taylor_term &self) { return self.coef; },
            [](CPP_taylor_term &self, double val) { self.coef = val; },
            "Property from Fortran struct")
        // Array property: expn, type: Int_ARRAY
        .def_property("expn",
            [](const CPP_taylor_term &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.expn;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new int[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<int*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<int>(), {size}, {sizeof(int)}, data, capsule);
                
            },
            [](CPP_taylor_term &self, py::array arr) {
                // Set expn from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.expn.resize(size);
                auto* data = static_cast<int*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.expn[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_taylor>(m, "taylor", "Fortran struct: taylor_struct")
        .def(py::init<>())
        .def_property("ref",
            [](const CPP_taylor &self) { return self.ref; },
            [](CPP_taylor &self, double val) { self.ref = val; },
            "Property from Fortran struct")
        // Array property: term, type: CPP_taylor_term_ARRAY
        .def_property("term",
            [](const CPP_taylor &self) {
                // Get list of struct objects
                
                const auto& arr = self.term;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_taylor &self, py::object obj) {
                // Set term from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.term;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_taylor_term>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_taylor_term objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_em_taylor_term>(m, "em_taylor_term", "Fortran struct: em_taylor_term_struct")
        .def(py::init<>())
        .def_property("coef",
            [](const CPP_em_taylor_term &self) { return self.coef; },
            [](CPP_em_taylor_term &self, double val) { self.coef = val; },
            "Property from Fortran struct")
        // Array property: expn, type: Int_ARRAY
        .def_property("expn",
            [](const CPP_em_taylor_term &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.expn;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new int[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<int*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<int>(), {size}, {sizeof(int)}, data, capsule);
                
            },
            [](CPP_em_taylor_term &self, py::array arr) {
                // Set expn from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.expn.resize(size);
                auto* data = static_cast<int*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.expn[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_em_taylor>(m, "em_taylor", "Fortran struct: em_taylor_struct")
        .def(py::init<>())
        .def_property("ref",
            [](const CPP_em_taylor &self) { return self.ref; },
            [](CPP_em_taylor &self, double val) { self.ref = val; },
            "Property from Fortran struct")
        // Array property: term, type: CPP_em_taylor_term_ARRAY
        .def_property("term",
            [](const CPP_em_taylor &self) {
                // Get list of struct objects
                
                const auto& arr = self.term;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_em_taylor &self, py::object obj) {
                // Set term from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.term;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_em_taylor_term>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_em_taylor_term objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cartesian_map_term1>(m, "cartesian_map_term1", "Fortran struct: cartesian_map_term1_struct")
        .def(py::init<>())
        .def_property("coef",
            [](const CPP_cartesian_map_term1 &self) { return self.coef; },
            [](CPP_cartesian_map_term1 &self, double val) { self.coef = val; },
            "Property from Fortran struct")
        .def_property("kx",
            [](const CPP_cartesian_map_term1 &self) { return self.kx; },
            [](CPP_cartesian_map_term1 &self, double val) { self.kx = val; },
            "Property from Fortran struct")
        .def_property("ky",
            [](const CPP_cartesian_map_term1 &self) { return self.ky; },
            [](CPP_cartesian_map_term1 &self, double val) { self.ky = val; },
            "Property from Fortran struct")
        .def_property("kz",
            [](const CPP_cartesian_map_term1 &self) { return self.kz; },
            [](CPP_cartesian_map_term1 &self, double val) { self.kz = val; },
            "Property from Fortran struct")
        .def_property("x0",
            [](const CPP_cartesian_map_term1 &self) { return self.x0; },
            [](CPP_cartesian_map_term1 &self, double val) { self.x0 = val; },
            "Property from Fortran struct")
        .def_property("y0",
            [](const CPP_cartesian_map_term1 &self) { return self.y0; },
            [](CPP_cartesian_map_term1 &self, double val) { self.y0 = val; },
            "Property from Fortran struct")
        .def_property("phi_z",
            [](const CPP_cartesian_map_term1 &self) { return self.phi_z; },
            [](CPP_cartesian_map_term1 &self, double val) { self.phi_z = val; },
            "Property from Fortran struct")
        .def_property("family",
            [](const CPP_cartesian_map_term1 &self) { return self.family; },
            [](CPP_cartesian_map_term1 &self, int val) { self.family = val; },
            "family_x$, etc.")
        .def_property("form",
            [](const CPP_cartesian_map_term1 &self) { return self.form; },
            [](CPP_cartesian_map_term1 &self, int val) { self.form = val; },
            "hyper_y$, etc.")
        ;

    py::class_<CPP_cartesian_map_term>(m, "cartesian_map_term", "Fortran struct: cartesian_map_term_struct")
        .def(py::init<>())
        .def_property("file",
            [](const CPP_cartesian_map_term &self) { return self.file; },
            [](CPP_cartesian_map_term &self, std::string val) { self.file = val; },
            "Input file name. Used also as ID for instances.")
        .def_property("n_link",
            [](const CPP_cartesian_map_term &self) { return self.n_link; },
            [](CPP_cartesian_map_term &self, int val) { self.n_link = val; },
            "For memory management of %term")
        // Array property: term, type: CPP_cartesian_map_term1_ARRAY
        .def_property("term",
            [](const CPP_cartesian_map_term &self) {
                // Get list of struct objects
                
                const auto& arr = self.term;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_cartesian_map_term &self, py::object obj) {
                // Set term from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.term;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_cartesian_map_term1>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_cartesian_map_term1 objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cartesian_map>(m, "cartesian_map", "Fortran struct: cartesian_map_struct")
        .def(py::init<>())
        .def_property("field_scale",
            [](const CPP_cartesian_map &self) { return self.field_scale; },
            [](CPP_cartesian_map &self, double val) { self.field_scale = val; },
            "Factor to scale the fields by")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_cartesian_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_cartesian_map &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "Field origin offset.")
        .def_property("master_parameter",
            [](const CPP_cartesian_map &self) { return self.master_parameter; },
            [](CPP_cartesian_map &self, int val) { self.master_parameter = val; },
            "Master parameter in ele%value(:) array to use for scaling the field.")
        .def_property("ele_anchor_pt",
            [](const CPP_cartesian_map &self) { return self.ele_anchor_pt; },
            [](CPP_cartesian_map &self, int val) { self.ele_anchor_pt = val; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        .def_property("field_type",
            [](const CPP_cartesian_map &self) { return self.field_type; },
            [](CPP_cartesian_map &self, int val) { self.field_type = val; },
            "or electric$")
        // TODO Skipping ptr: pointer to struct type (CPP_cartesian_map_term)
        ;

    py::class_<CPP_cylindrical_map_term1>(m, "cylindrical_map_term1", "Fortran struct: cylindrical_map_term1_struct")
        .def(py::init<>())
        .def_property("e_coef",
            [](const CPP_cylindrical_map_term1 &self) { return self.e_coef; },
            [](CPP_cylindrical_map_term1 &self, std::complex<double> val) { self.e_coef = val; },
            "Property from Fortran struct")
        .def_property("b_coef",
            [](const CPP_cylindrical_map_term1 &self) { return self.b_coef; },
            [](CPP_cylindrical_map_term1 &self, std::complex<double> val) { self.b_coef = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cylindrical_map_term>(m, "cylindrical_map_term", "Fortran struct: cylindrical_map_term_struct")
        .def(py::init<>())
        .def_property("file",
            [](const CPP_cylindrical_map_term &self) { return self.file; },
            [](CPP_cylindrical_map_term &self, std::string val) { self.file = val; },
            "Input file name. Used also as ID for instances.")
        .def_property("n_link",
            [](const CPP_cylindrical_map_term &self) { return self.n_link; },
            [](CPP_cylindrical_map_term &self, int val) { self.n_link = val; },
            "For memory management of this structure")
        // Array property: term, type: CPP_cylindrical_map_term1_ARRAY
        .def_property("term",
            [](const CPP_cylindrical_map_term &self) {
                // Get list of struct objects
                
                const auto& arr = self.term;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_cylindrical_map_term &self, py::object obj) {
                // Set term from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.term;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_cylindrical_map_term1>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_cylindrical_map_term1 objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_cylindrical_map>(m, "cylindrical_map", "Fortran struct: cylindrical_map_struct")
        .def(py::init<>())
        .def_property("m",
            [](const CPP_cylindrical_map &self) { return self.m; },
            [](CPP_cylindrical_map &self, int val) { self.m = val; },
            "Azimuthal Mode: varies as cos(m*phi - theta0_azimuth)")
        .def_property("harmonic",
            [](const CPP_cylindrical_map &self) { return self.harmonic; },
            [](CPP_cylindrical_map &self, int val) { self.harmonic = val; },
            "Harmonic of fundamental")
        .def_property("phi0_fieldmap",
            [](const CPP_cylindrical_map &self) { return self.phi0_fieldmap; },
            [](CPP_cylindrical_map &self, double val) { self.phi0_fieldmap = val; },
            "Mode oscillates as: twopi * (f * t + phi0_fieldmap)")
        .def_property("theta0_azimuth",
            [](const CPP_cylindrical_map &self) { return self.theta0_azimuth; },
            [](CPP_cylindrical_map &self, double val) { self.theta0_azimuth = val; },
            "Azimuthal ((x, y) plane) orientation of mode.")
        .def_property("field_scale",
            [](const CPP_cylindrical_map &self) { return self.field_scale; },
            [](CPP_cylindrical_map &self, double val) { self.field_scale = val; },
            "Factor to scale the fields by")
        .def_property("master_parameter",
            [](const CPP_cylindrical_map &self) { return self.master_parameter; },
            [](CPP_cylindrical_map &self, int val) { self.master_parameter = val; },
            "Master parameter in ele%value(:) array to use for scaling the field.")
        .def_property("ele_anchor_pt",
            [](const CPP_cylindrical_map &self) { return self.ele_anchor_pt; },
            [](CPP_cylindrical_map &self, int val) { self.ele_anchor_pt = val; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        .def_property("dz",
            [](const CPP_cylindrical_map &self) { return self.dz; },
            [](CPP_cylindrical_map &self, double val) { self.dz = val; },
            "Distance between sampled field points.")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_cylindrical_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_cylindrical_map &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "Field origin offset.")
        // TODO Skipping ptr: pointer to struct type (CPP_cylindrical_map_term)
        ;

    py::class_<CPP_grid_field_pt1>(m, "grid_field_pt1", "Fortran struct: grid_field_pt1_struct")
        .def(py::init<>())
        // Array property: e, type: Complex_ARRAY
        .def_property("e",
            [](const CPP_grid_field_pt1 &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.e;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new std::complex<double>[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<std::complex<double>*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<std::complex<double>>(), {size}, {sizeof(std::complex<double>)}, data, capsule);
                
            },
            [](CPP_grid_field_pt1 &self, py::array arr) {
                // Set e from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.e.resize(size);
                auto* data = static_cast<std::complex<double>*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.e[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: b, type: Complex_ARRAY
        .def_property("b",
            [](const CPP_grid_field_pt1 &self) {
                // Get numpy array from Complex_ARRAY
                const auto& arr = self.b;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new std::complex<double>[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<std::complex<double>*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<std::complex<double>>(), {size}, {sizeof(std::complex<double>)}, data, capsule);
                
            },
            [](CPP_grid_field_pt1 &self, py::array arr) {
                // Set b from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.b.resize(size);
                auto* data = static_cast<std::complex<double>*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.b[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_grid_field_pt>(m, "grid_field_pt", "Fortran struct: grid_field_pt_struct")
        .def(py::init<>())
        .def_property("file",
            [](const CPP_grid_field_pt &self) { return self.file; },
            [](CPP_grid_field_pt &self, std::string val) { self.file = val; },
            "Input file name. Used also as ID for instances.")
        .def_property("n_link",
            [](const CPP_grid_field_pt &self) { return self.n_link; },
            [](CPP_grid_field_pt &self, int val) { self.n_link = val; },
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
        .def_property("geometry",
            [](const CPP_grid_field &self) { return self.geometry; },
            [](CPP_grid_field &self, int val) { self.geometry = val; },
            "Type of grid: xyz$, or rotationally_symmetric_rz$")
        .def_property("harmonic",
            [](const CPP_grid_field &self) { return self.harmonic; },
            [](CPP_grid_field &self, int val) { self.harmonic = val; },
            "Harmonic of fundamental for AC fields.")
        .def_property("phi0_fieldmap",
            [](const CPP_grid_field &self) { return self.phi0_fieldmap; },
            [](CPP_grid_field &self, double val) { self.phi0_fieldmap = val; },
            "Mode oscillates as: twopi * (f * t + phi0_fieldmap)")
        .def_property("field_scale",
            [](const CPP_grid_field &self) { return self.field_scale; },
            [](CPP_grid_field &self, double val) { self.field_scale = val; },
            "Factor to scale the fields by")
        .def_property("field_type",
            [](const CPP_grid_field &self) { return self.field_type; },
            [](CPP_grid_field &self, int val) { self.field_type = val; },
            "or magnetic$ or electric$")
        .def_property("master_parameter",
            [](const CPP_grid_field &self) { return self.master_parameter; },
            [](CPP_grid_field &self, int val) { self.master_parameter = val; },
            "Master parameter in ele%value(:) array to use for scaling the field.")
        .def_property("ele_anchor_pt",
            [](const CPP_grid_field &self) { return self.ele_anchor_pt; },
            [](CPP_grid_field &self, int val) { self.ele_anchor_pt = val; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        .def_property("interpolation_order",
            [](const CPP_grid_field &self) { return self.interpolation_order; },
            [](CPP_grid_field &self, int val) { self.interpolation_order = val; },
            "Possibilities are 1 or 3.")
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_grid_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_grid_field &self, py::array arr) {
                // Set dr from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.dr.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.dr[i] = data[i];
                }
                
            },
            "Grid spacing.")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_grid_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_grid_field &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "Field origin relative to ele_anchor_pt.")
        .def_property("curved_ref_frame",
            [](const CPP_grid_field &self) { return self.curved_ref_frame; },
            [](CPP_grid_field &self, bool val) { self.curved_ref_frame = val; },
            "Property from Fortran struct")
        // TODO Skipping ptr: pointer to struct type (CPP_grid_field_pt)
        ;

    py::class_<CPP_floor_position>(m, "floor_position", "Fortran struct: floor_position_struct")
        .def(py::init<>())
        // Array property: r, type: Real_ARRAY
        .def_property("r",
            [](const CPP_floor_position &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_floor_position &self, py::array arr) {
                // Set r from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r[i] = data[i];
                }
                
            },
            "(x, y, z) offset from origin")
        // Array property: w, type: Real_MATRIX
        .def_property("w",
            [](const CPP_floor_position &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.w;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_floor_position &self, py::array arr) {
                // Set w from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.w.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.w[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.w[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "W matrix. Columns are unit vectors of the frame axes.")
        .def_property("theta",
            [](const CPP_floor_position &self) { return self.theta; },
            [](CPP_floor_position &self, double val) { self.theta = val; },
            "angular orientation consistent with W matrix")
        .def_property("phi",
            [](const CPP_floor_position &self) { return self.phi; },
            [](CPP_floor_position &self, double val) { self.phi = val; },
            "angular orientation consistent with W matrix")
        .def_property("psi",
            [](const CPP_floor_position &self) { return self.psi; },
            [](CPP_floor_position &self, double val) { self.psi = val; },
            "angular orientation consistent with W matrix")
        ;

    py::class_<CPP_high_energy_space_charge>(m, "high_energy_space_charge", "Fortran struct: high_energy_space_charge_struct")
        .def(py::init<>())
        .def_property("closed_orb",
            [](const CPP_high_energy_space_charge &self) { return self.closed_orb; },
            [](CPP_high_energy_space_charge &self, CPP_coord val) { self.closed_orb = val; },
            "beam orbit")
        .def_property("kick_const",
            [](const CPP_high_energy_space_charge &self) { return self.kick_const; },
            [](CPP_high_energy_space_charge &self, double val) { self.kick_const = val; },
            "Property from Fortran struct")
        .def_property("sig_x",
            [](const CPP_high_energy_space_charge &self) { return self.sig_x; },
            [](CPP_high_energy_space_charge &self, double val) { self.sig_x = val; },
            "Property from Fortran struct")
        .def_property("sig_y",
            [](const CPP_high_energy_space_charge &self) { return self.sig_y; },
            [](CPP_high_energy_space_charge &self, double val) { self.sig_y = val; },
            "Property from Fortran struct")
        .def_property("phi",
            [](const CPP_high_energy_space_charge &self) { return self.phi; },
            [](CPP_high_energy_space_charge &self, double val) { self.phi = val; },
            "Rotation angle to go from lab frame to rotated frame.")
        .def_property("sin_phi",
            [](const CPP_high_energy_space_charge &self) { return self.sin_phi; },
            [](CPP_high_energy_space_charge &self, double val) { self.sin_phi = val; },
            "Property from Fortran struct")
        .def_property("cos_phi",
            [](const CPP_high_energy_space_charge &self) { return self.cos_phi; },
            [](CPP_high_energy_space_charge &self, double val) { self.cos_phi = val; },
            "Property from Fortran struct")
        .def_property("sig_z",
            [](const CPP_high_energy_space_charge &self) { return self.sig_z; },
            [](CPP_high_energy_space_charge &self, double val) { self.sig_z = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_xy_disp>(m, "xy_disp", "Fortran struct: xy_disp_struct")
        .def(py::init<>())
        .def_property("eta",
            [](const CPP_xy_disp &self) { return self.eta; },
            [](CPP_xy_disp &self, double val) { self.eta = val; },
            "Property from Fortran struct")
        .def_property("etap",
            [](const CPP_xy_disp &self) { return self.etap; },
            [](CPP_xy_disp &self, double val) { self.etap = val; },
            "Property from Fortran struct")
        .def_property("deta_ds",
            [](const CPP_xy_disp &self) { return self.deta_ds; },
            [](CPP_xy_disp &self, double val) { self.deta_ds = val; },
            "Property from Fortran struct")
        .def_property("sigma",
            [](const CPP_xy_disp &self) { return self.sigma; },
            [](CPP_xy_disp &self, double val) { self.sigma = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_twiss>(m, "twiss", "Fortran struct: twiss_struct")
        .def(py::init<>())
        .def_property("beta",
            [](const CPP_twiss &self) { return self.beta; },
            [](CPP_twiss &self, double val) { self.beta = val; },
            "Property from Fortran struct")
        .def_property("alpha",
            [](const CPP_twiss &self) { return self.alpha; },
            [](CPP_twiss &self, double val) { self.alpha = val; },
            "Property from Fortran struct")
        .def_property("gamma",
            [](const CPP_twiss &self) { return self.gamma; },
            [](CPP_twiss &self, double val) { self.gamma = val; },
            "Property from Fortran struct")
        .def_property("phi",
            [](const CPP_twiss &self) { return self.phi; },
            [](CPP_twiss &self, double val) { self.phi = val; },
            "Property from Fortran struct")
        .def_property("eta",
            [](const CPP_twiss &self) { return self.eta; },
            [](CPP_twiss &self, double val) { self.eta = val; },
            "Property from Fortran struct")
        .def_property("etap",
            [](const CPP_twiss &self) { return self.etap; },
            [](CPP_twiss &self, double val) { self.etap = val; },
            "Property from Fortran struct")
        .def_property("deta_ds",
            [](const CPP_twiss &self) { return self.deta_ds; },
            [](CPP_twiss &self, double val) { self.deta_ds = val; },
            "Property from Fortran struct")
        .def_property("sigma",
            [](const CPP_twiss &self) { return self.sigma; },
            [](CPP_twiss &self, double val) { self.sigma = val; },
            "Property from Fortran struct")
        .def_property("sigma_p",
            [](const CPP_twiss &self) { return self.sigma_p; },
            [](CPP_twiss &self, double val) { self.sigma_p = val; },
            "Property from Fortran struct")
        .def_property("emit",
            [](const CPP_twiss &self) { return self.emit; },
            [](CPP_twiss &self, double val) { self.emit = val; },
            "Property from Fortran struct")
        .def_property("norm_emit",
            [](const CPP_twiss &self) { return self.norm_emit; },
            [](CPP_twiss &self, double val) { self.norm_emit = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_mode3>(m, "mode3", "Fortran struct: mode3_struct")
        .def(py::init<>())
        // Array property: v, type: Real_MATRIX
        .def_property("v",
            [](const CPP_mode3 &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.v;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_mode3 &self, py::array arr) {
                // Set v from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.v.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.v[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.v[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "Property from Fortran struct")
        .def_property("a",
            [](const CPP_mode3 &self) { return self.a; },
            [](CPP_mode3 &self, CPP_twiss val) { self.a = val; },
            "Property from Fortran struct")
        .def_property("b",
            [](const CPP_mode3 &self) { return self.b; },
            [](CPP_mode3 &self, CPP_twiss val) { self.b = val; },
            "Property from Fortran struct")
        .def_property("c",
            [](const CPP_mode3 &self) { return self.c; },
            [](CPP_mode3 &self, CPP_twiss val) { self.c = val; },
            "Property from Fortran struct")
        .def_property("x",
            [](const CPP_mode3 &self) { return self.x; },
            [](CPP_mode3 &self, CPP_twiss val) { self.x = val; },
            "Property from Fortran struct")
        .def_property("y",
            [](const CPP_mode3 &self) { return self.y; },
            [](CPP_mode3 &self, CPP_twiss val) { self.y = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_bookkeeping_state>(m, "bookkeeping_state", "Fortran struct: bookkeeping_state_struct")
        .def(py::init<>())
        .def_property("attributes",
            [](const CPP_bookkeeping_state &self) { return self.attributes; },
            [](CPP_bookkeeping_state &self, int val) { self.attributes = val; },
            "Element dependent attributes: super_ok$, ok$ or stale$")
        .def_property("control",
            [](const CPP_bookkeeping_state &self) { return self.control; },
            [](CPP_bookkeeping_state &self, int val) { self.control = val; },
            "Lord/slave bookkeeping status: super_ok$, ok$ or stale$")
        .def_property("floor_position",
            [](const CPP_bookkeeping_state &self) { return self.floor_position; },
            [](CPP_bookkeeping_state &self, int val) { self.floor_position = val; },
            "Global (floor) geometry: super_ok$, ok$ or stale$")
        .def_property("s_position",
            [](const CPP_bookkeeping_state &self) { return self.s_position; },
            [](CPP_bookkeeping_state &self, int val) { self.s_position = val; },
            "Longitudinal position & element length: super_ok$, ok$ or stale$")
        .def_property("ref_energy",
            [](const CPP_bookkeeping_state &self) { return self.ref_energy; },
            [](CPP_bookkeeping_state &self, int val) { self.ref_energy = val; },
            "Reference energy and ref time: super_ok$, ok$ or stale$")
        .def_property("mat6",
            [](const CPP_bookkeeping_state &self) { return self.mat6; },
            [](CPP_bookkeeping_state &self, int val) { self.mat6 = val; },
            "Linear transfer map status: super_ok$, ok$ or stale$")
        .def_property("rad_int",
            [](const CPP_bookkeeping_state &self) { return self.rad_int; },
            [](CPP_bookkeeping_state &self, int val) { self.rad_int = val; },
            "Radiation integrals cache status")
        .def_property("ptc",
            [](const CPP_bookkeeping_state &self) { return self.ptc; },
            [](CPP_bookkeeping_state &self, int val) { self.ptc = val; },
            "Associated PTC fibre (or layout) status.")
        .def_property("has_misalign",
            [](const CPP_bookkeeping_state &self) { return self.has_misalign; },
            [](CPP_bookkeeping_state &self, bool val) { self.has_misalign = val; },
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set ref_orb from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.ref_orb.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.ref_orb[i] = data[i];
                }
                
            },
            "Reference point around which damp_mat is calculated.")
        // Array property: damp_dmat, type: Real_MATRIX
        .def_property("damp_dmat",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.damp_dmat;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set damp_dmat from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.damp_dmat.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.damp_dmat[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.damp_dmat[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "damp_correction = xfer_mat_with_damping - xfer_mat_without_damping.")
        // Array property: xfer_damp_vec, type: Real_ARRAY
        .def_property("xfer_damp_vec",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.xfer_damp_vec;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set xfer_damp_vec from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.xfer_damp_vec.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.xfer_damp_vec[i] = data[i];
                }
                
            },
            "Transfer map with damping 0th order vector.")
        // Array property: xfer_damp_mat, type: Real_MATRIX
        .def_property("xfer_damp_mat",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.xfer_damp_mat;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set xfer_damp_mat from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.xfer_damp_mat.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.xfer_damp_mat[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.xfer_damp_mat[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "1st order matrix: xfer_no_damp_mat + xfer_damp_correction.")
        // Array property: stoc_mat, type: Real_MATRIX
        .def_property("stoc_mat",
            [](const CPP_rad_map &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.stoc_mat;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_rad_map &self, py::array arr) {
                // Set stoc_mat from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.stoc_mat.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.stoc_mat[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.stoc_mat[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "Stochastic variance or 'kick' (Cholesky decomposed) matrix.")
        ;

    py::class_<CPP_rad_map_ele>(m, "rad_map_ele", "Fortran struct: rad_map_ele_struct")
        .def(py::init<>())
        .def_property("rm0",
            [](const CPP_rad_map_ele &self) { return self.rm0; },
            [](CPP_rad_map_ele &self, CPP_rad_map val) { self.rm0 = val; },
            "Upstream half and downstream half matrices for an element.")
        .def_property("rm1",
            [](const CPP_rad_map_ele &self) { return self.rm1; },
            [](CPP_rad_map_ele &self, CPP_rad_map val) { self.rm1 = val; },
            "Upstream half and downstream half matrices for an element.")
        .def_property("stale",
            [](const CPP_rad_map_ele &self) { return self.stale; },
            [](CPP_rad_map_ele &self, bool val) { self.stale = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_gen_grad1>(m, "gen_grad1", "Fortran struct: gen_grad1_struct")
        .def(py::init<>())
        .def_property("m",
            [](const CPP_gen_grad1 &self) { return self.m; },
            [](CPP_gen_grad1 &self, int val) { self.m = val; },
            "Azimuthal index")
        .def_property("sincos",
            [](const CPP_gen_grad1 &self) { return self.sincos; },
            [](CPP_gen_grad1 &self, int val) { self.sincos = val; },
            "sin$ or cos$")
        .def_property("n_deriv_max",
            [](const CPP_gen_grad1 &self) { return self.n_deriv_max; },
            [](CPP_gen_grad1 &self, int val) { self.n_deriv_max = val; },
            "Max GG derivative")
        // Array property: deriv, type: Real_MATRIX
        .def_property("deriv",
            [](const CPP_gen_grad1 &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.deriv;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_gen_grad1 &self, py::array arr) {
                // Set deriv from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.deriv.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.deriv[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.deriv[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "Range: (iz0:iz1, 0:2*n_deriv_max+1)")
        ;

    py::class_<CPP_gen_grad_map>(m, "gen_grad_map", "Fortran struct: gen_grad_map_struct")
        .def(py::init<>())
        .def_property("file",
            [](const CPP_gen_grad_map &self) { return self.file; },
            [](CPP_gen_grad_map &self, std::string val) { self.file = val; },
            "Input file name. Used also as ID for instances.")
        // Array property: gg, type: CPP_gen_grad1_ARRAY
        .def_property("gg",
            [](const CPP_gen_grad_map &self) {
                // Get list of struct objects
                
                const auto& arr = self.gg;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_gen_grad_map &self, py::object obj) {
                // Set gg from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.gg;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_gen_grad1>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_gen_grad1 objects");
                }
                
            },
            "Property from Fortran struct")
        .def_property("ele_anchor_pt",
            [](const CPP_gen_grad_map &self) { return self.ele_anchor_pt; },
            [](CPP_gen_grad_map &self, int val) { self.ele_anchor_pt = val; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        .def_property("field_type",
            [](const CPP_gen_grad_map &self) { return self.field_type; },
            [](CPP_gen_grad_map &self, int val) { self.field_type = val; },
            "or electric$")
        .def_property("iz0",
            [](const CPP_gen_grad_map &self) { return self.iz0; },
            [](CPP_gen_grad_map &self, int val) { self.iz0 = val; },
            "gg%deriv(iz0:iz1, :) lower bound.")
        .def_property("iz1",
            [](const CPP_gen_grad_map &self) { return self.iz1; },
            [](CPP_gen_grad_map &self, int val) { self.iz1 = val; },
            "gg%deriv(iz0:iz1, :) upper bound.")
        .def_property("dz",
            [](const CPP_gen_grad_map &self) { return self.dz; },
            [](CPP_gen_grad_map &self, double val) { self.dz = val; },
            "Point spacing.")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_gen_grad_map &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_gen_grad_map &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "field origin relative to ele_anchor_pt.")
        .def_property("field_scale",
            [](const CPP_gen_grad_map &self) { return self.field_scale; },
            [](CPP_gen_grad_map &self, double val) { self.field_scale = val; },
            "Factor to scale the fields by")
        .def_property("master_parameter",
            [](const CPP_gen_grad_map &self) { return self.master_parameter; },
            [](CPP_gen_grad_map &self, int val) { self.master_parameter = val; },
            "Master parameter in ele%value(:) array to use for scaling the field.")
        .def_property("curved_ref_frame",
            [](const CPP_gen_grad_map &self) { return self.curved_ref_frame; },
            [](CPP_gen_grad_map &self, bool val) { self.curved_ref_frame = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_surface_segmented_pt>(m, "surface_segmented_pt", "Fortran struct: surface_segmented_pt_struct")
        .def(py::init<>())
        .def_property("x0",
            [](const CPP_surface_segmented_pt &self) { return self.x0; },
            [](CPP_surface_segmented_pt &self, double val) { self.x0 = val; },
            "Position at center")
        .def_property("y0",
            [](const CPP_surface_segmented_pt &self) { return self.y0; },
            [](CPP_surface_segmented_pt &self, double val) { self.y0 = val; },
            "Position at center")
        .def_property("z0",
            [](const CPP_surface_segmented_pt &self) { return self.z0; },
            [](CPP_surface_segmented_pt &self, double val) { self.z0 = val; },
            "Position at center")
        .def_property("dz_dx",
            [](const CPP_surface_segmented_pt &self) { return self.dz_dx; },
            [](CPP_surface_segmented_pt &self, double val) { self.dz_dx = val; },
            "Slope at center")
        .def_property("dz_dy",
            [](const CPP_surface_segmented_pt &self) { return self.dz_dy; },
            [](CPP_surface_segmented_pt &self, double val) { self.dz_dy = val; },
            "Slope at center")
        ;

    py::class_<CPP_surface_segmented>(m, "surface_segmented", "Fortran struct: surface_segmented_struct")
        .def(py::init<>())
        .def_property("active",
            [](const CPP_surface_segmented &self) { return self.active; },
            [](CPP_surface_segmented &self, bool val) { self.active = val; },
            "Property from Fortran struct")
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_surface_segmented &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_surface_segmented &self, py::array arr) {
                // Set dr from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.dr.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.dr[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_surface_segmented &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_surface_segmented &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: pt, type: CPP_surface_segmented_pt_MATRIX
        .def_property("pt",
            [](const CPP_surface_segmented &self) {
                // Get list of struct objects
                
                const auto& matrix = self.pt;
                py::list result;
                for (size_t i = 0; i < matrix.size(); ++i) {
                    py::list row;
                    for (size_t j = 0; j < matrix[i].size(); ++j) {
                        row.append(py::cast(matrix[i][j]));
                    }
                    result.append(row);
                }
                return result;
                
            },
            [](CPP_surface_segmented &self, py::object obj) {
                // Set pt from list of structs
                
                try {
                    py::list outer_list = obj.cast<py::list>();
                    auto& matrix = self.pt;
                    matrix.resize(outer_list.size());
                    
                    for (size_t i = 0; i < outer_list.size(); ++i) {
                        py::list inner_list = outer_list[i].cast<py::list>();
                        matrix[i].resize(inner_list.size());
                        
                        for (size_t j = 0; j < inner_list.size(); ++j) {
                            matrix[i][j] = inner_list[j].cast<CPP_surface_segmented_pt>();
                        }
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of lists of CPP_surface_segmented_pt objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_surface_h_misalign_pt>(m, "surface_h_misalign_pt", "Fortran struct: surface_h_misalign_pt_struct")
        .def(py::init<>())
        .def_property("x0",
            [](const CPP_surface_h_misalign_pt &self) { return self.x0; },
            [](CPP_surface_h_misalign_pt &self, double val) { self.x0 = val; },
            "Position at center")
        .def_property("y0",
            [](const CPP_surface_h_misalign_pt &self) { return self.y0; },
            [](CPP_surface_h_misalign_pt &self, double val) { self.y0 = val; },
            "Position at center")
        .def_property("rot_y",
            [](const CPP_surface_h_misalign_pt &self) { return self.rot_y; },
            [](CPP_surface_h_misalign_pt &self, double val) { self.rot_y = val; },
            "rot_t = x-rotation for Bragg and z-rotation for Laue.")
        .def_property("rot_t",
            [](const CPP_surface_h_misalign_pt &self) { return self.rot_t; },
            [](CPP_surface_h_misalign_pt &self, double val) { self.rot_t = val; },
            "rot_t = x-rotation for Bragg and z-rotation for Laue.")
        .def_property("rot_y_rms",
            [](const CPP_surface_h_misalign_pt &self) { return self.rot_y_rms; },
            [](CPP_surface_h_misalign_pt &self, double val) { self.rot_y_rms = val; },
            "rot_t = x-rotation for Bragg and z-rotation for Laue.")
        .def_property("rot_t_rms",
            [](const CPP_surface_h_misalign_pt &self) { return self.rot_t_rms; },
            [](CPP_surface_h_misalign_pt &self, double val) { self.rot_t_rms = val; },
            "rot_t = x-rotation for Bragg and z-rotation for Laue.")
        ;

    py::class_<CPP_surface_h_misalign>(m, "surface_h_misalign", "Fortran struct: surface_h_misalign_struct")
        .def(py::init<>())
        .def_property("active",
            [](const CPP_surface_h_misalign &self) { return self.active; },
            [](CPP_surface_h_misalign &self, bool val) { self.active = val; },
            "Property from Fortran struct")
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_surface_h_misalign &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_surface_h_misalign &self, py::array arr) {
                // Set dr from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.dr.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.dr[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_surface_h_misalign &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_surface_h_misalign &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: pt, type: CPP_surface_h_misalign_pt_MATRIX
        .def_property("pt",
            [](const CPP_surface_h_misalign &self) {
                // Get list of struct objects
                
                const auto& matrix = self.pt;
                py::list result;
                for (size_t i = 0; i < matrix.size(); ++i) {
                    py::list row;
                    for (size_t j = 0; j < matrix[i].size(); ++j) {
                        row.append(py::cast(matrix[i][j]));
                    }
                    result.append(row);
                }
                return result;
                
            },
            [](CPP_surface_h_misalign &self, py::object obj) {
                // Set pt from list of structs
                
                try {
                    py::list outer_list = obj.cast<py::list>();
                    auto& matrix = self.pt;
                    matrix.resize(outer_list.size());
                    
                    for (size_t i = 0; i < outer_list.size(); ++i) {
                        py::list inner_list = outer_list[i].cast<py::list>();
                        matrix[i].resize(inner_list.size());
                        
                        for (size_t j = 0; j < inner_list.size(); ++j) {
                            matrix[i][j] = inner_list[j].cast<CPP_surface_h_misalign_pt>();
                        }
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of lists of CPP_surface_h_misalign_pt objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_surface_displacement_pt>(m, "surface_displacement_pt", "Fortran struct: surface_displacement_pt_struct")
        .def(py::init<>())
        .def_property("x0",
            [](const CPP_surface_displacement_pt &self) { return self.x0; },
            [](CPP_surface_displacement_pt &self, double val) { self.x0 = val; },
            "Position at center")
        .def_property("y0",
            [](const CPP_surface_displacement_pt &self) { return self.y0; },
            [](CPP_surface_displacement_pt &self, double val) { self.y0 = val; },
            "Position at center")
        .def_property("z0",
            [](const CPP_surface_displacement_pt &self) { return self.z0; },
            [](CPP_surface_displacement_pt &self, double val) { self.z0 = val; },
            "Property from Fortran struct")
        .def_property("dz_dx",
            [](const CPP_surface_displacement_pt &self) { return self.dz_dx; },
            [](CPP_surface_displacement_pt &self, double val) { self.dz_dx = val; },
            "Property from Fortran struct")
        .def_property("dz_dy",
            [](const CPP_surface_displacement_pt &self) { return self.dz_dy; },
            [](CPP_surface_displacement_pt &self, double val) { self.dz_dy = val; },
            "Property from Fortran struct")
        .def_property("d2z_dxdy",
            [](const CPP_surface_displacement_pt &self) { return self.d2z_dxdy; },
            [](CPP_surface_displacement_pt &self, double val) { self.d2z_dxdy = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_surface_displacement>(m, "surface_displacement", "Fortran struct: surface_displacement_struct")
        .def(py::init<>())
        .def_property("active",
            [](const CPP_surface_displacement &self) { return self.active; },
            [](CPP_surface_displacement &self, bool val) { self.active = val; },
            "Property from Fortran struct")
        // Array property: dr, type: Real_ARRAY
        .def_property("dr",
            [](const CPP_surface_displacement &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.dr;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_surface_displacement &self, py::array arr) {
                // Set dr from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.dr.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.dr[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_surface_displacement &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_surface_displacement &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: pt, type: CPP_surface_displacement_pt_MATRIX
        .def_property("pt",
            [](const CPP_surface_displacement &self) {
                // Get list of struct objects
                
                const auto& matrix = self.pt;
                py::list result;
                for (size_t i = 0; i < matrix.size(); ++i) {
                    py::list row;
                    for (size_t j = 0; j < matrix[i].size(); ++j) {
                        row.append(py::cast(matrix[i][j]));
                    }
                    result.append(row);
                }
                return result;
                
            },
            [](CPP_surface_displacement &self, py::object obj) {
                // Set pt from list of structs
                
                try {
                    py::list outer_list = obj.cast<py::list>();
                    auto& matrix = self.pt;
                    matrix.resize(outer_list.size());
                    
                    for (size_t i = 0; i < outer_list.size(); ++i) {
                        py::list inner_list = outer_list[i].cast<py::list>();
                        matrix[i].resize(inner_list.size());
                        
                        for (size_t j = 0; j < inner_list.size(); ++j) {
                            matrix[i][j] = inner_list[j].cast<CPP_surface_displacement_pt>();
                        }
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of lists of CPP_surface_displacement_pt objects");
                }
                
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_target_point &self, py::array arr) {
                // Set r from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r[i] = data[i];
                }
                
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
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_surface_curvature &self, py::array arr) {
                // Set xy from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.xy.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.xy[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.xy[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "Property from Fortran struct")
        .def_property("spherical",
            [](const CPP_surface_curvature &self) { return self.spherical; },
            [](CPP_surface_curvature &self, double val) { self.spherical = val; },
            "Property from Fortran struct")
        // Array property: elliptical, type: Real_ARRAY
        .def_property("elliptical",
            [](const CPP_surface_curvature &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.elliptical;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_surface_curvature &self, py::array arr) {
                // Set elliptical from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.elliptical.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.elliptical[i] = data[i];
                }
                
            },
            "Total curvature = elliptical + spherical")
        .def_property("has_curvature",
            [](const CPP_surface_curvature &self) { return self.has_curvature; },
            [](CPP_surface_curvature &self, bool val) { self.has_curvature = val; },
            "Dependent var. Will be set by Bmad")
        ;

    py::class_<CPP_photon_target>(m, "photon_target", "Fortran struct: photon_target_struct")
        .def(py::init<>())
        .def_property("type",
            [](const CPP_photon_target &self) { return self.type; },
            [](CPP_photon_target &self, int val) { self.type = val; },
            "or rectangular$")
        .def_property("n_corner",
            [](const CPP_photon_target &self) { return self.n_corner; },
            [](CPP_photon_target &self, int val) { self.n_corner = val; },
            "Property from Fortran struct")
        .def_property("ele_loc",
            [](const CPP_photon_target &self) { return self.ele_loc; },
            [](CPP_photon_target &self, CPP_lat_ele_loc val) { self.ele_loc = val; },
            "Property from Fortran struct")
        // Array property: corner, type: CPP_target_point_ARRAY
        .def_property("corner",
            [](const CPP_photon_target &self) {
                // Get list of struct objects
                
                const auto& arr = self.corner;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_photon_target &self, py::object obj) {
                // Set corner from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.corner;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_target_point>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_target_point objects");
                }
                
            },
            "Property from Fortran struct")
        .def_property("center",
            [](const CPP_photon_target &self) { return self.center; },
            [](CPP_photon_target &self, CPP_target_point val) { self.center = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_photon_material>(m, "photon_material", "Fortran struct: photon_material_struct")
        .def(py::init<>())
        .def_property("f0_m1",
            [](const CPP_photon_material &self) { return self.f0_m1; },
            [](CPP_photon_material &self, std::complex<double> val) { self.f0_m1 = val; },
            "For multilayer_mirror only.")
        .def_property("f0_m2",
            [](const CPP_photon_material &self) { return self.f0_m2; },
            [](CPP_photon_material &self, std::complex<double> val) { self.f0_m2 = val; },
            "For multilayer_mirror only.")
        .def_property("f_0",
            [](const CPP_photon_material &self) { return self.f_0; },
            [](CPP_photon_material &self, std::complex<double> val) { self.f_0 = val; },
            "Property from Fortran struct")
        .def_property("f_h",
            [](const CPP_photon_material &self) { return self.f_h; },
            [](CPP_photon_material &self, std::complex<double> val) { self.f_h = val; },
            "Structure factor for H direction.")
        .def_property("f_hbar",
            [](const CPP_photon_material &self) { return self.f_hbar; },
            [](CPP_photon_material &self, std::complex<double> val) { self.f_hbar = val; },
            "Structure factor for -H direction.")
        .def_property("f_hkl",
            [](const CPP_photon_material &self) { return self.f_hkl; },
            [](CPP_photon_material &self, std::complex<double> val) { self.f_hkl = val; },
            "= sqrt(f_h * f_hbar)")
        // Array property: h_norm, type: Real_ARRAY
        .def_property("h_norm",
            [](const CPP_photon_material &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.h_norm;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_photon_material &self, py::array arr) {
                // Set h_norm from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.h_norm.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.h_norm[i] = data[i];
                }
                
            },
            "Normalized H vector for crystals.")
        // Array property: l_ref, type: Real_ARRAY
        .def_property("l_ref",
            [](const CPP_photon_material &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.l_ref;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_photon_material &self, py::array arr) {
                // Set l_ref from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.l_ref.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.l_ref[i] = data[i];
                }
                
            },
            "Crystal reference orbit displacement vector in element coords.")
        ;

    py::class_<CPP_pixel_pt>(m, "pixel_pt", "Fortran struct: pixel_pt_struct")
        .def(py::init<>())
        .def_property("n_photon",
            [](const CPP_pixel_pt &self) { return self.n_photon; },
            [](CPP_pixel_pt &self, int64_t val) { self.n_photon = val; },
            "Property from Fortran struct")
        .def_property("e_x",
            [](const CPP_pixel_pt &self) { return self.e_x; },
            [](CPP_pixel_pt &self, std::complex<double> val) { self.e_x = val; },
            "Property from Fortran struct")
        .def_property("e_y",
            [](const CPP_pixel_pt &self) { return self.e_y; },
            [](CPP_pixel_pt &self, std::complex<double> val) { self.e_y = val; },
            "Property from Fortran struct")
        .def_property("intensity_x",
            [](const CPP_pixel_pt &self) { return self.intensity_x; },
            [](CPP_pixel_pt &self, double val) { self.intensity_x = val; },
            "Property from Fortran struct")
        .def_property("intensity_y",
            [](const CPP_pixel_pt &self) { return self.intensity_y; },
            [](CPP_pixel_pt &self, double val) { self.intensity_y = val; },
            "Property from Fortran struct")
        .def_property("intensity",
            [](const CPP_pixel_pt &self) { return self.intensity; },
            [](CPP_pixel_pt &self, double val) { self.intensity = val; },
            "Property from Fortran struct")
        // Array property: orbit, type: Real_ARRAY
        .def_property("orbit",
            [](const CPP_pixel_pt &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.orbit;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_pixel_pt &self, py::array arr) {
                // Set orbit from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.orbit.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.orbit[i] = data[i];
                }
                
            },
            "x, Vx/c, y, Vy/c, dummy, E - E_ref.")
        // Array property: orbit_rms, type: Real_ARRAY
        .def_property("orbit_rms",
            [](const CPP_pixel_pt &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.orbit_rms;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_pixel_pt &self, py::array arr) {
                // Set orbit_rms from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.orbit_rms.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.orbit_rms[i] = data[i];
                }
                
            },
            "RMS statistics.")
        // Array property: init_orbit, type: Real_ARRAY
        .def_property("init_orbit",
            [](const CPP_pixel_pt &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.init_orbit;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_pixel_pt &self, py::array arr) {
                // Set init_orbit from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.init_orbit.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.init_orbit[i] = data[i];
                }
                
            },
            "Initial orbit at start of lattice statistics.")
        // Array property: init_orbit_rms, type: Real_ARRAY
        .def_property("init_orbit_rms",
            [](const CPP_pixel_pt &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.init_orbit_rms;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_pixel_pt &self, py::array arr) {
                // Set init_orbit_rms from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.init_orbit_rms.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.init_orbit_rms[i] = data[i];
                }
                
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_pixel_detec &self, py::array arr) {
                // Set dr from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.dr.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.dr[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_pixel_detec &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_pixel_detec &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        .def_property("n_track_tot",
            [](const CPP_pixel_detec &self) { return self.n_track_tot; },
            [](CPP_pixel_detec &self, int64_t val) { self.n_track_tot = val; },
            "How many photons were launched from source element.")
        .def_property("n_hit_detec",
            [](const CPP_pixel_detec &self) { return self.n_hit_detec; },
            [](CPP_pixel_detec &self, int64_t val) { self.n_hit_detec = val; },
            "How many photons hit the detector.")
        .def_property("n_hit_pixel",
            [](const CPP_pixel_detec &self) { return self.n_hit_pixel; },
            [](CPP_pixel_detec &self, int64_t val) { self.n_hit_pixel = val; },
            "How many photons hit the pixel grid of the detector.")
        // Array property: pt, type: CPP_pixel_pt_MATRIX
        .def_property("pt",
            [](const CPP_pixel_detec &self) {
                // Get list of struct objects
                
                const auto& matrix = self.pt;
                py::list result;
                for (size_t i = 0; i < matrix.size(); ++i) {
                    py::list row;
                    for (size_t j = 0; j < matrix[i].size(); ++j) {
                        row.append(py::cast(matrix[i][j]));
                    }
                    result.append(row);
                }
                return result;
                
            },
            [](CPP_pixel_detec &self, py::object obj) {
                // Set pt from list of structs
                
                try {
                    py::list outer_list = obj.cast<py::list>();
                    auto& matrix = self.pt;
                    matrix.resize(outer_list.size());
                    
                    for (size_t i = 0; i < outer_list.size(); ++i) {
                        py::list inner_list = outer_list[i].cast<py::list>();
                        matrix[i].resize(inner_list.size());
                        
                        for (size_t j = 0; j < inner_list.size(); ++j) {
                            matrix[i][j] = inner_list[j].cast<CPP_pixel_pt>();
                        }
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of lists of CPP_pixel_pt objects");
                }
                
            },
            "Grid of pixels")
        ;

    py::class_<CPP_photon_element>(m, "photon_element", "Fortran struct: photon_element_struct")
        .def(py::init<>())
        .def_property("curvature",
            [](const CPP_photon_element &self) { return self.curvature; },
            [](CPP_photon_element &self, CPP_surface_curvature val) { self.curvature = val; },
            "Property from Fortran struct")
        .def_property("target",
            [](const CPP_photon_element &self) { return self.target; },
            [](CPP_photon_element &self, CPP_photon_target val) { self.target = val; },
            "Property from Fortran struct")
        .def_property("material",
            [](const CPP_photon_element &self) { return self.material; },
            [](CPP_photon_element &self, CPP_photon_material val) { self.material = val; },
            "Property from Fortran struct")
        .def_property("segmented",
            [](const CPP_photon_element &self) { return self.segmented; },
            [](CPP_photon_element &self, CPP_surface_segmented val) { self.segmented = val; },
            "Property from Fortran struct")
        .def_property("h_misalign",
            [](const CPP_photon_element &self) { return self.h_misalign; },
            [](CPP_photon_element &self, CPP_surface_h_misalign val) { self.h_misalign = val; },
            "Property from Fortran struct")
        .def_property("displacement",
            [](const CPP_photon_element &self) { return self.displacement; },
            [](CPP_photon_element &self, CPP_surface_displacement val) { self.displacement = val; },
            "Property from Fortran struct")
        .def_property("pixel",
            [](const CPP_photon_element &self) { return self.pixel; },
            [](CPP_photon_element &self, CPP_pixel_detec val) { self.pixel = val; },
            "Property from Fortran struct")
        .def_property("reflectivity_table_type",
            [](const CPP_photon_element &self) { return self.reflectivity_table_type; },
            [](CPP_photon_element &self, int val) { self.reflectivity_table_type = val; },
            "Property from Fortran struct")
        .def_property("reflectivity_table_sigma",
            [](const CPP_photon_element &self) { return self.reflectivity_table_sigma; },
            [](CPP_photon_element &self, CPP_photon_reflect_table val) { self.reflectivity_table_sigma = val; },
            "If polarization is ignored use sigma table.")
        .def_property("reflectivity_table_pi",
            [](const CPP_photon_element &self) { return self.reflectivity_table_pi; },
            [](CPP_photon_element &self, CPP_photon_reflect_table val) { self.reflectivity_table_pi = val; },
            "Property from Fortran struct")
        // Array property: init_energy_prob, type: CPP_spline_ARRAY
        .def_property("init_energy_prob",
            [](const CPP_photon_element &self) {
                // Get list of struct objects
                
                const auto& arr = self.init_energy_prob;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_photon_element &self, py::object obj) {
                // Set init_energy_prob from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.init_energy_prob;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_spline>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_spline objects");
                }
                
            },
            "Initial energy probability density")
        // Array property: integrated_init_energy_prob, type: Real_ARRAY
        .def_property("integrated_init_energy_prob",
            [](const CPP_photon_element &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.integrated_init_energy_prob;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_photon_element &self, py::array arr) {
                // Set integrated_init_energy_prob from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.integrated_init_energy_prob.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.integrated_init_energy_prob[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_wall3d_vertex>(m, "wall3d_vertex", "Fortran struct: wall3d_vertex_struct")
        .def(py::init<>())
        .def_property("x",
            [](const CPP_wall3d_vertex &self) { return self.x; },
            [](CPP_wall3d_vertex &self, double val) { self.x = val; },
            "Coordinates of the vertex.")
        .def_property("y",
            [](const CPP_wall3d_vertex &self) { return self.y; },
            [](CPP_wall3d_vertex &self, double val) { self.y = val; },
            "Coordinates of the vertex.")
        .def_property("radius_x",
            [](const CPP_wall3d_vertex &self) { return self.radius_x; },
            [](CPP_wall3d_vertex &self, double val) { self.radius_x = val; },
            "Radius of arc or ellipse x-axis half width. 0 => Straight line.")
        .def_property("radius_y",
            [](const CPP_wall3d_vertex &self) { return self.radius_y; },
            [](CPP_wall3d_vertex &self, double val) { self.radius_y = val; },
            "Ellipse y-axis half height.")
        .def_property("tilt",
            [](const CPP_wall3d_vertex &self) { return self.tilt; },
            [](CPP_wall3d_vertex &self, double val) { self.tilt = val; },
            "Tilt of ellipse")
        .def_property("angle",
            [](const CPP_wall3d_vertex &self) { return self.angle; },
            [](CPP_wall3d_vertex &self, double val) { self.angle = val; },
            "Angle of (x, y) point.")
        .def_property("x0",
            [](const CPP_wall3d_vertex &self) { return self.x0; },
            [](CPP_wall3d_vertex &self, double val) { self.x0 = val; },
            "Center of ellipse")
        .def_property("y0",
            [](const CPP_wall3d_vertex &self) { return self.y0; },
            [](CPP_wall3d_vertex &self, double val) { self.y0 = val; },
            "Center of ellipse")
        .def_property("type",
            [](const CPP_wall3d_vertex &self) { return self.type; },
            [](CPP_wall3d_vertex &self, int val) { self.type = val; },
            "No longer used.")
        ;

    py::class_<CPP_wall3d_section>(m, "wall3d_section", "Fortran struct: wall3d_section_struct")
        .def(py::init<>())
        .def_property("name",
            [](const CPP_wall3d_section &self) { return self.name; },
            [](CPP_wall3d_section &self, std::string val) { self.name = val; },
            "Identifying name")
        .def_property("material",
            [](const CPP_wall3d_section &self) { return self.material; },
            [](CPP_wall3d_section &self, std::string val) { self.material = val; },
            "Material.")
        // Array property: v, type: CPP_wall3d_vertex_ARRAY
        .def_property("v",
            [](const CPP_wall3d_section &self) {
                // Get list of struct objects
                
                const auto& arr = self.v;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_wall3d_section &self, py::object obj) {
                // Set v from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.v;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_wall3d_vertex>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_wall3d_vertex objects");
                }
                
            },
            "Array of vertices. Always stored relative.")
        // TODO Skipping surface: pointer to struct type (CPP_photon_reflect_surface)
        .def_property("type",
            [](const CPP_wall3d_section &self) { return self.type; },
            [](CPP_wall3d_section &self, int val) { self.type = val; },
            "normal$, clear$, opaque$, wall_start$, wall_end$")
        .def_property("n_vertex_input",
            [](const CPP_wall3d_section &self) { return self.n_vertex_input; },
            [](CPP_wall3d_section &self, int val) { self.n_vertex_input = val; },
            "Number of vertices specified by the user.")
        .def_property("ix_ele",
            [](const CPP_wall3d_section &self) { return self.ix_ele; },
            [](CPP_wall3d_section &self, int val) { self.ix_ele = val; },
            "index of lattice element containing section")
        .def_property("ix_branch",
            [](const CPP_wall3d_section &self) { return self.ix_branch; },
            [](CPP_wall3d_section &self, int val) { self.ix_branch = val; },
            "Index of branch lattice element is in.")
        .def_property("vertices_state",
            [](const CPP_wall3d_section &self) { return self.vertices_state; },
            [](CPP_wall3d_section &self, int val) { self.vertices_state = val; },
            "absolute$, or shifted_to_relative$. If set to absolute$ on input,")
        .def_property("patch_in_region",
            [](const CPP_wall3d_section &self) { return self.patch_in_region; },
            [](CPP_wall3d_section &self, bool val) { self.patch_in_region = val; },
            "Patch element exists between this section and previous one?")
        .def_property("thickness",
            [](const CPP_wall3d_section &self) { return self.thickness; },
            [](CPP_wall3d_section &self, double val) { self.thickness = val; },
            "Material thickness.")
        .def_property("s",
            [](const CPP_wall3d_section &self) { return self.s; },
            [](CPP_wall3d_section &self, double val) { self.s = val; },
            "Longitudinal position")
        // Array property: r0, type: Real_ARRAY
        .def_property("r0",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.r0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set r0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.r0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.r0[i] = data[i];
                }
                
            },
            "Center of section")
        .def_property("dx0_ds",
            [](const CPP_wall3d_section &self) { return self.dx0_ds; },
            [](CPP_wall3d_section &self, double val) { self.dx0_ds = val; },
            "Center of wall derivative")
        .def_property("dy0_ds",
            [](const CPP_wall3d_section &self) { return self.dy0_ds; },
            [](CPP_wall3d_section &self, double val) { self.dy0_ds = val; },
            "Center of wall derivative")
        // Array property: x0_coef, type: Real_ARRAY
        .def_property("x0_coef",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.x0_coef;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set x0_coef from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.x0_coef.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.x0_coef[i] = data[i];
                }
                
            },
            "Spline coefs for x-center")
        // Array property: y0_coef, type: Real_ARRAY
        .def_property("y0_coef",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.y0_coef;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set y0_coef from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.y0_coef.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.y0_coef[i] = data[i];
                }
                
            },
            "Spline coefs for y-center")
        .def_property("dr_ds",
            [](const CPP_wall3d_section &self) { return self.dr_ds; },
            [](CPP_wall3d_section &self, double val) { self.dr_ds = val; },
            "derivative of wall radius")
        // Array property: p1_coef, type: Real_ARRAY
        .def_property("p1_coef",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.p1_coef;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set p1_coef from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.p1_coef.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.p1_coef[i] = data[i];
                }
                
            },
            "Spline coefs for p0 function")
        // Array property: p2_coef, type: Real_ARRAY
        .def_property("p2_coef",
            [](const CPP_wall3d_section &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.p2_coef;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_wall3d_section &self, py::array arr) {
                // Set p2_coef from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.p2_coef.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.p2_coef[i] = data[i];
                }
                
            },
            "Spline coefs for p1 function")
        ;

    py::class_<CPP_wall3d>(m, "wall3d", "Fortran struct: wall3d_struct")
        .def(py::init<>())
        .def_property("name",
            [](const CPP_wall3d &self) { return self.name; },
            [](CPP_wall3d &self, std::string val) { self.name = val; },
            "Property from Fortran struct")
        .def_property("type",
            [](const CPP_wall3d &self) { return self.type; },
            [](CPP_wall3d &self, int val) { self.type = val; },
            "or mask_plate$")
        .def_property("ix_wall3d",
            [](const CPP_wall3d &self) { return self.ix_wall3d; },
            [](CPP_wall3d &self, int val) { self.ix_wall3d = val; },
            "Index in branch%wall3d(:) array.")
        .def_property("n_link",
            [](const CPP_wall3d &self) { return self.n_link; },
            [](CPP_wall3d &self, int val) { self.n_link = val; },
            "For memory management of ele%wall3d")
        .def_property("thickness",
            [](const CPP_wall3d &self) { return self.thickness; },
            [](CPP_wall3d &self, double val) { self.thickness = val; },
            "For diffraction_plate elements")
        .def_property("clear_material",
            [](const CPP_wall3d &self) { return self.clear_material; },
            [](CPP_wall3d &self, std::string val) { self.clear_material = val; },
            "Property from Fortran struct")
        .def_property("opaque_material",
            [](const CPP_wall3d &self) { return self.opaque_material; },
            [](CPP_wall3d &self, std::string val) { self.opaque_material = val; },
            "Property from Fortran struct")
        .def_property("superimpose",
            [](const CPP_wall3d &self) { return self.superimpose; },
            [](CPP_wall3d &self, bool val) { self.superimpose = val; },
            "Can overlap another wall")
        .def_property("ele_anchor_pt",
            [](const CPP_wall3d &self) { return self.ele_anchor_pt; },
            [](CPP_wall3d &self, int val) { self.ele_anchor_pt = val; },
            "anchor_beginning$, anchor_center$, or anchor_end$")
        // Array property: section, type: CPP_wall3d_section_ARRAY
        .def_property("section",
            [](const CPP_wall3d &self) {
                // Get list of struct objects
                
                const auto& arr = self.section;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_wall3d &self, py::object obj) {
                // Set section from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.section;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_wall3d_section>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_wall3d_section objects");
                }
                
            },
            "Indexed from 1.")
        ;

    py::class_<CPP_ramper_lord>(m, "ramper_lord", "Fortran struct: ramper_lord_struct")
        .def(py::init<>())
        .def_property("ix_ele",
            [](const CPP_ramper_lord &self) { return self.ix_ele; },
            [](CPP_ramper_lord &self, int val) { self.ix_ele = val; },
            "Lord index")
        .def_property("ix_con",
            [](const CPP_ramper_lord &self) { return self.ix_con; },
            [](CPP_ramper_lord &self, int val) { self.ix_con = val; },
            "Index in lord%control%ramp(:) array")
        .def_property("attrib_ptr",
            [](const CPP_ramper_lord &self) { return self.attrib_ptr; },
            [](CPP_ramper_lord &self, double* val) { self.attrib_ptr = val; },
            "Pointer to attribute in this element.")
        ;

    py::class_<CPP_control>(m, "control", "Fortran struct: control_struct")
        .def(py::init<>())
        .def_property("value",
            [](const CPP_control &self) { return self.value; },
            [](CPP_control &self, double val) { self.value = val; },
            "Used by group, and overlay elements.")
        // Array property: y_knot, type: Real_ARRAY
        .def_property("y_knot",
            [](const CPP_control &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.y_knot;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_control &self, py::array arr) {
                // Set y_knot from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.y_knot.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.y_knot[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: stack, type: CPP_expression_atom_ARRAY
        .def_property("stack",
            [](const CPP_control &self) {
                // Get list of struct objects
                
                const auto& arr = self.stack;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_control &self, py::object obj) {
                // Set stack from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.stack;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_expression_atom>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_expression_atom objects");
                }
                
            },
            "Evaluation stack")
        .def_property("slave",
            [](const CPP_control &self) { return self.slave; },
            [](CPP_control &self, CPP_lat_ele_loc val) { self.slave = val; },
            "Property from Fortran struct")
        .def_property("lord",
            [](const CPP_control &self) { return self.lord; },
            [](CPP_control &self, CPP_lat_ele_loc val) { self.lord = val; },
            "Property from Fortran struct")
        .def_property("slave_name",
            [](const CPP_control &self) { return self.slave_name; },
            [](CPP_control &self, std::string val) { self.slave_name = val; },
            "Name of slave.")
        .def_property("attribute",
            [](const CPP_control &self) { return self.attribute; },
            [](CPP_control &self, std::string val) { self.attribute = val; },
            "Name of attribute controlled. Set to 'FIELD_OVERLAPS' for field overlaps.")
        .def_property("ix_attrib",
            [](const CPP_control &self) { return self.ix_attrib; },
            [](CPP_control &self, int val) { self.ix_attrib = val; },
            "Index of attribute controlled. See note above!")
        ;

    py::class_<CPP_control_var1>(m, "control_var1", "Fortran struct: control_var1_struct")
        .def(py::init<>())
        .def_property("name",
            [](const CPP_control_var1 &self) { return self.name; },
            [](CPP_control_var1 &self, std::string val) { self.name = val; },
            "Property from Fortran struct")
        .def_property("value",
            [](const CPP_control_var1 &self) { return self.value; },
            [](CPP_control_var1 &self, double val) { self.value = val; },
            "Property from Fortran struct")
        .def_property("old_value",
            [](const CPP_control_var1 &self) { return self.old_value; },
            [](CPP_control_var1 &self, double val) { self.old_value = val; },
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_control_ramp1 &self, py::array arr) {
                // Set y_knot from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.y_knot.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.y_knot[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: stack, type: CPP_expression_atom_ARRAY
        .def_property("stack",
            [](const CPP_control_ramp1 &self) {
                // Get list of struct objects
                
                const auto& arr = self.stack;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_control_ramp1 &self, py::object obj) {
                // Set stack from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.stack;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_expression_atom>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_expression_atom objects");
                }
                
            },
            "Evaluation stack")
        .def_property("attribute",
            [](const CPP_control_ramp1 &self) { return self.attribute; },
            [](CPP_control_ramp1 &self, std::string val) { self.attribute = val; },
            "Name of attribute controlled. Set to 'FIELD_OVERLAPS' for field overlaps.")
        .def_property("slave_name",
            [](const CPP_control_ramp1 &self) { return self.slave_name; },
            [](CPP_control_ramp1 &self, std::string val) { self.slave_name = val; },
            "Name of slave.")
        .def_property("is_controller",
            [](const CPP_control_ramp1 &self) { return self.is_controller; },
            [](CPP_control_ramp1 &self, bool val) { self.is_controller = val; },
            "Is the slave a controller? If so bookkeeping is different.")
        ;

    py::class_<CPP_controller>(m, "controller", "Fortran struct: controller_struct")
        .def(py::init<>())
        // Array property: var, type: CPP_control_var1_ARRAY
        .def_property("var",
            [](const CPP_controller &self) {
                // Get list of struct objects
                
                const auto& arr = self.var;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_controller &self, py::object obj) {
                // Set var from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.var;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_control_var1>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_control_var1 objects");
                }
                
            },
            "Property from Fortran struct")
        // Array property: ramp, type: CPP_control_ramp1_ARRAY
        .def_property("ramp",
            [](const CPP_controller &self) {
                // Get list of struct objects
                
                const auto& arr = self.ramp;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_controller &self, py::object obj) {
                // Set ramp from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.ramp;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_control_ramp1>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_control_ramp1 objects");
                }
                
            },
            "For ramper lord elements")
        // Array property: ramper_lord, type: CPP_ramper_lord_ARRAY
        .def_property("ramper_lord",
            [](const CPP_controller &self) {
                // Get list of struct objects
                
                const auto& arr = self.ramper_lord;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_controller &self, py::object obj) {
                // Set ramper_lord from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.ramper_lord;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_ramper_lord>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_ramper_lord objects");
                }
                
            },
            "Ramper lord info for this slave")
        // Array property: x_knot, type: Real_ARRAY
        .def_property("x_knot",
            [](const CPP_controller &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.x_knot;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_controller &self, py::array arr) {
                // Set x_knot from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.x_knot.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.x_knot[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_ellipse_beam_init>(m, "ellipse_beam_init", "Fortran struct: ellipse_beam_init_struct")
        .def(py::init<>())
        .def_property("part_per_ellipse",
            [](const CPP_ellipse_beam_init &self) { return self.part_per_ellipse; },
            [](CPP_ellipse_beam_init &self, int val) { self.part_per_ellipse = val; },
            "number of particles per ellipse")
        .def_property("n_ellipse",
            [](const CPP_ellipse_beam_init &self) { return self.n_ellipse; },
            [](CPP_ellipse_beam_init &self, int val) { self.n_ellipse = val; },
            "number of ellipses (>= 1)")
        .def_property("sigma_cutoff",
            [](const CPP_ellipse_beam_init &self) { return self.sigma_cutoff; },
            [](CPP_ellipse_beam_init &self, double val) { self.sigma_cutoff = val; },
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
                
                // Copy data to avoid lifetime issues
                auto* data = new int[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<int*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<int>(), {size}, {sizeof(int)}, data, capsule);
                
            },
            [](CPP_kv_beam_init &self, py::array arr) {
                // Set part_per_phi from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.part_per_phi.resize(size);
                auto* data = static_cast<int*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.part_per_phi[i] = data[i];
                }
                
            },
            "number of particles per angle variable.")
        .def_property("n_i2",
            [](const CPP_kv_beam_init &self) { return self.n_i2; },
            [](CPP_kv_beam_init &self, int val) { self.n_i2 = val; },
            "number of I2")
        .def_property("a",
            [](const CPP_kv_beam_init &self) { return self.a; },
            [](CPP_kv_beam_init &self, double val) { self.a = val; },
            "A = I1/e")
        ;

    py::class_<CPP_grid_beam_init>(m, "grid_beam_init", "Fortran struct: grid_beam_init_struct")
        .def(py::init<>())
        .def_property("n_x",
            [](const CPP_grid_beam_init &self) { return self.n_x; },
            [](CPP_grid_beam_init &self, int val) { self.n_x = val; },
            "Number of columns.")
        .def_property("n_px",
            [](const CPP_grid_beam_init &self) { return self.n_px; },
            [](CPP_grid_beam_init &self, int val) { self.n_px = val; },
            "Number of rows.")
        .def_property("x_min",
            [](const CPP_grid_beam_init &self) { return self.x_min; },
            [](CPP_grid_beam_init &self, double val) { self.x_min = val; },
            "Lower x limit.")
        .def_property("x_max",
            [](const CPP_grid_beam_init &self) { return self.x_max; },
            [](CPP_grid_beam_init &self, double val) { self.x_max = val; },
            "Upper x limit.")
        .def_property("px_min",
            [](const CPP_grid_beam_init &self) { return self.px_min; },
            [](CPP_grid_beam_init &self, double val) { self.px_min = val; },
            "Lower px limit.")
        .def_property("px_max",
            [](const CPP_grid_beam_init &self) { return self.px_max; },
            [](CPP_grid_beam_init &self, double val) { self.px_max = val; },
            "Upper px limit.")
        ;

    py::class_<CPP_beam_init>(m, "beam_init", "Fortran struct: beam_init_struct")
        .def(py::init<>())
        .def_property("position_file",
            [](const CPP_beam_init &self) { return self.position_file; },
            [](CPP_beam_init &self, std::string val) { self.position_file = val; },
            "File with particle positions.")
        // Array property: distribution_type, type: String_ARRAY
        .def_property("distribution_type",
            [](const CPP_beam_init &self) {
                // Get numpy array from String_ARRAY
                const auto& arr = self.distribution_type;
                auto size = arr.size();
                return py::cast(std::vector<std::string>(std::begin(arr), std::end(arr)));
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set distribution_type from numpy array
                
                py::list string_list = arr.cast<py::list>();
                self.distribution_type.resize(string_list.size());
                for (size_t i = 0; i < string_list.size(); ++i) {
                    self.distribution_type[i] = string_list[i].cast<std::string>();
                }
                
            },
            "distribution type (in x-px, y-py, and z-pz planes)")
        // Array property: spin, type: Real_ARRAY
        .def_property("spin",
            [](const CPP_beam_init &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.spin;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set spin from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.spin.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.spin[i] = data[i];
                }
                
            },
            "Spin (x, y, z)")
        // Array property: ellipse, type: CPP_ellipse_beam_init_ARRAY
        .def_property("ellipse",
            [](const CPP_beam_init &self) {
                // Get list of struct objects
                
                const auto& arr = self.ellipse;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_beam_init &self, py::object obj) {
                // Set ellipse from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.ellipse;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_ellipse_beam_init>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_ellipse_beam_init objects");
                }
                
            },
            "Ellipse beam distribution")
        .def_property("kv",
            [](const CPP_beam_init &self) { return self.kv; },
            [](CPP_beam_init &self, CPP_kv_beam_init val) { self.kv = val; },
            "KV beam distribution")
        // Array property: grid, type: CPP_grid_beam_init_ARRAY
        .def_property("grid",
            [](const CPP_beam_init &self) {
                // Get list of struct objects
                
                const auto& arr = self.grid;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_beam_init &self, py::object obj) {
                // Set grid from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.grid;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_grid_beam_init>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_grid_beam_init objects");
                }
                
            },
            "Grid beam distribution")
        // Array property: center_jitter, type: Real_ARRAY
        .def_property("center_jitter",
            [](const CPP_beam_init &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.center_jitter;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set center_jitter from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.center_jitter.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.center_jitter[i] = data[i];
                }
                
            },
            "Bunch center rms jitter")
        // Array property: emit_jitter, type: Real_ARRAY
        .def_property("emit_jitter",
            [](const CPP_beam_init &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.emit_jitter;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set emit_jitter from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.emit_jitter.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.emit_jitter[i] = data[i];
                }
                
            },
            "a and b bunch emittance rms jitter normalized to emittance")
        .def_property("sig_z_jitter",
            [](const CPP_beam_init &self) { return self.sig_z_jitter; },
            [](CPP_beam_init &self, double val) { self.sig_z_jitter = val; },
            "bunch length RMS jitter")
        .def_property("sig_pz_jitter",
            [](const CPP_beam_init &self) { return self.sig_pz_jitter; },
            [](CPP_beam_init &self, double val) { self.sig_pz_jitter = val; },
            "RMS pz spread jitter")
        .def_property("n_particle",
            [](const CPP_beam_init &self) { return self.n_particle; },
            [](CPP_beam_init &self, int val) { self.n_particle = val; },
            "Number of particles per bunch.")
        .def_property("renorm_center",
            [](const CPP_beam_init &self) { return self.renorm_center; },
            [](CPP_beam_init &self, bool val) { self.renorm_center = val; },
            "Renormalize centroid?")
        .def_property("renorm_sigma",
            [](const CPP_beam_init &self) { return self.renorm_sigma; },
            [](CPP_beam_init &self, bool val) { self.renorm_sigma = val; },
            "Renormalize sigma?")
        .def_property("random_engine",
            [](const CPP_beam_init &self) { return self.random_engine; },
            [](CPP_beam_init &self, std::string val) { self.random_engine = val; },
            "Or 'quasi'. Random number engine to use.")
        .def_property("random_gauss_converter",
            [](const CPP_beam_init &self) { return self.random_gauss_converter; },
            [](CPP_beam_init &self, std::string val) { self.random_gauss_converter = val; },
            "Property from Fortran struct")
        .def_property("random_sigma_cutoff",
            [](const CPP_beam_init &self) { return self.random_sigma_cutoff; },
            [](CPP_beam_init &self, double val) { self.random_sigma_cutoff = val; },
            "Cut-off in sigmas.")
        .def_property("a_norm_emit",
            [](const CPP_beam_init &self) { return self.a_norm_emit; },
            [](CPP_beam_init &self, double val) { self.a_norm_emit = val; },
            "a-mode normalized emittance (emit * beta * gamma)")
        .def_property("b_norm_emit",
            [](const CPP_beam_init &self) { return self.b_norm_emit; },
            [](CPP_beam_init &self, double val) { self.b_norm_emit = val; },
            "b-mode normalized emittance (emit * beta * gamma)")
        .def_property("a_emit",
            [](const CPP_beam_init &self) { return self.a_emit; },
            [](CPP_beam_init &self, double val) { self.a_emit = val; },
            "a-mode emittance")
        .def_property("b_emit",
            [](const CPP_beam_init &self) { return self.b_emit; },
            [](CPP_beam_init &self, double val) { self.b_emit = val; },
            "b-mode emittance")
        .def_property("dpz_dz",
            [](const CPP_beam_init &self) { return self.dpz_dz; },
            [](CPP_beam_init &self, double val) { self.dpz_dz = val; },
            "Correlation of Pz with long position.")
        // Array property: center, type: Real_ARRAY
        .def_property("center",
            [](const CPP_beam_init &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.center;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_beam_init &self, py::array arr) {
                // Set center from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.center.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.center[i] = data[i];
                }
                
            },
            "Bench phase space center offset relative to reference.")
        .def_property("t_offset",
            [](const CPP_beam_init &self) { return self.t_offset; },
            [](CPP_beam_init &self, double val) { self.t_offset = val; },
            "Time center offset")
        .def_property("dt_bunch",
            [](const CPP_beam_init &self) { return self.dt_bunch; },
            [](CPP_beam_init &self, double val) { self.dt_bunch = val; },
            "Time between bunches.")
        .def_property("sig_z",
            [](const CPP_beam_init &self) { return self.sig_z; },
            [](CPP_beam_init &self, double val) { self.sig_z = val; },
            "Z sigma in m.")
        .def_property("sig_pz",
            [](const CPP_beam_init &self) { return self.sig_pz; },
            [](CPP_beam_init &self, double val) { self.sig_pz = val; },
            "pz sigma")
        .def_property("bunch_charge",
            [](const CPP_beam_init &self) { return self.bunch_charge; },
            [](CPP_beam_init &self, double val) { self.bunch_charge = val; },
            "charge (Coul) in a bunch.")
        .def_property("n_bunch",
            [](const CPP_beam_init &self) { return self.n_bunch; },
            [](CPP_beam_init &self, int val) { self.n_bunch = val; },
            "Number of bunches.")
        .def_property("ix_turn",
            [](const CPP_beam_init &self) { return self.ix_turn; },
            [](CPP_beam_init &self, int val) { self.ix_turn = val; },
            "Turn index used to adjust particles time if needed.")
        .def_property("species",
            [](const CPP_beam_init &self) { return self.species; },
            [](CPP_beam_init &self, std::string val) { self.species = val; },
            "'positron', etc. '' => use referece particle.")
        .def_property("full_6d_coupling_calc",
            [](const CPP_beam_init &self) { return self.full_6d_coupling_calc; },
            [](CPP_beam_init &self, bool val) { self.full_6d_coupling_calc = val; },
            "Use V from 6x6 1-turn mat to match distribution?")
        .def_property("use_particle_start",
            [](const CPP_beam_init &self) { return self.use_particle_start; },
            [](CPP_beam_init &self, bool val) { self.use_particle_start = val; },
            "Use lat%particle_start instead of beam_init%center, %spin?")
        .def_property("use_t_coords",
            [](const CPP_beam_init &self) { return self.use_t_coords; },
            [](CPP_beam_init &self, bool val) { self.use_t_coords = val; },
            "If true, the distributions will be taken as in t-coordinates")
        .def_property("use_z_as_t",
            [](const CPP_beam_init &self) { return self.use_z_as_t; },
            [](CPP_beam_init &self, bool val) { self.use_z_as_t = val; },
            "Only used if  use_t_coords = .true.")
        .def_property("file_name",
            [](const CPP_beam_init &self) { return self.file_name; },
            [](CPP_beam_init &self, std::string val) { self.file_name = val; },
            "OLD!! DO NOT USE!!")
        ;

    py::class_<CPP_lat_param>(m, "lat_param", "Fortran struct: lat_param_struct")
        .def(py::init<>())
        .def_property("n_part",
            [](const CPP_lat_param &self) { return self.n_part; },
            [](CPP_lat_param &self, double val) { self.n_part = val; },
            "Particles/bunch (for BeamBeam elements).")
        .def_property("total_length",
            [](const CPP_lat_param &self) { return self.total_length; },
            [](CPP_lat_param &self, double val) { self.total_length = val; },
            "total_length of branch. Warning: branch may not start at s = 0.")
        .def_property("unstable_factor",
            [](const CPP_lat_param &self) { return self.unstable_factor; },
            [](CPP_lat_param &self, double val) { self.unstable_factor = val; },
            "If positive: Growth rate/turn if unstable in closed branches or")
        // Array property: t1_with_rf, type: Real_MATRIX
        .def_property("t1_with_rf",
            [](const CPP_lat_param &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.t1_with_rf;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_lat_param &self, py::array arr) {
                // Set t1_with_rf from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.t1_with_rf.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.t1_with_rf[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.t1_with_rf[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "Full 1-turn matrix with RF on.")
        // Array property: t1_no_rf, type: Real_MATRIX
        .def_property("t1_no_rf",
            [](const CPP_lat_param &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.t1_no_rf;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_lat_param &self, py::array arr) {
                // Set t1_no_rf from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.t1_no_rf.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.t1_no_rf[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.t1_no_rf[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "Full 1-turn matrix with RF off.")
        .def_property("spin_tune",
            [](const CPP_lat_param &self) { return self.spin_tune; },
            [](CPP_lat_param &self, double val) { self.spin_tune = val; },
            "Closed orbit spin tune.")
        .def_property("particle",
            [](const CPP_lat_param &self) { return self.particle; },
            [](CPP_lat_param &self, int val) { self.particle = val; },
            "Reference particle: positron$, electron$, etc.")
        .def_property("default_tracking_species",
            [](const CPP_lat_param &self) { return self.default_tracking_species; },
            [](CPP_lat_param &self, int val) { self.default_tracking_species = val; },
            "Default particle type to use in tracking.")
        .def_property("geometry",
            [](const CPP_lat_param &self) { return self.geometry; },
            [](CPP_lat_param &self, int val) { self.geometry = val; },
            "open$ or closed$")
        .def_property("ixx",
            [](const CPP_lat_param &self) { return self.ixx; },
            [](CPP_lat_param &self, int val) { self.ixx = val; },
            "Integer for general use")
        .def_property("stable",
            [](const CPP_lat_param &self) { return self.stable; },
            [](CPP_lat_param &self, bool val) { self.stable = val; },
            "is closed lat stable?")
        .def_property("live_branch",
            [](const CPP_lat_param &self) { return self.live_branch; },
            [](CPP_lat_param &self, bool val) { self.live_branch = val; },
            "Should tracking be done on the branch?")
        .def_property("g1_integral",
            [](const CPP_lat_param &self) { return self.g1_integral; },
            [](CPP_lat_param &self, double val) { self.g1_integral = val; },
            "Approximate |g| (bending strength) integral of branch.")
        .def_property("g2_integral",
            [](const CPP_lat_param &self) { return self.g2_integral; },
            [](CPP_lat_param &self, double val) { self.g2_integral = val; },
            "Approximate g^2 integral of branch.")
        .def_property("g3_integral",
            [](const CPP_lat_param &self) { return self.g3_integral; },
            [](CPP_lat_param &self, double val) { self.g3_integral = val; },
            "Approximate g^2 integral of branch.")
        .def_property("bookkeeping_state",
            [](const CPP_lat_param &self) { return self.bookkeeping_state; },
            [](CPP_lat_param &self, CPP_bookkeeping_state val) { self.bookkeeping_state = val; },
            "Property from Fortran struct")
        .def_property("beam_init",
            [](const CPP_lat_param &self) { return self.beam_init; },
            [](CPP_lat_param &self, CPP_beam_init val) { self.beam_init = val; },
            "For beam initialization.")
        ;

    py::class_<CPP_mode_info>(m, "mode_info", "Fortran struct: mode_info_struct")
        .def(py::init<>())
        .def_property("stable",
            [](const CPP_mode_info &self) { return self.stable; },
            [](CPP_mode_info &self, bool val) { self.stable = val; },
            "Is the mode stable?")
        .def_property("tune",
            [](const CPP_mode_info &self) { return self.tune; },
            [](CPP_mode_info &self, double val) { self.tune = val; },
            "'fractional' tune in radians")
        .def_property("emit",
            [](const CPP_mode_info &self) { return self.emit; },
            [](CPP_mode_info &self, double val) { self.emit = val; },
            "Emittance (unnormalized).")
        .def_property("chrom",
            [](const CPP_mode_info &self) { return self.chrom; },
            [](CPP_mode_info &self, double val) { self.chrom = val; },
            "Chromaticity.")
        .def_property("sigma",
            [](const CPP_mode_info &self) { return self.sigma; },
            [](CPP_mode_info &self, double val) { self.sigma = val; },
            "Beam size.")
        .def_property("sigmap",
            [](const CPP_mode_info &self) { return self.sigmap; },
            [](CPP_mode_info &self, double val) { self.sigmap = val; },
            "Beam divergence.")
        ;

    py::class_<CPP_pre_tracker>(m, "pre_tracker", "Fortran struct: pre_tracker_struct")
        .def(py::init<>())
        .def_property("who",
            [](const CPP_pre_tracker &self) { return self.who; },
            [](CPP_pre_tracker &self, int val) { self.who = val; },
            "Can be opal$, or impactt$")
        .def_property("ix_ele_start",
            [](const CPP_pre_tracker &self) { return self.ix_ele_start; },
            [](CPP_pre_tracker &self, int val) { self.ix_ele_start = val; },
            "Property from Fortran struct")
        .def_property("ix_ele_end",
            [](const CPP_pre_tracker &self) { return self.ix_ele_end; },
            [](CPP_pre_tracker &self, int val) { self.ix_ele_end = val; },
            "Property from Fortran struct")
        .def_property("input_file",
            [](const CPP_pre_tracker &self) { return self.input_file; },
            [](CPP_pre_tracker &self, std::string val) { self.input_file = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_anormal_mode>(m, "anormal_mode", "Fortran struct: anormal_mode_struct")
        .def(py::init<>())
        .def_property("emittance",
            [](const CPP_anormal_mode &self) { return self.emittance; },
            [](CPP_anormal_mode &self, double val) { self.emittance = val; },
            "Beam emittance (unnormalized). Includes vertical photon opening angle.")
        .def_property("emittance_no_vert",
            [](const CPP_anormal_mode &self) { return self.emittance_no_vert; },
            [](CPP_anormal_mode &self, double val) { self.emittance_no_vert = val; },
            "Unnormalized beam emittance without the vertical photon opening angle taken into account.")
        // Array property: synch_int, type: Real_ARRAY
        .def_property("synch_int",
            [](const CPP_anormal_mode &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.synch_int;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_anormal_mode &self, py::array arr) {
                // Set synch_int from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.synch_int.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.synch_int[i] = data[i];
                }
                
            },
            "Synchrotron integrals")
        .def_property("j_damp",
            [](const CPP_anormal_mode &self) { return self.j_damp; },
            [](CPP_anormal_mode &self, double val) { self.j_damp = val; },
            "damping partition number")
        .def_property("alpha_damp",
            [](const CPP_anormal_mode &self) { return self.alpha_damp; },
            [](CPP_anormal_mode &self, double val) { self.alpha_damp = val; },
            "damping per turn")
        .def_property("chrom",
            [](const CPP_anormal_mode &self) { return self.chrom; },
            [](CPP_anormal_mode &self, double val) { self.chrom = val; },
            "Chromaticity")
        .def_property("tune",
            [](const CPP_anormal_mode &self) { return self.tune; },
            [](CPP_anormal_mode &self, double val) { self.tune = val; },
            "'Fractional' tune in radians")
        ;

    py::class_<CPP_linac_normal_mode>(m, "linac_normal_mode", "Fortran struct: linac_normal_mode_struct")
        .def(py::init<>())
        .def_property("i2_e4",
            [](const CPP_linac_normal_mode &self) { return self.i2_e4; },
            [](CPP_linac_normal_mode &self, double val) { self.i2_e4 = val; },
            "Integral: g^2 * gamma^4")
        .def_property("i3_e7",
            [](const CPP_linac_normal_mode &self) { return self.i3_e7; },
            [](CPP_linac_normal_mode &self, double val) { self.i3_e7 = val; },
            "Integral: g^3 * gamma^7")
        .def_property("i5a_e6",
            [](const CPP_linac_normal_mode &self) { return self.i5a_e6; },
            [](CPP_linac_normal_mode &self, double val) { self.i5a_e6 = val; },
            "Integral: (g^3 * H_a) * gamma^6")
        .def_property("i5b_e6",
            [](const CPP_linac_normal_mode &self) { return self.i5b_e6; },
            [](CPP_linac_normal_mode &self, double val) { self.i5b_e6 = val; },
            "Integral: (g^3 * H_b) * gamma^6")
        .def_property("sig_e1",
            [](const CPP_linac_normal_mode &self) { return self.sig_e1; },
            [](CPP_linac_normal_mode &self, double val) { self.sig_e1 = val; },
            "Energy spread after 1 pass (eV)")
        .def_property("a_emittance_end",
            [](const CPP_linac_normal_mode &self) { return self.a_emittance_end; },
            [](CPP_linac_normal_mode &self, double val) { self.a_emittance_end = val; },
            "a mode emittance at end of linac")
        .def_property("b_emittance_end",
            [](const CPP_linac_normal_mode &self) { return self.b_emittance_end; },
            [](CPP_linac_normal_mode &self, double val) { self.b_emittance_end = val; },
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_normal_modes &self, py::array arr) {
                // Set synch_int from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.synch_int.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.synch_int[i] = data[i];
                }
                
            },
            "Synchrotron integrals I0, I1, I2, and I3")
        .def_property("sige_e",
            [](const CPP_normal_modes &self) { return self.sige_e; },
            [](CPP_normal_modes &self, double val) { self.sige_e = val; },
            "SigmaE/E")
        .def_property("sig_z",
            [](const CPP_normal_modes &self) { return self.sig_z; },
            [](CPP_normal_modes &self, double val) { self.sig_z = val; },
            "Sigma_Z")
        .def_property("e_loss",
            [](const CPP_normal_modes &self) { return self.e_loss; },
            [](CPP_normal_modes &self, double val) { self.e_loss = val; },
            "Energy loss / turn (eV)")
        .def_property("rf_voltage",
            [](const CPP_normal_modes &self) { return self.rf_voltage; },
            [](CPP_normal_modes &self, double val) { self.rf_voltage = val; },
            "Total rfcavity voltage (eV)")
        .def_property("pz_aperture",
            [](const CPP_normal_modes &self) { return self.pz_aperture; },
            [](CPP_normal_modes &self, double val) { self.pz_aperture = val; },
            "pz aperture limit. Used with Touschek calculations.")
        .def_property("pz_average",
            [](const CPP_normal_modes &self) { return self.pz_average; },
            [](CPP_normal_modes &self, double val) { self.pz_average = val; },
            "Average over branch due to damping.")
        .def_property("momentum_compaction",
            [](const CPP_normal_modes &self) { return self.momentum_compaction; },
            [](CPP_normal_modes &self, double val) { self.momentum_compaction = val; },
            "Property from Fortran struct")
        .def_property("dpz_damp",
            [](const CPP_normal_modes &self) { return self.dpz_damp; },
            [](CPP_normal_modes &self, double val) { self.dpz_damp = val; },
            "Change in pz without RF")
        .def_property("a",
            [](const CPP_normal_modes &self) { return self.a; },
            [](CPP_normal_modes &self, CPP_anormal_mode val) { self.a = val; },
            "Property from Fortran struct")
        .def_property("b",
            [](const CPP_normal_modes &self) { return self.b; },
            [](CPP_normal_modes &self, CPP_anormal_mode val) { self.b = val; },
            "Property from Fortran struct")
        .def_property("z",
            [](const CPP_normal_modes &self) { return self.z; },
            [](CPP_normal_modes &self, CPP_anormal_mode val) { self.z = val; },
            "Property from Fortran struct")
        .def_property("lin",
            [](const CPP_normal_modes &self) { return self.lin; },
            [](CPP_normal_modes &self, CPP_linac_normal_mode val) { self.lin = val; },
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
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_em_field &self, py::array arr) {
                // Set e from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.e.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.e[i] = data[i];
                }
                
            },
            "electric field.")
        // Array property: b, type: Real_ARRAY
        .def_property("b",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.b;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_em_field &self, py::array arr) {
                // Set b from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.b.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.b[i] = data[i];
                }
                
            },
            "magnetic field.")
        // Array property: de, type: Real_MATRIX
        .def_property("de",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.de;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_em_field &self, py::array arr) {
                // Set de from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.de.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.de[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.de[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "electric field gradient.")
        // Array property: db, type: Real_MATRIX
        .def_property("db",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.db;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_em_field &self, py::array arr) {
                // Set db from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.db.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.db[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.db[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "magnetic field gradient.")
        .def_property("phi",
            [](const CPP_em_field &self) { return self.phi; },
            [](CPP_em_field &self, double val) { self.phi = val; },
            "Electric scalar potential.")
        .def_property("phi_b",
            [](const CPP_em_field &self) { return self.phi_b; },
            [](CPP_em_field &self, double val) { self.phi_b = val; },
            "Magnetic scalar potential.")
        // Array property: a, type: Real_ARRAY
        .def_property("a",
            [](const CPP_em_field &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.a;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_em_field &self, py::array arr) {
                // Set a from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.a.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.a[i] = data[i];
                }
                
            },
            "Magnetic vector potential.")
        ;

    py::class_<CPP_strong_beam>(m, "strong_beam", "Fortran struct: strong_beam_struct")
        .def(py::init<>())
        .def_property("ix_slice",
            [](const CPP_strong_beam &self) { return self.ix_slice; },
            [](CPP_strong_beam &self, int val) { self.ix_slice = val; },
            "0 -> at element center and not at slice.")
        .def_property("x_center",
            [](const CPP_strong_beam &self) { return self.x_center; },
            [](CPP_strong_beam &self, double val) { self.x_center = val; },
            "Strong beam slice center.")
        .def_property("y_center",
            [](const CPP_strong_beam &self) { return self.y_center; },
            [](CPP_strong_beam &self, double val) { self.y_center = val; },
            "Strong beam slice center.")
        .def_property("x_sigma",
            [](const CPP_strong_beam &self) { return self.x_sigma; },
            [](CPP_strong_beam &self, double val) { self.x_sigma = val; },
            "Strong beam slice sigma.")
        .def_property("y_sigma",
            [](const CPP_strong_beam &self) { return self.y_sigma; },
            [](CPP_strong_beam &self, double val) { self.y_sigma = val; },
            "Strong beam slice sigma.")
        .def_property("dx",
            [](const CPP_strong_beam &self) { return self.dx; },
            [](CPP_strong_beam &self, double val) { self.dx = val; },
            "Particle - beam slice distance.")
        .def_property("dy",
            [](const CPP_strong_beam &self) { return self.dy; },
            [](CPP_strong_beam &self, double val) { self.dy = val; },
            "Particle - beam slice distance.")
        ;

    py::class_<CPP_track_point>(m, "track_point", "Fortran struct: track_point_struct")
        .def(py::init<>())
        .def_property("s_body",
            [](const CPP_track_point &self) { return self.s_body; },
            [](CPP_track_point &self, double val) { self.s_body = val; },
            "Longitudinal coords within the element body.")
        .def_property("orb",
            [](const CPP_track_point &self) { return self.orb; },
            [](CPP_track_point &self, CPP_coord val) { self.orb = val; },
            "An array of track points indexed from 0 (%orb(0:)).")
        .def_property("field",
            [](const CPP_track_point &self) { return self.field; },
            [](CPP_track_point &self, CPP_em_field val) { self.field = val; },
            "An array of em fields indexed from 0 (%field(0:)).")
        .def_property("strong_beam",
            [](const CPP_track_point &self) { return self.strong_beam; },
            [](CPP_track_point &self, CPP_strong_beam val) { self.strong_beam = val; },
            "Strong beam info for beambeam element.")
        // Array property: vec0, type: Real_ARRAY
        .def_property("vec0",
            [](const CPP_track_point &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.vec0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_track_point &self, py::array arr) {
                // Set vec0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.vec0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.vec0[i] = data[i];
                }
                
            },
            "0th order part of xfer map from the beginning.")
        // Array property: mat6, type: Real_MATRIX
        .def_property("mat6",
            [](const CPP_track_point &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.mat6;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_track_point &self, py::array arr) {
                // Set mat6 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.mat6.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.mat6[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.mat6[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "1st order part of xfer map (transfer matrix).")
        ;

    py::class_<CPP_track>(m, "track", "Fortran struct: track_struct")
        .def(py::init<>())
        // Array property: pt, type: CPP_track_point_ARRAY
        .def_property("pt",
            [](const CPP_track &self) {
                // Get list of struct objects
                
                const auto& arr = self.pt;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_track &self, py::object obj) {
                // Set pt from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.pt;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_track_point>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_track_point objects");
                }
                
            },
            "Array of track points indexed from 0.")
        .def_property("ds_save",
            [](const CPP_track &self) { return self.ds_save; },
            [](CPP_track &self, double val) { self.ds_save = val; },
            "Min distance between points. Not positive => Save at all points.")
        .def_property("n_pt",
            [](const CPP_track &self) { return self.n_pt; },
            [](CPP_track &self, int val) { self.n_pt = val; },
            "Track upper bound for %pt(0:) array.")
        .def_property("n_bad",
            [](const CPP_track &self) { return self.n_bad; },
            [](CPP_track &self, int val) { self.n_bad = val; },
            "Number of 'bad' steps where the step length was shortened.")
        .def_property("n_ok",
            [](const CPP_track &self) { return self.n_ok; },
            [](CPP_track &self, int val) { self.n_ok = val; },
            "Number of 'good' steps where the step length was not shortened.")
        ;

    py::class_<CPP_space_charge_common>(m, "space_charge_common", "Fortran struct: space_charge_common_struct")
        .def(py::init<>())
        .def_property("ds_track_step",
            [](const CPP_space_charge_common &self) { return self.ds_track_step; },
            [](CPP_space_charge_common &self, double val) { self.ds_track_step = val; },
            "CSR tracking step size")
        .def_property("dt_track_step",
            [](const CPP_space_charge_common &self) { return self.dt_track_step; },
            [](CPP_space_charge_common &self, double val) { self.dt_track_step = val; },
            "Time Runge kutta initial step.")
        .def_property("cathode_strength_cutoff",
            [](const CPP_space_charge_common &self) { return self.cathode_strength_cutoff; },
            [](CPP_space_charge_common &self, double val) { self.cathode_strength_cutoff = val; },
            "Cutoff for the cathode field calc.")
        .def_property("rel_tol_tracking",
            [](const CPP_space_charge_common &self) { return self.rel_tol_tracking; },
            [](CPP_space_charge_common &self, double val) { self.rel_tol_tracking = val; },
            "Relative tolerance for tracking.")
        .def_property("abs_tol_tracking",
            [](const CPP_space_charge_common &self) { return self.abs_tol_tracking; },
            [](CPP_space_charge_common &self, double val) { self.abs_tol_tracking = val; },
            "Absolute tolerance for tracking.")
        .def_property("beam_chamber_height",
            [](const CPP_space_charge_common &self) { return self.beam_chamber_height; },
            [](CPP_space_charge_common &self, double val) { self.beam_chamber_height = val; },
            "Used in shielding calculation.")
        .def_property("lsc_sigma_cutoff",
            [](const CPP_space_charge_common &self) { return self.lsc_sigma_cutoff; },
            [](CPP_space_charge_common &self, double val) { self.lsc_sigma_cutoff = val; },
            "Cutoff for the 1-dim longitudinal SC calc.")
        .def_property("particle_sigma_cutoff",
            [](const CPP_space_charge_common &self) { return self.particle_sigma_cutoff; },
            [](CPP_space_charge_common &self, double val) { self.particle_sigma_cutoff = val; },
            "3D SC calc cutoff for particles with (x,y,z) position far from the center.")
        // Array property: space_charge_mesh_size, type: Int_ARRAY
        .def_property("space_charge_mesh_size",
            [](const CPP_space_charge_common &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.space_charge_mesh_size;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new int[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<int*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<int>(), {size}, {sizeof(int)}, data, capsule);
                
            },
            [](CPP_space_charge_common &self, py::array arr) {
                // Set space_charge_mesh_size from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.space_charge_mesh_size.resize(size);
                auto* data = static_cast<int*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.space_charge_mesh_size[i] = data[i];
                }
                
            },
            "Gird size for fft_3d space charge calc.")
        // Array property: csr3d_mesh_size, type: Int_ARRAY
        .def_property("csr3d_mesh_size",
            [](const CPP_space_charge_common &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.csr3d_mesh_size;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new int[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<int*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<int>(), {size}, {sizeof(int)}, data, capsule);
                
            },
            [](CPP_space_charge_common &self, py::array arr) {
                // Set csr3d_mesh_size from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.csr3d_mesh_size.resize(size);
                auto* data = static_cast<int*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.csr3d_mesh_size[i] = data[i];
                }
                
            },
            "Gird size for CSR.")
        .def_property("n_bin",
            [](const CPP_space_charge_common &self) { return self.n_bin; },
            [](CPP_space_charge_common &self, int val) { self.n_bin = val; },
            "Number of bins used")
        .def_property("particle_bin_span",
            [](const CPP_space_charge_common &self) { return self.particle_bin_span; },
            [](CPP_space_charge_common &self, int val) { self.particle_bin_span = val; },
            "Longitudinal particle length / dz_bin")
        .def_property("n_shield_images",
            [](const CPP_space_charge_common &self) { return self.n_shield_images; },
            [](CPP_space_charge_common &self, int val) { self.n_shield_images = val; },
            "Chamber wall shielding. 0 = no shielding.")
        .def_property("sc_min_in_bin",
            [](const CPP_space_charge_common &self) { return self.sc_min_in_bin; },
            [](CPP_space_charge_common &self, int val) { self.sc_min_in_bin = val; },
            "Minimum number of particles in a bin for sigmas to be valid.")
        .def_property("lsc_kick_transverse_dependence",
            [](const CPP_space_charge_common &self) { return self.lsc_kick_transverse_dependence; },
            [](CPP_space_charge_common &self, bool val) { self.lsc_kick_transverse_dependence = val; },
            "Property from Fortran struct")
        .def_property("debug",
            [](const CPP_space_charge_common &self) { return self.debug; },
            [](CPP_space_charge_common &self, bool val) { self.debug = val; },
            "Property from Fortran struct")
        .def_property("diagnostic_output_file",
            [](const CPP_space_charge_common &self) { return self.diagnostic_output_file; },
            [](CPP_space_charge_common &self, std::string val) { self.diagnostic_output_file = val; },
            "If non-blank write a diagnostic (EG wake) file")
        ;

    py::class_<CPP_bmad_common>(m, "bmad_common", "Fortran struct: bmad_common_struct")
        .def(py::init<>())
        .def_property("max_aperture_limit",
            [](const CPP_bmad_common &self) { return self.max_aperture_limit; },
            [](CPP_bmad_common &self, double val) { self.max_aperture_limit = val; },
            "Max Aperture.")
        // Array property: d_orb, type: Real_ARRAY
        .def_property("d_orb",
            [](const CPP_bmad_common &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.d_orb;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_bmad_common &self, py::array arr) {
                // Set d_orb from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.d_orb.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.d_orb[i] = data[i];
                }
                
            },
            "Orbit deltas for the mat6 via tracking calc.")
        .def_property("default_ds_step",
            [](const CPP_bmad_common &self) { return self.default_ds_step; },
            [](CPP_bmad_common &self, double val) { self.default_ds_step = val; },
            "Default integration step for eles without an explicit step calc.")
        .def_property("significant_length",
            [](const CPP_bmad_common &self) { return self.significant_length; },
            [](CPP_bmad_common &self, double val) { self.significant_length = val; },
            "meter")
        .def_property("rel_tol_tracking",
            [](const CPP_bmad_common &self) { return self.rel_tol_tracking; },
            [](CPP_bmad_common &self, double val) { self.rel_tol_tracking = val; },
            "Closed orbit relative tolerance.")
        .def_property("abs_tol_tracking",
            [](const CPP_bmad_common &self) { return self.abs_tol_tracking; },
            [](CPP_bmad_common &self, double val) { self.abs_tol_tracking = val; },
            "Closed orbit absolute tolerance.")
        .def_property("rel_tol_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.rel_tol_adaptive_tracking; },
            [](CPP_bmad_common &self, double val) { self.rel_tol_adaptive_tracking = val; },
            "Runge-Kutta tracking relative tolerance.")
        .def_property("abs_tol_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.abs_tol_adaptive_tracking; },
            [](CPP_bmad_common &self, double val) { self.abs_tol_adaptive_tracking = val; },
            "Runge-Kutta tracking absolute tolerance.")
        .def_property("init_ds_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.init_ds_adaptive_tracking; },
            [](CPP_bmad_common &self, double val) { self.init_ds_adaptive_tracking = val; },
            "Initial step size")
        .def_property("min_ds_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.min_ds_adaptive_tracking; },
            [](CPP_bmad_common &self, double val) { self.min_ds_adaptive_tracking = val; },
            "Min step size to take.")
        .def_property("fatal_ds_adaptive_tracking",
            [](const CPP_bmad_common &self) { return self.fatal_ds_adaptive_tracking; },
            [](CPP_bmad_common &self, double val) { self.fatal_ds_adaptive_tracking = val; },
            "If actual step size is below this particle is lost.")
        .def_property("autoscale_amp_abs_tol",
            [](const CPP_bmad_common &self) { return self.autoscale_amp_abs_tol; },
            [](CPP_bmad_common &self, double val) { self.autoscale_amp_abs_tol = val; },
            "Autoscale absolute amplitude tolerance (eV).")
        .def_property("autoscale_amp_rel_tol",
            [](const CPP_bmad_common &self) { return self.autoscale_amp_rel_tol; },
            [](CPP_bmad_common &self, double val) { self.autoscale_amp_rel_tol = val; },
            "Autoscale relative amplitude tolerance")
        .def_property("autoscale_phase_tol",
            [](const CPP_bmad_common &self) { return self.autoscale_phase_tol; },
            [](CPP_bmad_common &self, double val) { self.autoscale_phase_tol = val; },
            "Autoscale phase tolerance.")
        .def_property("electric_dipole_moment",
            [](const CPP_bmad_common &self) { return self.electric_dipole_moment; },
            [](CPP_bmad_common &self, double val) { self.electric_dipole_moment = val; },
            "Particle's EDM. Call set_ptc to transfer value to PTC.")
        .def_property("synch_rad_scale",
            [](const CPP_bmad_common &self) { return self.synch_rad_scale; },
            [](CPP_bmad_common &self, double val) { self.synch_rad_scale = val; },
            "Synch radiation kick scale. 1 => normal, 0 => no kicks.")
        .def_property("sad_eps_scale",
            [](const CPP_bmad_common &self) { return self.sad_eps_scale; },
            [](CPP_bmad_common &self, double val) { self.sad_eps_scale = val; },
            "Used in sad_mult step length calc.")
        .def_property("sad_amp_max",
            [](const CPP_bmad_common &self) { return self.sad_amp_max; },
            [](CPP_bmad_common &self, double val) { self.sad_amp_max = val; },
            "Used in sad_mult step length calc.")
        .def_property("sad_n_div_max",
            [](const CPP_bmad_common &self) { return self.sad_n_div_max; },
            [](CPP_bmad_common &self, int val) { self.sad_n_div_max = val; },
            "Used in sad_mult step length calc.")
        .def_property("taylor_order",
            [](const CPP_bmad_common &self) { return self.taylor_order; },
            [](CPP_bmad_common &self, int val) { self.taylor_order = val; },
            "Taylor order to use. 0 -> default = ptc_private%taylor_order_saved.")
        .def_property("runge_kutta_order",
            [](const CPP_bmad_common &self) { return self.runge_kutta_order; },
            [](CPP_bmad_common &self, int val) { self.runge_kutta_order = val; },
            "Runge Kutta order.")
        .def_property("default_integ_order",
            [](const CPP_bmad_common &self) { return self.default_integ_order; },
            [](CPP_bmad_common &self, int val) { self.default_integ_order = val; },
            "PTC integration order.")
        .def_property("max_num_runge_kutta_step",
            [](const CPP_bmad_common &self) { return self.max_num_runge_kutta_step; },
            [](CPP_bmad_common &self, int val) { self.max_num_runge_kutta_step = val; },
            "Maximum number of RK steps before particle is considered lost.")
        .def_property("rf_phase_below_transition_ref",
            [](const CPP_bmad_common &self) { return self.rf_phase_below_transition_ref; },
            [](CPP_bmad_common &self, bool val) { self.rf_phase_below_transition_ref = val; },
            "Autoscale uses below transition stable point for RFCavities?")
        .def_property("sr_wakes_on",
            [](const CPP_bmad_common &self) { return self.sr_wakes_on; },
            [](CPP_bmad_common &self, bool val) { self.sr_wakes_on = val; },
            "Short range wakefields?")
        .def_property("lr_wakes_on",
            [](const CPP_bmad_common &self) { return self.lr_wakes_on; },
            [](CPP_bmad_common &self, bool val) { self.lr_wakes_on = val; },
            "Long range wakefields")
        .def_property("auto_bookkeeper",
            [](const CPP_bmad_common &self) { return self.auto_bookkeeper; },
            [](CPP_bmad_common &self, bool val) { self.auto_bookkeeper = val; },
            "Automatic bookkeeping?")
        .def_property("high_energy_space_charge_on",
            [](const CPP_bmad_common &self) { return self.high_energy_space_charge_on; },
            [](CPP_bmad_common &self, bool val) { self.high_energy_space_charge_on = val; },
            "High energy space charge effect switch.")
        .def_property("csr_and_space_charge_on",
            [](const CPP_bmad_common &self) { return self.csr_and_space_charge_on; },
            [](CPP_bmad_common &self, bool val) { self.csr_and_space_charge_on = val; },
            "Space charge switch.")
        .def_property("spin_tracking_on",
            [](const CPP_bmad_common &self) { return self.spin_tracking_on; },
            [](CPP_bmad_common &self, bool val) { self.spin_tracking_on = val; },
            "spin tracking?")
        .def_property("spin_sokolov_ternov_flipping_on",
            [](const CPP_bmad_common &self) { return self.spin_sokolov_ternov_flipping_on; },
            [](CPP_bmad_common &self, bool val) { self.spin_sokolov_ternov_flipping_on = val; },
            "Spin flipping during synchrotron radiation emission?")
        .def_property("radiation_damping_on",
            [](const CPP_bmad_common &self) { return self.radiation_damping_on; },
            [](CPP_bmad_common &self, bool val) { self.radiation_damping_on = val; },
            "Radiation damping toggle.")
        .def_property("radiation_zero_average",
            [](const CPP_bmad_common &self) { return self.radiation_zero_average; },
            [](CPP_bmad_common &self, bool val) { self.radiation_zero_average = val; },
            "Shift damping to be zero on the zero orbit to get rid of sawtooth?")
        .def_property("radiation_fluctuations_on",
            [](const CPP_bmad_common &self) { return self.radiation_fluctuations_on; },
            [](CPP_bmad_common &self, bool val) { self.radiation_fluctuations_on = val; },
            "Radiation fluctuations toggle.")
        .def_property("conserve_taylor_maps",
            [](const CPP_bmad_common &self) { return self.conserve_taylor_maps; },
            [](CPP_bmad_common &self, bool val) { self.conserve_taylor_maps = val; },
            "Enable bookkeeper to set ele%taylor_map_includes_offsets = F?")
        .def_property("absolute_time_tracking",
            [](const CPP_bmad_common &self) { return self.absolute_time_tracking; },
            [](CPP_bmad_common &self, bool val) { self.absolute_time_tracking = val; },
            "Absolute or relative time tracking?")
        .def_property("absolute_time_ref_shift",
            [](const CPP_bmad_common &self) { return self.absolute_time_ref_shift; },
            [](CPP_bmad_common &self, bool val) { self.absolute_time_ref_shift = val; },
            "Apply reference time shift when using absolute time tracking?")
        .def_property("convert_to_kinetic_momentum",
            [](const CPP_bmad_common &self) { return self.convert_to_kinetic_momentum; },
            [](CPP_bmad_common &self, bool val) { self.convert_to_kinetic_momentum = val; },
            "Cancel kicks due to finite vector potential when doing symplectic tracking?")
        .def_property("aperture_limit_on",
            [](const CPP_bmad_common &self) { return self.aperture_limit_on; },
            [](CPP_bmad_common &self, bool val) { self.aperture_limit_on = val; },
            "use apertures in tracking?")
        .def_property("debug",
            [](const CPP_bmad_common &self) { return self.debug; },
            [](CPP_bmad_common &self, bool val) { self.debug = val; },
            "Used for code debugging.")
        ;

    py::class_<CPP_rad_int1>(m, "rad_int1", "Fortran struct: rad_int1_struct")
        .def(py::init<>())
        .def_property("i0",
            [](const CPP_rad_int1 &self) { return self.i0; },
            [](CPP_rad_int1 &self, double val) { self.i0 = val; },
            "Property from Fortran struct")
        .def_property("i1",
            [](const CPP_rad_int1 &self) { return self.i1; },
            [](CPP_rad_int1 &self, double val) { self.i1 = val; },
            "Property from Fortran struct")
        .def_property("i2",
            [](const CPP_rad_int1 &self) { return self.i2; },
            [](CPP_rad_int1 &self, double val) { self.i2 = val; },
            "Property from Fortran struct")
        .def_property("i3",
            [](const CPP_rad_int1 &self) { return self.i3; },
            [](CPP_rad_int1 &self, double val) { self.i3 = val; },
            "Property from Fortran struct")
        .def_property("i4a",
            [](const CPP_rad_int1 &self) { return self.i4a; },
            [](CPP_rad_int1 &self, double val) { self.i4a = val; },
            "Property from Fortran struct")
        .def_property("i4b",
            [](const CPP_rad_int1 &self) { return self.i4b; },
            [](CPP_rad_int1 &self, double val) { self.i4b = val; },
            "Property from Fortran struct")
        .def_property("i4z",
            [](const CPP_rad_int1 &self) { return self.i4z; },
            [](CPP_rad_int1 &self, double val) { self.i4z = val; },
            "Property from Fortran struct")
        .def_property("i5a",
            [](const CPP_rad_int1 &self) { return self.i5a; },
            [](CPP_rad_int1 &self, double val) { self.i5a = val; },
            "Property from Fortran struct")
        .def_property("i5b",
            [](const CPP_rad_int1 &self) { return self.i5b; },
            [](CPP_rad_int1 &self, double val) { self.i5b = val; },
            "Property from Fortran struct")
        .def_property("i6b",
            [](const CPP_rad_int1 &self) { return self.i6b; },
            [](CPP_rad_int1 &self, double val) { self.i6b = val; },
            "Property from Fortran struct")
        .def_property("lin_i2_e4",
            [](const CPP_rad_int1 &self) { return self.lin_i2_e4; },
            [](CPP_rad_int1 &self, double val) { self.lin_i2_e4 = val; },
            "Property from Fortran struct")
        .def_property("lin_i3_e7",
            [](const CPP_rad_int1 &self) { return self.lin_i3_e7; },
            [](CPP_rad_int1 &self, double val) { self.lin_i3_e7 = val; },
            "Property from Fortran struct")
        .def_property("lin_i5a_e6",
            [](const CPP_rad_int1 &self) { return self.lin_i5a_e6; },
            [](CPP_rad_int1 &self, double val) { self.lin_i5a_e6 = val; },
            "Property from Fortran struct")
        .def_property("lin_i5b_e6",
            [](const CPP_rad_int1 &self) { return self.lin_i5b_e6; },
            [](CPP_rad_int1 &self, double val) { self.lin_i5b_e6 = val; },
            "Property from Fortran struct")
        .def_property("lin_norm_emit_a",
            [](const CPP_rad_int1 &self) { return self.lin_norm_emit_a; },
            [](CPP_rad_int1 &self, double val) { self.lin_norm_emit_a = val; },
            "Running sum")
        .def_property("lin_norm_emit_b",
            [](const CPP_rad_int1 &self) { return self.lin_norm_emit_b; },
            [](CPP_rad_int1 &self, double val) { self.lin_norm_emit_b = val; },
            "Running sum")
        .def_property("lin_sig_e",
            [](const CPP_rad_int1 &self) { return self.lin_sig_e; },
            [](CPP_rad_int1 &self, double val) { self.lin_sig_e = val; },
            "Running sum")
        .def_property("n_steps",
            [](const CPP_rad_int1 &self) { return self.n_steps; },
            [](CPP_rad_int1 &self, double val) { self.n_steps = val; },
            "number of qromb steps needed")
        ;

    py::class_<CPP_rad_int_branch>(m, "rad_int_branch", "Fortran struct: rad_int_branch_struct")
        .def(py::init<>())
        // Array property: ele, type: CPP_rad_int1_ARRAY
        .def_property("ele",
            [](const CPP_rad_int_branch &self) {
                // Get list of struct objects
                
                const auto& arr = self.ele;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_rad_int_branch &self, py::object obj) {
                // Set ele from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.ele;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_rad_int1>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_rad_int1 objects");
                }
                
            },
            "Array is indexed from 0")
        ;

    py::class_<CPP_rad_int_all_ele>(m, "rad_int_all_ele", "Fortran struct: rad_int_all_ele_struct")
        .def(py::init<>())
        // Array property: branch, type: CPP_rad_int_branch_ARRAY
        .def_property("branch",
            [](const CPP_rad_int_all_ele &self) {
                // Get list of struct objects
                
                const auto& arr = self.branch;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_rad_int_all_ele &self, py::object obj) {
                // Set branch from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.branch;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_rad_int_branch>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_rad_int_branch objects");
                }
                
            },
            "Array is indexed from 0")
        ;

    py::class_<CPP_ele>(m, "ele", "Fortran struct: ele_struct")
        // TODO: .def(py::init<const int key_ = 0>())
        .def(py::init<>())
        .def_property("name",
            [](const CPP_ele &self) { return self.name; },
            [](CPP_ele &self, std::string val) { self.name = val; },
            "name of element.")
        .def_property("type",
            [](const CPP_ele &self) { return self.type; },
            [](CPP_ele &self, std::string val) { self.type = val; },
            "type name.")
        .def_property("alias",
            [](const CPP_ele &self) { return self.alias; },
            [](CPP_ele &self, std::string val) { self.alias = val; },
            "Another name.")
        .def_property("component_name",
            [](const CPP_ele &self) { return self.component_name; },
            [](CPP_ele &self, std::string val) { self.component_name = val; },
            "Used by overlays, multipass patch, etc.")
        .def_property("descrip",
            [](const CPP_ele &self) { return self.descrip; },
            [](CPP_ele &self, std::string* val) { self.descrip = val; },
            "Description string.")
        .def_property("a",
            [](const CPP_ele &self) { return self.a; },
            [](CPP_ele &self, CPP_twiss val) { self.a = val; },
            "Twiss parameters at end of element")
        .def_property("b",
            [](const CPP_ele &self) { return self.b; },
            [](CPP_ele &self, CPP_twiss val) { self.b = val; },
            "Twiss parameters at end of element")
        .def_property("z",
            [](const CPP_ele &self) { return self.z; },
            [](CPP_ele &self, CPP_twiss val) { self.z = val; },
            "Twiss parameters at end of element")
        .def_property("x",
            [](const CPP_ele &self) { return self.x; },
            [](CPP_ele &self, CPP_xy_disp val) { self.x = val; },
            "Projected dispersions.")
        .def_property("y",
            [](const CPP_ele &self) { return self.y; },
            [](CPP_ele &self, CPP_xy_disp val) { self.y = val; },
            "Projected dispersions.")
        // TODO Skipping ac_kick: pointer to struct type (CPP_ac_kicker)
        .def_property("bookkeeping_state",
            [](const CPP_ele &self) { return self.bookkeeping_state; },
            [](CPP_ele &self, CPP_bookkeeping_state val) { self.bookkeeping_state = val; },
            "Attribute bookkeeping")
        // TODO Skipping control: pointer to struct type (CPP_controller)
        .def_property("floor",
            [](const CPP_ele &self) { return self.floor; },
            [](CPP_ele &self, CPP_floor_position val) { self.floor = val; },
            "Property from Fortran struct")
        // TODO Skipping high_energy_space_charge: pointer to struct type (CPP_high_energy_space_charge)
        // TODO Skipping mode3: pointer to struct type (CPP_mode3)
        // TODO Skipping photon: pointer to struct type (CPP_photon_element)
        // TODO Skipping rad_map: pointer to struct type (CPP_rad_map_ele)
        // Array property: taylor, type: CPP_taylor_ARRAY
        .def_property("taylor",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                const auto& arr = self.taylor;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set taylor from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.taylor;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_taylor>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_taylor objects");
                }
                
            },
            "Phase space Taylor map.")
        // Array property: spin_taylor_ref_orb_in, type: Real_ARRAY
        .def_property("spin_taylor_ref_orb_in",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.spin_taylor_ref_orb_in;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set spin_taylor_ref_orb_in from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.spin_taylor_ref_orb_in.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.spin_taylor_ref_orb_in[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        // Array property: spin_taylor, type: CPP_taylor_ARRAY
        .def_property("spin_taylor",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                const auto& arr = self.spin_taylor;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set spin_taylor from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.spin_taylor;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_taylor>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_taylor objects");
                }
                
            },
            "Quaternion Spin Taylor map.")
        // TODO Skipping wake: pointer to struct type (CPP_wake)
        // Array property: wall3d, type: CPP_wall3d_ARRAY
        .def_property("wall3d",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                const auto& arr = self.wall3d;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set wall3d from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.wall3d;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_wall3d>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_wall3d objects");
                }
                
            },
            "Chamber or capillary wall")
        // Array property: cartesian_map, type: CPP_cartesian_map_ARRAY
        .def_property("cartesian_map",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                const auto& arr = self.cartesian_map;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set cartesian_map from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.cartesian_map;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_cartesian_map>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_cartesian_map objects");
                }
                
            },
            "Used to define E/M fields")
        // Array property: cylindrical_map, type: CPP_cylindrical_map_ARRAY
        .def_property("cylindrical_map",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                const auto& arr = self.cylindrical_map;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set cylindrical_map from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.cylindrical_map;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_cylindrical_map>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_cylindrical_map objects");
                }
                
            },
            "Used to define E/M fields")
        // Array property: gen_grad_map, type: CPP_gen_grad_map_ARRAY
        .def_property("gen_grad_map",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                const auto& arr = self.gen_grad_map;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set gen_grad_map from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.gen_grad_map;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_gen_grad_map>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_gen_grad_map objects");
                }
                
            },
            "Used to define E/M fields.")
        // Array property: grid_field, type: CPP_grid_field_ARRAY
        .def_property("grid_field",
            [](const CPP_ele &self) {
                // Get list of struct objects
                
                const auto& arr = self.grid_field;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_ele &self, py::object obj) {
                // Set grid_field from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.grid_field;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_grid_field>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_grid_field objects");
                }
                
            },
            "Used to define E/M fields.")
        .def_property("map_ref_orb_in",
            [](const CPP_ele &self) { return self.map_ref_orb_in; },
            [](CPP_ele &self, CPP_coord val) { self.map_ref_orb_in = val; },
            "Entrance end transfer map ref orbit")
        .def_property("map_ref_orb_out",
            [](const CPP_ele &self) { return self.map_ref_orb_out; },
            [](CPP_ele &self, CPP_coord val) { self.map_ref_orb_out = val; },
            "Exit end transfer map ref orbit")
        .def_property("time_ref_orb_in",
            [](const CPP_ele &self) { return self.time_ref_orb_in; },
            [](CPP_ele &self, CPP_coord val) { self.time_ref_orb_in = val; },
            "Reference orbit at entrance end for ref_time calc.")
        .def_property("time_ref_orb_out",
            [](const CPP_ele &self) { return self.time_ref_orb_out; },
            [](CPP_ele &self, CPP_coord val) { self.time_ref_orb_out = val; },
            "Reference orbit at exit end for ref_time calc.")
        // Array property: value, type: Real_ARRAY
        .def_property("value",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.value;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set value from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.value.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.value[i] = data[i];
                }
                
            },
            "attribute values.")
        // Array property: old_value, type: Real_ARRAY
        .def_property("old_value",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.old_value;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set old_value from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.old_value.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.old_value[i] = data[i];
                }
                
            },
            "Used to see if %value(:) array has changed.")
        // Array property: spin_q, type: Real_MATRIX
        .def_property("spin_q",
            [](const CPP_ele &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.spin_q;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set spin_q from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.spin_q.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.spin_q[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.spin_q[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "0th and 1st order Spin transport quaternion.")
        // Array property: vec0, type: Real_ARRAY
        .def_property("vec0",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.vec0;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set vec0 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.vec0.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.vec0[i] = data[i];
                }
                
            },
            "0th order transport vector.")
        // Array property: mat6, type: Real_MATRIX
        .def_property("mat6",
            [](const CPP_ele &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.mat6;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set mat6 from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.mat6.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.mat6[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.mat6[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "1st order transport matrix.")
        // Array property: c_mat, type: Real_MATRIX
        .def_property("c_mat",
            [](const CPP_ele &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.c_mat;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set c_mat from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.c_mat.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.c_mat[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.c_mat[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "2x2 C coupling matrix")
        .def_property("gamma_c",
            [](const CPP_ele &self) { return self.gamma_c; },
            [](CPP_ele &self, double val) { self.gamma_c = val; },
            "gamma associated with C matrix")
        .def_property("s_start",
            [](const CPP_ele &self) { return self.s_start; },
            [](CPP_ele &self, double val) { self.s_start = val; },
            "longitudinal ref position at entrance_end")
        .def_property("s",
            [](const CPP_ele &self) { return self.s; },
            [](CPP_ele &self, double val) { self.s = val; },
            "longitudinal ref position at the exit end.")
        .def_property("ref_time",
            [](const CPP_ele &self) { return self.ref_time; },
            [](CPP_ele &self, double val) { self.ref_time = val; },
            "Time ref particle passes exit end.")
        // Array property: a_pole, type: Real_ARRAY
        .def_property("a_pole",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.a_pole;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set a_pole from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.a_pole.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.a_pole[i] = data[i];
                }
                
            },
            "knl for multipole elements.")
        // Array property: b_pole, type: Real_ARRAY
        .def_property("b_pole",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.b_pole;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set b_pole from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.b_pole.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.b_pole[i] = data[i];
                }
                
            },
            "tilt for multipole elements.")
        // Array property: a_pole_elec, type: Real_ARRAY
        .def_property("a_pole_elec",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.a_pole_elec;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set a_pole_elec from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.a_pole_elec.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.a_pole_elec[i] = data[i];
                }
                
            },
            "Electrostatic multipoles. ksnl for multipole elements.")
        // Array property: b_pole_elec, type: Real_ARRAY
        .def_property("b_pole_elec",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.b_pole_elec;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set b_pole_elec from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.b_pole_elec.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.b_pole_elec[i] = data[i];
                }
                
            },
            "Electrostatic multipoles.")
        // Array property: custom, type: Real_ARRAY
        .def_property("custom",
            [](const CPP_ele &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.custom;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set custom from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.custom.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.custom[i] = data[i];
                }
                
            },
            "Custom attributes.")
        // Array property: r, type: Real_TENSOR
        .def_property("r",
            [](const CPP_ele &self) {
                // Get numpy array from Real_TENSOR
                const auto& tensor = self.r;
                
                if (tensor.size() == 0) return py::array(py::dtype::of<double>(), {0, 0, 0});
                
                size_t depth = tensor.size();
                size_t rows = depth > 0 ? tensor[0].size() : 0;
                size_t cols = (depth > 0 && rows > 0) ? tensor[0][0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[depth * rows * cols];
                for (size_t i = 0; i < depth; ++i) {
                    for (size_t j = 0; j < rows; ++j) {
                        for (size_t k = 0; k < cols; ++k) {
                            data[i*(rows*cols) + j*cols + k] = tensor[i][j][k];
                        }
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {depth, rows, cols}, 
                                {rows * cols * sizeof(double), cols * sizeof(double), sizeof(double)}, 
                                data, capsule);
                
            },
            [](CPP_ele &self, py::array arr) {
                // Set r from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 3) throw std::runtime_error("Expected a 3D array");
                
                // Resize and copy data
                size_t depth = static_cast<size_t>(info.shape[0]);
                size_t rows = static_cast<size_t>(info.shape[1]);
                size_t cols = static_cast<size_t>(info.shape[2]);
                
                self.r.resize(depth);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < depth; ++i) {
                    self.r[i].resize(rows);
                    for (size_t j = 0; j < rows; ++j) {
                        self.r[i][j].resize(cols);
                        for (size_t k = 0; k < cols; ++k) {
                            self.r[i][j][k] = data[i * info.strides[0]/sizeof(double) + 
                                                         j * info.strides[1]/sizeof(double) + 
                                                         k * info.strides[2]/sizeof(double)];
                        }
                    }
                }
                
            },
            "For general use. Not used by Bmad.")
        .def_property("key",
            [](const CPP_ele &self) { return self.key; },
            [](CPP_ele &self, int val) { self.key = val; },
            "Element class (quadrupole, etc.).")
        .def_property("sub_key",
            [](const CPP_ele &self) { return self.sub_key; },
            [](CPP_ele &self, int val) { self.sub_key = val; },
            "Records bend input type.")
        .def_property("ix_ele",
            [](const CPP_ele &self) { return self.ix_ele; },
            [](CPP_ele &self, int val) { self.ix_ele = val; },
            "Index in branch ele(0:) array. Set to ix_slice_slave$ = -2 for slice_slave$ elements.")
        .def_property("ix_branch",
            [](const CPP_ele &self) { return self.ix_branch; },
            [](CPP_ele &self, int val) { self.ix_branch = val; },
            "Index in lat%branch(:) array. Note: lat%ele => lat%branch(0).")
        .def_property("lord_status",
            [](const CPP_ele &self) { return self.lord_status; },
            [](CPP_ele &self, int val) { self.lord_status = val; },
            "Type of lord element this is. overlay_lord$, etc.")
        .def_property("n_slave",
            [](const CPP_ele &self) { return self.n_slave; },
            [](CPP_ele &self, int val) { self.n_slave = val; },
            "Number of slaves (except field overlap slaves) of this element.")
        .def_property("n_slave_field",
            [](const CPP_ele &self) { return self.n_slave_field; },
            [](CPP_ele &self, int val) { self.n_slave_field = val; },
            "Number of field slaves of this element.")
        .def_property("ix1_slave",
            [](const CPP_ele &self) { return self.ix1_slave; },
            [](CPP_ele &self, int val) { self.ix1_slave = val; },
            "Pointer index to this element's slaves.")
        .def_property("slave_status",
            [](const CPP_ele &self) { return self.slave_status; },
            [](CPP_ele &self, int val) { self.slave_status = val; },
            "Type of slave element this is. multipass_slave$, slice_slave$, etc.")
        .def_property("n_lord",
            [](const CPP_ele &self) { return self.n_lord; },
            [](CPP_ele &self, int val) { self.n_lord = val; },
            "Number of lords (except field overlap and ramper lords).")
        .def_property("n_lord_field",
            [](const CPP_ele &self) { return self.n_lord_field; },
            [](CPP_ele &self, int val) { self.n_lord_field = val; },
            "Number of field lords of this element.")
        .def_property("n_lord_ramper",
            [](const CPP_ele &self) { return self.n_lord_ramper; },
            [](CPP_ele &self, int val) { self.n_lord_ramper = val; },
            "Number of ramper lords.")
        .def_property("ic1_lord",
            [](const CPP_ele &self) { return self.ic1_lord; },
            [](CPP_ele &self, int val) { self.ic1_lord = val; },
            "Pointer index to this element's lords.")
        .def_property("ix_pointer",
            [](const CPP_ele &self) { return self.ix_pointer; },
            [](CPP_ele &self, int val) { self.ix_pointer = val; },
            "For general use. Not used by Bmad.")
        .def_property("ixx",
            [](const CPP_ele &self) { return self.ixx; },
            [](CPP_ele &self, int val) { self.ixx = val; },
            "Index for Bmad internal use.")
        .def_property("iyy",
            [](const CPP_ele &self) { return self.iyy; },
            [](CPP_ele &self, int val) { self.iyy = val; },
            "Index for Bmad internal use.")
        .def_property("izz",
            [](const CPP_ele &self) { return self.izz; },
            [](CPP_ele &self, int val) { self.izz = val; },
            "Index for Bmad internal use.")
        .def_property("mat6_calc_method",
            [](const CPP_ele &self) { return self.mat6_calc_method; },
            [](CPP_ele &self, int val) { self.mat6_calc_method = val; },
            "taylor$, symp_lie_ptc$, etc.")
        .def_property("tracking_method",
            [](const CPP_ele &self) { return self.tracking_method; },
            [](CPP_ele &self, int val) { self.tracking_method = val; },
            "taylor$, linear$, etc.")
        .def_property("spin_tracking_method",
            [](const CPP_ele &self) { return self.spin_tracking_method; },
            [](CPP_ele &self, int val) { self.spin_tracking_method = val; },
            "symp_lie_ptc$, etc.")
        .def_property("csr_method",
            [](const CPP_ele &self) { return self.csr_method; },
            [](CPP_ele &self, int val) { self.csr_method = val; },
            "or one_dim$ ('1_dim'), steady_state_3d$")
        .def_property("space_charge_method",
            [](const CPP_ele &self) { return self.space_charge_method; },
            [](CPP_ele &self, int val) { self.space_charge_method = val; },
            "slice$, slice_longitudinal$, slice_transverse$, fft_3D$, cathode_fft_3d$")
        .def_property("ptc_integration_type",
            [](const CPP_ele &self) { return self.ptc_integration_type; },
            [](CPP_ele &self, int val) { self.ptc_integration_type = val; },
            "drift_kick$, matrix_kick$, or ripken_kick$")
        .def_property("field_calc",
            [](const CPP_ele &self) { return self.field_calc; },
            [](CPP_ele &self, int val) { self.field_calc = val; },
            "no_field$, fieldmap$, refer_to_lords$, or custom$")
        .def_property("aperture_at",
            [](const CPP_ele &self) { return self.aperture_at; },
            [](CPP_ele &self, int val) { self.aperture_at = val; },
            "Aperture location: entrance_end$, ...")
        .def_property("aperture_type",
            [](const CPP_ele &self) { return self.aperture_type; },
            [](CPP_ele &self, int val) { self.aperture_type = val; },
            "rectangular$, elliptical$, auto_aperture$, ...")
        .def_property("ref_species",
            [](const CPP_ele &self) { return self.ref_species; },
            [](CPP_ele &self, int val) { self.ref_species = val; },
            "Reference species")
        .def_property("orientation",
            [](const CPP_ele &self) { return self.orientation; },
            [](CPP_ele &self, int val) { self.orientation = val; },
            "-1 -> Element is longitudinally reversed. +1 -> Normal.")
        .def_property("symplectify",
            [](const CPP_ele &self) { return self.symplectify; },
            [](CPP_ele &self, bool val) { self.symplectify = val; },
            "Symplectify mat6 matrices.")
        .def_property("mode_flip",
            [](const CPP_ele &self) { return self.mode_flip; },
            [](CPP_ele &self, bool val) { self.mode_flip = val; },
            "Have the normal modes traded places?")
        .def_property("multipoles_on",
            [](const CPP_ele &self) { return self.multipoles_on; },
            [](CPP_ele &self, bool val) { self.multipoles_on = val; },
            "For turning multipoles on/off")
        .def_property("scale_multipoles",
            [](const CPP_ele &self) { return self.scale_multipoles; },
            [](CPP_ele &self, bool val) { self.scale_multipoles = val; },
            "Are ab_multipoles within other elements (EG: quads, etc.)")
        .def_property("taylor_map_includes_offsets",
            [](const CPP_ele &self) { return self.taylor_map_includes_offsets; },
            [](CPP_ele &self, bool val) { self.taylor_map_includes_offsets = val; },
            "Taylor map calculated with element misalignments?")
        .def_property("field_master",
            [](const CPP_ele &self) { return self.field_master; },
            [](CPP_ele &self, bool val) { self.field_master = val; },
            "Calculate strength from the field value?")
        .def_property("is_on",
            [](const CPP_ele &self) { return self.is_on; },
            [](CPP_ele &self, bool val) { self.is_on = val; },
            "For turning element on/off.")
        .def_property("logic",
            [](const CPP_ele &self) { return self.logic; },
            [](CPP_ele &self, bool val) { self.logic = val; },
            "For general use. Not used by Bmad (except during lattice parsing).")
        .def_property("bmad_logic",
            [](const CPP_ele &self) { return self.bmad_logic; },
            [](CPP_ele &self, bool val) { self.bmad_logic = val; },
            "For Bmad internal use only.")
        .def_property("select",
            [](const CPP_ele &self) { return self.select; },
            [](CPP_ele &self, bool val) { self.select = val; },
            "For Bmad internal use only.")
        .def_property("offset_moves_aperture",
            [](const CPP_ele &self) { return self.offset_moves_aperture; },
            [](CPP_ele &self, bool val) { self.offset_moves_aperture = val; },
            "element offsets affects aperture?")
        // Custom methods
        // Additional methods would be bound here
        ;

    py::class_<CPP_complex_taylor_term>(m, "complex_taylor_term", "Fortran struct: complex_taylor_term_struct")
        .def(py::init<>())
        .def_property("coef",
            [](const CPP_complex_taylor_term &self) { return self.coef; },
            [](CPP_complex_taylor_term &self, std::complex<double> val) { self.coef = val; },
            "Property from Fortran struct")
        // Array property: expn, type: Int_ARRAY
        .def_property("expn",
            [](const CPP_complex_taylor_term &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.expn;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new int[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<int*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<int>(), {size}, {sizeof(int)}, data, capsule);
                
            },
            [](CPP_complex_taylor_term &self, py::array arr) {
                // Set expn from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.expn.resize(size);
                auto* data = static_cast<int*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.expn[i] = data[i];
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_complex_taylor>(m, "complex_taylor", "Fortran struct: complex_taylor_struct")
        .def(py::init<>())
        .def_property("ref",
            [](const CPP_complex_taylor &self) { return self.ref; },
            [](CPP_complex_taylor &self, std::complex<double> val) { self.ref = val; },
            "Property from Fortran struct")
        // Array property: term, type: CPP_complex_taylor_term_ARRAY
        .def_property("term",
            [](const CPP_complex_taylor &self) {
                // Get list of struct objects
                
                const auto& arr = self.term;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_complex_taylor &self, py::object obj) {
                // Set term from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.term;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_complex_taylor_term>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_complex_taylor_term objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_branch>(m, "branch", "Fortran struct: branch_struct")
        .def(py::init<>())
        .def_property("name",
            [](const CPP_branch &self) { return self.name; },
            [](CPP_branch &self, std::string val) { self.name = val; },
            "Name of line that defines the branch.")
        .def_property("ix_branch",
            [](const CPP_branch &self) { return self.ix_branch; },
            [](CPP_branch &self, int val) { self.ix_branch = val; },
            "Index of this branch. 0 => Main branch")
        .def_property("ix_from_branch",
            [](const CPP_branch &self) { return self.ix_from_branch; },
            [](CPP_branch &self, int val) { self.ix_from_branch = val; },
            "-1 => No creating fork element to this branch.")
        .def_property("ix_from_ele",
            [](const CPP_branch &self) { return self.ix_from_ele; },
            [](CPP_branch &self, int val) { self.ix_from_ele = val; },
            "Index of creating fork element which forks to this branch.")
        .def_property("ix_to_ele",
            [](const CPP_branch &self) { return self.ix_to_ele; },
            [](CPP_branch &self, int val) { self.ix_to_ele = val; },
            "Index of element in this branch that creating fork element forks to.")
        .def_property("n_ele_track",
            [](const CPP_branch &self) { return self.n_ele_track; },
            [](CPP_branch &self, int val) { self.n_ele_track = val; },
            "Property from Fortran struct")
        .def_property("n_ele_max",
            [](const CPP_branch &self) { return self.n_ele_max; },
            [](CPP_branch &self, int val) { self.n_ele_max = val; },
            "Property from Fortran struct")
        .def_property("a",
            [](const CPP_branch &self) { return self.a; },
            [](CPP_branch &self, CPP_mode_info val) { self.a = val; },
            "Note: Tunes are the fractional part.")
        .def_property("b",
            [](const CPP_branch &self) { return self.b; },
            [](CPP_branch &self, CPP_mode_info val) { self.b = val; },
            "Note: Tunes are the fractional part.")
        .def_property("z",
            [](const CPP_branch &self) { return self.z; },
            [](CPP_branch &self, CPP_mode_info val) { self.z = val; },
            "Note: Tunes are the fractional part.")
        // Array property: ele, type: CPP_ele_ARRAY
        .def_property("ele",
            [](const CPP_branch &self) {
                // Get list of struct objects
                
                const auto& arr = self.ele;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_branch &self, py::object obj) {
                // Set ele from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.ele;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_ele>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_ele objects");
                }
                
            },
            "Property from Fortran struct")
        .def_property("param",
            [](const CPP_branch &self) { return self.param; },
            [](CPP_branch &self, CPP_lat_param val) { self.param = val; },
            "Property from Fortran struct")
        // Array property: wall3d, type: CPP_wall3d_ARRAY
        .def_property("wall3d",
            [](const CPP_branch &self) {
                // Get list of struct objects
                
                const auto& arr = self.wall3d;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_branch &self, py::object obj) {
                // Set wall3d from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.wall3d;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_wall3d>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_wall3d objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_lat>(m, "lat", "Fortran struct: lat_struct")
        .def(py::init<>())
        .def_property("use_name",
            [](const CPP_lat &self) { return self.use_name; },
            [](CPP_lat &self, std::string val) { self.use_name = val; },
            "Name of lat given by USE statement")
        .def_property("lattice",
            [](const CPP_lat &self) { return self.lattice; },
            [](CPP_lat &self, std::string val) { self.lattice = val; },
            "Lattice")
        .def_property("machine",
            [](const CPP_lat &self) { return self.machine; },
            [](CPP_lat &self, std::string val) { self.machine = val; },
            "Name of the machine the lattice is for ('LHC', etc).")
        .def_property("input_file_name",
            [](const CPP_lat &self) { return self.input_file_name; },
            [](CPP_lat &self, std::string val) { self.input_file_name = val; },
            "Name of the lattice input file")
        .def_property("title",
            [](const CPP_lat &self) { return self.title; },
            [](CPP_lat &self, std::string val) { self.title = val; },
            "General title")
        // Array property: print_str, type: String_ARRAY
        .def_property("print_str",
            [](const CPP_lat &self) {
                // Get numpy array from String_ARRAY
                const auto& arr = self.print_str;
                auto size = arr.size();
                return py::cast(std::vector<std::string>(std::begin(arr), std::end(arr)));
            },
            [](CPP_lat &self, py::array arr) {
                // Set print_str from numpy array
                
                py::list string_list = arr.cast<py::list>();
                self.print_str.resize(string_list.size());
                for (size_t i = 0; i < string_list.size(); ++i) {
                    self.print_str[i] = string_list[i].cast<std::string>();
                }
                
            },
            "Saved print statements.")
        // Array property: constant, type: CPP_expression_atom_ARRAY
        .def_property("constant",
            [](const CPP_lat &self) {
                // Get list of struct objects
                
                const auto& arr = self.constant;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_lat &self, py::object obj) {
                // Set constant from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.constant;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_expression_atom>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_expression_atom objects");
                }
                
            },
            "Constants defined in the lattice")
        // TODO Skipping a: pointer to struct type (CPP_mode_info)
        // TODO Skipping b: pointer to struct type (CPP_mode_info)
        // TODO Skipping z: pointer to struct type (CPP_mode_info)
        // TODO Skipping param: pointer to struct type (CPP_lat_param)
        .def_property("lord_state",
            [](const CPP_lat &self) { return self.lord_state; },
            [](CPP_lat &self, CPP_bookkeeping_state val) { self.lord_state = val; },
            "lord bookkeeping status.")
        .def_property("ele_init",
            [](const CPP_lat &self) { return self.ele_init; },
            [](CPP_lat &self, CPP_ele val) { self.ele_init = val; },
            "For use by any program")
        // Array property: ele, type: CPP_ele_ARRAY
        .def_property("ele",
            [](const CPP_lat &self) {
                // Get list of struct objects
                
                const auto& arr = self.ele;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_lat &self, py::object obj) {
                // Set ele from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.ele;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_ele>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_ele objects");
                }
                
            },
            "Array of elements [=> branch(0)].")
        // Array property: branch, type: CPP_branch_ARRAY
        .def_property("branch",
            [](const CPP_lat &self) {
                // Get list of struct objects
                
                const auto& arr = self.branch;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_lat &self, py::object obj) {
                // Set branch from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.branch;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_branch>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_branch objects");
                }
                
            },
            "Branch(0:) array")
        // Array property: control, type: CPP_control_ARRAY
        .def_property("control",
            [](const CPP_lat &self) {
                // Get list of struct objects
                
                const auto& arr = self.control;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_lat &self, py::object obj) {
                // Set control from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.control;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_control>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_control objects");
                }
                
            },
            "Control list")
        .def_property("particle_start",
            [](const CPP_lat &self) { return self.particle_start; },
            [](CPP_lat &self, CPP_coord val) { self.particle_start = val; },
            "Starting particle_coords.")
        .def_property("beam_init",
            [](const CPP_lat &self) { return self.beam_init; },
            [](CPP_lat &self, CPP_beam_init val) { self.beam_init = val; },
            "Beam initialization.")
        .def_property("pre_tracker",
            [](const CPP_lat &self) { return self.pre_tracker; },
            [](CPP_lat &self, CPP_pre_tracker val) { self.pre_tracker = val; },
            "For OPAL/IMPACT-T")
        // Array property: custom, type: Real_ARRAY
        .def_property("custom",
            [](const CPP_lat &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.custom;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_lat &self, py::array arr) {
                // Set custom from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.custom.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.custom[i] = data[i];
                }
                
            },
            "Custom attributes.")
        .def_property("version",
            [](const CPP_lat &self) { return self.version; },
            [](CPP_lat &self, int val) { self.version = val; },
            "Version number")
        .def_property("n_ele_track",
            [](const CPP_lat &self) { return self.n_ele_track; },
            [](CPP_lat &self, int* val) { self.n_ele_track = val; },
            "Number of lat elements to track through.")
        .def_property("n_ele_max",
            [](const CPP_lat &self) { return self.n_ele_max; },
            [](CPP_lat &self, int* val) { self.n_ele_max = val; },
            "Index of last valid element in %ele(:) array")
        .def_property("n_control_max",
            [](const CPP_lat &self) { return self.n_control_max; },
            [](CPP_lat &self, int val) { self.n_control_max = val; },
            "Last index used in control_array")
        .def_property("n_ic_max",
            [](const CPP_lat &self) { return self.n_ic_max; },
            [](CPP_lat &self, int val) { self.n_ic_max = val; },
            "Last index used in ic_array")
        .def_property("input_taylor_order",
            [](const CPP_lat &self) { return self.input_taylor_order; },
            [](CPP_lat &self, int val) { self.input_taylor_order = val; },
            "As set in the input file")
        // Array property: ic, type: Int_ARRAY
        .def_property("ic",
            [](const CPP_lat &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.ic;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new int[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<int*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<int>(), {size}, {sizeof(int)}, data, capsule);
                
            },
            [](CPP_lat &self, py::array arr) {
                // Set ic from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.ic.resize(size);
                auto* data = static_cast<int*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.ic[i] = data[i];
                }
                
            },
            "Index to %control(:) from slaves.")
        .def_property("photon_type",
            [](const CPP_lat &self) { return self.photon_type; },
            [](CPP_lat &self, int val) { self.photon_type = val; },
            "Or coherent$. For X-ray simulations.")
        .def_property("creation_hash",
            [](const CPP_lat &self) { return self.creation_hash; },
            [](CPP_lat &self, int val) { self.creation_hash = val; },
            "Set by bmad_parser. creation_hash will vary if")
        .def_property("ramper_slave_bookkeeping",
            [](const CPP_lat &self) { return self.ramper_slave_bookkeeping; },
            [](CPP_lat &self, int val) { self.ramper_slave_bookkeeping = val; },
            "Property from Fortran struct")
        ;

    py::class_<CPP_bunch>(m, "bunch", "Fortran struct: bunch_struct")
        .def(py::init<>())
        // Array property: particle, type: CPP_coord_ARRAY
        .def_property("particle",
            [](const CPP_bunch &self) {
                // Get list of struct objects
                
                const auto& arr = self.particle;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_bunch &self, py::object obj) {
                // Set particle from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.particle;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_coord>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_coord objects");
                }
                
            },
            "Property from Fortran struct")
        // Array property: ix_z, type: Int_ARRAY
        .def_property("ix_z",
            [](const CPP_bunch &self) {
                // Get numpy array from Int_ARRAY
                const auto& arr = self.ix_z;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new int[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<int*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<int>(), {size}, {sizeof(int)}, data, capsule);
                
            },
            [](CPP_bunch &self, py::array arr) {
                // Set ix_z from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.ix_z.resize(size);
                auto* data = static_cast<int*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.ix_z[i] = data[i];
                }
                
            },
            "bunch%ix_z(1) is index of head particle, etc.")
        .def_property("charge_tot",
            [](const CPP_bunch &self) { return self.charge_tot; },
            [](CPP_bunch &self, double val) { self.charge_tot = val; },
            "Total charge in a bunch (Coul).")
        .def_property("charge_live",
            [](const CPP_bunch &self) { return self.charge_live; },
            [](CPP_bunch &self, double val) { self.charge_live = val; },
            "Charge of live particles (Coul).")
        .def_property("z_center",
            [](const CPP_bunch &self) { return self.z_center; },
            [](CPP_bunch &self, double val) { self.z_center = val; },
            "Longitudinal center of bunch at creation time. Note: Generally, z_center of")
        .def_property("t_center",
            [](const CPP_bunch &self) { return self.t_center; },
            [](CPP_bunch &self, double val) { self.t_center = val; },
            "Center of bunch at creation time relative to head bunch.")
        .def_property("t0",
            [](const CPP_bunch &self) { return self.t0; },
            [](CPP_bunch &self, double val) { self.t0 = val; },
            "Used by track1_bunch_space_charge for tracking so particles have constant t.")
        .def_property("drift_between_t_and_s",
            [](const CPP_bunch &self) { return self.drift_between_t_and_s; },
            [](CPP_bunch &self, bool val) { self.drift_between_t_and_s = val; },
            "Property from Fortran struct")
        .def_property("ix_ele",
            [](const CPP_bunch &self) { return self.ix_ele; },
            [](CPP_bunch &self, int val) { self.ix_ele = val; },
            "Nominal element bunch is at. But, EG, dead particles can be someplace else.")
        .def_property("ix_bunch",
            [](const CPP_bunch &self) { return self.ix_bunch; },
            [](CPP_bunch &self, int val) { self.ix_bunch = val; },
            "Bunch index. Head bunch = 1, etc.")
        .def_property("ix_turn",
            [](const CPP_bunch &self) { return self.ix_turn; },
            [](CPP_bunch &self, int val) { self.ix_turn = val; },
            "Turn index for long term tracking. ix_turn = 0 before end of first turn, etc.")
        .def_property("n_live",
            [](const CPP_bunch &self) { return self.n_live; },
            [](CPP_bunch &self, int val) { self.n_live = val; },
            "Property from Fortran struct")
        .def_property("n_good",
            [](const CPP_bunch &self) { return self.n_good; },
            [](CPP_bunch &self, int val) { self.n_good = val; },
            "Number of accepted steps when using adaptive step size control.")
        .def_property("n_bad",
            [](const CPP_bunch &self) { return self.n_bad; },
            [](CPP_bunch &self, int val) { self.n_bad = val; },
            "Number of rejected steps when using adaptive step size control.")
        ;

    py::class_<CPP_bunch_params>(m, "bunch_params", "Fortran struct: bunch_params_struct")
        .def(py::init<>())
        .def_property("centroid",
            [](const CPP_bunch_params &self) { return self.centroid; },
            [](CPP_bunch_params &self, CPP_coord val) { self.centroid = val; },
            "Lab frame")
        .def_property("x",
            [](const CPP_bunch_params &self) { return self.x; },
            [](CPP_bunch_params &self, CPP_twiss val) { self.x = val; },
            "Projected Twiss parameters")
        .def_property("y",
            [](const CPP_bunch_params &self) { return self.y; },
            [](CPP_bunch_params &self, CPP_twiss val) { self.y = val; },
            "Projected Twiss parameters")
        .def_property("z",
            [](const CPP_bunch_params &self) { return self.z; },
            [](CPP_bunch_params &self, CPP_twiss val) { self.z = val; },
            "Projected Twiss parameters")
        .def_property("a",
            [](const CPP_bunch_params &self) { return self.a; },
            [](CPP_bunch_params &self, CPP_twiss val) { self.a = val; },
            "Normal mode twiss parameters")
        .def_property("b",
            [](const CPP_bunch_params &self) { return self.b; },
            [](CPP_bunch_params &self, CPP_twiss val) { self.b = val; },
            "Normal mode twiss parameters")
        .def_property("c",
            [](const CPP_bunch_params &self) { return self.c; },
            [](CPP_bunch_params &self, CPP_twiss val) { self.c = val; },
            "Normal mode twiss parameters")
        // Array property: sigma, type: Real_MATRIX
        .def_property("sigma",
            [](const CPP_bunch_params &self) {
                // Get numpy array from Real_MATRIX
                const auto& matrix = self.sigma;
                
                if (matrix.size() == 0) return py::array(py::dtype::of<double>(), {0, 0});
                
                size_t rows = matrix.size();
                size_t cols = rows > 0 ? matrix[0].size() : 0;
                
                // Copy data to avoid lifetime issues
                auto* data = new double[rows * cols];
                for (size_t i = 0; i < rows; ++i) {
                    for (size_t j = 0; j < cols; ++j) {
                        data[i*cols + j] = matrix[i][j];
                    }
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {rows, cols}, {cols * sizeof(double), sizeof(double)}, data, capsule);
                
            },
            [](CPP_bunch_params &self, py::array arr) {
                // Set sigma from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
                
                // Resize and copy data
                size_t rows = static_cast<size_t>(info.shape[0]);
                size_t cols = static_cast<size_t>(info.shape[1]);
                
                self.sigma.resize(rows);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < rows; ++i) {
                    self.sigma[i].resize(cols);
                    for (size_t j = 0; j < cols; ++j) {
                        self.sigma[i][j] = data[i * info.strides[0]/sizeof(double) + j * info.strides[1]/sizeof(double)];
                    }
                }
                
            },
            "beam size matrix")
        // Array property: rel_max, type: Real_ARRAY
        .def_property("rel_max",
            [](const CPP_bunch_params &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.rel_max;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_bunch_params &self, py::array arr) {
                // Set rel_max from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.rel_max.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.rel_max[i] = data[i];
                }
                
            },
            "Max orbit relative to centroid. 7 -> time.")
        // Array property: rel_min, type: Real_ARRAY
        .def_property("rel_min",
            [](const CPP_bunch_params &self) {
                // Get numpy array from Real_ARRAY
                const auto& arr = self.rel_min;
                auto size = arr.size();
                
                // Copy data to avoid lifetime issues
                auto* data = new double[size];
                for (size_t i = 0; i < size; ++i) {
                    data[i] = arr[i];
                }
                
                // Create a capsule to manage the memory
                auto capsule = py::capsule(data, [](void *p) { delete[] static_cast<double*>(p); });
                
                // Return numpy array
                return py::array(py::dtype::of<double>(), {size}, {sizeof(double)}, data, capsule);
                
            },
            [](CPP_bunch_params &self, py::array arr) {
                // Set rel_min from numpy array
                
                py::buffer_info info = arr.request();
                if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
                
                // Resize and copy data
                size_t size = static_cast<size_t>(info.shape[0]);
                self.rel_min.resize(size);
                auto* data = static_cast<double*>(info.ptr);
                
                for (size_t i = 0; i < size; ++i) {
                    self.rel_min[i] = data[i];
                }
                
            },
            "Min orbit relative to_centroid. 7 -> time.")
        .def_property("s",
            [](const CPP_bunch_params &self) { return self.s; },
            [](CPP_bunch_params &self, double val) { self.s = val; },
            "Longitudinal position.")
        .def_property("t",
            [](const CPP_bunch_params &self) { return self.t; },
            [](CPP_bunch_params &self, double val) { self.t = val; },
            "Time.")
        .def_property("sigma_t",
            [](const CPP_bunch_params &self) { return self.sigma_t; },
            [](CPP_bunch_params &self, double val) { self.sigma_t = val; },
            "RMS of time spread.")
        .def_property("charge_live",
            [](const CPP_bunch_params &self) { return self.charge_live; },
            [](CPP_bunch_params &self, double val) { self.charge_live = val; },
            "Charge of all non-lost particle")
        .def_property("charge_tot",
            [](const CPP_bunch_params &self) { return self.charge_tot; },
            [](CPP_bunch_params &self, double val) { self.charge_tot = val; },
            "Charge of all particles.")
        .def_property("n_particle_tot",
            [](const CPP_bunch_params &self) { return self.n_particle_tot; },
            [](CPP_bunch_params &self, int val) { self.n_particle_tot = val; },
            "Total number of particles")
        .def_property("n_particle_live",
            [](const CPP_bunch_params &self) { return self.n_particle_live; },
            [](CPP_bunch_params &self, int val) { self.n_particle_live = val; },
            "Number of non-lost particles")
        .def_property("n_particle_lost_in_ele",
            [](const CPP_bunch_params &self) { return self.n_particle_lost_in_ele; },
            [](CPP_bunch_params &self, int val) { self.n_particle_lost_in_ele = val; },
            "Number lost in element (not calculated by Bmad)")
        .def_property("n_good_steps",
            [](const CPP_bunch_params &self) { return self.n_good_steps; },
            [](CPP_bunch_params &self, int val) { self.n_good_steps = val; },
            "Number of good steps (set when tracking with space charge)")
        .def_property("n_bad_steps",
            [](const CPP_bunch_params &self) { return self.n_bad_steps; },
            [](CPP_bunch_params &self, int val) { self.n_bad_steps = val; },
            "Number of bad steps (set when tracking with space charge)")
        .def_property("ix_ele",
            [](const CPP_bunch_params &self) { return self.ix_ele; },
            [](CPP_bunch_params &self, int val) { self.ix_ele = val; },
            "Lattice element where params evaluated at.")
        .def_property("location",
            [](const CPP_bunch_params &self) { return self.location; },
            [](CPP_bunch_params &self, int val) { self.location = val; },
            "Location in element: upstream_end$, inside$, or downstream_end$")
        .def_property("twiss_valid",
            [](const CPP_bunch_params &self) { return self.twiss_valid; },
            [](CPP_bunch_params &self, bool val) { self.twiss_valid = val; },
            "Is the data here valid? Note: IF there is no energy")
        ;

    py::class_<CPP_beam>(m, "beam", "Fortran struct: beam_struct")
        .def(py::init<>())
        // Array property: bunch, type: CPP_bunch_ARRAY
        .def_property("bunch",
            [](const CPP_beam &self) {
                // Get list of struct objects
                
                const auto& arr = self.bunch;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_beam &self, py::object obj) {
                // Set bunch from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.bunch;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_bunch>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_bunch objects");
                }
                
            },
            "Property from Fortran struct")
        ;

    py::class_<CPP_aperture_point>(m, "aperture_point", "Fortran struct: aperture_point_struct")
        .def(py::init<>())
        .def_property("x",
            [](const CPP_aperture_point &self) { return self.x; },
            [](CPP_aperture_point &self, double val) { self.x = val; },
            "(x,y) aperture point with respect to the reference orbit.")
        .def_property("y",
            [](const CPP_aperture_point &self) { return self.y; },
            [](CPP_aperture_point &self, double val) { self.y = val; },
            "(x,y) aperture point with respect to the reference orbit.")
        .def_property("plane",
            [](const CPP_aperture_point &self) { return self.plane; },
            [](CPP_aperture_point &self, int val) { self.plane = val; },
            "plane determining loss")
        .def_property("ix_ele",
            [](const CPP_aperture_point &self) { return self.ix_ele; },
            [](CPP_aperture_point &self, int val) { self.ix_ele = val; },
            "ele index particle lost at")
        .def_property("i_turn",
            [](const CPP_aperture_point &self) { return self.i_turn; },
            [](CPP_aperture_point &self, int val) { self.i_turn = val; },
            "turn particle lost at")
        ;

    py::class_<CPP_aperture_param>(m, "aperture_param", "Fortran struct: aperture_param_struct")
        .def(py::init<>())
        .def_property("min_angle",
            [](const CPP_aperture_param &self) { return self.min_angle; },
            [](CPP_aperture_param &self, double val) { self.min_angle = val; },
            "Property from Fortran struct")
        .def_property("max_angle",
            [](const CPP_aperture_param &self) { return self.max_angle; },
            [](CPP_aperture_param &self, double val) { self.max_angle = val; },
            "Property from Fortran struct")
        .def_property("n_angle",
            [](const CPP_aperture_param &self) { return self.n_angle; },
            [](CPP_aperture_param &self, int val) { self.n_angle = val; },
            "Property from Fortran struct")
        .def_property("n_turn",
            [](const CPP_aperture_param &self) { return self.n_turn; },
            [](CPP_aperture_param &self, int val) { self.n_turn = val; },
            "Number of turns a particle must survive.")
        .def_property("x_init",
            [](const CPP_aperture_param &self) { return self.x_init; },
            [](CPP_aperture_param &self, double val) { self.x_init = val; },
            "Initial x coordinate to start with for theta_xy = 0.")
        .def_property("y_init",
            [](const CPP_aperture_param &self) { return self.y_init; },
            [](CPP_aperture_param &self, double val) { self.y_init = val; },
            "Initial y coordinate to start with for theta_xy = pi/2.")
        .def_property("rel_accuracy",
            [](const CPP_aperture_param &self) { return self.rel_accuracy; },
            [](CPP_aperture_param &self, double val) { self.rel_accuracy = val; },
            "Relative resolution of bracketed aperture.")
        .def_property("abs_accuracy",
            [](const CPP_aperture_param &self) { return self.abs_accuracy; },
            [](CPP_aperture_param &self, double val) { self.abs_accuracy = val; },
            "Absolute resolution of bracketed aperture (meters).")
        .def_property("start_ele",
            [](const CPP_aperture_param &self) { return self.start_ele; },
            [](CPP_aperture_param &self, std::string val) { self.start_ele = val; },
            "Element to start tracking at.")
        ;

    py::class_<CPP_aperture_scan>(m, "aperture_scan", "Fortran struct: aperture_scan_struct")
        .def(py::init<>())
        // Array property: point, type: CPP_aperture_point_ARRAY
        .def_property("point",
            [](const CPP_aperture_scan &self) {
                // Get list of struct objects
                
                const auto& arr = self.point;
                py::list result;
                for (size_t i = 0; i < arr.size(); ++i) {
                    result.append(py::cast(arr[i]));
                }
                return result;
                
            },
            [](CPP_aperture_scan &self, py::object obj) {
                // Set point from list of structs
                
                try {
                    py::list list = obj.cast<py::list>();
                    auto& arr = self.point;
                    arr.resize(list.size());
                    
                    for (size_t i = 0; i < list.size(); ++i) {
                        arr[i] = list[i].cast<CPP_aperture_point>();
                    }
                } catch (const py::cast_error& e) {
                    throw std::runtime_error("Expected a list of CPP_aperture_point objects");
                }
                
            },
            "Set of aperture points at different angles.")
        .def_property("ref_orb",
            [](const CPP_aperture_scan &self) { return self.ref_orb; },
            [](CPP_aperture_scan &self, CPP_coord val) { self.ref_orb = val; },
            "Ref orbit around which the scan is made.")
        .def_property("pz_start",
            [](const CPP_aperture_scan &self) { return self.pz_start; },
            [](CPP_aperture_scan &self, double val) { self.pz_start = val; },
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

