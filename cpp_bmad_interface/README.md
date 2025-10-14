## cpp_bmad_interface

There are important aspects of the C++ Bmad Interface (`cpp_bmad_interface`):

1. Structure information from `../structs` used as a reference when generating
   C++ code.
2. A Python package `bmad_cpp_codegen` (and command-line program) used to
   generate all source code for this interface.
3. CMake files to compile the interface.

Normally you should not have to create any code files since:

1. The code files are part of the git repository and do not normally have to be regenerated.
2. They only need to be regenerated when there are changes to Bmad structures or
   if a new structure is to be added.
3. Code file generation is not meant for the uninitiated.

### Warning

If you want to generate new code files, please talk to David Sagan first.

## Code Generation Overview

Run from the `cpp_bmad_interface` directory:

```bash
python3 -m bmad_cpp_codegen
```

This script generates:

1. Proxy class C++ headers and source code
2. Fortran-side accessors
3. D) equality_mod.f90 which is placed in the `bmad/modules` directory.

This file is placed in bmad since it is used by some bmad routines.

### Constants / enums

`bmad_cpp_codegen/enums.py` searches a set of Bmad files and generates
corresponding constants for use with C++ code.

This file is created: `include/bmad_enums.h`

For example, the `proton$` parameter on the Fortran side is translated to
`PROTON` on the C++ side.
