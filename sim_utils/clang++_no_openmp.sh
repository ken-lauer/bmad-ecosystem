#!/bin/bash

OPTS="$@"
OPTS=${OPTS/-fopenmp/}
clang++ $OPTS
