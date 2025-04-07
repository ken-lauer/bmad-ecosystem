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

unique_ptr<CPP_lat> bmad_parser_wrapper(
    const std::string& lat_file,
    py::object make_mats6_obj = py::none(),
    py::object digested_read_ok_obj = py::none(),
    py::object use_line_obj = py::none()
) {
    auto lat = unique_ptr<CPP_lat>(new CPP_lat {});
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

    // insert classes here //

    m.def("bmad_parser", &bmad_parser_wrapper, py::return_value_policy::move,
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
