#!/bin/bash

if test -e /etc/redhat-release && grep -Eqi "stream" /etc/redhat-release; then
    release="centos-stream"
    version=$(cat /etc/os-release | grep "VERSION_ID" | grep -Eo "[0-9]")
elif [[ -f /etc/redhat-release ]]; then
    release="centos"
    version=$(cat /etc/os-release | grep "VERSION_ID" | grep -Eo "[0-9]")
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    version=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    version=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    version=$(cat /etc/os-release | grep "VERSION_ID" | grep -Eo "[0-9]")
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    version=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    version=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

echo ${release}
echo ${version}