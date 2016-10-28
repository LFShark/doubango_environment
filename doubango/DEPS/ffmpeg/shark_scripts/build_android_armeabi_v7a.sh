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

function build_ARMv7
{
  ./configure \
  --target-os=linux \
  --prefix=./android/armeabi-v7a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --enable-shared \
  --disable-static \
  --extra-cflags="-DANDROID -fPIC -ffunction-sections -funwind-tables -fstack-protector -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300" \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog -lpthread" \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon \
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
  --disable-debug

  make clean
  make
  make install
}

build_ARMv7

echo -------------------------------------------------
echo -------- Android ARMv7-a builds finished --------
echo -------------------------------------------------