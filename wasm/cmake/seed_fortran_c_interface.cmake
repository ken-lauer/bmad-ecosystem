# Write the result of CMake's FortranCInterface detection for flang targeting WebAssembly.
#
# Usage: cmake -DBUILD_DIR=<build tree> -P seed_fortran_c_interface.cmake
#
# CMake finds out how the Fortran compiler mangles names by linking a Fortran program against
# C functions named after every known convention. In WebAssembly a call with the wrong function
# signature does not link to the function, so the detection finds nothing. The mangling used by
# flang is known, so the answer is written directly.

set(FortranCInterface_GLOBAL_SYMBOL "mysub_")
set(FortranCInterface_GLOBAL_PREFIX "")
set(FortranCInterface_GLOBAL_SUFFIX "_")
set(FortranCInterface_GLOBAL_CASE "LOWER")
set(FortranCInterface_GLOBAL_MACRO "(name,NAME) name##_")

set(FortranCInterface_GLOBAL__SYMBOL "my_sub_")
set(FortranCInterface_GLOBAL__PREFIX "")
set(FortranCInterface_GLOBAL__SUFFIX "_")
set(FortranCInterface_GLOBAL__CASE "LOWER")
set(FortranCInterface_GLOBAL__MACRO "(name,NAME) name##_")

set(FortranCInterface_MODULE_SYMBOL "_QMmymodulePmysub")
set(FortranCInterface_MODULE_PREFIX "_QM")
set(FortranCInterface_MODULE_MIDDLE "P")
set(FortranCInterface_MODULE_SUFFIX "")
set(FortranCInterface_MODULE_CASE "LOWER")
set(FortranCInterface_MODULE_ORDER "MODULE_THEN_SYMBOL")
set(FortranCInterface_MODULE_MACRO "(mod_name,name, mod_NAME,NAME) _QM##mod_name##P##name")

set(FortranCInterface_MODULE__SYMBOL "_QMmy_modulePmy_sub")
set(FortranCInterface_MODULE__PREFIX "_QM")
set(FortranCInterface_MODULE__MIDDLE "P")
set(FortranCInterface_MODULE__SUFFIX "")
set(FortranCInterface_MODULE__CASE "LOWER")
set(FortranCInterface_MODULE__ORDER "MODULE_THEN_SYMBOL")
set(FortranCInterface_MODULE__MACRO "(mod_name,name, mod_NAME,NAME) _QM##mod_name##P##name")

set(FortranCInterface_GLOBAL_FOUND 1)
set(FortranCInterface_MODULE_FOUND 1)

configure_file(${CMAKE_ROOT}/Modules/FortranCInterface/Output.cmake.in
               ${BUILD_DIR}/CMakeFiles/FortranCInterface/Output.cmake @ONLY)
