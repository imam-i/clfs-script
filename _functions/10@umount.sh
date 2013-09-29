#!/bin/bash
################################################################################
# Функция размонтирования "umount_clfs"
# Version: 0.1

umount_clfs ()
{

local _log=${CLFS_LOG}/umount.log

install -d ${CLFS_LOG}

[ -n "$( pwd | grep ${BUILD_DIR} )" ] && popd

if [ -n "$( mount | grep ${BUILD_DIR} )" ]; then
	color-echo "Размонтирование: ${BUILD_DIR}" ${CYAN}
	umount -v ${BUILD_DIR} >> ${_log}
fi

#if [ -n "$( mount | grep ${LFS}/dev )" ]; then
#	color-echo "Размонтирование: ${LFS}/dev/pts" ${CYAN}
#	umount -v "${LFS}/dev/pts" > ${_log}
#	if [ -h $LFS/dev/shm ]; then
#		link=$(readlink $LFS/dev/shm)
#		color-echo "		 ${LFS}/$link" ${CYAN}
#		umount -v $LFS/$link >> ${_log}
#		unset link
#	else
#		color-echo "		 ${LFS}/dev/shm" ${CYAN}
#		umount -v $LFS/dev/shm >> ${_log}
#	fi
#	color-echo "		 ${LFS}/dev/shm" ${CYAN}
#	umount -v "${LFS}/dev/shm" >> ${_log} || return ${?}
#	color-echo "		 ${LFS}/dev" ${CYAN}
#	umount -v "${LFS}/dev" >> ${_log}
#	color-echo "		 ${LFS}/sys" ${CYAN}
#	umount -v "${LFS}/sys" >> ${_log}
#	color-echo "		 ${LFS}/proc" ${CYAN}
#	umount -v "${LFS}/proc" >> ${_log}
#fi

#if [ -n "$( mount | grep ${LFS}${LFS_PWD} )" ]; then
#	color-echo "		 ${LFS}${LFS_PWD}" ${CYAN}
#	umount -v "${LFS}${LFS_PWD}" >> ${_log}
#fi

local _disk
for _disk in `tac ${CLFS_PWD}/disk`
do
	local _section=$(echo ${_disk} | cut -d: -f1)
	local _mount_point=$(echo ${_disk} | cut -d: -f2)
	local _type=$(echo ${_disk} | cut -d: -f3)

	case ${_mount_point} in
	    'swap' )
		[ "${MOUNT_CLFS_FLAG}" -ne 0 ] && ( swapoff -v ${_section} >> ${_log} )
	    ;;
	    * )
		if [ -n "$( mount | grep ${_section} )" ]; then
			color-echo "Размонтирование: ${_mount_point}" ${CYAN}
			if [ "${MOUNT_CLFS_FLAG}" -ne 0 ]; then
				umount -v ${_section} >> ${_log}
				if [ "${?}" -ne 0 ]; then
					fuser -m -k ${_section} >> ${_log}
					umount -v ${_section} >> ${_log}
				fi
			fi
#			rm -Rf "${LFS}${_mount_point}"
		fi
	    ;;
	esac
done
if [ -n "$( mount | grep ${CLFS} )" ]; then
	color-echo "Остались смонтированны:
`mount | grep ${CLFS}`" ${RED}
	return 1
#else
#	rm -Rf ${CLFS} /tools
fi
}

################################################################################
