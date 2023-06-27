#/usr/bin/env bash

set -e

NC='\033[0m'
CYAN='\033[0;36m'

echo "${CYAN}Format source code ...${NC}"
clang-format -i src/*.[ch]pp

echo "${CYAN}Run CMake to generate Makefile project ...${NC}"
mkdir -p build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --config Debug -- -j $(nproc)

echo "${CYAN}Build project ...${NC}"
(cd build && make)

echo "${CYAN}Run tests with memcheck support ...${NC}"
ctest --test-dir    build    \
      --parallel    $(nproc) \
      --test-action memcheck \
      --schedule-random      \
      --output-on-failure    \
      --force-new-ctest-process

echo "${CYAN}Print memcheck reports ...${NC}"
find build/Testing/Temporary -maxdepth 1 -name "MemoryChecker*.log" -print -exec cat "{}" \;

echo "${CYAN}Run static analysis ...${NC}"
clang-tidy src/*.[ch]pp -- -std=c++20 -I/usr/local/include
