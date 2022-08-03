#!/usr/bin/env bash

# @Author mrc
# @Github https://github.com/marchocode/shell
#
#
# @Title Automatic Update Linux Mirrors
# @Desc Automatic install docker-ce

ID=`cat /etc/os-release | grep "^ID" | cut -d "=" -f 2`
