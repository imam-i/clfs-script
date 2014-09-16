%CONFIG%
local version=`echo ${version} | cut -d- -f1`

../${name}${version}/unix/configure --prefix=/tools

%BUILD%
make

%CHECK%
TZ=UTC make test

%INSTALL%
make install
chmod -v u+w /tools/lib/libtcl8.6.so
make install-private-headers
ln -sv tclsh8.6 /tools/bin/tclsh
