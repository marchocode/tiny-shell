#!/usr/bin/env bash

BUCKET="https://tiny-shell.chaobei.xyz"
curl -s -o tiny-shell.sh ${BUCKET}/tiny-shell.sh

sed -i 's/file:${pwd}/https:\/\/tiny-shell.chaobei.xyz/g' tiny-shell.sh
chmod +x tiny-shell.sh

./tiny-shell.sh