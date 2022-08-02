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
MIRRORS_LIST=("" "mirrors.aliyun.com" "mirrors.163.com" "mirrors.pku.edu.cn")
ID=`cat /etc/os-release | grep "^ID" | cut -d "=" -f 2`
HOST=${MIRRORS_LIST[1]}

BASE_PATH=https://${HOST}/docker-ce/linux/${ID}

# update repo
apt-get update


# install some softwares
apt-get install ca-certificates curl gnupg lsb-release


# GPG key
# https://mirrors.aliyun.com/docker-ce/linux/debian/gpg
mkdir -p /etc/apt/keyrings
curl ${BASE_PATH}/gpg | gpg --dearmor > /etc/apt/keyrings/docker.gpg


echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg]\
  ${BASE_PATH}\
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# install docker-ce
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose

# check version
docker -v