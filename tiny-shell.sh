#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

# check os

if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

mirrors(){
    
    echo -e ""
    echo -e "${green}tiny-shell ${plain}mirrors"
    echo -e "----------------------------------------------"
    echo -e ""
    echo -e "1. mirrors.163.com                     - 网易开源镜像站"
    echo -e "2. mirrors.aliyun.com                  - 阿里云镜像站"
    echo -e "3. mirrors.ustc.edu.cn                 - 中国科学技术大学开源软件镜像"
    echo -e "4. mirrors.tuna.tsinghua.edu.cn        - 清华大学开源软件镜像站"
    echo -e ""
    echo -e "----------------------------------------------"

    echo -e "${red}请选择编号：默认【1】${plain}" && read CHOISE
    if [ -z $CHOISE ]; then
        CHOISE="1"
    fi

    echo ${CHOISE}

}

echo -e ""
echo -e "${green}tiny-shell ${plain}使用帮助："

echo -e "----------------------------------------------"
echo -e "${green}tiny-shell ${plain}一个帮助你节省一堆时间的shell脚本"
echo -e ""
echo -e "tiny-shell                      - 显示帮助菜单"
echo -e "tiny-shell mirrors              - 切换国内系统镜像源(阿里云/网易/清华大学)众多镜像站收录"
echo -e "tiny-shell docker               - 快速安装docker"
echo -e "tiny-shell pip                  - 快速配置pip加速镜像"
echo -e "----------------------------------------------"
echo -e ""

mirrors