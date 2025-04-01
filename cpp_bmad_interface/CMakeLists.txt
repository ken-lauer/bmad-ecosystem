cmake_minimum_required(VERSION $ENV{ACC_CMAKE_VERSION})
project(ACC)

set (LIBNAME cpp_bmad_interface)
SET (CREATE_SHARED true)

set(INC_DIRS 
  include
  $ENV{ACC_CONDA_PATH}/include
  $ENV{ACC_CONDA_PATH}/include/python3.12
)
# TODO: python3 -m pybind11 --includes

set(SRC_DIRS
  code
  python
)

set(EXE_SPECS 
  cmake.cpp_bmad_interface_test
)

SET (SHARED_DEPS
  bmad
  sim_utils
)

# TODO: macos only
SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -undefined dynamic_lookup")

include($ENV{ACC_BUILD_SYSTEM}/Master.cmake)




