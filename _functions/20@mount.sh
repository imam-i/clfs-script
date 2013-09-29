#!/bin/bash
################################################################################
# Функция монтирования "mount_clfs"
# Version: 0.1

mount_clfs ()
{
if [ ! -f ./disk ]; then
	color-echo 'Отсутствует файл disk.' ${RED}
	return 1
else
	if [ -n "$( mount | grep ${CLFS} )" ]; then
		color-echo "Остались смонтированны:
`mount | grep ${CLFS}`" ${RED}
		return 1
	else
		rm -Rf ${CLFS} /tools
	fi
	local _disk
	for _disk in `cat ${CLFS_PWD}/disk`
	do
		local _section=$(echo ${_disk} | cut -d: -f1)
		local _mount_point=$(echo ${_disk} | cut -d: -f2)
		local _type=$(echo ${_disk} | cut -d: -f3)

		case ${_type} in
		    'swap' )
			;;
		    ext[2-4] | 'ext4dev' | 'vfat' )
			local _mke2fs="mkfs.${_type}"
			local _mount="mount -v -t ${_type}"
			;;
		    * )
			color-echo "Тип файловой системы не потдерживается \"${_type}\"" ${RED} & return 1
			;;
		esac

		case "${_mount_point}" in
		    'swap' )
			color-echo "Форматированние: ${_section} в ${_type}" ${CYAN}
			[ ${MOUNT_CLFS_FLAG} -ne 0 ] && mkswap ${_section}
			color-echo "Монтирование: ${_section} в ${_mount_point}" ${CYAN}
			[ ${MOUNT_CLFS_FLAG} -ne 0 ] && swapon -v ${_section}
			;;
		    * )
			install -dv "${CLFS}${_mount_point}"
			color-echo "Форматированние: ${_section} в ${_type}" ${CYAN}
			[ ${MOUNT_CLFS_FLAG} -ne 0 ] && ${_mke2fs} ${_section}
			color-echo "Монтирование: ${_section} в ${_mount_point}" ${CYAN}
			[ ${MOUNT_CLFS_FLAG} -ne 0 ] && ${_mount} ${_section} "${CLFS}${_mount_point}"
			;;
		esac
	done
fi

install -d ${CLFS_LOG} ${CLFS_SRC}
chmod -v a+wt ${CLFS_SRC}
}

#####################################Z###########################################
