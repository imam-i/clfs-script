%CONFIG%
../${name}-${version}/configure \
	--prefix=/tools         \
	--without-guile

%BUILD%
make

%CHECK%
make check

%INSTALL%
make install
