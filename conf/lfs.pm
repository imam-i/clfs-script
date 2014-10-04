package lfs;

our %pkg = (

"mpfr" => {
	"type" => "pkg",
	"url" => "http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.xz",
	"urlpatch" => [
		"http://www.linuxfromscratch.org/patches/lfs/systemd/mpfr-3.1.2-upstream_fixes-2.patch"
	],
	"chapter" => [
		"05"
	],
	"md5patch" => [
		"2b2aa4371a4e848411639356fd82becf"
	],
	"md5" => "e3d203d188b8fe60bb6578dd3152e05c",
	"status" => "1",
	"version" => "3.1.2"

},

"mpc" => {
	"url" => "http://www.multiprecision.org/mpc/download/mpc-1.0.2.tar.gz",
	"chapter" => [
		"05"
	],
	"type" => "pkg",
	"version" => "1.0.2",
	"status" => "1",
	"md5" => "68fadff3358fb3e7976c7a398a0af4c3"

},

"ncurses" => {
	"status" => "1",
	"version" => "5.9",
	"md5" => "8cb9c412e5f2d96bc6f459aa8c6282a1",
	"C05" => [
		"15"
	],
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu//ncurses/ncurses-5.9.tar.gz",
	"type" => "pkg"

},

"texinfo" => {
	"status" => "1",
	"version" => "5.2",
	"C05" => [
		"32"
	],
	"md5" => "cb489df8a7ee9d10a236197aefdb32c5",
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu/texinfo/texinfo-5.2.tar.xz",
	"type" => "pkg"

},

"libstdc++" => {
	"link" => "gcc",
	"chapter" => [
		"05"
	],
	"type" => "link",
	"status" => "1",
	"C05" => [
		"08"
	]

},

"gzip" => {
	"type" => "pkg",
	"url" => "http://ftp.gnu.org/gnu/gzip/gzip-1.6.tar.xz",
	"chapter" => [
		"05"
	],
	"md5" => "da981f86677d58a106496e68de6f8995",
	"C05" => [
		"25"
	],
	"version" => "1.6",
	"status" => "1"

},

"linux" => {
	"type" => "pkg",
	"C08" => [
		"03"
	],
	"chapter" => [
		"08"
	],
	"url" => "https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.16.3.tar.xz",
	"md5" => "96f1d5219534e89f7477960695093654",
	"status" => "1",
	"version" => "3.16.3"

},

"bash" => {
	"version" => "4.3",
	"status" => "1",
	"md5" => "81348932d5da294953e15d4814c74dd1",
	"C05" => [
		"16"
	],
	"md5patch" => [
		"6d2ab19ad99e20ca29ccb4e3c95468b72"
	],
	"chapter" => [
		"05"
	],
	"urlpatch" => [
		"http://www.linuxfromscratch.org/patches/lfs/systemd/bash-4.3-upstream_fixes-6.patch"
	],
	"url" => "http://ftp.gnu.org/gnu/bash/bash-4.3.tar.gz",
	"type" => "pkg"

},

"patch" => {
	"C05" => [
		"28"
	],
	"md5" => "e9ae5393426d3ad783a300a338c09b72",
	"version" => "2.7.1",
	"status" => "1",
	"type" => "pkg",
	"url" => "http://ftp.gnu.org/gnu/patch/patch-2.7.1.tar.xz",
	"chapter" => [
		"05"
	]

},

"perl" => {
	"status" => "1",
	"version" => "5.20.1",
	"C05" => [
		"29"
	],
	"md5" => "ede5166f949d9a07163bc5b086be9759",
	"chapter" => [
		"05"
	],
	"url" => "http://www.cpan.org/src/5.0/perl-5.20.1.tar.bz2",
	"type" => "pkg"

},

"sed" => {
	"C05" => [
		"30"
	],
	"md5" => "7ffe1c7cdc3233e1e0c4b502df253974",
	"status" => "1",
	"version" => "4.2.2",
	"type" => "pkg",
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu/sed/sed-4.2.2.tar.bz2"

},

"coreutils" => {
	"url" => "http://ftp.gnu.org/gnu/coreutils/coreutils-8.23.tar.xz",
	"type" => "pkg",
	"urlpatch" => [
		"http://www.linuxfromscratch.org/patches/lfs/systemd/coreutils-8.23-i18n-1.patch"
	],
	"md5patch" => [
		"587051bc411e0da9b3bf8984b49b364e"
	],
	"chapter" => [
		"05"
	],
	"version" => "8.23",
	"status" => "1",
	"C05" => [
		"18"
	],
	"md5" => "abed135279f87ad6762ce57ff6d89c41"

},

"linux-headers" => {
	"type" => "link",
	"link" => "linux",
	"chapter" => [
		"05"
	],
	"C05" => [
		"06"
	],
	"status" => "1"

},

"check" => {
	"status" => "1",
	"version" => "0.9.14",
	"C05" => [
		"14"
	],
	"md5" => "38263d115d784c17aa3b959ce94be8b8",
	"chapter" => [
		"05"
	],
	"url" => "http://sourceforge.net/projects/check/files/check/0.9.14/check-0.9.14.tar.gz",
	"type" => "pkg"

},

"xz" => {
	"type" => "pkg",
	"chapter" => [
		"05"
	],
	"url" => "http://tukaani.org/xz/xz-5.0.7.tar.xz",
	"md5" => "d0456c2c3ea3c356369807eef1e2ae65",
	"C05" => [
		"34"
	],
	"status" => "1",
	"version" => "5.0.7"

},

"m4" => {
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.xz",
	"type" => "pkg",
	"status" => "1",
	"version" => "1.4.17",
	"md5" => "12a3c829301a4fd6586a57d3fcf196dc",
	"C05" => [
		"26"
	]

},

"diffutils" => {
	"type" => "pkg",
	"url" => "http://ftp.gnu.org/gnu/diffutils/diffutils-3.3.tar.xz",
	"chapter" => [
		"05"
	],
	"C05" => [
		"19"
	],
	"md5" => "99180208ec2a82ce71f55b0d7389f1b3",
	"version" => "3.3",
	"status" => "1"

},

"glibc" => {
	"chapter" => [
		"05"
	],
	"md5patch" => [
		"9a5997c3452909b1769918c759eff8a2"
	],
	"status" => "1",
	"version" => "2.20",
	"md5" => "948a6e06419a01bd51e97206861595b0",
	"C05" => [
		"07"
	],
	"url" => "http://ftp.gnu.org/gnu/glibc/glibc-2.20.tar.xz",
	"type" => "pkg",
	"urlpatch" => [
		"http://www.linuxfromscratch.org/patches/lfs/systemd/glibc-2.20-fhs-1.patch"
	]

},

"util-linux" => {
	"version" => "2.25.1",
	"status" => "1",
	"C05" => [
		"33"
	],
	"md5" => "2ff36a8f8ede70f66c5ad0fb09e40e79",
	"url" => "https://www.kernel.org/pub/linux/utils/util-linux/v2.25/util-linux-2.25.1.tar.xz",
	"chapter" => [
		"05"
	],
	"type" => "pkg"

},

"grep" => {
	"status" => "1",
	"version" => "2.20",
	"C05" => [
		"24"
	],
	"md5" => "2cbea44a4f1548aee20b9ff2d3076908",
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu/grep/grep-2.20.tar.xz",
	"type" => "pkg"

},

"gettext" => {
	"status" => "1",
	"version" => "0.19.2",
	"md5" => "1e6a827f5fbd98b3d40bd16b803acc44",
	"C05" => [
		"23"
	],
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu/gettext/gettext-0.19.2.tar.xz",
	"type" => "pkg"

},

"expect" => {
	"version" => "5.45",
	"status" => "1",
	"md5" => "44e1a4f4c877e9ddc5a542dfa7ecc92b",
	"C05" => [
		"12"
	],
	"url" => "http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz",
	"chapter" => [
		"05"
	],
	"type" => "pkg"

},

"tcl" => {
	"C05" => [
		"11"
	],
	"md5" => "8103eaf6d71acb716a64224492f09d5f",
	"status" => "1",
	"version" => "8.6.2",
	"type" => "pkg",
	"chapter" => [
		"05"
	],
	"url" => "http://downloads.sourceforge.net/project/tcl/Tcl/8.6.2/tcl8.6.2-src.tar.gz"

},

"binutils-pass1" => {
	"chapter" => [
		"05"
	],
	"link" => "binutils",
	"type" => "link",
	"status" => "1",
	"C05" => [
		"04"
	]

},

"gmp" => {
	"version" => "6.0.0a",
	"status" => "1",
	"md5" => "1e6da4e434553d2811437aa42c7f7c76",
	"url" => "http://ftp.gnu.org/gnu//gmp/gmp-6.0.0a.tar.xz",
	"chapter" => [
		"05"
	],
	"type" => "pkg"

},

"gawk" => {
	"type" => "pkg",
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu/gawk/gawk-4.1.1.tar.xz",
	"md5" => "a2a26543ce410eb74bc4a508349ed09a",
	"C05" => [
		"22"
	],
	"status" => "1",
	"version" => "4.1.1"

},

"gcc" => {
	"chapter" => [
		"06"
	],
	"md5patch" => [
		"015e026dff5052cd65906ee0bb8f25e8"
	],
	"md5" => "fddf71348546af523353bd43d34919c1",
	"status" => "1",
	"version" => "4.9.1",
	"type" => "pkg",
	"url" => "http://ftp.gnu.org/gnu/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2",
	"urlpatch" => [
		"http://www.linuxfromscratch.org/patches/lfs/systemd/gcc-4.9.1-upstream_fixes-1.patch"
	],
	"C06" => [
		"17"
	]

},

"findutils" => {
	"type" => "pkg",
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu/findutils/findutils-4.4.2.tar.gz",
	"C05" => [
		"21"
	],
	"md5" => "351cc4adb07d54877fa15f75fb77d39f",
	"status" => "1",
	"version" => "4.4.2"

},

"dejagnu" => {
	"version" => "1.5.1",
	"status" => "1",
	"md5" => "8386e04e362345f50ad169f052f4c4ab",
	"C05" => [
		"13"
	],
	"url" => "http://ftp.gnu.org/gnu/dejagnu/dejagnu-1.5.1.tar.gz",
	"chapter" => [
		"05"
	],
	"type" => "pkg"

},

"tar" => {
	"url" => "http://ftp.gnu.org/gnu/tar/tar-1.28.tar.xz",
	"chapter" => [
		"05"
	],
	"type" => "pkg",
	"version" => "1.28",
	"status" => "1",
	"md5" => "49b6306167724fe48f419a33a5beb857",
	"C05" => [
		"31"
	]

},

"gcc-pass2" => {
	"chapter" => [
		"05"
	],
	"link" => "gcc",
	"type" => "link",
	"extract" => [
		"mpfr",
		"gmp",
		"mpc"
	],
	"status" => "1",
	"C05" => [
		"10"
	]

},

"binutils-pass2" => {
	"status" => "1",
	"C05" => [
		"09"
	],
	"chapter" => [
		"05"
	],
	"link" => "binutils",
	"type" => "link"

},

"make" => {
	"md5" => "571d470a7647b455e3af3f92d79f1c18",
	"C05" => [
		"27"
	],
	"status" => "1",
	"version" => "4.0",
	"type" => "pkg",
	"chapter" => [
		"05"
	],
	"url" => "http://ftp.gnu.org/gnu/make/make-4.0.tar.bz2"

},

"gcc-pass1" => {
	"status" => "1",
	"extract" => [
		"mpfr",
		"gmp",
		"mpc"
	],
	"C05" => [
		"05"
	],
	"link" => "gcc",
	"chapter" => [
		"05"
	],
	"type" => "link"

},

"bzip2" => {
	"urlpatch" => [
		"http://www.linuxfromscratch.org/patches/lfs/systemd/bzip2-1.0.6-install_docs-1.patch"
	],
	"type" => "pkg",
	"url" => "http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz",
	"C05" => [
		"17"
	],
	"md5" => "00b516f4704d4a7cb50a1d97e6e8e15b",
	"status" => "1",
	"version" => "1.0.6",
	"chapter" => [
		"05"
	],
	"md5patch" => [
		"6a5ac7e89b791aae556de0f745916f7f"
	]

},

"binutils" => {
	"urlpatch" => [
		"http://www.linuxfromscratch.org/patches/lfs/systemd/binutils-2.24-load_gcc_lto_plugin_by_default-1.patch",
		"http://www.linuxfromscratch.org/patches/lfs/systemd/binutils-2.24-lto_testsuite-1.patch"
	],
	"C06" => [
		"13"
	],
	"type" => "pkg",
	"url" => "http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.bz2",
	"md5" => "e0f71a7b2ddab0f8612336ac81d9636b",
	"status" => "1",
	"version" => "2.24",
	"chapter" => [
		"06"
	],
	"md5patch" => [
		"48e4e96a60bfed41804aaecf4944f5d9",
		"a6647fdb3cca512962bb1433bb6b4f9f"
	]

},

"file" => {
	"type" => "pkg",
	"url" => "ftp://ftp.astron.com/pub/file/file-5.19.tar.gz",
	"chapter" => [
		"05"
	],
	"C05" => [
		"20"
	],
	"md5" => "e3526f59023f3f7d1ffa4d541335edab",
	"version" => "5.19",
	"status" => "1"

}

);

1;