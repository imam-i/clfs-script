#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
CC=$LFS_TGT-gcc \
  AR=$LFS_TGT-ar \
  RANLIB=$LFS_TGT-ranlib \
    ../${PACK}/configure \
	--prefix=/tools \
	--disable-nls \
	--disable-werror \
	--with-lib-path=/tools/lib \
	--with-sysroot

%BUILD%
make

%INSTALL%
make install
make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin

#######################################
