#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}/gettext-tools

%CONFIG%
echo "gl_cv_func_wcwidth_works=yes" > config.cache

CC="${CC} ${BUILD64}" \
  CXX="${CXX} ${BUILD64}" \
    ../${PACK}/gettext-tools/configure \
	--prefix=/tools \
	--disable-shared \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET} \
	--cache-file=config.cache

%BUILD%
make -C gnulib-lib
make -C src msgfmt msgmerge xgettext

%INSTALL%
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

#######################################
