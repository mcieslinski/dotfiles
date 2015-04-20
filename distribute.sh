#!/bin/bash
LB_FILES_DIR="$(pwd)/files"
LB_SCRIPTS_DIR="$(pwd)/scripts"
LB_NEW_DIR=
LB_TEST_MODE_ENGAGE="${LB_NEW_DIR}"

# Check for test mode
if [[ "${1}" = "--test" ]]; then
    export LB_TEST_MODE="HELL_YEAH"
    LB_NEW_DIR="~"
else
    export LB_TEST_MODE="HELL_NAW"
    LB_NEW_DIR="$(pwd)/test"
fi

# Source the linux_base functions
source ${LB_SCRIPTS_DIR}/util_functions.sh

# The basics
lb_testwrap lb_mklink ${LB_FILES_DIR}/bashrc ${LB_NEW_DIR}/.bashrc
lb_testwrap lb_mklink ${LB_FILES_DIR}/bash_aliases ${LB_NEW_DIR}/.bash_aliases
lb_testwrap lb_mklink ${LB_FILES_DIR}/profile ${LB_NEW_DIR}/.profile
lb_testwrap lb_mklink ${LB_FILES_DIR}/dircolors ${LB_NEW_DIR}/.dircolors
lb_testwrap source ${LB_NEW_DIR}/.bashrc

# Vim
if [[ -e '/usr/bin/vim' ]]; then
    lb_testwrap lb_mklink ${LB_FILES_DIR}/vimrc ${LB_NEW_DIR}/.vimrc
else
    echo "Vim not found. Fix that shit."
    return 1
fi

# Guake
if [[ -e /usr/local/bin/guake ]]; then
    lb_testwrap lb_mklink ${LB_FILES_DIR}/guake ${LB_NEW_DIR}/.gconf/schemas/apps/guake
    echo "You will probably want to restart guake to make sure you get the new settings."
else
    echo "Guake not found. Dafuq you doin' without Guake, bro?"
    return 1
fi

unset -v LB_TEST_MODE
unset -v LB_NEW_DIR
unset -v LB_SCRIPTS_DIR
unset -v LB_FILES_DIR
