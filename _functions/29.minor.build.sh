#!/bin/bash
################################################################################
# Функция "build"
# Version: 0.1

minor_build ()
{
local CLFS_FLAG="${FUNCNAME}"

# Назначаем переменные пакета
local pkg_var=`minor_pack_var ${BOOK}.${ID}.${NAME}`
eval "local ${pkg_var}"
#local name="${pkg}"
#local extract="extract_${BOOK}_${ID}"
local DOWNLOAD_FLAG=0

if [ -f ${pkg_dir}/${NAME}.${BOOK} ]; then
	local CLFS_PKG_LOG="${CLFS_MINOR_LOG_DIR}/${NAME}.log"

	exec >> ${CLFS_PKG_LOG} 2>> ${CLFS_PKG_LOG}

	minor_log INFO '======================================================'

	minor_download ${extract[@]}
	minor_clear_per "${pkg_var_down}"
	eval "local ${pkg_var}"

	pushd ${BUILD_DIR} > /dev/null
	if [ ${ERR_FLAG} -eq 0 ]; then
		if [ "${PWD}" = "${BUILD_DIR}" ]; then
			rm -Rf ./*
		fi
		minor_unarch ${extract[@]}
		minor_clear_per "${pkg_var_unarch}"
		eval "local ${pkg_var}"
	fi

	install -d ./${NAME}-build; cd ./${NAME}-build

	minor_build_run 'CONFIG'
	minor_build_run 'BUILD'
	minor_build_run 'CHECK'
	minor_build_run 'INSTALL'

	popd > /dev/null
elif [ -d ${pkg_dir}/${NAME} ]; then
	minor_exec_io OFF

	local _url=`echo ${url} | sed -e "s/_version/${version}/g"`

	# Проверка на наличие патчей
	for (( n=1; n <= 9; n++ ))
	do
		local urlpatch="urlpatch${n}"
		if [ "${!urlpatch}" ]; then
			_url="${_url}"$'\n'`echo ${!urlpatch} | sed -e "s/_version/${version}/g"`
			local md5patch="md5patch${n}"
			md5="${md5}"$'\n'${!md5patch}
		fi
	done

	export name version _url md5
	pushd ${_script}
		f_makepkg ${_file}
		f_pacman ${_file}
	popd
	unset name version _url md5

	minor_exec_io OK
else
	minor_log ERROR "${NAME} ни скрипт ни каталог!!!"
	ERR_FLAG=1
fi
}

################################################################################
