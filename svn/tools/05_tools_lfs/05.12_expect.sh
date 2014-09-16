%CONFIG%
cd ../${name}-${version}
cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

cd ../${name}-build
../${name}-${version}/configure \
	--prefix=/tools        \
	--with-tcl=/tools/lib  \
	--with-tclinclude=/tools/include

%BUILD%
make

%CHECK%
make test

%INSTALL%
make SCRIPTS="" install
