%CONFIG%
cd ../${name}-${version}
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $(${LFS_TGT}-gcc -print-libgcc-file-name)`/include-fixed/limits.h

for file in \
 `find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h`
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

sed -i 's/if \((code.*))\)/if (\1 \&\& \!DEBUG_INSN_P (insn))/' gcc/sched-deps.c

cd ../${name}-build
CC=${LFS_TGT}-gcc               \
CXX=${LFS_TGT}-g++              \
AR=${LFS_TGT}-ar                \
RANLIB=${LFS_TGT}-ranlib        \
../${name}-${version}/configure \
    --prefix=/tools             \
    --with-local-prefix=/tools  \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++    \
    --disable-libstdcxx-pch     \
    --disable-multilib          \
    --disable-bootstrap         \
    --disable-libgomp

%BUILD%
make

%INSTALL%
make install
ln -vs gcc /tools/bin/cc

echo 'Test compiling C'
echo 'main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out
