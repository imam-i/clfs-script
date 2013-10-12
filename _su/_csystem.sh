#!/bin/bash
################################################################################
# Функция "_system_clfs"
# Version: 0.1

_system_clfs ()
{
cd ${CLFS_PWD}
for _functions in ${CLFS_PWD}/_functions/*.sh
do
	. ${_functions}
done

local CLFS_FLAG='_system-clfs'

local TOOLS_CLFS_FLAG=${1}
local SYSTEM_CLFS_FLAG=${2}
local BLFS_FLAG=${3}
local CHROOT_FLAG=${4}

# Перехватываем ошибки.
local restoretrap

set -eE

restoretrap=`trap -p ERR`
trap '_ERROR' ERR
eval $restoretrap

# Удаляем запуск скрипта.
sed -e "/\/_su\/_csystem.sh/d" \
    -e '/^exit/d' \
    -i ~/.bashrc

# Назначение переменных (массивов) хроняших информацию о пакетах.
array_packages

# Каталог для хронения лог-файлов tools
_LOG="${CLFS_LOG}/system_clfs"
install -d ${_LOG}

case ${SYSTEM_CLFS_FLAG} in
#	3)	# 11
#		scripts_ctools '04.Final Preparations'	#-1
#		scripts_ctools 'pm.Pacman'	#1-
#		;;
#	2)	# 10
#		scripts_ctools 'pm.Pacman' '04.Final Preparations'	#1-
#		;;
	1)	# -1
		scripts_clfs '06.Installing Basic System Software'		#-1
		scripts_clfs '07.Making the CLFS System Bootable'
		scripts_clfs '08.Setting Up System Bootscripts'
		scripts_clfs '11.Additional Libraries'
		scripts_clfs '12.Networking Software'
		scripts_clfs '13.File System Tools'
#		scripts_ctools '05.Constructing Cross-Compile Tools'
		;;
	0)	# 00
		if [ "${SYSTEM_CLFS_FLAG}" -gt 0 ]; then
			untar_clfs 'pm.Pacman' '04.Final Preparations'	#1-
		else
			return 0
		fi
		;;
	*) echo 'Не верный параметер константы "TOOLS_CLFS_FLAG"' ;;
esac

#if [ "${ERR_FLAG}" -eq 0 ] && [ "${MOUNT_CLFS_FLAG}" -ne 0 ]; then
if [ "${ERR_FLAG}" -eq 0 ]; then

# fstab
cat > ${CLFS}/etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type   options          dump  fsck
#                                                         order

EOF

local _disk
for _disk in `cat ${CLFS_PWD}/disk`
do
	local _section=$(echo ${_disk} | cut -d: -f1)
	local _mount_point=$(echo ${_disk} | cut -d: -f2)
	local _type=$(echo ${_disk} | cut -d: -f3)
	case ${_mount_point} in
		'swap') echo "${_section}      none         ${_type}   sw              0     0" >> ${CLFS}/etc/fstab ;;
		'/')	echo "${_section}      ${_mount_point}            ${_type}   defaults        0     1" >> ${CLFS}/etc/fstab
			_ROOT="${_section}"
			;;
		'/boot') echo "${_section}     ${_mount_point}         ${_type}   defaults        1     2" >> ${CLFS}/etc/fstab ;;
		*)	echo "${_section}      ${_mount_point}         ${_type}   defaults        0     0" >> ${CLFS}/etc/fstab ;;
	esac
done

cat >> ${CLFS}/etc/fstab << "EOF"
proc           /proc        proc   defaults         0     0
sysfs          /sys         sysfs  defaults         0     0
devpts         /dev/pts     devpts gid=4,mode=620   0     0
shm            /dev/shm     tmpfs  defaults         0     0
# End /etc/fstab
EOF

cat > /mnt/clfs/boot/cmdline.txt << EOF
root=${_ROOT} rootdelay=${_ROOT: -1}
EOF

fi

set +Ee
}

_system_clfs $*

################################################################################
