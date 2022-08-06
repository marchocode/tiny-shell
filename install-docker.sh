#!/bin/bash

echo ""
echo ""
echo "@Title Automatic Install Docker"
echo "@Author Marcho"
echo "@Github https://github.com/marchocode/shell"
echo ""
echo ""

GITEE_RAW="https://gitee.com/marchocode/shell/raw/master"
VERSION_CODENAME=`lsb_release -sc`
ARCHCODE=$(dpkg --print-architecture)
ID=`cat /etc/os-release | grep -w "ID" | cut -d "=" -f 2`

KEY_DIR="/etc/apt/keyrings"
TARGET=".docker.list"
DOCKER_MIRROR="/etc/apt/sources.list.d/docker.list"


echo "[INFO]-----------------A.Loading Mirrors"
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
echo "[INFO]-----------------B.Please type your numbers"
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
    echo "[ERROR] Array Index Out!----"
    echo "[ERROR] You Can Input Min Number Is [1], And Max Number Is ["${#MIRRORS[@]}"]"
    exit 0
fi

HOST=${MIRRORS[CHOISE-1]}
HOST_DOMAIN=`echo ${HOST} | cut -d '|' -f 1`
HOST_NAME=`echo ${HOST} | cut -d '|' -f 2`
BASE_PATH=https://${HOST_DOMAIN}/docker-ce/linux/${ID}

echo ""
echo "[INFO]-----------------C.Install ca-certificates gnupg "
echo ""
# install some softwares
apt-get -y -q install ca-certificates gnupg


echo ""
echo "[INFO]-----------------D.Downloading Template"
echo ""
wget --no-check-certificate -q -O ${TARGET} ${GITEE_RAW}/docker/${ID}.sources.list

sed -i 's/HOST/'${HOST_DOMAIN}'/g' ${TARGET}
sed -i 's/ARCHCODE/'${ARCHCODE}'/g' ${TARGET}
sed -i 's/ID/'${VERSION_CODENAME}'/g' ${TARGET}

cat ${TARGET} > ${DOCKER_MIRROR}


echo ""
echo "[INFO]-----------------E.Import Key"
echo ""
mkdir -p ${KEY_DIR}
wget --no-check-certificate -q -O - ${BASE_PATH}/gpg | gpg --dearmor > ${KEY_DIR}/docker.gpg


echo ""
echo "[INFO]-----------------F.System Info"
echo ""
echo "--------OS: "${ID}
echo "--------Code: "${VERSION_CODENAME}
echo "--------Mirrors: "${HOST_DOMAIN}"(${HOST_NAME})"
echo "--------DockerMirror: "${DOCKER_MIRROR}
echo "--------Docker GPG Key: "${KEY_DIR}/docker.gpg
echo ""

echo ""
echo "[INFO]-----------------G.Update Mirrors"
echo ""
apt-get update

echo ""
echo "[INFO]-----------------H.Setup"
echo ""
apt-get -y install docker-ce

echo ""
echo "[INFO]-----------------H.Check"
echo ""
docker -v
echo "Try execute: docker run hello-world"
echo ""