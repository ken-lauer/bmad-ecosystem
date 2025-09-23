cmake_minimum_required(VERSION $ENV{ACC_CMAKE_VERSION})
project(ACC)

set(LIBNAME cpp_bmad_interface)
set(CREATE_SHARED true)
set(CMAKE_EXPORT_COMPILE_COMMANDS true)

set(INC_DIRS
  include
  $ENV{ACC_CONDA_PATH}/include
)

set(SRC_DIRS
  code
)

set(SHARED_DEPS
  bmad
  tao
  sim_utils
  jsonfortran
)

# TODO: macos only
# SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -undefined dynamic_lookup")

include($ENV{ACC_BUILD_SYSTEM}/Master.cmake)

FOREACH(target ${TARGETS})

  set_property(TARGET ${target} PROPERTY CXX_STANDARD 17)

ENDFOREACH()
