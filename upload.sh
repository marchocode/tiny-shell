
# check qshell
qshell -v

if [[ $? != 0 ]];then
    echo "install qshell"
fi

qshell qupload2 --bucket tiny-shell \
                --overwrite true \
                --src-dir $(pwd) \
                --skip-file-prefixes "upload" \
                --skip-path-prefixes ".tiny-shell/,doc/,icons/" \
                --skip-fixed-strings ".git,.gitignore"
                