#!/bin/bash
DF_FILES_DIR="$(pwd)/files"
DF_SCRIPTS_DIR="$(pwd)/scripts"
DF_NEW_DIR=
DF_TEST_MODE_ENGAGE="${DF_NEW_DIR}"

# Check for test mode
if [[ "${1}" = "--test" ]]; then
    export DF_TEST_MODE="HELL_YEAH"
    DF_NEW_DIR="$(pwd)/test"
else
    export DF_TEST_MODE="HELL_NAW"
    DF_NEW_DIR="${HOME}"
fi

# Source the dotfiles functions
source ${DF_SCRIPTS_DIR}/util_functions.sh

# The basics
df_testwrap df_mklink ${DF_FILES_DIR}/bashrc            ${DF_NEW_DIR}/.bashrc
df_testwrap df_mklink ${DF_FILES_DIR}/zshrc             ${DF_NEW_DIR}/.zshrc
df_testwrap df_mklink ${DF_FILES_DIR}/michael_theme.zsh ${DF_NEW_DIR}/.michael_theme.zsh
df_testwrap df_mklink ${DF_FILES_DIR}/bash_aliases      ${DF_NEW_DIR}/.bash_aliases
df_testwrap df_mklink ${DF_FILES_DIR}/profile           ${DF_NEW_DIR}/.profile
df_testwrap df_mklink ${DF_FILES_DIR}/dircolors         ${DF_NEW_DIR}/.dircolors
df_testwrap df_mklink ${DF_FILES_DIR}/shell_common      ${DF_NEW_DIR}/.shell_common
df_testwrap df_mklink ${DF_FILES_DIR}/tmux.conf         ${DF_NEW_DIR}/.tmux.conf

# Golang. Duh.
if [ ! -d ${HOME}/go_workspace ]; then
    gospace=${HOME}/go_workspace
    df_testwrap mkdir -p ${gospace}/src
    df_testwrap mkdir -p ${gospace}/bin
    df_testwrap mkdir -p ${gospace}/pkg
fi

apt-cache policy golang | grep -i "installed" | grep -i "none" &> /dev/null
aptgo=$?

test -d /opt/go &> /dev/null
optgo=$?

if [ $? -ne 0 ]; then
    echo "You really need to install go."
fi

# Vim
if [[ -e $(which vim) ]]; then
    df_testwrap df_mklink ${DF_FILES_DIR}/vimrc ${DF_NEW_DIR}/.vimrc
    echo "Vim is already installed."
else
    sudo apt-get install vim && echo "Vim installed."
    df_testwrap df_mklink ${DF_FILES_DIR}/vimrc ${DF_NEW_DIR}/.vimrc
    exit 1
fi

unset -v DF_TEST_MODE
unset -v DF_NEW_DIR
unset -v DF_SCRIPTS_DIR
unset -v DF_FILES_DIR
