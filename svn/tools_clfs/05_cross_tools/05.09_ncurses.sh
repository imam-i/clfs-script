#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
pushd ../${PACK}
    patch -Np1 -i ${CLFS_SRC}/${PACK}-bash_fix-1.patch
popd

../${PACK}/configure \
	--prefix=/cross-tools \
	--without-debug \
	--without-shared

%BUILD%
make -C include
make -C progs tic

%INSTALL%
install -v -m755 progs/tic /cross-tools/bin

#######################################
