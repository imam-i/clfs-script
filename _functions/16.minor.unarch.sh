#!/bin/bash
################################################################################
# Функция "unarch"
# Version: 0.1

minor_unarch ()
{
local CLFS_FLAG="${FUNCNAME}"

local url=`echo ${url} | sed -e "s@_version@${version}@g"`

local _archname=`basename ${url}`
minor_log INFO "EXTRACT ARCHIVE: ${_archname}"
tar -xpvf ${CLFS_SRC}/${_archname} 2>&1 | minor_log ALL
local PACK=`echo ${_archname} | sed -e 's@.tar.bz2@@g' -e 's@.tar.xz@@g' -e 's@.tar.gz@@g'`

if [ "${#}" -ne 0 ] && [ "${ERR_FLAG}" -eq 0 ]; then

	minor_clear_per "${pkg_var} pkg_var_unarch"

	for NAME_UNARCH in ${*}
	do
		local pkg_var_unarch=`minor_pack_var "${BOOK}.${ID}.${NAME_UNARCH}"`
		eval "local ${pkg_var_unarch}"

		minor_unarch
		[ "${ERR_FLAG}" -ne 0 ] && return 0

		# Очистка переменных
		minor_clear_per "${pkg_var_unarch} pkg_var_unarch"
	done
fi

}

################################################################################
