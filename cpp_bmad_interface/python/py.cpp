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
        // CPP_wake_lr.aaa: NOT arg.kind='8' arg=Argument(is_component=True, f_name='aaa', c_name='aaa', type='integer8', kind='8', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%aaa', to_c2_type='integer(c_long)', to_c2_name='z_aaa', to_c2_f2_sub_arg='z_aaa', to_f2_type='integer(c_long)', to_f2_name='z_aaa', to_f2_trans='F%aaa = z_aaa', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%aaa == f2%aaa)\n', test_pat='rhs = ARGIDX + offset; F%aaa = rhs\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='Int8', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Int8&', to_f2_call='C.aaa', to_c2_arg='c_Int8& z_aaa', to_c2_set='  C.aaa = z_aaa;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.aaa == y.aaa);\n', test_pat='  rhs = ARGIDX + offset; C.aaa = rhs;\n', test_value='rhs'), split_line=[' aaa'], intent='', optional=False)
        // [default case]
        .def_property_readonly("aaa",
            [](const CPP_wake_lr &self) { return self.aaa; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_wake_lr.bbb: NOT arg.kind='' arg=Argument(is_component=True, f_name='bbb', c_name='bbb', type='integer', kind='', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%bbb', to_c2_type='integer(c_int)', to_c2_name='z_bbb', to_c2_f2_sub_arg='z_bbb', to_f2_type='integer(c_int)', to_f2_name='z_bbb', to_f2_trans='F%bbb = z_bbb', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%bbb == f2%bbb)\n', test_pat='rhs = ARGIDX + offset; F%bbb = rhs\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='Int', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Int&', to_f2_call='C.bbb', to_c2_arg='c_Int& z_bbb', to_c2_set='  C.bbb = z_bbb;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.bbb == y.bbb);\n', test_pat='  rhs = ARGIDX + offset; C.bbb = rhs;\n', test_value='rhs'), split_line=[' bbb'], intent='', optional=False)
        // [default case]
        .def_property_readonly("bbb",
            [](const CPP_wake_lr &self) { return self.bbb; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_wake_lr.file: NOT arg.kind='200' arg=Argument(is_component=True, f_name='file', c_name='file', type='character', kind='200', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value="''", comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='trim(F%file) // c_null_char', to_c2_type='character(c_char)', to_c2_name='z_file(*)', to_c2_f2_sub_arg='z_file', to_f2_type='character(c_char)', to_f2_name='z_file(*)', to_f2_trans='call to_f_str(z_file, F%file)', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%file == f2%file)\n', test_pat='do jd1 = 1, len(F%file)\n  F%file(jd1:jd1) = char(ichar("a") + modulo(100+ARGIDX+offset+jd1, 26))\nenddo\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='string', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Char', to_f2_call='C.file.c_str()', to_c2_arg='c_Char z_file', to_c2_set='  C.file = z_file;', class_initializer='{ "" }', construct_value='""', destructor='', equality_test='  is_eq = is_eq && (x.file == y.file);\n', test_pat="  C.file.resize(200);\n  for (size_t i = 0; i < C.file.size(); i++)\n    {int rhs = 101 + i + ARGIDX + offset; C.file[i] = 'a' + rhs % 26;}", test_value=''), split_line=[" file = ''"], intent='', optional=False)
        // [default case]
        .def_property_readonly("file",
            [](const CPP_wake_lr &self) { return self.file; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_wake_lr.t_ref: NOT arg.kind='rp' arg=Argument(is_component=True, f_name='t_ref', c_name='t_ref', type='real', kind='rp', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='0', comment='time reference value for computing the wake amplitude.', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%t_ref', to_c2_type='real(c_double)', to_c2_name='z_t_ref', to_c2_f2_sub_arg='z_t_ref', to_f2_type='real(c_double)', to_f2_name='z_t_ref', to_f2_trans='F%t_ref = z_t_ref', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%t_ref == f2%t_ref)\n', test_pat='rhs = ARGIDX + offset; F%t_ref = rhs\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='Real', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Real&', to_f2_call='C.t_ref', to_c2_arg='c_Real& z_t_ref', to_c2_set='  C.t_ref = z_t_ref;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.t_ref == y.t_ref);\n', test_pat='  rhs = ARGIDX + offset; C.t_ref = rhs;\n', test_value='rhs'), split_line=[' t_ref = 0'], intent='', optional=False)
        // [default case]
        .def_property_readonly("t_ref",
            [](const CPP_wake_lr &self) { return self.t_ref; },
            py::return_value_policy::copy,
            "time reference value for computing the wake amplitude.")
        // CPP_wake_lr.freq_spread: NOT arg.kind='rp' arg=Argument(is_component=True, f_name='freq_spread', c_name='freq_spread', type='real', kind='rp', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='0', comment='Random frequency spread of long range modes.', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%freq_spread', to_c2_type='real(c_double)', to_c2_name='z_freq_spread', to_c2_f2_sub_arg='z_freq_spread', to_f2_type='real(c_double)', to_f2_name='z_freq_spread', to_f2_trans='F%freq_spread = z_freq_spread', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%freq_spread == f2%freq_spread)\n', test_pat='rhs = ARGIDX + offset; F%freq_spread = rhs\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='Real', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Real&', to_f2_call='C.freq_spread', to_c2_arg='c_Real& z_freq_spread', to_c2_set='  C.freq_spread = z_freq_spread;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.freq_spread == y.freq_spread);\n', test_pat='  rhs = ARGIDX + offset; C.freq_spread = rhs;\n', test_value='rhs'), split_line=[' freq_spread = 0'], intent='', optional=False)
        // [default case]
        .def_property_readonly("freq_spread",
            [](const CPP_wake_lr &self) { return self.freq_spread; },
            py::return_value_policy::copy,
            "Random frequency spread of long range modes.")
        ;

    py::class_<CPP_wake, std::shared_ptr<CPP_wake>>(m, "wake", "Fortran struct: wake_struct")
        .def(py::init<>())
        // CPP_wake.sr: NOT arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='sr', c_name='sr', type='type', kind='wake_lr_struct', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value="wake_lr_struct(0, 0, '', 0, 0)", comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='c_loc(F%sr)', to_c2_type='type(c_ptr), value', to_c2_name='z_sr', to_c2_f2_sub_arg='z_sr', to_f2_type='type(c_ptr), value', to_f2_name='z_sr', to_f2_trans='call wake_lr_to_f(z_sr, c_loc(F%sr))', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%sr == f2%sr)\n', test_pat='call set_wake_lr_test_pattern (F%sr, ix_patt)\n', size_var=[], test_value='TEST_VALUE'), c_side=c_side_trans_class(c_class='CPP_wake_lr', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='const CPP_wake_lr&', to_f2_call='C.sr', to_c2_arg='const Opaque_wake_lr_class* z_sr', to_c2_set='  wake_lr_to_c(z_sr, C.sr);', class_initializer='', construct_value="wake_lr_struct(0, 0, '', 0, 0)", destructor='', equality_test='  is_eq = is_eq && (x.sr == y.sr);\n', test_pat='  set_CPP_wake_lr_test_pattern(C.sr, ix_patt);\n', test_value=''), split_line=[" sr = wake_lr_struct(0, 0, '', 0, 0)"], intent='', optional=False)
        // [default case]
        .def_property_readonly("sr",
            [](const CPP_wake &self) { return self.sr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        ;

    py::class_<CPP_all_encompassing, std::shared_ptr<CPP_all_encompassing>>(m, "all_encompassing", "Fortran struct: all_encompassing_struct")
        .def(py::init<>())
        // CPP_all_encompassing.real_rp_0d: NOT arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_0d', c_name='real_rp_0d', type='real', kind='rp', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%real_rp_0d', to_c2_type='real(c_double)', to_c2_name='z_real_rp_0d', to_c2_f2_sub_arg='z_real_rp_0d', to_f2_type='real(c_double)', to_f2_name='z_real_rp_0d', to_f2_trans='F%real_rp_0d = z_real_rp_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%real_rp_0d == f2%real_rp_0d)\n', test_pat='rhs = ARGIDX + offset; F%real_rp_0d = rhs\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='Real', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Real&', to_f2_call='C.real_rp_0d', to_c2_arg='c_Real& z_real_rp_0d', to_c2_set='  C.real_rp_0d = z_real_rp_0d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_rp_0d == y.real_rp_0d);\n', test_pat='  rhs = ARGIDX + offset; C.real_rp_0d = rhs;\n', test_value='rhs'), split_line=['real_rp_0d'], intent='', optional=False)
        // [default case]
        .def_property_readonly("real_rp_0d",
            [](const CPP_all_encompassing &self) { return self.real_rp_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_1d: NOT arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_1d', c_name='real_rp_1d', type='real', kind='rp', pointer_type='NOT', array=['3'], lbound=['1'], ubound=['3'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='fvec2vec(F%real_rp_1d, 3)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_1d(*)', to_c2_f2_sub_arg='z_real_rp_1d', to_f2_type='real(c_double)', to_f2_name='z_real_rp_1d(*)', to_f2_trans='F%real_rp_1d = z_real_rp_1d(1:3)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_1d == f2%real_rp_1d)\n', test_pat='do jd1 = 1, size(F%real_rp_1d,1); lb1 = lbound(F%real_rp_1d,1) - 1\n  rhs = 100 + jd1 + ARGIDX + offset\n  F%real_rp_1d(jd1+lb1) = rhs\nenddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray1D<Real, 3>', c_instantiation_suffix='{VALUE}', to_f_setup='', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='&C.real_rp_1d[0]', to_c2_arg='c_RealArr z_real_rp_1d', to_c2_set='  C.real_rp_1d << z_real_rp_1d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_1d, y.real_rp_1d);\n', test_pat='  for (size_t i = 0; i < C.real_rp_1d.size(); i++)\n    {int rhs = 101 + i + ARGIDX + offset; C.real_rp_1d[i] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_1d, type: FixedArray1D<Real
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_rp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_rp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_2d: NOT arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_2d', c_name='real_rp_2d', type='real', kind='rp', pointer_type='NOT', array=['3', '4'], lbound=['1', '1'], ubound=['3', '4'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='mat2vec(F%real_rp_2d, 3*4)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_2d(*)', to_c2_f2_sub_arg='z_real_rp_2d', to_f2_type='real(c_double)', to_f2_name='z_real_rp_2d(*)', to_f2_trans='call vec2mat(z_real_rp_2d, F%real_rp_2d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_2d == f2%real_rp_2d)\n', test_pat='do jd1 = 1, size(F%real_rp_2d,1); lb1 = lbound(F%real_rp_2d,1) - 1\ndo jd2 = 1, size(F%real_rp_2d,2); lb2 = lbound(F%real_rp_2d,2) - 1\n  rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n  F%real_rp_2d(jd1+lb1,jd2+lb2) = rhs\nenddo; enddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray2D<Real, 3, 4>', c_instantiation_suffix='', to_f_setup='  Real z_real_rp_2d[3*4]; matrix_to_vec(C.real_rp_2d, z_real_rp_2d);\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='z_real_rp_2d', to_c2_arg='c_RealArr z_real_rp_2d', to_c2_set='  C.real_rp_2d << z_real_rp_2d;', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_2d, y.real_rp_2d);\n', test_pat='  for (size_t i = 0; i < C.real_rp_2d.size(); i++)  for (size_t j = 0; j < C.real_rp_2d[0].size(); j++) \n    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.real_rp_2d[i][j] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_2d, type: FixedArray2D<Real
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
                //     throw std::runtime_error("Expected a list of lists of CPP_rp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_3d: NOT arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_3d', c_name='real_rp_3d', type='real', kind='rp', pointer_type='NOT', array=['3', '4', '5'], lbound=['1', '1', '1'], ubound=['3', '4', '5'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='tensor2vec(F%real_rp_3d, 3*4*5)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_3d(*)', to_c2_f2_sub_arg='z_real_rp_3d', to_f2_type='real(c_double)', to_f2_name='z_real_rp_3d(*)', to_f2_trans='call vec2tensor(z_real_rp_3d, F%real_rp_3d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_rp_3d == f2%real_rp_3d)\n', test_pat='do jd1 = 1, size(F%real_rp_3d,1); lb1 = lbound(F%real_rp_3d,1) - 1\ndo jd2 = 1, size(F%real_rp_3d,2); lb2 = lbound(F%real_rp_3d,2) - 1\ndo jd3 = 1, size(F%real_rp_3d,3); lb3 = lbound(F%real_rp_3d,3) - 1\n  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n  F%real_rp_3d(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\nenddo; enddo; enddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray3D<Real, 3, 4, 5>', c_instantiation_suffix='', to_f_setup='  Real z_real_rp_3d[3*4*5]; tensor_to_vec(C.real_rp_3d, z_real_rp_3d);\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='z_real_rp_3d', to_c2_arg='c_RealArr z_real_rp_3d', to_c2_set='  C.real_rp_3d << z_real_rp_3d;', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_3d, y.real_rp_3d);\n', test_pat='  for (size_t i = 0; i < C.real_rp_3d.size(); i++)  for (size_t j = 0; j < C.real_rp_3d[0].size(); j++)   for (size_t k = 0; k < C.real_rp_3d[0][0].size(); k++)\n    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; C.real_rp_3d[i][j][k] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_3d, type: FixedArray3D<Real
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
        // CPP_all_encompassing.real_rp_0d_ptr: PTR arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_0d_ptr', c_name='real_rp_0d_ptr', type='real', kind='rp', pointer_type='PTR', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n_real_rp_0d_ptr = 0\nif (associated(F%real_rp_0d_ptr)) n_real_rp_0d_ptr = 1\n', to_c2_call='F%real_rp_0d_ptr', to_c2_type='real(c_double)', to_c2_name='z_real_rp_0d_ptr', to_c2_f2_sub_arg='z_real_rp_0d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_real_rp_0d_ptr', to_f2_trans='if (n_real_rp_0d_ptr == 0) then                                                                                  \n  if (associated(F%real_rp_0d_ptr)) deallocate(F%real_rp_0d_ptr)                                                           \nelse                                                                                                   \n  call c_f_pointer (z_real_rp_0d_ptr, f_real_rp_0d_ptr)                                                                    \n  if (.not. associated(F%real_rp_0d_ptr)) allocate(F%real_rp_0d_ptr)                                                       \n  F%real_rp_0d_ptr = f_real_rp_0d_ptr\nendif                                                                                                  \n', to_f2_var=['real(c_double), pointer :: f_real_rp_0d_ptr'], equality_test='\nis_eq = is_eq .and. (associated(f1%real_rp_0d_ptr) .eqv. associated(f2%real_rp_0d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_rp_0d_ptr)) is_eq = (f1%real_rp_0d_ptr == f2%real_rp_0d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%real_rp_0d_ptr)) deallocate (F%real_rp_0d_ptr)\nelse\n  if (.not. associated(F%real_rp_0d_ptr)) allocate (F%real_rp_0d_ptr)\n  rhs = ARGIDX + offset\n  F%real_rp_0d_ptr = rhs\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='shared_ptr<Real>', c_instantiation_suffix='', to_f_setup='  size_t n_real_rp_0d_ptr = 0; if (C.real_rp_0d_ptr != nullptr) n_real_rp_0d_ptr = 1;\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='C.real_rp_0d_ptr.get()', to_c2_arg='c_RealArr z_real_rp_0d_ptr', to_c2_set='  if (n_real_rp_0d_ptr == 0) {\n    C.real_rp_0d_ptr = nullptr;\n  } else {\n    C.real_rp_0d_ptr = make_shared<Real>();\n    *C.real_rp_0d_ptr = *z_real_rp_0d_ptr;\n  }\n', class_initializer='nullptr', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && ((x.real_rp_0d_ptr == NULL) == (y.real_rp_0d_ptr == NULL));\n  if (!is_eq) return false;\n  if (x.real_rp_0d_ptr != NULL) is_eq = (*x.real_rp_0d_ptr == *y.real_rp_0d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.real_rp_0d_ptr = nullptr;\n  else {\n    C.real_rp_0d_ptr = make_shared<Real>();\n    rhs = ARGIDX + offset; (*C.real_rp_0d_ptr) = rhs;\n  }', test_value='rhs'), split_line=['real_rp_0d_ptr'], intent='', optional=False)
        // PTR
        .def_property_readonly("real_rp_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.real_rp_0d_ptr ? py::cast(*self.real_rp_0d_ptr) : py::none(); },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_1d_ptr: PTR arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_1d_ptr', c_name='real_rp_1d_ptr', type='real', kind='rp', pointer_type='PTR', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_real_rp_1d_ptr = 0\nif (associated(F%real_rp_1d_ptr)) then\n  n1_real_rp_1d_ptr = size(F%real_rp_1d_ptr, 1)\nendif\n', to_c2_call='fvec2vec(F%real_rp_1d_ptr, n1_real_rp_1d_ptr)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_1d_ptr(*)', to_c2_f2_sub_arg='z_real_rp_1d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_real_rp_1d_ptr', to_f2_trans='if (associated(F%real_rp_1d_ptr)) then\n  if (n1_real_rp_1d_ptr == 0 .or. any(shape(F%real_rp_1d_ptr) /= [n1_real_rp_1d_ptr])) deallocate(F%real_rp_1d_ptr)\n  if (any(lbound(F%real_rp_1d_ptr) /= 1)) deallocate(F%real_rp_1d_ptr)\nendif\nif (n1_real_rp_1d_ptr /= 0) then\n  call c_f_pointer (z_real_rp_1d_ptr, f_real_rp_1d_ptr, [n1_real_rp_1d_ptr])\n  if (.not. associated(F%real_rp_1d_ptr)) allocate(F%real_rp_1d_ptr(n1_real_rp_1d_ptr))\n  F%real_rp_1d_ptr = f_real_rp_1d_ptr(1:n1_real_rp_1d_ptr)\nelse\n  if (associated(F%real_rp_1d_ptr)) deallocate(F%real_rp_1d_ptr)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_rp_1d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%real_rp_1d_ptr) .eqv. associated(f2%real_rp_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_rp_1d_ptr)) is_eq = all(shape(f1%real_rp_1d_ptr) == shape(f2%real_rp_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_rp_1d_ptr)) is_eq = all(f1%real_rp_1d_ptr == f2%real_rp_1d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%real_rp_1d_ptr)) deallocate (F%real_rp_1d_ptr)\nelse\n  if (.not. associated(F%real_rp_1d_ptr)) allocate (F%real_rp_1d_ptr(-1:1))\n  do jd1 = 1, size(F%real_rp_1d_ptr,1); lb1 = lbound(F%real_rp_1d_ptr,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%real_rp_1d_ptr(jd1+lb1) = rhs\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Real>', c_instantiation_suffix='', to_f_setup='  auto n1_real_rp_1d_ptr = C.real_rp_1d_ptr.size();\n  c_RealArr z_real_rp_1d_ptr = nullptr;\n  if (n1_real_rp_1d_ptr > 0) {\n    z_real_rp_1d_ptr = &C.real_rp_1d_ptr[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='z_real_rp_1d_ptr', to_c2_arg='c_RealArr z_real_rp_1d_ptr', to_c2_set='\n  C.real_rp_1d_ptr.resize(n1_real_rp_1d_ptr);\n  C.real_rp_1d_ptr << z_real_rp_1d_ptr;\n', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_1d_ptr, y.real_rp_1d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.real_rp_1d_ptr.resize(0);\n  else {\n    C.real_rp_1d_ptr.resize(3);\n    for (size_t i = 0; i < C.real_rp_1d_ptr.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.real_rp_1d_ptr[i] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_1d_ptr, type: VariableArray1D<Real>
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_rp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_rp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_2d_ptr: PTR arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_2d_ptr', c_name='real_rp_2d_ptr', type='real', kind='rp', pointer_type='PTR', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%real_rp_2d_ptr)) then\n  n1_real_rp_2d_ptr = size(F%real_rp_2d_ptr, 1)\n  n2_real_rp_2d_ptr = size(F%real_rp_2d_ptr, 2)\nelse\n  n1_real_rp_2d_ptr = 0; n2_real_rp_2d_ptr = 0\nendif\n', to_c2_call='mat2vec(F%real_rp_2d_ptr, n1_real_rp_2d_ptr*n2_real_rp_2d_ptr)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_2d_ptr(*)', to_c2_f2_sub_arg='z_real_rp_2d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_real_rp_2d_ptr', to_f2_trans='if (associated(F%real_rp_2d_ptr)) then\n  if (n1_real_rp_2d_ptr == 0 .or. any(shape(F%real_rp_2d_ptr) /= [n1_real_rp_2d_ptr, n2_real_rp_2d_ptr])) deallocate(F%real_rp_2d_ptr)\n  if (any(lbound(F%real_rp_2d_ptr) /= 1)) deallocate(F%real_rp_2d_ptr)\nendif\nif (n1_real_rp_2d_ptr /= 0) then\n  call c_f_pointer (z_real_rp_2d_ptr, f_real_rp_2d_ptr, [n1_real_rp_2d_ptr*n2_real_rp_2d_ptr])\n  if (.not. associated(F%real_rp_2d_ptr)) allocate(F%real_rp_2d_ptr(n1_real_rp_2d_ptr, n2_real_rp_2d_ptr))\n  call vec2mat(f_real_rp_2d_ptr, F%real_rp_2d_ptr)\nelse\n  if (associated(F%real_rp_2d_ptr)) deallocate(F%real_rp_2d_ptr)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_rp_2d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%real_rp_2d_ptr) .eqv. associated(f2%real_rp_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_rp_2d_ptr)) is_eq = all(shape(f1%real_rp_2d_ptr) == shape(f2%real_rp_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_rp_2d_ptr)) is_eq = all(f1%real_rp_2d_ptr == f2%real_rp_2d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%real_rp_2d_ptr)) deallocate (F%real_rp_2d_ptr)\nelse\n  if (.not. associated(F%real_rp_2d_ptr)) allocate (F%real_rp_2d_ptr(-1:1, 2))\n  do jd1 = 1, size(F%real_rp_2d_ptr,1); lb1 = lbound(F%real_rp_2d_ptr,1) - 1\n  do jd2 = 1, size(F%real_rp_2d_ptr,2); lb2 = lbound(F%real_rp_2d_ptr,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%real_rp_2d_ptr(jd1+lb1,jd2+lb2) = rhs\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Real>', c_instantiation_suffix='', to_f_setup='  auto n1_real_rp_2d_ptr { C.real_rp_2d_ptr.size() };\n  auto n2_real_rp_2d_ptr { std::size_t{0} };\n  Real* z_real_rp_2d_ptr = nullptr;\n  if (n1_real_rp_2d_ptr > 0) {\n    n2_real_rp_2d_ptr = C.real_rp_2d_ptr[0].size();\n    z_real_rp_2d_ptr = new Real [n1_real_rp_2d_ptr*n2_real_rp_2d_ptr];\n    matrix_to_vec (C.real_rp_2d_ptr, z_real_rp_2d_ptr);\n  }\n', to_f_cleanup='  if (z_real_rp_2d_ptr) delete[] z_real_rp_2d_ptr;\n', to_f2_arg='c_RealArr', to_f2_call='z_real_rp_2d_ptr', to_c2_arg='c_RealArr z_real_rp_2d_ptr', to_c2_set='  C.real_rp_2d_ptr.resize(n1_real_rp_2d_ptr);\n  for (auto i{0}; i < n1_real_rp_2d_ptr; i++) C.real_rp_2d_ptr[i].resize(n2_real_rp_2d_ptr);\n  C.real_rp_2d_ptr << z_real_rp_2d_ptr;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_2d_ptr, y.real_rp_2d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.real_rp_2d_ptr.resize(0);\n  else {\n    C.real_rp_2d_ptr.resize(3);\n    for (size_t i = 0; i < C.real_rp_2d_ptr.size(); i++)\n      C.real_rp_2d_ptr[i].resize(2);\n    for (size_t i = 0; i < C.real_rp_2d_ptr.size(); i++)  for (size_t j = 0; j < C.real_rp_2d_ptr[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.real_rp_2d_ptr[i][j] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_2d_ptr, type: VariableArray2D<Real>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_rp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_3d_ptr: PTR arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_3d_ptr', c_name='real_rp_3d_ptr', type='real', kind='rp', pointer_type='PTR', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%real_rp_3d_ptr)) then\n  n1_real_rp_3d_ptr = size(F%real_rp_3d_ptr, 1)\n  n2_real_rp_3d_ptr = size(F%real_rp_3d_ptr, 2)\n  n3_real_rp_3d_ptr = size(F%real_rp_3d_ptr, 3)\nelse\n  n1_real_rp_3d_ptr = 0; n2_real_rp_3d_ptr = 0; n3_real_rp_3d_ptr = 0\nendif\n', to_c2_call='tensor2vec(F%real_rp_3d_ptr, n1_real_rp_3d_ptr*n2_real_rp_3d_ptr*n3_real_rp_3d_ptr)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_3d_ptr(*)', to_c2_f2_sub_arg='z_real_rp_3d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_real_rp_3d_ptr', to_f2_trans='if (associated(F%real_rp_3d_ptr)) then\n  if (n1_real_rp_3d_ptr == 0 .or. any(shape(F%real_rp_3d_ptr) /= [n1_real_rp_3d_ptr, n2_real_rp_3d_ptr, n3_real_rp_3d_ptr])) deallocate(F%real_rp_3d_ptr)\n  if (any(lbound(F%real_rp_3d_ptr) /= 1)) deallocate(F%real_rp_3d_ptr)\nendif\nif (n1_real_rp_3d_ptr /= 0) then\n  call c_f_pointer (z_real_rp_3d_ptr, f_real_rp_3d_ptr, [n1_real_rp_3d_ptr*n2_real_rp_3d_ptr*n3_real_rp_3d_ptr])\n  if (.not. associated(F%real_rp_3d_ptr)) allocate(F%real_rp_3d_ptr(n1_real_rp_3d_ptr, n2_real_rp_3d_ptr, n3_real_rp_3d_ptr))\n  call vec2tensor(f_real_rp_3d_ptr, F%real_rp_3d_ptr)\nelse\n  if (associated(F%real_rp_3d_ptr)) deallocate(F%real_rp_3d_ptr)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_rp_3d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%real_rp_3d_ptr) .eqv. associated(f2%real_rp_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_rp_3d_ptr)) is_eq = all(shape(f1%real_rp_3d_ptr) == shape(f2%real_rp_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_rp_3d_ptr)) is_eq = all(f1%real_rp_3d_ptr == f2%real_rp_3d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%real_rp_3d_ptr)) deallocate (F%real_rp_3d_ptr)\nelse\n  if (.not. associated(F%real_rp_3d_ptr)) allocate (F%real_rp_3d_ptr(-1:1, 2, 1))\n  do jd1 = 1, size(F%real_rp_3d_ptr,1); lb1 = lbound(F%real_rp_3d_ptr,1) - 1\n  do jd2 = 1, size(F%real_rp_3d_ptr,2); lb2 = lbound(F%real_rp_3d_ptr,2) - 1\n  do jd3 = 1, size(F%real_rp_3d_ptr,3); lb3 = lbound(F%real_rp_3d_ptr,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%real_rp_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Real>', c_instantiation_suffix='', to_f_setup='\n  auto n1_real_rp_3d_ptr { C.real_rp_3d_ptr.size() };\n  auto n2_real_rp_3d_ptr { std::size_t{0} };\n  auto n3_real_rp_3d_ptr { std::size_t{0} };\n  Real* z_real_rp_3d_ptr { nullptr };\n  if (n1_real_rp_3d_ptr > 0) {\n    n2_real_rp_3d_ptr = C.real_rp_3d_ptr[0].size();\n    n3_real_rp_3d_ptr = C.real_rp_3d_ptr[0][0].size();\n    z_real_rp_3d_ptr = new Real [C.real_rp_3d_ptr.size()*C.real_rp_3d_ptr[0].size()*C.real_rp_3d_ptr[0][0].size()];\n    tensor_to_vec (C.real_rp_3d_ptr, z_real_rp_3d_ptr);\n  }\n', to_f_cleanup='  if (z_real_rp_3d_ptr) delete[] z_real_rp_3d_ptr;\n', to_f2_arg='c_RealArr', to_f2_call='z_real_rp_3d_ptr', to_c2_arg='c_RealArr z_real_rp_3d_ptr', to_c2_set='  C.real_rp_3d_ptr.resize(n1_real_rp_3d_ptr);\n  for (size_t i = 0; i < C.real_rp_3d_ptr.size(); i++) {\n    C.real_rp_3d_ptr[i].resize(n2_real_rp_3d_ptr);\n    for (size_t j = 0; j < C.real_rp_3d_ptr[0].size(); j++)\n      C.real_rp_3d_ptr[i][j].resize(n3_real_rp_3d_ptr);\n  }\n  C.real_rp_3d_ptr << z_real_rp_3d_ptr;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_3d_ptr, y.real_rp_3d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.real_rp_3d_ptr.resize(0);\n  else {\n    C.real_rp_3d_ptr.resize(3);\n    for (size_t i = 0; i < C.real_rp_3d_ptr.size(); i++) {\n      C.real_rp_3d_ptr[i].resize(2);\n      for (size_t j = 0; j < C.real_rp_3d_ptr[0].size(); j++) {\n        C.real_rp_3d_ptr[i][j].resize(1);\n        for (size_t k = 0; k < C.real_rp_3d_ptr[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.real_rp_3d_ptr[i][j][k] = rhs;\n        }\n      }\n    }\n  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_3d_ptr, type: VariableArray3D<Real>
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
        // CPP_all_encompassing.real_rp_1d_alloc: ALLOC arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_1d_alloc', c_name='real_rp_1d_alloc', type='real', kind='rp', pointer_type='ALLOC', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_real_rp_1d_alloc = 0\nif (allocated(F%real_rp_1d_alloc)) then\n  n1_real_rp_1d_alloc = size(F%real_rp_1d_alloc, 1)\nendif\n', to_c2_call='fvec2vec(F%real_rp_1d_alloc, n1_real_rp_1d_alloc)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_1d_alloc(*)', to_c2_f2_sub_arg='z_real_rp_1d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_real_rp_1d_alloc', to_f2_trans='if (allocated(F%real_rp_1d_alloc)) then\n  if (n1_real_rp_1d_alloc == 0 .or. any(shape(F%real_rp_1d_alloc) /= [n1_real_rp_1d_alloc])) deallocate(F%real_rp_1d_alloc)\n  if (any(lbound(F%real_rp_1d_alloc) /= 1)) deallocate(F%real_rp_1d_alloc)\nendif\nif (n1_real_rp_1d_alloc /= 0) then\n  call c_f_pointer (z_real_rp_1d_alloc, f_real_rp_1d_alloc, [n1_real_rp_1d_alloc])\n  if (.not. allocated(F%real_rp_1d_alloc)) allocate(F%real_rp_1d_alloc(n1_real_rp_1d_alloc))\n  F%real_rp_1d_alloc = f_real_rp_1d_alloc(1:n1_real_rp_1d_alloc)\nelse\n  if (allocated(F%real_rp_1d_alloc)) deallocate(F%real_rp_1d_alloc)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_rp_1d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%real_rp_1d_alloc) .eqv. allocated(f2%real_rp_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_rp_1d_alloc)) is_eq = all(shape(f1%real_rp_1d_alloc) == shape(f2%real_rp_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_rp_1d_alloc)) is_eq = all(f1%real_rp_1d_alloc == f2%real_rp_1d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%real_rp_1d_alloc)) deallocate (F%real_rp_1d_alloc)\nelse\n  if (.not. allocated(F%real_rp_1d_alloc)) allocate (F%real_rp_1d_alloc(-1:1))\n  do jd1 = 1, size(F%real_rp_1d_alloc,1); lb1 = lbound(F%real_rp_1d_alloc,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%real_rp_1d_alloc(jd1+lb1) = rhs\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Real>', c_instantiation_suffix='', to_f_setup='  auto n1_real_rp_1d_alloc = C.real_rp_1d_alloc.size();\n  c_RealArr z_real_rp_1d_alloc = nullptr;\n  if (n1_real_rp_1d_alloc > 0) {\n    z_real_rp_1d_alloc = &C.real_rp_1d_alloc[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='z_real_rp_1d_alloc', to_c2_arg='c_RealArr z_real_rp_1d_alloc', to_c2_set='\n  C.real_rp_1d_alloc.resize(n1_real_rp_1d_alloc);\n  C.real_rp_1d_alloc << z_real_rp_1d_alloc;\n', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_1d_alloc, y.real_rp_1d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.real_rp_1d_alloc.resize(0);\n  else {\n    C.real_rp_1d_alloc.resize(3);\n    for (size_t i = 0; i < C.real_rp_1d_alloc.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.real_rp_1d_alloc[i] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_1d_alloc, type: VariableArray1D<Real>
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_rp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_rp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_2d_alloc: ALLOC arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_2d_alloc', c_name='real_rp_2d_alloc', type='real', kind='rp', pointer_type='ALLOC', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%real_rp_2d_alloc)) then\n  n1_real_rp_2d_alloc = size(F%real_rp_2d_alloc, 1)\n  n2_real_rp_2d_alloc = size(F%real_rp_2d_alloc, 2)\nelse\n  n1_real_rp_2d_alloc = 0; n2_real_rp_2d_alloc = 0\nendif\n', to_c2_call='mat2vec(F%real_rp_2d_alloc, n1_real_rp_2d_alloc*n2_real_rp_2d_alloc)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_2d_alloc(*)', to_c2_f2_sub_arg='z_real_rp_2d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_real_rp_2d_alloc', to_f2_trans='if (allocated(F%real_rp_2d_alloc)) then\n  if (n1_real_rp_2d_alloc == 0 .or. any(shape(F%real_rp_2d_alloc) /= [n1_real_rp_2d_alloc, n2_real_rp_2d_alloc])) deallocate(F%real_rp_2d_alloc)\n  if (any(lbound(F%real_rp_2d_alloc) /= 1)) deallocate(F%real_rp_2d_alloc)\nendif\nif (n1_real_rp_2d_alloc /= 0) then\n  call c_f_pointer (z_real_rp_2d_alloc, f_real_rp_2d_alloc, [n1_real_rp_2d_alloc*n2_real_rp_2d_alloc])\n  if (.not. allocated(F%real_rp_2d_alloc)) allocate(F%real_rp_2d_alloc(n1_real_rp_2d_alloc, n2_real_rp_2d_alloc))\n  call vec2mat(f_real_rp_2d_alloc, F%real_rp_2d_alloc)\nelse\n  if (allocated(F%real_rp_2d_alloc)) deallocate(F%real_rp_2d_alloc)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_rp_2d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%real_rp_2d_alloc) .eqv. allocated(f2%real_rp_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_rp_2d_alloc)) is_eq = all(shape(f1%real_rp_2d_alloc) == shape(f2%real_rp_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_rp_2d_alloc)) is_eq = all(f1%real_rp_2d_alloc == f2%real_rp_2d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%real_rp_2d_alloc)) deallocate (F%real_rp_2d_alloc)\nelse\n  if (.not. allocated(F%real_rp_2d_alloc)) allocate (F%real_rp_2d_alloc(-1:1, 2))\n  do jd1 = 1, size(F%real_rp_2d_alloc,1); lb1 = lbound(F%real_rp_2d_alloc,1) - 1\n  do jd2 = 1, size(F%real_rp_2d_alloc,2); lb2 = lbound(F%real_rp_2d_alloc,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%real_rp_2d_alloc(jd1+lb1,jd2+lb2) = rhs\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Real>', c_instantiation_suffix='', to_f_setup='  auto n1_real_rp_2d_alloc { C.real_rp_2d_alloc.size() };\n  auto n2_real_rp_2d_alloc { std::size_t{0} };\n  Real* z_real_rp_2d_alloc = nullptr;\n  if (n1_real_rp_2d_alloc > 0) {\n    n2_real_rp_2d_alloc = C.real_rp_2d_alloc[0].size();\n    z_real_rp_2d_alloc = new Real [n1_real_rp_2d_alloc*n2_real_rp_2d_alloc];\n    matrix_to_vec (C.real_rp_2d_alloc, z_real_rp_2d_alloc);\n  }\n', to_f_cleanup='  if (z_real_rp_2d_alloc) delete[] z_real_rp_2d_alloc;\n', to_f2_arg='c_RealArr', to_f2_call='z_real_rp_2d_alloc', to_c2_arg='c_RealArr z_real_rp_2d_alloc', to_c2_set='  C.real_rp_2d_alloc.resize(n1_real_rp_2d_alloc);\n  for (auto i{0}; i < n1_real_rp_2d_alloc; i++) C.real_rp_2d_alloc[i].resize(n2_real_rp_2d_alloc);\n  C.real_rp_2d_alloc << z_real_rp_2d_alloc;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_2d_alloc, y.real_rp_2d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.real_rp_2d_alloc.resize(0);\n  else {\n    C.real_rp_2d_alloc.resize(3);\n    for (size_t i = 0; i < C.real_rp_2d_alloc.size(); i++)\n      C.real_rp_2d_alloc[i].resize(2);\n    for (size_t i = 0; i < C.real_rp_2d_alloc.size(); i++)  for (size_t j = 0; j < C.real_rp_2d_alloc[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.real_rp_2d_alloc[i][j] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_2d_alloc, type: VariableArray2D<Real>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_rp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_rp_3d_alloc: ALLOC arg.kind='rp' arg=Argument(is_component=True, f_name='real_rp_3d_alloc', c_name='real_rp_3d_alloc', type='real', kind='rp', pointer_type='ALLOC', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%real_rp_3d_alloc)) then\n  n1_real_rp_3d_alloc = size(F%real_rp_3d_alloc, 1)\n  n2_real_rp_3d_alloc = size(F%real_rp_3d_alloc, 2)\n  n3_real_rp_3d_alloc = size(F%real_rp_3d_alloc, 3)\nelse\n  n1_real_rp_3d_alloc = 0; n2_real_rp_3d_alloc = 0; n3_real_rp_3d_alloc = 0\nendif\n', to_c2_call='tensor2vec(F%real_rp_3d_alloc, n1_real_rp_3d_alloc*n2_real_rp_3d_alloc*n3_real_rp_3d_alloc)', to_c2_type='real(c_double)', to_c2_name='z_real_rp_3d_alloc(*)', to_c2_f2_sub_arg='z_real_rp_3d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_real_rp_3d_alloc', to_f2_trans='if (allocated(F%real_rp_3d_alloc)) then\n  if (n1_real_rp_3d_alloc == 0 .or. any(shape(F%real_rp_3d_alloc) /= [n1_real_rp_3d_alloc, n2_real_rp_3d_alloc, n3_real_rp_3d_alloc])) deallocate(F%real_rp_3d_alloc)\n  if (any(lbound(F%real_rp_3d_alloc) /= 1)) deallocate(F%real_rp_3d_alloc)\nendif\nif (n1_real_rp_3d_alloc /= 0) then\n  call c_f_pointer (z_real_rp_3d_alloc, f_real_rp_3d_alloc, [n1_real_rp_3d_alloc*n2_real_rp_3d_alloc*n3_real_rp_3d_alloc])\n  if (.not. allocated(F%real_rp_3d_alloc)) allocate(F%real_rp_3d_alloc(n1_real_rp_3d_alloc, n2_real_rp_3d_alloc, n3_real_rp_3d_alloc))\n  call vec2tensor(f_real_rp_3d_alloc, F%real_rp_3d_alloc)\nelse\n  if (allocated(F%real_rp_3d_alloc)) deallocate(F%real_rp_3d_alloc)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_rp_3d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%real_rp_3d_alloc) .eqv. allocated(f2%real_rp_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_rp_3d_alloc)) is_eq = all(shape(f1%real_rp_3d_alloc) == shape(f2%real_rp_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_rp_3d_alloc)) is_eq = all(f1%real_rp_3d_alloc == f2%real_rp_3d_alloc)\n', test_pat='if (ix_patt < 3) then\n  if (allocated(F%real_rp_3d_alloc)) deallocate (F%real_rp_3d_alloc)\nelse\n  if (.not. allocated(F%real_rp_3d_alloc)) allocate (F%real_rp_3d_alloc(-1:1, 2, 1))\n  do jd1 = 1, size(F%real_rp_3d_alloc,1); lb1 = lbound(F%real_rp_3d_alloc,1) - 1\n  do jd2 = 1, size(F%real_rp_3d_alloc,2); lb2 = lbound(F%real_rp_3d_alloc,2) - 1\n  do jd3 = 1, size(F%real_rp_3d_alloc,3); lb3 = lbound(F%real_rp_3d_alloc,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%real_rp_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Real>', c_instantiation_suffix='', to_f_setup='\n  auto n1_real_rp_3d_alloc { C.real_rp_3d_alloc.size() };\n  auto n2_real_rp_3d_alloc { std::size_t{0} };\n  auto n3_real_rp_3d_alloc { std::size_t{0} };\n  Real* z_real_rp_3d_alloc { nullptr };\n  if (n1_real_rp_3d_alloc > 0) {\n    n2_real_rp_3d_alloc = C.real_rp_3d_alloc[0].size();\n    n3_real_rp_3d_alloc = C.real_rp_3d_alloc[0][0].size();\n    z_real_rp_3d_alloc = new Real [C.real_rp_3d_alloc.size()*C.real_rp_3d_alloc[0].size()*C.real_rp_3d_alloc[0][0].size()];\n    tensor_to_vec (C.real_rp_3d_alloc, z_real_rp_3d_alloc);\n  }\n', to_f_cleanup='  if (z_real_rp_3d_alloc) delete[] z_real_rp_3d_alloc;\n', to_f2_arg='c_RealArr', to_f2_call='z_real_rp_3d_alloc', to_c2_arg='c_RealArr z_real_rp_3d_alloc', to_c2_set='  C.real_rp_3d_alloc.resize(n1_real_rp_3d_alloc);\n  for (size_t i = 0; i < C.real_rp_3d_alloc.size(); i++) {\n    C.real_rp_3d_alloc[i].resize(n2_real_rp_3d_alloc);\n    for (size_t j = 0; j < C.real_rp_3d_alloc[0].size(); j++)\n      C.real_rp_3d_alloc[i][j].resize(n3_real_rp_3d_alloc);\n  }\n  C.real_rp_3d_alloc << z_real_rp_3d_alloc;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_rp_3d_alloc, y.real_rp_3d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.real_rp_3d_alloc.resize(0);\n  else {\n    C.real_rp_3d_alloc.resize(3);\n    for (size_t i = 0; i < C.real_rp_3d_alloc.size(); i++) {\n      C.real_rp_3d_alloc[i].resize(2);\n      for (size_t j = 0; j < C.real_rp_3d_alloc[0].size(); j++) {\n        C.real_rp_3d_alloc[i][j].resize(1);\n        for (size_t k = 0; k < C.real_rp_3d_alloc[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.real_rp_3d_alloc[i][j][k] = rhs;\n        }\n      }\n    }\n  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_rp_3d_alloc, type: VariableArray3D<Real>
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
        // CPP_all_encompassing.real_dp_0d: NOT arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_0d', c_name='real_dp_0d', type='real', kind='dp', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%real_dp_0d', to_c2_type='real(c_double)', to_c2_name='z_real_dp_0d', to_c2_f2_sub_arg='z_real_dp_0d', to_f2_type='real(c_double)', to_f2_name='z_real_dp_0d', to_f2_trans='F%real_dp_0d = z_real_dp_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%real_dp_0d == f2%real_dp_0d)\n', test_pat='rhs = ARGIDX + offset; F%real_dp_0d = rhs\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='Real', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Real&', to_f2_call='C.real_dp_0d', to_c2_arg='c_Real& z_real_dp_0d', to_c2_set='  C.real_dp_0d = z_real_dp_0d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.real_dp_0d == y.real_dp_0d);\n', test_pat='  rhs = ARGIDX + offset; C.real_dp_0d = rhs;\n', test_value='rhs'), split_line=['real_dp_0d'], intent='', optional=False)
        // [default case]
        .def_property_readonly("real_dp_0d",
            [](const CPP_all_encompassing &self) { return self.real_dp_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_1d: NOT arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_1d', c_name='real_dp_1d', type='real', kind='dp', pointer_type='NOT', array=['3'], lbound=['1'], ubound=['3'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='fvec2vec(F%real_dp_1d, 3)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_1d(*)', to_c2_f2_sub_arg='z_real_dp_1d', to_f2_type='real(c_double)', to_f2_name='z_real_dp_1d(*)', to_f2_trans='F%real_dp_1d = z_real_dp_1d(1:3)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_1d == f2%real_dp_1d)\n', test_pat='do jd1 = 1, size(F%real_dp_1d,1); lb1 = lbound(F%real_dp_1d,1) - 1\n  rhs = 100 + jd1 + ARGIDX + offset\n  F%real_dp_1d(jd1+lb1) = rhs\nenddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray1D<Real, 3>', c_instantiation_suffix='{VALUE}', to_f_setup='', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='&C.real_dp_1d[0]', to_c2_arg='c_RealArr z_real_dp_1d', to_c2_set='  C.real_dp_1d << z_real_dp_1d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_1d, y.real_dp_1d);\n', test_pat='  for (size_t i = 0; i < C.real_dp_1d.size(); i++)\n    {int rhs = 101 + i + ARGIDX + offset; C.real_dp_1d[i] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_1d, type: FixedArray1D<Real
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_dp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_2d: NOT arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_2d', c_name='real_dp_2d', type='real', kind='dp', pointer_type='NOT', array=['3', '4'], lbound=['1', '1'], ubound=['3', '4'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='mat2vec(F%real_dp_2d, 3*4)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_2d(*)', to_c2_f2_sub_arg='z_real_dp_2d', to_f2_type='real(c_double)', to_f2_name='z_real_dp_2d(*)', to_f2_trans='call vec2mat(z_real_dp_2d, F%real_dp_2d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_2d == f2%real_dp_2d)\n', test_pat='do jd1 = 1, size(F%real_dp_2d,1); lb1 = lbound(F%real_dp_2d,1) - 1\ndo jd2 = 1, size(F%real_dp_2d,2); lb2 = lbound(F%real_dp_2d,2) - 1\n  rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n  F%real_dp_2d(jd1+lb1,jd2+lb2) = rhs\nenddo; enddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray2D<Real, 3, 4>', c_instantiation_suffix='', to_f_setup='  Real z_real_dp_2d[3*4]; matrix_to_vec(C.real_dp_2d, z_real_dp_2d);\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='z_real_dp_2d', to_c2_arg='c_RealArr z_real_dp_2d', to_c2_set='  C.real_dp_2d << z_real_dp_2d;', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_2d, y.real_dp_2d);\n', test_pat='  for (size_t i = 0; i < C.real_dp_2d.size(); i++)  for (size_t j = 0; j < C.real_dp_2d[0].size(); j++) \n    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.real_dp_2d[i][j] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_2d, type: FixedArray2D<Real
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
                //     throw std::runtime_error("Expected a list of lists of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_3d: NOT arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_3d', c_name='real_dp_3d', type='real', kind='dp', pointer_type='NOT', array=['3', '4', '5'], lbound=['1', '1', '1'], ubound=['3', '4', '5'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='tensor2vec(F%real_dp_3d, 3*4*5)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_3d(*)', to_c2_f2_sub_arg='z_real_dp_3d', to_f2_type='real(c_double)', to_f2_name='z_real_dp_3d(*)', to_f2_trans='call vec2tensor(z_real_dp_3d, F%real_dp_3d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%real_dp_3d == f2%real_dp_3d)\n', test_pat='do jd1 = 1, size(F%real_dp_3d,1); lb1 = lbound(F%real_dp_3d,1) - 1\ndo jd2 = 1, size(F%real_dp_3d,2); lb2 = lbound(F%real_dp_3d,2) - 1\ndo jd3 = 1, size(F%real_dp_3d,3); lb3 = lbound(F%real_dp_3d,3) - 1\n  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n  F%real_dp_3d(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\nenddo; enddo; enddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray3D<Real, 3, 4, 5>', c_instantiation_suffix='', to_f_setup='  Real z_real_dp_3d[3*4*5]; tensor_to_vec(C.real_dp_3d, z_real_dp_3d);\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='z_real_dp_3d', to_c2_arg='c_RealArr z_real_dp_3d', to_c2_set='  C.real_dp_3d << z_real_dp_3d;', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_3d, y.real_dp_3d);\n', test_pat='  for (size_t i = 0; i < C.real_dp_3d.size(); i++)  for (size_t j = 0; j < C.real_dp_3d[0].size(); j++)   for (size_t k = 0; k < C.real_dp_3d[0][0].size(); k++)\n    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; C.real_dp_3d[i][j][k] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_3d, type: FixedArray3D<Real
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
        // CPP_all_encompassing.real_dp_0d_ptr: PTR arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_0d_ptr', c_name='real_dp_0d_ptr', type='real', kind='dp', pointer_type='PTR', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n_real_dp_0d_ptr = 0\nif (associated(F%real_dp_0d_ptr)) n_real_dp_0d_ptr = 1\n', to_c2_call='F%real_dp_0d_ptr', to_c2_type='real(c_double)', to_c2_name='z_real_dp_0d_ptr', to_c2_f2_sub_arg='z_real_dp_0d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_real_dp_0d_ptr', to_f2_trans='if (n_real_dp_0d_ptr == 0) then                                                                                  \n  if (associated(F%real_dp_0d_ptr)) deallocate(F%real_dp_0d_ptr)                                                           \nelse                                                                                                   \n  call c_f_pointer (z_real_dp_0d_ptr, f_real_dp_0d_ptr)                                                                    \n  if (.not. associated(F%real_dp_0d_ptr)) allocate(F%real_dp_0d_ptr)                                                       \n  F%real_dp_0d_ptr = f_real_dp_0d_ptr\nendif                                                                                                  \n', to_f2_var=['real(c_double), pointer :: f_real_dp_0d_ptr'], equality_test='\nis_eq = is_eq .and. (associated(f1%real_dp_0d_ptr) .eqv. associated(f2%real_dp_0d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_dp_0d_ptr)) is_eq = (f1%real_dp_0d_ptr == f2%real_dp_0d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%real_dp_0d_ptr)) deallocate (F%real_dp_0d_ptr)\nelse\n  if (.not. associated(F%real_dp_0d_ptr)) allocate (F%real_dp_0d_ptr)\n  rhs = ARGIDX + offset\n  F%real_dp_0d_ptr = rhs\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='shared_ptr<Real>', c_instantiation_suffix='', to_f_setup='  size_t n_real_dp_0d_ptr = 0; if (C.real_dp_0d_ptr != nullptr) n_real_dp_0d_ptr = 1;\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='C.real_dp_0d_ptr.get()', to_c2_arg='c_RealArr z_real_dp_0d_ptr', to_c2_set='  if (n_real_dp_0d_ptr == 0) {\n    C.real_dp_0d_ptr = nullptr;\n  } else {\n    C.real_dp_0d_ptr = make_shared<Real>();\n    *C.real_dp_0d_ptr = *z_real_dp_0d_ptr;\n  }\n', class_initializer='nullptr', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && ((x.real_dp_0d_ptr == NULL) == (y.real_dp_0d_ptr == NULL));\n  if (!is_eq) return false;\n  if (x.real_dp_0d_ptr != NULL) is_eq = (*x.real_dp_0d_ptr == *y.real_dp_0d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.real_dp_0d_ptr = nullptr;\n  else {\n    C.real_dp_0d_ptr = make_shared<Real>();\n    rhs = ARGIDX + offset; (*C.real_dp_0d_ptr) = rhs;\n  }', test_value='rhs'), split_line=['real_dp_0d_ptr'], intent='', optional=False)
        // PTR
        .def_property_readonly("real_dp_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.real_dp_0d_ptr ? py::cast(*self.real_dp_0d_ptr) : py::none(); },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_1d_ptr: PTR arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_1d_ptr', c_name='real_dp_1d_ptr', type='real', kind='dp', pointer_type='PTR', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_real_dp_1d_ptr = 0\nif (associated(F%real_dp_1d_ptr)) then\n  n1_real_dp_1d_ptr = size(F%real_dp_1d_ptr, 1)\nendif\n', to_c2_call='fvec2vec(F%real_dp_1d_ptr, n1_real_dp_1d_ptr)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_1d_ptr(*)', to_c2_f2_sub_arg='z_real_dp_1d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_real_dp_1d_ptr', to_f2_trans='if (associated(F%real_dp_1d_ptr)) then\n  if (n1_real_dp_1d_ptr == 0 .or. any(shape(F%real_dp_1d_ptr) /= [n1_real_dp_1d_ptr])) deallocate(F%real_dp_1d_ptr)\n  if (any(lbound(F%real_dp_1d_ptr) /= 1)) deallocate(F%real_dp_1d_ptr)\nendif\nif (n1_real_dp_1d_ptr /= 0) then\n  call c_f_pointer (z_real_dp_1d_ptr, f_real_dp_1d_ptr, [n1_real_dp_1d_ptr])\n  if (.not. associated(F%real_dp_1d_ptr)) allocate(F%real_dp_1d_ptr(n1_real_dp_1d_ptr))\n  F%real_dp_1d_ptr = f_real_dp_1d_ptr(1:n1_real_dp_1d_ptr)\nelse\n  if (associated(F%real_dp_1d_ptr)) deallocate(F%real_dp_1d_ptr)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_dp_1d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%real_dp_1d_ptr) .eqv. associated(f2%real_dp_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_dp_1d_ptr)) is_eq = all(shape(f1%real_dp_1d_ptr) == shape(f2%real_dp_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_dp_1d_ptr)) is_eq = all(f1%real_dp_1d_ptr == f2%real_dp_1d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%real_dp_1d_ptr)) deallocate (F%real_dp_1d_ptr)\nelse\n  if (.not. associated(F%real_dp_1d_ptr)) allocate (F%real_dp_1d_ptr(-1:1))\n  do jd1 = 1, size(F%real_dp_1d_ptr,1); lb1 = lbound(F%real_dp_1d_ptr,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%real_dp_1d_ptr(jd1+lb1) = rhs\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Real>', c_instantiation_suffix='', to_f_setup='  auto n1_real_dp_1d_ptr = C.real_dp_1d_ptr.size();\n  c_RealArr z_real_dp_1d_ptr = nullptr;\n  if (n1_real_dp_1d_ptr > 0) {\n    z_real_dp_1d_ptr = &C.real_dp_1d_ptr[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='z_real_dp_1d_ptr', to_c2_arg='c_RealArr z_real_dp_1d_ptr', to_c2_set='\n  C.real_dp_1d_ptr.resize(n1_real_dp_1d_ptr);\n  C.real_dp_1d_ptr << z_real_dp_1d_ptr;\n', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_1d_ptr, y.real_dp_1d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.real_dp_1d_ptr.resize(0);\n  else {\n    C.real_dp_1d_ptr.resize(3);\n    for (size_t i = 0; i < C.real_dp_1d_ptr.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.real_dp_1d_ptr[i] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_1d_ptr, type: VariableArray1D<Real>
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_dp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_2d_ptr: PTR arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_2d_ptr', c_name='real_dp_2d_ptr', type='real', kind='dp', pointer_type='PTR', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%real_dp_2d_ptr)) then\n  n1_real_dp_2d_ptr = size(F%real_dp_2d_ptr, 1)\n  n2_real_dp_2d_ptr = size(F%real_dp_2d_ptr, 2)\nelse\n  n1_real_dp_2d_ptr = 0; n2_real_dp_2d_ptr = 0\nendif\n', to_c2_call='mat2vec(F%real_dp_2d_ptr, n1_real_dp_2d_ptr*n2_real_dp_2d_ptr)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_2d_ptr(*)', to_c2_f2_sub_arg='z_real_dp_2d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_real_dp_2d_ptr', to_f2_trans='if (associated(F%real_dp_2d_ptr)) then\n  if (n1_real_dp_2d_ptr == 0 .or. any(shape(F%real_dp_2d_ptr) /= [n1_real_dp_2d_ptr, n2_real_dp_2d_ptr])) deallocate(F%real_dp_2d_ptr)\n  if (any(lbound(F%real_dp_2d_ptr) /= 1)) deallocate(F%real_dp_2d_ptr)\nendif\nif (n1_real_dp_2d_ptr /= 0) then\n  call c_f_pointer (z_real_dp_2d_ptr, f_real_dp_2d_ptr, [n1_real_dp_2d_ptr*n2_real_dp_2d_ptr])\n  if (.not. associated(F%real_dp_2d_ptr)) allocate(F%real_dp_2d_ptr(n1_real_dp_2d_ptr, n2_real_dp_2d_ptr))\n  call vec2mat(f_real_dp_2d_ptr, F%real_dp_2d_ptr)\nelse\n  if (associated(F%real_dp_2d_ptr)) deallocate(F%real_dp_2d_ptr)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_dp_2d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%real_dp_2d_ptr) .eqv. associated(f2%real_dp_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_dp_2d_ptr)) is_eq = all(shape(f1%real_dp_2d_ptr) == shape(f2%real_dp_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_dp_2d_ptr)) is_eq = all(f1%real_dp_2d_ptr == f2%real_dp_2d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%real_dp_2d_ptr)) deallocate (F%real_dp_2d_ptr)\nelse\n  if (.not. associated(F%real_dp_2d_ptr)) allocate (F%real_dp_2d_ptr(-1:1, 2))\n  do jd1 = 1, size(F%real_dp_2d_ptr,1); lb1 = lbound(F%real_dp_2d_ptr,1) - 1\n  do jd2 = 1, size(F%real_dp_2d_ptr,2); lb2 = lbound(F%real_dp_2d_ptr,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%real_dp_2d_ptr(jd1+lb1,jd2+lb2) = rhs\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Real>', c_instantiation_suffix='', to_f_setup='  auto n1_real_dp_2d_ptr { C.real_dp_2d_ptr.size() };\n  auto n2_real_dp_2d_ptr { std::size_t{0} };\n  Real* z_real_dp_2d_ptr = nullptr;\n  if (n1_real_dp_2d_ptr > 0) {\n    n2_real_dp_2d_ptr = C.real_dp_2d_ptr[0].size();\n    z_real_dp_2d_ptr = new Real [n1_real_dp_2d_ptr*n2_real_dp_2d_ptr];\n    matrix_to_vec (C.real_dp_2d_ptr, z_real_dp_2d_ptr);\n  }\n', to_f_cleanup='  if (z_real_dp_2d_ptr) delete[] z_real_dp_2d_ptr;\n', to_f2_arg='c_RealArr', to_f2_call='z_real_dp_2d_ptr', to_c2_arg='c_RealArr z_real_dp_2d_ptr', to_c2_set='  C.real_dp_2d_ptr.resize(n1_real_dp_2d_ptr);\n  for (auto i{0}; i < n1_real_dp_2d_ptr; i++) C.real_dp_2d_ptr[i].resize(n2_real_dp_2d_ptr);\n  C.real_dp_2d_ptr << z_real_dp_2d_ptr;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_2d_ptr, y.real_dp_2d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.real_dp_2d_ptr.resize(0);\n  else {\n    C.real_dp_2d_ptr.resize(3);\n    for (size_t i = 0; i < C.real_dp_2d_ptr.size(); i++)\n      C.real_dp_2d_ptr[i].resize(2);\n    for (size_t i = 0; i < C.real_dp_2d_ptr.size(); i++)  for (size_t j = 0; j < C.real_dp_2d_ptr[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.real_dp_2d_ptr[i][j] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_2d_ptr, type: VariableArray2D<Real>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_3d_ptr: PTR arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_3d_ptr', c_name='real_dp_3d_ptr', type='real', kind='dp', pointer_type='PTR', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%real_dp_3d_ptr)) then\n  n1_real_dp_3d_ptr = size(F%real_dp_3d_ptr, 1)\n  n2_real_dp_3d_ptr = size(F%real_dp_3d_ptr, 2)\n  n3_real_dp_3d_ptr = size(F%real_dp_3d_ptr, 3)\nelse\n  n1_real_dp_3d_ptr = 0; n2_real_dp_3d_ptr = 0; n3_real_dp_3d_ptr = 0\nendif\n', to_c2_call='tensor2vec(F%real_dp_3d_ptr, n1_real_dp_3d_ptr*n2_real_dp_3d_ptr*n3_real_dp_3d_ptr)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_3d_ptr(*)', to_c2_f2_sub_arg='z_real_dp_3d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_real_dp_3d_ptr', to_f2_trans='if (associated(F%real_dp_3d_ptr)) then\n  if (n1_real_dp_3d_ptr == 0 .or. any(shape(F%real_dp_3d_ptr) /= [n1_real_dp_3d_ptr, n2_real_dp_3d_ptr, n3_real_dp_3d_ptr])) deallocate(F%real_dp_3d_ptr)\n  if (any(lbound(F%real_dp_3d_ptr) /= 1)) deallocate(F%real_dp_3d_ptr)\nendif\nif (n1_real_dp_3d_ptr /= 0) then\n  call c_f_pointer (z_real_dp_3d_ptr, f_real_dp_3d_ptr, [n1_real_dp_3d_ptr*n2_real_dp_3d_ptr*n3_real_dp_3d_ptr])\n  if (.not. associated(F%real_dp_3d_ptr)) allocate(F%real_dp_3d_ptr(n1_real_dp_3d_ptr, n2_real_dp_3d_ptr, n3_real_dp_3d_ptr))\n  call vec2tensor(f_real_dp_3d_ptr, F%real_dp_3d_ptr)\nelse\n  if (associated(F%real_dp_3d_ptr)) deallocate(F%real_dp_3d_ptr)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_dp_3d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%real_dp_3d_ptr) .eqv. associated(f2%real_dp_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_dp_3d_ptr)) is_eq = all(shape(f1%real_dp_3d_ptr) == shape(f2%real_dp_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%real_dp_3d_ptr)) is_eq = all(f1%real_dp_3d_ptr == f2%real_dp_3d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%real_dp_3d_ptr)) deallocate (F%real_dp_3d_ptr)\nelse\n  if (.not. associated(F%real_dp_3d_ptr)) allocate (F%real_dp_3d_ptr(-1:1, 2, 1))\n  do jd1 = 1, size(F%real_dp_3d_ptr,1); lb1 = lbound(F%real_dp_3d_ptr,1) - 1\n  do jd2 = 1, size(F%real_dp_3d_ptr,2); lb2 = lbound(F%real_dp_3d_ptr,2) - 1\n  do jd3 = 1, size(F%real_dp_3d_ptr,3); lb3 = lbound(F%real_dp_3d_ptr,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%real_dp_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Real>', c_instantiation_suffix='', to_f_setup='\n  auto n1_real_dp_3d_ptr { C.real_dp_3d_ptr.size() };\n  auto n2_real_dp_3d_ptr { std::size_t{0} };\n  auto n3_real_dp_3d_ptr { std::size_t{0} };\n  Real* z_real_dp_3d_ptr { nullptr };\n  if (n1_real_dp_3d_ptr > 0) {\n    n2_real_dp_3d_ptr = C.real_dp_3d_ptr[0].size();\n    n3_real_dp_3d_ptr = C.real_dp_3d_ptr[0][0].size();\n    z_real_dp_3d_ptr = new Real [C.real_dp_3d_ptr.size()*C.real_dp_3d_ptr[0].size()*C.real_dp_3d_ptr[0][0].size()];\n    tensor_to_vec (C.real_dp_3d_ptr, z_real_dp_3d_ptr);\n  }\n', to_f_cleanup='  if (z_real_dp_3d_ptr) delete[] z_real_dp_3d_ptr;\n', to_f2_arg='c_RealArr', to_f2_call='z_real_dp_3d_ptr', to_c2_arg='c_RealArr z_real_dp_3d_ptr', to_c2_set='  C.real_dp_3d_ptr.resize(n1_real_dp_3d_ptr);\n  for (size_t i = 0; i < C.real_dp_3d_ptr.size(); i++) {\n    C.real_dp_3d_ptr[i].resize(n2_real_dp_3d_ptr);\n    for (size_t j = 0; j < C.real_dp_3d_ptr[0].size(); j++)\n      C.real_dp_3d_ptr[i][j].resize(n3_real_dp_3d_ptr);\n  }\n  C.real_dp_3d_ptr << z_real_dp_3d_ptr;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_3d_ptr, y.real_dp_3d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.real_dp_3d_ptr.resize(0);\n  else {\n    C.real_dp_3d_ptr.resize(3);\n    for (size_t i = 0; i < C.real_dp_3d_ptr.size(); i++) {\n      C.real_dp_3d_ptr[i].resize(2);\n      for (size_t j = 0; j < C.real_dp_3d_ptr[0].size(); j++) {\n        C.real_dp_3d_ptr[i][j].resize(1);\n        for (size_t k = 0; k < C.real_dp_3d_ptr[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.real_dp_3d_ptr[i][j][k] = rhs;\n        }\n      }\n    }\n  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_3d_ptr, type: VariableArray3D<Real>
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
        // CPP_all_encompassing.real_dp_1d_alloc: ALLOC arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_1d_alloc', c_name='real_dp_1d_alloc', type='real', kind='dp', pointer_type='ALLOC', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_real_dp_1d_alloc = 0\nif (allocated(F%real_dp_1d_alloc)) then\n  n1_real_dp_1d_alloc = size(F%real_dp_1d_alloc, 1)\nendif\n', to_c2_call='fvec2vec(F%real_dp_1d_alloc, n1_real_dp_1d_alloc)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_1d_alloc(*)', to_c2_f2_sub_arg='z_real_dp_1d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_real_dp_1d_alloc', to_f2_trans='if (allocated(F%real_dp_1d_alloc)) then\n  if (n1_real_dp_1d_alloc == 0 .or. any(shape(F%real_dp_1d_alloc) /= [n1_real_dp_1d_alloc])) deallocate(F%real_dp_1d_alloc)\n  if (any(lbound(F%real_dp_1d_alloc) /= 1)) deallocate(F%real_dp_1d_alloc)\nendif\nif (n1_real_dp_1d_alloc /= 0) then\n  call c_f_pointer (z_real_dp_1d_alloc, f_real_dp_1d_alloc, [n1_real_dp_1d_alloc])\n  if (.not. allocated(F%real_dp_1d_alloc)) allocate(F%real_dp_1d_alloc(n1_real_dp_1d_alloc))\n  F%real_dp_1d_alloc = f_real_dp_1d_alloc(1:n1_real_dp_1d_alloc)\nelse\n  if (allocated(F%real_dp_1d_alloc)) deallocate(F%real_dp_1d_alloc)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_dp_1d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%real_dp_1d_alloc) .eqv. allocated(f2%real_dp_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_dp_1d_alloc)) is_eq = all(shape(f1%real_dp_1d_alloc) == shape(f2%real_dp_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_dp_1d_alloc)) is_eq = all(f1%real_dp_1d_alloc == f2%real_dp_1d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%real_dp_1d_alloc)) deallocate (F%real_dp_1d_alloc)\nelse\n  if (.not. allocated(F%real_dp_1d_alloc)) allocate (F%real_dp_1d_alloc(-1:1))\n  do jd1 = 1, size(F%real_dp_1d_alloc,1); lb1 = lbound(F%real_dp_1d_alloc,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%real_dp_1d_alloc(jd1+lb1) = rhs\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Real>', c_instantiation_suffix='', to_f_setup='  auto n1_real_dp_1d_alloc = C.real_dp_1d_alloc.size();\n  c_RealArr z_real_dp_1d_alloc = nullptr;\n  if (n1_real_dp_1d_alloc > 0) {\n    z_real_dp_1d_alloc = &C.real_dp_1d_alloc[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_RealArr', to_f2_call='z_real_dp_1d_alloc', to_c2_arg='c_RealArr z_real_dp_1d_alloc', to_c2_set='\n  C.real_dp_1d_alloc.resize(n1_real_dp_1d_alloc);\n  C.real_dp_1d_alloc << z_real_dp_1d_alloc;\n', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_1d_alloc, y.real_dp_1d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.real_dp_1d_alloc.resize(0);\n  else {\n    C.real_dp_1d_alloc.resize(3);\n    for (size_t i = 0; i < C.real_dp_1d_alloc.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.real_dp_1d_alloc[i] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_1d_alloc, type: VariableArray1D<Real>
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_dp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_2d_alloc: ALLOC arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_2d_alloc', c_name='real_dp_2d_alloc', type='real', kind='dp', pointer_type='ALLOC', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%real_dp_2d_alloc)) then\n  n1_real_dp_2d_alloc = size(F%real_dp_2d_alloc, 1)\n  n2_real_dp_2d_alloc = size(F%real_dp_2d_alloc, 2)\nelse\n  n1_real_dp_2d_alloc = 0; n2_real_dp_2d_alloc = 0\nendif\n', to_c2_call='mat2vec(F%real_dp_2d_alloc, n1_real_dp_2d_alloc*n2_real_dp_2d_alloc)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_2d_alloc(*)', to_c2_f2_sub_arg='z_real_dp_2d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_real_dp_2d_alloc', to_f2_trans='if (allocated(F%real_dp_2d_alloc)) then\n  if (n1_real_dp_2d_alloc == 0 .or. any(shape(F%real_dp_2d_alloc) /= [n1_real_dp_2d_alloc, n2_real_dp_2d_alloc])) deallocate(F%real_dp_2d_alloc)\n  if (any(lbound(F%real_dp_2d_alloc) /= 1)) deallocate(F%real_dp_2d_alloc)\nendif\nif (n1_real_dp_2d_alloc /= 0) then\n  call c_f_pointer (z_real_dp_2d_alloc, f_real_dp_2d_alloc, [n1_real_dp_2d_alloc*n2_real_dp_2d_alloc])\n  if (.not. allocated(F%real_dp_2d_alloc)) allocate(F%real_dp_2d_alloc(n1_real_dp_2d_alloc, n2_real_dp_2d_alloc))\n  call vec2mat(f_real_dp_2d_alloc, F%real_dp_2d_alloc)\nelse\n  if (allocated(F%real_dp_2d_alloc)) deallocate(F%real_dp_2d_alloc)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_dp_2d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%real_dp_2d_alloc) .eqv. allocated(f2%real_dp_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_dp_2d_alloc)) is_eq = all(shape(f1%real_dp_2d_alloc) == shape(f2%real_dp_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_dp_2d_alloc)) is_eq = all(f1%real_dp_2d_alloc == f2%real_dp_2d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%real_dp_2d_alloc)) deallocate (F%real_dp_2d_alloc)\nelse\n  if (.not. allocated(F%real_dp_2d_alloc)) allocate (F%real_dp_2d_alloc(-1:1, 2))\n  do jd1 = 1, size(F%real_dp_2d_alloc,1); lb1 = lbound(F%real_dp_2d_alloc,1) - 1\n  do jd2 = 1, size(F%real_dp_2d_alloc,2); lb2 = lbound(F%real_dp_2d_alloc,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%real_dp_2d_alloc(jd1+lb1,jd2+lb2) = rhs\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Real>', c_instantiation_suffix='', to_f_setup='  auto n1_real_dp_2d_alloc { C.real_dp_2d_alloc.size() };\n  auto n2_real_dp_2d_alloc { std::size_t{0} };\n  Real* z_real_dp_2d_alloc = nullptr;\n  if (n1_real_dp_2d_alloc > 0) {\n    n2_real_dp_2d_alloc = C.real_dp_2d_alloc[0].size();\n    z_real_dp_2d_alloc = new Real [n1_real_dp_2d_alloc*n2_real_dp_2d_alloc];\n    matrix_to_vec (C.real_dp_2d_alloc, z_real_dp_2d_alloc);\n  }\n', to_f_cleanup='  if (z_real_dp_2d_alloc) delete[] z_real_dp_2d_alloc;\n', to_f2_arg='c_RealArr', to_f2_call='z_real_dp_2d_alloc', to_c2_arg='c_RealArr z_real_dp_2d_alloc', to_c2_set='  C.real_dp_2d_alloc.resize(n1_real_dp_2d_alloc);\n  for (auto i{0}; i < n1_real_dp_2d_alloc; i++) C.real_dp_2d_alloc[i].resize(n2_real_dp_2d_alloc);\n  C.real_dp_2d_alloc << z_real_dp_2d_alloc;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_2d_alloc, y.real_dp_2d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.real_dp_2d_alloc.resize(0);\n  else {\n    C.real_dp_2d_alloc.resize(3);\n    for (size_t i = 0; i < C.real_dp_2d_alloc.size(); i++)\n      C.real_dp_2d_alloc[i].resize(2);\n    for (size_t i = 0; i < C.real_dp_2d_alloc.size(); i++)  for (size_t j = 0; j < C.real_dp_2d_alloc[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.real_dp_2d_alloc[i][j] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_2d_alloc, type: VariableArray2D<Real>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.real_dp_3d_alloc: ALLOC arg.kind='dp' arg=Argument(is_component=True, f_name='real_dp_3d_alloc', c_name='real_dp_3d_alloc', type='real', kind='dp', pointer_type='ALLOC', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%real_dp_3d_alloc)) then\n  n1_real_dp_3d_alloc = size(F%real_dp_3d_alloc, 1)\n  n2_real_dp_3d_alloc = size(F%real_dp_3d_alloc, 2)\n  n3_real_dp_3d_alloc = size(F%real_dp_3d_alloc, 3)\nelse\n  n1_real_dp_3d_alloc = 0; n2_real_dp_3d_alloc = 0; n3_real_dp_3d_alloc = 0\nendif\n', to_c2_call='tensor2vec(F%real_dp_3d_alloc, n1_real_dp_3d_alloc*n2_real_dp_3d_alloc*n3_real_dp_3d_alloc)', to_c2_type='real(c_double)', to_c2_name='z_real_dp_3d_alloc(*)', to_c2_f2_sub_arg='z_real_dp_3d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_real_dp_3d_alloc', to_f2_trans='if (allocated(F%real_dp_3d_alloc)) then\n  if (n1_real_dp_3d_alloc == 0 .or. any(shape(F%real_dp_3d_alloc) /= [n1_real_dp_3d_alloc, n2_real_dp_3d_alloc, n3_real_dp_3d_alloc])) deallocate(F%real_dp_3d_alloc)\n  if (any(lbound(F%real_dp_3d_alloc) /= 1)) deallocate(F%real_dp_3d_alloc)\nendif\nif (n1_real_dp_3d_alloc /= 0) then\n  call c_f_pointer (z_real_dp_3d_alloc, f_real_dp_3d_alloc, [n1_real_dp_3d_alloc*n2_real_dp_3d_alloc*n3_real_dp_3d_alloc])\n  if (.not. allocated(F%real_dp_3d_alloc)) allocate(F%real_dp_3d_alloc(n1_real_dp_3d_alloc, n2_real_dp_3d_alloc, n3_real_dp_3d_alloc))\n  call vec2tensor(f_real_dp_3d_alloc, F%real_dp_3d_alloc)\nelse\n  if (allocated(F%real_dp_3d_alloc)) deallocate(F%real_dp_3d_alloc)\nendif\n', to_f2_var=['real(c_double), pointer :: f_real_dp_3d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%real_dp_3d_alloc) .eqv. allocated(f2%real_dp_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_dp_3d_alloc)) is_eq = all(shape(f1%real_dp_3d_alloc) == shape(f2%real_dp_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%real_dp_3d_alloc)) is_eq = all(f1%real_dp_3d_alloc == f2%real_dp_3d_alloc)\n', test_pat='if (ix_patt < 3) then\n  if (allocated(F%real_dp_3d_alloc)) deallocate (F%real_dp_3d_alloc)\nelse\n  if (.not. allocated(F%real_dp_3d_alloc)) allocate (F%real_dp_3d_alloc(-1:1, 2, 1))\n  do jd1 = 1, size(F%real_dp_3d_alloc,1); lb1 = lbound(F%real_dp_3d_alloc,1) - 1\n  do jd2 = 1, size(F%real_dp_3d_alloc,2); lb2 = lbound(F%real_dp_3d_alloc,2) - 1\n  do jd3 = 1, size(F%real_dp_3d_alloc,3); lb3 = lbound(F%real_dp_3d_alloc,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%real_dp_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Real>', c_instantiation_suffix='', to_f_setup='\n  auto n1_real_dp_3d_alloc { C.real_dp_3d_alloc.size() };\n  auto n2_real_dp_3d_alloc { std::size_t{0} };\n  auto n3_real_dp_3d_alloc { std::size_t{0} };\n  Real* z_real_dp_3d_alloc { nullptr };\n  if (n1_real_dp_3d_alloc > 0) {\n    n2_real_dp_3d_alloc = C.real_dp_3d_alloc[0].size();\n    n3_real_dp_3d_alloc = C.real_dp_3d_alloc[0][0].size();\n    z_real_dp_3d_alloc = new Real [C.real_dp_3d_alloc.size()*C.real_dp_3d_alloc[0].size()*C.real_dp_3d_alloc[0][0].size()];\n    tensor_to_vec (C.real_dp_3d_alloc, z_real_dp_3d_alloc);\n  }\n', to_f_cleanup='  if (z_real_dp_3d_alloc) delete[] z_real_dp_3d_alloc;\n', to_f2_arg='c_RealArr', to_f2_call='z_real_dp_3d_alloc', to_c2_arg='c_RealArr z_real_dp_3d_alloc', to_c2_set='  C.real_dp_3d_alloc.resize(n1_real_dp_3d_alloc);\n  for (size_t i = 0; i < C.real_dp_3d_alloc.size(); i++) {\n    C.real_dp_3d_alloc[i].resize(n2_real_dp_3d_alloc);\n    for (size_t j = 0; j < C.real_dp_3d_alloc[0].size(); j++)\n      C.real_dp_3d_alloc[i][j].resize(n3_real_dp_3d_alloc);\n  }\n  C.real_dp_3d_alloc << z_real_dp_3d_alloc;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.real_dp_3d_alloc, y.real_dp_3d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.real_dp_3d_alloc.resize(0);\n  else {\n    C.real_dp_3d_alloc.resize(3);\n    for (size_t i = 0; i < C.real_dp_3d_alloc.size(); i++) {\n      C.real_dp_3d_alloc[i].resize(2);\n      for (size_t j = 0; j < C.real_dp_3d_alloc[0].size(); j++) {\n        C.real_dp_3d_alloc[i][j].resize(1);\n        for (size_t k = 0; k < C.real_dp_3d_alloc[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.real_dp_3d_alloc[i][j][k] = rhs;\n        }\n      }\n    }\n  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: real_dp_3d_alloc, type: VariableArray3D<Real>
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
        // CPP_all_encompassing.complex_dp_0d: NOT arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_0d', c_name='complex_dp_0d', type='complex', kind='dp', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%complex_dp_0d', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_0d', to_c2_f2_sub_arg='z_complex_dp_0d', to_f2_type='complex(c_double_complex)', to_f2_name='z_complex_dp_0d', to_f2_trans='F%complex_dp_0d = z_complex_dp_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%complex_dp_0d == f2%complex_dp_0d)\n', test_pat='rhs = ARGIDX + offset; F%complex_dp_0d = cmplx(rhs, 100+rhs)\n', size_var=[], test_value='cmplx(rhs, 100+rhs)'), c_side=c_side_trans_class(c_class='Complex', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Complex&', to_f2_call='C.complex_dp_0d', to_c2_arg='c_Complex& z_complex_dp_0d', to_c2_set='  C.complex_dp_0d = z_complex_dp_0d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && (x.complex_dp_0d == y.complex_dp_0d);\n', test_pat='  rhs = ARGIDX + offset; C.complex_dp_0d = Complex(rhs, 100+rhs);\n', test_value='Complex(rhs, 100+rhs)'), split_line=['complex_dp_0d'], intent='', optional=False)
        // [default case]
        .def_property_readonly("complex_dp_0d",
            [](const CPP_all_encompassing &self) { return self.complex_dp_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_1d: NOT arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_1d', c_name='complex_dp_1d', type='complex', kind='dp', pointer_type='NOT', array=['3'], lbound=['1'], ubound=['3'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='fvec2vec(F%complex_dp_1d, 3)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_1d(*)', to_c2_f2_sub_arg='z_complex_dp_1d', to_f2_type='complex(c_double_complex)', to_f2_name='z_complex_dp_1d(*)', to_f2_trans='F%complex_dp_1d = z_complex_dp_1d(1:3)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_1d == f2%complex_dp_1d)\n', test_pat='do jd1 = 1, size(F%complex_dp_1d,1); lb1 = lbound(F%complex_dp_1d,1) - 1\n  rhs = 100 + jd1 + ARGIDX + offset\n  F%complex_dp_1d(jd1+lb1) = cmplx(rhs, 100+rhs)\nenddo\n', size_var=[], test_value='cmplx(rhs, 100+rhs)'), c_side=c_side_trans_class(c_class='FixedArray1D<Complex, 3>', c_instantiation_suffix='{VALUE}', to_f_setup='', to_f_cleanup='', to_f2_arg='c_ComplexArr', to_f2_call='&C.complex_dp_1d[0]', to_c2_arg='c_ComplexArr z_complex_dp_1d', to_c2_set='  C.complex_dp_1d << z_complex_dp_1d;', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_1d, y.complex_dp_1d);\n', test_pat='  for (size_t i = 0; i < C.complex_dp_1d.size(); i++)\n    {int rhs = 101 + i + ARGIDX + offset; C.complex_dp_1d[i] = Complex(rhs, 100+rhs);}', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_1d, type: FixedArray1D<Complex
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_dp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_2d: NOT arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_2d', c_name='complex_dp_2d', type='complex', kind='dp', pointer_type='NOT', array=['3', '4'], lbound=['1', '1'], ubound=['3', '4'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='mat2vec(F%complex_dp_2d, 3*4)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_2d(*)', to_c2_f2_sub_arg='z_complex_dp_2d', to_f2_type='complex(c_double_complex)', to_f2_name='z_complex_dp_2d(*)', to_f2_trans='call vec2mat(z_complex_dp_2d, F%complex_dp_2d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_2d == f2%complex_dp_2d)\n', test_pat='do jd1 = 1, size(F%complex_dp_2d,1); lb1 = lbound(F%complex_dp_2d,1) - 1\ndo jd2 = 1, size(F%complex_dp_2d,2); lb2 = lbound(F%complex_dp_2d,2) - 1\n  rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n  F%complex_dp_2d(jd1+lb1,jd2+lb2) = cmplx(rhs, 100+rhs)\nenddo; enddo\n', size_var=[], test_value='cmplx(rhs, 100+rhs)'), c_side=c_side_trans_class(c_class='FixedArray2D<Complex, 3, 4>', c_instantiation_suffix='', to_f_setup='  Complex z_complex_dp_2d[3*4]; matrix_to_vec(C.complex_dp_2d, z_complex_dp_2d);\n', to_f_cleanup='', to_f2_arg='c_ComplexArr', to_f2_call='z_complex_dp_2d', to_c2_arg='c_ComplexArr z_complex_dp_2d', to_c2_set='  C.complex_dp_2d << z_complex_dp_2d;', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_2d, y.complex_dp_2d);\n', test_pat='  for (size_t i = 0; i < C.complex_dp_2d.size(); i++)  for (size_t j = 0; j < C.complex_dp_2d[0].size(); j++) \n    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.complex_dp_2d[i][j] = Complex(rhs, 100+rhs);}', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_2d, type: FixedArray2D<Complex
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
                //     throw std::runtime_error("Expected a list of lists of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_3d: NOT arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_3d', c_name='complex_dp_3d', type='complex', kind='dp', pointer_type='NOT', array=['3', '4', '5'], lbound=['1', '1', '1'], ubound=['3', '4', '5'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='tensor2vec(F%complex_dp_3d, 3*4*5)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_3d(*)', to_c2_f2_sub_arg='z_complex_dp_3d', to_f2_type='complex(c_double_complex)', to_f2_name='z_complex_dp_3d(*)', to_f2_trans='call vec2tensor(z_complex_dp_3d, F%complex_dp_3d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%complex_dp_3d == f2%complex_dp_3d)\n', test_pat='do jd1 = 1, size(F%complex_dp_3d,1); lb1 = lbound(F%complex_dp_3d,1) - 1\ndo jd2 = 1, size(F%complex_dp_3d,2); lb2 = lbound(F%complex_dp_3d,2) - 1\ndo jd3 = 1, size(F%complex_dp_3d,3); lb3 = lbound(F%complex_dp_3d,3) - 1\n  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n  F%complex_dp_3d(jd1+lb1,jd2+lb2,jd3+lb3) = cmplx(rhs, 100+rhs)\nenddo; enddo; enddo\n', size_var=[], test_value='cmplx(rhs, 100+rhs)'), c_side=c_side_trans_class(c_class='FixedArray3D<Complex, 3, 4, 5>', c_instantiation_suffix='', to_f_setup='  Complex z_complex_dp_3d[3*4*5]; tensor_to_vec(C.complex_dp_3d, z_complex_dp_3d);\n', to_f_cleanup='', to_f2_arg='c_ComplexArr', to_f2_call='z_complex_dp_3d', to_c2_arg='c_ComplexArr z_complex_dp_3d', to_c2_set='  C.complex_dp_3d << z_complex_dp_3d;', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_3d, y.complex_dp_3d);\n', test_pat='  for (size_t i = 0; i < C.complex_dp_3d.size(); i++)  for (size_t j = 0; j < C.complex_dp_3d[0].size(); j++)   for (size_t k = 0; k < C.complex_dp_3d[0][0].size(); k++)\n    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; C.complex_dp_3d[i][j][k] = Complex(rhs, 100+rhs);}', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_3d, type: FixedArray3D<Complex
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
        // CPP_all_encompassing.complex_dp_0d_ptr: PTR arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_0d_ptr', c_name='complex_dp_0d_ptr', type='complex', kind='dp', pointer_type='PTR', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n_complex_dp_0d_ptr = 0\nif (associated(F%complex_dp_0d_ptr)) n_complex_dp_0d_ptr = 1\n', to_c2_call='F%complex_dp_0d_ptr', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_0d_ptr', to_c2_f2_sub_arg='z_complex_dp_0d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_complex_dp_0d_ptr', to_f2_trans='if (n_complex_dp_0d_ptr == 0) then                                                                                  \n  if (associated(F%complex_dp_0d_ptr)) deallocate(F%complex_dp_0d_ptr)                                                           \nelse                                                                                                   \n  call c_f_pointer (z_complex_dp_0d_ptr, f_complex_dp_0d_ptr)                                                                    \n  if (.not. associated(F%complex_dp_0d_ptr)) allocate(F%complex_dp_0d_ptr)                                                       \n  F%complex_dp_0d_ptr = f_complex_dp_0d_ptr\nendif                                                                                                  \n', to_f2_var=['complex(c_double_complex), pointer :: f_complex_dp_0d_ptr'], equality_test='\nis_eq = is_eq .and. (associated(f1%complex_dp_0d_ptr) .eqv. associated(f2%complex_dp_0d_ptr))\nif (.not. is_eq) return\nif (associated(f1%complex_dp_0d_ptr)) is_eq = (f1%complex_dp_0d_ptr == f2%complex_dp_0d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%complex_dp_0d_ptr)) deallocate (F%complex_dp_0d_ptr)\nelse\n  if (.not. associated(F%complex_dp_0d_ptr)) allocate (F%complex_dp_0d_ptr)\n  rhs = ARGIDX + offset\n  F%complex_dp_0d_ptr = cmplx(rhs, 100+rhs)\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='shared_ptr<Complex>', c_instantiation_suffix='', to_f_setup='  size_t n_complex_dp_0d_ptr = 0; if (C.complex_dp_0d_ptr != nullptr) n_complex_dp_0d_ptr = 1;\n', to_f_cleanup='', to_f2_arg='c_ComplexArr', to_f2_call='C.complex_dp_0d_ptr.get()', to_c2_arg='c_ComplexArr z_complex_dp_0d_ptr', to_c2_set='  if (n_complex_dp_0d_ptr == 0) {\n    C.complex_dp_0d_ptr = nullptr;\n  } else {\n    C.complex_dp_0d_ptr = make_shared<Complex>();\n    *C.complex_dp_0d_ptr = *z_complex_dp_0d_ptr;\n  }\n', class_initializer='nullptr', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && ((x.complex_dp_0d_ptr == NULL) == (y.complex_dp_0d_ptr == NULL));\n  if (!is_eq) return false;\n  if (x.complex_dp_0d_ptr != NULL) is_eq = (*x.complex_dp_0d_ptr == *y.complex_dp_0d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.complex_dp_0d_ptr = nullptr;\n  else {\n    C.complex_dp_0d_ptr = make_shared<Complex>();\n    rhs = ARGIDX + offset; (*C.complex_dp_0d_ptr) = Complex(rhs, 100+rhs);\n  }', test_value='Complex(rhs, 100+rhs)'), split_line=['complex_dp_0d_ptr'], intent='', optional=False)
        // PTR
        .def_property_readonly("complex_dp_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.complex_dp_0d_ptr ? py::cast(*self.complex_dp_0d_ptr) : py::none(); },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_1d_ptr: PTR arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_1d_ptr', c_name='complex_dp_1d_ptr', type='complex', kind='dp', pointer_type='PTR', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_complex_dp_1d_ptr = 0\nif (associated(F%complex_dp_1d_ptr)) then\n  n1_complex_dp_1d_ptr = size(F%complex_dp_1d_ptr, 1)\nendif\n', to_c2_call='fvec2vec(F%complex_dp_1d_ptr, n1_complex_dp_1d_ptr)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_1d_ptr(*)', to_c2_f2_sub_arg='z_complex_dp_1d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_complex_dp_1d_ptr', to_f2_trans='if (associated(F%complex_dp_1d_ptr)) then\n  if (n1_complex_dp_1d_ptr == 0 .or. any(shape(F%complex_dp_1d_ptr) /= [n1_complex_dp_1d_ptr])) deallocate(F%complex_dp_1d_ptr)\n  if (any(lbound(F%complex_dp_1d_ptr) /= 1)) deallocate(F%complex_dp_1d_ptr)\nendif\nif (n1_complex_dp_1d_ptr /= 0) then\n  call c_f_pointer (z_complex_dp_1d_ptr, f_complex_dp_1d_ptr, [n1_complex_dp_1d_ptr])\n  if (.not. associated(F%complex_dp_1d_ptr)) allocate(F%complex_dp_1d_ptr(n1_complex_dp_1d_ptr))\n  F%complex_dp_1d_ptr = f_complex_dp_1d_ptr(1:n1_complex_dp_1d_ptr)\nelse\n  if (associated(F%complex_dp_1d_ptr)) deallocate(F%complex_dp_1d_ptr)\nendif\n', to_f2_var=['complex(c_double_complex), pointer :: f_complex_dp_1d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%complex_dp_1d_ptr) .eqv. associated(f2%complex_dp_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%complex_dp_1d_ptr)) is_eq = all(shape(f1%complex_dp_1d_ptr) == shape(f2%complex_dp_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%complex_dp_1d_ptr)) is_eq = all(f1%complex_dp_1d_ptr == f2%complex_dp_1d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%complex_dp_1d_ptr)) deallocate (F%complex_dp_1d_ptr)\nelse\n  if (.not. associated(F%complex_dp_1d_ptr)) allocate (F%complex_dp_1d_ptr(-1:1))\n  do jd1 = 1, size(F%complex_dp_1d_ptr,1); lb1 = lbound(F%complex_dp_1d_ptr,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%complex_dp_1d_ptr(jd1+lb1) = cmplx(rhs, 100+rhs)\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Complex>', c_instantiation_suffix='', to_f_setup='  auto n1_complex_dp_1d_ptr = C.complex_dp_1d_ptr.size();\n  c_ComplexArr z_complex_dp_1d_ptr = nullptr;\n  if (n1_complex_dp_1d_ptr > 0) {\n    z_complex_dp_1d_ptr = &C.complex_dp_1d_ptr[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_ComplexArr', to_f2_call='z_complex_dp_1d_ptr', to_c2_arg='c_ComplexArr z_complex_dp_1d_ptr', to_c2_set='\n  C.complex_dp_1d_ptr.resize(n1_complex_dp_1d_ptr);\n  C.complex_dp_1d_ptr << z_complex_dp_1d_ptr;\n', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_1d_ptr, y.complex_dp_1d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.complex_dp_1d_ptr.resize(0);\n  else {\n    C.complex_dp_1d_ptr.resize(3);\n    for (size_t i = 0; i < C.complex_dp_1d_ptr.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.complex_dp_1d_ptr[i] = Complex(rhs, 100+rhs);}  }\n', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_1d_ptr, type: VariableArray1D<Complex>
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_dp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_2d_ptr: PTR arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_2d_ptr', c_name='complex_dp_2d_ptr', type='complex', kind='dp', pointer_type='PTR', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%complex_dp_2d_ptr)) then\n  n1_complex_dp_2d_ptr = size(F%complex_dp_2d_ptr, 1)\n  n2_complex_dp_2d_ptr = size(F%complex_dp_2d_ptr, 2)\nelse\n  n1_complex_dp_2d_ptr = 0; n2_complex_dp_2d_ptr = 0\nendif\n', to_c2_call='mat2vec(F%complex_dp_2d_ptr, n1_complex_dp_2d_ptr*n2_complex_dp_2d_ptr)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_2d_ptr(*)', to_c2_f2_sub_arg='z_complex_dp_2d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_complex_dp_2d_ptr', to_f2_trans='if (associated(F%complex_dp_2d_ptr)) then\n  if (n1_complex_dp_2d_ptr == 0 .or. any(shape(F%complex_dp_2d_ptr) /= [n1_complex_dp_2d_ptr, n2_complex_dp_2d_ptr])) deallocate(F%complex_dp_2d_ptr)\n  if (any(lbound(F%complex_dp_2d_ptr) /= 1)) deallocate(F%complex_dp_2d_ptr)\nendif\nif (n1_complex_dp_2d_ptr /= 0) then\n  call c_f_pointer (z_complex_dp_2d_ptr, f_complex_dp_2d_ptr, [n1_complex_dp_2d_ptr*n2_complex_dp_2d_ptr])\n  if (.not. associated(F%complex_dp_2d_ptr)) allocate(F%complex_dp_2d_ptr(n1_complex_dp_2d_ptr, n2_complex_dp_2d_ptr))\n  call vec2mat(f_complex_dp_2d_ptr, F%complex_dp_2d_ptr)\nelse\n  if (associated(F%complex_dp_2d_ptr)) deallocate(F%complex_dp_2d_ptr)\nendif\n', to_f2_var=['complex(c_double_complex), pointer :: f_complex_dp_2d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%complex_dp_2d_ptr) .eqv. associated(f2%complex_dp_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%complex_dp_2d_ptr)) is_eq = all(shape(f1%complex_dp_2d_ptr) == shape(f2%complex_dp_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%complex_dp_2d_ptr)) is_eq = all(f1%complex_dp_2d_ptr == f2%complex_dp_2d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%complex_dp_2d_ptr)) deallocate (F%complex_dp_2d_ptr)\nelse\n  if (.not. associated(F%complex_dp_2d_ptr)) allocate (F%complex_dp_2d_ptr(-1:1, 2))\n  do jd1 = 1, size(F%complex_dp_2d_ptr,1); lb1 = lbound(F%complex_dp_2d_ptr,1) - 1\n  do jd2 = 1, size(F%complex_dp_2d_ptr,2); lb2 = lbound(F%complex_dp_2d_ptr,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%complex_dp_2d_ptr(jd1+lb1,jd2+lb2) = cmplx(rhs, 100+rhs)\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Complex>', c_instantiation_suffix='', to_f_setup='  auto n1_complex_dp_2d_ptr { C.complex_dp_2d_ptr.size() };\n  auto n2_complex_dp_2d_ptr { std::size_t{0} };\n  Complex* z_complex_dp_2d_ptr = nullptr;\n  if (n1_complex_dp_2d_ptr > 0) {\n    n2_complex_dp_2d_ptr = C.complex_dp_2d_ptr[0].size();\n    z_complex_dp_2d_ptr = new Complex [n1_complex_dp_2d_ptr*n2_complex_dp_2d_ptr];\n    matrix_to_vec (C.complex_dp_2d_ptr, z_complex_dp_2d_ptr);\n  }\n', to_f_cleanup='  if (z_complex_dp_2d_ptr) delete[] z_complex_dp_2d_ptr;\n', to_f2_arg='c_ComplexArr', to_f2_call='z_complex_dp_2d_ptr', to_c2_arg='c_ComplexArr z_complex_dp_2d_ptr', to_c2_set='  C.complex_dp_2d_ptr.resize(n1_complex_dp_2d_ptr);\n  for (auto i{0}; i < n1_complex_dp_2d_ptr; i++) C.complex_dp_2d_ptr[i].resize(n2_complex_dp_2d_ptr);\n  C.complex_dp_2d_ptr << z_complex_dp_2d_ptr;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_2d_ptr, y.complex_dp_2d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.complex_dp_2d_ptr.resize(0);\n  else {\n    C.complex_dp_2d_ptr.resize(3);\n    for (size_t i = 0; i < C.complex_dp_2d_ptr.size(); i++)\n      C.complex_dp_2d_ptr[i].resize(2);\n    for (size_t i = 0; i < C.complex_dp_2d_ptr.size(); i++)  for (size_t j = 0; j < C.complex_dp_2d_ptr[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.complex_dp_2d_ptr[i][j] = Complex(rhs, 100+rhs);}  }\n', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_2d_ptr, type: VariableArray2D<Complex>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_3d_ptr: PTR arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_3d_ptr', c_name='complex_dp_3d_ptr', type='complex', kind='dp', pointer_type='PTR', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%complex_dp_3d_ptr)) then\n  n1_complex_dp_3d_ptr = size(F%complex_dp_3d_ptr, 1)\n  n2_complex_dp_3d_ptr = size(F%complex_dp_3d_ptr, 2)\n  n3_complex_dp_3d_ptr = size(F%complex_dp_3d_ptr, 3)\nelse\n  n1_complex_dp_3d_ptr = 0; n2_complex_dp_3d_ptr = 0; n3_complex_dp_3d_ptr = 0\nendif\n', to_c2_call='tensor2vec(F%complex_dp_3d_ptr, n1_complex_dp_3d_ptr*n2_complex_dp_3d_ptr*n3_complex_dp_3d_ptr)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_3d_ptr(*)', to_c2_f2_sub_arg='z_complex_dp_3d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_complex_dp_3d_ptr', to_f2_trans='if (associated(F%complex_dp_3d_ptr)) then\n  if (n1_complex_dp_3d_ptr == 0 .or. any(shape(F%complex_dp_3d_ptr) /= [n1_complex_dp_3d_ptr, n2_complex_dp_3d_ptr, n3_complex_dp_3d_ptr])) deallocate(F%complex_dp_3d_ptr)\n  if (any(lbound(F%complex_dp_3d_ptr) /= 1)) deallocate(F%complex_dp_3d_ptr)\nendif\nif (n1_complex_dp_3d_ptr /= 0) then\n  call c_f_pointer (z_complex_dp_3d_ptr, f_complex_dp_3d_ptr, [n1_complex_dp_3d_ptr*n2_complex_dp_3d_ptr*n3_complex_dp_3d_ptr])\n  if (.not. associated(F%complex_dp_3d_ptr)) allocate(F%complex_dp_3d_ptr(n1_complex_dp_3d_ptr, n2_complex_dp_3d_ptr, n3_complex_dp_3d_ptr))\n  call vec2tensor(f_complex_dp_3d_ptr, F%complex_dp_3d_ptr)\nelse\n  if (associated(F%complex_dp_3d_ptr)) deallocate(F%complex_dp_3d_ptr)\nendif\n', to_f2_var=['complex(c_double_complex), pointer :: f_complex_dp_3d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%complex_dp_3d_ptr) .eqv. associated(f2%complex_dp_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%complex_dp_3d_ptr)) is_eq = all(shape(f1%complex_dp_3d_ptr) == shape(f2%complex_dp_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%complex_dp_3d_ptr)) is_eq = all(f1%complex_dp_3d_ptr == f2%complex_dp_3d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%complex_dp_3d_ptr)) deallocate (F%complex_dp_3d_ptr)\nelse\n  if (.not. associated(F%complex_dp_3d_ptr)) allocate (F%complex_dp_3d_ptr(-1:1, 2, 1))\n  do jd1 = 1, size(F%complex_dp_3d_ptr,1); lb1 = lbound(F%complex_dp_3d_ptr,1) - 1\n  do jd2 = 1, size(F%complex_dp_3d_ptr,2); lb2 = lbound(F%complex_dp_3d_ptr,2) - 1\n  do jd3 = 1, size(F%complex_dp_3d_ptr,3); lb3 = lbound(F%complex_dp_3d_ptr,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%complex_dp_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = cmplx(rhs, 100+rhs)\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Complex>', c_instantiation_suffix='', to_f_setup='\n  auto n1_complex_dp_3d_ptr { C.complex_dp_3d_ptr.size() };\n  auto n2_complex_dp_3d_ptr { std::size_t{0} };\n  auto n3_complex_dp_3d_ptr { std::size_t{0} };\n  Complex* z_complex_dp_3d_ptr { nullptr };\n  if (n1_complex_dp_3d_ptr > 0) {\n    n2_complex_dp_3d_ptr = C.complex_dp_3d_ptr[0].size();\n    n3_complex_dp_3d_ptr = C.complex_dp_3d_ptr[0][0].size();\n    z_complex_dp_3d_ptr = new Complex [C.complex_dp_3d_ptr.size()*C.complex_dp_3d_ptr[0].size()*C.complex_dp_3d_ptr[0][0].size()];\n    tensor_to_vec (C.complex_dp_3d_ptr, z_complex_dp_3d_ptr);\n  }\n', to_f_cleanup='  if (z_complex_dp_3d_ptr) delete[] z_complex_dp_3d_ptr;\n', to_f2_arg='c_ComplexArr', to_f2_call='z_complex_dp_3d_ptr', to_c2_arg='c_ComplexArr z_complex_dp_3d_ptr', to_c2_set='  C.complex_dp_3d_ptr.resize(n1_complex_dp_3d_ptr);\n  for (size_t i = 0; i < C.complex_dp_3d_ptr.size(); i++) {\n    C.complex_dp_3d_ptr[i].resize(n2_complex_dp_3d_ptr);\n    for (size_t j = 0; j < C.complex_dp_3d_ptr[0].size(); j++)\n      C.complex_dp_3d_ptr[i][j].resize(n3_complex_dp_3d_ptr);\n  }\n  C.complex_dp_3d_ptr << z_complex_dp_3d_ptr;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_3d_ptr, y.complex_dp_3d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.complex_dp_3d_ptr.resize(0);\n  else {\n    C.complex_dp_3d_ptr.resize(3);\n    for (size_t i = 0; i < C.complex_dp_3d_ptr.size(); i++) {\n      C.complex_dp_3d_ptr[i].resize(2);\n      for (size_t j = 0; j < C.complex_dp_3d_ptr[0].size(); j++) {\n        C.complex_dp_3d_ptr[i][j].resize(1);\n        for (size_t k = 0; k < C.complex_dp_3d_ptr[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.complex_dp_3d_ptr[i][j][k] = Complex(rhs, 100+rhs);\n        }\n      }\n    }\n  }\n', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_3d_ptr, type: VariableArray3D<Complex>
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
        // CPP_all_encompassing.complex_dp_1d_alloc: ALLOC arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_1d_alloc', c_name='complex_dp_1d_alloc', type='complex', kind='dp', pointer_type='ALLOC', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_complex_dp_1d_alloc = 0\nif (allocated(F%complex_dp_1d_alloc)) then\n  n1_complex_dp_1d_alloc = size(F%complex_dp_1d_alloc, 1)\nendif\n', to_c2_call='fvec2vec(F%complex_dp_1d_alloc, n1_complex_dp_1d_alloc)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_1d_alloc(*)', to_c2_f2_sub_arg='z_complex_dp_1d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_complex_dp_1d_alloc', to_f2_trans='if (allocated(F%complex_dp_1d_alloc)) then\n  if (n1_complex_dp_1d_alloc == 0 .or. any(shape(F%complex_dp_1d_alloc) /= [n1_complex_dp_1d_alloc])) deallocate(F%complex_dp_1d_alloc)\n  if (any(lbound(F%complex_dp_1d_alloc) /= 1)) deallocate(F%complex_dp_1d_alloc)\nendif\nif (n1_complex_dp_1d_alloc /= 0) then\n  call c_f_pointer (z_complex_dp_1d_alloc, f_complex_dp_1d_alloc, [n1_complex_dp_1d_alloc])\n  if (.not. allocated(F%complex_dp_1d_alloc)) allocate(F%complex_dp_1d_alloc(n1_complex_dp_1d_alloc))\n  F%complex_dp_1d_alloc = f_complex_dp_1d_alloc(1:n1_complex_dp_1d_alloc)\nelse\n  if (allocated(F%complex_dp_1d_alloc)) deallocate(F%complex_dp_1d_alloc)\nendif\n', to_f2_var=['complex(c_double_complex), pointer :: f_complex_dp_1d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%complex_dp_1d_alloc) .eqv. allocated(f2%complex_dp_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%complex_dp_1d_alloc)) is_eq = all(shape(f1%complex_dp_1d_alloc) == shape(f2%complex_dp_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%complex_dp_1d_alloc)) is_eq = all(f1%complex_dp_1d_alloc == f2%complex_dp_1d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%complex_dp_1d_alloc)) deallocate (F%complex_dp_1d_alloc)\nelse\n  if (.not. allocated(F%complex_dp_1d_alloc)) allocate (F%complex_dp_1d_alloc(-1:1))\n  do jd1 = 1, size(F%complex_dp_1d_alloc,1); lb1 = lbound(F%complex_dp_1d_alloc,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%complex_dp_1d_alloc(jd1+lb1) = cmplx(rhs, 100+rhs)\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Complex>', c_instantiation_suffix='', to_f_setup='  auto n1_complex_dp_1d_alloc = C.complex_dp_1d_alloc.size();\n  c_ComplexArr z_complex_dp_1d_alloc = nullptr;\n  if (n1_complex_dp_1d_alloc > 0) {\n    z_complex_dp_1d_alloc = &C.complex_dp_1d_alloc[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_ComplexArr', to_f2_call='z_complex_dp_1d_alloc', to_c2_arg='c_ComplexArr z_complex_dp_1d_alloc', to_c2_set='\n  C.complex_dp_1d_alloc.resize(n1_complex_dp_1d_alloc);\n  C.complex_dp_1d_alloc << z_complex_dp_1d_alloc;\n', class_initializer='{ 0.0 }', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_1d_alloc, y.complex_dp_1d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.complex_dp_1d_alloc.resize(0);\n  else {\n    C.complex_dp_1d_alloc.resize(3);\n    for (size_t i = 0; i < C.complex_dp_1d_alloc.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.complex_dp_1d_alloc[i] = Complex(rhs, 100+rhs);}  }\n', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_1d_alloc, type: VariableArray1D<Complex>
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_dp>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_2d_alloc: ALLOC arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_2d_alloc', c_name='complex_dp_2d_alloc', type='complex', kind='dp', pointer_type='ALLOC', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%complex_dp_2d_alloc)) then\n  n1_complex_dp_2d_alloc = size(F%complex_dp_2d_alloc, 1)\n  n2_complex_dp_2d_alloc = size(F%complex_dp_2d_alloc, 2)\nelse\n  n1_complex_dp_2d_alloc = 0; n2_complex_dp_2d_alloc = 0\nendif\n', to_c2_call='mat2vec(F%complex_dp_2d_alloc, n1_complex_dp_2d_alloc*n2_complex_dp_2d_alloc)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_2d_alloc(*)', to_c2_f2_sub_arg='z_complex_dp_2d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_complex_dp_2d_alloc', to_f2_trans='if (allocated(F%complex_dp_2d_alloc)) then\n  if (n1_complex_dp_2d_alloc == 0 .or. any(shape(F%complex_dp_2d_alloc) /= [n1_complex_dp_2d_alloc, n2_complex_dp_2d_alloc])) deallocate(F%complex_dp_2d_alloc)\n  if (any(lbound(F%complex_dp_2d_alloc) /= 1)) deallocate(F%complex_dp_2d_alloc)\nendif\nif (n1_complex_dp_2d_alloc /= 0) then\n  call c_f_pointer (z_complex_dp_2d_alloc, f_complex_dp_2d_alloc, [n1_complex_dp_2d_alloc*n2_complex_dp_2d_alloc])\n  if (.not. allocated(F%complex_dp_2d_alloc)) allocate(F%complex_dp_2d_alloc(n1_complex_dp_2d_alloc, n2_complex_dp_2d_alloc))\n  call vec2mat(f_complex_dp_2d_alloc, F%complex_dp_2d_alloc)\nelse\n  if (allocated(F%complex_dp_2d_alloc)) deallocate(F%complex_dp_2d_alloc)\nendif\n', to_f2_var=['complex(c_double_complex), pointer :: f_complex_dp_2d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%complex_dp_2d_alloc) .eqv. allocated(f2%complex_dp_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%complex_dp_2d_alloc)) is_eq = all(shape(f1%complex_dp_2d_alloc) == shape(f2%complex_dp_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%complex_dp_2d_alloc)) is_eq = all(f1%complex_dp_2d_alloc == f2%complex_dp_2d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%complex_dp_2d_alloc)) deallocate (F%complex_dp_2d_alloc)\nelse\n  if (.not. allocated(F%complex_dp_2d_alloc)) allocate (F%complex_dp_2d_alloc(-1:1, 2))\n  do jd1 = 1, size(F%complex_dp_2d_alloc,1); lb1 = lbound(F%complex_dp_2d_alloc,1) - 1\n  do jd2 = 1, size(F%complex_dp_2d_alloc,2); lb2 = lbound(F%complex_dp_2d_alloc,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%complex_dp_2d_alloc(jd1+lb1,jd2+lb2) = cmplx(rhs, 100+rhs)\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Complex>', c_instantiation_suffix='', to_f_setup='  auto n1_complex_dp_2d_alloc { C.complex_dp_2d_alloc.size() };\n  auto n2_complex_dp_2d_alloc { std::size_t{0} };\n  Complex* z_complex_dp_2d_alloc = nullptr;\n  if (n1_complex_dp_2d_alloc > 0) {\n    n2_complex_dp_2d_alloc = C.complex_dp_2d_alloc[0].size();\n    z_complex_dp_2d_alloc = new Complex [n1_complex_dp_2d_alloc*n2_complex_dp_2d_alloc];\n    matrix_to_vec (C.complex_dp_2d_alloc, z_complex_dp_2d_alloc);\n  }\n', to_f_cleanup='  if (z_complex_dp_2d_alloc) delete[] z_complex_dp_2d_alloc;\n', to_f2_arg='c_ComplexArr', to_f2_call='z_complex_dp_2d_alloc', to_c2_arg='c_ComplexArr z_complex_dp_2d_alloc', to_c2_set='  C.complex_dp_2d_alloc.resize(n1_complex_dp_2d_alloc);\n  for (auto i{0}; i < n1_complex_dp_2d_alloc; i++) C.complex_dp_2d_alloc[i].resize(n2_complex_dp_2d_alloc);\n  C.complex_dp_2d_alloc << z_complex_dp_2d_alloc;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_2d_alloc, y.complex_dp_2d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.complex_dp_2d_alloc.resize(0);\n  else {\n    C.complex_dp_2d_alloc.resize(3);\n    for (size_t i = 0; i < C.complex_dp_2d_alloc.size(); i++)\n      C.complex_dp_2d_alloc[i].resize(2);\n    for (size_t i = 0; i < C.complex_dp_2d_alloc.size(); i++)  for (size_t j = 0; j < C.complex_dp_2d_alloc[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.complex_dp_2d_alloc[i][j] = Complex(rhs, 100+rhs);}  }\n', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_2d_alloc, type: VariableArray2D<Complex>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_dp objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.complex_dp_3d_alloc: ALLOC arg.kind='dp' arg=Argument(is_component=True, f_name='complex_dp_3d_alloc', c_name='complex_dp_3d_alloc', type='complex', kind='dp', pointer_type='ALLOC', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%complex_dp_3d_alloc)) then\n  n1_complex_dp_3d_alloc = size(F%complex_dp_3d_alloc, 1)\n  n2_complex_dp_3d_alloc = size(F%complex_dp_3d_alloc, 2)\n  n3_complex_dp_3d_alloc = size(F%complex_dp_3d_alloc, 3)\nelse\n  n1_complex_dp_3d_alloc = 0; n2_complex_dp_3d_alloc = 0; n3_complex_dp_3d_alloc = 0\nendif\n', to_c2_call='tensor2vec(F%complex_dp_3d_alloc, n1_complex_dp_3d_alloc*n2_complex_dp_3d_alloc*n3_complex_dp_3d_alloc)', to_c2_type='complex(c_double_complex)', to_c2_name='z_complex_dp_3d_alloc(*)', to_c2_f2_sub_arg='z_complex_dp_3d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_complex_dp_3d_alloc', to_f2_trans='if (allocated(F%complex_dp_3d_alloc)) then\n  if (n1_complex_dp_3d_alloc == 0 .or. any(shape(F%complex_dp_3d_alloc) /= [n1_complex_dp_3d_alloc, n2_complex_dp_3d_alloc, n3_complex_dp_3d_alloc])) deallocate(F%complex_dp_3d_alloc)\n  if (any(lbound(F%complex_dp_3d_alloc) /= 1)) deallocate(F%complex_dp_3d_alloc)\nendif\nif (n1_complex_dp_3d_alloc /= 0) then\n  call c_f_pointer (z_complex_dp_3d_alloc, f_complex_dp_3d_alloc, [n1_complex_dp_3d_alloc*n2_complex_dp_3d_alloc*n3_complex_dp_3d_alloc])\n  if (.not. allocated(F%complex_dp_3d_alloc)) allocate(F%complex_dp_3d_alloc(n1_complex_dp_3d_alloc, n2_complex_dp_3d_alloc, n3_complex_dp_3d_alloc))\n  call vec2tensor(f_complex_dp_3d_alloc, F%complex_dp_3d_alloc)\nelse\n  if (allocated(F%complex_dp_3d_alloc)) deallocate(F%complex_dp_3d_alloc)\nendif\n', to_f2_var=['complex(c_double_complex), pointer :: f_complex_dp_3d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%complex_dp_3d_alloc) .eqv. allocated(f2%complex_dp_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%complex_dp_3d_alloc)) is_eq = all(shape(f1%complex_dp_3d_alloc) == shape(f2%complex_dp_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%complex_dp_3d_alloc)) is_eq = all(f1%complex_dp_3d_alloc == f2%complex_dp_3d_alloc)\n', test_pat='if (ix_patt < 3) then\n  if (allocated(F%complex_dp_3d_alloc)) deallocate (F%complex_dp_3d_alloc)\nelse\n  if (.not. allocated(F%complex_dp_3d_alloc)) allocate (F%complex_dp_3d_alloc(-1:1, 2, 1))\n  do jd1 = 1, size(F%complex_dp_3d_alloc,1); lb1 = lbound(F%complex_dp_3d_alloc,1) - 1\n  do jd2 = 1, size(F%complex_dp_3d_alloc,2); lb2 = lbound(F%complex_dp_3d_alloc,2) - 1\n  do jd3 = 1, size(F%complex_dp_3d_alloc,3); lb3 = lbound(F%complex_dp_3d_alloc,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%complex_dp_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = cmplx(rhs, 100+rhs)\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Complex>', c_instantiation_suffix='', to_f_setup='\n  auto n1_complex_dp_3d_alloc { C.complex_dp_3d_alloc.size() };\n  auto n2_complex_dp_3d_alloc { std::size_t{0} };\n  auto n3_complex_dp_3d_alloc { std::size_t{0} };\n  Complex* z_complex_dp_3d_alloc { nullptr };\n  if (n1_complex_dp_3d_alloc > 0) {\n    n2_complex_dp_3d_alloc = C.complex_dp_3d_alloc[0].size();\n    n3_complex_dp_3d_alloc = C.complex_dp_3d_alloc[0][0].size();\n    z_complex_dp_3d_alloc = new Complex [C.complex_dp_3d_alloc.size()*C.complex_dp_3d_alloc[0].size()*C.complex_dp_3d_alloc[0][0].size()];\n    tensor_to_vec (C.complex_dp_3d_alloc, z_complex_dp_3d_alloc);\n  }\n', to_f_cleanup='  if (z_complex_dp_3d_alloc) delete[] z_complex_dp_3d_alloc;\n', to_f2_arg='c_ComplexArr', to_f2_call='z_complex_dp_3d_alloc', to_c2_arg='c_ComplexArr z_complex_dp_3d_alloc', to_c2_set='  C.complex_dp_3d_alloc.resize(n1_complex_dp_3d_alloc);\n  for (size_t i = 0; i < C.complex_dp_3d_alloc.size(); i++) {\n    C.complex_dp_3d_alloc[i].resize(n2_complex_dp_3d_alloc);\n    for (size_t j = 0; j < C.complex_dp_3d_alloc[0].size(); j++)\n      C.complex_dp_3d_alloc[i][j].resize(n3_complex_dp_3d_alloc);\n  }\n  C.complex_dp_3d_alloc << z_complex_dp_3d_alloc;\n', class_initializer='', construct_value='0.0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.complex_dp_3d_alloc, y.complex_dp_3d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.complex_dp_3d_alloc.resize(0);\n  else {\n    C.complex_dp_3d_alloc.resize(3);\n    for (size_t i = 0; i < C.complex_dp_3d_alloc.size(); i++) {\n      C.complex_dp_3d_alloc[i].resize(2);\n      for (size_t j = 0; j < C.complex_dp_3d_alloc[0].size(); j++) {\n        C.complex_dp_3d_alloc[i][j].resize(1);\n        for (size_t k = 0; k < C.complex_dp_3d_alloc[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.complex_dp_3d_alloc[i][j][k] = Complex(rhs, 100+rhs);\n        }\n      }\n    }\n  }\n', test_value='Complex(rhs, 100+rhs)'), split_line=[], intent='', optional=False)
        // Array property: complex_dp_3d_alloc, type: VariableArray3D<Complex>
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
        // CPP_all_encompassing.int_0d: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_0d', c_name='int_0d', type='integer', kind='', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%int_0d', to_c2_type='integer(c_int)', to_c2_name='z_int_0d', to_c2_f2_sub_arg='z_int_0d', to_f2_type='integer(c_int)', to_f2_name='z_int_0d', to_f2_trans='F%int_0d = z_int_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%int_0d == f2%int_0d)\n', test_pat='rhs = ARGIDX + offset; F%int_0d = rhs\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='Int', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Int&', to_f2_call='C.int_0d', to_c2_arg='c_Int& z_int_0d', to_c2_set='  C.int_0d = z_int_0d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int_0d == y.int_0d);\n', test_pat='  rhs = ARGIDX + offset; C.int_0d = rhs;\n', test_value='rhs'), split_line=['int_0d'], intent='', optional=False)
        // [default case]
        .def_property_readonly("int_0d",
            [](const CPP_all_encompassing &self) { return self.int_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_1d: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_1d', c_name='int_1d', type='integer', kind='', pointer_type='NOT', array=['3'], lbound=['1'], ubound=['3'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='fvec2vec(F%int_1d, 3)', to_c2_type='integer(c_int)', to_c2_name='z_int_1d(*)', to_c2_f2_sub_arg='z_int_1d', to_f2_type='integer(c_int)', to_f2_name='z_int_1d(*)', to_f2_trans='F%int_1d = z_int_1d(1:3)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_1d == f2%int_1d)\n', test_pat='do jd1 = 1, size(F%int_1d,1); lb1 = lbound(F%int_1d,1) - 1\n  rhs = 100 + jd1 + ARGIDX + offset\n  F%int_1d(jd1+lb1) = rhs\nenddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray1D<Int, 3>', c_instantiation_suffix='{VALUE}', to_f_setup='', to_f_cleanup='', to_f2_arg='c_IntArr', to_f2_call='&C.int_1d[0]', to_c2_arg='c_IntArr z_int_1d', to_c2_set='  C.int_1d << z_int_1d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_1d, y.int_1d);\n', test_pat='  for (size_t i = 0; i < C.int_1d.size(); i++)\n    {int rhs = 101 + i + ARGIDX + offset; C.int_1d[i] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_1d, type: FixedArray1D<Int
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
        // CPP_all_encompassing.int_2d: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_2d', c_name='int_2d', type='integer', kind='', pointer_type='NOT', array=['3', '4'], lbound=['1', '1'], ubound=['3', '4'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='mat2vec(F%int_2d, 3*4)', to_c2_type='integer(c_int)', to_c2_name='z_int_2d(*)', to_c2_f2_sub_arg='z_int_2d', to_f2_type='integer(c_int)', to_f2_name='z_int_2d(*)', to_f2_trans='call vec2mat(z_int_2d, F%int_2d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_2d == f2%int_2d)\n', test_pat='do jd1 = 1, size(F%int_2d,1); lb1 = lbound(F%int_2d,1) - 1\ndo jd2 = 1, size(F%int_2d,2); lb2 = lbound(F%int_2d,2) - 1\n  rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n  F%int_2d(jd1+lb1,jd2+lb2) = rhs\nenddo; enddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray2D<Int, 3, 4>', c_instantiation_suffix='', to_f_setup='  Int z_int_2d[3*4]; matrix_to_vec(C.int_2d, z_int_2d);\n', to_f_cleanup='', to_f2_arg='c_IntArr', to_f2_call='z_int_2d', to_c2_arg='c_IntArr z_int_2d', to_c2_set='  C.int_2d << z_int_2d;', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_2d, y.int_2d);\n', test_pat='  for (size_t i = 0; i < C.int_2d.size(); i++)  for (size_t j = 0; j < C.int_2d[0].size(); j++) \n    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.int_2d[i][j] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_2d, type: FixedArray2D<Int
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
        // CPP_all_encompassing.int_3d: NOT arg.kind='' arg=Argument(is_component=True, f_name='int_3d', c_name='int_3d', type='integer', kind='', pointer_type='NOT', array=['3', '4', '5'], lbound=['1', '1', '1'], ubound=['3', '4', '5'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='tensor2vec(F%int_3d, 3*4*5)', to_c2_type='integer(c_int)', to_c2_name='z_int_3d(*)', to_c2_f2_sub_arg='z_int_3d', to_f2_type='integer(c_int)', to_f2_name='z_int_3d(*)', to_f2_trans='call vec2tensor(z_int_3d, F%int_3d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int_3d == f2%int_3d)\n', test_pat='do jd1 = 1, size(F%int_3d,1); lb1 = lbound(F%int_3d,1) - 1\ndo jd2 = 1, size(F%int_3d,2); lb2 = lbound(F%int_3d,2) - 1\ndo jd3 = 1, size(F%int_3d,3); lb3 = lbound(F%int_3d,3) - 1\n  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n  F%int_3d(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\nenddo; enddo; enddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray3D<Int, 3, 4, 5>', c_instantiation_suffix='', to_f_setup='  Int z_int_3d[3*4*5]; tensor_to_vec(C.int_3d, z_int_3d);\n', to_f_cleanup='', to_f2_arg='c_IntArr', to_f2_call='z_int_3d', to_c2_arg='c_IntArr z_int_3d', to_c2_set='  C.int_3d << z_int_3d;', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_3d, y.int_3d);\n', test_pat='  for (size_t i = 0; i < C.int_3d.size(); i++)  for (size_t j = 0; j < C.int_3d[0].size(); j++)   for (size_t k = 0; k < C.int_3d[0][0].size(); k++)\n    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; C.int_3d[i][j][k] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_3d, type: FixedArray3D<Int
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
        // CPP_all_encompassing.int_0d_ptr: PTR arg.kind='' arg=Argument(is_component=True, f_name='int_0d_ptr', c_name='int_0d_ptr', type='integer', kind='', pointer_type='PTR', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n_int_0d_ptr = 0\nif (associated(F%int_0d_ptr)) n_int_0d_ptr = 1\n', to_c2_call='F%int_0d_ptr', to_c2_type='integer(c_int)', to_c2_name='z_int_0d_ptr', to_c2_f2_sub_arg='z_int_0d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_int_0d_ptr', to_f2_trans='if (n_int_0d_ptr == 0) then                                                                                  \n  if (associated(F%int_0d_ptr)) deallocate(F%int_0d_ptr)                                                           \nelse                                                                                                   \n  call c_f_pointer (z_int_0d_ptr, f_int_0d_ptr)                                                                    \n  if (.not. associated(F%int_0d_ptr)) allocate(F%int_0d_ptr)                                                       \n  F%int_0d_ptr = f_int_0d_ptr\nendif                                                                                                  \n', to_f2_var=['integer(c_int), pointer :: f_int_0d_ptr'], equality_test='\nis_eq = is_eq .and. (associated(f1%int_0d_ptr) .eqv. associated(f2%int_0d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int_0d_ptr)) is_eq = (f1%int_0d_ptr == f2%int_0d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%int_0d_ptr)) deallocate (F%int_0d_ptr)\nelse\n  if (.not. associated(F%int_0d_ptr)) allocate (F%int_0d_ptr)\n  rhs = ARGIDX + offset\n  F%int_0d_ptr = rhs\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='shared_ptr<Int>', c_instantiation_suffix='', to_f_setup='  size_t n_int_0d_ptr = 0; if (C.int_0d_ptr != nullptr) n_int_0d_ptr = 1;\n', to_f_cleanup='', to_f2_arg='c_IntArr', to_f2_call='C.int_0d_ptr.get()', to_c2_arg='c_IntArr z_int_0d_ptr', to_c2_set='  if (n_int_0d_ptr == 0) {\n    C.int_0d_ptr = nullptr;\n  } else {\n    C.int_0d_ptr = make_shared<Int>();\n    *C.int_0d_ptr = *z_int_0d_ptr;\n  }\n', class_initializer='nullptr', construct_value='0', destructor='', equality_test='  is_eq = is_eq && ((x.int_0d_ptr == NULL) == (y.int_0d_ptr == NULL));\n  if (!is_eq) return false;\n  if (x.int_0d_ptr != NULL) is_eq = (*x.int_0d_ptr == *y.int_0d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.int_0d_ptr = nullptr;\n  else {\n    C.int_0d_ptr = make_shared<Int>();\n    rhs = ARGIDX + offset; (*C.int_0d_ptr) = rhs;\n  }', test_value='rhs'), split_line=['int_0d_ptr'], intent='', optional=False)
        // PTR
        .def_property_readonly("int_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.int_0d_ptr ? py::cast(*self.int_0d_ptr) : py::none(); },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.int_1d_ptr: PTR arg.kind='' arg=Argument(is_component=True, f_name='int_1d_ptr', c_name='int_1d_ptr', type='integer', kind='', pointer_type='PTR', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_int_1d_ptr = 0\nif (associated(F%int_1d_ptr)) then\n  n1_int_1d_ptr = size(F%int_1d_ptr, 1)\nendif\n', to_c2_call='fvec2vec(F%int_1d_ptr, n1_int_1d_ptr)', to_c2_type='integer(c_int)', to_c2_name='z_int_1d_ptr(*)', to_c2_f2_sub_arg='z_int_1d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_int_1d_ptr', to_f2_trans='if (associated(F%int_1d_ptr)) then\n  if (n1_int_1d_ptr == 0 .or. any(shape(F%int_1d_ptr) /= [n1_int_1d_ptr])) deallocate(F%int_1d_ptr)\n  if (any(lbound(F%int_1d_ptr) /= 1)) deallocate(F%int_1d_ptr)\nendif\nif (n1_int_1d_ptr /= 0) then\n  call c_f_pointer (z_int_1d_ptr, f_int_1d_ptr, [n1_int_1d_ptr])\n  if (.not. associated(F%int_1d_ptr)) allocate(F%int_1d_ptr(n1_int_1d_ptr))\n  F%int_1d_ptr = f_int_1d_ptr(1:n1_int_1d_ptr)\nelse\n  if (associated(F%int_1d_ptr)) deallocate(F%int_1d_ptr)\nendif\n', to_f2_var=['integer(c_int), pointer :: f_int_1d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%int_1d_ptr) .eqv. associated(f2%int_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int_1d_ptr)) is_eq = all(shape(f1%int_1d_ptr) == shape(f2%int_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int_1d_ptr)) is_eq = all(f1%int_1d_ptr == f2%int_1d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%int_1d_ptr)) deallocate (F%int_1d_ptr)\nelse\n  if (.not. associated(F%int_1d_ptr)) allocate (F%int_1d_ptr(-1:1))\n  do jd1 = 1, size(F%int_1d_ptr,1); lb1 = lbound(F%int_1d_ptr,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%int_1d_ptr(jd1+lb1) = rhs\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Int>', c_instantiation_suffix='', to_f_setup='  auto n1_int_1d_ptr = C.int_1d_ptr.size();\n  c_IntArr z_int_1d_ptr = nullptr;\n  if (n1_int_1d_ptr > 0) {\n    z_int_1d_ptr = &C.int_1d_ptr[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_IntArr', to_f2_call='z_int_1d_ptr', to_c2_arg='c_IntArr z_int_1d_ptr', to_c2_set='\n  C.int_1d_ptr.resize(n1_int_1d_ptr);\n  C.int_1d_ptr << z_int_1d_ptr;\n', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_1d_ptr, y.int_1d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.int_1d_ptr.resize(0);\n  else {\n    C.int_1d_ptr.resize(3);\n    for (size_t i = 0; i < C.int_1d_ptr.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.int_1d_ptr[i] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_1d_ptr, type: VariableArray1D<Int>
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
        // CPP_all_encompassing.int_2d_ptr: PTR arg.kind='' arg=Argument(is_component=True, f_name='int_2d_ptr', c_name='int_2d_ptr', type='integer', kind='', pointer_type='PTR', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%int_2d_ptr)) then\n  n1_int_2d_ptr = size(F%int_2d_ptr, 1)\n  n2_int_2d_ptr = size(F%int_2d_ptr, 2)\nelse\n  n1_int_2d_ptr = 0; n2_int_2d_ptr = 0\nendif\n', to_c2_call='mat2vec(F%int_2d_ptr, n1_int_2d_ptr*n2_int_2d_ptr)', to_c2_type='integer(c_int)', to_c2_name='z_int_2d_ptr(*)', to_c2_f2_sub_arg='z_int_2d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_int_2d_ptr', to_f2_trans='if (associated(F%int_2d_ptr)) then\n  if (n1_int_2d_ptr == 0 .or. any(shape(F%int_2d_ptr) /= [n1_int_2d_ptr, n2_int_2d_ptr])) deallocate(F%int_2d_ptr)\n  if (any(lbound(F%int_2d_ptr) /= 1)) deallocate(F%int_2d_ptr)\nendif\nif (n1_int_2d_ptr /= 0) then\n  call c_f_pointer (z_int_2d_ptr, f_int_2d_ptr, [n1_int_2d_ptr*n2_int_2d_ptr])\n  if (.not. associated(F%int_2d_ptr)) allocate(F%int_2d_ptr(n1_int_2d_ptr, n2_int_2d_ptr))\n  call vec2mat(f_int_2d_ptr, F%int_2d_ptr)\nelse\n  if (associated(F%int_2d_ptr)) deallocate(F%int_2d_ptr)\nendif\n', to_f2_var=['integer(c_int), pointer :: f_int_2d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%int_2d_ptr) .eqv. associated(f2%int_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int_2d_ptr)) is_eq = all(shape(f1%int_2d_ptr) == shape(f2%int_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int_2d_ptr)) is_eq = all(f1%int_2d_ptr == f2%int_2d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%int_2d_ptr)) deallocate (F%int_2d_ptr)\nelse\n  if (.not. associated(F%int_2d_ptr)) allocate (F%int_2d_ptr(-1:1, 2))\n  do jd1 = 1, size(F%int_2d_ptr,1); lb1 = lbound(F%int_2d_ptr,1) - 1\n  do jd2 = 1, size(F%int_2d_ptr,2); lb2 = lbound(F%int_2d_ptr,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%int_2d_ptr(jd1+lb1,jd2+lb2) = rhs\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Int>', c_instantiation_suffix='', to_f_setup='  auto n1_int_2d_ptr { C.int_2d_ptr.size() };\n  auto n2_int_2d_ptr { std::size_t{0} };\n  Int* z_int_2d_ptr = nullptr;\n  if (n1_int_2d_ptr > 0) {\n    n2_int_2d_ptr = C.int_2d_ptr[0].size();\n    z_int_2d_ptr = new Int [n1_int_2d_ptr*n2_int_2d_ptr];\n    matrix_to_vec (C.int_2d_ptr, z_int_2d_ptr);\n  }\n', to_f_cleanup='  if (z_int_2d_ptr) delete[] z_int_2d_ptr;\n', to_f2_arg='c_IntArr', to_f2_call='z_int_2d_ptr', to_c2_arg='c_IntArr z_int_2d_ptr', to_c2_set='  C.int_2d_ptr.resize(n1_int_2d_ptr);\n  for (auto i{0}; i < n1_int_2d_ptr; i++) C.int_2d_ptr[i].resize(n2_int_2d_ptr);\n  C.int_2d_ptr << z_int_2d_ptr;\n', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_2d_ptr, y.int_2d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.int_2d_ptr.resize(0);\n  else {\n    C.int_2d_ptr.resize(3);\n    for (size_t i = 0; i < C.int_2d_ptr.size(); i++)\n      C.int_2d_ptr[i].resize(2);\n    for (size_t i = 0; i < C.int_2d_ptr.size(); i++)  for (size_t j = 0; j < C.int_2d_ptr[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.int_2d_ptr[i][j] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_2d_ptr, type: VariableArray2D<Int>
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
        // CPP_all_encompassing.int_3d_ptr: PTR arg.kind='' arg=Argument(is_component=True, f_name='int_3d_ptr', c_name='int_3d_ptr', type='integer', kind='', pointer_type='PTR', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%int_3d_ptr)) then\n  n1_int_3d_ptr = size(F%int_3d_ptr, 1)\n  n2_int_3d_ptr = size(F%int_3d_ptr, 2)\n  n3_int_3d_ptr = size(F%int_3d_ptr, 3)\nelse\n  n1_int_3d_ptr = 0; n2_int_3d_ptr = 0; n3_int_3d_ptr = 0\nendif\n', to_c2_call='tensor2vec(F%int_3d_ptr, n1_int_3d_ptr*n2_int_3d_ptr*n3_int_3d_ptr)', to_c2_type='integer(c_int)', to_c2_name='z_int_3d_ptr(*)', to_c2_f2_sub_arg='z_int_3d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_int_3d_ptr', to_f2_trans='if (associated(F%int_3d_ptr)) then\n  if (n1_int_3d_ptr == 0 .or. any(shape(F%int_3d_ptr) /= [n1_int_3d_ptr, n2_int_3d_ptr, n3_int_3d_ptr])) deallocate(F%int_3d_ptr)\n  if (any(lbound(F%int_3d_ptr) /= 1)) deallocate(F%int_3d_ptr)\nendif\nif (n1_int_3d_ptr /= 0) then\n  call c_f_pointer (z_int_3d_ptr, f_int_3d_ptr, [n1_int_3d_ptr*n2_int_3d_ptr*n3_int_3d_ptr])\n  if (.not. associated(F%int_3d_ptr)) allocate(F%int_3d_ptr(n1_int_3d_ptr, n2_int_3d_ptr, n3_int_3d_ptr))\n  call vec2tensor(f_int_3d_ptr, F%int_3d_ptr)\nelse\n  if (associated(F%int_3d_ptr)) deallocate(F%int_3d_ptr)\nendif\n', to_f2_var=['integer(c_int), pointer :: f_int_3d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%int_3d_ptr) .eqv. associated(f2%int_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int_3d_ptr)) is_eq = all(shape(f1%int_3d_ptr) == shape(f2%int_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int_3d_ptr)) is_eq = all(f1%int_3d_ptr == f2%int_3d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%int_3d_ptr)) deallocate (F%int_3d_ptr)\nelse\n  if (.not. associated(F%int_3d_ptr)) allocate (F%int_3d_ptr(-1:1, 2, 1))\n  do jd1 = 1, size(F%int_3d_ptr,1); lb1 = lbound(F%int_3d_ptr,1) - 1\n  do jd2 = 1, size(F%int_3d_ptr,2); lb2 = lbound(F%int_3d_ptr,2) - 1\n  do jd3 = 1, size(F%int_3d_ptr,3); lb3 = lbound(F%int_3d_ptr,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%int_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Int>', c_instantiation_suffix='', to_f_setup='\n  auto n1_int_3d_ptr { C.int_3d_ptr.size() };\n  auto n2_int_3d_ptr { std::size_t{0} };\n  auto n3_int_3d_ptr { std::size_t{0} };\n  Int* z_int_3d_ptr { nullptr };\n  if (n1_int_3d_ptr > 0) {\n    n2_int_3d_ptr = C.int_3d_ptr[0].size();\n    n3_int_3d_ptr = C.int_3d_ptr[0][0].size();\n    z_int_3d_ptr = new Int [C.int_3d_ptr.size()*C.int_3d_ptr[0].size()*C.int_3d_ptr[0][0].size()];\n    tensor_to_vec (C.int_3d_ptr, z_int_3d_ptr);\n  }\n', to_f_cleanup='  if (z_int_3d_ptr) delete[] z_int_3d_ptr;\n', to_f2_arg='c_IntArr', to_f2_call='z_int_3d_ptr', to_c2_arg='c_IntArr z_int_3d_ptr', to_c2_set='  C.int_3d_ptr.resize(n1_int_3d_ptr);\n  for (size_t i = 0; i < C.int_3d_ptr.size(); i++) {\n    C.int_3d_ptr[i].resize(n2_int_3d_ptr);\n    for (size_t j = 0; j < C.int_3d_ptr[0].size(); j++)\n      C.int_3d_ptr[i][j].resize(n3_int_3d_ptr);\n  }\n  C.int_3d_ptr << z_int_3d_ptr;\n', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_3d_ptr, y.int_3d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.int_3d_ptr.resize(0);\n  else {\n    C.int_3d_ptr.resize(3);\n    for (size_t i = 0; i < C.int_3d_ptr.size(); i++) {\n      C.int_3d_ptr[i].resize(2);\n      for (size_t j = 0; j < C.int_3d_ptr[0].size(); j++) {\n        C.int_3d_ptr[i][j].resize(1);\n        for (size_t k = 0; k < C.int_3d_ptr[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.int_3d_ptr[i][j][k] = rhs;\n        }\n      }\n    }\n  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_3d_ptr, type: VariableArray3D<Int>
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
        // CPP_all_encompassing.int_1d_alloc: ALLOC arg.kind='' arg=Argument(is_component=True, f_name='int_1d_alloc', c_name='int_1d_alloc', type='integer', kind='', pointer_type='ALLOC', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_int_1d_alloc = 0\nif (allocated(F%int_1d_alloc)) then\n  n1_int_1d_alloc = size(F%int_1d_alloc, 1)\nendif\n', to_c2_call='fvec2vec(F%int_1d_alloc, n1_int_1d_alloc)', to_c2_type='integer(c_int)', to_c2_name='z_int_1d_alloc(*)', to_c2_f2_sub_arg='z_int_1d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_int_1d_alloc', to_f2_trans='if (allocated(F%int_1d_alloc)) then\n  if (n1_int_1d_alloc == 0 .or. any(shape(F%int_1d_alloc) /= [n1_int_1d_alloc])) deallocate(F%int_1d_alloc)\n  if (any(lbound(F%int_1d_alloc) /= 1)) deallocate(F%int_1d_alloc)\nendif\nif (n1_int_1d_alloc /= 0) then\n  call c_f_pointer (z_int_1d_alloc, f_int_1d_alloc, [n1_int_1d_alloc])\n  if (.not. allocated(F%int_1d_alloc)) allocate(F%int_1d_alloc(n1_int_1d_alloc))\n  F%int_1d_alloc = f_int_1d_alloc(1:n1_int_1d_alloc)\nelse\n  if (allocated(F%int_1d_alloc)) deallocate(F%int_1d_alloc)\nendif\n', to_f2_var=['integer(c_int), pointer :: f_int_1d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%int_1d_alloc) .eqv. allocated(f2%int_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int_1d_alloc)) is_eq = all(shape(f1%int_1d_alloc) == shape(f2%int_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int_1d_alloc)) is_eq = all(f1%int_1d_alloc == f2%int_1d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%int_1d_alloc)) deallocate (F%int_1d_alloc)\nelse\n  if (.not. allocated(F%int_1d_alloc)) allocate (F%int_1d_alloc(-1:1))\n  do jd1 = 1, size(F%int_1d_alloc,1); lb1 = lbound(F%int_1d_alloc,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%int_1d_alloc(jd1+lb1) = rhs\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Int>', c_instantiation_suffix='', to_f_setup='  auto n1_int_1d_alloc = C.int_1d_alloc.size();\n  c_IntArr z_int_1d_alloc = nullptr;\n  if (n1_int_1d_alloc > 0) {\n    z_int_1d_alloc = &C.int_1d_alloc[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_IntArr', to_f2_call='z_int_1d_alloc', to_c2_arg='c_IntArr z_int_1d_alloc', to_c2_set='\n  C.int_1d_alloc.resize(n1_int_1d_alloc);\n  C.int_1d_alloc << z_int_1d_alloc;\n', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_1d_alloc, y.int_1d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.int_1d_alloc.resize(0);\n  else {\n    C.int_1d_alloc.resize(3);\n    for (size_t i = 0; i < C.int_1d_alloc.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.int_1d_alloc[i] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_1d_alloc, type: VariableArray1D<Int>
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
        // CPP_all_encompassing.int_2d_alloc: ALLOC arg.kind='' arg=Argument(is_component=True, f_name='int_2d_alloc', c_name='int_2d_alloc', type='integer', kind='', pointer_type='ALLOC', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%int_2d_alloc)) then\n  n1_int_2d_alloc = size(F%int_2d_alloc, 1)\n  n2_int_2d_alloc = size(F%int_2d_alloc, 2)\nelse\n  n1_int_2d_alloc = 0; n2_int_2d_alloc = 0\nendif\n', to_c2_call='mat2vec(F%int_2d_alloc, n1_int_2d_alloc*n2_int_2d_alloc)', to_c2_type='integer(c_int)', to_c2_name='z_int_2d_alloc(*)', to_c2_f2_sub_arg='z_int_2d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_int_2d_alloc', to_f2_trans='if (allocated(F%int_2d_alloc)) then\n  if (n1_int_2d_alloc == 0 .or. any(shape(F%int_2d_alloc) /= [n1_int_2d_alloc, n2_int_2d_alloc])) deallocate(F%int_2d_alloc)\n  if (any(lbound(F%int_2d_alloc) /= 1)) deallocate(F%int_2d_alloc)\nendif\nif (n1_int_2d_alloc /= 0) then\n  call c_f_pointer (z_int_2d_alloc, f_int_2d_alloc, [n1_int_2d_alloc*n2_int_2d_alloc])\n  if (.not. allocated(F%int_2d_alloc)) allocate(F%int_2d_alloc(n1_int_2d_alloc, n2_int_2d_alloc))\n  call vec2mat(f_int_2d_alloc, F%int_2d_alloc)\nelse\n  if (allocated(F%int_2d_alloc)) deallocate(F%int_2d_alloc)\nendif\n', to_f2_var=['integer(c_int), pointer :: f_int_2d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%int_2d_alloc) .eqv. allocated(f2%int_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int_2d_alloc)) is_eq = all(shape(f1%int_2d_alloc) == shape(f2%int_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int_2d_alloc)) is_eq = all(f1%int_2d_alloc == f2%int_2d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%int_2d_alloc)) deallocate (F%int_2d_alloc)\nelse\n  if (.not. allocated(F%int_2d_alloc)) allocate (F%int_2d_alloc(-1:1, 2))\n  do jd1 = 1, size(F%int_2d_alloc,1); lb1 = lbound(F%int_2d_alloc,1) - 1\n  do jd2 = 1, size(F%int_2d_alloc,2); lb2 = lbound(F%int_2d_alloc,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%int_2d_alloc(jd1+lb1,jd2+lb2) = rhs\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Int>', c_instantiation_suffix='', to_f_setup='  auto n1_int_2d_alloc { C.int_2d_alloc.size() };\n  auto n2_int_2d_alloc { std::size_t{0} };\n  Int* z_int_2d_alloc = nullptr;\n  if (n1_int_2d_alloc > 0) {\n    n2_int_2d_alloc = C.int_2d_alloc[0].size();\n    z_int_2d_alloc = new Int [n1_int_2d_alloc*n2_int_2d_alloc];\n    matrix_to_vec (C.int_2d_alloc, z_int_2d_alloc);\n  }\n', to_f_cleanup='  if (z_int_2d_alloc) delete[] z_int_2d_alloc;\n', to_f2_arg='c_IntArr', to_f2_call='z_int_2d_alloc', to_c2_arg='c_IntArr z_int_2d_alloc', to_c2_set='  C.int_2d_alloc.resize(n1_int_2d_alloc);\n  for (auto i{0}; i < n1_int_2d_alloc; i++) C.int_2d_alloc[i].resize(n2_int_2d_alloc);\n  C.int_2d_alloc << z_int_2d_alloc;\n', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_2d_alloc, y.int_2d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.int_2d_alloc.resize(0);\n  else {\n    C.int_2d_alloc.resize(3);\n    for (size_t i = 0; i < C.int_2d_alloc.size(); i++)\n      C.int_2d_alloc[i].resize(2);\n    for (size_t i = 0; i < C.int_2d_alloc.size(); i++)  for (size_t j = 0; j < C.int_2d_alloc[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.int_2d_alloc[i][j] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_2d_alloc, type: VariableArray2D<Int>
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
        // CPP_all_encompassing.int_3d_alloc: ALLOC arg.kind='' arg=Argument(is_component=True, f_name='int_3d_alloc', c_name='int_3d_alloc', type='integer', kind='', pointer_type='ALLOC', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%int_3d_alloc)) then\n  n1_int_3d_alloc = size(F%int_3d_alloc, 1)\n  n2_int_3d_alloc = size(F%int_3d_alloc, 2)\n  n3_int_3d_alloc = size(F%int_3d_alloc, 3)\nelse\n  n1_int_3d_alloc = 0; n2_int_3d_alloc = 0; n3_int_3d_alloc = 0\nendif\n', to_c2_call='tensor2vec(F%int_3d_alloc, n1_int_3d_alloc*n2_int_3d_alloc*n3_int_3d_alloc)', to_c2_type='integer(c_int)', to_c2_name='z_int_3d_alloc(*)', to_c2_f2_sub_arg='z_int_3d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_int_3d_alloc', to_f2_trans='if (allocated(F%int_3d_alloc)) then\n  if (n1_int_3d_alloc == 0 .or. any(shape(F%int_3d_alloc) /= [n1_int_3d_alloc, n2_int_3d_alloc, n3_int_3d_alloc])) deallocate(F%int_3d_alloc)\n  if (any(lbound(F%int_3d_alloc) /= 1)) deallocate(F%int_3d_alloc)\nendif\nif (n1_int_3d_alloc /= 0) then\n  call c_f_pointer (z_int_3d_alloc, f_int_3d_alloc, [n1_int_3d_alloc*n2_int_3d_alloc*n3_int_3d_alloc])\n  if (.not. allocated(F%int_3d_alloc)) allocate(F%int_3d_alloc(n1_int_3d_alloc, n2_int_3d_alloc, n3_int_3d_alloc))\n  call vec2tensor(f_int_3d_alloc, F%int_3d_alloc)\nelse\n  if (allocated(F%int_3d_alloc)) deallocate(F%int_3d_alloc)\nendif\n', to_f2_var=['integer(c_int), pointer :: f_int_3d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%int_3d_alloc) .eqv. allocated(f2%int_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int_3d_alloc)) is_eq = all(shape(f1%int_3d_alloc) == shape(f2%int_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int_3d_alloc)) is_eq = all(f1%int_3d_alloc == f2%int_3d_alloc)\n', test_pat='if (ix_patt < 3) then\n  if (allocated(F%int_3d_alloc)) deallocate (F%int_3d_alloc)\nelse\n  if (.not. allocated(F%int_3d_alloc)) allocate (F%int_3d_alloc(-1:1, 2, 1))\n  do jd1 = 1, size(F%int_3d_alloc,1); lb1 = lbound(F%int_3d_alloc,1) - 1\n  do jd2 = 1, size(F%int_3d_alloc,2); lb2 = lbound(F%int_3d_alloc,2) - 1\n  do jd3 = 1, size(F%int_3d_alloc,3); lb3 = lbound(F%int_3d_alloc,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%int_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Int>', c_instantiation_suffix='', to_f_setup='\n  auto n1_int_3d_alloc { C.int_3d_alloc.size() };\n  auto n2_int_3d_alloc { std::size_t{0} };\n  auto n3_int_3d_alloc { std::size_t{0} };\n  Int* z_int_3d_alloc { nullptr };\n  if (n1_int_3d_alloc > 0) {\n    n2_int_3d_alloc = C.int_3d_alloc[0].size();\n    n3_int_3d_alloc = C.int_3d_alloc[0][0].size();\n    z_int_3d_alloc = new Int [C.int_3d_alloc.size()*C.int_3d_alloc[0].size()*C.int_3d_alloc[0][0].size()];\n    tensor_to_vec (C.int_3d_alloc, z_int_3d_alloc);\n  }\n', to_f_cleanup='  if (z_int_3d_alloc) delete[] z_int_3d_alloc;\n', to_f2_arg='c_IntArr', to_f2_call='z_int_3d_alloc', to_c2_arg='c_IntArr z_int_3d_alloc', to_c2_set='  C.int_3d_alloc.resize(n1_int_3d_alloc);\n  for (size_t i = 0; i < C.int_3d_alloc.size(); i++) {\n    C.int_3d_alloc[i].resize(n2_int_3d_alloc);\n    for (size_t j = 0; j < C.int_3d_alloc[0].size(); j++)\n      C.int_3d_alloc[i][j].resize(n3_int_3d_alloc);\n  }\n  C.int_3d_alloc << z_int_3d_alloc;\n', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int_3d_alloc, y.int_3d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.int_3d_alloc.resize(0);\n  else {\n    C.int_3d_alloc.resize(3);\n    for (size_t i = 0; i < C.int_3d_alloc.size(); i++) {\n      C.int_3d_alloc[i].resize(2);\n      for (size_t j = 0; j < C.int_3d_alloc[0].size(); j++) {\n        C.int_3d_alloc[i][j].resize(1);\n        for (size_t k = 0; k < C.int_3d_alloc[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.int_3d_alloc[i][j][k] = rhs;\n        }\n      }\n    }\n  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int_3d_alloc, type: VariableArray3D<Int>
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
        // CPP_all_encompassing.int8_0d: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_0d', c_name='int8_0d', type='integer8', kind='8', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='F%int8_0d', to_c2_type='integer(c_long)', to_c2_name='z_int8_0d', to_c2_f2_sub_arg='z_int8_0d', to_f2_type='integer(c_long)', to_f2_name='z_int8_0d', to_f2_trans='F%int8_0d = z_int8_0d', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%int8_0d == f2%int8_0d)\n', test_pat='rhs = ARGIDX + offset; F%int8_0d = rhs\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='Int8', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Int8&', to_f2_call='C.int8_0d', to_c2_arg='c_Int8& z_int8_0d', to_c2_set='  C.int8_0d = z_int8_0d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && (x.int8_0d == y.int8_0d);\n', test_pat='  rhs = ARGIDX + offset; C.int8_0d = rhs;\n', test_value='rhs'), split_line=['int8_0d'], intent='', optional=False)
        // [default case]
        .def_property_readonly("int8_0d",
            [](const CPP_all_encompassing &self) { return self.int8_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_1d: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_1d', c_name='int8_1d', type='integer8', kind='8', pointer_type='NOT', array=['3'], lbound=['1'], ubound=['3'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='fvec2vec(F%int8_1d, 3)', to_c2_type='integer(c_long)', to_c2_name='z_int8_1d(*)', to_c2_f2_sub_arg='z_int8_1d', to_f2_type='integer(c_long)', to_f2_name='z_int8_1d(*)', to_f2_trans='F%int8_1d = z_int8_1d(1:3)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_1d == f2%int8_1d)\n', test_pat='do jd1 = 1, size(F%int8_1d,1); lb1 = lbound(F%int8_1d,1) - 1\n  rhs = 100 + jd1 + ARGIDX + offset\n  F%int8_1d(jd1+lb1) = rhs\nenddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray1D<Int8, 3>', c_instantiation_suffix='{VALUE}', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Int8Arr', to_f2_call='&C.int8_1d[0]', to_c2_arg='c_Int8Arr z_int8_1d', to_c2_set='  C.int8_1d << z_int8_1d;', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_1d, y.int8_1d);\n', test_pat='  for (size_t i = 0; i < C.int8_1d.size(); i++)\n    {int rhs = 101 + i + ARGIDX + offset; C.int8_1d[i] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_1d, type: FixedArray1D<Int8
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
        // CPP_all_encompassing.int8_2d: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_2d', c_name='int8_2d', type='integer8', kind='8', pointer_type='NOT', array=['3', '4'], lbound=['1', '1'], ubound=['3', '4'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='mat2vec(F%int8_2d, 3*4)', to_c2_type='integer(c_long)', to_c2_name='z_int8_2d(*)', to_c2_f2_sub_arg='z_int8_2d', to_f2_type='integer(c_long)', to_f2_name='z_int8_2d(*)', to_f2_trans='call vec2mat(z_int8_2d, F%int8_2d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_2d == f2%int8_2d)\n', test_pat='do jd1 = 1, size(F%int8_2d,1); lb1 = lbound(F%int8_2d,1) - 1\ndo jd2 = 1, size(F%int8_2d,2); lb2 = lbound(F%int8_2d,2) - 1\n  rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n  F%int8_2d(jd1+lb1,jd2+lb2) = rhs\nenddo; enddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray2D<Int8, 3, 4>', c_instantiation_suffix='', to_f_setup='  Int8 z_int8_2d[3*4]; matrix_to_vec(C.int8_2d, z_int8_2d);\n', to_f_cleanup='', to_f2_arg='c_Int8Arr', to_f2_call='z_int8_2d', to_c2_arg='c_Int8Arr z_int8_2d', to_c2_set='  C.int8_2d << z_int8_2d;', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_2d, y.int8_2d);\n', test_pat='  for (size_t i = 0; i < C.int8_2d.size(); i++)  for (size_t j = 0; j < C.int8_2d[0].size(); j++) \n    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.int8_2d[i][j] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_2d, type: FixedArray2D<Int8
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
        // CPP_all_encompassing.int8_3d: NOT arg.kind='8' arg=Argument(is_component=True, f_name='int8_3d', c_name='int8_3d', type='integer8', kind='8', pointer_type='NOT', array=['3', '4', '5'], lbound=['1', '1', '1'], ubound=['3', '4', '5'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='tensor2vec(F%int8_3d, 3*4*5)', to_c2_type='integer(c_long)', to_c2_name='z_int8_3d(*)', to_c2_f2_sub_arg='z_int8_3d', to_f2_type='integer(c_long)', to_f2_name='z_int8_3d(*)', to_f2_trans='call vec2tensor(z_int8_3d, F%int8_3d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%int8_3d == f2%int8_3d)\n', test_pat='do jd1 = 1, size(F%int8_3d,1); lb1 = lbound(F%int8_3d,1) - 1\ndo jd2 = 1, size(F%int8_3d,2); lb2 = lbound(F%int8_3d,2) - 1\ndo jd3 = 1, size(F%int8_3d,3); lb3 = lbound(F%int8_3d,3) - 1\n  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n  F%int8_3d(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\nenddo; enddo; enddo\n', size_var=[], test_value='rhs'), c_side=c_side_trans_class(c_class='FixedArray3D<Int8, 3, 4, 5>', c_instantiation_suffix='', to_f_setup='  Int8 z_int8_3d[3*4*5]; tensor_to_vec(C.int8_3d, z_int8_3d);\n', to_f_cleanup='', to_f2_arg='c_Int8Arr', to_f2_call='z_int8_3d', to_c2_arg='c_Int8Arr z_int8_3d', to_c2_set='  C.int8_3d << z_int8_3d;', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_3d, y.int8_3d);\n', test_pat='  for (size_t i = 0; i < C.int8_3d.size(); i++)  for (size_t j = 0; j < C.int8_3d[0].size(); j++)   for (size_t k = 0; k < C.int8_3d[0][0].size(); k++)\n    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; C.int8_3d[i][j][k] = rhs;}', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_3d, type: FixedArray3D<Int8
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
        // CPP_all_encompassing.int8_0d_ptr: PTR arg.kind='8' arg=Argument(is_component=True, f_name='int8_0d_ptr', c_name='int8_0d_ptr', type='integer8', kind='8', pointer_type='PTR', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n_int8_0d_ptr = 0\nif (associated(F%int8_0d_ptr)) n_int8_0d_ptr = 1\n', to_c2_call='F%int8_0d_ptr', to_c2_type='integer(c_long)', to_c2_name='z_int8_0d_ptr', to_c2_f2_sub_arg='z_int8_0d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_int8_0d_ptr', to_f2_trans='if (n_int8_0d_ptr == 0) then                                                                                  \n  if (associated(F%int8_0d_ptr)) deallocate(F%int8_0d_ptr)                                                           \nelse                                                                                                   \n  call c_f_pointer (z_int8_0d_ptr, f_int8_0d_ptr)                                                                    \n  if (.not. associated(F%int8_0d_ptr)) allocate(F%int8_0d_ptr)                                                       \n  F%int8_0d_ptr = f_int8_0d_ptr\nendif                                                                                                  \n', to_f2_var=['integer(c_long), pointer :: f_int8_0d_ptr'], equality_test='\nis_eq = is_eq .and. (associated(f1%int8_0d_ptr) .eqv. associated(f2%int8_0d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int8_0d_ptr)) is_eq = (f1%int8_0d_ptr == f2%int8_0d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%int8_0d_ptr)) deallocate (F%int8_0d_ptr)\nelse\n  if (.not. associated(F%int8_0d_ptr)) allocate (F%int8_0d_ptr)\n  rhs = ARGIDX + offset\n  F%int8_0d_ptr = rhs\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='shared_ptr<Int8>', c_instantiation_suffix='', to_f_setup='  size_t n_int8_0d_ptr = 0; if (C.int8_0d_ptr != nullptr) n_int8_0d_ptr = 1;\n', to_f_cleanup='', to_f2_arg='c_Int8Arr', to_f2_call='C.int8_0d_ptr.get()', to_c2_arg='c_Int8Arr z_int8_0d_ptr', to_c2_set='  if (n_int8_0d_ptr == 0) {\n    C.int8_0d_ptr = nullptr;\n  } else {\n    C.int8_0d_ptr = make_shared<Int8>();\n    *C.int8_0d_ptr = *z_int8_0d_ptr;\n  }\n', class_initializer='nullptr', construct_value='0', destructor='', equality_test='  is_eq = is_eq && ((x.int8_0d_ptr == NULL) == (y.int8_0d_ptr == NULL));\n  if (!is_eq) return false;\n  if (x.int8_0d_ptr != NULL) is_eq = (*x.int8_0d_ptr == *y.int8_0d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.int8_0d_ptr = nullptr;\n  else {\n    C.int8_0d_ptr = make_shared<Int8>();\n    rhs = ARGIDX + offset; (*C.int8_0d_ptr) = rhs;\n  }', test_value='rhs'), split_line=['int8_0d_ptr'], intent='', optional=False)
        // PTR
        .def_property_readonly("int8_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.int8_0d_ptr ? py::cast(*self.int8_0d_ptr) : py::none(); },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.int8_1d_ptr: PTR arg.kind='8' arg=Argument(is_component=True, f_name='int8_1d_ptr', c_name='int8_1d_ptr', type='integer8', kind='8', pointer_type='PTR', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_int8_1d_ptr = 0\nif (associated(F%int8_1d_ptr)) then\n  n1_int8_1d_ptr = size(F%int8_1d_ptr, 1)\nendif\n', to_c2_call='fvec2vec(F%int8_1d_ptr, n1_int8_1d_ptr)', to_c2_type='integer(c_long)', to_c2_name='z_int8_1d_ptr(*)', to_c2_f2_sub_arg='z_int8_1d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_int8_1d_ptr', to_f2_trans='if (associated(F%int8_1d_ptr)) then\n  if (n1_int8_1d_ptr == 0 .or. any(shape(F%int8_1d_ptr) /= [n1_int8_1d_ptr])) deallocate(F%int8_1d_ptr)\n  if (any(lbound(F%int8_1d_ptr) /= 1)) deallocate(F%int8_1d_ptr)\nendif\nif (n1_int8_1d_ptr /= 0) then\n  call c_f_pointer (z_int8_1d_ptr, f_int8_1d_ptr, [n1_int8_1d_ptr])\n  if (.not. associated(F%int8_1d_ptr)) allocate(F%int8_1d_ptr(n1_int8_1d_ptr))\n  F%int8_1d_ptr = f_int8_1d_ptr(1:n1_int8_1d_ptr)\nelse\n  if (associated(F%int8_1d_ptr)) deallocate(F%int8_1d_ptr)\nendif\n', to_f2_var=['integer(c_long), pointer :: f_int8_1d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%int8_1d_ptr) .eqv. associated(f2%int8_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int8_1d_ptr)) is_eq = all(shape(f1%int8_1d_ptr) == shape(f2%int8_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int8_1d_ptr)) is_eq = all(f1%int8_1d_ptr == f2%int8_1d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%int8_1d_ptr)) deallocate (F%int8_1d_ptr)\nelse\n  if (.not. associated(F%int8_1d_ptr)) allocate (F%int8_1d_ptr(-1:1))\n  do jd1 = 1, size(F%int8_1d_ptr,1); lb1 = lbound(F%int8_1d_ptr,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%int8_1d_ptr(jd1+lb1) = rhs\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Int8>', c_instantiation_suffix='', to_f_setup='  auto n1_int8_1d_ptr = C.int8_1d_ptr.size();\n  c_Int8Arr z_int8_1d_ptr = nullptr;\n  if (n1_int8_1d_ptr > 0) {\n    z_int8_1d_ptr = &C.int8_1d_ptr[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_Int8Arr', to_f2_call='z_int8_1d_ptr', to_c2_arg='c_Int8Arr z_int8_1d_ptr', to_c2_set='\n  C.int8_1d_ptr.resize(n1_int8_1d_ptr);\n  C.int8_1d_ptr << z_int8_1d_ptr;\n', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_1d_ptr, y.int8_1d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.int8_1d_ptr.resize(0);\n  else {\n    C.int8_1d_ptr.resize(3);\n    for (size_t i = 0; i < C.int8_1d_ptr.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.int8_1d_ptr[i] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_1d_ptr, type: VariableArray1D<Int8>
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
        // CPP_all_encompassing.int8_2d_ptr: PTR arg.kind='8' arg=Argument(is_component=True, f_name='int8_2d_ptr', c_name='int8_2d_ptr', type='integer8', kind='8', pointer_type='PTR', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%int8_2d_ptr)) then\n  n1_int8_2d_ptr = size(F%int8_2d_ptr, 1)\n  n2_int8_2d_ptr = size(F%int8_2d_ptr, 2)\nelse\n  n1_int8_2d_ptr = 0; n2_int8_2d_ptr = 0\nendif\n', to_c2_call='mat2vec(F%int8_2d_ptr, n1_int8_2d_ptr*n2_int8_2d_ptr)', to_c2_type='integer(c_long)', to_c2_name='z_int8_2d_ptr(*)', to_c2_f2_sub_arg='z_int8_2d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_int8_2d_ptr', to_f2_trans='if (associated(F%int8_2d_ptr)) then\n  if (n1_int8_2d_ptr == 0 .or. any(shape(F%int8_2d_ptr) /= [n1_int8_2d_ptr, n2_int8_2d_ptr])) deallocate(F%int8_2d_ptr)\n  if (any(lbound(F%int8_2d_ptr) /= 1)) deallocate(F%int8_2d_ptr)\nendif\nif (n1_int8_2d_ptr /= 0) then\n  call c_f_pointer (z_int8_2d_ptr, f_int8_2d_ptr, [n1_int8_2d_ptr*n2_int8_2d_ptr])\n  if (.not. associated(F%int8_2d_ptr)) allocate(F%int8_2d_ptr(n1_int8_2d_ptr, n2_int8_2d_ptr))\n  call vec2mat(f_int8_2d_ptr, F%int8_2d_ptr)\nelse\n  if (associated(F%int8_2d_ptr)) deallocate(F%int8_2d_ptr)\nendif\n', to_f2_var=['integer(c_long), pointer :: f_int8_2d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%int8_2d_ptr) .eqv. associated(f2%int8_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int8_2d_ptr)) is_eq = all(shape(f1%int8_2d_ptr) == shape(f2%int8_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int8_2d_ptr)) is_eq = all(f1%int8_2d_ptr == f2%int8_2d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%int8_2d_ptr)) deallocate (F%int8_2d_ptr)\nelse\n  if (.not. associated(F%int8_2d_ptr)) allocate (F%int8_2d_ptr(-1:1, 2))\n  do jd1 = 1, size(F%int8_2d_ptr,1); lb1 = lbound(F%int8_2d_ptr,1) - 1\n  do jd2 = 1, size(F%int8_2d_ptr,2); lb2 = lbound(F%int8_2d_ptr,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%int8_2d_ptr(jd1+lb1,jd2+lb2) = rhs\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Int8>', c_instantiation_suffix='', to_f_setup='  auto n1_int8_2d_ptr { C.int8_2d_ptr.size() };\n  auto n2_int8_2d_ptr { std::size_t{0} };\n  Int8* z_int8_2d_ptr = nullptr;\n  if (n1_int8_2d_ptr > 0) {\n    n2_int8_2d_ptr = C.int8_2d_ptr[0].size();\n    z_int8_2d_ptr = new Int8 [n1_int8_2d_ptr*n2_int8_2d_ptr];\n    matrix_to_vec (C.int8_2d_ptr, z_int8_2d_ptr);\n  }\n', to_f_cleanup='  if (z_int8_2d_ptr) delete[] z_int8_2d_ptr;\n', to_f2_arg='c_Int8Arr', to_f2_call='z_int8_2d_ptr', to_c2_arg='c_Int8Arr z_int8_2d_ptr', to_c2_set='  C.int8_2d_ptr.resize(n1_int8_2d_ptr);\n  for (auto i{0}; i < n1_int8_2d_ptr; i++) C.int8_2d_ptr[i].resize(n2_int8_2d_ptr);\n  C.int8_2d_ptr << z_int8_2d_ptr;\n', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_2d_ptr, y.int8_2d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.int8_2d_ptr.resize(0);\n  else {\n    C.int8_2d_ptr.resize(3);\n    for (size_t i = 0; i < C.int8_2d_ptr.size(); i++)\n      C.int8_2d_ptr[i].resize(2);\n    for (size_t i = 0; i < C.int8_2d_ptr.size(); i++)  for (size_t j = 0; j < C.int8_2d_ptr[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.int8_2d_ptr[i][j] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_2d_ptr, type: VariableArray2D<Int8>
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
        // CPP_all_encompassing.int8_3d_ptr: PTR arg.kind='8' arg=Argument(is_component=True, f_name='int8_3d_ptr', c_name='int8_3d_ptr', type='integer8', kind='8', pointer_type='PTR', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (associated(F%int8_3d_ptr)) then\n  n1_int8_3d_ptr = size(F%int8_3d_ptr, 1)\n  n2_int8_3d_ptr = size(F%int8_3d_ptr, 2)\n  n3_int8_3d_ptr = size(F%int8_3d_ptr, 3)\nelse\n  n1_int8_3d_ptr = 0; n2_int8_3d_ptr = 0; n3_int8_3d_ptr = 0\nendif\n', to_c2_call='tensor2vec(F%int8_3d_ptr, n1_int8_3d_ptr*n2_int8_3d_ptr*n3_int8_3d_ptr)', to_c2_type='integer(c_long)', to_c2_name='z_int8_3d_ptr(*)', to_c2_f2_sub_arg='z_int8_3d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_int8_3d_ptr', to_f2_trans='if (associated(F%int8_3d_ptr)) then\n  if (n1_int8_3d_ptr == 0 .or. any(shape(F%int8_3d_ptr) /= [n1_int8_3d_ptr, n2_int8_3d_ptr, n3_int8_3d_ptr])) deallocate(F%int8_3d_ptr)\n  if (any(lbound(F%int8_3d_ptr) /= 1)) deallocate(F%int8_3d_ptr)\nendif\nif (n1_int8_3d_ptr /= 0) then\n  call c_f_pointer (z_int8_3d_ptr, f_int8_3d_ptr, [n1_int8_3d_ptr*n2_int8_3d_ptr*n3_int8_3d_ptr])\n  if (.not. associated(F%int8_3d_ptr)) allocate(F%int8_3d_ptr(n1_int8_3d_ptr, n2_int8_3d_ptr, n3_int8_3d_ptr))\n  call vec2tensor(f_int8_3d_ptr, F%int8_3d_ptr)\nelse\n  if (associated(F%int8_3d_ptr)) deallocate(F%int8_3d_ptr)\nendif\n', to_f2_var=['integer(c_long), pointer :: f_int8_3d_ptr(:)'], equality_test='is_eq = is_eq .and. (associated(f1%int8_3d_ptr) .eqv. associated(f2%int8_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int8_3d_ptr)) is_eq = all(shape(f1%int8_3d_ptr) == shape(f2%int8_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%int8_3d_ptr)) is_eq = all(f1%int8_3d_ptr == f2%int8_3d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%int8_3d_ptr)) deallocate (F%int8_3d_ptr)\nelse\n  if (.not. associated(F%int8_3d_ptr)) allocate (F%int8_3d_ptr(-1:1, 2, 1))\n  do jd1 = 1, size(F%int8_3d_ptr,1); lb1 = lbound(F%int8_3d_ptr,1) - 1\n  do jd2 = 1, size(F%int8_3d_ptr,2); lb2 = lbound(F%int8_3d_ptr,2) - 1\n  do jd3 = 1, size(F%int8_3d_ptr,3); lb3 = lbound(F%int8_3d_ptr,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%int8_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Int8>', c_instantiation_suffix='', to_f_setup='\n  auto n1_int8_3d_ptr { C.int8_3d_ptr.size() };\n  auto n2_int8_3d_ptr { std::size_t{0} };\n  auto n3_int8_3d_ptr { std::size_t{0} };\n  Int8* z_int8_3d_ptr { nullptr };\n  if (n1_int8_3d_ptr > 0) {\n    n2_int8_3d_ptr = C.int8_3d_ptr[0].size();\n    n3_int8_3d_ptr = C.int8_3d_ptr[0][0].size();\n    z_int8_3d_ptr = new Int8 [C.int8_3d_ptr.size()*C.int8_3d_ptr[0].size()*C.int8_3d_ptr[0][0].size()];\n    tensor_to_vec (C.int8_3d_ptr, z_int8_3d_ptr);\n  }\n', to_f_cleanup='  if (z_int8_3d_ptr) delete[] z_int8_3d_ptr;\n', to_f2_arg='c_Int8Arr', to_f2_call='z_int8_3d_ptr', to_c2_arg='c_Int8Arr z_int8_3d_ptr', to_c2_set='  C.int8_3d_ptr.resize(n1_int8_3d_ptr);\n  for (size_t i = 0; i < C.int8_3d_ptr.size(); i++) {\n    C.int8_3d_ptr[i].resize(n2_int8_3d_ptr);\n    for (size_t j = 0; j < C.int8_3d_ptr[0].size(); j++)\n      C.int8_3d_ptr[i][j].resize(n3_int8_3d_ptr);\n  }\n  C.int8_3d_ptr << z_int8_3d_ptr;\n', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_3d_ptr, y.int8_3d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.int8_3d_ptr.resize(0);\n  else {\n    C.int8_3d_ptr.resize(3);\n    for (size_t i = 0; i < C.int8_3d_ptr.size(); i++) {\n      C.int8_3d_ptr[i].resize(2);\n      for (size_t j = 0; j < C.int8_3d_ptr[0].size(); j++) {\n        C.int8_3d_ptr[i][j].resize(1);\n        for (size_t k = 0; k < C.int8_3d_ptr[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.int8_3d_ptr[i][j][k] = rhs;\n        }\n      }\n    }\n  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_3d_ptr, type: VariableArray3D<Int8>
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
        // CPP_all_encompassing.int8_1d_alloc: ALLOC arg.kind='8' arg=Argument(is_component=True, f_name='int8_1d_alloc', c_name='int8_1d_alloc', type='integer8', kind='8', pointer_type='ALLOC', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n1_int8_1d_alloc = 0\nif (allocated(F%int8_1d_alloc)) then\n  n1_int8_1d_alloc = size(F%int8_1d_alloc, 1)\nendif\n', to_c2_call='fvec2vec(F%int8_1d_alloc, n1_int8_1d_alloc)', to_c2_type='integer(c_long)', to_c2_name='z_int8_1d_alloc(*)', to_c2_f2_sub_arg='z_int8_1d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_int8_1d_alloc', to_f2_trans='if (allocated(F%int8_1d_alloc)) then\n  if (n1_int8_1d_alloc == 0 .or. any(shape(F%int8_1d_alloc) /= [n1_int8_1d_alloc])) deallocate(F%int8_1d_alloc)\n  if (any(lbound(F%int8_1d_alloc) /= 1)) deallocate(F%int8_1d_alloc)\nendif\nif (n1_int8_1d_alloc /= 0) then\n  call c_f_pointer (z_int8_1d_alloc, f_int8_1d_alloc, [n1_int8_1d_alloc])\n  if (.not. allocated(F%int8_1d_alloc)) allocate(F%int8_1d_alloc(n1_int8_1d_alloc))\n  F%int8_1d_alloc = f_int8_1d_alloc(1:n1_int8_1d_alloc)\nelse\n  if (allocated(F%int8_1d_alloc)) deallocate(F%int8_1d_alloc)\nendif\n', to_f2_var=['integer(c_long), pointer :: f_int8_1d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%int8_1d_alloc) .eqv. allocated(f2%int8_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int8_1d_alloc)) is_eq = all(shape(f1%int8_1d_alloc) == shape(f2%int8_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int8_1d_alloc)) is_eq = all(f1%int8_1d_alloc == f2%int8_1d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%int8_1d_alloc)) deallocate (F%int8_1d_alloc)\nelse\n  if (.not. allocated(F%int8_1d_alloc)) allocate (F%int8_1d_alloc(-1:1))\n  do jd1 = 1, size(F%int8_1d_alloc,1); lb1 = lbound(F%int8_1d_alloc,1) - 1\n    rhs = 100 + jd1 + ARGIDX + offset\n    F%int8_1d_alloc(jd1+lb1) = rhs\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<Int8>', c_instantiation_suffix='', to_f_setup='  auto n1_int8_1d_alloc = C.int8_1d_alloc.size();\n  c_Int8Arr z_int8_1d_alloc = nullptr;\n  if (n1_int8_1d_alloc > 0) {\n    z_int8_1d_alloc = &C.int8_1d_alloc[0];\n  }\n', to_f_cleanup='', to_f2_arg='c_Int8Arr', to_f2_call='z_int8_1d_alloc', to_c2_arg='c_Int8Arr z_int8_1d_alloc', to_c2_set='\n  C.int8_1d_alloc.resize(n1_int8_1d_alloc);\n  C.int8_1d_alloc << z_int8_1d_alloc;\n', class_initializer='{ 0 }', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_1d_alloc, y.int8_1d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.int8_1d_alloc.resize(0);\n  else {\n    C.int8_1d_alloc.resize(3);\n    for (size_t i = 0; i < C.int8_1d_alloc.size(); i++)\n      {int rhs = 101 + i + ARGIDX + offset; C.int8_1d_alloc[i] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_1d_alloc, type: VariableArray1D<Int8>
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
        // CPP_all_encompassing.int8_2d_alloc: ALLOC arg.kind='8' arg=Argument(is_component=True, f_name='int8_2d_alloc', c_name='int8_2d_alloc', type='integer8', kind='8', pointer_type='ALLOC', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%int8_2d_alloc)) then\n  n1_int8_2d_alloc = size(F%int8_2d_alloc, 1)\n  n2_int8_2d_alloc = size(F%int8_2d_alloc, 2)\nelse\n  n1_int8_2d_alloc = 0; n2_int8_2d_alloc = 0\nendif\n', to_c2_call='mat2vec(F%int8_2d_alloc, n1_int8_2d_alloc*n2_int8_2d_alloc)', to_c2_type='integer(c_long)', to_c2_name='z_int8_2d_alloc(*)', to_c2_f2_sub_arg='z_int8_2d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_int8_2d_alloc', to_f2_trans='if (allocated(F%int8_2d_alloc)) then\n  if (n1_int8_2d_alloc == 0 .or. any(shape(F%int8_2d_alloc) /= [n1_int8_2d_alloc, n2_int8_2d_alloc])) deallocate(F%int8_2d_alloc)\n  if (any(lbound(F%int8_2d_alloc) /= 1)) deallocate(F%int8_2d_alloc)\nendif\nif (n1_int8_2d_alloc /= 0) then\n  call c_f_pointer (z_int8_2d_alloc, f_int8_2d_alloc, [n1_int8_2d_alloc*n2_int8_2d_alloc])\n  if (.not. allocated(F%int8_2d_alloc)) allocate(F%int8_2d_alloc(n1_int8_2d_alloc, n2_int8_2d_alloc))\n  call vec2mat(f_int8_2d_alloc, F%int8_2d_alloc)\nelse\n  if (allocated(F%int8_2d_alloc)) deallocate(F%int8_2d_alloc)\nendif\n', to_f2_var=['integer(c_long), pointer :: f_int8_2d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%int8_2d_alloc) .eqv. allocated(f2%int8_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int8_2d_alloc)) is_eq = all(shape(f1%int8_2d_alloc) == shape(f2%int8_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int8_2d_alloc)) is_eq = all(f1%int8_2d_alloc == f2%int8_2d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%int8_2d_alloc)) deallocate (F%int8_2d_alloc)\nelse\n  if (.not. allocated(F%int8_2d_alloc)) allocate (F%int8_2d_alloc(-1:1, 2))\n  do jd1 = 1, size(F%int8_2d_alloc,1); lb1 = lbound(F%int8_2d_alloc,1) - 1\n  do jd2 = 1, size(F%int8_2d_alloc,2); lb2 = lbound(F%int8_2d_alloc,2) - 1\n    rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n    F%int8_2d_alloc(jd1+lb1,jd2+lb2) = rhs\n  enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<Int8>', c_instantiation_suffix='', to_f_setup='  auto n1_int8_2d_alloc { C.int8_2d_alloc.size() };\n  auto n2_int8_2d_alloc { std::size_t{0} };\n  Int8* z_int8_2d_alloc = nullptr;\n  if (n1_int8_2d_alloc > 0) {\n    n2_int8_2d_alloc = C.int8_2d_alloc[0].size();\n    z_int8_2d_alloc = new Int8 [n1_int8_2d_alloc*n2_int8_2d_alloc];\n    matrix_to_vec (C.int8_2d_alloc, z_int8_2d_alloc);\n  }\n', to_f_cleanup='  if (z_int8_2d_alloc) delete[] z_int8_2d_alloc;\n', to_f2_arg='c_Int8Arr', to_f2_call='z_int8_2d_alloc', to_c2_arg='c_Int8Arr z_int8_2d_alloc', to_c2_set='  C.int8_2d_alloc.resize(n1_int8_2d_alloc);\n  for (auto i{0}; i < n1_int8_2d_alloc; i++) C.int8_2d_alloc[i].resize(n2_int8_2d_alloc);\n  C.int8_2d_alloc << z_int8_2d_alloc;\n', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_2d_alloc, y.int8_2d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.int8_2d_alloc.resize(0);\n  else {\n    C.int8_2d_alloc.resize(3);\n    for (size_t i = 0; i < C.int8_2d_alloc.size(); i++)\n      C.int8_2d_alloc[i].resize(2);\n    for (size_t i = 0; i < C.int8_2d_alloc.size(); i++)  for (size_t j = 0; j < C.int8_2d_alloc[0].size(); j++) \n      {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.int8_2d_alloc[i][j] = rhs;}  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_2d_alloc, type: VariableArray2D<Int8>
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
        // CPP_all_encompassing.int8_3d_alloc: ALLOC arg.kind='8' arg=Argument(is_component=True, f_name='int8_3d_alloc', c_name='int8_3d_alloc', type='integer8', kind='8', pointer_type='ALLOC', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='if (allocated(F%int8_3d_alloc)) then\n  n1_int8_3d_alloc = size(F%int8_3d_alloc, 1)\n  n2_int8_3d_alloc = size(F%int8_3d_alloc, 2)\n  n3_int8_3d_alloc = size(F%int8_3d_alloc, 3)\nelse\n  n1_int8_3d_alloc = 0; n2_int8_3d_alloc = 0; n3_int8_3d_alloc = 0\nendif\n', to_c2_call='tensor2vec(F%int8_3d_alloc, n1_int8_3d_alloc*n2_int8_3d_alloc*n3_int8_3d_alloc)', to_c2_type='integer(c_long)', to_c2_name='z_int8_3d_alloc(*)', to_c2_f2_sub_arg='z_int8_3d_alloc', to_f2_type='type(c_ptr), value', to_f2_name='z_int8_3d_alloc', to_f2_trans='if (allocated(F%int8_3d_alloc)) then\n  if (n1_int8_3d_alloc == 0 .or. any(shape(F%int8_3d_alloc) /= [n1_int8_3d_alloc, n2_int8_3d_alloc, n3_int8_3d_alloc])) deallocate(F%int8_3d_alloc)\n  if (any(lbound(F%int8_3d_alloc) /= 1)) deallocate(F%int8_3d_alloc)\nendif\nif (n1_int8_3d_alloc /= 0) then\n  call c_f_pointer (z_int8_3d_alloc, f_int8_3d_alloc, [n1_int8_3d_alloc*n2_int8_3d_alloc*n3_int8_3d_alloc])\n  if (.not. allocated(F%int8_3d_alloc)) allocate(F%int8_3d_alloc(n1_int8_3d_alloc, n2_int8_3d_alloc, n3_int8_3d_alloc))\n  call vec2tensor(f_int8_3d_alloc, F%int8_3d_alloc)\nelse\n  if (allocated(F%int8_3d_alloc)) deallocate(F%int8_3d_alloc)\nendif\n', to_f2_var=['integer(c_long), pointer :: f_int8_3d_alloc(:)'], equality_test='is_eq = is_eq .and. (allocated(f1%int8_3d_alloc) .eqv. allocated(f2%int8_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int8_3d_alloc)) is_eq = all(shape(f1%int8_3d_alloc) == shape(f2%int8_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%int8_3d_alloc)) is_eq = all(f1%int8_3d_alloc == f2%int8_3d_alloc)\n', test_pat='if (ix_patt < 3) then\n  if (allocated(F%int8_3d_alloc)) deallocate (F%int8_3d_alloc)\nelse\n  if (.not. allocated(F%int8_3d_alloc)) allocate (F%int8_3d_alloc(-1:1, 2, 1))\n  do jd1 = 1, size(F%int8_3d_alloc,1); lb1 = lbound(F%int8_3d_alloc,1) - 1\n  do jd2 = 1, size(F%int8_3d_alloc,2); lb2 = lbound(F%int8_3d_alloc,2) - 1\n  do jd3 = 1, size(F%int8_3d_alloc,3); lb3 = lbound(F%int8_3d_alloc,3) - 1\n    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n    F%int8_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = rhs\n  enddo; enddo; enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<Int8>', c_instantiation_suffix='', to_f_setup='\n  auto n1_int8_3d_alloc { C.int8_3d_alloc.size() };\n  auto n2_int8_3d_alloc { std::size_t{0} };\n  auto n3_int8_3d_alloc { std::size_t{0} };\n  Int8* z_int8_3d_alloc { nullptr };\n  if (n1_int8_3d_alloc > 0) {\n    n2_int8_3d_alloc = C.int8_3d_alloc[0].size();\n    n3_int8_3d_alloc = C.int8_3d_alloc[0][0].size();\n    z_int8_3d_alloc = new Int8 [C.int8_3d_alloc.size()*C.int8_3d_alloc[0].size()*C.int8_3d_alloc[0][0].size()];\n    tensor_to_vec (C.int8_3d_alloc, z_int8_3d_alloc);\n  }\n', to_f_cleanup='  if (z_int8_3d_alloc) delete[] z_int8_3d_alloc;\n', to_f2_arg='c_Int8Arr', to_f2_call='z_int8_3d_alloc', to_c2_arg='c_Int8Arr z_int8_3d_alloc', to_c2_set='  C.int8_3d_alloc.resize(n1_int8_3d_alloc);\n  for (size_t i = 0; i < C.int8_3d_alloc.size(); i++) {\n    C.int8_3d_alloc[i].resize(n2_int8_3d_alloc);\n    for (size_t j = 0; j < C.int8_3d_alloc[0].size(); j++)\n      C.int8_3d_alloc[i][j].resize(n3_int8_3d_alloc);\n  }\n  C.int8_3d_alloc << z_int8_3d_alloc;\n', class_initializer='', construct_value='0', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.int8_3d_alloc, y.int8_3d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.int8_3d_alloc.resize(0);\n  else {\n    C.int8_3d_alloc.resize(3);\n    for (size_t i = 0; i < C.int8_3d_alloc.size(); i++) {\n      C.int8_3d_alloc[i].resize(2);\n      for (size_t j = 0; j < C.int8_3d_alloc[0].size(); j++) {\n        C.int8_3d_alloc[i][j].resize(1);\n        for (size_t k = 0; k < C.int8_3d_alloc[0][0].size(); k++) {\n          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;\n          C.int8_3d_alloc[i][j][k] = rhs;\n        }\n      }\n    }\n  }\n', test_value='rhs'), split_line=[], intent='', optional=False)
        // Array property: int8_3d_alloc, type: VariableArray3D<Int8>
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
        // CPP_all_encompassing.logical_0d: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_0d', c_name='logical_0d', type='logical', kind='', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='c_logic(F%logical_0d)', to_c2_type='logical(c_bool)', to_c2_name='z_logical_0d', to_c2_f2_sub_arg='z_logical_0d', to_f2_type='logical(c_bool)', to_f2_name='z_logical_0d', to_f2_trans='F%logical_0d = f_logic(z_logical_0d)', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%logical_0d .eqv. f2%logical_0d)\n', test_pat='rhs = ARGIDX + offset; F%logical_0d = (modulo(rhs, 2) == 0)\n', size_var=[], test_value='(modulo(rhs, 2) == 0)'), c_side=c_side_trans_class(c_class='Bool', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='c_Bool&', to_f2_call='C.logical_0d', to_c2_arg='c_Bool& z_logical_0d', to_c2_set='  C.logical_0d = z_logical_0d;', class_initializer='{ false }', construct_value='false', destructor='', equality_test='  is_eq = is_eq && (x.logical_0d == y.logical_0d);\n', test_pat='  rhs = ARGIDX + offset; C.logical_0d = (rhs % 2 == 0);\n', test_value='(rhs % 2 == 0)'), split_line=['logical_0d'], intent='', optional=False)
        // [default case]
        .def_property_readonly("logical_0d",
            [](const CPP_all_encompassing &self) { return self.logical_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.logical_1d: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_1d', c_name='logical_1d', type='logical', kind='', pointer_type='NOT', array=['3'], lbound=['1'], ubound=['3'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='fvec2vec(F%logical_1d, 3)', to_c2_type='logical(c_bool)', to_c2_name='z_logical_1d(*)', to_c2_f2_sub_arg='z_logical_1d', to_f2_type='logical(c_bool)', to_f2_name='z_logical_1d(*)', to_f2_trans='call vec2fvec (z_logical_1d, F%logical_1d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%logical_1d .eqv. f2%logical_1d)\n', test_pat='do jd1 = 1, size(F%logical_1d,1); lb1 = lbound(F%logical_1d,1) - 1\n  rhs = 100 + jd1 + ARGIDX + offset\n  F%logical_1d(jd1+lb1) = (modulo(rhs, 2) == 0)\nenddo\n', size_var=[], test_value='(modulo(rhs, 2) == 0)'), c_side=c_side_trans_class(c_class='FixedArray1D<Bool, 3>', c_instantiation_suffix='{VALUE}', to_f_setup='', to_f_cleanup='', to_f2_arg='c_BoolArr', to_f2_call='&C.logical_1d[0]', to_c2_arg='c_BoolArr z_logical_1d', to_c2_set='  C.logical_1d << z_logical_1d;', class_initializer='{ false }', construct_value='false', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.logical_1d, y.logical_1d);\n', test_pat='  for (size_t i = 0; i < C.logical_1d.size(); i++)\n    {int rhs = 101 + i + ARGIDX + offset; C.logical_1d[i] = (rhs % 2 == 0);}', test_value='(rhs % 2 == 0)'), split_line=[], intent='', optional=False)
        // Array property: logical_1d, type: FixedArray1D<Bool
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
        // CPP_all_encompassing.logical_2d: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_2d', c_name='logical_2d', type='logical', kind='', pointer_type='NOT', array=['3', '4'], lbound=['1', '1'], ubound=['3', '4'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='mat2vec(F%logical_2d, 3*4)', to_c2_type='logical(c_bool)', to_c2_name='z_logical_2d(*)', to_c2_f2_sub_arg='z_logical_2d', to_f2_type='logical(c_bool)', to_f2_name='z_logical_2d(*)', to_f2_trans='call vec2mat(z_logical_2d, F%logical_2d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%logical_2d .eqv. f2%logical_2d)\n', test_pat='do jd1 = 1, size(F%logical_2d,1); lb1 = lbound(F%logical_2d,1) - 1\ndo jd2 = 1, size(F%logical_2d,2); lb2 = lbound(F%logical_2d,2) - 1\n  rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n  F%logical_2d(jd1+lb1,jd2+lb2) = (modulo(rhs, 2) == 0)\nenddo; enddo\n', size_var=[], test_value='(modulo(rhs, 2) == 0)'), c_side=c_side_trans_class(c_class='FixedArray2D<Bool, 3, 4>', c_instantiation_suffix='', to_f_setup='  Bool z_logical_2d[3*4]; matrix_to_vec(C.logical_2d, z_logical_2d);\n', to_f_cleanup='', to_f2_arg='c_BoolArr', to_f2_call='z_logical_2d', to_c2_arg='c_BoolArr z_logical_2d', to_c2_set='  C.logical_2d << z_logical_2d;', class_initializer='', construct_value='false', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.logical_2d, y.logical_2d);\n', test_pat='  for (size_t i = 0; i < C.logical_2d.size(); i++)  for (size_t j = 0; j < C.logical_2d[0].size(); j++) \n    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.logical_2d[i][j] = (rhs % 2 == 0);}', test_value='(rhs % 2 == 0)'), split_line=[], intent='', optional=False)
        // Array property: logical_2d, type: FixedArray2D<Bool
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
        // CPP_all_encompassing.logical_3d: NOT arg.kind='' arg=Argument(is_component=True, f_name='logical_3d', c_name='logical_3d', type='logical', kind='', pointer_type='NOT', array=['3', '4', '5'], lbound=['1', '1', '1'], ubound=['3', '4', '5'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='tensor2vec(F%logical_3d, 3*4*5)', to_c2_type='logical(c_bool)', to_c2_name='z_logical_3d(*)', to_c2_f2_sub_arg='z_logical_3d', to_f2_type='logical(c_bool)', to_f2_name='z_logical_3d(*)', to_f2_trans='call vec2tensor(z_logical_3d, F%logical_3d)', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%logical_3d .eqv. f2%logical_3d)\n', test_pat='do jd1 = 1, size(F%logical_3d,1); lb1 = lbound(F%logical_3d,1) - 1\ndo jd2 = 1, size(F%logical_3d,2); lb2 = lbound(F%logical_3d,2) - 1\ndo jd3 = 1, size(F%logical_3d,3); lb3 = lbound(F%logical_3d,3) - 1\n  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n  F%logical_3d(jd1+lb1,jd2+lb2,jd3+lb3) = (modulo(rhs, 2) == 0)\nenddo; enddo; enddo\n', size_var=[], test_value='(modulo(rhs, 2) == 0)'), c_side=c_side_trans_class(c_class='FixedArray3D<Bool, 3, 4, 5>', c_instantiation_suffix='', to_f_setup='  Bool z_logical_3d[3*4*5]; tensor_to_vec(C.logical_3d, z_logical_3d);\n', to_f_cleanup='', to_f2_arg='c_BoolArr', to_f2_call='z_logical_3d', to_c2_arg='c_BoolArr z_logical_3d', to_c2_set='  C.logical_3d << z_logical_3d;', class_initializer='', construct_value='false', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.logical_3d, y.logical_3d);\n', test_pat='  for (size_t i = 0; i < C.logical_3d.size(); i++)  for (size_t j = 0; j < C.logical_3d[0].size(); j++)   for (size_t k = 0; k < C.logical_3d[0][0].size(); k++)\n    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; C.logical_3d[i][j][k] = (rhs % 2 == 0);}', test_value='(rhs % 2 == 0)'), split_line=[], intent='', optional=False)
        // Array property: logical_3d, type: FixedArray3D<Bool
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
        // CPP_all_encompassing.logical_0d_ptr: PTR arg.kind='' arg=Argument(is_component=True, f_name='logical_0d_ptr', c_name='logical_0d_ptr', type='logical', kind='', pointer_type='PTR', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n_logical_0d_ptr = 0\nif (associated(F%logical_0d_ptr)) n_logical_0d_ptr = 1\n', to_c2_call='fscalar2scalar(F%logical_0d_ptr, n_logical_0d_ptr)', to_c2_type='logical(c_bool)', to_c2_name='z_logical_0d_ptr', to_c2_f2_sub_arg='z_logical_0d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_logical_0d_ptr', to_f2_trans='if (n_logical_0d_ptr == 0) then                                                                                  \n  if (associated(F%logical_0d_ptr)) deallocate(F%logical_0d_ptr)                                                           \nelse                                                                                                   \n  call c_f_pointer (z_logical_0d_ptr, f_logical_0d_ptr)                                                                    \n  if (.not. associated(F%logical_0d_ptr)) allocate(F%logical_0d_ptr)                                                       \n  F%logical_0d_ptr = f_logic(f_logical_0d_ptr)\nendif                                                                                                  \n', to_f2_var=['logical(c_bool), pointer :: f_logical_0d_ptr'], equality_test='\nis_eq = is_eq .and. (associated(f1%logical_0d_ptr) .eqv. associated(f2%logical_0d_ptr))\nif (.not. is_eq) return\nif (associated(f1%logical_0d_ptr)) is_eq = (f1%logical_0d_ptr .eqv. f2%logical_0d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%logical_0d_ptr)) deallocate (F%logical_0d_ptr)\nelse\n  if (.not. associated(F%logical_0d_ptr)) allocate (F%logical_0d_ptr)\n  rhs = ARGIDX + offset\n  F%logical_0d_ptr = (modulo(rhs, 2) == 0)\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='shared_ptr<Bool>', c_instantiation_suffix='', to_f_setup='  size_t n_logical_0d_ptr = 0; if (C.logical_0d_ptr != nullptr) n_logical_0d_ptr = 1;\n', to_f_cleanup='', to_f2_arg='c_BoolArr', to_f2_call='C.logical_0d_ptr.get()', to_c2_arg='c_BoolArr z_logical_0d_ptr', to_c2_set='  if (n_logical_0d_ptr == 0) {\n    C.logical_0d_ptr = nullptr;\n  } else {\n    C.logical_0d_ptr = make_shared<Bool>();\n    *C.logical_0d_ptr = *z_logical_0d_ptr;\n  }\n', class_initializer='nullptr', construct_value='false', destructor='', equality_test='  is_eq = is_eq && ((x.logical_0d_ptr == NULL) == (y.logical_0d_ptr == NULL));\n  if (!is_eq) return false;\n  if (x.logical_0d_ptr != NULL) is_eq = (*x.logical_0d_ptr == *y.logical_0d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.logical_0d_ptr = nullptr;\n  else {\n    C.logical_0d_ptr = make_shared<Bool>();\n    rhs = ARGIDX + offset; (*C.logical_0d_ptr) = (rhs % 2 == 0);\n  }', test_value='(rhs % 2 == 0)'), split_line=['logical_0d_ptr'], intent='', optional=False)
        // PTR
        .def_property_readonly("logical_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.logical_0d_ptr ? py::cast(*self.logical_0d_ptr) : py::none(); },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_0d: NOT arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_0d', c_name='type_0d', type='type', kind='wake_lr_struct', pointer_type='NOT', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='', to_c2_call='c_loc(F%type_0d)', to_c2_type='type(c_ptr), value', to_c2_name='z_type_0d', to_c2_f2_sub_arg='z_type_0d', to_f2_type='type(c_ptr), value', to_f2_name='z_type_0d', to_f2_trans='call wake_lr_to_f(z_type_0d, c_loc(F%type_0d))', to_f2_var=[], equality_test='is_eq = is_eq .and. (f1%type_0d == f2%type_0d)\n', test_pat='call set_wake_lr_test_pattern (F%type_0d, ix_patt)\n', size_var=[], test_value='TEST_VALUE'), c_side=c_side_trans_class(c_class='CPP_wake_lr', c_instantiation_suffix='', to_f_setup='', to_f_cleanup='', to_f2_arg='const CPP_wake_lr&', to_f2_call='C.type_0d', to_c2_arg='const Opaque_wake_lr_class* z_type_0d', to_c2_set='  wake_lr_to_c(z_type_0d, C.type_0d);', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && (x.type_0d == y.type_0d);\n', test_pat='  set_CPP_wake_lr_test_pattern(C.type_0d, ix_patt);\n', test_value=''), split_line=['type_0d'], intent='', optional=False)
        // [default case]
        .def_property_readonly("type_0d",
            [](const CPP_all_encompassing &self) { return self.type_0d; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_1d: NOT arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_1d', c_name='type_1d', type='type', kind='wake_lr_struct', pointer_type='NOT', array=['3'], lbound=['1'], ubound=['3'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr) :: z_type_1d(3)'], to_c_trans='do jd1 = 1, size(F%type_1d,1); lb1 = lbound(F%type_1d,1) - 1\n  z_type_1d(jd1) = c_loc(F%type_1d(jd1+lb1))\nenddo\n', to_c2_call='z_type_1d', to_c2_type='type(c_ptr)', to_c2_name='z_type_1d(*)', to_c2_f2_sub_arg='z_type_1d', to_f2_type='type(c_ptr)', to_f2_name='z_type_1d(*)', to_f2_trans='do jd1 = 1, size(F%type_1d,1); lb1 = lbound(F%type_1d,1) - 1\n  call wake_lr_to_f(z_type_1d(jd1), c_loc(F%type_1d(jd1+lb1)))\nenddo', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_1d == f2%type_1d)\n', test_pat='do jd1 = 1, size(F%type_1d,1); lb1 = lbound(F%type_1d,1) - 1\n  rhs = 100 + jd1 + ARGIDX + offset\n  call set_wake_lr_test_pattern (F%type_1d(jd1+lb1), ix_patt+jd1)\nenddo\n', size_var=[], test_value='TEST_VALUE'), c_side=c_side_trans_class(c_class='FixedArray1D<CPP_wake_lr, 3>', c_instantiation_suffix='{VALUE}', to_f_setup='  const CPP_wake_lr* z_type_1d[3];\n  for (int i = 0; i < 3; i++) {z_type_1d[i] = &C.type_1d[i];}\n', to_f_cleanup='', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_1d', to_c2_arg='const Opaque_wake_lr_class** z_type_1d', to_c2_set='for (size_t i = 0; i < C.type_1d.size(); i++)\n{ wake_lr_to_c(z_type_1d[i], C.type_1d[i]); }', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_1d, y.type_1d);\n', test_pat='  for (size_t i = 0; i < C.type_1d.size(); i++)\n    {int rhs = 101 + i + ARGIDX + offset; set_CPP_wake_lr_test_pattern(C.type_1d[i], ix_patt+i+1);}', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_1d, type: FixedArray1D<CPP_wake_lr
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_wake_lr>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wake_lr objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_2d: NOT arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_2d', c_name='type_2d', type='type', kind='wake_lr_struct', pointer_type='NOT', array=['3', '4'], lbound=['1', '1'], ubound=['3', '4'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr) :: z_type_2d(3*4)'], to_c_trans='do jd1 = 1, size(F%type_2d,1); lb1 = lbound(F%type_2d,1) - 1\ndo jd2 = 1, size(F%type_2d,2); lb2 = lbound(F%type_2d,2) - 1\n  z_type_2d(4*(jd1-1) + jd2) = c_loc(F%type_2d(jd1+lb1,jd2+lb2))\nenddo; enddo\n', to_c2_call='z_type_2d', to_c2_type='type(c_ptr)', to_c2_name='z_type_2d(*)', to_c2_f2_sub_arg='z_type_2d', to_f2_type='type(c_ptr)', to_f2_name='z_type_2d(*)', to_f2_trans='do jd1 = 1, size(F%type_2d,1); lb1 = lbound(F%type_2d,1) - 1\ndo jd2 = 1, size(F%type_2d,2); lb2 = lbound(F%type_2d,2) - 1\n  call wake_lr_to_f(z_type_2d(4*(jd1-1) + jd2), c_loc(F%type_2d(jd1+lb1,jd2+lb2)))\nenddo; enddo\n', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_2d == f2%type_2d)\n', test_pat='do jd1 = 1, size(F%type_2d,1); lb1 = lbound(F%type_2d,1) - 1\ndo jd2 = 1, size(F%type_2d,2); lb2 = lbound(F%type_2d,2) - 1\n  rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n  call set_wake_lr_test_pattern (F%type_2d(jd1+lb1,jd2+lb2), ix_patt+jd1+10*jd2)\nenddo; enddo\n', size_var=[], test_value='TEST_VALUE'), c_side=c_side_trans_class(c_class='SharedVector2D<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='  const CPP_wake_lr* z_type_2d[3*4];\n  for (size_t i = 0; i < C.type_2d.size(); i++)  for (size_t j = 0; j < C.type_2d[0].size(); j++) \n    {auto m = 4*i + j; z_type_2d[m] = C.type_2d[i][j].get();}\n', to_f_cleanup='', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_2d', to_c2_arg='const Opaque_wake_lr_class** z_type_2d', to_c2_set='  for (size_t i = 0; i < C.type_2d.size(); i++)  for (size_t j = 0; j < C.type_2d[0].size(); j++) \n    {auto m = 4*i + j; wake_lr_to_c(z_type_2d[m], *C.type_2d[i][j].get());}', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_2d, y.type_2d);\n', test_pat='  for (size_t i = 0; i < C.type_2d.size(); i++)  for (size_t j = 0; j < C.type_2d[0].size(); j++) \n    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; set_CPP_wake_lr_test_pattern(*C.type_2d[i][j], ix_patt+i+1+10*(j+1));}', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_2d, type: SharedVector2D<CPP_wake_lr>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_wake_lr objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_3d: NOT arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_3d', c_name='type_3d', type='type', kind='wake_lr_struct', pointer_type='NOT', array=['3', '4', '5'], lbound=['1', '1', '1'], ubound=['3', '4', '5'], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr) :: z_type_3d(3*4*5)'], to_c_trans='do jd1 = 1, size(F%type_3d,1); lb1 = lbound(F%type_3d,1) - 1\ndo jd2 = 1, size(F%type_3d,2); lb2 = lbound(F%type_3d,2) - 1\ndo jd3 = 1, size(F%type_3d,3); lb3 = lbound(F%type_3d,3) - 1\n  z_type_3d(5*4*(jd1-1) + 5*(jd2-1) + jd3) = c_loc(F%type_3d(jd1+lb1,jd2+lb2,jd3+lb3))\nenddo; enddo; enddo\n', to_c2_call='z_type_3d', to_c2_type='type(c_ptr)', to_c2_name='z_type_3d(*)', to_c2_f2_sub_arg='z_type_3d', to_f2_type='type(c_ptr)', to_f2_name='z_type_3d(*)', to_f2_trans='do jd1 = 1, size(F%type_3d,1); lb1 = lbound(F%type_3d,1) - 1\ndo jd2 = 1, size(F%type_3d,2); lb2 = lbound(F%type_3d,2) - 1\ndo jd3 = 1, size(F%type_3d,3); lb3 = lbound(F%type_3d,3) - 1\n  call wake_lr_to_f(z_type_3d(5*4*(jd1-1) + 5*(jd2-1) + jd3), c_loc(F%type_3d(jd1+lb1,jd2+lb2,jd3+lb3)))\nenddo; enddo; enddo\n', to_f2_var=[], equality_test='is_eq = is_eq .and. all(f1%type_3d == f2%type_3d)\n', test_pat='do jd1 = 1, size(F%type_3d,1); lb1 = lbound(F%type_3d,1) - 1\ndo jd2 = 1, size(F%type_3d,2); lb2 = lbound(F%type_3d,2) - 1\ndo jd3 = 1, size(F%type_3d,3); lb3 = lbound(F%type_3d,3) - 1\n  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n  call set_wake_lr_test_pattern (F%type_3d(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+10*jd2+100*jd3)\nenddo; enddo; enddo\n', size_var=[], test_value='TEST_VALUE'), c_side=c_side_trans_class(c_class='SharedVector3D<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='  const CPP_wake_lr* z_type_3d[3*4*5];\n  for (size_t i = 0; i < C.type_3d.size(); i++)  for (size_t j = 0; j < C.type_3d[0].size(); j++)   for (size_t k = 0; k < C.type_3d[0][0].size(); k++)\n    {auto m = 5*4*i + 5*j + k; z_type_3d[m] = C.type_3d[i][j][k].get();}\n', to_f_cleanup='', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_3d', to_c2_arg='const Opaque_wake_lr_class** z_type_3d', to_c2_set='  for (size_t i = 0; i < C.type_3d.size(); i++)  for (size_t j = 0; j < C.type_3d[0].size(); j++)   for (size_t k = 0; k < C.type_3d[0][0].size(); k++)\n    {auto m = 5*4*i + 5*j + k; wake_lr_to_c(z_type_3d[m], *C.type_3d[i][j][k].get());}', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_3d, y.type_3d);\n', test_pat='  for (size_t i = 0; i < C.type_3d.size(); i++)  for (size_t j = 0; j < C.type_3d[0].size(); j++)   for (size_t k = 0; k < C.type_3d[0][0].size(); k++)\n    {int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; set_CPP_wake_lr_test_pattern(*C.type_3d[i][j][k], ix_patt+i+1+10*(j+1)+100*(k+1));}', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_3d, type: SharedVector3D<CPP_wake_lr>
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
        // CPP_all_encompassing.type_0d_ptr: PTR arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_0d_ptr', c_name='type_0d_ptr', type='type', kind='wake_lr_struct', pointer_type='PTR', array=[], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=[], to_c_trans='n_type_0d_ptr = 0\nif (associated(F%type_0d_ptr)) n_type_0d_ptr = 1\n', to_c2_call='c_loc(F%type_0d_ptr)', to_c2_type='type(c_ptr), value', to_c2_name='z_type_0d_ptr', to_c2_f2_sub_arg='z_type_0d_ptr', to_f2_type='type(c_ptr), value', to_f2_name='z_type_0d_ptr', to_f2_trans='if (n_type_0d_ptr == 0) then\n  if (associated(F%type_0d_ptr)) deallocate(F%type_0d_ptr)\nelse\n  if (.not. associated(F%type_0d_ptr)) allocate(F%type_0d_ptr)\n  call wake_lr_to_f (z_type_0d_ptr, c_loc(F%type_0d_ptr))\nendif\n', to_f2_var=['type(wake_lr_struct), pointer :: f_type_0d_ptr'], equality_test='\nis_eq = is_eq .and. (associated(f1%type_0d_ptr) .eqv. associated(f2%type_0d_ptr))\nif (.not. is_eq) return\nif (associated(f1%type_0d_ptr)) is_eq = (f1%type_0d_ptr == f2%type_0d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%type_0d_ptr)) deallocate (F%type_0d_ptr)\nelse\n  if (.not. associated(F%type_0d_ptr)) allocate (F%type_0d_ptr)\n  rhs = ARGIDX + offset\n  call set_wake_lr_test_pattern (F%type_0d_ptr, ix_patt)\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='shared_ptr<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='  size_t n_type_0d_ptr = 0; if (C.type_0d_ptr != nullptr) n_type_0d_ptr = 1;\n', to_f_cleanup='', to_f2_arg='const CPP_wake_lr&', to_f2_call='*C.type_0d_ptr', to_c2_arg='Opaque_wake_lr_class* z_type_0d_ptr', to_c2_set='  if (n_type_0d_ptr == 0) {\n    C.type_0d_ptr = nullptr;\n  } else {\n    C.type_0d_ptr = make_shared<CPP_wake_lr>();\n    wake_lr_to_c(z_type_0d_ptr, *C.type_0d_ptr);\n  }\n', class_initializer='nullptr', construct_value='', destructor='', equality_test='  is_eq = is_eq && ((x.type_0d_ptr == NULL) == (y.type_0d_ptr == NULL));\n  if (!is_eq) return false;\n  if (x.type_0d_ptr != NULL) is_eq = (*x.type_0d_ptr == *y.type_0d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.type_0d_ptr = nullptr;\n  else {\n    C.type_0d_ptr = make_shared<CPP_wake_lr>();\n    set_CPP_wake_lr_test_pattern((*C.type_0d_ptr), ix_patt);\n  }', test_value=''), split_line=['type_0d_ptr'], intent='', optional=False)
        // PTR, _struct in kind
        .def_property_readonly("type_0d_ptr",
            [](const CPP_all_encompassing &self) { return self.type_0d_ptr; },
            py::return_value_policy::copy,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_1d_ptr: PTR arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_1d_ptr', c_name='type_1d_ptr', type='type', kind='wake_lr_struct', pointer_type='PTR', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr), allocatable :: z_type_1d_ptr(:)'], to_c_trans=' n1_type_1d_ptr = 0\nif (associated(F%type_1d_ptr)) then\n  n1_type_1d_ptr = size(F%type_1d_ptr); lb1 = lbound(F%type_1d_ptr, 1) - 1\n  allocate (z_type_1d_ptr(n1_type_1d_ptr))\n  do jd1 = 1, n1_type_1d_ptr\n    z_type_1d_ptr(jd1) = c_loc(F%type_1d_ptr(jd1+lb1))\n  enddo\nendif\n', to_c2_call='z_type_1d_ptr', to_c2_type='type(c_ptr)', to_c2_name='z_type_1d_ptr(*)', to_c2_f2_sub_arg='z_type_1d_ptr', to_f2_type='type(c_ptr)', to_f2_name='z_type_1d_ptr(*)', to_f2_trans='if (n1_type_1d_ptr == 0) then\n  if (associated(F%type_1d_ptr)) deallocate(F%type_1d_ptr)\nelse\n  if (associated(F%type_1d_ptr)) then\n    if (n1_type_1d_ptr == 0 .or. any(shape(F%type_1d_ptr) /= [n1_type_1d_ptr])) deallocate(F%type_1d_ptr)\n    if (any(lbound(F%type_1d_ptr) /= 1)) deallocate(F%type_1d_ptr)\n  endif\n  if (.not. associated(F%type_1d_ptr)) allocate(F%type_1d_ptr(1:n1_type_1d_ptr+1-1))\n  do jd1 = 1, n1_type_1d_ptr\n    call wake_lr_to_f (z_type_1d_ptr(jd1), c_loc(F%type_1d_ptr(jd1+1-1)))\n  enddo\nendif\n', to_f2_var=[], equality_test='is_eq = is_eq .and. (associated(f1%type_1d_ptr) .eqv. associated(f2%type_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%type_1d_ptr)) is_eq = all(shape(f1%type_1d_ptr) == shape(f2%type_1d_ptr))\nif (.not. is_eq) return\nif (associated(f1%type_1d_ptr)) is_eq = all(f1%type_1d_ptr == f2%type_1d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%type_1d_ptr)) deallocate (F%type_1d_ptr)\nelse\n  if (.not. associated(F%type_1d_ptr)) allocate (F%type_1d_ptr(-1:1))\n  do jd1 = 1, size(F%type_1d_ptr,1); lb1 = lbound(F%type_1d_ptr,1) - 1\n    call set_wake_lr_test_pattern (F%type_1d_ptr(jd1+lb1), ix_patt+jd1)\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='  auto n1_type_1d_ptr = C.type_1d_ptr.size();\n  const CPP_wake_lr** z_type_1d_ptr = nullptr;\n  if (n1_type_1d_ptr != 0) {\n    z_type_1d_ptr = new const CPP_wake_lr*[n1_type_1d_ptr];\n    for (auto i{0}; i < n1_type_1d_ptr; i++) z_type_1d_ptr[i] = &C.type_1d_ptr[i];\n  }\n', to_f_cleanup=' if (z_type_1d_ptr) delete[] z_type_1d_ptr;\n', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_1d_ptr', to_c2_arg='Opaque_wake_lr_class** z_type_1d_ptr', to_c2_set='  C.type_1d_ptr.resize(n1_type_1d_ptr);\n  for (auto i{0}; i < n1_type_1d_ptr; i++) { wake_lr_to_c(z_type_1d_ptr[i], C.type_1d_ptr[i]); }\n', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_1d_ptr, y.type_1d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.type_1d_ptr.resize(0);\n  else {\n    C.type_1d_ptr.resize(3);\n    for (size_t i = 0; i < C.type_1d_ptr.size(); i++)  {set_CPP_wake_lr_test_pattern(C.type_1d_ptr[i], ix_patt+i+1);}\n  }\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_1d_ptr, type: VariableArray1D<CPP_wake_lr>
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_wake_lr>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wake_lr objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_2d_ptr: PTR arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_2d_ptr', c_name='type_2d_ptr', type='type', kind='wake_lr_struct', pointer_type='PTR', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr), allocatable :: z_type_2d_ptr(:)'], to_c_trans='if (associated(F%type_2d_ptr)) then\n  n1_type_2d_ptr = size(F%type_2d_ptr, 1); lb1 = lbound(F%type_2d_ptr, 1) - 1\n  n2_type_2d_ptr = size(F%type_2d_ptr, 2); lb2 = lbound(F%type_2d_ptr, 2) - 1\n  allocate (z_type_2d_ptr(n1_type_2d_ptr * n2_type_2d_ptr))\n  do jd1 = 1, n1_type_2d_ptr; do jd2 = 1, n2_type_2d_ptr\n    z_type_2d_ptr(n2_type_2d_ptr*(jd1-1) + jd2) = c_loc(F%type_2d_ptr(jd1+lb1, jd2+lb2))\n  enddo;  enddo\nelse\n  n1_type_2d_ptr = 0; n2_type_2d_ptr = 0\nendif\n', to_c2_call='z_type_2d_ptr', to_c2_type='type(c_ptr)', to_c2_name='z_type_2d_ptr(*)', to_c2_f2_sub_arg='z_type_2d_ptr', to_f2_type='type(c_ptr)', to_f2_name='z_type_2d_ptr(*)', to_f2_trans='if (n1_type_2d_ptr == 0) then\n  if (associated(F%type_2d_ptr)) deallocate(F%type_2d_ptr)\nelse\n  if (associated(F%type_2d_ptr)) then\n    if (n1_type_2d_ptr == 0 .or. any(shape(F%type_2d_ptr) /= [n1_type_2d_ptr, n2_type_2d_ptr])) deallocate(F%type_2d_ptr)\n    if (any(lbound(F%type_2d_ptr) /= 1)) deallocate(F%type_2d_ptr)\n  endif\n  if (.not. associated(F%type_2d_ptr)) allocate(F%type_2d_ptr(1:n1_type_2d_ptr+1-1, 1:n2_type_2d_ptr+1-1))\n  do jd1 = 1, n1_type_2d_ptr\n  do jd2 = 1, n2_type_2d_ptr\n    call wake_lr_to_f (z_type_2d_ptr(n2_type_2d_ptr*(jd1-1) + jd2), c_loc(F%type_2d_ptr(jd1+1-1,jd2+1-1)))\n  enddo\n  enddo\nendif\n', to_f2_var=[], equality_test='is_eq = is_eq .and. (associated(f1%type_2d_ptr) .eqv. associated(f2%type_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%type_2d_ptr)) is_eq = all(shape(f1%type_2d_ptr) == shape(f2%type_2d_ptr))\nif (.not. is_eq) return\nif (associated(f1%type_2d_ptr)) is_eq = all(f1%type_2d_ptr == f2%type_2d_ptr)\n', test_pat='\nif (ix_patt < 3) then\n  if (associated(F%type_2d_ptr)) deallocate (F%type_2d_ptr)\nelse\n  if (.not. associated(F%type_2d_ptr)) allocate (F%type_2d_ptr(-1:1, 2))\n  do jd1 = 1, size(F%type_2d_ptr,1); lb1 = lbound(F%type_2d_ptr,1) - 1\n  do jd2 = 1, size(F%type_2d_ptr,2); lb2 = lbound(F%type_2d_ptr,2) - 1\n    call set_wake_lr_test_pattern (F%type_2d_ptr(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)\n  enddo\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='\n  auto n1_type_2d_ptr { C.type_2d_ptr.size() };\n  auto n2_type_2d_ptr { std::size_t{0} };\n  const CPP_wake_lr** z_type_2d_ptr { nullptr };\n  if (n1_type_2d_ptr > 0) {\n    n2_type_2d_ptr = C.type_2d_ptr[0].size();\n    z_type_2d_ptr = new const CPP_wake_lr* [n1_type_2d_ptr*n2_type_2d_ptr];\n    for (auto i{0}; i < n1_type_2d_ptr; i++) {\n      for (auto j{0}; j < n2_type_2d_ptr; j++) {\n        z_type_2d_ptr[i*n2_type_2d_ptr + j] = &C.type_2d_ptr[i][j];\n      }\n    }\n  }\n', to_f_cleanup='  if (z_type_2d_ptr) delete[] z_type_2d_ptr;\n', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_2d_ptr', to_c2_arg='Opaque_wake_lr_class** z_type_2d_ptr', to_c2_set='  C.type_2d_ptr.resize(n1_type_2d_ptr);\n  for (auto i{0}; i < n1_type_2d_ptr; i++) {\n    C.type_2d_ptr[i].resize(n2_type_2d_ptr);\n    for (auto j{0}; j < n2_type_2d_ptr; j++) {\n        auto &item = C.type_2d_ptr[i][j];\n        wake_lr_to_c(z_type_2d_ptr[n2_type_2d_ptr*i+j], item);\n    }\n  }\n', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_2d_ptr, y.type_2d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.type_2d_ptr.resize(0);\n  else {\n    C.type_2d_ptr.resize(3);\n    for (size_t i = 0; i < C.type_2d_ptr.size(); i++) {\n      C.type_2d_ptr[i].resize(2);\n\n      for (size_t j = 0; j < C.type_2d_ptr[0].size(); j++) {\n        auto &item = C.type_2d_ptr[i][j];\n        set_CPP_wake_lr_test_pattern(item, ix_patt+i+2*j+3);\n      }\n    }\n  }\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_2d_ptr, type: VariableArray2D<CPP_wake_lr>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_wake_lr objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_3d_ptr: PTR arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_3d_ptr', c_name='type_3d_ptr', type='type', kind='wake_lr_struct', pointer_type='PTR', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr), allocatable :: z_type_3d_ptr(:)'], to_c_trans='if (associated(F%type_3d_ptr)) then\n  n1_type_3d_ptr = size(F%type_3d_ptr, 1); lb1 = lbound(F%type_3d_ptr, 1) - 1\n  n2_type_3d_ptr = size(F%type_3d_ptr, 2); lb2 = lbound(F%type_3d_ptr, 2) - 1\n  n3_type_3d_ptr = size(F%type_3d_ptr, 3); lb3 = lbound(F%type_3d_ptr, 3) - 1\n  allocate (z_type_3d_ptr(n1_type_3d_ptr * n2_type_3d_ptr * n3_type_3d_ptr))\n  do jd1 = 1, n1_type_3d_ptr; do jd2 = 1, n2_type_3d_ptr; do jd3 = 1, n3_type_3d_ptr\n    z_type_3d_ptr(n3_type_3d_ptr*n2_type_3d_ptr*(jd1-1) + n3_type_3d_ptr*(jd2-1) + jd3) = c_loc(F%type_3d_ptr(jd1+lb1, jd2+lb2, jd3+lb3))\n  enddo;  enddo; enddo\nelse\n  n1_type_3d_ptr = 0; n2_type_3d_ptr = 0; n3_type_3d_ptr = 0\nendif\n', to_c2_call='z_type_3d_ptr', to_c2_type='type(c_ptr)', to_c2_name='z_type_3d_ptr(*)', to_c2_f2_sub_arg='z_type_3d_ptr', to_f2_type='type(c_ptr)', to_f2_name='z_type_3d_ptr(*)', to_f2_trans='if (n1_type_3d_ptr == 0) then\n  if (associated(F%type_3d_ptr)) deallocate(F%type_3d_ptr)\nelse\n  if (associated(F%type_3d_ptr)) then\n    if (n1_type_3d_ptr == 0 .or. any(shape(F%type_3d_ptr) /= [n1_type_3d_ptr, n2_type_3d_ptr, n3_type_3d_ptr])) deallocate(F%type_3d_ptr)\n    if (any(lbound(F%type_3d_ptr) /= 1)) deallocate(F%type_3d_ptr)\n  endif\n  if (.not. associated(F%type_3d_ptr)) allocate(F%type_3d_ptr(1:n1_type_3d_ptr+1-1, 1:n2_type_3d_ptr+1-1, 1:n3_type_3d_ptr+1-1))\n  do jd1 = 1, n1_type_3d_ptr;  do jd2 = 1, n2_type_3d_ptr;  do jd3 = 1, n3_type_3d_ptr\n    call wake_lr_to_f (z_type_3d_ptr(n3_type_3d_ptr*n2_type_3d_ptr*(jd1-1) + n3_type_3d_ptr*(jd2-1) + jd3), c_loc(F%type_3d_ptr(jd1+1-1,jd2+1-1,jd3+1-1)))\n  enddo;  enddo;  enddo\nendif\n', to_f2_var=[], equality_test='is_eq = is_eq .and. (associated(f1%type_3d_ptr) .eqv. associated(f2%type_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%type_3d_ptr)) is_eq = all(shape(f1%type_3d_ptr) == shape(f2%type_3d_ptr))\nif (.not. is_eq) return\nif (associated(f1%type_3d_ptr)) is_eq = all(f1%type_3d_ptr == f2%type_3d_ptr)\n', test_pat='if (ix_patt < 3) then\n  if (associated(F%type_3d_ptr)) deallocate (F%type_3d_ptr)\nelse\n  if (.not. associated(F%type_3d_ptr)) allocate (F%type_3d_ptr(-1:1, 2, 1))\n  do jd1 = 1, size(F%type_3d_ptr,1); lb1 = lbound(F%type_3d_ptr,1) - 1\n  do jd2 = 1, size(F%type_3d_ptr,2); lb2 = lbound(F%type_3d_ptr,2) - 1\n  do jd3 = 1, size(F%type_3d_ptr,3); lb3 = lbound(F%type_3d_ptr,3) - 1\n    call set_wake_lr_test_pattern (F%type_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+2*jd2+3*jd3)\n  enddo\n  enddo\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='\n  auto n1_type_3d_ptr { C.type_3d_ptr.size() };\n  auto n2_type_3d_ptr { std::size_t{0} };\n  auto n3_type_3d_ptr { std::size_t{0} };\n  const CPP_wake_lr** z_type_3d_ptr { nullptr };\n  if (n1_type_3d_ptr > 0) {\n    n2_type_3d_ptr = C.type_3d_ptr[0].size();\n    n3_type_3d_ptr = C.type_3d_ptr[0][0].size();\n    z_type_3d_ptr = new const CPP_wake_lr* [n1_type_3d_ptr*n2_type_3d_ptr*n3_type_3d_ptr];\n    for (auto i{0}; i < n1_type_3d_ptr; i++) {\n      for (auto j{0}; j < n2_type_3d_ptr; j++) {\n        for (auto k{0}; k < n3_type_3d_ptr; k++) {\n          z_type_3d_ptr[i*n2_type_3d_ptr*n3_type_3d_ptr + j*n3_type_3d_ptr + k] = &C.type_3d_ptr[i][j][k];\n        }\n      }\n    }\n  }\n', to_f_cleanup='  if (z_type_3d_ptr) delete[] z_type_3d_ptr;\n', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_3d_ptr', to_c2_arg='Opaque_wake_lr_class** z_type_3d_ptr', to_c2_set='\n  C.type_3d_ptr.resize(n1_type_3d_ptr);\n  for (auto i{0}; i < n1_type_3d_ptr; i++) {\n    C.type_3d_ptr[i].resize(n2_type_3d_ptr);\n    for (auto j{0}; j < n2_type_3d_ptr; j++) {\n      C.type_3d_ptr[i][j].resize(n3_type_3d_ptr);\n      for (auto k{0}; k < n3_type_3d_ptr; k++) {\n        // C.type_3d_ptr[i][j][k] = make_shared<CPP_wake_lr>();\n        wake_lr_to_c(z_type_3d_ptr[n3_type_3d_ptr*n2_type_3d_ptr*i+n3_type_3d_ptr*j+k], C.type_3d_ptr[i][j][k]);\n    } } }\n', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_3d_ptr, y.type_3d_ptr);\n', test_pat='  if (ix_patt < 3) \n    C.type_3d_ptr.resize(0);\n  else {\n    C.type_3d_ptr.resize(3);\n    for (size_t i = 0; i < C.type_3d_ptr.size(); i++) {\n      C.type_3d_ptr[i].resize(2);\n      for (size_t j = 0; j < C.type_3d_ptr[0].size(); j++) {\n        C.type_3d_ptr[i][j].resize(1);\n        for (size_t k = 0; k < C.type_3d_ptr[0][0].size(); k++) {\n          // C.type_3d_ptr[i][j][k] = make_shared<CPP_wake_lr>();\n          set_CPP_wake_lr_test_pattern(C.type_3d_ptr[i][j][k], ix_patt+i+2*j+3*k+6);\n        }\n      }\n    }\n  }\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_3d_ptr, type: VariableArray3D<CPP_wake_lr>
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
        // CPP_all_encompassing.type_1d_alloc: ALLOC arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_1d_alloc', c_name='type_1d_alloc', type='type', kind='wake_lr_struct', pointer_type='ALLOC', array=[':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr), allocatable :: z_type_1d_alloc(:)'], to_c_trans=' n1_type_1d_alloc = 0\nif (allocated(F%type_1d_alloc)) then\n  n1_type_1d_alloc = size(F%type_1d_alloc); lb1 = lbound(F%type_1d_alloc, 1) - 1\n  allocate (z_type_1d_alloc(n1_type_1d_alloc))\n  do jd1 = 1, n1_type_1d_alloc\n    z_type_1d_alloc(jd1) = c_loc(F%type_1d_alloc(jd1+lb1))\n  enddo\nendif\n', to_c2_call='z_type_1d_alloc', to_c2_type='type(c_ptr)', to_c2_name='z_type_1d_alloc(*)', to_c2_f2_sub_arg='z_type_1d_alloc', to_f2_type='type(c_ptr)', to_f2_name='z_type_1d_alloc(*)', to_f2_trans='if (n1_type_1d_alloc == 0) then\n  if (allocated(F%type_1d_alloc)) deallocate(F%type_1d_alloc)\nelse\n  if (allocated(F%type_1d_alloc)) then\n    if (n1_type_1d_alloc == 0 .or. any(shape(F%type_1d_alloc) /= [n1_type_1d_alloc])) deallocate(F%type_1d_alloc)\n    if (any(lbound(F%type_1d_alloc) /= 1)) deallocate(F%type_1d_alloc)\n  endif\n  if (.not. allocated(F%type_1d_alloc)) allocate(F%type_1d_alloc(1:n1_type_1d_alloc+1-1))\n  do jd1 = 1, n1_type_1d_alloc\n    call wake_lr_to_f (z_type_1d_alloc(jd1), c_loc(F%type_1d_alloc(jd1+1-1)))\n  enddo\nendif\n', to_f2_var=[], equality_test='is_eq = is_eq .and. (allocated(f1%type_1d_alloc) .eqv. allocated(f2%type_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%type_1d_alloc)) is_eq = all(shape(f1%type_1d_alloc) == shape(f2%type_1d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%type_1d_alloc)) is_eq = all(f1%type_1d_alloc == f2%type_1d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%type_1d_alloc)) deallocate (F%type_1d_alloc)\nelse\n  if (.not. allocated(F%type_1d_alloc)) allocate (F%type_1d_alloc(-1:1))\n  do jd1 = 1, size(F%type_1d_alloc,1); lb1 = lbound(F%type_1d_alloc,1) - 1\n    call set_wake_lr_test_pattern (F%type_1d_alloc(jd1+lb1), ix_patt+jd1)\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray1D<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='  auto n1_type_1d_alloc = C.type_1d_alloc.size();\n  const CPP_wake_lr** z_type_1d_alloc = nullptr;\n  if (n1_type_1d_alloc != 0) {\n    z_type_1d_alloc = new const CPP_wake_lr*[n1_type_1d_alloc];\n    for (auto i{0}; i < n1_type_1d_alloc; i++) z_type_1d_alloc[i] = &C.type_1d_alloc[i];\n  }\n', to_f_cleanup=' if (z_type_1d_alloc) delete[] z_type_1d_alloc;\n', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_1d_alloc', to_c2_arg='Opaque_wake_lr_class** z_type_1d_alloc', to_c2_set='  C.type_1d_alloc.resize(n1_type_1d_alloc);\n  for (auto i{0}; i < n1_type_1d_alloc; i++) { wake_lr_to_c(z_type_1d_alloc[i], C.type_1d_alloc[i]); }\n', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_1d_alloc, y.type_1d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.type_1d_alloc.resize(0);\n  else {\n    C.type_1d_alloc.resize(3);\n    for (size_t i = 0; i < C.type_1d_alloc.size(); i++)  {set_CPP_wake_lr_test_pattern(C.type_1d_alloc[i], ix_patt+i+1);}\n  }\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_1d_alloc, type: VariableArray1D<CPP_wake_lr>
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
                //         arr[i] = list[i].cast<shared_ptr<CPP_wake_lr>>();
                //     }
                // } catch (const py::cast_error& e) {
                //     throw std::runtime_error("Expected a list of CPP_wake_lr objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_2d_alloc: ALLOC arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_2d_alloc', c_name='type_2d_alloc', type='type', kind='wake_lr_struct', pointer_type='ALLOC', array=[':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr), allocatable :: z_type_2d_alloc(:)'], to_c_trans='if (allocated(F%type_2d_alloc)) then\n  n1_type_2d_alloc = size(F%type_2d_alloc, 1); lb1 = lbound(F%type_2d_alloc, 1) - 1\n  n2_type_2d_alloc = size(F%type_2d_alloc, 2); lb2 = lbound(F%type_2d_alloc, 2) - 1\n  allocate (z_type_2d_alloc(n1_type_2d_alloc * n2_type_2d_alloc))\n  do jd1 = 1, n1_type_2d_alloc; do jd2 = 1, n2_type_2d_alloc\n    z_type_2d_alloc(n2_type_2d_alloc*(jd1-1) + jd2) = c_loc(F%type_2d_alloc(jd1+lb1, jd2+lb2))\n  enddo;  enddo\nelse\n  n1_type_2d_alloc = 0; n2_type_2d_alloc = 0\nendif\n', to_c2_call='z_type_2d_alloc', to_c2_type='type(c_ptr)', to_c2_name='z_type_2d_alloc(*)', to_c2_f2_sub_arg='z_type_2d_alloc', to_f2_type='type(c_ptr)', to_f2_name='z_type_2d_alloc(*)', to_f2_trans='if (n1_type_2d_alloc == 0) then\n  if (allocated(F%type_2d_alloc)) deallocate(F%type_2d_alloc)\nelse\n  if (allocated(F%type_2d_alloc)) then\n    if (n1_type_2d_alloc == 0 .or. any(shape(F%type_2d_alloc) /= [n1_type_2d_alloc, n2_type_2d_alloc])) deallocate(F%type_2d_alloc)\n    if (any(lbound(F%type_2d_alloc) /= 1)) deallocate(F%type_2d_alloc)\n  endif\n  if (.not. allocated(F%type_2d_alloc)) allocate(F%type_2d_alloc(1:n1_type_2d_alloc+1-1, 1:n2_type_2d_alloc+1-1))\n  do jd1 = 1, n1_type_2d_alloc\n  do jd2 = 1, n2_type_2d_alloc\n    call wake_lr_to_f (z_type_2d_alloc(n2_type_2d_alloc*(jd1-1) + jd2), c_loc(F%type_2d_alloc(jd1+1-1,jd2+1-1)))\n  enddo\n  enddo\nendif\n', to_f2_var=[], equality_test='is_eq = is_eq .and. (allocated(f1%type_2d_alloc) .eqv. allocated(f2%type_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%type_2d_alloc)) is_eq = all(shape(f1%type_2d_alloc) == shape(f2%type_2d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%type_2d_alloc)) is_eq = all(f1%type_2d_alloc == f2%type_2d_alloc)\n', test_pat='\nif (ix_patt < 3) then\n  if (allocated(F%type_2d_alloc)) deallocate (F%type_2d_alloc)\nelse\n  if (.not. allocated(F%type_2d_alloc)) allocate (F%type_2d_alloc(-1:1, 2))\n  do jd1 = 1, size(F%type_2d_alloc,1); lb1 = lbound(F%type_2d_alloc,1) - 1\n  do jd2 = 1, size(F%type_2d_alloc,2); lb2 = lbound(F%type_2d_alloc,2) - 1\n    call set_wake_lr_test_pattern (F%type_2d_alloc(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)\n  enddo\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray2D<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='\n  auto n1_type_2d_alloc { C.type_2d_alloc.size() };\n  auto n2_type_2d_alloc { std::size_t{0} };\n  const CPP_wake_lr** z_type_2d_alloc { nullptr };\n  if (n1_type_2d_alloc > 0) {\n    n2_type_2d_alloc = C.type_2d_alloc[0].size();\n    z_type_2d_alloc = new const CPP_wake_lr* [n1_type_2d_alloc*n2_type_2d_alloc];\n    for (auto i{0}; i < n1_type_2d_alloc; i++) {\n      for (auto j{0}; j < n2_type_2d_alloc; j++) {\n        z_type_2d_alloc[i*n2_type_2d_alloc + j] = &C.type_2d_alloc[i][j];\n      }\n    }\n  }\n', to_f_cleanup='  if (z_type_2d_alloc) delete[] z_type_2d_alloc;\n', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_2d_alloc', to_c2_arg='Opaque_wake_lr_class** z_type_2d_alloc', to_c2_set='  C.type_2d_alloc.resize(n1_type_2d_alloc);\n  for (auto i{0}; i < n1_type_2d_alloc; i++) {\n    C.type_2d_alloc[i].resize(n2_type_2d_alloc);\n    for (auto j{0}; j < n2_type_2d_alloc; j++) {\n        auto &item = C.type_2d_alloc[i][j];\n        wake_lr_to_c(z_type_2d_alloc[n2_type_2d_alloc*i+j], item);\n    }\n  }\n', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_2d_alloc, y.type_2d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.type_2d_alloc.resize(0);\n  else {\n    C.type_2d_alloc.resize(3);\n    for (size_t i = 0; i < C.type_2d_alloc.size(); i++) {\n      C.type_2d_alloc[i].resize(2);\n\n      for (size_t j = 0; j < C.type_2d_alloc[0].size(); j++) {\n        auto &item = C.type_2d_alloc[i][j];\n        set_CPP_wake_lr_test_pattern(item, ix_patt+i+2*j+3);\n      }\n    }\n  }\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_2d_alloc, type: VariableArray2D<CPP_wake_lr>
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
                //     throw std::runtime_error("Expected a list of lists of CPP_wake_lr objects");
                // }
                
            },
            py::return_value_policy::reference_internal,
            "Property from Fortran struct")
        // CPP_all_encompassing.type_3d_alloc: ALLOC arg.kind='wake_lr_struct' arg=Argument(is_component=True, f_name='type_3d_alloc', c_name='type_3d_alloc', type='type', kind='wake_lr_struct', pointer_type='ALLOC', array=[':', ':', ':'], lbound=[], ubound=[], init_value='', comment='', f_side=f_side_trans_class(to_c_var=['type(c_ptr), allocatable :: z_type_3d_alloc(:)'], to_c_trans='if (allocated(F%type_3d_alloc)) then\n  n1_type_3d_alloc = size(F%type_3d_alloc, 1); lb1 = lbound(F%type_3d_alloc, 1) - 1\n  n2_type_3d_alloc = size(F%type_3d_alloc, 2); lb2 = lbound(F%type_3d_alloc, 2) - 1\n  n3_type_3d_alloc = size(F%type_3d_alloc, 3); lb3 = lbound(F%type_3d_alloc, 3) - 1\n  allocate (z_type_3d_alloc(n1_type_3d_alloc * n2_type_3d_alloc * n3_type_3d_alloc))\n  do jd1 = 1, n1_type_3d_alloc; do jd2 = 1, n2_type_3d_alloc; do jd3 = 1, n3_type_3d_alloc\n    z_type_3d_alloc(n3_type_3d_alloc*n2_type_3d_alloc*(jd1-1) + n3_type_3d_alloc*(jd2-1) + jd3) = c_loc(F%type_3d_alloc(jd1+lb1, jd2+lb2, jd3+lb3))\n  enddo;  enddo; enddo\nelse\n  n1_type_3d_alloc = 0; n2_type_3d_alloc = 0; n3_type_3d_alloc = 0\nendif\n', to_c2_call='z_type_3d_alloc', to_c2_type='type(c_ptr)', to_c2_name='z_type_3d_alloc(*)', to_c2_f2_sub_arg='z_type_3d_alloc', to_f2_type='type(c_ptr)', to_f2_name='z_type_3d_alloc(*)', to_f2_trans='if (n1_type_3d_alloc == 0) then\n  if (allocated(F%type_3d_alloc)) deallocate(F%type_3d_alloc)\nelse\n  if (allocated(F%type_3d_alloc)) then\n    if (n1_type_3d_alloc == 0 .or. any(shape(F%type_3d_alloc) /= [n1_type_3d_alloc, n2_type_3d_alloc, n3_type_3d_alloc])) deallocate(F%type_3d_alloc)\n    if (any(lbound(F%type_3d_alloc) /= 1)) deallocate(F%type_3d_alloc)\n  endif\n  if (.not. allocated(F%type_3d_alloc)) allocate(F%type_3d_alloc(1:n1_type_3d_alloc+1-1, 1:n2_type_3d_alloc+1-1, 1:n3_type_3d_alloc+1-1))\n  do jd1 = 1, n1_type_3d_alloc;  do jd2 = 1, n2_type_3d_alloc;  do jd3 = 1, n3_type_3d_alloc\n    call wake_lr_to_f (z_type_3d_alloc(n3_type_3d_alloc*n2_type_3d_alloc*(jd1-1) + n3_type_3d_alloc*(jd2-1) + jd3), c_loc(F%type_3d_alloc(jd1+1-1,jd2+1-1,jd3+1-1)))\n  enddo;  enddo;  enddo\nendif\n', to_f2_var=[], equality_test='is_eq = is_eq .and. (allocated(f1%type_3d_alloc) .eqv. allocated(f2%type_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%type_3d_alloc)) is_eq = all(shape(f1%type_3d_alloc) == shape(f2%type_3d_alloc))\nif (.not. is_eq) return\nif (allocated(f1%type_3d_alloc)) is_eq = all(f1%type_3d_alloc == f2%type_3d_alloc)\n', test_pat='if (ix_patt < 3) then\n  if (allocated(F%type_3d_alloc)) deallocate (F%type_3d_alloc)\nelse\n  if (.not. allocated(F%type_3d_alloc)) allocate (F%type_3d_alloc(-1:1, 2, 1))\n  do jd1 = 1, size(F%type_3d_alloc,1); lb1 = lbound(F%type_3d_alloc,1) - 1\n  do jd2 = 1, size(F%type_3d_alloc,2); lb2 = lbound(F%type_3d_alloc,2) - 1\n  do jd3 = 1, size(F%type_3d_alloc,3); lb3 = lbound(F%type_3d_alloc,3) - 1\n    call set_wake_lr_test_pattern (F%type_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+2*jd2+3*jd3)\n  enddo\n  enddo\n  enddo\nendif\n', size_var=[], test_value=''), c_side=c_side_trans_class(c_class='VariableArray3D<CPP_wake_lr>', c_instantiation_suffix='', to_f_setup='\n  auto n1_type_3d_alloc { C.type_3d_alloc.size() };\n  auto n2_type_3d_alloc { std::size_t{0} };\n  auto n3_type_3d_alloc { std::size_t{0} };\n  const CPP_wake_lr** z_type_3d_alloc { nullptr };\n  if (n1_type_3d_alloc > 0) {\n    n2_type_3d_alloc = C.type_3d_alloc[0].size();\n    n3_type_3d_alloc = C.type_3d_alloc[0][0].size();\n    z_type_3d_alloc = new const CPP_wake_lr* [n1_type_3d_alloc*n2_type_3d_alloc*n3_type_3d_alloc];\n    for (auto i{0}; i < n1_type_3d_alloc; i++) {\n      for (auto j{0}; j < n2_type_3d_alloc; j++) {\n        for (auto k{0}; k < n3_type_3d_alloc; k++) {\n          z_type_3d_alloc[i*n2_type_3d_alloc*n3_type_3d_alloc + j*n3_type_3d_alloc + k] = &C.type_3d_alloc[i][j][k];\n        }\n      }\n    }\n  }\n', to_f_cleanup='  if (z_type_3d_alloc) delete[] z_type_3d_alloc;\n', to_f2_arg='const CPP_wake_lr**', to_f2_call='z_type_3d_alloc', to_c2_arg='Opaque_wake_lr_class** z_type_3d_alloc', to_c2_set='\n  C.type_3d_alloc.resize(n1_type_3d_alloc);\n  for (auto i{0}; i < n1_type_3d_alloc; i++) {\n    C.type_3d_alloc[i].resize(n2_type_3d_alloc);\n    for (auto j{0}; j < n2_type_3d_alloc; j++) {\n      C.type_3d_alloc[i][j].resize(n3_type_3d_alloc);\n      for (auto k{0}; k < n3_type_3d_alloc; k++) {\n        // C.type_3d_alloc[i][j][k] = make_shared<CPP_wake_lr>();\n        wake_lr_to_c(z_type_3d_alloc[n3_type_3d_alloc*n2_type_3d_alloc*i+n3_type_3d_alloc*j+k], C.type_3d_alloc[i][j][k]);\n    } } }\n', class_initializer='', construct_value='', destructor='', equality_test='  is_eq = is_eq && is_all_equal(x.type_3d_alloc, y.type_3d_alloc);\n', test_pat='  if (ix_patt < 3) \n    C.type_3d_alloc.resize(0);\n  else {\n    C.type_3d_alloc.resize(3);\n    for (size_t i = 0; i < C.type_3d_alloc.size(); i++) {\n      C.type_3d_alloc[i].resize(2);\n      for (size_t j = 0; j < C.type_3d_alloc[0].size(); j++) {\n        C.type_3d_alloc[i][j].resize(1);\n        for (size_t k = 0; k < C.type_3d_alloc[0][0].size(); k++) {\n          // C.type_3d_alloc[i][j][k] = make_shared<CPP_wake_lr>();\n          set_CPP_wake_lr_test_pattern(C.type_3d_alloc[i][j][k], ix_patt+i+2*j+3*k+6);\n        }\n      }\n    }\n  }\n', test_value=''), split_line=[], intent='', optional=False)
        // Array property: type_3d_alloc, type: VariableArray3D<CPP_wake_lr>
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

