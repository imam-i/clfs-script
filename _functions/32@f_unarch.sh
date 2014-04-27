#!/bin/bash
################################################################################
# Функция "unarch"
# Version: 0.1

f_unarch ()
{
pushd ${BUILD_DIR}
if [ "${PWD}" = "${BUILD_DIR}" ]; then
	rm -Rf ./*
else
	ERR_FLAG=1
	return ${ERR_FLAG}
fi

echo "${name} ${version}"
date

url=`echo ${url} | sed -e "s@_version@${version}@g"`

local _archname=`basename ${url}`
#echo
#color-echo "EXTRACT ARCHIVE: ${_archname}" ${WHITE} >&6
#echo
f_log WHITE "EXTRACT ARCHIVE: ${_archname}"
tar -xpvf ${CLFS_SRC}/${_archname} | f_log NC
PACK=`echo ${_archname} | sed -e 's@.tar.bz2@@g' -e 's@.tar.xz@@g' -e 's@.tar.gz@@g'`

if [ "${#}" -ne 0 ]; then

	unset _pack_var_unarch

	for _NAME_UNARCH in ${*}
	do
		_pack_var_unarch=`pack_var "lfs.${_ID}.${_NAME_UNARCH}"`
		local ${_pack_var_unarch}

		local name=${_NAME_UNARCH}
		echo "${name} ${version}"
		date

		url=`echo ${url} | sed -e "s@_version@${version}@g"`
		local _archname=`basename ${url}`
#		echo
#		color-echo "EXTRACT ARCHIVE: ${_archname}" ${WHITE}
#		echo
		f_log WHITE "EXTRACT ARCHIVE: ${_archname}"
		tar -xpvf ${CLFS_SRC}/${_archname} | f_log NC

		# Очистка переменных
		f_clear_per "${_pack_var_unarch} _pack_var_unarch"
	done
fi

}

################################################################################
