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
local BUILD_DIR="${CLFS_PWD}/build"

local CLFS_ARCH='arm'

local PACKAGE_MANAGER='pacman'

local PACKAGE_GROUPS=('base' 'base-devel')
local PACKAGE_FORCE=('base-core' 'glibc' 'binutils' 'gcc' 'shadow' 'coreutils' 'bash' 'perl' 'bash-completion')

local HOSTNAME='inet'
local ns1_IP='8.8.4.4'
local ns2_IP='8.8.8.8'
local PATH_CHROOT='/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin:/tools/sbin'

# flags
local CLFS_FLAG='lfs'
local CHROOT_FLAG=${CHROOT_FLAG:-0}
local J2_CLFS_FLAG="$(( `grep -c '^processor' /proc/cpuinfo` + 1 ))"
local PACKAGE_MANAGER_FLAG=${PACKAGE_MANAGER_FLAG:-1}
local MOUNT_CLFS_FLAG=${MOUNT_CLFS_FLAG:-0}
local PACKAGES_CLFS_FLAG=${PACKAGES_CLFS_FLAG:-0}
local TOOLS_CLFS_FLAG=${TOOLS_CLFS_FLAG:-0}		# 0 = 00; 1 = -1; 2 = 10; 3 = 11.
local SYSTEM_CLFS_FLAG=${SYSTEM_CLFS_FLAG:-0}		# 0 = 00; 1 = -1; 2 = 10; 3 = 11.
local BLFS_FLAG=${BLFS_FLAG:-0}
local ERR_FLAG=${ERR_FLAG:-0}

#######################################
