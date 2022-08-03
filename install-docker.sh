#!/bin/bash

# @Author mrc
# @Github https://github.com/marchocode/shell
#
#
# @Title Docker-ce Install Script
# @Desc Automatic install docker-ce


# 1. https://mirrors.aliyun.com/docker-ce/
# 2. https://mirrors.163.com/docker-ce/
# 3. https://mirrors.pku.edu.cn/docker-ce/
# 4. https://mirrors.ustc.edu.cn/debian/

MIRRORS_LIST=("" "mirrors.aliyun.com" "mirrors.163.com" "mirrors.pku.edu.cn")
ID=`cat /etc/os-release | grep "^ID" | cut -d "=" -f 2`

USER_CHECK=1
echo "--------------------------A.请选择docker-ce镜像站------------------------------"

echo "--------1.mirrors.aliyun.com(阿里云)-----------------------------"
echo "--------2.mirrors.163.com(网易)-----------------------------"
echo "--------3.mirrors.pku.edu.cn(北京大学)-----------------------------"
echo "--------4.mirrors.ustc.edu.cn(中国科学技术大学)-----------------------------"

read -p "--------请输入数字选择[默认阿里云]：" USER_CHECK

HOST=${MIRRORS_LIST[USER_CHECK]}
BASE_PATH=https://${HOST}/docker-ce/linux/${ID}

# update repo
apt-get update


echo "--------------------------B.安装必要的依赖------------------------------"
# install some softwares
apt-get install ca-certificates curl gnupg lsb-release


echo "--------------------------C.导入公钥------------------------------"
# GPG key
# https://mirrors.aliyun.com/docker-ce/linux/debian/gpg
mkdir -p /etc/apt/keyrings
curl ${BASE_PATH}/gpg | gpg --dearmor > /etc/apt/keyrings/docker.gpg


echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg]\
  ${BASE_PATH}\
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "--------------------------D.开始安装------------------------------"
# install docker-ce
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose

# check version
echo "--------------------------E.检查版本------------------------------"
docker -v