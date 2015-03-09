#!/bin/bash

# Personal aliases
alias rpro=". /home/michael/.profile"
alias rn="rename"
alias aliases="vim /home/michael/.bash_aliases; rpro"
alias qtcreator="noterm /opt/Qt5.4.0/Tools/QtCreator/bin/qtcreator.sh"
alias gedit="noterm /usr/bin/gedit"
alias makeroute="sudo route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0"
alias ccmake="cmake-gui"

# VICTORY aliases
export VICTORY_ROOT="/home/michael/VICTORY"
alias v="cd ${VICTORY_ROOT}"
alias vb="cd ${VICTORY_ROOT}/build/bin"
alias vbuild="cd ${VICTORY_ROOT}/build"
alias vs="cd ${VICTORY_ROOT}/src"
alias va="cd ${VICTORY_ROOT}/app"
export NAS="/mnt/VICTORY_SIL_NAS/"
alias nas="cd ${NAS}"
alias nascheck="ping -c 3 192.168.1.96"

# VECTOR aliases
export VECTOR_ROOT="/home/michael/VMSTUFF/vector"
alias ve="cd ${VECTOR_ROOT}"
alias vebuild="cd ${VECTOR_ROOT}/build"

function noterm()
{
    (nohup $@ &) &> /dev/null
}

function extract()
{
    nargs=$#;

    if [[ $# -ne 1 && $# -ne 2 ]]; then
        echo "Ya dun goofed. Usage: untar archive [directory]"
        return 1
    else
        filename=""
        filetype=""
        directory=""
        extractCommand=""

        echo $1 | grep -E "*\.tar\.gz" &> /dev/null && echo "Found gz!" && filename=$1 && filetype="z" && extractCommand="tar -${filetype}xf"
        echo $1 | grep -E "*\.tgz" &> /dev/null && echo "Found gz!" && filename=$1 && filetype="z" && extractCommand="tar -${filetype}xf"
        echo $1 | grep -E "*\.tar\.bz2" &> /dev/null && echo "Found bz2!" && filename=$1 && filetype="j" && extractCommand="tar -${filetype}xf"
        echo $1 | grep -E "*\.tbz" &> /dev/null && echo "Found bz2!" && filename=$1 && filetype="j" && extractCommand="tar -${filetype}xf"
        echo $1 | grep -E "*\.zip" &> /dev/null && echo "Found zip!" && filename=$1 && filetype="zip" && extractCommand="unzip"
        
        if [[ "$filetype" != "z" && "$filetype" != "j" && "$filetype" != "zip" ]]; then
            echo "Ya dun goofed. No tar or zip found."
            return 1
        else
            if [[ $# -eq 2 ]]; then
                if [[ -d $2 ]]; then
                    if [[ "${filetype}" = "z" || "${filetype}" = "j" ]]; then
                        directory="-C ${2}"
                    else
                        directory="-d ${2}"
                    fi
                else
                    echo "Ya dun goofed. ${2} is not a valid directory."
                    return 1
                fi
            fi
            ${extractCommand} ${filename} ${directory}
        fi
    fi
}

vrun()
{
    if [[ -d ${VICTORY_ROOT} || "${2}" = "--force" ]]; then
        if [[ $# -ne 1 && $# -ne 2 && $# -ne 3 ]]; then
            echo "Wrong number of arguments.    Usage: vrun ServiceName [--force/--gdb]   Example: vrun AttributeStore"
            return 1
        else
            use_dir=${VICTORY_ROOT}
            debug_mode=
            go_back=0
            test "${2}" = "--force" -o "${3}" = "--force" && use_dir=$(pwd)
            test "${2}" = "--gdb" -o "${3}" = "--gdb" && debug_mode="gdb --args " 
            test "$(pwd)" != "${use_dir}" && cd ${use_dir} && go_back=1
            #test -d ${use_dir} && echo "Found VICTORY directory environment variable."

            service_name="build/bin/$(ls ./build/bin | grep "$1")"
            test -f $service_name; test $? -eq 1 && echo "${service_name} does not exist" && return 2
            service_cfg="cfg/$(ls ./cfg | grep "$1")"
            test -e $service_cfg; test $? -eq 1 && echo "${service_cfg} does not exist" && return 2
            service_vclid="cfg/VCLID/$(ls ./cfg/VCLID | grep "$1")"
            test -e $service_vclid; test $? -eq 1 && echo "${service_vclid} does not exist" && return 2
            $debug_mode $service_name $service_cfg $service_vclid
            #echo $debug_mode $service_name $service_cfg $service_vclid
            test $go_back -eq 1 && cd - &> /dev/null
        fi
    else
        echo "No VICTORY_ROOT environment variable defined. Please run export VICTORY_ROOT=\"path/to/VICTORY\""
        echo "Option 2: Navigate to your VICTORY directory and run with --force"
    fi
}

function bak()
{
    if [[ $# -ne 1 ]]; then
        echo "You're doing it wrong. Usage: bak <filename>"
    else
        cp ${1} "${1}.bak"
    fi
}

function unbak()
{
    if [[ $# -ne 1 ]]; then
        echo "You're doing it wrong. Usage: unbak <filename>.bak"
    else
        echo ${1} | grep ".bak" &> /dev/null
        
        if [[ $? -ne 0 ]]; then
            echo "You're doing it wrong. File doesn't have .bak."
        else
            mv ${1} "${1%.*}"
        fi
    fi
}

function vv()
{
    theCommand=""
    firstLoop=0
    firstFile=""

    for i in $(ls *.cpp); do
        if [[ $firstLoop -eq 0 ]]; then
            firstLoop=1

            if [[ -e "${i%%.*}.h" ]]; then
                firstFile="e ${i%%.*}.h|vs|e ${i}|"
            elif [[ -e "../../../include/${i%%.*}.h" ]]; then
                firstFile="e ../../../include/${i%%.*}.h|vs|e ${i}|"
            else
                firstFile="e ${i}|"
            fi
        else
            if [[ -e "${i%%.*}.h" ]]; then
                theCommand+="tabe ${i%%.*}.h|vs|e ${i}|"
            elif [[ -e "../../../include/${i%%.*}.h" ]]; then
                theCommand+="tabe ../../../include/${i%%.*}.h|vs|e ${i}|"
            else
                theCommand+="tabe ${i}|"
            fi
        fi
    done
    
    vim --cmd "${firstFile}${theCommand}echom \"OPEN LOL.\""

    return 0;
}


function far()
{
    if [[ $# -eq 0 ]]
    then
        echo "--- Rules of far() ---"
        echo "File search:"
        echo "    -Enter a filter like *.java"
        echo "In-file text search:"
        echo "    -Escape any \"/\"."
        echo "    -Escape any symbols interpreted by bash, such as \"\\\". ex: \"\\n\" must be entered as \"\\\\n\"."
        echo "Replace text:"
        echo "    -Escape any \"/\""
        echo "    -Escape any symbols interpreted by bash, such as \"\\\". ex: \"\\n\" must be entered as \"\\\\n\"."
        echo 
        echo "--- File search step ---"
        echo "File: "
        read first
        echo 
        echo "--- Search step ---"
        read second
        echo 
        echo "--- Replace step ---"
        read third
        echo
        echo "Command to be executed:"
        echo "find . -name \"${first}\" -exec sed -i \"s/${second}/${third}/g\" {} \\;"
        echo "Continue? (y/n)"
        read confirmation
        if [[ "${confirmation}" = y || "${confirmation}" = Y ]]; then
            find . -name "${first}" -exec sed -i "s/${second}/${third}/g" {} \;
        else
            echo "Exiting..."
            return 2;
        fi
    elif [[ $# -eq 3 ]]
    then
        find . -name "${1}" -exec sed -i "s/${2}/${3}/g" {} \;
        return 0
    else
        echo "far: Too few arguments."
        return 1
    fi
}
