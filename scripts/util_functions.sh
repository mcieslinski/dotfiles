#!/bin/bash
lb_bak()
{
    if [[ "${1}" = "-r" ]]; then
        restored_file="${2%%.lb_bak}"
        if [[ -e ${2} ]]; then
            test -e ${restored_file} && echo rm ${restored_file}
            test -e ${2} && echo mv ${2} ${restored_file}
        else
            echo "Neither ${2} nor ${restored_file} exist? This is pretty much not possible unless you fucked with the code or the files."
            echo "Unfuck whatever you fucked and try this again."
            echo "A git checkout of the repo or specific files might do it. I don't know. I don't know what you did."
        fi
    else
        if [[ -e ${1} ]]; then
            test -e "${1}.lb_bak"
            test $? -ne 0 && echo mv ${1} "${1}.lb_bak"
        else
            echo "${1} does not exist. This is pretty much not possible unless you fucked with the code or the files."
            echo "Unfuck whatever you fucked and try this again."
            echo "A git checkout of the repo or specific files might do it. I don't know. I don't know what you did."
        fi
    fi
}

lb_noterm()
{
    (nohup $@ &) &> /dev/null
}

lb_testwrap()
{
    if [[ "${LB_TEST_MODE}" = "HELL_YEAH" ]]; then
        echo $@
    else
        $@
    fi
}

lb_mklink()
{
    if [[ -e ${2} ]]; then
        if [[ -L ${2} ]]; then
            echo "A link already exists for ${2}. Delete it? (y/n):"
            read deleteLink
            test "${deleteLink}" = "y" && rm ${2} && ln -s ${1} ${2}
        else
            lb_bak ${2}
            ln -s ${1} ${2}
        fi
    else
        ln -s ${1} ${2}
    fi
}

lb_unsource()
{
    unset -f lb_bak
    unset -f lb_noterm
    unset -f lb_unsource
}
