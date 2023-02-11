#!/usr/bin/env bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

BUCKET="http://rpwp9rk6e.hd-bkt.clouddn.com"
WORKDIR=".tiny-shell"

mkdir -p ${WORKDIR}

log() {
    date=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${date}  INFO   ${1}"
}

warn(){
    date=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${date}  ${yellow}WARN   ${1}${plain}"
}

error(){
    date=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${date}  ${red}ERROR  ${1}${plain}"
}

backup(){
    
    backup_target="${WORKDIR}/${2}"

    mkdir -p ${backup_target}
    log "Backup file ${1} to ${backup_target}"

    cp ${1} ${backup_target}
}


root_check() {

    log "Check Current User = ${USER}"

    if [[ $USER != "root" ]]
    then
        error "The Script needs Root Permission!" && exit 1
    fi
}

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
    error "The script does't support your system. Please commit your request! \n" && exit 1
fi

yum(){
    echo ""
}

apt(){
    host="\/\/mirrors.tencent.com\/"
    sed -E "s/\/\/[a-zA-Z.0-9]+\//${host}/g" /etc/apt/sources.list
}

mirrors_check(){

    q=$1
    # centos-stream-8 作为centos去搜索
    if [[ ${q} = "centos-stream" && ${version} = "8" ]];then
        q="centos"
    fi

    log "Mirrors Downloading...\n"

    mirrors_list=($(curl -s ${BUCKET}/host.mirrors | grep ${q}))
    mirrors_length=$(expr ${#mirrors_list[@]} - 1)

    for (( i=0; i<${#mirrors_list[@]}; i++ ));
    do
        host=$(echo ${mirrors_list[$i]} | cut -d "|" -f 1)
        name=$(echo ${mirrors_list[$i]}| cut -d "|" -f 2)

        echo -e "${i}. ${green}${host}${plain}(${name})"
    done

    echo -e ""
    read -p "Please Type Your Choice [0-${mirrors_length}](Default 0): " CHOISE
    echo -e ""

    if [[ -z $CHOISE ]]; then
        CHOISE="0"
    fi

    if [[ ! ${CHOISE} =~ ^[0-9]+$ || ${CHOISE} < 0 || ${CHOISE} > ${mirrors_length} ]]; then
        echo -e "${red}Number Error...${plain} Try Again!" && exit 1
    fi

    check_host=${mirrors_list[${CHOISE}]}

    id=$(echo ${check_host} | cut -d "|" -f 1)
    host=$(echo ${check_host} | cut -d "|" -f 2)
    name=$(echo ${check_host} | cut -d "|" -f 3)
    host_url=$(echo ${check_host} | cut -d "|" -f 4)

    log "id=${id}"
    log "host=${host}"

    return 0
}

print_info(){

    log ""
    log "OS            - ${release}"
    log "Version       - ${version}"
    log "Mirror        - ${name}|${host_url}"
    log "Destination   - ${destination}"

}


system(){

    clear
    echo -e ""
    echo -e "${green}Tiny-Shell ${plain} System Mirrors Check..."
    echo -e ""

    mirrors_check ${release}
    system_tmp="${WORKDIR}/system.destination.tmp"

    log "System Configuation is loading..."
    curl -s ${BUCKET}/system.destination > ${system_tmp}

    destinations=($(cat ${system_tmp} | grep "${release}-${version}"))

    if [[ ${#destinations[@]} -eq 0 ]]; then
        destinations=($(cat ${system_tmp} | grep "${release}-default"))
        warn "Loading Default Configuation."
    fi

    for (( i=0; i<${#destinations[@]}; i++ ));
    do
        
        destination=$(echo ${destinations[$i]} | cut -d "|" -f 3)
        config="${release}/"$(echo ${destinations[$i]} | cut -d "|" -f 2)

        backup ${destination} "system"

        log "Downloading System Mirrors..."
        curl -s "${BUCKET}/${config}" > "${WORKDIR}/.target"

        sed -i "s/host/${host}/g" "${WORKDIR}/.target"
        sed -i "s/version/${version}/g" "${WORKDIR}/.target"

        cat "${WORKDIR}/.target" > ${destination}

    done

    print_info

}


menu(){
    echo -e ""
    echo -e "${green}Tiny-Shell ${plain}"

    echo -e "A Simple Shell Script To Help You For Work"
    echo -e ""
    echo -e "./tiny-shell                      - Help"
    echo -e "./tiny-shell system               - Check System Mirrors"
    echo -e "./tiny-shell docker               - Install Docker Environment"
    echo -e "./tiny-shell pypi                 - Configuating Python Package Manager's Mirrors"
    echo -e "./tiny-shell maven                - Maven's Mirrors Check"
    echo -e ""
}

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