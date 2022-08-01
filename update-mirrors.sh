#!/bin/bash

DIR=$(pwd)
WORK_DIR=${DIR}/backup
OS=$(lsb_release -si)
CODE=$(lsb_release -sc)
SOURCE_FILE='/etc/apt'

# 163 http://mirrors.163.com/debian/
# huaweicloud https://mirrors.huaweicloud.com/debian/
# aliyun https://mirrors.aliyun.com/debian/

mkdir -p ${WORK_DIR}

# backup
copy ${SOURCE_FILE} ${WORK_DIR}/backup

# download template
wget -O 