#!/usr/bin/bash

echo ""
echo ""
echo "@Title Automatic Update Linux Mirrors"
echo "@Author Marcho"
echo "@Github https://github.com/marchocode/shell"
echo ""
echo ""


ID=`cat /etc/os-release | grep -w "ID" | cut -d "=" -f 2 | tr -d "\""`
VERSION_CODENAME=`cat /etc/os-release | fgrep -w "VERSION" | cut -d "=" -f 2 | tr -d "\""`

if [ $ID != "centos" ];
then
  VERSION_CODENAME=`lsb_release -sc`
fi

GITEE_RAW="https://gitee.com/marchocode/shell/raw/master"

echo "[INFO]----------------Loading Configuration"
echo ""
CONFIG=`wget --no-check-certificate -q -O - ${GITEE_RAW}/config | fgrep -w ${ID}`
echo ""

DOWNLOAD="${HOME}/."${ID}-${VERSION_CODENAME}
BACKUP=${HOME}"/mirrors.backup"
TARGET=`echo ${CONFIG} | cut -d "," -f 2`

echo "[INFO]----------------A.Loading Mirrors"
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
echo "[INFO]----------------Please type your numbers"
echo ""
read -p "Type(default: 1): " CHOISE
echo ""

if [ -z $CHOISE ]; then
    CHOISE="1"
fi

if [[ ! $CHOISE =~ ^[0-9]+$ ]] ; then
    echo "[ERROR] Typing Number Please!----"
    exit 0
fi

if [ ${CHOISE} -lt 1 ] || [ ${CHOISE} -gt ${#MIRRORS[@]} ];
then
    echo "[ERROR] Array Index Out!"
    echo "[ERROR] You Can Input Min Number Is [1], And Max Number Is ["${#MIRRORS[@]}"]"
    exit 0
fi

HOST=${MIRRORS[CHOISE-1]}
HOST_URL=`echo ${HOST} | cut -d '|' -f 1`
HOST_NAME=`echo ${HOST} | cut -d '|' -f 2`


echo ""
echo "[INFO]----------------Downloading Template"
echo ""

# download release config
wget --no-check-certificate -q -O ${DOWNLOAD} ${GITEE_RAW}/${ID}/${VERSION_CODENAME}

# download default config
if [ ! -s ${DOWNLOAD} ]; then
    echo "[WARN] Not Found Release file, Use Default"
    wget --no-check-certificate -q -O ${DOWNLOAD} ${GITEE_RAW}/${ID}/default
    sed -i 's/release/'${VERSION_CODENAME}'/g' ${DOWNLOAD}
fi

sed -i 's/host/'${HOST_URL}'/g' ${DOWNLOAD}

echo ""
echo "[INFO]----------------Backup Old Sources"
echo ""
cp -n ${TARGET} ${BACKUP}

echo ""
echo "[INFO]----------------System Info"
echo ""
echo "--------OS: "${ID}
echo "--------Code: "${VERSION_CODENAME}
echo "--------Mirrors: "${HOST_URL}"(${HOST_NAME})"
echo "--------Backup Config: "${BACKUP}
echo "--------Target Config: "${TARGET}
echo ""

if [ $ID == "centos" ];
then
  rm -f /etc/yum.repos.d/*.repo
fi

echo ""
echo "[INFO]----------------Finish"
echo ""
cat ${DOWNLOAD} > ${TARGET}
echo "[INFO]----------------Now,execute comment 'apt-get update' to update your system."
echo ""