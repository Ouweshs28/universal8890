#!/bin/bash

KERNEL_NAME="Primal_Kernel"
KERNEL_VERSION="2.5.0"
KERNEL_REVISION="0"
KERNEL_BETA="1"
ANDROID_VERSION="7"

if [ $ANDROID_VERSION >= 7 ]; then
	export PLATFORM_VERSION_NUMBER=70000
	export MAJOR_VERSION=n
else
	export PLATFORM_VERSION_NUMBER=60001
	export MAJOR_VERSION=m
fi

if [ $KERNEL_BETA == 1 ]; then
	KERNEL_VERSION+=β
fi
if [ $KERNEL_REVISION != 0 ]; then
	KERNEL_VERSION+=-r$KERNEL_REVISION
fi
export LOCALVERSION=-${KERNEL_NAME}-v${KERNEL_VERSION}

export ARCH=arm64
export CROSS_COMPILE=../aarch64-linux-android-4.9/bin/aarch64-linux-android-

RDIR=$(pwd)
CNFDIR=$RDIR/arch/$ARCH/configs

cp $CNFDIR/exynos8890-hero2lte_defconfig $CNFDIR/temp_defconfig

make temp_defconfig
rm $CNFDIR/temp_defconfig
make -j4 2>&1 | tee -a ./build_kernel.log
