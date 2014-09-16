#!/bin/bash
################################################################################
# Функция "unarch"
# Version: 0.1

f_unarch ()
{
#if [ "${PWD}" = "${BUILD_DIR}" ]; then
#	rm -Rf ./*
#else
#	ERR_FLAG=1
#	return ${ERR_FLAG}
#fi

local url=`echo ${url} | sed -e "s@_version@${version}@g"`

local _archname=`basename ${url}`
#local _log="${CLFS_MINOR_LOG_DIR}/extract"
f_log INFO "EXTRACT ARCHIVE: ${_archname}"
tar -xpvf ${CLFS_SRC}/${_archname} 2>&1 | f_log ALL
local PACK=`echo ${_archname} | sed -e 's@.tar.bz2@@g' -e 's@.tar.xz@@g' -e 's@.tar.gz@@g'`

if [ "${#}" -ne 0 ]; then

	unset _pack_var_unarch

	for _NAME_UNARCH in ${*}
	do
		_pack_var_unarch=`f_pack_var "${BOOK}.${ID}.${_NAME_UNARCH}"`
		local ${_pack_var_unarch}

		local name=${_NAME_UNARCH}

		local url=`echo ${url} | sed -e "s@_version@${version}@g"`
		f_unarch

		# Очистка переменных
		f_clear_per "${_pack_var_unarch} _pack_var_unarch"
	done
fi

}

################################################################################
