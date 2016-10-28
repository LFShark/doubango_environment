echo ---------------------------------------------
echo --------- CHECKING OUT DEPENDANCIES ---------
echo --------------------------------------------- 


#setup NDK path
export NDK=/home/devshark/SCRATCH/android-ndk-r12b

#libSRTP
echo -------------------- Cloning libSRTP and building --------------------
pwd
git clone https://github.com/cisco/libsrtp/
cd libsrtp
git checkout v1.5.0
CFLAGS="-fPIC" ./configure --enable-pic
#make
#sudo make install
pwd
cd ..
pwd
read

#OpenSSL
echo -------------------- Cloning openSSL and configuring --------------------
pwd
wget --no-check-certificate http://www.openssl.org/source/openssl-1.0.1c.tar.gz
tar -xvzf openssl-1.0.1c.tar.gz
cd openssl-1.0.1c
./config shared --prefix=/usr/local --openssldir=/usr/local/openssl
#replace Makefile with makefile without install_docs
rm Makefile && cp /home/devshark/SCRATCH/doubango_env/openssl_makefile Makefile
#make
#sudo make install
pwd
read

#./Configure shared --prefix=/usr/local --openssldir=/usr/local/openssl android
echo -------------------- openSSL/setenv-android.sh and make, make install --------------------
#cp /home/devshark/SCRATCH/setenv-android.sh
# scratch/doubango/deps/openssl
cp /home/devshark/SCRATCH/doubango_env/setenv-android.sh .
sh setenv-android.sh
#make
#sudo make install
pwd
cd ..
pwd
read

#speex
#sudo apt-get install libspeex-dev
echo -------------------- Cloning speex --------------------
pwd
wget http://downloads.xiph.org/releases/speex/speex-1.2beta3.tar.gz
tar -xvzf speex-1.2beta3.tar.gz
cd speex-1.2beta3
echo -------------------- ./configure, make, make install --------------------
./configure --disable-oggtest --without-libogg
#make
#sudo make install
pwd
cd ..
pwd
read

#YASM
echo -------------------- Cloning YASM, configure, make, make install --------------------
pwd
read
#wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar -xvzf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
#make
#sudo make install
cd ..

#libvpx
#sudo apt-get install libvpx-dev
echo -------------------- Cloning libvpx --------------------
pwd
git clone https://chromium.googlesource.com/chromium/deps/libvpx
cd libvpx
echo ---------- libvpx/configure, make, make install ----------
./configure --enable-realtime-only --enable-error-concealment --disable-examples --enable-vp8 --enable-pic --enable-shared --as=yasm
#make
#sudo make install
cd ..


#libyuv
echo -------------------- Cloning libyuv --------------------
mkdir libyuv && cd libyuv
svn co http://src.chromium.org/svn/trunk/tools/depot_tools . 
echo -------------------- libyuv/configure, make --------------------
./gclient config http://libyuv.googlecode.com/svn/trunk
./gclient sync && cd trunk
#make -j6 V=1 -r libyuv BUILDTYPE=Release
#cp out/Release/obj.target/libyuv.a /usr/local/lib
#mkdir /usr/local/include/libyuv && cp -r include/* /usr/local/include/libyuv
cd ..

#libopus
echo -------------------- Cloning libopus --------------------
#wget http://downloads.xiph.org/releases/opus/opus-1.0.2.tar.gz
wget http://downloads.xiph.org/releases/opus/opus-1.1.3.tar.gz
tar -xvzf opus-1.1.3.tar.gz
cd opus-1.1.3
echo -------------------- libyuv/configure, make, make install --------------------
./configure --with-pic --enable-float-approx
#make
#sudo make install
cd ..

#opencore-amv
echo -------------------- Cloning opencore-amv, configure, make, make install --------------------
git clone git://opencore-amr.git.sourceforge.net/gitroot/opencore-amr/opencore-amr
cd opencore-amr && autoreconf --install
./configure
make
sudo make install
cd ..


#libgsm
#sudo apt-get install libgsm1-dev
echo -------------------- Cloning libgsm --------------------
#wget http://www.quut.com/gsm/gsm-1.0.13.tar.gz
wget http://www.quut.com/gsm/gsm-1.0.16.tar.gz
tar -xvzf gsm-1.0.16.tar.gz
echo -------------------- libgsm/make, make install --------------------
#cd gsm-1.0-pl13 && make && sudo make install
cd gsm-1.0-pl16
#make
#sudo make install
#cp -rf ./inc/* /usr/local/include
#cp -rf ./lib/* /usr/local/lib
cd ..

#g729b
#svn co http://g729.googlecode.com/svn/trunk/ g729b
echo -------------------- Cloning g729b --------------------
git clone https://github.com/DoubangoTelecom/g729 g729b
cd g729b
#./autogen.sh && ./configure --enable-static --disable-shared && make && sudo make install
echo -------------------- g729b/autogen, configure, make, make install --------------------
./autogen.sh
./configure --disable-static --enable-shared
#make
#sudo make install
cd ..

#iLBC
#ilbc is no longer there, use the one fetched from github
echo -------------------- Copying ilbc --------------------
cp -r /home/devshark/SCRATCH/ilbc-master ilbc
#svn co http://doubango.googlecode.com/svn/branches/2.0/doubango/thirdparties/scripts/ilbc ilbc
cd ilbc
wget http://www.ietf.org/rfc/rfc3951.txt
awk -f extract.awk rfc3951.txt
echo -------------------- ilbc autogen, configure --------------------
./autogen.sh && ./configure
echo -------------------- ilbc make, make install --------------------
#make
#sudo make install
cd ..

#x264
echo -------------------- Cloning x264 --------------------
wget ftp://ftp.videolan.org/pub/x264/snapshots/last_stable_x264.tar.bz2
tar -xvjf last_stable_x264.tar.bz2
# the output directory may be difference depending on the version and date
cd x264-snapshot-20160926-2245-stable
echo -------------------- x264/configure, make, make install --------------------
./configure --enable-shared --enable-pic
#make
#sudo make install
pwd
cd ..

#FFMPEG
echo -------------------- Cloning FFMPEG --------------------
git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg
cd ffmpeg
git checkout n1.2
echo -------------------- FFMPEG/ configure --------------------
./configure \
--extra-cflags="-fPIC" \
--extra-ldflags="-lpthread" \
--enable-libx264 --enable-encoder=libx264 --enable-decoder=h264 \
--enable-pic --enable-memalign-hack --enable-pthreads \
--enable-shared --disable-static --disable-asm \
--disable-network --enable-pthreads \
--disable-ffmpeg --disable-ffplay --disable-ffserver --disable-ffprobe \
--enable-encoder=h263 --enable-encoder=h263p --enable-decoder=h263 \
--enable-gpl --enable-nonfree \
--disable-debug
echo -------------------- FFMPEG/ make and make install --------------------
#make
#sudo make install
cd ..

#OpenH264
echo -------------------- Cloning OpenH264 --------------------
git clone https://github.com/cisco/openh264.git
cd openh264
git checkout v1.5.0
echo -------------------- OpenH264/make and make install --------------------
#make ENABLE64BIT=Yes # Use ENABLE64BIT=No for 32bit platforms
#sudo make install
cd ..
#we're back in DEPS

