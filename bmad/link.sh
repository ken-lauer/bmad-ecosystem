#!/bin/bash

mkdir all_code

for dir in code geometry interface modules multiparticle output ptc photon parsing low_level hdf5 space_charge spin; do

  for fn in $dir/*.f90; do
    ln -svf ../$fn ./all_code/$(basename $fn)
  done

done
