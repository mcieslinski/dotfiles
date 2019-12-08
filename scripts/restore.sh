#!/bin/bash
FILES_DIR="$(pwd)/files"
SCRIPTS_DIR="$(pwd)/scripts"
TEST_DIR="$(pwd)/test"

# Source the dotfiles functions
source ${SCRIPTS_DIR}/util_functions.sh

# The basics
test -e ${TEST_DIR}/.bash_aliases.lb_bak && lb_bak -r ${TEST_DIR}/.bash_aliases.lb_bak
rm -f ${TEST_DIR}/.bash_aliases.lb_bak
test -e ${TEST_DIR}/.bashrc.lb_bak && lb_bak -r ${TEST_DIR}/.bashrc.lb_bak
rm -f ${TEST_DIR}/.bashrc.lb_bak
test -e ${TEST_DIR}/.profile.lb_bak && lb_bak -r ${TEST_DIR}/.profile.lb_bak
rm -f ${TEST_DIR}/.profile.lb_bak
test -e ${TEST_DIR}/.dircolors.lb_bak && lb_bak -r ${TEST_DIR}/.dircolors.lb_bak
rm -f ${TEST_DIR}/.dircolors.lb_bak
source ${TEST_DIR}/.bashrc
