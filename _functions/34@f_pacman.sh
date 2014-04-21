#!/bin/bash
################################################################################
# Функция "pacman_clfs"
# Version: 0.1

f_pacman_clfs ()
{
[ "${ERR_FLAG}" -gt 0 ] && return ${ERR_FLAG}

local _LOG_DIR="${LOG_DIR}/${_ID}/${1}"
local PACKAGE_FORCE=( ${PACKAGE_FORCE[*]} )

for (( y=0; ${y} < ${#PACKAGE_FORCE[@]}; y++ ))
do
	if [ "${PACKAGE_FORCE[${y}]}" = "${_NAME}" ]; then
		local _pacman_flags="${2} --force"
		break
	else
		local _pacman_flags="${2}"
	fi
done

if [ -f ${CLFS_PKG}/${_NAME}-${version}*.pkg.tar.xz ]; then
	install -d ${_LOG_DIR}
	yes | /opt/bin/pacman -U ${_pacman_flags} --needed --config ${CLFS_CONF}/pacman.conf \
				 ${CLFS_PKG}/${_NAME}-${version}*.pkg.tar.xz || ERR_FLAG=${?}
	if [ ${ERR_FLAG} -gt 0 ]; then
		color-echo "error pacman: ${1}" ${RED}
		return ${ERR_FLAG}
	fi
else
	color-echo "Отсутствует пакет pacman: ${1}" ${RED}
	ERR_FLAG=1
	return ${ERR_FLAG}
fi
}

################################################################################
