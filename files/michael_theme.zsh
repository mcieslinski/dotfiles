#!/usr/bin/zsh

setopt promptsubst

function get_pwd()
{
    echo "${PWD/$HOME/~}"
}

function get_git()
{
    local git_status
    local git_status_p
    # Name of branch
    local bname
    # Status of local version (behind/ahead/current)
    local bstatus
    # Number of changed files
    local bnfiles
    git status &> /dev/null
    
    if [ $? -eq 0 ]; then
        git_status=$(git status)
        git_status_p=$(git status --porcelain)
        bname=$(echo $git_status|grep "On branch")
        if [ $? -ne 0 ]; then
            bname=$(echo $git_status|grep "detached")
            bname="%F{red}DETACHED: %f%F{yellow}${bname/*detached at /}%f%F{yellow}"
        else
            bname=$(git symbolic-ref --short -q HEAD)
            echo $git_status | grep -i "up-to-date" &> /dev/null
            if [ $? -ne 0 ]; then
                bstatus=" - $(echo $git_status | grep -i "Your branch" | grep -Eio "(ahead|behind)")"
            fi
            
            bnfiles=$(git status --porcelain | wc -l)
            if [ $bnfiles -ne 0 ]; then
                if [ $bnfiles -eq 1 ]; then
                    bnfiles=" - %F{red}${bnfiles} change%f"
                else
                    bnfiles=" - %F{red}${bnfiles} changes%f"
                fi
            else
                bnfiles=""
            fi
        fi
    else
        bname=''
        bstatus=''
        bnfiles=''
    fi

    echo "${bname}${bstatus}${bnfiles}%F{yellow}"
}

function get_last_cmd()
{
    local last_cmd
    last_cmd=$(history | tail -n 1)
    last_cmd=${last_cmd:1}
    last_cmd=${last_cmd/  /:}
    echo "${last_cmd}"
}

PROMPT='%B%F{red}%n%f%b%B%F{magenta} -- %f%b%B%F{blue}$(get_pwd)%f%b%B%F{magenta} -- %f%b%B%F{yellow}{$(get_git)}%f%b%B%F{magenta} -- %f%b%B%F{green}%(?..%S)[$(get_last_cmd)]%(?..%s)%f%b
> '
