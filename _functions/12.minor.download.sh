#!/bin/bash
################################################################################
# Функция "download"
# Version: 0.1

f_curlrc ()
{
	pushd ${CLFS_SRC} > /dev/null
		color-echo "curl -C - -L -O ${1}" ${WHITE}
		curl -C - -L -O ${1}
	popd > /dev/null
}

f_wgetrc ()
{
	color-echo "wget -P ${CLFS_SRC} -c ${1}" ${WHITE}
	wget -P ${CLFS_SRC} -c ${1}
}

f_gitrc ()
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

f_download ()
{
	local _pack_name=`basename ${1:-$url}`
	local _pack_url="${1:-$url}"

	[ "${_pack_url}" = 'NONE' ] && return 0

	echo ${_pack_name} >> ${log_file}
	if [ "${_pack_url:0:3}" = 'git' ]; then
		date >> ${log_file}
		if [ -n "$(which git)" ]; then
			f_gitrc ${_pack_url}
		else
			color-echo 'Отсутствует программа (git) для скачивания пакетов!' ${RED}
			return 1
		fi
		date >> ${log_file}
		return ${?}
	fi

	if [ -f ${CLFS_SRC}/${_pack_name} ]; then
		f_md5sum_clfs "${_pack_url}" "${2}"
	else
		date >> ${log_file}

		if [ -n "$(which curl)" ]; then
			f_curlrc ${_pack_url}
		elif [ -n "$(which wget)" ]; then
			f_wgetrc ${_pack_url}
		else
			color-echo 'Отсутствует программа (curl|wget) для скачивания пакетов!' ${RED}
			return 1
		fi

		f_md5sum_clfs "${_pack_url}" "${2}"
		date >> ${log_file}
	fi
}

################################################################################
