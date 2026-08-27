#!/bin/bash
set -exo pipefail

CUDA_ARGS="-Ccmake.define.USE_CUDA=OFF"
if [[ "${gpu_variant}" == "cuda" ]]; then
    # LightGBM 4.7.0 requires NCCL for CUDA builds; use the shared NCCL library.
    CUDA_ARGS="-Ccmake.define.USE_CUDA=ON -Ccmake.define.BUILD_WITH_SHARED_NCCL=ON"
fi

${PYTHON} -m pip install . --no-deps --no-build-isolation -vv \
    -Ccmake.define.CMAKE_GENERATOR="Ninja" \
    ${CUDA_ARGS}
