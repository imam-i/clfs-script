#!/bin/bash
################################################################################
# Функция "makepkg_clfs"
# Version: 0.1

f_makepkg_clfs ()
{
[ "${ERR_FLAG}" -gt 0 ] && return ${ERR_FLAG}

local _LOG_DIR="${LOG_DIR}/${_ID}/${1}"

echo ++++++++++makepkg+++++++++++
echo name=\'${name}\'
echo version=\'${version}\'
echo _url=\'${_url}\'
echo md5=\'${md5}\'
echo _depends=\'${_depends}\'
echo _makedepends=\'${_makedepends}\'
echo ++++++++++++++++++++++++++++

if [ ! -f ${CLFS_PKG}/${_NAME}-${version}*.pkg.tar.xz ]; then
	rm -Rf ${_LOG_DIR}
	rm -Rf ./{pkg,src} *.log
	/opt/bin/makepkg --clean --log ${2} --config ${CLFS_CONF}/makepkg.conf -f || ERR_FLAG=${?}
	if [ ${ERR_FLAG} -gt 0 ]; then
		color-echo "error makepkg: ${1}" ${RED}
		return ${ERR_FLAG}
	fi
	install -d ${_LOG_DIR}
	mv -f *.log ${_LOG_DIR}/
	rm -f *.pkg.tar.xz
else
	color-echo "Не требуется makepkg: ${1}" ${WHITE}
fi
}

################################################################################
