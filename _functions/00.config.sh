#!/bin/bash
#######################################
# config
# Version: test

local PREFIX='svn'
local CLFS='/mnt/clfs'
local CLFS_SRC="${CLFS_PWD}/${PREFIX}/sources"
local CLFS_OUT="${CLFS_PWD}/output"
local CLFS_PKG="${CLFS_OUT}/pkg"
local CLFS_LOG="${CLFS_OUT}/log"
local CLFS_CONF="${CLFS_PWD}/conf"
local BUILD_DIR="${CLFS_PWD}/build"

#local CLFS_CROSS_TOOLS=${CLFS}/cross-tools
local CLFS_TOOLS=${CLFS}/tools
local CLFS_ARCH=`uname -m`

local PACKAGE_MANAGER='pacman'

local PACKAGE_GROUPS=('base' 'base-devel')
#local PACKAGE_FORCE=('base-core' 'glibc' 'binutils' 'gcc' 'shadow' 'coreutils' 'bash' 'perl' 'bash-completion')

local HOSTNAME='inet'
local ns1_IP='8.8.4.4'
local ns2_IP='8.8.8.8'
#local PATH_CHROOT='/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin:/tools/sbin'

# flags
local CLFS_FLAG='clfs'
local SU_FLAG=${SU_FLAG:-0}
#local J2_CLFS_FLAG="$(( `grep -c '^processor' /proc/cpuinfo` + 1 ))"
local PACKAGE_MANAGER_FLAG=${PACKAGE_MANAGER_FLAG:-1}
local MOUNT_FLAG=${MOUNT_FLAG:-0}
local PACKAGES_FLAG=${PACKAGES_FLAG:-0}
local TOOLS_FLAG=${TOOLS_FLAG:-0}		# 0 = 00; 1 = -1; 2 = 10; 3 = 11.
local SYSTEM_FLAG=${SYSTEM_FLAG:-0}		# 0 = 00; 1 = -1; 2 = 10; 3 = 11.
local BLFS_FLAG=${BLFS_FLAG:-0}
local ERR_FLAG=${ERR_FLAG:-0}

# The different log levels:
local CT_LOG_LEVEL_ERROR=0
local CT_LOG_LEVEL_WARN=1
local CT_LOG_LEVEL_INFO=2
local CT_LOG_LEVEL_EXTRA=3
local CT_LOG_LEVEL_CFG=4
local CT_LOG_LEVEL_FILE=5
local CT_LOG_LEVEL_STATE=6
local CT_LOG_LEVEL_ALL=7
local CT_LOG_LEVEL_DEBUG=8

#######################################
