#!/bin/bash

mkdir code
mkdir include
shopt -s nullglob

# plot
for dir in file interfaces io math matrix misc optimizers string geodesic_lm special_functions; do

  for fn in $dir/*.f90 $dir/*.cpp $dir/*.c $dir/*.f; do
    ln -svf ../$fn ./code/$(basename $fn)
  done

  for fn in $dir/*.cc; do
    target=${fn/.cc/.cpp}
    ln -svf ../${target} ./code/$(basename $fn)
  done

  for fn in $dir/*.hh; do
    ln -svf ../$fn ./include/$(basename $fn)
  done

done

shopt -u nullglob
