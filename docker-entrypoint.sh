#/usr/bin/env bash

set -e

export BUILD_DIR="cmake-build-debug"

export NC="\033[0m"
export CYAN="\033[0;36m"
export SEPARATOR="========================================================================"

log() {
      echo "${CYAN}${1}${NC}"
}

section() {
      log "${SEPARATOR}"
      log "${1}"
      log "${SEPARATOR}"
}

section "Format source code"
clang-format --verbose --Werror -i src/*.[ch]pp

section "Generate CMake project"
cmake -S . -B ${BUILD_DIR} -DCMAKE_BUILD_TYPE=Debug -DCODE_COVERAGE=ON

section "Build CMake project"
cmake --build ${BUILD_DIR} --config Debug -- -j $(nproc)

section "Build Makefile project"
(cd ${BUILD_DIR} && make)

section "Run tests with memcheck support"
ctest --test-dir    ${BUILD_DIR} \
      --parallel    $(nproc)     \
      --test-action memcheck     \
      --schedule-random          \
      --output-on-failure        \
      --force-new-ctest-process

section "Print memcheck reports with filenames"
find ${BUILD_DIR}/Testing/Temporary -maxdepth 1 -name "MemoryChecker*.log" -print -exec cat "{}" \;

section "Generate code coverage reports"
cd ${BUILD_DIR}
lcov --directory . --capture --output-file coverage.info
lcov --directory . --remove coverage.info '/usr/*' --output-file coverage.info.cleaned
genhtml -o coverage coverage.info.cleaned
cd -

section "Run static analysis"
clang-tidy src/*.[ch]pp -- -std=c++20 -I/usr/local/include

log "Build output is located in the [${BUILD_DIR}] directory"
log "Code coverage reports are rooted at [${BUILD_DIR}/coverage/index.html]"
