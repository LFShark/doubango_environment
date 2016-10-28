#!/bin/bash
NDK=/home/devshark/SCRATCH/android-ndk-r12b
PLATFORM=$NDK/platforms/android-9/arch-x86/
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/linux-x86_64
PREFIX=./android/x86

function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-pic \
  --host=i686-linux \
  --cross-prefix=$TOOLCHAIN/bin/i686-linux-android- \
  --sysroot=$PLATFORM

  make clean
  make
  make install
}

build_one

echo ---------------------------------------
echo ----- Android x86 builds finished -----
echo ---------------------------------------
