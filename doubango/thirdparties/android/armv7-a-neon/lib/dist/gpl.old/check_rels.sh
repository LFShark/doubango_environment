
#for f in *.a *.so ;
#do
#   readelf -a f | grep TEXTREL
#done

find . -type f -name "*.a" -printf "readelf -a %p | grep TEXTREL\n" | bash

#readelf -a libtinyWRAP.so | grep TEXTREL
