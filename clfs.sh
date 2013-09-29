#!/bin/bash
#######################################
# Cross-LFS
# Version: test

_clfs ()
{
# Устанавливаем точное время.
which ntpdate 2> /dev/null && ntpdate 0.europe.pool.ntp.org

# Определяем основную переменную.
local CLFS_PWD=`dirname "${0}"`
[ "${CLFS_PWD}" == '.' ] && local CLFS_PWD=`pwd`

# Определяем все переменные и функции.
for _function in ${CLFS_PWD}/_functions/*.sh
do
	source ${_function}
done

# Должен быть хотя бы один аргумент.
if [ "$#" -eq 0 ]; then
	cat << EOF
./clfs.sh [ Опции ]

Опции:
-t | --tools	Сборка пакетов из раздела "5. Constructing a Temporary System" книги LFS.
-s | --system	Сборка пакетов из раздела "6. Installing Basic System Software",
		"7. Setting Up System Bootscripts" и
		"8. Making the LFS System Bootable" книги LFS.
-b | --blfs	Сборка пакетов из книги BLFS.

-m | --mount	Смонтировать разделы из файла ./disk для новой системы.
-d | --download	Загрузка пакетов.
-c | --chroot	По завершению установки войти в систему с chroot.

--clean		Очистка логов и результируюших пакетов.
EOF

	exit 0
fi

# Проверяем входные аргументы.
for _ARG in $*
do
	case "${_ARG}" in
		-m | --mount)
			MOUNT_CLFS_FLAG=1
		;;
		-t | --tools)
			TOOLS_CLFS_FLAG=1
		;;
		-s | --system)
			SYSTEM_CLFS_FLAG=3
		;;
		-b | --blfs)
			BLFS_FLAG=1
		;;
		-c | --chroot)
			CHROOT_FLAG=1
		;;
		-d | --download)
			PACKAGES_CLFS_FLAG=1
		;;
		--clean)
			if [ -z "$(fgrep "${CLFS}" /proc/mounts)" ]; then
				rm -Rfv ${BUILD_DIR} /tools ${CLFS} ${CLFS_OUT}
			else
				color-echo 'Остались смонтироваными ФС!' ${RED}
				exit 1
			fi
			exit
		;;
	esac
done

# Сменяем права доступа на скрипты если имеется пользователь i.
[ -n "$(grep ^i: /etc/passwd 2> /dev/null)" ] && chown i:i -R ${CLFS_PWD}

# Размонтирование разделов.
umount_clfs || exit ${?}

# Перехватываем ошибки.
local restoretrap

set -eE

restoretrap=`trap -p ERR`
trap '_ERROR' ERR
eval $restoretrap

# Подготовка и монтирование разделов.
mount_clfs

# Назначение переменных (массивов) хроняших информацию о пакетах.
array_packages

# Скачиваем пакеты.
packages_clfs

# Создание необходимых каталогов и сборка временной системы.
tools_clfs

# Сборка основной системы.
#system_clfs

# Сборка BLFS.
#beyond_clfs

# Входим в chroot
#chroot_clfs

# Размонтирование разделов и очистка системы.
umount_clfs

# Сменяем права доступа на скрипты если имеется пользователь i.
[ -n "$(grep ^i: /etc/passwd 2> /dev/null)" ] && chown i:i -R ${CLFS_PWD}

# Прекрашяем перехватывать ошибки.
set +Ee
}

setterm -blank 0
_clfs $*

#######################################
