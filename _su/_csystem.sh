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
local SU_FLAG=${4}

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
	1)	# -1
		scripts_clfs '05.Installing Basic System Software'		#-1
		scripts_clfs '06.Making the CLFS System Bootable'
		scripts_clfs '07.Setting Up System Bootscripts'
		scripts_clfs '09.Additional Libraries'
		scripts_clfs '10.Networking Software'
		scripts_clfs '11.File System Tools'
		;;
	0)	# 00
#		if [ "${SYSTEM_CLFS_FLAG}" -gt 0 ]; then
#			untar_clfs '04.Constructing Cross-Compile Tools'	#1-
#		else
			return 0
#		fi
		;;
	*) echo 'Не верный параметер константы "TOOLS_CLFS_FLAG"' ;;
esac

#if [ "${ERR_FLAG}" -eq 0 ] && [ "${MOUNT_CLFS_FLAG}" -ne 0 ]; then
if [ "${ERR_FLAG}" -eq 0 ]; then

# 12.1. Copy Libraries
cp -vP ${CLFS_CROSS_TOOLS}/${CLFS_TARGET}/lib/*.so* ${CLFS}/targetfs/lib/
${CLFS_TARGET}-strip ${CLFS}/targetfs/lib/* || true

# 6.2. Creating the /etc/fstab File
cat > ${CLFS}/targetfs/etc/fstab << "EOF"
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
		'swap') echo "${_section}      swap         ${_type}   pri=1              0     0" >> ${CLFS}/targetfs/etc/fstab ;;
		'/')	echo "${_section}      ${_mount_point}            ${_type}   defaults        0     1" >> ${CLFS}/targetfs/etc/fstab
			_ROOT="${_section}"
			;;
		'/boot') echo "${_section}     ${_mount_point}         ${_type}   defaults        1     2" >> ${CLFS}/targetfs/etc/fstab ;;
		*)	echo "${_section}      ${_mount_point}         ${_type}   defaults        0     0" >> ${CLFS}/targetfs/etc/fstab ;;
	esac
done

cat >> ${CLFS}/targetfs/etc/fstab << "EOF"
proc           /proc        proc   defaults         0     0
sysfs          /sys         sysfs  defaults         0     0
devpts         /dev/pts     devpts gid=4,mode=620   0     0
shm            /dev/shm     tmpfs  defaults         0     0
# End /etc/fstab
EOF

cat > /mnt/clfs/targetfs/boot/cmdline.txt << EOF
root=${_ROOT} rootdelay=${_ROOT: -1}
EOF

fi

set +Ee
}

_system_clfs $*

################################################################################
