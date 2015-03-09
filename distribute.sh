#!/bin/bash
FILE_DIR=$(pwd)/files

# The basics
ln -s ${FILE_DIR}/bash_aliases ~/.bash_aliases
ln -s ${FILE_DIR}/bashrc ~/.bashrc
ln -s ${FILE_DIR}/profile ~/.profile
ln -s ${FILE_DIR}/dircolors ~/.dircolors
source ~/.bashrc

# Vim
if [[ -e '/usr/bin/vim' ]]; then
    ln -s ${FILE_DIR}/vimrc ~/.vimrc
else
    echo "Vim not found. Fix that shit."
    exit 1
fi

# Guake
if [[ -e /usr/local/bin/guake ]]; then
    ln -s ${FILE_DIR}/guake ~/.gconf/schemas/apps/guake
    guake -q
    ( nohup guake & ) &> /dev/null
    exit 0
else
    echo "Guake not found. Dafuq you doin' without Guake, bro?"
    exit 1
fi

unset -v FILE_DIR
