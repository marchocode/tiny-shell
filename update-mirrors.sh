#!/bin/bash

# 163 http://mirrors.163.com/debian/
# huaweicloud https://mirrors.huaweicloud.com/debian/
# aliyun https://mirrors.aliyun.com/debian/

DIR=$(pwd)
HOST="mirrors.aliyun.com"
WORK_DIR=${DIR}/.backup
SOURCE_FILE='/etc/apt/sources.list'
REMOTE_MIRRORS="https://gitee.com/marchocode/shell/raw/master/mirrors"
OS=`cat /etc/os-release | grep "^ID" | cut -d "=" -f 2`
VERSION_CODE=`cat /etc/os-release | grep "VERSION_CODENAME" | cut -d "=" -f 2`
MIRRORS_FILE=${OS}.source

MIRRORS_LIST=("" "mirrors.163.com" "mirrors.aliyun.com")

echo "请选择系统源："
echo "1. mirrors.163.com"
echo "2. mirrors.aliyun.com"
echo ""
read -p "请输入[默认2]: " CHECK

HOST=${MIRRORS_LIST[$CHECK]}

echo "1. create work dir"
mkdir -p ${WORK_DIR}

# backup
echo "2. backup file"
cp ${SOURCE_FILE} ${WORK_DIR}/sources.old

# download template
echo "3. download template"
wget -P ${WORK_DIR} ${REMOTE_MIRRORS}/${MIRRORS_FILE}

# make mirrors file
echo "4. making files"

sed -i 's/code/'${VERSION_CODE}'/g' ${WORK_DIR}/${MIRRORS_FILE}
sed -i 's/host/'${HOST}'/g' ${WORK_DIR}/${MIRRORS_FILE}

# deploy
echo "5. Deploy...."
cp ${WORK_DIR}/${MIRRORS_FILE} ${SOURCE_FILE}

echo "6. Shell is over"