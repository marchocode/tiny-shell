#!/usr/bin/env bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
line="----------------------------------------------"
backup_dir=".backup"

mkdir -p ${backup_dir}

# check os
# check code

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

# clean log
cat /dev/null > .tiny-shell.log

log() {
    echo "$1" >> .tiny-shell.log
}

root_check() {

    log "root_check user=${USER}"

    if [[ $USER != "root" ]]
    then
        echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1
    fi
}

# 选择镜像源
mirrors_check(){

    log "mirrors_check param=${1}"

    q=$1
    # centos-stream-8 作为centos去搜索
    if [[ ${q} = "centos-stream" && ${version} = "8" ]];then
        q="centos"
    fi

    mirrors_list=($(cat host.mirrors | grep ${q}))
    mirrors_length=$(expr ${#mirrors_list[@]} - 1)

    for (( i=0; i<${#mirrors_list[@]}; i++ ));
    do
        host=$(echo ${mirrors_list[$i]} | cut -d "|" -f 1)
        name=$(echo ${mirrors_list[$i]}| cut -d "|" -f 2)

        echo -e "${i}. ${green}${host}${plain}(${name})"
        log "${i}. ${green}${host}${plain}(${name})"
    done

    echo -e ""
    echo -e ${line}

    read -p "请输入选择 [0-${mirrors_length}](默认0): " CHOISE
    
    log "user choice=${CHOISE}"

    if [[ -z $CHOISE ]]; then
        CHOISE="0"
    fi

    if [[ ! ${CHOISE} =~ ^[0-9]+$ || ${CHOISE} < 0 || ${CHOISE} > ${mirrors_length} ]]; then
        echo -e "${red}错误，请重试！${plain}" && exit 1
    fi

    check_host=${mirrors_list[${CHOISE}]}
    log "check_host=${check_host}"

    id=$(echo ${check_host} | cut -d "|" -f 1)
    host=$(echo ${check_host} | cut -d "|" -f 2)
    name=$(echo ${check_host} | cut -d "|" -f 3)
    host_url=$(echo ${check_host} | cut -d "|" -f 4)

    return 0
}

print_info(){

    echo -e ""
    echo -e "OS                   - ${release}"
    echo -e "Version              - ${version}"
    echo -e "Mirror               - ${name}|${host_url}"
    echo -e "Destination          - ${destination}"
    echo -e ${line}

    echo -e ""
    echo -e "${red}感谢您的使用,相关文件已经被替换${plain}"
}

system(){
    clear
    echo -e ""
    echo -e "${green}tiny-shell ${plain}系统更新源快速切换"
    echo -e ${line}
    echo -e ""

    mirrors_check ${release}

    destinations=($(cat system.destination | grep "${release}-${version}"))
    log "system-destinations=${destinations}"

    if [[ ${#destinations[@]} -eq 0 ]]; then
        destinations=($(cat system.destination | grep "${release}-default"))
        log "system-destinations=${destinations}"
    fi

    backup=".sources.list.backup"
    

    for (( i=0; i<${#destinations[@]}; i++ ));
    do
        
        destination=$(echo ${destinations[$i]} | cut -d "|" -f 3)
        config="${release}/"$(echo ${destinations[$i]} | cut -d "|" -f 2)

        log "system-destination=${destination}"
        log "system-config=${config}"

        backup="${backup_dir}/"$(basename ${destination})

        # file backup
        cp ${destination} ${backup}

        cat ${config} > .target

        sed -i "s/host/${host}/g" .target
        sed -i "s/version/${version}/g" .target

        cat .target > ${destination}
        rm .target

    done

    print_info

}

docker(){
    clear
    echo -e ""
    echo -e "${green}tiny-shell ${plain}Docker-ce Install"
    echo -e ${line}
    echo -e ""
    
    mirrors_check docker

    repo_config="./${release}/docker"
    destination=$(cat docker.destination | grep ${release} | cut -d '|' -f 3)

    print_info
    backup=".docker.list.backup"

    # file backup
    if [[ -e ${destination} ]];then 
        cp ${destination} ${backup} 
    fi

    cat ${repo_config} > .target

    # download grp
    mkdir -p /etc/apt/keyring
    
    wget -q -O .docker.gpg "http://${host}/docker-ce/linux/${release}/gpg"
    gpg --dearmor -o /etc/apt/keyring/docker.gpg .docker.gpg

    sed -i "s/host/${host}/g" .target
    sed -i "s/version/${version}/g" .target

    cat .target > ${destination}

    rm .target
    rm .docker.gpg
}


maven(){
    clear
    echo -e ""
    echo -e "${green}tiny-shell ${plain}Maven Setting"
    echo -e ${line}
    echo -e ""

    mirrors_check maven

    repo_config="./maven/${id}.xml"
    destination="${HOME}/.m2/settings.xml"

    print_info
    backup=".setting.xml"

    # file backup
    if [[ -e ${destination} ]];then 
        cp ${destination} ${backup_dir}"/"${backup} 
    fi
    
    mkdir -p "${HOME}/.m2"

    cat ${repo_config} > ${destination}
}

pypi(){
    
    clear
    echo -e ""
    echo -e "${green}tiny-shell ${plain}Pip Setting"
    echo -e ${line}
    echo -e ""

    mirrors_check pypi

    repo_config="./pip.conf"
    destination="$HOME/.pip/pip.conf"

    print_info
    mkdir -p $(dirname ${destination})

    cat ${repo_config} > .target

    sed -i "s/HOST/${host}/g" .target

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
    echo -e "tiny-shell system               - 切换国内系统镜像源(阿里云/网易/清华大学)众多镜像站收录"
    echo -e "tiny-shell docker               - 快速安装docker"
    echo -e "tiny-shell pypi                 - 快速配置pip加速镜像"
    echo -e "tiny-shell maven                - 快速配置maven加速镜像"
    echo -e ${line}
    echo -e ""
}

log "os: ${release}"
log "version: ${version}"

if [[ $# > 0 ]]; then
    case $1 in 
    "system")
        root_check && system
        ;;
    "docker")
        root_check && docker
        ;;
    "pypi")
        pypi
        ;;    
    "maven")
        maven
        ;;               
    *) menu
        ;;
    esac    
else
    menu
fi