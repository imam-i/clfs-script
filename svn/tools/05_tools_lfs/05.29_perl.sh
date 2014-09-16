%CONFIG%
sh ../${name}-${version}/Configure -des -Dprefix=/tools -Dlibs=-lm

%BUILD%
make

%INSTALL%
cp -v perl cpan/podlators/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/${version}
cp -Rv lib/* /tools/lib/perl5/${version}
