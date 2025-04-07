from __future__ import annotations
from create_interface import (
    ALLOC,
    CHAR,
    CMPLX,
    INT,
    INT8,
    LOGIC,
    PTR,
    REAL,
    SIZE,
    STRUCT,
    SCRIPTS_PATH,
    arg_class,
    struct_def_class,
    struct_definitions,
)


OUTPUT_PATH = SCRIPTS_PATH.parent / "python" / "py.cpp"


def get_struct_array_return_code(arg):
    """Generate code to convert an array of structs to a Python list of objects"""
    dimensions = len(arg.array)

    if dimensions == 1:
        return f"""
                return py::none();
                // return self.{arg.c_name};
                """
    if dimensions == 2:
        return f"""
                return self.{arg.c_name};
                // const auto& matrix = self.{arg.c_name};
                // py::list result;
                // for (size_t i = 0; i < matrix.size(); ++i) {{
                //     py::list row;
                //     for (size_t j = 0; j < matrix[i].size(); ++j) {{
                //         row.append(py::cast(matrix[i][j]));
                //     }}
                //     result.append(row);
                // }}
                // return result;
                """
    return "return py::list(); // Unsupported dimensions for struct arrays"


def get_struct_array_setter_code(arg):
    """Generate code to convert a Python list of objects to an array of structs"""
    # Get the kind of struct
    fortran_type_name = arg.kind.replace("_struct", "")
    cpp_class_name = f"CPP_{fortran_type_name}"

    dimensions = len(arg.array)

    if dimensions == 1:
        return f"""
                throw std::runtime_error("Not implemented (dim1)");
                // try {{
                //     py::list list = obj.cast<py::list>();
                //     auto& arr = self.{arg.c_name};
                //     arr.resize(list.size());

                //     for (size_t i = 0; i < list.size(); ++i) {{
                //         arr[i] = list[i].cast<shared_ptr<{cpp_class_name}>>();
                //     }}
                // }} catch (const py::cast_error& e) {{
                //     throw std::runtime_error("Expected a list of {cpp_class_name} objects");
                // }}
                """
    if dimensions == 2:
        return f"""
                throw std::runtime_error("Not implemented (dim2)");
                // try {{
                //     py::list outer_list = obj.cast<py::list>();
                //     auto& matrix = self.{arg.c_name};
                //     matrix.resize(outer_list.size());
                //     
                //     for (size_t i = 0; i < outer_list.size(); ++i) {{
                //         py::list inner_list = outer_list[i].cast<py::list>();
                //         matrix[i].resize(inner_list.size());
                //         
                //         for (size_t j = 0; j < inner_list.size(); ++j) {{
                //             // matrix[i][j] = inner_list[j];
                //             // TODO
                //         }}
                //     }}
                // }} catch (const py::cast_error& e) {{
                //     throw std::runtime_error("Expected a list of lists of {cpp_class_name} objects");
                // }}
                """
    return "// Unsupported dimensions for struct arrays"


def handle_array(cpp_class_name: str, property_doc: str, arg: arg_class):
    cpp_type = get_cpp_array_type(arg)

    code = []
    code.append(f"        // Array property: {arg.c_name}, type: {cpp_type}")
    # Handle arrays of structs differently
    if arg.type.lower() == STRUCT:
        # Arrays of structs need special handling
        code.append(f'        .def_property("{arg.c_name}",')
        code.append(f"            [](const {cpp_class_name} &self) {{")
        code.append("                // Get list of struct objects")
        code.append(f"                {get_struct_array_return_code(arg)}")
        code.append("            },")
        code.append(f"            []({cpp_class_name} &self, py::object obj) {{")
        code.append(f"                // Set {arg.c_name} from list of structs")
        code.append(f"                {get_struct_array_setter_code(arg)}")
        code.append("            },")
        code.append("            py::return_value_policy::copy,")
        code.append(f"            {property_doc})")
    # Handle different array types for primitive types
    elif "ARRAY" in cpp_type:
        # 1D array
        code.append(f'        .def_property("{arg.c_name}",')
        code.append(f"            [](const {cpp_class_name} &self) {{")
        code.append(f"                // Get numpy array from {cpp_type}")
        code.append(f"                const auto& arr = self.{arg.c_name};")
        code.append("                auto size = arr.size();")
        code.append(f"                {get_numpy_return_code_for_array(arg, 1)}")
        code.append("            },")
        code.append(f"            []({cpp_class_name} &self, py::array arr) {{")
        code.append(f"                // Set {arg.c_name} from numpy array")
        code.append(
            f"                {get_numpy_to_array_code(arg, 'self.' + arg.c_name, 1)}"
        )
        code.append("            },")
        code.append(f"            {property_doc})")
    elif "MATRIX" in cpp_type:
        # 2D array (matrix)
        code.append(f'        .def_property("{arg.c_name}",')
        code.append(f"            [](const {cpp_class_name} &self) {{")
        code.append(f"                // Get numpy array from {cpp_type}")
        code.append(f"                const auto& matrix = self.{arg.c_name};")
        code.append(f"                {get_numpy_return_code_for_array(arg, 2)}")
        code.append("            },")
        code.append(f"            []({cpp_class_name} &self, py::array arr) {{")
        code.append(f"                // Set {arg.c_name} from numpy array")
        code.append(
            f"                {get_numpy_to_array_code(arg, 'self.' + arg.c_name, 2)}"
        )
        code.append("            },")
        code.append(f"            {property_doc})")
    elif "TENSOR" in cpp_type:
        # 3D array (tensor)
        code.append(f'        .def_property("{arg.c_name}",')
        code.append(f"            [](const {cpp_class_name} &self) {{")
        code.append(f"                // Get numpy array from {cpp_type}")
        code.append(f"                const auto& tensor = self.{arg.c_name};")
        code.append(f"                {get_numpy_return_code_for_array(arg, 3)}")
        code.append("            },")
        code.append(f"            []({cpp_class_name} &self, py::array arr) {{")
        code.append(f"                // Set {arg.c_name} from numpy array")
        code.append(
            f"                {get_numpy_to_array_code(arg, 'self.' + arg.c_name, 3)}"
        )
        code.append("            },")
        code.append(f"            {property_doc})")
    else:
        # Raw pointer arrays (c_RealArr, etc.)
        code.append(f'        .def_property_readonly("{arg.c_name}",')
        code.append(f"            [](const {cpp_class_name} &self) {{")
        code.append("                // Get numpy array from pointer array")
        code.append(f"                {get_numpy_return_code_for_ptr_array(arg)}")
        code.append("            },")
        code.append(f"            {property_doc})")
    return code


def generate_pybind11_module(struct_definitions: list[struct_def_class]):
    """
    Generate pybind11 module code from a list of struct definitions.

    Parameters:
    -----------
    struct_definitions : list of struct_def_class
        The C++ struct/class definitions to expose to Python

    Returns:
    --------
    str
        Complete pybind11 module C++ code
    """
    # Start with the necessary includes
    with open(SCRIPTS_PATH / "pybind11_template.cpp") as fp:
        template = fp.read()

    code = []
    for struct_def in struct_definitions:
        cpp_class_name = (
            struct_def.cpp_class
            if struct_def.cpp_class
            else f"CPP_{struct_def.short_name}"
        )
        py_class_name = (
            struct_def.short_name
            if struct_def.short_name
            else struct_def.f_name.replace("_struct", "")
        )

        # Add class with docstring
        code.append(
            f'    py::class_<{cpp_class_name}, std::shared_ptr<{cpp_class_name}>>(m, "{py_class_name}", "Fortran struct: {struct_def.f_name}")'
        )

        # Add constructor if available
        if struct_def.c_constructor_arg_list:
            code.append(
                f"        // TODO: .def(py::init<{struct_def.c_constructor_arg_list}>())"
            )
            code.append(
                # f"        .def(py::init<{struct_def.c_constructor_arg_list}>())"
                "        .def(py::init<>())"
            )
        else:
            code.append("        .def(py::init<>())")

        for arg in struct_def.arg:
            if not arg.is_component:
                continue
            comment = arg.comment.replace('"', "'") if arg.comment else ""
            property_doc = (
                f'"{comment}"' if comment else '"Property from Fortran struct"'
            )

            code.append(
                f"        // {struct_def.cpp_class}.{arg.c_name}: {arg.pointer_type} {arg.kind=} {arg=}"
            )
            # Skip pointer types to structs
            # Handle arrays vs scalar properties
            if arg.array:
                code.extend(
                    handle_array(
                        cpp_class_name=cpp_class_name,
                        property_doc=property_doc,
                        arg=arg,
                    )
                )
            elif arg.pointer_type == PTR and "_struct" in arg.kind:
                # property_type = get_cpp_type_for_property(arg)
                code.append(f'        .def_property_readonly("{arg.c_name}",')
                code.append(
                    f"            [](const {cpp_class_name} &self) {{ return self.{arg.c_name}; }},"
                )
                # code.append(
                #     f"            []({cpp_class_name} &self, {property_type} &val) {{ self.{arg.c_name} = val; }},"
                # )
                code.append("            py::return_value_policy::copy,")
                code.append(f"            {property_doc})")
            elif arg.pointer_type == PTR:
                # property_type = get_cpp_type_for_property(arg)
                var = f"self.{arg.c_name}"
                # TODO setter
                # code.append(f'        .def_property("{arg.c_name}",')
                code.append(f'        .def_property_readonly("{arg.c_name}",')
                code.append(
                    f"            [](const {cpp_class_name} &self) {{ return {var} ? py::cast(*{var}) : py::none(); }},"
                )
                # code.append(
                #     f"            []({cpp_class_name} &self, {property_type} val) {{ self.{arg.c_name} = val; }},"
                # )
                code.append("            py::return_value_policy::copy,")
                code.append(f"            {property_doc})")

            else:
                # Simple property for scalar values
                # property_type = get_cpp_type_for_property(arg)
                # TODO setter
                # code.append(f'        .def_property("{arg.c_name}",')
                code.append(f'        .def_property_readonly("{arg.c_name}",')
                code.append(
                    f"            [](const {cpp_class_name} &self) {{ return self.{arg.c_name}; }},"
                )
                # code.append(
                #     f"            []({cpp_class_name} &self, {property_type} val) {{ self.{arg.c_name} = val; }},"
                # )
                code.append("            py::return_value_policy::copy,")
                code.append(f"            {property_doc})")

        # Add any custom methods
        if struct_def.c_extra_methods:
            code.append("        // Custom methods")
            # This is placeholder - we'd need to parse c_extra_methods to properly expose them
            code.append("        // Additional methods would be bound here")

        code.append("        ;")
        code.append("")

    class_code = "\n".join(code)
    return template.replace("    // insert classes here //", class_code)


def get_cpp_array_type(arg):
    """
    Determine the C++ array type based on arg_class information.
    Prefers using c_side if available.
    """
    # If c_side is available and set, use it directly
    if hasattr(arg, "c_side") and arg.c_side:
        return str(arg.c_side).split(",")[0].strip()

    # Otherwise derive from the type information
    base_type = arg.type.lower()
    dim = len(arg.array)

    # Handle struct arrays differently
    if base_type == STRUCT:
        # Determine the C++ class name for the struct
        fortran_type_name = arg.kind.replace("_struct", "")
        cpp_class_name = f"CPP_{fortran_type_name}"
        if dim == 1:
            return f"std::vector<{cpp_class_name}>"
        else:
            # For multi-dimensional arrays of structs, use nested vectors
            return f"std::vector<std::vector<{cpp_class_name}>>"

    # Handle primitive types
    if base_type == REAL:
        if dim == 1:
            return "Real_ARRAY"
        elif dim == 2:
            return "Real_MATRIX"
        elif dim == 3:
            return "Real_TENSOR"
    elif base_type == CMPLX:
        if dim == 1:
            return "Complex_ARRAY"
        elif dim == 2:
            return "Complex_MATRIX"
        elif dim == 3:
            return "Complex_TENSOR"
    elif base_type == INT:
        if dim == 1:
            return "Int_ARRAY"
        elif dim == 2:
            return "Int_MATRIX"
        elif dim == 3:
            return "Int_TENSOR"
    elif base_type == LOGIC:
        if dim == 1:
            return "Bool_ARRAY"
        elif dim == 2:
            return "Bool_MATRIX"
        elif dim == 3:
            return "Bool_TENSOR"
    elif base_type == CHAR:
        return "String_ARRAY"  # Only 1D defined in the typedefs

    raise NotImplementedError(base_type)


def get_cpp_type_for_property(arg):
    """
    Convert Fortran type to equivalent C++ type for pybind11.

    Parameters:
    -----------
    arg : arg_class
        The argument to convert

    Returns:
    --------
    str
        C++ type string
    """
    # Basic type mapping
    type_map = {
        REAL: "double",
        CMPLX: "std::complex<double>",
        INT: "int",
        INT8: "int64_t",
        LOGIC: "bool",
        CHAR: "std::string",
        SIZE: "size_t",
    }

    # Custom struct handling
    if arg.type == STRUCT:
        fortran_type_name = arg.kind.replace("_struct", "")
        return f"CPP_{fortran_type_name}"

    # Basic type
    cpp_type = type_map.get(arg.type.lower(), "void*")  # Default to void* if unknown

    # Handle pointer types - but not for arrays which are handled separately
    if not arg.array:
        if arg.pointer_type == PTR:
            cpp_type = f"{cpp_type}*"
        elif arg.pointer_type == ALLOC:
            cpp_type = f"std::unique_ptr<{cpp_type}>"

    return cpp_type


def get_numpy_return_code_for_array(arg, dimensions):
    """Generate code to convert various array types to numpy arrays"""
    # base_type = arg.type.lower()

    # if base_type == REAL:
    #     dtype = "py::dtype::of<double>()"
    #     ctype = "double"
    # elif base_type == CMPLX:
    #     dtype = "py::dtype::of<std::complex<double>>()"
    #     ctype = "std::complex<double>"
    # elif base_type == INT:
    #     dtype = "py::dtype::of<int>()"
    #     ctype = "int"
    # elif base_type == INT8:
    #     dtype = "py::dtype::of<int64_t>()"
    #     ctype = "int64_t"
    # elif base_type == LOGIC:
    #     dtype = "py::dtype::of<bool>()"
    #     ctype = "bool"
    # elif base_type == CHAR:
    #     # Strings need special handling
    #     return (
    #         "return py::cast(std::vector<std::string>(std::begin(arr), std::end(arr)));"
    #     )
    # else:
    #     # Default case
    #     dtype = "py::dtype::of<double>()"
    #     ctype = "double"

    if dimensions == 1:
        return """
                return arr;
                """

        #
        #       // // Copy data to avoid lifetime issues
        #       // auto* data = new {ctype}[size];
        #       // for (size_t i = 0; i < size; ++i) {{
        #       //     data[i] = arr[i];
        #       // }}
        #       //
        #       // // Create a capsule to manage the memory
        #       // auto capsule = py::capsule(data, [](void *p) {{ delete[] static_cast<{ctype}*>(p); }});
        #       //
        #       // // Return numpy array
        #       // return py::array({dtype}, {{size}}, {{sizeof({ctype})}}, data, capsule);
    else:
        return """
                return py::str("not implemented");
        """

        # elif dimensions == 2:
        #     return f"""
        #             return py::str("not implemented");
        #             // if (matrix.size() == 0) return py::array({dtype}, {{0, 0}});
        #             //
        #             // size_t rows = matrix.size();
        #             // size_t cols = rows > 0 ? matrix[0].size() : 0;
        #             //
        #             // // Copy data to avoid lifetime issues
        #             // auto* data = new {ctype}[rows * cols];
        #             // for (size_t i = 0; i < rows; ++i) {{
        #             //     for (size_t j = 0; j < cols; ++j) {{
        #             //         data[i*cols + j] = matrix[i][j];
        #             //     }}
        #             // }}
        #             //
        #             // // Create a capsule to manage the memory
        #             // auto capsule = py::capsule(data, [](void *p) {{ delete[] static_cast<{ctype}*>(p); }});
        #             //
        #             // // Return numpy array
        #             // return py::array({dtype}, {{rows, cols}}, {{cols * sizeof({ctype}), sizeof({ctype})}}, data, capsule);
        #             """
        # elif dimensions == 3:
        #     return f"""
        #             return py::str("not implemented");
        #             //if (tensor.size() == 0) return py::array({dtype}, {{0, 0, 0}});
        #             //
        #             //size_t depth = tensor.size();
        #             //size_t rows = depth > 0 ? tensor[0].size() : 0;
        #             //size_t cols = (depth > 0 && rows > 0) ? tensor[0][0].size() : 0;
        #             //
        #             //// Copy data to avoid lifetime issues
        #             //auto* data = new {ctype}[depth * rows * cols];
        #             //for (size_t i = 0; i < depth; ++i) {{
        #             //    for (size_t j = 0; j < rows; ++j) {{
        #             //        for (size_t k = 0; k < cols; ++k) {{
        #             //            data[i*(rows*cols) + j*cols + k] = tensor[i][j][k];
        #             //        }}
        #             //    }}
        #             //}}
        #             //
        #             //// Create a capsule to manage the memory
        #             //auto capsule = py::capsule(data, [](void *p) {{ delete[] static_cast<{ctype}*>(p); }});
        #             //
        #             //// Return numpy array
        #             //return py::array({dtype}, {{depth, rows, cols}},
        #             //                {{rows * cols * sizeof({ctype}), cols * sizeof({ctype}), sizeof({ctype})}},
        #             //                data, capsule);
        #             """
        # else:
        #     return "return py::array(); // Unsupported dimensions"


def get_numpy_return_code_for_ptr_array(arg):
    """Generate code to handle const pointer arrays (c_RealArr, etc.)"""
    return f"""
            const auto* data_ptr = self.{arg.c_name};
    """

    base_type = arg.type.lower()

    if base_type == REAL:
        dtype = "py::dtype::of<double>()"
    elif base_type == CMPLX:
        dtype = "py::dtype::of<std::complex<double>>()"
    elif base_type == INT:
        dtype = "py::dtype::of<int>()"
    elif base_type == INT8:
        dtype = "py::dtype::of<int64_t>()"
    elif base_type == LOGIC:
        dtype = "py::dtype::of<bool>()"
    else:
        dtype = "py::dtype::of<double>()"  # Default

    return f"""
            // Note: This is read-only since we have a const pointer
            // For this to work correctly, the object must provide size information elsewhere
            const auto* data_ptr = self.{arg.c_name};
            if (data_ptr == nullptr) return py::array({dtype}, {{0}});
            
            // We need to know the size of the array
            // This might need modification based on how sizes are stored
            size_t size = self.{arg.c_name}_size; // Assuming a companion size property
            
            // Return numpy array as a view (no copy, read-only)
            return py::array({dtype}, {{size}}, {{sizeof(*data_ptr)}}, data_ptr);
            """


def get_numpy_to_array_code(arg, target_var, dimensions):
    """Generate code to convert numpy array to various array types"""

    return """
                return arr;
    """

    # base_type = arg.type.lower()
    # if base_type == REAL:
    #     ctype = "double"
    # elif base_type == CMPLX:
    #     ctype = "std::complex<double>"
    # elif base_type == INT:
    #     ctype = "int"
    # elif base_type == INT8:
    #     ctype = "int64_t"
    # elif base_type == LOGIC:
    #     ctype = "bool"
    # elif base_type == CHAR:
    #     # Strings need special handling
    #     return f"""
    #             // py::list string_list = arr.cast<py::list>();
    #             // {target_var}.resize(string_list.size());
    #             // for (size_t i = 0; i < string_list.size(); ++i) {{
    #             //     {target_var}[i] = string_list[i].cast<std::string>();
    #             // }}
    #             """
    # else:
    #     ctype = "double"  # Default

    # if dimensions == 1:
    #     return f"""
    #             return arr;
    #             // py::buffer_info info = arr.request();
    #             // if (info.ndim != 1) throw std::runtime_error("Expected a 1D array");
    #             //
    #             // // Resize and copy data
    #             // size_t size = static_cast<size_t>(info.shape[0]);
    #             // {target_var}.resize(size);
    #             // auto* data = static_cast<{ctype}*>(info.ptr);
    #             //
    #             // for (size_t i = 0; i < size; ++i) {{
    #             //     {target_var}[i] = data[i];
    #             // }}
    #             """
    # elif dimensions == 2:
    #     return f"""
    #             py::buffer_info info = arr.request();
    #             if (info.ndim != 2) throw std::runtime_error("Expected a 2D array");
    #
    #             // Resize and copy data
    #             size_t rows = static_cast<size_t>(info.shape[0]);
    #             size_t cols = static_cast<size_t>(info.shape[1]);
    #
    #             {target_var}.resize(rows);
    #             auto* data = static_cast<{ctype}*>(info.ptr);
    #
    #             for (size_t i = 0; i < rows; ++i) {{
    #                 {target_var}[i].resize(cols);
    #                 for (size_t j = 0; j < cols; ++j) {{
    #                     {target_var}[i][j] = data[i * info.strides[0]/sizeof({ctype}) + j * info.strides[1]/sizeof({ctype})];
    #                 }}
    #             }}
    #             """
    # elif dimensions == 3:
    #     return f"""
    #             py::buffer_info info = arr.request();
    #             if (info.ndim != 3) throw std::runtime_error("Expected a 3D array");
    #
    #             // Resize and copy data
    #             size_t depth = static_cast<size_t>(info.shape[0]);
    #             size_t rows = static_cast<size_t>(info.shape[1]);
    #             size_t cols = static_cast<size_t>(info.shape[2]);
    #
    #             {target_var}.resize(depth);
    #             auto* data = static_cast<{ctype}*>(info.ptr);
    #
    #             for (size_t i = 0; i < depth; ++i) {{
    #                 {target_var}[i].resize(rows);
    #                 for (size_t j = 0; j < rows; ++j) {{
    #                     {target_var}[i][j].resize(cols);
    #                     for (size_t k = 0; k < cols; ++k) {{
    #                         {target_var}[i][j][k] = data[i * info.strides[0]/sizeof({ctype}) +
    #                                                      j * info.strides[1]/sizeof({ctype}) +
    #                                                      k * info.strides[2]/sizeof({ctype})];
    #                     }}
    #                 }}
    #             }}
    #             """
    # else:
    #     return "// Unsupported dimensions"


if __name__ == "__main__":
    module_code = generate_pybind11_module(struct_definitions)
    by_name = {
        struct.f_name: {
            "struct": struct,
            "args": {arg.c_name: arg for arg in struct.arg},
        }
        for struct in struct_definitions
    }
    with open(OUTPUT_PATH, "w") as fp:
        print(module_code, file=fp)
