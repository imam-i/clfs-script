#!/bin/bash
################################################################################
# Функция "system_clfs"
# Version: 0.1

system_clfs ()
{
local CLFS_FLAG='system-clfs'

local _LOG

color-echo "system_clfs" ${YELLOW}

date > "${CLFS_LOG}/system_clfs.log"

# Очистка сборочной папки
#rm -Rf ${BUILD_DIR}
#install -dv ${BUILD_DIR}

cat >> /home/clfs/.bashrc << EOF

export CC="${CLFS_TARGET}-gcc"
export CXX="${CLFS_TARGET}-g++"
export AR="${CLFS_TARGET}-ar"
export AS="${CLFS_TARGET}-as"
export LD="${CLFS_TARGET}-ld"
export RANLIB="${CLFS_TARGET}-ranlib"
export READELF="${CLFS_TARGET}-readelf"
export STRIP="${CLFS_TARGET}-strip"
EOF

# ---------------------------------
cat >> /home/clfs/.bashrc << EOF
${CLFS_PWD}/_su/_csystem.sh ${TOOLS_CLFS_FLAG} ${SYSTEM_CLFS_FLAG} ${BLFS_FLAG} ${CHROOT_FLAG}
exit \${?}
EOF
# ---------------------------------

su - clfs

date >> "${CLFS_LOG}/system_clfs.log"
}

################################################################################
