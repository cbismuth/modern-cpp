cmake_minimum_required(VERSION 3.5)

project(HelloTest VERSION 1.0 LANGUAGES CXX)

# Enable testing with memcheck support
include(CTest)
enable_testing()

# Set C++ version
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Locate Boost library
if (DEFINED ENV{BOOST_INCLUDE_DIR})
    set(BOOST_INCLUDE_DIR $ENV{BOOST_INCLUDE_DIR})
else ()
    set(BOOST_INCLUDE_DIR "/usr/local/include")
endif ()
if (BOOST_INCLUDE_DIR STREQUAL "")
    message("[BOOST_INCLUDE_DIR] is not set then assuming Boost can be automatically found")
elseif (EXISTS ${BOOST_INCLUDE_DIR})
    include_directories(${BOOST_INCLUDE_DIR})
endif ()

# Enable code coverage support
option(CODE_COVERAGE "Enable code coverage reporting" OFF)
if (CODE_COVERAGE AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    SET(CMAKE_C_FLAGS   "-g -O0 -Wall -W -fprofile-arcs -ftest-coverage")
    SET(CMAKE_CXX_FLAGS "-g -O0 -Wall    -fprofile-arcs -ftest-coverage")
    SET(CMAKE_EXE_LINKER_FLAGS "-fprofile-arcs -ftest-coverage")
endif ()

# Add test targets
add_executable(HelloTest src/main.cpp)
add_test(NAME HelloTest COMMAND HelloTest)
