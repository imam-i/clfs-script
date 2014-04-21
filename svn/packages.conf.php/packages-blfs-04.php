<?php
$arr = array (

# blfs 04
'ca-certificates' => array (
		'status' => '1',
		'blfs' => '04',
		'version' => '0.1',
		'md5' => 'NONE',
		'url' => 'NONE',

		'depends_blfs' => 'blfs.04.openssl'
	),

'cracklib' => array (
		'status' => '1',
		'blfs' => '04',
		'version' => '2.9.0',
		'md5' => 'e0f94ac2138fd33c7e77b19c1e9a9390',
		'url' => 'http://downloads.sourceforge.net/cracklib/cracklib-_version.tar.gz',

		'md5patch1' => '7fa6ba0cd50e7f9ccaf4707c810b14f1',
		'urlpatch1' => 'http://downloads.sourceforge.net/cracklib/cracklib-words-20080507.gz',

		'depends_blfs' => 'lfs.06.glibc:lfs.06.zlib'
	),

'gnupg' => array (
		'status' => '1',
		'blfs' => '04',
		'version' => '1.4.13',
		'md5' => 'c74249db5803f76f17fee9a201c0189f',
		'url' => 'ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-_version.tar.bz2'
	),

'gnupg2' => array (
		'status' => '1',
		'blfs' => '04',
		'version' => '2.0.22',
		'md5' => 'ee22e7b4fdbfcb50229c2e6db6db291e',
		'url' => 'ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-_version.tar.bz2',

		'depends_blfs' => 'blfs.09.pth:blfs.09.libassuan:blfs.09.libgcrypt:blfs.09.libksba'
	),

'gnutls' => array (
		'status' => '1',
		'notlfs' => 'pm',
		'blfs' => '04',
		'version' => '3.2.6',
		'md5' => '1dfe5188df1641754056d853725ef785',
		'url' => 'ftp://ftp.gnutls.org/gcrypt/gnutls/v3.2/gnutls-_version.tar.xz',

		'depends_lfs' => 'blfs.04.nettle',
		'depends_blfs' => 'blfs.04.nettle'
	),

'gpgme' => array (
		'status' => '1',
		'notlfs' => 'pm',
		'blfs' => '04',
		'version' => '1.4.0',
		'md5' => 'a0f93aba6d8a831ba14905085027f2f9',
		'url' => 'ftp://ftp.gnupg.org/gcrypt/gpgme/gpgme-_version.tar.bz2',

		'depends_lfs' => 'blfs.09.libassuan:blfs.04.gnupg2',
		'depends_blfs' => 'blfs.09.libassuan:blfs.04.gnupg2'
	),

'Linux-PAM' => array (
		'status' => '1',
		'blfs' => '04',
		'version' => '1.1.8',
		'md5' => '35b6091af95981b1b2cd60d813b5e4ee',
		'url' => 'http://linux-pam.org/library/Linux-PAM-_version.tar.bz2',

		'depends_blfs' => 'blfs.04.cracklib:blfs.17.libtirpc'
	),

'nettle' => array (
		'status' => '1',
		'notlfs' => 'pm',
		'blfs' => '04',
		'version' => '2.7.1',
		'md5' => '003d5147911317931dd453520eb234a5',
		'url' => 'ftp://ftp.gnu.org/gnu/nettle/nettle-_version.tar.gz'
	),

'openssh' => array (
		'status' => '1',
		'blfs' => '04',
		'version' => '6.3p1',
		'md5' => '225e75c9856f76011966013163784038',
		'url' => 'ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-_version.tar.gz',

		'depends_blfs' => 'blfs.04.openssl',

		'makedepends_blfs' => 'lfs.06.linux-headers',

		'blfs_bootscripts' => '02'
	),

'openssl' => array (
		'status' => '1',
		'notlfs' => 'pm',
		'blfs' => '04',
		'version' => '1.0.1e',
		'md5' => '66bf6f10f060d561929de96f9dfe5b8c',
		'url' => 'ftp://ftp.openssl.org/source/openssl-_version.tar.gz',

		'md5patch1' => 'ffcc8ee49222d341cdab991aca3c5827',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/blfs/svn/openssl-_version-fix_parallel_build-1.patch',

		'md5patch2' => '88d3bef4bbdc640b0412315d8d347bdf',
		'urlpatch2' => 'http://www.linuxfromscratch.org/patches/blfs/svn/openssl-_version-fix_pod_syntax-1.patch'

		//'depends' => '09_perl'
	),

);
?>
