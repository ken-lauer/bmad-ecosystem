# Tao FPM build (noplot variant)

Build `tao` with [`fpm`](https://fpm.fortran-lang.org/) in this directory.

## Building with system package dependencies

TODO

## Building with conda dependencies

Create a conda environment with `conda` including the necessary compilers:

```
conda create -n fpm -c conda-forge compilers fpm
conda activate fpm
```

### Conda on MacOS

```
fpm @conda-macos
```

The binary should be available here:

```
ls -l ./conda-macos/tao
./conda-macos/tao
```
