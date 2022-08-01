#!/bin/bash

# 163 http://mirrors.163.com/debian/
# huaweicloud https://mirrors.huaweicloud.com/debian/
# aliyun https://mirrors.aliyun.com/debian/

DIR=$(pwd)
WORK_DIR=${DIR}/.mirrors
SOURCE_FILE='/etc/apt/sources.list'
REMOTE_MIRRORS="https://gitee.com/marchocode/shell/raw"
OS=`cat /etc/os-release | grep "^ID" | cut -d "=" -f 2`
VERSION_CODE=`cat /etc/os-release | grep "VERSION_CODENAME" | cut -d "=" -f 2`

echo "1. create work dir"
mkdir -p ${WORK_DIR}

# backup
echo "2. backup file"
cp ${SOURCE_FILE} ${WORK_DIR}/sources.old

# download template
echo "3. download template"
wget -P ${WORK_DIR} https://gitee.com/marchocode/shell/raw/master/mirrors/163.debian.sources.list

# make mirrors file
sed -i 's/code/'${VERSION_CODE}'/g' ${WORK_DIR}/163.debian.sources.list
sed -i 's/host/mirrors.163.com/g' ${WORK_DIR}/163.debian.sources.list