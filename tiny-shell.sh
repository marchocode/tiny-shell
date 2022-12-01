#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
line="----------------------------------------------"

[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

# check os
# check code

if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    version=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    version=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    version=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

# 选择镜像源
mirrors_check(){

    mirrors_list=($(cat host.mirrors | grep $1))
    mirrors_length=$(expr ${#mirrors_list[@]} - 1)

    for (( i=0; i<${#mirrors_list[@]}; i++ ));
    do
        host=$(echo ${mirrors_list[$i]} | cut -d "|" -f 1)
        name=$(echo ${mirrors_list[$i]}| cut -d "|" -f 2)

        echo -e "${i}. ${green}${host}${plain}(${name})"
    done

    echo -e ""
    echo -e ${line}

    read -p "请输入选择 [0-${mirrors_length}](默认0): " CHOISE

    if [[ -z $CHOISE ]]; then
        CHOISE="0"
    fi

    check_host=${mirrors_list[${CHOISE}]}
    host=$(echo ${check_host} | cut -d "|" -f 1)

    return 1
}

print_info(){
    echo -e ""
    echo -e "OS                   - ${release}"
    echo -e "Version              - ${version}"
    echo -e "Mirror               - ${check_host}"
    echo -e "Destination          - ${destination}"
    echo -e ${line}

    echo -e ""
    echo -e "${red}感谢您的使用,相关文件已经被替换${plain}"
}

mirrors(){
    clear
    echo -e ""
    echo -e "${green}tiny-shell ${plain}System Mirrors Check"
    echo -e ${line}
    echo -e ""

    mirrors_check mirrors

    host=$(echo ${check_host} | cut -d "|" -f 1)
    repo_config="./${release}/${version}"
    destination=$(cat mirrors.destination | grep ${release} | cut -d '|' -f 2)
    backup=".sources.list.backup"

    print_info

    # check release file if exits
    if [[ ! -e repo_config ]]; then
        repo_config="./${release}/default"
    fi

    # file backup
    cp ${destination} ${backup}

    cat ${repo_config} > .target
    
    sed -i "s/host/${host}/g" .target
    sed -i "s/release/${version}/g" .target

    cat .target > ${destination}

    rm .target
}

docker(){
    clear
    echo -e ""
    echo -e "${green}tiny-shell ${plain}Docker-ce Install"
    echo -e ${line}
    echo -e ""
    
    mirrors_check docker

    repo_config="./${release}/docker"
    destination=$(cat docker.destination | grep ${release} | cut -d '|' -f 2)

    print_info
    backup=".docker.list.backup"

    # file backup
    if [[ -e ${destination} ]];then 
        cp ${destination} ${backup} 
    fi

    cat ${repo_config} > .target

    # download grp
    wget -q -O docker.gpg "http://${host}/docker-ce/linux/${release}/gpg"
    gpg --dearmor -o /etc/apt/docker.gpg docker.gpg

    sed -i "s/host/${host}/g" .target
    sed -i "s/release/${version}/g" .target

    cat .target > ${destination}
    rm .target

}

menu(){
    clear
    echo -e ""
    echo -e "${green}tiny-shell ${plain}"

    echo -e ${line}
    echo -e "一个帮助你节省一堆时间的shell脚本"
    echo -e ""
    echo -e "tiny-shell                      - 显示帮助菜单"
    echo -e "tiny-shell mirrors              - 切换国内系统镜像源(阿里云/网易/清华大学)众多镜像站收录"
    echo -e "tiny-shell docker               - 快速安装docker"
    echo -e "tiny-shell pip                  - 快速配置pip加速镜像"
    echo -e "tiny-shell maven                - 快速配置maven加速镜像"
    echo -e ${line}
    echo -e ""
}

if [[ $# > 0 ]]; then
    case $1 in 
    "mirrors")
        mirrors
        ;;
    "docker")
        docker
        ;;        
    *) menu
        ;;
    esac    
else
    menu
fi
