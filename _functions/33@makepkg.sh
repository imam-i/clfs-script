#!/bin/bash
################################################################################
# Функция "makepkg_clfs"
# Version: 0.1

makepkg_clfs ()
{
[ "${ERR_FLAG}" -gt 0 ] && return ${ERR_FLAG}

echo ++++++++++makepkg+++++++++++
echo name=\'${name}\'
echo version=\'${version}\'
echo _url=\'${_url}\'
echo md5=\'${md5}\'
echo _depends=\'${_depends}\'
echo _makedepends=\'${_makedepends}\'
echo ++++++++++++++++++++++++++++

if [ ! -f ${CLFS_PKG}/${_NAME}-${version}*.pkg.tar.xz ]; then
	rm -Rf ${_LOG}/${_ID}/${1}
	rm -Rf ./{pkg,src} *.log
	/opt/bin/makepkg --clean --log ${2} --config ${CLFS_CONF}/makepkg.conf -f || ERR_FLAG=${?}
	if [ ${ERR_FLAG} -gt 0 ]; then
		color-echo "error makepkg: ${1}" ${RED}
		return ${ERR_FLAG}
	fi
	install -d ${_LOG}/${_ID}/${1}
	mv -f *.log ${_LOG}/${_ID}/${1}/
	rm -f *.pkg.tar.xz
else
	color-echo "Не требуется makepkg: ${1}" ${WHITE}
fi
}

################################################################################
