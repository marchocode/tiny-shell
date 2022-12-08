#!/bin/bash
read -p "请输入选择 [0-${mirrors_length}](默认0): " CHOISE

echo ${CHOISE}

if [[ ! ${CHOISE} =~ ^[0-9]+$ ]]; then
    echo -e "${red}错误，请重试！${plain}" && exit 1
fi