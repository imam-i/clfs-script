#!/bin/bash
################################################################################
# Функция "download"
# Version: 0.1

curlrc ()
{
	pushd ${CLFS_SRC} > /dev/null
		color-echo "curl -C - -L -O ${1}" ${WHITE}
		curl -C - -L -O ${1}
	popd > /dev/null
}

wgetrc ()
{
	color-echo "wget -P ${CLFS_SRC} -c ${1}" ${WHITE}
	wget -P ${CLFS_SRC} -c ${1}
}

gitrc ()
{
	pushd ${CLFS_SRC} > /dev/null
		if [ -d ${_pack_name/.git} ]; then
			pushd ${_pack_name/.git} > /dev/null
				color-echo "git pull ${1}" ${WHITE}
				git pull
			popd > /dev/null
		else
			color-echo "git clone ${1}" ${WHITE}
			git clone ${1}
		fi
	popd > /dev/null
}

download ()
{
	local _pack_name=`basename ${1:-$url}`
	local _pack_url="${1:-$url}"

	echo ${_pack_name} >> ${_log}
	if [ "${_pack_url:0:3}" = 'git' ]; then
		date >> ${_log}
		if [ -n "$(which git)" ]; then
			gitrc ${_pack_url}
		else
			color-echo 'Отсутствует программа (git) для скачивания пакетов!' ${RED}
			return 1
		fi
		date >> ${_log}
		return ${?}
	fi

	if [ -f ${CLFS_SRC}/${_pack_name} ]; then
		md5sum_clfs "${_pack_url}" "${2}"
	else
		date >> ${_log}

		if [ -n "$(which wget)" ]; then
			wgetrc ${_pack_url}
		elif [ -n "$(which curl)" ]; then
			curlrc ${_pack_url}
		else
			color-echo 'Отсутствует программа (curl|wget) для скачивания пакетов!' ${RED}
			return 1
		fi

		md5sum_clfs "${_pack_url}" "${2}"
		date >> ${_log}
	fi
}

################################################################################
