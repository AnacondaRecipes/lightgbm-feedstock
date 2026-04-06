#!/bin/bash
set -exo pipefail

CUDA_ARGS="-Ccmake.define.USE_CUDA=OFF"
if [[ "${gpu_variant}" == "cuda" ]]; then
    # CMAKE_CUDA_STANDARD=17 required: GCC 14 headers use C++17 features
    # that nvcc can't parse under the upstream default of -std=c++11
    CUDA_ARGS="-Ccmake.define.USE_CUDA=ON -Ccmake.define.CMAKE_CUDA_STANDARD=17"
fi

${PYTHON} -m pip install . --no-deps --no-build-isolation -vv \
    -Ccmake.define.CMAKE_GENERATOR="Ninja" \
    ${CUDA_ARGS}
