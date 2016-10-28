#setup NDK path
echo -------------------- Exporting NDK paths --------------------
export NDK=/home/devshark/SCRATCH/android-ndk-r13-beta2
export ANDROID_NDK_ROOT=/home/devshark/SCRATCH/android-ndk-r13-beta2

#setup environment
echo -------------------- Setting-up environment --------------------
sudo apt-get install make libtool autoconf subversion git wget gcc nasm git libogg-dev

#get doubango and start with the dependancies
echo ---------- Cloning doubango ----------
git clone https://github.com/DoubangoTelecom/doubango.git doubango

cd doubango

#setup toolchain
#echo -------------------- Setting-up toolchain --------------------
#sh $NDK/build/tools/make-standalone-toolchain.sh --arch=arm --platform=android-24 --install-dir=my-android-toolchain

#export CC="$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc-4.9 --sysroot=$SYSROOT -target armv7-none-linux-androideabi -gcc-toolchain $NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64"

echo -------------------- mkdir DEPS and cd DEPS --------------------
mkdir DEPS
cd DEPS

cp /home/devshark/SCRATCH/doubango_env/doubango_deps.sh .
. doubango_deps.sh


#copy includes from DEPS to thirdparties
#ilbc -> thirdparties/scripts/ilbc
echo -------------------- iLBC -> thirdparties/scripts/iLBC --------------------
cp -rf DEPS/ilbc thirdparties/scripts/ilbc
#ilbc/*.h -> thirdparties/android/common/include/ilbc
#echo -------------------- iLBC/*.h -> thirdparties/android/common/include/iLBC --------------------
#cp DEPS/ilbc/*.h thirdparties/android/common/include/ilbc
#echo -------------------- g729b/*.h -> thirdparties/android/common/include/g729b --------------------
#cp DEPS/g729b/*.h thirdparties/android/common/include/g729b
#echo -------------------- FFMPEG/libavcodec/*.h -> thirdparties/android/common/include/libavcodec --------------------
#cp DEPS/ffmpeg/libavcodec/*.h thirdparties/android/common/include/libavcodec
#echo -------------------- FFMPEG/libavdevice/*.h -> thirdparties/android/common/include/libavdevice --------------------
#cp DEPS/ffmpeg/libavdevice/*.h thirdparties/android/common/include/libavdevice

#minimal build
echo -------------------- Doubango minimal build: autogen, configure --------------------
#cd .. && ./autogen.sh && ./configure --with-ssl --with-srtp --with-speexdsp
./autogen.sh && ./configure --with-ssl --with-srtp --with-speexdsp
# ./autogen.sh && ./configure --with-ssl=DEPS/openssl-1.0.1c --with-srtp=DEPS/libsrtp --with-speexdsp=DEPS/speex-1.2beta3
echo -------------------- Doubango minimal build: make and make install --------------------
make
sudo make install

#recommended build
#echo -------------------- Doubango recommended build (autogen, configure) --------------------
#cd .. && ./autogen.sh && ./configure --with-ssl --with-srtp --with-speexdsp --with-ffmpeg --with-opus
#echo -------------------- Doubango minimal build (make && make install) --------------------
#make && make install

#full build
#echo -------------------- Doubango full build (autogen, configure) --------------------
#cd .. && ./autogen.sh && ./configure --with-ssl --with-srtp --with-vpx --with-yuv --with-amr --with-speex --with-speexdsp --enable-speexresampler --enable-speexdenoiser --with-opus --with-gsm --with-ilbc --with-g729 --with-ffmpeg
#echo -------------------- Doubango full build (make && make install) --------------------
#make && make install
