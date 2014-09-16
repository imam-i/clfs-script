#!/bin/bash
################################################################################
# Функция "download"
# Version: 0.1

f_curlrc ()
{
	pushd ${CLFS_SRC} > /dev/null
		color-echo "curl -C - -L -O ${1}" ${WHITE}
		eval "$(curl -C - -L -O ${1})" 2>&1 | f_log ALL
	popd > /dev/null
}

f_wgetrc ()
{
	color-echo "wget -P ${CLFS_SRC} -c ${1}" ${WHITE}
	eval "$(wget -P ${CLFS_SRC} -c ${1})" 2>&1 | f_log ALL
}

f_gitrc ()
{
	pushd ${CLFS_SRC} > /dev/null
		if [ -d ${_pack_name/.git} ]; then
			pushd ${_pack_name/.git} > /dev/null
				color-echo "git pull ${1}" ${WHITE}
				eval "$(git pull)" 2>&1 | f_log ALL
			popd > /dev/null
		else
			color-echo "git clone ${1}" ${WHITE}
			eval "$(git clone ${1})" 2>&1 | f_log ALL
		fi
	popd > /dev/null
}

f_download ()
{
	local _pack_url=`echo ${url} | sed -e "s@_version@${version}@g"`
	local _pack_name=`basename ${_pack_url}`

	[ "${_pack_url}" = 'NONE' ] && return 0

	echo ${_pack_name}
	if [ "${_pack_url:0:3}" = 'git' ]; then
		date
		if [ -n "$(which git)" ]; then
			f_log INFO "DOWNLOAD GIT: ${name}-${version}"
			f_gitrc ${_pack_url}
		else
			color-echo 'Отсутствует программа (git) для скачивания пакетов!' ${RED}
			return 1
		fi
		date
		return ${?}
	elif [ -f ${CLFS_SRC}/${_pack_name} ]; then
		f_md5sum "${_pack_url}" "${md5}"
	else
		date

		if [ -n "$(which curl)" ]; then
			f_log INFO "DOWNLOAD CURL: ${name}-${version}"
			f_curlrc ${_pack_url}
		elif [ -n "$(which wget)" ]; then
			f_log INFO "DOWNLOAD WGET: ${name}-${version}"
			f_wgetrc ${_pack_url}
		else
			color-echo 'Отсутствует программа (curl|wget) для скачивания пакетов!' ${RED}
			return 1
		fi

		f_md5sum "${_pack_url}" "${md5}"
		date
	fi

	for (( n=1; n <= 9; n++ ))
	do
		local urlpatch="urlpatch${n}"
		if [ -n "${!urlpatch}" ]; then
			local url=`echo ${!urlpatch} | sed -e "s@_version@${version}@g"`
			local md5patch="md5patch${n}"
			local md5=${md5patch}
			f_download
		fi
		unset urlpatch md5patch url md5
	done

	echo ${*}

	if [ "${#}" -ne 0 ]; then

		for NAME_DOWN in ${*}
		do
			local pack_var_down=`f_pack_var "${BOOK}.${ID}.${NAME_DOWN}"`
			local ${pack_var_down}

			local name=${NAME_DOWN}

			local url=`echo ${url} | sed -e "s@_version@${version}@g"`
			f_download

			# Очистка переменных
			f_clear_per "${pack_var_unarch} pack_var_unarch"
		done
	fi
}

################################################################################
