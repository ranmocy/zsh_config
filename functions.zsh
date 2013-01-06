wiki() { dig +short txt $1.wp.dg.cx; }

# ls after cd
function chpwd() {
    emulate -L zsh
    ls -al
}

# Git
current-git-branch-status () {
    update-current-git-info
    if [ -n "$__CURRENT_GIT_BRANCH" ]; then
        local s="$PR_GREEN$__CURRENT_GIT_BRANCH$PR_LIGHT_BLUE"
        case "$__CURRENT_GIT_BRANCH_STATUS" in
            ahead)
                s+="↑"
                ;;
            diverged)
                s+="↕"
                ;;
            behind)
                s+="↓"
                ;;
        esac
        if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
            s+="⚡"
        fi
        echo "$s$PR_NO_COLOUR"
    fi
}

update-current-git-info () {
    unset __CURRENT_GIT_BRANCH
    unset __CURRENT_GIT_BRANCH_STATUS
    unset __CURRENT_GIT_BRANCH_IS_DIRTY

    local st="$(git status 2>/dev/null)"
    if [[ -n "$st" ]]; then
        local -a arr
        arr=(${(f)st})

        if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
            __CURRENT_GIT_BRANCH='no-branch'
        else
            __CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
        fi

        if [[ $arr[2] =~ 'Your branch is' ]]; then
            if [[ $arr[2] =~ 'ahead' ]]; then
                __CURRENT_GIT_BRANCH_STATUS='ahead'
            elif [[ $arr[2] =~ 'diverged' ]]; then
                __CURRENT_GIT_BRANCH_STATUS='diverged'
            else
                __CURRENT_GIT_BRANCH_STATUS='behind'
            fi
        fi

        if [[ ! $st =~ 'nothing to commit' ]]; then
            __CURRENT_GIT_BRANCH_IS_DIRTY='1'
        fi
    fi
}

sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line                 #光标移动到行末
}

# auto fillin cd
user-complete () {
    case $BUFFER in
        "" )                       # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;
        * )
            zle expand-or-complete
            ;;
    esac
}
zle -N user-complete
bindkey "\t" user-complete

# Calculator
arith-eval-echo() {
    LBUFFER="${LBUFFER}echo \$(( "
    RBUFFER=" ))$RBUFFER"
}
zle -N arith-eval-echo
bindkey "\e\e" arith-eval-echo

# CPU MEM info
cpu() {
    local num=10;
    if [ ! -z $1 ]; then num=$1; fi
    ans=`ps -eo pcpu,pid,args | sort -r | head -$num | sed '/%CPU/d' | sed 's/\/Applications\///g' | sed 's/\/Utilities\///g' | sed 's/\/Contents.*//g' | sed 's/\/System\/Library\/Frameworks\///g'| sed 's/\.framework.*/\.framework/g'| sed 's/\/System\/Library\/PrivateFrameworks\///g'`
    echo $ans
}
mem() {
    local num=10;
    if [ ! -z $1 ]; then num=$1; fi
    ans=`ps -eo pmem,pid,args | sort -r | head -$num | sed '/%MEM/d' | sed 's/\/Applications\///g' | sed 's/\/Utilities\///g' | sed 's/\/Contents.*//g' | sed 's/\/System\/Library\/Frameworks\///g'| sed 's/\.framework.*/\.framework/g'| sed 's/\/System\/Library\/PrivateFrameworks\///g'`
    echo $ans
}

# Pretty UI
mountt() {
    ans=`(echo "DEVICE PATH TYPE FLAGS" && mount )| sed 's/map /map::/g' | sed 's/on//g' | column -t`
    echo $ans
}
