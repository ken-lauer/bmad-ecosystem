cmake_minimum_required(VERSION $ENV{ACC_CMAKE_VERSION})
project(ACC)

SET (LIBNAME forest)

SET (CREATE_SHARED true)

SET (INC_DIRS
  include
  )

SET (SRC_DIRS
  code
  )

SET(SHARED_DEPS
  jsonfortran
  ${SHARED_DEPS}
)

include($ENV{ACC_BUILD_SYSTEM}/Master.cmake)
