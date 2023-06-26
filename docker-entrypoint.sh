#/usr/bin/env bash

# Abort script execution on error
set -e

# Format source code
clang-format -i src/*.[ch]pp

# Run CMake to generate Makefile project
mkdir -p build && cmake -S . -B build

# Build projet and run tests
(cd build && make && make test)

# Run static analyzer
clang-tidy src/*.[ch]pp -- -std=c++20 -I/usr/local/include
