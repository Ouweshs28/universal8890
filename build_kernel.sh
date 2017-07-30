#!/bin/bash

KERNEL_NAME="Primal_Kernel"
KERNEL_VERSION="1.0.0"
KERNEL_REVISION="0"
KERNEL_BETA="1"

if [ $KERNEL_BETA == 1 ]; then
	KERNEL_VERSION+=β
fi
if [ $KERNEL_REVISION != 0 ]; then
	KERNEL_VERSION+=-r$KERNEL_REVISION
fi
export LOCALVERSION=-${KERNEL_NAME}-v${KERNEL_VERSION}

export ARCH=arm64
export CROSS_COMPILE=../gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-

make primal-hero2lteeur_defconfig
make -j4 2>&1 | tee -a ./build_kernel.log
