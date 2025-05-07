#!/bin/bash

# python -m pip install -e bmad_struct_parser
# cd ${ACC_ROOT_DIR}/structs
python3 -m bmad_struct_parser
python3 -m bmad_struct_parser.fortran_json
