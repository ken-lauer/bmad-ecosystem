#!/bin/bash

mkdir all_code

for dir in code code_synrad code_synrad3d synrad3d/custom modules; do

  for fn in $dir/*.f90; do
    ln -svf ../$fn ./all_code/$(basename $fn)
  done

done
