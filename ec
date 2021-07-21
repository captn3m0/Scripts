#!/bin/bash

#
# Attribution
# Written by cthulahoops.
# The idea is to provide a single interface for quickly editing various configurations.
#

declare -A configs
configs=(
    ['khal']=".config/khal/config"
    ['vdirsyncer']=".config/vdirsyncer/config"
    ['nvim']=".config/nvim/init.vim"
    ['bash']=".bashrc"
    ['tmux']=".tmux.conf"
    ['unison']=".unison/common"
    ['ec']='bin/ec'
)

case "$1" in
    show)
        echo "$HOME/${configs[$2]}"
        ;;
    *)
        exec $EDITOR "$HOME/${configs[$1]}"
esac