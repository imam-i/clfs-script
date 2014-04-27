#!/bin/bash
#######################################
# Cross-LFS
# Version: test

_clfs ()
{
# Устанавливаем точное время.
which ntpdate 2> /dev/null && ntpdate 0.europe.pool.ntp.org

# Определяем основную переменную CLFS_PWD.
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
-a | --arch	Укажите архитектуру rpi, x86_64, i686.
-t | --tools	Сборка пакетов из раздела "5. Constructing a Temporary System" книги LFS.
-s | --system	Сборка пакетов из раздела "6. Installing Basic System Software",
		"7. Setting Up System Bootscripts" и
		"8. Making the LFS System Bootable" книги LFS.
-b | --blfs	Сборка пакетов из книги BLFS.

-m | --mount	Смонтировать разделы из файла ./disk для новой системы.
-d | --download	Загрузка пакетов.
-u | --su	Вход в систему под пользователем clfs.

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
			TOOLS_CLFS_FLAG=2
		;;
		-s | --system)
			SYSTEM_CLFS_FLAG=1
		;;
		-b | --blfs)
			BLFS_FLAG=1
		;;
		-u | --su)
			SU_FLAG=1
		;;
		-d | --download)
			PACKAGES_CLFS_FLAG=1
		;;
		--clean)
			if [ -z "$(fgrep "${CLFS}" /proc/mounts)" ]; then
				rm -Rfv ${BUILD_DIR} ${CLFS} ${CLFS_OUT}
			else
				color-echo 'Остались смонтироваными ФС!' ${RED}
				exit 1
			fi
			exit
		;;
	esac
done

case "${CLFS_ARCH}" in
	'x86_64' | 'i686')	local CLFS_DISK="${CLFS_PWD}/disk.x86" ;;
	'rpi')			local CLFS_DISK="${CLFS_PWD}/disk.rpi" ;;
	*)
		color-echo "Не известная архитектура: (${CLFS_ARCH}) !!!" ${RED}
		exit 1
	;;
esac

if [ ! -f "${CLFS_DISK}" ]; then
	color-echo 'Отсутствует файл disk.' ${RED}
	exit 1
fi

# Сменяем права доступа на скрипты если имеется пользователь i.
[ -n "$(grep ^i: /etc/passwd 2> /dev/null)" ] && chown i:i -R ${CLFS_PWD}

# Размонтирование разделов.
f_umount_clfs || exit ${?}

# Перехватываем ошибки.
trap _ERROR ERR
set -eE

# Подготовка и монтирование разделов.
f_mount_clfs

# Назначение переменных (массивов) хроняших информацию о пакетах.
#array_packages

# Скачиваем пакеты.
f_packages_clfs 'lfs.06.all'

# Создание необходимых каталогов и сборка временной системы.
f_tools_clfs

# Входим в su - clfs
#su_clfs

# Сборка основной системы.
system_clfs

# Сборка BLFS.
#beyond_clfs

# Входим в chroot
#chroot_clfs

# Размонтирование разделов и очистка системы.
f_umount_clfs

# Сменяем права доступа на скрипты если имеется пользователь i.
[ -n "$(grep ^i: /etc/passwd 2> /dev/null)" ] && chown i:i -R ${CLFS_PWD}

# Прекрашяем перехватывать ошибки.
set +Ee
}

setterm -blank 0
_clfs $*

#######################################
