#!/bin/bash

ACC_ROOT_DIR="$(
  cd "$(dirname "$(dirname "${BASH_SOURCE:-$0}")")"/.. 2>&1 >/dev/null
  pwd -P
)"

python3 -m bmad_struct_parser
python3 -m bmad_struct_parser.fortran_json
