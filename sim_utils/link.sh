#!/bin/bash

mkdir code
mkdir code_fixed
shopt -s nullglob

for dir in file interfaces io math matrix misc optimizers plot string geodesic_lm special_functions; do

  for fn in $dir/*.f90 $dir/*.cpp $dir/*.c; do
    ln -svf ../$fn ./code/$(basename $fn)
  done

  for fn in $dir/*.f; do
    ln -svf ../$fn ./code_fixed/$(basename $fn)
  done

done
