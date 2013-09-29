#!/bin/bash
################################################################################
# Функция "untar_clfs"
# Version: 0.1

untar_clfs ()
{
	local _ID=${1:0:2}
	local _archive="${_ID}_$(uname -m)_clfs.tar.bz2"
	local _log="${_LOG}/${_ID}/${_ID}_clfs.log"

	color-echo 'untar_clfs.sh' ${MAGENTA}
	color-echo "1 : ${1}" ${MAGENTA}
	color-echo "2 : ${2}" ${MAGENTA}
	color-echo "3 : ${3}" ${MAGENTA}

	if [ -n "${2}" ]; then
		if [ -f ${CLFS_OUT}/${2:0:2}_$(uname -m)_clfs.tar.bz2 ] && [ $(cat ${_LOG}/${2:0:2}/${2:0:2}_flag) -eq 0 ]; then
			untar_clfs "${2}"
			untar_clfs "${1}"
		else
			scripts_ctools "${2}"
			scripts_ctools "${1}"
		fi
	else
		if [ -f ${CLFS_OUT}/${_archive} ] && [ $(cat ${_LOG}/${_ID}/${_ID}_flag) -eq 0 ]; then
			color-echo "Распаковка: \"${_archive}\"" ${CYAN}
			echo "untar: ${1}" > "${_log}"
			date >> "${_log}"
			echo '+++++++++++++++++env+++++++++++++++++++' >> "${_log}"
			env >> "${_log}"
			echo '+++++++++++++++++++++++++++++++++++++++' >> "${_log}"
			echo '++++++++++++++++local++++++++++++++++++' >> "${_log}"
			local >> "${_log}"
			echo '+++++++++++++++++++++++++++++++++++++++' >> "${_log}"

			pushd ${CLFS} > /dev/null
				tar -xf "${CLFS_OUT}/${_archive}"
			popd > /dev/null

#			color-echo "Создание файла: \"${_ID}-files\"" ${GREEN}
#			find /tools/ | sed -e '1d' > ${_LOG}/${_ID}/${_ID}-files
			#find /tools/ -type f > ${_LOG}/${_ID}/${_ID}-files
			#find /tools/ -type d > ${_LOG}/${_ID}/${_ID}-directory

#			echo ${ERR_FLAG} > ${_LOG}/${_ID}/${_ID}_flag
			date >> "${_log}"
		else
			scripts_ctools "${1}"
		fi
	fi
}

################################################################################
