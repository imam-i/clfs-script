#!/bin/bash
################################################################################
# Функция "download"
# Version: 0.1

minor_download_curlrc ()
{
	pushd ${CLFS_SRC} > /dev/null
		echo "curl -C - -L -O ${1}"
			curl -C - -L -O ${1} 2>&1 | minor_log ALL
	popd > /dev/null
}

minor_download_wgetrc ()
{
	echo "wget -P ${CLFS_SRC} -c ${1}"
	wget -P ${CLFS_SRC} -c ${1} 2>&1 | minor_log ALL
}

minor_download_gitrc ()
{
	pushd ${CLFS_SRC} > /dev/null
		if [ -d ${pkg_name/.git} ]; then
			pushd ${pkg_name/.git} > /dev/null
				echo "git pull ${1}"
				git pull 2>&1 | minor_log ALL
			popd > /dev/null
		else
			echo "git clone ${1}"
			git clone ${1} 2>&1 | minor_log ALL
		fi
	popd > /dev/null
}

minor_download ()
{
	local CLFS_FLAG="${FUNCNAME}"

	[ "${ERR_FLAG}" -ne 0 ] && return 0

	local pkg_url=`echo ${url} | sed -e "s@_version@${version}@g"`
#	local pkg_url=${url}
	local pkg_name=`basename ${pkg_url}`

	[ "${pkg_url}" = 'NONE' ] && return 0

	if [ "${pkg_url:0:3}" = 'git' ]; then
		date

		if [ -n "$(which git)" ]; then
			minor_log INFO "DOWNLOAD GIT: ${pkg_name}"
			minor_download_gitrc ${pkg_url}
		else
			minor_log ERROR 'Отсутствует программа (git) для скачивания пакетов!'
			ERR_FLAG=1; return 0
		fi

		date
	elif [ -f ${CLFS_SRC}/${pkg_name} ]; then
		minor_md5sum "${pkg_url}" "${md5}"
	else
		date

		if [ -n "$(which curl)" ]; then
			minor_log INFO "DOWNLOAD CURL: ${pkg_name}"
			minor_download_curlrc ${pkg_url}
		elif [ -n "$(which wget)" ]; then
			minor_log INFO "DOWNLOAD WGET: ${pkg_name}"
			minor_download_wgetrc ${pkg_url}
		else
			minor_log ERROR 'Отсутствует программа (curl|wget) для скачивания пакетов!'
			ERR_FLAG=1; return 0
		fi

		minor_md5sum "${pkg_url}" "${md5}"
		date
	fi

	[ "${DOWNLOAD_FLAG}" -ne 0 ] || \
	[ "${ERR_FLAG}" -ne 0 ] \
		&& return 0

	for (( n=0; n < ${#urlpatch[@]}; n++ ))
	do
#		local urlpatch="urlpatch${n}"
#		if [ -n "${!urlpatch}" ]; then
		local url=${urlpatch[$n]}
		local md5=${md5patch[$n]}
		local DOWNLOAD_FLAG=1
		minor_download
		[ "${ERR_FLAG}" -ne 0 ] && return 0
#		fi
#		unset urlpatch md5patch url md5
	done

	if [ "${#}" -ne 0 ] && [ "${ERR_FLAG}" -eq 0 ]; then

		minor_clear_per "${pkg_var} pkg_var_down"

		for NAME_DOWN in ${*}
		do
			local DOWNLOAD_FLAG=0

			local pkg_var_down=`minor_pack_var "${BOOK}.${ID}.${NAME_DOWN}"`
			eval "local ${pkg_var_down}"

#			local url=`echo ${url} | sed -e "s@_version@${version}@g"`
			minor_download
			[ "${ERR_FLAG}" -ne 0 ] && return 0

			# Очистка переменных
			minor_clear_per "${pkg_var_down} pkg_var_down"
		done
	fi
}

################################################################################
