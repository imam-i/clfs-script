#######################################

#pushd ${BUILD_DIR}
#unarch 'mpfr' 'gmp' 'mpc' || return ${?}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
pushd ../${PACK}
  cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
    `dirname $(${CLFS_TARGET}-gcc -print-libgcc-file-name)`/include-fixed/limits.h

  case `uname -m` in
    i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
  esac

  for file in \
   $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
  do
    cp -uv $file{,.orig}
    sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
        -e 's@/usr@/tools@g' $file.orig > $file
    echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
    touch $file.orig
  done

  mv -v ../mpfr-* mpfr
  mv -v ../gmp-* gmp
  mv -v ../mpc-* mpc
popd

CC=${CLFS_TARGET}-gcc \
  CXX=${CLFS_TARGET}-g++ \
  AR=${CLFS_TARGET}-ar \
  RANLIB=${CLFS_TARGET}-ranlib \
    ../${PACK}/configure \
	--prefix=/tools \
	--with-local-prefix=/tools \
	--with-native-system-header-dir=/tools/include \
	--enable-clocale=gnu \
	--enable-shared \
	--enable-threads=posix \
	--enable-__cxa_atexit \
	--enable-languages=c,c++ \
	--disable-libstdcxx-pch \
	--disable-multilib \
	--disable-bootstrap \
	--disable-libgomp \
	--with-mpfr-include=$(pwd)/../${PACK}/mpfr/src \
	--with-mpfr-lib=$(pwd)/mpfr/src/.libs

%BUILD%
make

%INSTALL%
make install
ln -sv gcc /tools/bin/cc
echo 'main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out

#######################################
