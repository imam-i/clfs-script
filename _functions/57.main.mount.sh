#!/bin/bash
################################################################################
# Функция монтирования "mount"
# Version: 0.1

f_mount ()
{
	if [ -n "$( mount | grep ${CLFS} )" ]; then
		color-echo "Остались смонтированны:
`mount | grep ${CLFS}`" ${RED}
		return 1
	else
		rm -Rf ${CLFS} /tools /cross-tools
	fi
	local _disk
	for _disk in `cat ${CLFS_DISK}`
	do
		local _section=$(echo ${_disk} | cut -d: -f1)
		local _mount_point=$(echo ${_disk} | cut -d: -f2)
		local _type=$(echo ${_disk} | cut -d: -f3)

		case "${_type}" in
		    'swap' ) ;;
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
			if [ "${MOUNT_FLAG}" -ne 0 ]; then
				color-echo "Форматированние: ${_section} в ${_type}" ${CYAN}
				mkswap ${_section}
				color-echo "Монтирование: ${_section} в ${_mount_point}" ${CYAN}
				swapon -v ${_section}
			fi
			;;
		    * )
			install -dv "${CLFS}${_mount_point}"
			if [ "${MOUNT_FLAG}" -ne 0 ]; then
				color-echo "Форматированние: ${_section} в ${_type}" ${CYAN}
				${_mke2fs} ${_section}
				color-echo "Монтирование: ${_section} в ${_mount_point}" ${CYAN}
				${_mount} ${_section} "${CLFS}${_mount_point}"
			fi
			;;
		esac
	done

install -d ${CLFS_LOG} ${CLFS_SRC} ${CLFS_PKG}
#install -d ${CLFS}/var/{lib/pacman,/cache/pacman/pkg,log}
chmod -v a+wt ${CLFS_SRC}
}

#####################################Z###########################################
