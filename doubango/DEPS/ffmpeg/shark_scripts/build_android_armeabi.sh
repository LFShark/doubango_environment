#!/bin/bash
#Change NDK to your Android NDK location
NDK=/home/devshark/SCRATCH/android-ndk-r12b
PLATFORM=$NDK/platforms/android-9/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=arm \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm \
--extra-cflags="-I../x264/android/arm/include" \
--extra-ldflags="-L../x264/android/arm/lib" "


MODULES="\
--enable-gpl \
--enable-libx264"

function build_ARMv6
{
  ./configure \
  --target-os=linux \
  --prefix=./android/armeabi \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags=" -O3 -fpic -fasm -Wno-psabi -fno-short-enums -fPIC -fno-strict-aliasing -finline-limit=300 -mfloat-abi=softfp -mfpu=vfp -marm -march=armv6" \
  --extra-ldflags="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog -lpthread" \
  --enable-zlib \
  ${MODULES} \
  --enable-libx264 \
  --enable-encoder=libx264 \
  --enable-decoder=h264 \
  --enable-pic \
  --enable-memalign-hack \
  --enable-pthreads \
  --enable-shared \
  --disable-static \
  --disable-asm \
  --disable-network \
  --disable-doc \
  --enable-pthreads \
  --disable-ffmpeg \
  --disable-ffplay \
  --disable-ffserver \
  --disable-ffprobe \
  --enable-encoder=h263 \
  --enable-encoder=h263p \
  --enable-decoder=h263 \
  --enable-gpl \
  --enable-nonfree \
  --disable-debug \
  --enable-neon

  make clean
  make
  make install
}



build_ARMv6

echo -------------------------------------------------
echo -------- Android ARMEABI builds finished --------
echo -------------------------------------------------
