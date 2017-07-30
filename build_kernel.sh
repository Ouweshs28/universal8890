#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=../gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-

make exynos8890-hero2lte_defconfig
make -j4
