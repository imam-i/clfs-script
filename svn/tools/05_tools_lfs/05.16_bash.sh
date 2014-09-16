%CONFIG%
cd ../${name}-${version}
patch -Np1 -i ${LFS_SRC}/bash-${version}-upstream_fixes-3.patch

cd ../${name}-build
../${name}-${version}/configure \
	--prefix=/tools         \
	--without-bash-malloc

%BUILD%
make

%CHECK%
make tests

%INSTALL%
make install
ln -vs bash /tools/bin/sh
