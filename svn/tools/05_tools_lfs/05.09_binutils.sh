%CONFIG%
CC=${LFS_TGT}-gcc                  \
AR=${LFS_TGT}-ar                   \
RANLIB=${LFS_TGT}-ranlib           \
../${name}-${version}/configure    \
	--prefix=/tools            \
	--disable-nls              \
	--disable-werror           \
	--with-lib-path=/tools/lib \
	--with-sysroot

%BUILD%
make

%INSTALL%
make install
make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin

echo 'Test compiling C'
echo 'main(){}' > dummy.c
${LFS_TGT}-gcc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out
