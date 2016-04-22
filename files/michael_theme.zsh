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
            echo ${git_status} | grep "rebas" &> /dev/null
            if [ $? -ne 0 ]; then
                bname="%F{red}DETACHED: %f%F{yellow}${bname/*detached at /}%f%F{yellow}"
            else
                bname="%F{red}DETACHED: %f%F{yellow}rebasing"
            fi
        else
            bname=$(git symbolic-ref --short -q HEAD)
            echo $git_status | grep -i "up-to-date" &> /dev/null
            if [ $? -ne 0 ]; then
                bstatus=" - $(echo $git_status | grep -i "Your branch" | grep -Eio "(ahead|behind|diverged)")"
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
    
    #echo "%7"
    last_cmd="$(history | tail -n 1 | awk '{ printf $1":" }')$history[$[HISTCMD-1]]"
    psvar[7]="$last_cmd"
    print "$last_cmd"
}

PROMPT='%B%F{blue}$(get_pwd)%f%F{yellow}>%f%b '

#PROMPT='%B%F{red}%n%f%b%B%F{magenta} -- %f%b%B%F{blue}$(get_pwd)%f%b%B%F{magenta} -- %f%b%B%F{yellow}{$(get_git)}%f%b%B%F{magenta} -- %f%b%B%F{green}%(?..%S)[$(get_last_cmd)]%(?..%s)%f%b
#> '
