#######################################

#pushd ${BUILD_DIR}
#unarch 'mpfr' 'gmp' 'mpc' || return ${?}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
pushd ../${PACK}
    patch -Np1 -i ${CLFS_SRC}/${PACK}-branch_update-2.patch
    case "${CLFS_ARCH}" in
	'x86_64') patch -Np1 -i ${CLFS_SRC}/${PACK}-pure64_specs-1.patch ;;
	*) patch -Np1 -i ${CLFS_SRC}/${PACK}-specs-1.patch ;;
    esac

    echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
    echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h

    sed -e 's@\./fixinc\.sh@-c true@' \
	-i gcc/Makefile.in
popd

#mkdir -v ../gcc-build && cd ../gcc-build
CC="${CC} ${BUILD64}" \
  CXX="${CXX} ${BUILD64}" \
    ../${PACK}/configure \
	--prefix=/tools \
	--disable-multilib \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET} \
	--target=${CLFS_TARGET} \
	--libexecdir=/tools/lib \
	--with-local-prefix=/tools \
	--enable-long-long \
	--enable-c99 \
	--enable-shared \
	--enable-threads=posix \
	--disable-nls \
	--enable-__cxa_atexit \
	--enable-languages=c,c++ \
	--disable-libstdcxx-pch \
	--with-gmp=/tools \
	--with-mpfr=/tools \
	--with-mpc=/tools \
	--with-isl=/tools \
	--with-cloog=/tools \
	--with-system-zlib \
	--with-native-system-header-dir=/tools/include \
	--enable-checking=release \
	--enable-libstdcxx-time

sed -e "/^HOST_\(GMP\|ISL\|CLOOG\)\(LIBS\|INC\)/s:/tools:/cross-tools:g" \
    -i Makefile

%BUILD%
make AS_FOR_TARGET="${AS}" LD_FOR_TARGET="${LD}"

%INSTALL%
make install

#######################################
