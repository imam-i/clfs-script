#!/bin/bash
################################################################################
# Функция "scripts_ctools"
# Version: 0.1

scripts_ctools ()
{
local _ID=${1:0:2}
local _archive="${_ID}_${CLFS_ARCH}_clfs.tar.bz2"

# clear
rm -Rf ${_LOG}/${_ID} ${CLFS_SRC}/${_archive}
install -dv ${_LOG}/${_ID}

color-echo 'scripts-ctools.sh' ${MAGENTA}
color-echo "1 : ${1}" ${MAGENTA}
color-echo "2 : ${2}" ${MAGENTA}
color-echo "3 : ${3}" ${MAGENTA}

# Проверка зависимостей
if [ -n "${2}" ]; then
	untar_clfs "${2}"
#	[ ${ERR_FLAG} -gt 0 ] && return ${ERR_FLAG}
fi

echo "scripts_build: ${1}" >> "${_LOG}/${_ID}/${_ID}_clfs.log"
date >> "${_LOG}/${_ID}/${_ID}_clfs.log"
echo '+++++++++++++++++env+++++++++++++++++++' >> "${_LOG}/${_ID}/${_ID}_clfs.log"
env >> "${_LOG}/${_ID}/${_ID}_clfs.log"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${_LOG}/${_ID}/${_ID}_clfs.log"
echo '++++++++++++++++local++++++++++++++++++' >> "${_LOG}/${_ID}/${_ID}_clfs.log"
local >> "${_LOG}/${_ID}/${_ID}_clfs.log"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${_LOG}/${_ID}/${_ID}_clfs.log"

unset _pack_var

local _script
for _script in ${CLFS_PWD}/${PREFIX}/ctools/${_ID}_*/${_ID}.[0-9][0-9]*.sh
do
	local _file=`basename "${_script}"`
	local _NAME=`echo ${_file} | cut -d_ -f2 | cut -d. -f1`

	local _log="${_LOG}/${_ID}/${_file}.log"
	if [[ -f ${_log} ]]; then
		rm -vf ${_log}
	fi
	local logpipe=$(mktemp -u "${_LOG}/${_ID}/logpipe.XXXXXXXX")
	mkfifo "${logpipe}"
	tee "${_log}" < "${logpipe}" &
	local teepid=${!}

	# Назначаем переменные пакета
	_pack_var=`pack_var "clfs.${_ID}.${_NAME}"`
	local ${_pack_var}
	local name="${_NAME}"

	while [ true ]
	do
		echo "${_ID}    ${name}    ${_file}"
		. ${_script} || ERR_FLAG=${?}
		if [ ${ERR_FLAG} -ne 0 ]; then
			color-echo "ERROR: ${_file}" ${RED}
			color-echo "Повторить - r" ${YELLOW}
			color-echo "Пропустить - c" ${YELLOW}
			color-echo "Остановить - x" ${YELLOW}
			local _flag=''
			read _flag
			case ${_flag} in
				'r')
					ERR_FLAG=0
					popd
					[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*
					local _flag=''
					continue
				;;
				'c')
					popd
					ERR_FLAG=0
					local _flag=''
				;;
				*)	return ${ERR_FLAG} ;;
			esac
		fi
		break
	done &>"${logpipe}"

	[ ${ERR_FLAG} -ne 0 ] && break
	[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*

	wait ${teepid}
	rm "${logpipe}"

	clear_per "${_pack_var}"

	date >> ${_log}
done

if [ ${ERR_FLAG} -eq 0 ]; then
	color-echo "OK: ${1}" ${GREEN}
else
	color-echo "ERROR: ${1}" ${RED}
	return ${ERR_FLAG}
fi

if [ "${_ID}" = '05' ]; then
	color-echo "Создание переменной: \"${_ID}-cross-tools\"" ${GREEN}
	local _files=`find ${CLFS}/cross-tools | sed -e '1d'`
	pushd ${CLFS_OUT}
		color-echo "Создание архива: \"${_archive}\"" ${GREEN}
		tar -cjf ${_archive} ${_files}

		color-echo "Проверка архива: \"${_archive}\"" ${GREEN}
		bzip2 -t ${_archive}
	popd
fi

date >> "${_LOG}/${_ID}/${_ID}_clfs.log"
}

################################################################################
