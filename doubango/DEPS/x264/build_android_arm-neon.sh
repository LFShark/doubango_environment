#!/bin/bash
NDK=/home/devshark/SCRATCH/android-ndk-r12b
PLATFORM=$NDK/platforms/android-9/arch-arm
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
PREFIX=./android/arm

function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-shared \
  --disable-static \
  --enable-pic \
  --host=arm-linux \
  --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
  --extra-cflags=" -O3 -fpic -shared -mfpu=neon "
  --sysroot=$PLATFORM

  make clean
  make
  make install
}

build_one

echo -------------------------------------------------
echo --------- Android ARM NEON builds finished -----------
echo -------------------------------------------------
