#include <complex>
#include <iostream>
#include <optional>
#include <pybind11/complex.h>
#include <pybind11/numpy.h>
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>
#include <string>
#include <vector>

#include "bmad_std_typedef.h"
#include "cpp_bmad_classes.h"

using namespace Bmad;

namespace py = pybind11;



/*
 *
 * TODO: using the test interface for now
extern "C" bool cpp_bmad_parser(const char *lat_file, void *lat
                                // ,
                                // bool make_mats6,
                                // bool digested_read_ok,
                                // const char* use_line,
                                // void *parse_lat
);

namespace py = pybind11;

shared_ptr<CPP_lat>
bmad_parser_wrapper(const std::string &lat_file,
                    py::object make_mats6_obj = py::none(),
                    py::object digested_read_ok_obj = py::none(),
                    py::object use_line_obj = py::none()) {
  // auto lat = shared_ptr<CPP_lat>(new CPP_lat {});
  auto lat = make_shared<CPP_lat>();
  void *parse_lat_ptr = nullptr;

  bool make_mats6 =
      make_mats6_obj.is_none() ? false : make_mats6_obj.cast<bool>();
  bool digested_read_ok =
      digested_read_ok_obj.is_none() ? true : digested_read_ok_obj.cast<bool>();
  // const char* use_line = use_line_obj.is_none() ? nullptr :
  // use_line_obj.cast<std::string>().c_str();

  bool error = cpp_bmad_parser(lat_file.c_str(), lat.get()
                               // , make_mats6,
                               // digested_read_ok,
                               // use_line,
                               // &parse_lat_ptr
  );

  std::cout << "bmad_parser returns\n";
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
*/

PYBIND11_MODULE(bmad, m) {
  m.doc() = "pybind11 bmad plugin: auto-generated from struct definitions";

      py::class_<CPP_wake_lr, std::shared_ptr<CPP_wake_lr>>(m, "wake_lr", "Fortran struct: wake_lr_struct")
        .def(py::init<>())
        // CPP_wake_lr.aaa: NOT arg.kind='8' arg=Argument(is_component=True, f_name='aaa', c_name='aaa', type='integer', kind='8', pointer_type='NOT', array=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_aaa', to_f2_type='', to_f2_name='', to_f2_trans='F%aaa = z_aaa', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%aaa == f2%aaa)\n', test_pat='rhs = ARGIDX + offset; F%aaa = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.aaa = z_aaa;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.aaa == y.aaa);\n', test_pat='  rhs = ARGIDX + offset; C.aaa = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("aaa",
            [](const CPP_wake_lr &self) { return self.aaa; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_wake_lr.bbb: NOT arg.kind='' arg=Argument(is_component=True, f_name='bbb', c_name='bbb', type='integer', kind='', pointer_type='NOT', array=[], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_bbb', to_f2_type='', to_f2_name='', to_f2_trans='F%bbb = z_bbb', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%bbb == f2%bbb)\n', test_pat='rhs = ARGIDX + offset; F%bbb = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.bbb = z_bbb;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.bbb == y.bbb);\n', test_pat='  rhs = ARGIDX + offset; C.bbb = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("bbb",
            [](const CPP_wake_lr &self) { return self.bbb; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_wake_lr.file: NOT arg.kind='200' arg=Argument(is_component=True, f_name='file', c_name='file', type='character', kind='200', pointer_type='NOT', array=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_file', to_f2_type='', to_f2_name='', to_f2_trans='F%file = z_file', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%file == f2%file)\n', test_pat='rhs = ARGIDX + offset; F%file = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.file = z_file;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.file == y.file);\n', test_pat='  rhs = ARGIDX + offset; C.file = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("file",
            [](const CPP_wake_lr &self) { return self.file; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_wake_lr.t_ref: NOT arg.kind='' arg=Argument(is_component=True, f_name='t_ref', c_name='t_ref', type='real', kind='', pointer_type='NOT', array=[], init_value='0', comment='time reference value for computing the wake amplitude.', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_t_ref', to_f2_type='', to_f2_name='', to_f2_trans='F%t_ref = z_t_ref', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%t_ref == f2%t_ref)\n', test_pat='rhs = ARGIDX + offset; F%t_ref = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.t_ref = z_t_ref;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.t_ref == y.t_ref);\n', test_pat='  rhs = ARGIDX + offset; C.t_ref = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("t_ref",
            [](const CPP_wake_lr &self) { return self.t_ref; },
            py::return_value_policy::copy,
            "time reference value for computing the wake amplitude.")
        // CPP_wake_lr.freq_spread: NOT arg.kind='' arg=Argument(is_component=True, f_name='freq_spread', c_name='freq_spread', type='real', kind='', pointer_type='NOT', array=[], init_value='0', comment='Random frequency spread of long range modes.', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_freq_spread', to_f2_type='', to_f2_name='', to_f2_trans='F%freq_spread = z_freq_spread', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%freq_spread == f2%freq_spread)\n', test_pat='rhs = ARGIDX + offset; F%freq_spread = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.freq_spread = z_freq_spread;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.freq_spread == y.freq_spread);\n', test_pat='  rhs = ARGIDX + offset; C.freq_spread = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("freq_spread",
            [](const CPP_wake_lr &self) { return self.freq_spread; },
            py::return_value_policy::copy,
            "Random frequency spread of long range modes.")
        ;

    py::class_<CPP_wake, std::shared_ptr<CPP_wake>>(m, "wake", "Fortran struct: wake_struct")
        .def(py::init<>())
        // CPP_wake.sr: NOT arg.kind='' arg=Argument(is_component=True, f_name='sr', c_name='sr', type='wake_lr_struct', kind='', pointer_type='NOT', array=[], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_sr', to_f2_type='', to_f2_name='', to_f2_trans='F%sr = z_sr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%sr == f2%sr)\n', test_pat='rhs = ARGIDX + offset; F%sr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.sr = z_sr;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.sr == y.sr);\n', test_pat='  rhs = ARGIDX + offset; C.sr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("sr",
            [](const CPP_wake &self) { return self.sr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        ;

    py::class_<CPP_all_encompassing, std::shared_ptr<CPP_all_encompassing>>(m, "all_encompassing", "Fortran struct: all_encompassing_struct")
        .def(py::init<>())
        // CPP_all_encompassing.real_rp_0d: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_0d', c_name='real_rp_0d', type='real', kind='', pointer_type='NOT', array=[], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_0d', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_0d = z_real_rp_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_0d == f2%real_rp_0d)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_0d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_0d = z_real_rp_0d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_0d == y.real_rp_0d);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_0d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("real_rp_0d",
            [](const CPP_all_encompassing &self) { return self.real_rp_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_1d: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_1d', c_name='real_rp_1d', type='real', kind='', pointer_type='NOT', array=['3'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_1d', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_1d = z_real_rp_1d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_1d == f2%real_rp_1d)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_1d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_1d = z_real_rp_1d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_1d == y.real_rp_1d);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_1d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_1d, type: 
        // struct array
        .def_property("real_rp_1d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_rp_1d;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_1d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.real_rp_1d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_2d: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_2d', c_name='real_rp_2d', type='real', kind='', pointer_type='NOT', array=['3', ' 4'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_2d', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_2d = z_real_rp_2d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_2d == f2%real_rp_2d)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_2d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_2d = z_real_rp_2d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_2d == y.real_rp_2d);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_2d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_2d, type: 
        // struct array
        .def_property("real_rp_2d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_rp_2d;
                // const auto& matrix = self.real_rp_2d;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_2d from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.real_rp_2d;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_3d: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_3d', c_name='real_rp_3d', type='real', kind='', pointer_type='NOT', array=['3', ' 4', ' 5'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_3d', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_3d = z_real_rp_3d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_3d == f2%real_rp_3d)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_3d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_3d = z_real_rp_3d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_3d == y.real_rp_3d);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_3d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_3d, type: 
        // struct array
        .def_property("real_rp_3d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_3d from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_0d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_0d_ptr', c_name='real_rp_0d_ptr', type='real', kind='', pointer_type='NOT', array=[], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_0d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_0d_ptr = z_real_rp_0d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_0d_ptr == f2%real_rp_0d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_0d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_0d_ptr = z_real_rp_0d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_0d_ptr == y.real_rp_0d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_0d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("real_rp_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.real_rp_0d_ptr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_1d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_1d_ptr', c_name='real_rp_1d_ptr', type='real', kind='', pointer_type='NOT', array=[':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_1d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_1d_ptr = z_real_rp_1d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_1d_ptr == f2%real_rp_1d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_1d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_1d_ptr = z_real_rp_1d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_1d_ptr == y.real_rp_1d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_1d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_1d_ptr, type: 
        // struct array
        .def_property("real_rp_1d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_rp_1d_ptr;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_1d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.real_rp_1d_ptr;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_2d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_2d_ptr', c_name='real_rp_2d_ptr', type='real', kind='', pointer_type='NOT', array=[':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_2d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_2d_ptr = z_real_rp_2d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_2d_ptr == f2%real_rp_2d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_2d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_2d_ptr = z_real_rp_2d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_2d_ptr == y.real_rp_2d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_2d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_2d_ptr, type: 
        // struct array
        .def_property("real_rp_2d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_rp_2d_ptr;
                // const auto& matrix = self.real_rp_2d_ptr;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_2d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.real_rp_2d_ptr;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_3d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_3d_ptr', c_name='real_rp_3d_ptr', type='real', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_3d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_3d_ptr = z_real_rp_3d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_3d_ptr == f2%real_rp_3d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_3d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_3d_ptr = z_real_rp_3d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_3d_ptr == y.real_rp_3d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_3d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_3d_ptr, type: 
        // struct array
        .def_property("real_rp_3d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_3d_ptr from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_1d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_1d_alloc', c_name='real_rp_1d_alloc', type='real', kind='', pointer_type='NOT', array=[':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_1d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_1d_alloc = z_real_rp_1d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_1d_alloc == f2%real_rp_1d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_1d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_1d_alloc = z_real_rp_1d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_1d_alloc == y.real_rp_1d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_1d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_1d_alloc, type: 
        // struct array
        .def_property("real_rp_1d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_rp_1d_alloc;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_1d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.real_rp_1d_alloc;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_2d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_2d_alloc', c_name='real_rp_2d_alloc', type='real', kind='', pointer_type='NOT', array=[':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_2d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_2d_alloc = z_real_rp_2d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_2d_alloc == f2%real_rp_2d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_2d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_2d_alloc = z_real_rp_2d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_2d_alloc == y.real_rp_2d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_2d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_2d_alloc, type: 
        // struct array
        .def_property("real_rp_2d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_rp_2d_alloc;
                // const auto& matrix = self.real_rp_2d_alloc;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_2d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.real_rp_2d_alloc;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_3d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_rp_3d_alloc', c_name='real_rp_3d_alloc', type='real', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_rp_3d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%real_rp_3d_alloc = z_real_rp_3d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_3d_alloc == f2%real_rp_3d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_3d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_rp_3d_alloc = z_real_rp_3d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_3d_alloc == y.real_rp_3d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_3d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_rp_3d_alloc, type: 
        // struct array
        .def_property("real_rp_3d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_rp_3d_alloc from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_0d: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_0d', c_name='real_dp_0d', type='real', kind='', pointer_type='NOT', array=[], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_0d', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_0d = z_real_dp_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_0d == f2%real_dp_0d)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_0d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_0d = z_real_dp_0d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_0d == y.real_dp_0d);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_0d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("real_dp_0d",
            [](const CPP_all_encompassing &self) { return self.real_dp_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_1d: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_1d', c_name='real_dp_1d', type='real', kind='', pointer_type='NOT', array=['3'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_1d', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_1d = z_real_dp_1d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_1d == f2%real_dp_1d)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_1d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_1d = z_real_dp_1d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_1d == y.real_dp_1d);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_1d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_1d, type: 
        // struct array
        .def_property("real_dp_1d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_dp_1d;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_1d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.real_dp_1d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_2d: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_2d', c_name='real_dp_2d', type='real', kind='', pointer_type='NOT', array=['3', ' 4'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_2d', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_2d = z_real_dp_2d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_2d == f2%real_dp_2d)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_2d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_2d = z_real_dp_2d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_2d == y.real_dp_2d);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_2d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_2d, type: 
        // struct array
        .def_property("real_dp_2d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_dp_2d;
                // const auto& matrix = self.real_dp_2d;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_2d from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.real_dp_2d;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_3d: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_3d', c_name='real_dp_3d', type='real', kind='', pointer_type='NOT', array=['3', ' 4', ' 5'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_3d', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_3d = z_real_dp_3d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_3d == f2%real_dp_3d)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_3d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_3d = z_real_dp_3d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_3d == y.real_dp_3d);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_3d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_3d, type: 
        // struct array
        .def_property("real_dp_3d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_3d from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_0d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_0d_ptr', c_name='real_dp_0d_ptr', type='real', kind='', pointer_type='NOT', array=[], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_0d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_0d_ptr = z_real_dp_0d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_0d_ptr == f2%real_dp_0d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_0d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_0d_ptr = z_real_dp_0d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_0d_ptr == y.real_dp_0d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_0d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("real_dp_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.real_dp_0d_ptr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_1d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_1d_ptr', c_name='real_dp_1d_ptr', type='real', kind='', pointer_type='NOT', array=[':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_1d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_1d_ptr = z_real_dp_1d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_1d_ptr == f2%real_dp_1d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_1d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_1d_ptr = z_real_dp_1d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_1d_ptr == y.real_dp_1d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_1d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_1d_ptr, type: 
        // struct array
        .def_property("real_dp_1d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_dp_1d_ptr;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_1d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.real_dp_1d_ptr;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_2d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_2d_ptr', c_name='real_dp_2d_ptr', type='real', kind='', pointer_type='NOT', array=[':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_2d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_2d_ptr = z_real_dp_2d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_2d_ptr == f2%real_dp_2d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_2d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_2d_ptr = z_real_dp_2d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_2d_ptr == y.real_dp_2d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_2d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_2d_ptr, type: 
        // struct array
        .def_property("real_dp_2d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_dp_2d_ptr;
                // const auto& matrix = self.real_dp_2d_ptr;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_2d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.real_dp_2d_ptr;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_3d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_3d_ptr', c_name='real_dp_3d_ptr', type='real', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_3d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_3d_ptr = z_real_dp_3d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_3d_ptr == f2%real_dp_3d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_3d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_3d_ptr = z_real_dp_3d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_3d_ptr == y.real_dp_3d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_3d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_3d_ptr, type: 
        // struct array
        .def_property("real_dp_3d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_3d_ptr from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_1d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_1d_alloc', c_name='real_dp_1d_alloc', type='real', kind='', pointer_type='NOT', array=[':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_1d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_1d_alloc = z_real_dp_1d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_1d_alloc == f2%real_dp_1d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_1d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_1d_alloc = z_real_dp_1d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_1d_alloc == y.real_dp_1d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_1d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_1d_alloc, type: 
        // struct array
        .def_property("real_dp_1d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_dp_1d_alloc;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_1d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.real_dp_1d_alloc;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_2d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_2d_alloc', c_name='real_dp_2d_alloc', type='real', kind='', pointer_type='NOT', array=[':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_2d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_2d_alloc = z_real_dp_2d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_2d_alloc == f2%real_dp_2d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_2d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_2d_alloc = z_real_dp_2d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_2d_alloc == y.real_dp_2d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_2d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_2d_alloc, type: 
        // struct array
        .def_property("real_dp_2d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.real_dp_2d_alloc;
                // const auto& matrix = self.real_dp_2d_alloc;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_2d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.real_dp_2d_alloc;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_3d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='real_dp_3d_alloc', c_name='real_dp_3d_alloc', type='real', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_real_dp_3d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%real_dp_3d_alloc = z_real_dp_3d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_3d_alloc == f2%real_dp_3d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_3d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.real_dp_3d_alloc = z_real_dp_3d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_3d_alloc == y.real_dp_3d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_3d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: real_dp_3d_alloc, type: 
        // struct array
        .def_property("real_dp_3d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set real_dp_3d_alloc from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_0d: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_0d', c_name='complex_dp_0d', type='complex', kind='', pointer_type='NOT', array=[], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_0d', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_0d = z_complex_dp_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_0d == f2%complex_dp_0d)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_0d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_0d = z_complex_dp_0d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_0d == y.complex_dp_0d);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_0d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("complex_dp_0d",
            [](const CPP_all_encompassing &self) { return self.complex_dp_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_1d: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_1d', c_name='complex_dp_1d', type='complex', kind='', pointer_type='NOT', array=['3'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_1d', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_1d = z_complex_dp_1d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_1d == f2%complex_dp_1d)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_1d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_1d = z_complex_dp_1d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_1d == y.complex_dp_1d);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_1d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_1d, type: 
        // struct array
        .def_property("complex_dp_1d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.complex_dp_1d;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_1d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.complex_dp_1d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_2d: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_2d', c_name='complex_dp_2d', type='complex', kind='', pointer_type='NOT', array=['3', ' 4'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_2d', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_2d = z_complex_dp_2d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_2d == f2%complex_dp_2d)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_2d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_2d = z_complex_dp_2d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_2d == y.complex_dp_2d);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_2d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_2d, type: 
        // struct array
        .def_property("complex_dp_2d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.complex_dp_2d;
                // const auto& matrix = self.complex_dp_2d;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_2d from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.complex_dp_2d;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_3d: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_3d', c_name='complex_dp_3d', type='complex', kind='', pointer_type='NOT', array=['3', ' 4', ' 5'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_3d', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_3d = z_complex_dp_3d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_3d == f2%complex_dp_3d)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_3d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_3d = z_complex_dp_3d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_3d == y.complex_dp_3d);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_3d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_3d, type: 
        // struct array
        .def_property("complex_dp_3d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_3d from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_0d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_0d_ptr', c_name='complex_dp_0d_ptr', type='complex', kind='', pointer_type='NOT', array=[], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_0d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_0d_ptr = z_complex_dp_0d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_0d_ptr == f2%complex_dp_0d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_0d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_0d_ptr = z_complex_dp_0d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_0d_ptr == y.complex_dp_0d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_0d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("complex_dp_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.complex_dp_0d_ptr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_1d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_1d_ptr', c_name='complex_dp_1d_ptr', type='complex', kind='', pointer_type='NOT', array=[':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_1d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_1d_ptr = z_complex_dp_1d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_1d_ptr == f2%complex_dp_1d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_1d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_1d_ptr = z_complex_dp_1d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_1d_ptr == y.complex_dp_1d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_1d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_1d_ptr, type: 
        // struct array
        .def_property("complex_dp_1d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.complex_dp_1d_ptr;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_1d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.complex_dp_1d_ptr;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_2d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_2d_ptr', c_name='complex_dp_2d_ptr', type='complex', kind='', pointer_type='NOT', array=[':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_2d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_2d_ptr = z_complex_dp_2d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_2d_ptr == f2%complex_dp_2d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_2d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_2d_ptr = z_complex_dp_2d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_2d_ptr == y.complex_dp_2d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_2d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_2d_ptr, type: 
        // struct array
        .def_property("complex_dp_2d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.complex_dp_2d_ptr;
                // const auto& matrix = self.complex_dp_2d_ptr;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_2d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.complex_dp_2d_ptr;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_3d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_3d_ptr', c_name='complex_dp_3d_ptr', type='complex', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_3d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_3d_ptr = z_complex_dp_3d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_3d_ptr == f2%complex_dp_3d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_3d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_3d_ptr = z_complex_dp_3d_ptr;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_3d_ptr == y.complex_dp_3d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_3d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_3d_ptr, type: 
        // struct array
        .def_property("complex_dp_3d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_3d_ptr from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_1d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_1d_alloc', c_name='complex_dp_1d_alloc', type='complex', kind='', pointer_type='NOT', array=[':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_1d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_1d_alloc = z_complex_dp_1d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_1d_alloc == f2%complex_dp_1d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_1d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_1d_alloc = z_complex_dp_1d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_1d_alloc == y.complex_dp_1d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_1d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_1d_alloc, type: 
        // struct array
        .def_property("complex_dp_1d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.complex_dp_1d_alloc;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_1d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.complex_dp_1d_alloc;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_2d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_2d_alloc', c_name='complex_dp_2d_alloc', type='complex', kind='', pointer_type='NOT', array=[':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_2d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_2d_alloc = z_complex_dp_2d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_2d_alloc == f2%complex_dp_2d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_2d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_2d_alloc = z_complex_dp_2d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_2d_alloc == y.complex_dp_2d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_2d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_2d_alloc, type: 
        // struct array
        .def_property("complex_dp_2d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.complex_dp_2d_alloc;
                // const auto& matrix = self.complex_dp_2d_alloc;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_2d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.complex_dp_2d_alloc;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_3d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='complex_dp_3d_alloc', c_name='complex_dp_3d_alloc', type='complex', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='0.0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_complex_dp_3d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%complex_dp_3d_alloc = z_complex_dp_3d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_3d_alloc == f2%complex_dp_3d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_3d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.complex_dp_3d_alloc = z_complex_dp_3d_alloc;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_3d_alloc == y.complex_dp_3d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_3d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: complex_dp_3d_alloc, type: 
        // struct array
        .def_property("complex_dp_3d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set complex_dp_3d_alloc from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_0d: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_0d', c_name='int_0d', type='integer', kind='', pointer_type='NOT', array=[], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_0d', to_f2_type='', to_f2_name='', to_f2_trans='F%int_0d = z_int_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_0d == f2%int_0d)\n', test_pat='rhs = ARGIDX + offset; F%int_0d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_0d = z_int_0d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_0d == y.int_0d);\n', test_pat='  rhs = ARGIDX + offset; C.int_0d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("int_0d",
            [](const CPP_all_encompassing &self) { return self.int_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_1d: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_1d', c_name='int_1d', type='integer', kind='', pointer_type='NOT', array=['3'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_1d', to_f2_type='', to_f2_name='', to_f2_trans='F%int_1d = z_int_1d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_1d == f2%int_1d)\n', test_pat='rhs = ARGIDX + offset; F%int_1d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_1d = z_int_1d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_1d == y.int_1d);\n', test_pat='  rhs = ARGIDX + offset; C.int_1d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_1d, type: 
        // struct array
        .def_property("int_1d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int_1d;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_1d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.int_1d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_2d: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_2d', c_name='int_2d', type='integer', kind='', pointer_type='NOT', array=['3', ' 4'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_2d', to_f2_type='', to_f2_name='', to_f2_trans='F%int_2d = z_int_2d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_2d == f2%int_2d)\n', test_pat='rhs = ARGIDX + offset; F%int_2d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_2d = z_int_2d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_2d == y.int_2d);\n', test_pat='  rhs = ARGIDX + offset; C.int_2d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_2d, type: 
        // struct array
        .def_property("int_2d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int_2d;
                // const auto& matrix = self.int_2d;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_2d from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.int_2d;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_3d: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_3d', c_name='int_3d', type='integer', kind='', pointer_type='NOT', array=['3', ' 4', ' 5'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_3d', to_f2_type='', to_f2_name='', to_f2_trans='F%int_3d = z_int_3d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_3d == f2%int_3d)\n', test_pat='rhs = ARGIDX + offset; F%int_3d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_3d = z_int_3d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_3d == y.int_3d);\n', test_pat='  rhs = ARGIDX + offset; C.int_3d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_3d, type: 
        // struct array
        .def_property("int_3d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_3d from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_0d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_0d_ptr', c_name='int_0d_ptr', type='integer', kind='', pointer_type='NOT', array=[], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_0d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%int_0d_ptr = z_int_0d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_0d_ptr == f2%int_0d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%int_0d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_0d_ptr = z_int_0d_ptr;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_0d_ptr == y.int_0d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.int_0d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("int_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.int_0d_ptr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_1d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_1d_ptr', c_name='int_1d_ptr', type='integer', kind='', pointer_type='NOT', array=[':'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_1d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%int_1d_ptr = z_int_1d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_1d_ptr == f2%int_1d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%int_1d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_1d_ptr = z_int_1d_ptr;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_1d_ptr == y.int_1d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.int_1d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_1d_ptr, type: 
        // struct array
        .def_property("int_1d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int_1d_ptr;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_1d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.int_1d_ptr;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_2d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_2d_ptr', c_name='int_2d_ptr', type='integer', kind='', pointer_type='NOT', array=[':', ':'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_2d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%int_2d_ptr = z_int_2d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_2d_ptr == f2%int_2d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%int_2d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_2d_ptr = z_int_2d_ptr;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_2d_ptr == y.int_2d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.int_2d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_2d_ptr, type: 
        // struct array
        .def_property("int_2d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int_2d_ptr;
                // const auto& matrix = self.int_2d_ptr;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_2d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.int_2d_ptr;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_3d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_3d_ptr', c_name='int_3d_ptr', type='integer', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_3d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%int_3d_ptr = z_int_3d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_3d_ptr == f2%int_3d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%int_3d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_3d_ptr = z_int_3d_ptr;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_3d_ptr == y.int_3d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.int_3d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_3d_ptr, type: 
        // struct array
        .def_property("int_3d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_3d_ptr from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_1d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_1d_alloc', c_name='int_1d_alloc', type='integer', kind='', pointer_type='NOT', array=[':'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_1d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%int_1d_alloc = z_int_1d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_1d_alloc == f2%int_1d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%int_1d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_1d_alloc = z_int_1d_alloc;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_1d_alloc == y.int_1d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.int_1d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_1d_alloc, type: 
        // struct array
        .def_property("int_1d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int_1d_alloc;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_1d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.int_1d_alloc;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_2d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_2d_alloc', c_name='int_2d_alloc', type='integer', kind='', pointer_type='NOT', array=[':', ':'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_2d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%int_2d_alloc = z_int_2d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_2d_alloc == f2%int_2d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%int_2d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_2d_alloc = z_int_2d_alloc;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_2d_alloc == y.int_2d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.int_2d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_2d_alloc, type: 
        // struct array
        .def_property("int_2d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int_2d_alloc;
                // const auto& matrix = self.int_2d_alloc;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_2d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.int_2d_alloc;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_3d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_3d_alloc', c_name='int_3d_alloc', type='integer', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='0', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int_3d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%int_3d_alloc = z_int_3d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_3d_alloc == f2%int_3d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%int_3d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int_3d_alloc = z_int_3d_alloc;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_3d_alloc == y.int_3d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.int_3d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int_3d_alloc, type: 
        // struct array
        .def_property("int_3d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int_3d_alloc from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_0d: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_0d', c_name='int8_0d', type='integer', kind='8', pointer_type='NOT', array=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_0d', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_0d = z_int8_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_0d == f2%int8_0d)\n', test_pat='rhs = ARGIDX + offset; F%int8_0d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_0d = z_int8_0d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_0d == y.int8_0d);\n', test_pat='  rhs = ARGIDX + offset; C.int8_0d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("int8_0d",
            [](const CPP_all_encompassing &self) { return self.int8_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_1d: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_1d', c_name='int8_1d', type='integer', kind='8', pointer_type='NOT', array=['3'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_1d', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_1d = z_int8_1d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_1d == f2%int8_1d)\n', test_pat='rhs = ARGIDX + offset; F%int8_1d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_1d = z_int8_1d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_1d == y.int8_1d);\n', test_pat='  rhs = ARGIDX + offset; C.int8_1d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_1d, type: 
        // struct array
        .def_property("int8_1d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int8_1d;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_1d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.int8_1d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_8>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_8 objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_2d: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_2d', c_name='int8_2d', type='integer', kind='8', pointer_type='NOT', array=['3', ' 4'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_2d', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_2d = z_int8_2d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_2d == f2%int8_2d)\n', test_pat='rhs = ARGIDX + offset; F%int8_2d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_2d = z_int8_2d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_2d == y.int8_2d);\n', test_pat='  rhs = ARGIDX + offset; C.int8_2d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_2d, type: 
        // struct array
        .def_property("int8_2d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int8_2d;
                // const auto& matrix = self.int8_2d;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_2d from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.int8_2d;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_8 objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_3d: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_3d', c_name='int8_3d', type='integer', kind='8', pointer_type='NOT', array=['3', ' 4', ' 5'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_3d', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_3d = z_int8_3d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_3d == f2%int8_3d)\n', test_pat='rhs = ARGIDX + offset; F%int8_3d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_3d = z_int8_3d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_3d == y.int8_3d);\n', test_pat='  rhs = ARGIDX + offset; C.int8_3d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_3d, type: 
        // struct array
        .def_property("int8_3d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_3d from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_0d_ptr: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_0d_ptr', c_name='int8_0d_ptr', type='integer', kind='8', pointer_type='NOT', array=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_0d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_0d_ptr = z_int8_0d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_0d_ptr == f2%int8_0d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%int8_0d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_0d_ptr = z_int8_0d_ptr;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_0d_ptr == y.int8_0d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.int8_0d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("int8_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.int8_0d_ptr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_1d_ptr: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_1d_ptr', c_name='int8_1d_ptr', type='integer', kind='8', pointer_type='NOT', array=[':'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_1d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_1d_ptr = z_int8_1d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_1d_ptr == f2%int8_1d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%int8_1d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_1d_ptr = z_int8_1d_ptr;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_1d_ptr == y.int8_1d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.int8_1d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_1d_ptr, type: 
        // struct array
        .def_property("int8_1d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int8_1d_ptr;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_1d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.int8_1d_ptr;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_8>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_8 objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_2d_ptr: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_2d_ptr', c_name='int8_2d_ptr', type='integer', kind='8', pointer_type='NOT', array=[':', ':'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_2d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_2d_ptr = z_int8_2d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_2d_ptr == f2%int8_2d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%int8_2d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_2d_ptr = z_int8_2d_ptr;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_2d_ptr == y.int8_2d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.int8_2d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_2d_ptr, type: 
        // struct array
        .def_property("int8_2d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int8_2d_ptr;
                // const auto& matrix = self.int8_2d_ptr;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_2d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.int8_2d_ptr;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_8 objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_3d_ptr: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_3d_ptr', c_name='int8_3d_ptr', type='integer', kind='8', pointer_type='NOT', array=[':', ':', ':'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_3d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_3d_ptr = z_int8_3d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_3d_ptr == f2%int8_3d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%int8_3d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_3d_ptr = z_int8_3d_ptr;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_3d_ptr == y.int8_3d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.int8_3d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_3d_ptr, type: 
        // struct array
        .def_property("int8_3d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_3d_ptr from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_1d_alloc: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_1d_alloc', c_name='int8_1d_alloc', type='integer', kind='8', pointer_type='NOT', array=[':'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_1d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_1d_alloc = z_int8_1d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_1d_alloc == f2%int8_1d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%int8_1d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_1d_alloc = z_int8_1d_alloc;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_1d_alloc == y.int8_1d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.int8_1d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_1d_alloc, type: 
        // struct array
        .def_property("int8_1d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int8_1d_alloc;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_1d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.int8_1d_alloc;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_8>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_8 objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_2d_alloc: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_2d_alloc', c_name='int8_2d_alloc', type='integer', kind='8', pointer_type='NOT', array=[':', ':'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_2d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_2d_alloc = z_int8_2d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_2d_alloc == f2%int8_2d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%int8_2d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_2d_alloc = z_int8_2d_alloc;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_2d_alloc == y.int8_2d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.int8_2d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_2d_alloc, type: 
        // struct array
        .def_property("int8_2d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.int8_2d_alloc;
                // const auto& matrix = self.int8_2d_alloc;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_2d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.int8_2d_alloc;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_8 objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_3d_alloc: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_3d_alloc', c_name='int8_3d_alloc', type='integer', kind='8', pointer_type='NOT', array=[':', ':', ':'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_int8_3d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%int8_3d_alloc = z_int8_3d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_3d_alloc == f2%int8_3d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%int8_3d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.int8_3d_alloc = z_int8_3d_alloc;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_3d_alloc == y.int8_3d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.int8_3d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: int8_3d_alloc, type: 
        // struct array
        .def_property("int8_3d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set int8_3d_alloc from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.logical_0d: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_0d', c_name='logical_0d', type='logical', kind='', pointer_type='NOT', array=[], init_value='False', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_logical_0d', to_f2_type='', to_f2_name='', to_f2_trans='F%logical_0d = z_logical_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%logical_0d == f2%logical_0d)\n', test_pat='rhs = ARGIDX + offset; F%logical_0d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.logical_0d = z_logical_0d;', class_initializer='{ False }', construct_value='False', destructor='', equality_test='  is_eq = is_eq && (x.logical_0d == y.logical_0d);\n', test_pat='  rhs = ARGIDX + offset; C.logical_0d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("logical_0d",
            [](const CPP_all_encompassing &self) { return self.logical_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.logical_1d: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_1d', c_name='logical_1d', type='logical', kind='', pointer_type='NOT', array=['3'], init_value='False', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_logical_1d', to_f2_type='', to_f2_name='', to_f2_trans='F%logical_1d = z_logical_1d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%logical_1d == f2%logical_1d)\n', test_pat='rhs = ARGIDX + offset; F%logical_1d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.logical_1d = z_logical_1d;', class_initializer='{ False }', construct_value='False', destructor='', equality_test='  is_eq = is_eq && (x.logical_1d == y.logical_1d);\n', test_pat='  rhs = ARGIDX + offset; C.logical_1d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: logical_1d, type: 
        // struct array
        .def_property("logical_1d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.logical_1d;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set logical_1d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.logical_1d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.logical_2d: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_2d', c_name='logical_2d', type='logical', kind='', pointer_type='NOT', array=['3', ' 4'], init_value='False', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_logical_2d', to_f2_type='', to_f2_name='', to_f2_trans='F%logical_2d = z_logical_2d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%logical_2d == f2%logical_2d)\n', test_pat='rhs = ARGIDX + offset; F%logical_2d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.logical_2d = z_logical_2d;', class_initializer='{ False }', construct_value='False', destructor='', equality_test='  is_eq = is_eq && (x.logical_2d == y.logical_2d);\n', test_pat='  rhs = ARGIDX + offset; C.logical_2d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: logical_2d, type: 
        // struct array
        .def_property("logical_2d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.logical_2d;
                // const auto& matrix = self.logical_2d;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set logical_2d from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.logical_2d;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.logical_3d: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_3d', c_name='logical_3d', type='logical', kind='', pointer_type='NOT', array=['3', ' 4', ' 5'], init_value='False', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_logical_3d', to_f2_type='', to_f2_name='', to_f2_trans='F%logical_3d = z_logical_3d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%logical_3d == f2%logical_3d)\n', test_pat='rhs = ARGIDX + offset; F%logical_3d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.logical_3d = z_logical_3d;', class_initializer='{ False }', construct_value='False', destructor='', equality_test='  is_eq = is_eq && (x.logical_3d == y.logical_3d);\n', test_pat='  rhs = ARGIDX + offset; C.logical_3d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: logical_3d, type: 
        // struct array
        .def_property("logical_3d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set logical_3d from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.logical_0d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_0d_ptr', c_name='logical_0d_ptr', type='logical', kind='', pointer_type='NOT', array=[], init_value='False', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_logical_0d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%logical_0d_ptr = z_logical_0d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%logical_0d_ptr == f2%logical_0d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%logical_0d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.logical_0d_ptr = z_logical_0d_ptr;', class_initializer='{ False }', construct_value='False', destructor='', equality_test='  is_eq = is_eq && (x.logical_0d_ptr == y.logical_0d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.logical_0d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("logical_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.logical_0d_ptr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_0d: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_0d', c_name='type_0d', type='wake_lr_struct', kind='', pointer_type='NOT', array=[], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_0d', to_f2_type='', to_f2_name='', to_f2_trans='F%type_0d = z_type_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_0d == f2%type_0d)\n', test_pat='rhs = ARGIDX + offset; F%type_0d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_0d = z_type_0d;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_0d == y.type_0d);\n', test_pat='  rhs = ARGIDX + offset; C.type_0d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("type_0d",
            [](const CPP_all_encompassing &self) { return self.type_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_1d: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_1d', c_name='type_1d', type='wake_lr_struct', kind='', pointer_type='NOT', array=['3'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_1d', to_f2_type='', to_f2_name='', to_f2_trans='F%type_1d = z_type_1d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_1d == f2%type_1d)\n', test_pat='rhs = ARGIDX + offset; F%type_1d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_1d = z_type_1d;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_1d == y.type_1d);\n', test_pat='  rhs = ARGIDX + offset; C.type_1d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_1d, type: 
        // struct array
        .def_property("type_1d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.type_1d;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_1d from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.type_1d;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_2d: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_2d', c_name='type_2d', type='wake_lr_struct', kind='', pointer_type='NOT', array=['3', ' 4'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_2d', to_f2_type='', to_f2_name='', to_f2_trans='F%type_2d = z_type_2d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_2d == f2%type_2d)\n', test_pat='rhs = ARGIDX + offset; F%type_2d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_2d = z_type_2d;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_2d == y.type_2d);\n', test_pat='  rhs = ARGIDX + offset; C.type_2d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_2d, type: 
        // struct array
        .def_property("type_2d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.type_2d;
                // const auto& matrix = self.type_2d;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_2d from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.type_2d;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_3d: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_3d', c_name='type_3d', type='wake_lr_struct', kind='', pointer_type='NOT', array=['3', ' 4', ' 5'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_3d', to_f2_type='', to_f2_name='', to_f2_trans='F%type_3d = z_type_3d', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_3d == f2%type_3d)\n', test_pat='rhs = ARGIDX + offset; F%type_3d = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_3d = z_type_3d;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_3d == y.type_3d);\n', test_pat='  rhs = ARGIDX + offset; C.type_3d = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_3d, type: 
        // struct array
        .def_property("type_3d",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_3d from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_0d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_0d_ptr', c_name='type_0d_ptr', type='wake_lr_struct', kind='', pointer_type='NOT', array=[], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_0d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%type_0d_ptr = z_type_0d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_0d_ptr == f2%type_0d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%type_0d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_0d_ptr = z_type_0d_ptr;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_0d_ptr == y.type_0d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.type_0d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // [default case]
        .def_property_readonly("type_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.type_0d_ptr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_1d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_1d_ptr', c_name='type_1d_ptr', type='wake_lr_struct', kind='', pointer_type='NOT', array=[':'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_1d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%type_1d_ptr = z_type_1d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_1d_ptr == f2%type_1d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%type_1d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_1d_ptr = z_type_1d_ptr;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_1d_ptr == y.type_1d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.type_1d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_1d_ptr, type: 
        // struct array
        .def_property("type_1d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.type_1d_ptr;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_1d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.type_1d_ptr;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_2d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_2d_ptr', c_name='type_2d_ptr', type='wake_lr_struct', kind='', pointer_type='NOT', array=[':', ':'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_2d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%type_2d_ptr = z_type_2d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_2d_ptr == f2%type_2d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%type_2d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_2d_ptr = z_type_2d_ptr;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_2d_ptr == y.type_2d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.type_2d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_2d_ptr, type: 
        // struct array
        .def_property("type_2d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.type_2d_ptr;
                // const auto& matrix = self.type_2d_ptr;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_2d_ptr from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.type_2d_ptr;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_3d_ptr: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_3d_ptr', c_name='type_3d_ptr', type='wake_lr_struct', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_3d_ptr', to_f2_type='', to_f2_name='', to_f2_trans='F%type_3d_ptr = z_type_3d_ptr', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_3d_ptr == f2%type_3d_ptr)\n', test_pat='rhs = ARGIDX + offset; F%type_3d_ptr = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_3d_ptr = z_type_3d_ptr;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_3d_ptr == y.type_3d_ptr);\n', test_pat='  rhs = ARGIDX + offset; C.type_3d_ptr = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_3d_ptr, type: 
        // struct array
        .def_property("type_3d_ptr",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_3d_ptr from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_1d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_1d_alloc', c_name='type_1d_alloc', type='wake_lr_struct', kind='', pointer_type='NOT', array=[':'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_1d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%type_1d_alloc = z_type_1d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_1d_alloc == f2%type_1d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%type_1d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_1d_alloc = z_type_1d_alloc;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_1d_alloc == y.type_1d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.type_1d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_1d_alloc, type: 
        // struct array
        .def_property("type_1d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.type_1d_alloc;
                
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_1d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim1)");
                // try {
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.type_1d_alloc;
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {
                //         arr[i] = list[i].cast<shared_ptr<CPP_>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_2d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_2d_alloc', c_name='type_2d_alloc', type='wake_lr_struct', kind='', pointer_type='NOT', array=[':', ':'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_2d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%type_2d_alloc = z_type_2d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_2d_alloc == f2%type_2d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%type_2d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_2d_alloc = z_type_2d_alloc;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_2d_alloc == y.type_2d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.type_2d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_2d_alloc, type: 
        // struct array
        .def_property("type_2d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                
                return self.type_2d_alloc;
                // const auto& matrix = self.type_2d_alloc;
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
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_2d_alloc from list of structs
                
                throw std::runtime_error("Not implemented (dim2)");
                // try {
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.type_2d_alloc;
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
                //     throw std::runtime_error("Expected a list of lists of CPP_ objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_3d_alloc: NOT arg.kind='' arg=Argument(is_component=True, f_name='type_3d_alloc', c_name='type_3d_alloc', type='wake_lr_struct', kind='', pointer_type='NOT', array=[':', ':', ':'], init_value='None', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='', to_c2_type='', to_c2_name='', to_c2_f2_sub_arg='z_type_3d_alloc', to_f2_type='', to_f2_name='', to_f2_trans='F%type_3d_alloc = z_type_3d_alloc', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_3d_alloc == f2%type_3d_alloc)\n', test_pat='rhs = ARGIDX + offset; F%type_3d_alloc = TEST_VALUE\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='', to_f2_call='', to_c2_arg='', to_c2_set='  C.type_3d_alloc = z_type_3d_alloc;', class_initializer='{ None }', construct_value='None', destructor='', equality_test='  is_eq = is_eq && (x.type_3d_alloc == y.type_3d_alloc);\n', test_pat='  rhs = ARGIDX + offset; C.type_3d_alloc = TEST_VALUE;\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_3d_alloc, type: 
        // struct array
        .def_property("type_3d_alloc",
            [](const CPP_all_encompassing &self) {
                // Get list of struct objects
                return py::list(); // Unsupported dimensions for struct arrays
            },
            [](CPP_all_encompassing &self, py::object obj) {
                // Set type_3d_alloc from list of structs
                // Unsupported dimensions for struct arrays
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        ;


  /*
   * TODO: using the test interface for now
  m.def("bmad_parser", &bmad_parser_wrapper, py::return_value_policy::automatic,
        py::arg("lat_file"), py::arg("make_mats6") = py::none(),
        py::arg("digested_read_ok") = py::none(),
        py::arg("use_line") = py::none(),
        "Parse a Bmad lattice file.\n\n"
        "Parameters:\n"
        "    lat_file (str): Path to the lattice file\n"
        "    make_mats6 (bool, optional): Whether to make 6x6 matrices\n"
        "    digested_read_ok (bool, optional): Whether to allow reading from "
        "digested file\n"
        "    use_line (str, optional): Name of line to use\n\n"
        "Returns:\n"
        "    dict: Dictionary containing 'error', 'lattice', and optionally "
        "'parse_lattice'");
  */
}

