%CONFIG%
cd ../${name}-${version}/
if [ ! -r /usr/include/rpc/types.h ]; then
  su -c 'mkdir -p /usr/include/rpc'
  su -c 'cp -v sunrpc/rpc/*.h /usr/include/rpc'
fi

cd ../${name}-build
../${name}-${version}/configure                    \
	--prefix=/tools                            \
	--host=${LFS_TGT}                          \
	--build=$(../${PACK}/scripts/config.guess) \
	--disable-profile                          \
	--enable-kernel=2.6.32                     \
	--with-headers=/tools/include              \
	libc_cv_forced_unwind=yes                  \
	libc_cv_ctors_header=yes                   \
	libc_cv_c_cleanup=yes

%BUILD%
make

%INSTALL%
make install

echo 'Test compiling C'
echo 'main(){}' > dummy.c
${LFS_TGT}-gcc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out
