#/usr/bin/env bash

set -e

export BUILD_DIR="cmake-build-debug"

# Clear scroll history
printf "\33c\e[3J"

# Override language support
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Delete build output directory
rm -Rf ${BUILD_DIR}

# Build Docker image
docker build --progress=plain -t modern-cpp:latest .

# Copy build output directory from Docker container to host
CONTAINER_ID=$(docker create modern-cpp:latest)
docker cp ${CONTAINER_ID}:/opt/modern-cpp/${BUILD_DIR} ${BUILD_DIR}
docker rm -v ${CONTAINER_ID}
