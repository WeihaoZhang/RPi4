#!/bin/bash

export BOARD_NAME=RPi4
export WORKSPACE=$(pwd)
export _ARCH=AARCH64
export _TOOLCHAIN=GCC5
export _DSC_FILE=Platform/RaspberryPi/$BOARD_NAME/$BOARD_NAME.dsc

export GCC5_AARCH64_PREFIX=$WORKSPACE/toolchain/gcc/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf/bin/aarch64-none-elf-
export PACKAGES_PATH=$WORKSPACE/edk2:$WORKSPACE/edk2-platforms:$WORKSPACE/edk2-non-osi:$WORKSPACE/edk2-platforms/Platform/RaspberryPi/
export IASL_PREFIX=$WORKSPACE/acpica/generate/unix/bin/


if [ $# -eq 1 ] && [ $1 -eq 1 ]; then
	rm -rf Build/$BOARD_NAME
	echo "Build clean"
fi

if [ ! -e $WORKSPACE/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli/.git ]; then
	echo "Need update edk2 submodule!"
	cd $WORKSPACE/edk2
	git config --list|grep submodule.*url=|sed -e 's#^\(.*url\)=https://github.com/\(.*\)$#git config \1 ssh://git@gitmirror.cixcomputing.com/github_mirror/\2##g'|while read c;do $c;done
	git submodule update --init
fi

if [ ! -e $WORKSPACE/toolchain/gcc/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf/bin ]; then
	echo "Need extract gcc tool compressed file!"
	cd $WORKSPACE/toolchain/gcc/
	tar -xf gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf.tar.xz
fi

cd $WORKSPACE


if [ ! -e $WORKSPACE/Source/C/bin ]; then
	echo "Need build edk2 basetool!"
	make -C edk2/BaseTools
fi

if [ ! -e $WORKSPACE/acpica/generate/unix/bin ]; then
	echo "Need build acpi tool!"
	make -C acpica
fi


source $WORKSPACE/edk2/edksetup.sh --reconfig

build -a $_ARCH -t $_TOOLCHAIN -p $_DSC_FILE
