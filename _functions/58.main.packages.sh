#!/bin/bash
################################################################################
# Функция "packages_clfs"
# Version: 0.1

_f_package_clfs ()
{
local ${pak}

# Проверка пакета на включение
if [ "${status}" -eq 0 ]; then
	# Продолжаем
	return 0
fi

if [ -n "${url}" ]; then
	local url=`echo ${url} | sed -e "s@_version@${version}@g"`
	f_download
fi
unset url md5

if [ -n "${urlconf}" ]; then
	local urlconf=`echo ${urlconf} | sed -e "s@_version@${verconf}@g"`
	f_download "${urlconf}" "${md5conf}"
fi

for (( n=1; n <= 9; n++ ))
do
	local urlpatch="urlpatch${n}"
	if [ -n "${!urlpatch}" ]; then

		local _urlpatch=`echo ${!urlpatch} | \
					sed -e "s@_version@${version}@g"`
		local md5patch="md5patch${n}"

		f_download "${_urlpatch}" "${!md5patch}"
	fi
done
}

f_packages_clfs ()
{
# Назначаем переменные
local CLFS_FLAG='packages-lfs'
local BOOK=`echo ${1} | cut -d. -f1`
local CHAPTER=`echo ${1} | cut -d. -f2`
local GROUP_PACKAGE_ALL=`echo ${1} | cut -d. -f3`

#[ "${ERR_FLAG}" -gt 0 ] && return 1

color-echo "f_packages_clfs" ${YELLOW}

if [ "${PACKAGES_CLFS_FLAG}" -eq 0 ]; then
        return 0
fi

local _log="${CLFS_LOG}/packages.log"
:> ${_log}

for package_name in `f_pack_var ${BOOK}.${CHAPTER}.${GROUP_PACKAGE_ALL}`
do
	local pak=`f_pack_var ${BOOK}.${CHAPTER}.${package_name}`

	_f_package_clfs

	# Очистка переменных
	unset pak
done
}

################################################################################
