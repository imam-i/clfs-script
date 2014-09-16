%CONFIG%
../${name}-${version}/configure --prefix=/tools

%INSTALL%
make install
make check
