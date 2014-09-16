#!/bin/bash
################################################################################
# Функция размонтирования "umount"
# Version: 0.1

f_umount ()
{

local _log=${CLFS_LOG}/umount.log

install -d ${CLFS_LOG}

[ -n "$( pwd | grep ${BUILD_DIR} )" ] && popd

if [ -n "$( mount | grep ${BUILD_DIR} )" ]; then
	color-echo "Размонтирование: ${BUILD_DIR}" ${CYAN}
	umount -v ${BUILD_DIR} >> ${_log}
fi

local _disk
for _disk in `tac ${CLFS_DISK}`
do
	local _section=$(echo ${_disk} | cut -d: -f1)
	local _mount_point=$(echo ${_disk} | cut -d: -f2)
	local _type=$(echo ${_disk} | cut -d: -f3)

	case ${_mount_point} in
	    'swap' )
		[ "${MOUNT_FLAG}" -ne 0 ] \
			&& ( swapoff -v ${_section} >> ${_log} )
	    ;;
	    * )
		if [ -n "$( mount | grep ${_section} )" ]; then
			color-echo "Размонтирование: ${_mount_point}" ${CYAN}
			if [ "${MOUNT_FLAG}" -ne 0 ]; then
				umount -v ${_section} >> ${_log}
				if [ "${?}" -ne 0 ]; then
					fuser -m -k ${_section} >> ${_log}
					umount -v ${_section} >> ${_log}
				fi
			fi
		fi
	    ;;
	esac
done
if [ -n "$( mount | grep ${CLFS} )" ]; then
	color-echo "Остались смонтированны:
`mount | grep ${CLFS}`" ${RED}
	return 1
fi
}

################################################################################
