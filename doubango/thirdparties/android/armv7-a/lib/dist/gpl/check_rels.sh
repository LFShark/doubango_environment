
for f in *.a *.so ;
do
   readelf -a f | grep TEXTREL
; done

#readelf -a libtinyWRAP.so | grep TEXTREL
