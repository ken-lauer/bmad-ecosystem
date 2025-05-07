from __future__ import annotations

debug = True

# List of files containing definitions of the structures to setup interfaces for.

struct_def_files = [
    "code/test_struct_defs.f90",
]
struct_def_yaml_files = [
    "../structs/yaml/test_structs.yaml",
]

# List of use statements needed in various Fortran modules

conversion_use_statements = [
    "use test_struct_defs",
]
equality_use_statements = [
    "use test_struct_defs",
]
test_use_statements = [
    # "use bmad_json",
    # "use sim_utils_json",
    "use test_struct_defs",
]

# List of structures to setup interfaces for.
# List must be in ordered such that if struct A is a component of struct B,
# then A must be before B in the list.

struct_list = [
    "wake_lr_struct",
    "wake_struct",
    "all_encompassing_struct",
]

# List of sub-structures to ignore.
# That is, do not translate these sub-structure components.

component_no_translate_list = {"fibre", "genfield"}
interface_ignore_list = {"fibre", "genfield"}
structs_defined_externally = set()

# Directory where the output is put

equality_mod_dir = "../bmad/modules"
equality_mod_file = "equality_mod"
test_dir = "interface_test"
code_dir = "code"

# Lower bounds for allocatable and pointer arrays on the fortran side


def f_side_lbound(id_name):
    if id_name == "branch%ele":
        return "0"
    return "1"


# Function to customize the interface code.

c_side_name_translation = {
    "rf_wake_sr_table_struct%long": "long_wake",
    "rf_wake_sr_table_struct%trans": "trans_wake",
}

# Include header files for main header file

include_header_files = [
    '#include "bmad_enums.h"',
    '#include "bmad_std_typedef.h"',
]

routine_interface_files = []


def customize(struct_definitions):
    pass
