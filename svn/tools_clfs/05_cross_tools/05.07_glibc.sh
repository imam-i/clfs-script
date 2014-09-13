#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${name}-${version}

%CONFIG%
pushd ../${PACK}
if [ ! -r /usr/include/rpc/types.h ]; then
  su -c 'mkdir -pv /usr/include/rpc'
  su -c 'cp -v sunrpc/rpc/*.h /usr/include/rpc'
fi
popd

../${PACK}/configure \
	--prefix=/tools \
	--host=${CLFS_TARGET} \
	--build=$(../${PACK}/scripts/config.guess) \
	--disable-profile \
	--enable-kernel=2.6.32 \
	--with-headers=/tools/include \
	libc_cv_forced_unwind=yes \
	libc_cv_ctors_header=yes \
	libc_cv_c_cleanup=yes

%BUILD%
make

%INSTALL%
make install

echo 'main(){}' > dummy.c
${CLFS_TARGET}-gcc dummy.c
readelf -l a.out | grep ': /tools'

rm -v dummy.c a.out

#######################################
