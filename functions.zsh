function wiki() { dig +short txt $1.wp.dg.cx; }

# ls after cd
function chpwd() {
    # emulate -L zsh
    l
}

# replace strings in folder
function replace_all() {
    if [ ! -z $1 ] || [ ! -z $2 ]; then
        echo "USAGE: replace_all ORIGINAL_STRING NEW_STRING"
        exit 127
    fi
    grep -rl "$1" ./ | xargs sed -i "s/$1/$2/g"
}

# Rbenv
# current-rbenv-info() {
#   local version=$(rbenv version-name)
#   # local gemset=$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)
#   local gemset=$(rbenv gemset active 2&>/dev/null | head -n1)
#   if [ -z "$gemset" ]; then
#     echo "$version"
#   else
#     echo "$version@$gemset"
#   fi
# }

# Git
# current-git-branch-status () {
#     update-current-git-info
#     if [ -n "$__CURRENT_GIT_BRANCH" ]; then
#         case "$__CURRENT_GIT_BRANCH_STATUS" in
#             ahead)
#                 s="↑"
#                 ;;
#             diverged)
#                 s="↕"
#                 ;;
#             behind)
#                 s="↓"
#                 ;;
#         esac
#         if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
#             s+="?"
#         fi
#         echo "$PR_LIGHT_YELLOW$s$PR_GREEN$__CURRENT_GIT_BRANCH$PR_NO_COLOUR"
#     fi
# }

# update-current-git-info () {
#     unset __CURRENT_GIT_BRANCH
#     unset __CURRENT_GIT_BRANCH_STATUS
#     unset __CURRENT_GIT_BRANCH_IS_DIRTY

#     local st="$(git status 2>/dev/null)"
#     if [[ -n "$st" ]]; then
#         local -a arr
#         arr=(${(f)st})

#         if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
#             __CURRENT_GIT_BRANCH='no-branch'
#         else
#             __CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
#         fi

#         if [[ $arr[2] =~ 'Your branch is' ]]; then
#             if [[ $arr[2] =~ 'ahead' ]]; then
#                 __CURRENT_GIT_BRANCH_STATUS='ahead'
#             elif [[ $arr[2] =~ 'diverged' ]]; then
#                 __CURRENT_GIT_BRANCH_STATUS='diverged'
#             elif [[ $arr[2] =~ 'behind' ]]; then
#                 __CURRENT_GIT_BRANCH_STATUS='behind'
#             fi
#         fi

#         if [[ ! $st =~ 'nothing to commit' ]]; then
#             __CURRENT_GIT_BRANCH_IS_DIRTY='1'
#         fi
#     fi
# }

# CPU MEM info
function cpu() {
    local num=10;
    if [ ! -z $1 ]; then num=$1; fi
    ans=`ps -eo pcpu,pid,args | sort -r | head -$num | sed '/%CPU/d' | sed 's/\/Applications\///g' | sed 's/\/Utilities\///g' | sed 's/\/Contents.*//g' | sed 's/\/System\/Library\/Frameworks\///g'| sed 's/\.framework.*/\.framework/g'| sed 's/\/System\/Library\/PrivateFrameworks\///g'`
    echo $ans
}
function mem() {
    local num=10;
    if [ ! -z $1 ]; then num=$1; fi
    ans=`ps -eo pmem,pid,args | sort -r | head -$num | sed '/%MEM/d' | sed 's/\/Applications\///g' | sed 's/\/Utilities\///g' | sed 's/\/Contents.*//g' | sed 's/\/System\/Library\/Frameworks\///g'| sed 's/\.framework.*/\.framework/g'| sed 's/\/System\/Library\/PrivateFrameworks\///g'`
    echo $ans
}

# Pretty UI
function mountt() {
    ans=`(echo "DEVICE PATH TYPE FLAGS" && mount )| sed 's/map /map::/g' | sed 's/on//g' | column -t`
    echo $ans
}

function listtask() {
    if [ -z $1 ]; then
        echo "USAGE: listtask PROGRAM_NAME"
        return 127
    fi
    ps aux | grep -v grep | grep -i $1
}

function listkill() {
    if [ -z $1 ]; then
        echo "USAGE: listkill PROGRAM_NAME [SIGNAL]"
        return 127
    fi

    if [[ -z $2 ]]; then
        local sig=3
    else
        local sig=$2
    fi

    echo "kill $1 with signal $sig."
    listtask $1 | awk '{print $2}' | xargs kill -$sig
}

function bak() {
    if [[ -z $1 ]]; then
        echo "USAGE: bak FILENAME"
        echo "This will cp FILENAME to FILENAME.bak"
        return 127
    fi

    cp -i $1 $1.bak
}

function telephone() {
    if [[ -z $1 ]]; then
        echo "USAGE: telephone REMOTEHOST"
        echo "This will give you a telephone via SSH."
        return 127
    fi

    rec -t wav - | ssh $1 play -t wav
}

function httpserver() {
    local host=$2;
    local port=$1;
    if [[ -z $1 ]]; then
        port="8000"
    fi
    if [[ -z $2 ]]; then
        host='localhost'
    fi
    echo "Server will be started at http://$host:$port"
    python -c "import BaseHTTPServer as bhs, SimpleHTTPServer as shs; bhs.HTTPServer(('$host', $port), shs.SimpleHTTPRequestHandler).serve_forever()" 2>/dev/null &
}
