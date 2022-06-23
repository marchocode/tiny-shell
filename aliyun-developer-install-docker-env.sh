#!/bin/bash
# 阿里云弹性计算体验馆快速安装Docker环境，用于体验Docker和测试
# https://developer.aliyun.com/adc/expo/ecs

echo "1. start install some package."
yum install -y yum-utils device-mapper-persistent-data lvm2

echo "2. config aliyun mirrors"
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

echo "3. make cache and install docker"
yum makecache fast

yum -y install docker-ce

echo "4. config docker hub mirrors"
echo '{"registry-mirrors": ["https://registry.docker-cn.com"]}' > /etc/docker/daemon.json

echo "5. start docker service"
systemctl start docker

echo "6. check version"
docker info

echo "7. finish."