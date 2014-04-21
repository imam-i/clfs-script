<?php
$arr = array (

# blfs 09
'glib2' => array (
		'status' => '1',
		'blfs' => '09',
		'version' => '2.35.9',
		'md5' => '0afa8ddc839a86474c04fd0870182ba3',
		'url' => 'ftp://ftp.gnome.org/pub/gnome/sources/glib/2.35/glib-_version.tar.xz',

		'depends_blfs' => 'blfs.09.libffi:blfs.09.pcre',

		'makedepends_blfs' => 'blfs.13.pkg-config:blfs.13.python2'
	),

'libassuan' => array (
		'status' => '1',
		'notlfs' => 'pm',
		'blfs' => '09',
		'version' => '2.1.0',
		'md5' => 'b3231eec8e567f4f9294474a387378f5',
		'url' => 'ftp://ftp.gnupg.org/gcrypt/libassuan/libassuan-_version.tar.bz2',

		'depends_notlfs' => 'blfs.09.libgpg-error',
		'depends_blfs' => 'blfs.09.libgpg-error'
	),

'libffi' => array (
		'status' => '1',
		'blfs' => '09',
		'version' => '3.0.13',
		'md5' => '45f3b6dbc9ee7c7dfbbbc5feba571529',
		'url' => 'ftp://sourceware.org/pub/libffi/libffi-_version.tar.gz',

		'md5patch1' => 'f8a991217706875e803b5ccb888e7797',
		'urlpatch1' => 'http://www.linuxfromscratch.org/patches/blfs/svn/libffi-_version-includedir-1.patch',

		'depends_blfs' => 'lfs.06.glibc'
	),

'libgcrypt' => array (
		'status' => '1',
		'blfs' => '09',
		'version' => '1.5.2',
		'md5' => '668aa1a1aae93f5fccb7eda4be403026',
		'url' => 'ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-_version.tar.bz2',

		'depends_blfs' => 'blfs.09.libgpg-error'
	),

'libgpg-error' => array (
		'status' => '1',
		'notlfs' => 'pm',
		'blfs' => '09',
		'version' => '1.11',
		'md5' => 'b9fa55b71cae73cb2e44254c2acc4e2c',
		'url' => 'ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-_version.tar.bz2'
	),

'libksba' => array (
		'status' => '1',
		'blfs' => '09',
		'version' => '1.3.0',
		'md5' => 'cd86fad9c9d360b2cf80449f8a4a4075',
		'url' => 'ftp://ftp.gnupg.org/gcrypt/libksba/libksba-_version.tar.bz2',

		'depends_blfs' => 'blfs.09.libgpg-error'
	),

'pcre' => array (
		'status' => '1',
		'blfs' => '09',
		'version' => '8.32',
		'md5' => '62f02a76bb57a40bc66681760ed511d5',
		'url' => 'http://downloads.sourceforge.net/pcre/pcre-_version.tar.bz2'
	),

'pth' => array (
		'status' => '1',
		'blfs' => '09',
		'version' => '2.0.7',
		'md5' => '9cb4a25331a4c4db866a31cbe507c793',
		'url' => 'ftp://ftp.gnu.org/gnu/pth/pth-_version.tar.gz'
	),

);
?>
