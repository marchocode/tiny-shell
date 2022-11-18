#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1


echo -e ""
echo -e "${green}tiny-shell ${plain}使用帮助："

echo -e "----------------------------------------------"
echo -e "${green}tiny-shell ${plain}一个帮助你节省一堆时间的shell脚本"
echo -e ""
echo -e "tiny-shell                      - 显示帮助菜单"
echo -e "tiny-shell mirrors              - 切换最快的国内系统镜像源(阿里云/网易/清华大学)众多镜像站收录"
echo -e "tiny-shell docker               - 快速安装docker"
echo -e "tiny-shell pip                  - 快速配置pip加速镜像"
echo -e "----------------------------------------------"
echo -e ""
