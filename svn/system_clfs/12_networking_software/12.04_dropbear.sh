#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

cp Makefile.in{,.orig} &&
sed -e s/@LD@/@CC@/ Makefile.in.orig > Makefile.in || return ${?}

CC="${CC} -Os" ./configure --prefix=/usr --host=${CLFS_TARGET} || return ${?}
cp -v options.h options.h.backup &&
sed -e "s@/dev/random@/dev/urandom@" options.h.backup > options.h || return ${?}
make MULTI=1 PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" || return ${?}
make MULTI=1 PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" \
    install DESTDIR=${CLFS} || return ${?}

ln -svf /usr/bin/dropbearmulti ${CLFS}/usr/sbin/dropbear || return ${?}
ln -svf /usr/bin/dropbearmulti ${CLFS}/usr/bin/dbclient || return ${?}
ln -svf /usr/bin/dropbearmulti ${CLFS}/usr/bin/dropbearkey || return ${?}
ln -svf /usr/bin/dropbearmulti ${CLFS}/usr/bin/dropbearconvert || return ${?}
ln -svf /usr/bin/dropbearmulti ${CLFS}/usr/bin/scp || return ${?}

install -dv ${CLFS}/etc/dropbear || return ${?}

cd ${CLFS_SRC}/bootscripts-embedded &&
make install-dropbear DESTDIR=${CLFS} || return ${?}

popd

#######################################
