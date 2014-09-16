<?php
$arr = array (

# lfs 06
'linux' => array (
		'status' => '1',
		'lfs' => '05;06;08',
		'version' => '3.16.2',
		'md5' => '227814a1a523992400da5d5437552445',
		'url' => 'ftp://ftp.kernel.org/pub/linux/kernel/v3.x/linux-_version.tar.xz'
	),

'man-pages' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '3.62',
		'md5' => '3877e1539dcb46bd23605b4d9d73c57d',
		'url' => 'http://www.kernel.org/pub/linux/docs/man-pages/man-pages-_version.tar.xz'
	),

'glibc' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '2.20',
		'md5' => '948a6e06419a01bd51e97206861595b0',
		'url' => 'http://ftp.gnu.org/gnu/glibc/glibc-_version.tar.xz',

		'md5patch1' => '9a5997c3452909b1769918c759eff8a2',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/systemd/glibc-_version-fhs-1.patch',

		'depends_lfs' => 'notlfs.my.base-core:lfs.06.linux-headers:notlfs.my.tzdata'
	),

'test-ld' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '0.1',
		'md5' => 'NONE',
		'url' => 'NONE'
	),

'zlib' => array (
		'status' => '1',
		'lfs' => '06',
		'notlfs' => 'pm',
		'version' => '1.2.8',
		'md5' => '28f1205d8dd2001f26fec1e8c2cebe37',
		'url' => 'http://www.zlib.net/zlib-_version.tar.xz',

		'depends_lfs' => 'lfs.06.glibc',
		'depends_notlfs' => 'lfs.06.glibc'
	),

'file' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '5.19',
		'md5' => 'e3526f59023f3f7d1ffa4d541335edab',
		'url' => 'ftp://ftp.astron.com/pub/file/file-_version.tar.gz',

		'depends_lfs' => 'lfs.06.glibc:lfs.06.zlib'
	),

'binutils' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '2.24',
		'md5' => 'e0f71a7b2ddab0f8612336ac81d9636b',
		'url' => 'http://ftp.gnu.org/gnu/binutils/binutils-_version.tar.bz2',

		//'md5patch1' => 'cb47fae1bc572d45f4b0cff8ae8ecba8',
		//'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/development/binutils-_version-testsuite_fix-1.patch',

		'depends_lfs' => 'lfs.06.glibc:lfs.06.zlib:lfs.06.file'
	),

'gmp' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '6.0.0a',
		'md5' => '1e6da4e434553d2811437aa42c7f7c76',
		'url' => 'http://ftp.gnu.org/gnu//gmp/gmp-_version.tar.xz'
	),

'mpfr' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '3.1.2',
		'md5' => 'e3d203d188b8fe60bb6578dd3152e05c',
		'url' => 'http://www.mpfr.org/mpfr-_version/mpfr-_version.tar.xz',

		'depends_lfs' => 'lfs.06.gmp'
	),

'mpc' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '1.0.2',
		'md5' => '68fadff3358fb3e7976c7a398a0af4c3',
		'url' => 'http://www.multiprecision.org/mpc/download/mpc-_version.tar.gz',

		'depends_lfs' => 'lfs.06.mpfr'
	),

'gcc' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '4.9.1',
		'md5' => 'fddf71348546af523353bd43d34919c1',
		'url' => 'http://ftp.gnu.org/gnu/gcc/gcc-_version/gcc-_version.tar.bz2',

		'extract_lfs_05' => 'gmp;mpfr;mpc',

		'depends_lfs' => 'lfs.06.binutils:lfs.06.gmp:lfs.06.mpfr:lfs.06.mpc'
		//'checkdepends' => 'lfs.05.dejagnu:lfs.05.expect'
	),

'sed' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '4.2.2',
		'md5' => '7ffe1c7cdc3233e1e0c4b502df253974',
		'url' => 'http://ftp.gnu.org/gnu/sed/sed-_version.tar.bz2'
	),

'bzip2' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '1.0.6',
		'md5' => '00b516f4704d4a7cb50a1d97e6e8e15b',
		'url' => 'http://www.bzip.org/_version/bzip2-_version.tar.gz',

		'md5patch1' => '6a5ac7e89b791aae556de0f745916f7f',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/development/bzip2-_version-install_docs-1.patch',

		'depends_lfs' => 'lfs.06.glibc'
	),

'pkg-config' => array (
		'status' => '1',
		'lfs' => '06',
		'blfs' => '13',
		'version' => '0.28',
		'md5' => 'aa3c86e67551adc3ac865160e34a2a0d',
		'url' => 'http://pkgconfig.freedesktop.org/releases/pkg-config-_version.tar.gz'
	),

'ncurses' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '5.9',
		'md5' => '8cb9c412e5f2d96bc6f459aa8c6282a1',
		'url' => 'ftp://ftp.gnu.org/gnu/ncurses/ncurses-_version.tar.gz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'shadow' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '4.1.5.1',
		'md5' => 'a00449aa439c69287b6d472191dc2247',
		'url' => 'http://pkg-shadow.alioth.debian.org/releases/shadow-_version.tar.bz2',

		'depends_blfs' => 'blfs.04.Linux-PAM'
	),

'util-linux' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '2.25.1',
		'md5' => '2ff36a8f8ede70f66c5ad0fb09e40e79',
		'url' => 'http://www.kernel.org/pub/linux/utils/util-linux/v2.25/util-linux-_version.tar.xz',

		'depends_lfs' => 'lfs.06.shadow:lfs.06.glibc'
	),

'psmisc' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '22.21',
		'md5' => '935c0fd6eb208288262b385fa656f1bf',
		'url' => 'http://prdownloads.sourceforge.net/psmisc/psmisc-_version.tar.gz',

		'depends_lfs' => 'lfs.06.ncurses'
	),

'procps-ng' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '3.3.8',
		'md5' => 'aecbeeda2ab308f8d09dddcb4cb9a572',
		'url' => 'http://sourceforge.net/projects/procps-ng/files/Production/procps-ng-_version.tar.xz',

		'depends_lfs' => 'lfs.06.ncurses'
	),

'e2fsprogs' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '1.42.9',
		'md5' => '3f8e41e63b432ba114b33f58674563f7',
		'url' => 'http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-_version.tar.gz'

		//'depends_lfs' => 'lfs.06.util-linux'
	),

'coreutils' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '8.23',
		'md5' => 'abed135279f87ad6762ce57ff6d89c41',
		'url' => 'http://ftp.gnu.org/gnu/coreutils/coreutils-_version.tar.xz',

		'md5patch1' => '587051bc411e0da9b3bf8984b49b364e',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/development/coreutils-_version-i18n-1.patch',

		'depends_lfs' => 'lfs.06.glibc:lfs.06.gmp'
	),

'iana-etc' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.30',
		'md5' => '3ba3afb1d1b261383d247f46cb135ee8',
		'url' => 'http://anduin.linuxfromscratch.org/sources/LFS/lfs-packages/conglomeration/iana-etc/iana-etc-_version.tar.bz2'
	),

'm4' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '1.4.17',
		'md5' => '12a3c829301a4fd6586a57d3fcf196dc',
		'url' => 'http://ftp.gnu.org/gnu/m4/m4-_version.tar.xz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'flex' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.5.38',
		'md5' => 'b230c88e65996ff74994d08a2a2e0f27',
		'url' => 'http://prdownloads.sourceforge.net/flex/flex-_version.tar.bz2',

		'depends_lfs' => 'lfs.06.glibc:lfs.06.m4'
	),

'bison' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '3.0.2',
		'md5' => '146be9ff9fbd27497f0bf2286a5a2082',
		'url' => 'http://ftp.gnu.org/gnu/bison/bison-_version.tar.xz',

		'depends_lfs' => 'lfs.06.flex:lfs.06.m4'
	),

'grep' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '2.20',
		'md5' => '2cbea44a4f1548aee20b9ff2d3076908',
		'url' => 'http://ftp.gnu.org/gnu/grep/grep-_version.tar.xz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'readline' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '6.3',
		'md5' => '33c8fb279e981274f485fd91da77e94a',
		'url' => 'http://ftp.gnu.org/gnu/readline/readline-_version.tar.gz',

		//'md5patch1' => 'b793b2bf1306bc62e5f1e7ebbdae2f35',
		//'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/development/readline-_version-fixes-2.patch',

		'depends_lfs' => 'lfs.06.glibc:lfs.06.ncurses'
	),

'bash' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '4.3',
		'md5' => '81348932d5da294953e15d4814c74dd1',
		'url' => 'http://ftp.gnu.org/gnu/bash/bash-_version.tar.gz',

		'md5patch1' => '3266ce3d2f0aa647d4ef068e46899246',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/systemd/bash-_version-upstream_fixes-3.patch',

		'depends_lfs' => 'lfs.06.glibc:lfs.06.readline'
	),

'bc' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '1.06.95',
		'md5' => '5126a721b73f97d715bb72c13c889035',
		'url' => 'ftp://alpha.gnu.org/gnu/bc/bc-_version.tar.bz2',

		'md5patch1' => '877e81fba316fe487ec23501059d54b8',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/systemd/bc-_version-memory_leak-1.patch',

		'depends_lfs' => 'lfs.06.glibc'
	),

'libtool' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.4.2',
		'md5' => 'd2f3b7d4627e69e13514a40e72a24d50',
		'url' => 'http://ftp.gnu.org/gnu/libtool/libtool-_version.tar.gz',

		'makedepends_lfs' => 'lfs.06.gcc'
	),

'gdbm' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '1.11',
		'md5' => '72c832680cf0999caedbe5b265c8c1bd',
		'url' => 'http://ftp.gnu.org/gnu/gdbm/gdbm-_version.tar.gz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'inetutils' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '1.9.2',
		'md5' => 'aa1a9a132259db83e66c1f3265065ba2',
		'url' => 'http://ftp.gnu.org/gnu/inetutils/inetutils-_version.tar.gz'

		//'depends' => 'blfs.04.Linux-PAM'
	),

'perl' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '5.20.0',
		'md5' => '20cbecd4e9e880ee7a50a136c8b1484e',
		'url' => 'http://www.cpan.org/src/5.0/perl-_version.tar.bz2',

		'depends_lfs' => 'lfs.06.coreutils:lfs.06.gdbm:lfs.06.glibc'
	),

'autoconf' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.69',
		'md5' => '50f97f4159805e374639a73e2636f22e',
		'url' => 'http://ftp.gnu.org/gnu/autoconf/autoconf-_version.tar.xz',

		'depends_lfs' => 'lfs.06.m4:lfs.06.bash'
	),

'automake' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '1.14.1',
		'md5' => '7fc29854c520f56b07aa232a0f880292',
		'url' => 'http://ftp.gnu.org/gnu/automake/automake-_version.tar.xz',

		'depends_lfs' => 'lfs.06.perl:lfs.06.bash',

		'makedepends_lfs' => 'lfs.06.autoconf'
	),

'diffutils' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '3.3',
		'md5' => '99180208ec2a82ce71f55b0d7389f1b3',
		'url' => 'http://ftp.gnu.org/gnu/diffutils/diffutils-_version.tar.xz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'gawk' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '4.1.1',
		'md5' => 'a2a26543ce410eb74bc4a508349ed09a',
		'url' => 'http://ftp.gnu.org/gnu/gawk/gawk-_version.tar.xz',

		'depends_lfs' => 'lfs.06.glibc:lfs.06.mpfr'
	),

'findutils' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '4.4.2',
		'md5' => '351cc4adb07d54877fa15f75fb77d39f',
		'url' => 'http://ftp.gnu.org/gnu/findutils/findutils-_version.tar.gz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'gettext' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '0.19.2',
		'md5' => '1e6a827f5fbd98b3d40bd16b803acc44',
		'url' => 'http://ftp.gnu.org/gnu/gettext/gettext-_version.tar.gz',

		'depends_lfs' => 'lfs.06.gcc'
	),

'groff' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '1.22.2',
		'md5' => '9f4cd592a5efc7e36481d8d8d8af6d16',
		'url' => 'http://ftp.gnu.org/gnu/groff/groff-_version.tar.gz',

		'depends_lfs' => 'lfs.06.gcc:lfs.06.perl'
	),

'xz' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '5.0.5',
		'md5' => 'aa17280f4521dbeebed0fbd11cd7fa30',
		'url' => 'http://tukaani.org/xz/xz-_version.tar.xz'
	),

'grub' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.00',
		'md5' => 'a1043102fbc7bcedbf53e7ee3d17ab91',
		'url' => 'http://ftp.gnu.org/gnu/grub/grub-_version.tar.xz',

		'depends_lfs' => 'lfs.06.bash:lfs.06.gettext:lfs.06.xz'
	),

'less' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '458',
		'md5' => '935b38aa2e73c888c210dedf8fd94f49',
		'url' => 'http://www.greenwoodsoftware.com/less/less-_version.tar.gz',

		'depends_lfs' => 'lfs.06.ncurses'
	),

'gzip' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '1.6',
		'md5' => 'da981f86677d58a106496e68de6f8995',
		'url' => 'http://ftp.gnu.org/gnu/gzip/gzip-_version.tar.xz',

		'depends_lfs' => 'lfs.06.bash:lfs.06.glibc:lfs.06.less'
	),

'iproute2' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '3.12.0',
		'md5' => 'f87386aaaecafab95607fd10e8152c68',
		'url' => 'http://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-_version.tar.xz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'kbd' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.0.1',
		'md5' => 'cc0ee9f2537d8636cae85a8c6541ed2e',
		'url' => 'http://ftp.altlinux.org/pub/people/legion/kbd/kbd-_version.tar.gz',

		'md5patch1' => 'f75cca16a38da6caa7d52151f7136895',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/development/kbd-_version-backspace-1.patch',

		'depends_lfs' => 'lfs.06.glibc'
	),

'kmod' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '16',
		'md5' => '3006a0287211212501cdfe1211b29f09',
		'url' => 'http://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-_version.tar.xz',

		'depends_lfs' => 'lfs.06.glibc:lfs.06.zlib'
	),

'libpipeline' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '1.2.6',
		'md5' => '6d1d51a5dc102af41e0d269d2a31e6f9',
		'url' => 'http://download.savannah.gnu.org/releases/libpipeline/libpipeline-_version.tar.gz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'make' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '4.0',
		'md5' => '571d470a7647b455e3af3f92d79f1c18',
		'url' => 'http://ftp.gnu.org/gnu/make/make-_version.tar.bz2',

		'depends_lfs' => 'lfs.06.bash:lfs.06.glibc'
	),

'man-db' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.6.6',
		'md5' => '5d65d66191080c144437a6c854e17868',
		'url' => 'http://download.savannah.gnu.org/releases/man-db/man-db-_version.tar.xz',

		'depends_lfs' => 'lfs.06.bash:lfs.06.zlib:lfs.06.gdbm:lfs.06.groff:lfs.06.less:lfs.06.libpipeline'
	),

'patch' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '2.7.1',
		'md5' => 'e9ae5393426d3ad783a300a338c09b72',
		'url' => 'http://ftp.gnu.org/gnu/patch/patch-_version.tar.xz',

		'depends_lfs' => 'lfs.06.glibc'
	),

'tar' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '1.28',
		'md5' => '49b6306167724fe48f419a33a5beb857',
		'url' => 'http://ftp.gnu.org/gnu/tar/tar-_version.tar.xz',

		'depends_lfs' => 'lfs.06.bash:lfs.06.glibc'
	),

'texinfo' => array (
		'status' => '1',
		'lfs' => '05;06',
		'version' => '5.2',
		'md5' => 'cb489df8a7ee9d10a236197aefdb32c5',
		'url' => 'http://ftp.gnu.org/gnu/texinfo/texinfo-_version.tar.xz',

		'depends_lfs' => 'lfs.06.ncurses:lfs.06.findutils:lfs.06.perl:lfs.06.gzip'
	),

'systemd' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '211',
		'md5' => '0a70c382b6089526f98073b4ee85ef75',
		'url' => 'http://www.freedesktop.org/software/systemd/systemd-_version.tar.xz',

		'md5patch1' => '0edc54bbe9391cfb072bc737312e6b7a',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/lfs/systemd/systemd-_version-compat-1.patch'
	),


'vim' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '7.4',
		'md5' => '607e135c559be642f210094ad023dc65',
		'url' => 'ftp://ftp.vim.org/pub/vim/unix/vim-_version.tar.bz2',

		'depends_lfs' => 'lfs.06.ncurses'
	),

### Systemd ###

'acl' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.2.52',
		'md5' => 'a61415312426e9c2212bd7dc7929abda',
		'url' => 'http://download.savannah.gnu.org/releases/acl/acl-_version.src.tar.gz',

		'depends_lfs' => ''
	),

'attr' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.4.47',
		'md5' => '84f58dec00b60f2dc8fd1c9709291cc7',
		'url' => 'http://download.savannah.gnu.org/releases/attr/attr-_version.src.tar.gz',

		'depends_lfs' => ''
	),

'libcap' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.24',
		'md5' => 'd43ab9f680435a7fff35b4ace8d45b80',
		'url' => 'http://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-_version.tar.xz',

		'depends_lfs' => ''
	),

'expat' => array (
		'status' => '1',
		'lfs' => '06',
		'blfs' => '09',
		'version' => '2.1.0',
		'md5' => 'dd7dab7a5fea97d2a6a43f511449b7cd',
		'url' => 'http://prdownloads.sourceforge.net/expat/expat-_version.tar.gz',

		'depends_lfs' => ''
	),

'perl-xml-parser' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '2.42_01',
		'md5' => 'a4650aebcc464bb91113c2c356da8210',
		'url' => 'http://search.cpan.org/CPAN/authors/id/T/TO/TODDR/XML-Parser-_version.tar.gz',

		'depends_lfs' => ''
	),

'intltool' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '0.50.2',
		'md5' => '23fbd879118253cb99aeac067da5f591',
		'url' => 'http://launchpad.net/intltool/trunk/_version/+download/intltool-_version.tar.gz',

		'depends_lfs' => ''
	),

'gperf' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '3.0.4',
		'md5' => 'c1f1db32fb6598d6a93e6e88796a8632',
		'url' => 'http://ftp.gnu.org/gnu/gperf/gperf-_version.tar.gz',

		'depends_lfs' => ''
	),

'dbus' => array (
		'status' => '1',
		'lfs' => '06',
		'version' => '1.6.18',
		'md5' => 'b02e9c95027a416987b81f9893831061',
		'url' => 'http://dbus.freedesktop.org/releases/dbus/dbus-_version.tar.gz',

		'depends_lfs' => ''
	),

);

// Альтернативне имена пакетов
$arr['linux-headers']	= &$arr['linux'];
$arr['libstdc++']	= &$arr['gcc'];
$arr['libdbus']		= &$arr['dbus'];

?>
