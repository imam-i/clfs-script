#!/bin/bash
################################################################################
# Функция "scripts_clfs"
# Version: 0.1

f_scripts_clfs ()
{
local ID=${1:0:2}
local _archive="${ID}_${CLFS_ARCH}_clfs.tar.bz2"
local LOG_FILE="${LOG_DIR}/${ID}/${ID}_clfs.log"

color-echo 'scripts-clfs.sh' ${MAGENTA}
color-echo "1 : ${1}" ${MAGENTA}
color-echo "2 : ${2}" ${MAGENTA}
color-echo "3 : ${3}" ${MAGENTA}

# Проверка зависимостей
if [ -n "${2}" ]; then
	f_scripts_clfs "${2}" "${3}"
fi

if [ -f ${CLFS_OUT}/${_archive} ] && [ $(cat ${LOG_DIR}/${ID}/${ID}_flag) -eq 0 ]; then

	f_untar

	if [ ${ERR_FLAG} -eq 0 ]; then
		color-echo "OK: ${1}" ${GREEN}
		return ${ERR_FLAG}
	else
		color-echo "ERROR: ${1}" ${RED} & return ${?}
	fi
fi

# clear
rm -Rf ${LOG_DIR}/${ID} ${CLFS_SRC}/${_archive}
install -dv ${LOG_DIR}/${ID}

echo "f_scripts_build: ${1}" >> "${LOG_FILE}"
date >> "${LOG_FILE}"
echo '+++++++++++++++++env+++++++++++++++++++' >> "${LOG_FILE}"
env >> "${LOG_FILE}"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${LOG_FILE}"
echo '++++++++++++++++local++++++++++++++++++' >> "${LOG_FILE}"
local >> "${LOG_FILE}"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${LOG_FILE}"

unset _pack_var

local _script
for _script in ${CLFS_PWD}/${PREFIX}/`basename ${LOG_DIR}`/${ID}_*/${ID}.[0-9][0-9]_*
do
	local _file=`basename "${_script}"`
	local _NAME=`echo ${_file} | cut -d_ -f2 | cut -d. -f1`

	if [ -f ${_script} ]; then
		local _log="${LOG_DIR}/${ID}/${_file}.log"
	else
		local _log="${LOG_DIR}/${ID}/${_file}_dir.log"
		# Отключена ссборка пакетов pacman.
		continue
	fi
	[ -f "${_log}" ] && rm -vf ${_log}
	local logpipe=`mktemp -u "${LOG_DIR}/${ID}/logpipe.XXXXXXXX"`
	mkfifo "${logpipe}"
	tee "${_log}" < "${logpipe}" &
	local teepid=${!}

	# Назначаем переменные пакета
	local _pack_var=`f_pack_var "lfs.${ID}.${_NAME}"`

	f_build_clfs

	[ ${ERR_FLAG} -ne 0 ] && break
	[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*

	wait ${teepid}
	rm "${logpipe}"
done

if [ ${ERR_FLAG} -eq 0 ]; then
	color-echo "OK: ${1}" ${GREEN}
else
	color-echo "ERROR: ${1}" ${RED}
	return ${ERR_FLAG}
fi

color-echo "Создание файла: \"${ID}-files\"" ${GREEN}
find /{tools,cross-tools} | sed -e '1d' > ${LOG_DIR}/${ID}/${ID}-files

color-echo "Создание переменной: \"${ID}-c-tools\"" ${GREEN}
if [ -n "${2}" ]; then
	local _files=`diff -n "${LOG_DIR}/${2:0:2}/${2:0:2}-files" \
			      "${LOG_DIR}/${ID}/${ID}-files"`
else
	local _files=`find /{tools,cross-tools} | sed -e '1d'`
fi
color-echo "Создание архива: \"${_archive}\"" ${GREEN}
[ -f ${CLFS_OUT}/${_archive} ] && rm -f ${CLFS_OUT}/${_archive}
tar -cjf ${CLFS_OUT}/${_archive} ${_files}

color-echo "Проверка архива: \"${_archive}\"" ${GREEN}
bzip2 -t ${CLFS_OUT}/${_archive}

date >> "${LOG_FILE}"
}

################################################################################
