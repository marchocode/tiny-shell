#!/usr/bin/bash

echo ""
echo ""
echo "@Title Automatic Update Linux Mirrors"
echo "@Author Marcho"
echo "@Github https://github.com/marchocode/shell"
echo ""
echo ""


ID=`cat /etc/os-release | grep -w "ID" | cut -d "=" -f 2`
VERSION_CODENAME=`lsb_release -sc`

GITEE_RAW="https://gitee.com/marchocode/shell/raw/master"
TARGET=".sources.list"
BACKUP="sources.list.old"


echo "-----------------A.Loading Mirrors----------------------------"
echo ""
MIRRORS=(`wget --no-check-certificate -q -O - ${GITEE_RAW}/host.mirrors`)

for (( i=0; i<${#MIRRORS[@]}; i++ ));
do
    index=`expr ${i} + 1`
    host=`echo ${MIRRORS[$i]} | cut -d '|' -f 1`
    desc=`echo ${MIRRORS[$i]} | cut -d '|' -f 2`

    echo $index"."$host"(${desc})"
done

echo ""
echo "-----------------B.Please type your numbers----------------------------"
echo ""
read -p "Type(default: 1): " CHOISE
echo ""

if [ -z $CHOISE ]; then
    CHOISE="1"
fi

if [[ ! $CHOISE =~ ^[0-9]+$ ]] ; then
    echo "[ERROR]---------Typing Number Please!----"
    exit 0
fi

if [ ${CHOISE} -lt 1 ] || [ ${CHOISE} -gt ${#MIRRORS[@]} ];
then 
    echo "[ERROR]---------Array Index Out!----"
    echo "[INFO]---------You Can Input Min Number Is [1], And Max Number Is ["${#MIRRORS[@]}"]"
    exit 0
fi

HOST=${MIRRORS[CHOISE-1]}
HOST_URL=`echo ${HOST} | cut -d '|' -f 1`
HOST_NAME=`echo ${HOST} | cut -d '|' -f 2`

echo ""
echo "-----------------D.System Info----------------------------"
echo ""
echo "--------OS: "${ID}
echo "--------Code: "${VERSION_CODENAME}
echo "--------Mirrors: "${HOST_URL}"(${HOST_NAME})"
echo "--------Backup Config: "${BACKUP}
echo ""


echo ""
echo "-----------------C.Downloading Template----------------------------"
echo ""
wget --no-check-certificate -q -O ${TARGET} ${GITEE_RAW}/mirrors/${VERSION_CODENAME}.sources.list
sed -i 's/host/'${HOST_URL}'/g' ${TARGET}

echo ""
echo "-----------------D.Backup Old Configuation----------------------------"
echo ""
cp -n /etc/apt/sources.list ${BACKUP}

echo ""
echo "-----------------E.Finish----------------------------"
echo ""
cat ${TARGET} > /etc/apt/sources.list
echo "--------Now,execute comment 'apt-get update' to update your system."