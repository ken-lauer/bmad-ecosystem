cmake_minimum_required(VERSION $ENV{ACC_CMAKE_VERSION})
project(ACC)

SET (LIBNAME bmad)

SET (CREATE_SHARED true)

SET (PLOT_LINK_LIBS $ENV{PLOT_LINK_LIBS})

# If this is a conda build, xraylib is contained
# one level deeper in the include folder

IF ($ENV{ACC_CONDA_BUILD})
  SET (INC_DIRS
    $ENV{ACC_CONDA_PATH}/include
    $ENV{ACC_CONDA_PATH}/include/xraylib/
    $ENV{ACC_CONDA_PATH}/include/fgsl/
  )
ELSE ()
  SET (INC_DIRS
  )
ENDIF ()

SET (SRC_DIRS 
  code 
  ### custom  # Using function pointers now
  geometry
  interface
  modules
  multiparticle
  output
  ptc
  photon
  parsing
  low_level
  hdf5
  space_charge
  spin
  gpu
  )

SET (SHARED_DEPS
  sim_utils
  $ENV{ACC_BMAD_LINK_LIBS}
  X11
  readline
)

include($ENV{ACC_BUILD_SYSTEM}/Master.cmake)

# Device backend (see gpu/bmad_device.h). Built as its own library, loaded at run time by
# gpu/bmad_device.c, so nothing that links libbmad needs the Metal frameworks.

IF (APPLE)
  include (CheckLanguage)
  check_language (OBJCXX)
  IF (CMAKE_OBJCXX_COMPILER)
    enable_language (OBJCXX)
    find_library (BMAD_METAL_FRAMEWORK Metal)
    find_library (BMAD_FOUNDATION_FRAMEWORK Foundation)
    IF (BMAD_METAL_FRAMEWORK AND BMAD_FOUNDATION_FRAMEWORK)
      add_library (bmad_metal SHARED gpu/metal/bmad_metal.mm)
      set_source_files_properties (gpu/metal/bmad_metal.mm PROPERTIES COMPILE_FLAGS "-fobjc-arc -std=c++17 -O2 -fPIC")
      target_include_directories (bmad_metal PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/gpu)
      target_link_libraries (bmad_metal ${BMAD_METAL_FRAMEWORK} ${BMAD_FOUNDATION_FRAMEWORK})
      MESSAGE ("Device backend     : libbmad_metal")
    ELSE ()
      MESSAGE ("Device backend     : Metal frameworks not found, none built")
    ENDIF ()
  ELSE ()
    MESSAGE ("Device backend     : no Objective-C++ compiler, none built")
  ENDIF ()
ENDIF ()
