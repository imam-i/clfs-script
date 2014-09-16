#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

sed -i 's/.*mandir.*//g' Makefile.in || return ${?}

CC="${CC} -Os" ./configure --prefix=/usr --host=${CLFS_TARGET} || return ${?}
make MULTI=1 \
  PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" || return ${?}
make MULTI=1 \
  PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" \
  install DESTDIR=${CLFS}/targetfs || return ${?}

install -dv ${CLFS}/targetfs/etc/dropbear || return ${?}

cd ${CLFS_SRC}/bootscripts-embedded && \
make install-dropbear DESTDIR=${CLFS}/targetfs || return ${?}

popd

#######################################
