#!/bin/bash
FILES_DIR="$(pwd)/files"
SCRIPTS_DIR="$(pwd)/scripts"
TEST_DIR="$(pwd)/test"

# Source the linux_base functions
source ${SCRIPTS_DIR}/util_functions.sh

# The basics
test -e ${TEST_DIR}/.bash_aliases && lb_bak ${TEST_DIR}/.bash_aliases
ln -s ${FILES_DIR}/bash_aliases ${TEST_DIR}/.bash_aliases
test -e ${TEST_DIR}/.bashrc && lb_bak ${TEST_DIR}/.bashrc
ln -s ${FILES_DIR}/bashrc ${TEST_DIR}/.bashrc
test -e ${TEST_DIR}/.profile && lb_bak ${TEST_DIR}/.profile
ln -s ${FILES_DIR}/profile ${TEST_DIR}/.profile
test -e ${TEST_DIR}/.dircolors && lb_bak ${TEST_DIR}/.dircolors
ln -s ${FILES_DIR}/dircolors ${TEST_DIR}/.dircolors
source ${TEST_DIR}/.bashrc

# Vim
if [[ -e '/usr/bin/vim' ]]; then
    ln -s ${FILES_DIR}/vimrc ${TEST_DIR}/.vimrc
else
    echo "Vim not found. Fix that shit."
    return 1
fi

# Guake
if [[ -e /usr/local/bin/guake ]]; then
    ln -s ${FILES_DIR}/guake ${TEST_DIR}/.gconf/schemas/apps/guake
    guake -q
    ( nohup guake & ) &> /dev/null
else
    echo "Guake not found. Dafuq you doin' without Guake, bro?"
    return 1
fi

unset -v SCRIPTS_DIR
unset -v FILES_DIR
