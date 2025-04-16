## cpp_bmad_interface

There are two parts to cpp_bmad_interface:

1. Scripts to create the appropriate code files.
2. The standard Cmake files to create the cpp_bmad_interface

Normally you should not have to create any code files since:

1. The code files are part of the git repository and do not normally have to be regenerated.
2. They only need to be regenerated when there are changes to Bmad structures or
   if a new structure is to be added.
3. Code file generation is not meant for the uninitiated.

### Warning

If you want to generate new code files, please talk to David Sagan first.

## Code Generation Overview

There are two scipts to generate files:

- `scripts/bmad_enums_to_c.py`
- `scripts/create_interface.py`
- `scripts/bmad_enums_to_c.py:`
  Run from the cpp_bmad_directory:

```bash
python3  ./scripts/bmad_enums_to_c.py
```

This script searches a set of Bmad files and generates corresponding constants for use with C++ code.
The constants file is: include/bmad_enums.h
For example, the proton$ parameter on the Fortran side is translated to PROTON on the C++ side.

- `scripts/create_interface.py`:
  Run from the cpp_bmad_directory:

  ```
  python3 ./scripts/create_interface.py
  ```

  If the Bmad structures are modified then the file
  scripts/interface_input_params.py must be appropriately updatted. See this
  file for more instructions.

  This script generates:
  A) The include/cpp_bmad_classes.h file defining the C++ classes
  B) .f90 and .cpp translation code files in the code directory.
  C) .f90 and .cpp test files in the interface_test directory.
  D) equality_mod.f90 which is placed in the bmad/modules directory.
  This file is placed in bmad since it is used by some bmad routines.

- After generating new code for cpp_bmad_interface, generate new code for the cpp_tao_interface.

## Compiling and Linking

The standard "mk" and "mkd" scripts will create both the cpp_bmad_interface
library and the test program cpp_bmad_interface_test.

---

## Testing

1. Go to the bmad directory and recompile
2. Return to the cpp_bmad_interface directory and run the test program:
   ../production/bin/cpp_bmad_interface_test

### Test meaning

Taking the structure `f_spline_struct`, for example:

1. **Fortran `test1_f_spline`**: Creates a spline structure with test pattern 1 and sends it to C++
2. **C++ `test_c_spline`**:
   - [1] Receives Fortran spline and compares with C++ test pattern 1
   - Prepares C++ spline with test pattern 2 and sends to Fortran
3. **Fortran `test2_f_spline`**:
   - [2] Receives C++ spline and compares with Fortran test pattern 2
   - Prepares Fortran spline with test pattern 3 and sends back to C++
4. **C++ `test_c_spline` (continued)**:
   - [3] Compares received Fortran data with C++ test pattern 3
   - Prepares C++ spline with test pattern 4 and sends to Fortran
5. **Fortran `test1_f_spline` (continued)**:
   - [4] Compares received C++ data with Fortran test pattern 4

In short:

- **Test [1]**: Verifies C++ can correctly read data created in Fortran (F→C conversion)
- **Test [2]**: Verifies Fortran can correctly read data created in C++ (C→F conversion)
- **Test [3]**: Verifies C++ can correctly read data modified in Fortran (F→C conversion)
- **Test [4]**: Verifies Fortran can correctly read data modified in C++ (C→F conversion)
