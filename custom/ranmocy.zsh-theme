# Two lines promot, with RVM and Git support
# Better with my iTerm color scheme
#
# Mar 2015, Ranmocy

function pwd_prompt_info {
    echo "%~"
}

function precmd {

    # Git info.
    ZSH_THEME_GIT_PROMPT_PREFIX="$PR_GREEN"
    ZSH_THEME_GIT_PROMPT_SUFFIX="$PR_NO_COLOUR"
    ZSH_THEME_GIT_PROMPT_DIRTY=" %{$PR_RED%}x"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
    ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %{$PR_YELLOW%}↓"
    ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %{$PR_YELLOW%}↑"
    ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=" %{$PR_YELLOW%}↕"


    # PROMPTS
    PR_TEMPLATE="--()()--"
    PR_FILLBAR=""
    PR_PWD="$(pwd_prompt_info)"
    # PR_RUBY="(`current-rbenv-info`)"
    PR_RUBY=`rvm_prompt_info`
    PR_USER="%(!.%SROOT%s.%n)"
    PR_HOST="$PR_GREY@$PR_GREEN%m:%l"

    # PR_GIT="$(git_prompt_info)"
    PR_GIT="$(git_prompt_info)$(git_remote_status)"
    PR_MOE="(～￣▽￣)～"
    PR_TIME="%D{%H:%M:%S %b %d}"

    # Calc sizes
    local TERMWIDTH=$(($COLUMNS-1))
    local templatesize=${#${(%):-${PR_TEMPLATE}}}
    local pwdsize=${#${(%):-${PR_PWD}}}
    local rubysize=${#${(%):-${PR_RUBY}}}
    local usersize=${#${(%):-${PR_USER}}}
    local hostsize=${#${(%):-"@%m:%l"}}

    local gitsize=${#${(%):-${PR_GIT}}}
    local moesize=${#${(%):-${PR_MOE}}}
    local timesize=${#${(%):-${PR_TIME}}}

    # Full info => remove host => remove user => shrink pwd
    if [[ "$templatesize + $pwdsize + $rubysize + $usersize + $hostsize" -lt $TERMWIDTH ]]; then
        # Full info
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($templatesize + $pwdsize + $rubysize + $usersize + $hostsize)))..${PR_HBAR}.)}"
    elif [[ "$templatesize + $pwdsize + $rubysize + $usersize" -lt $TERMWIDTH ]]; then
        # Remove @host
        PR_HOST=""
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($templatesize + $pwdsize + $rubysize + $usersize)))..${PR_HBAR}.)}"
    elif [[ "$templatesize + $pwdsize + $rubysize" -lt $TERMWIDTH ]]; then
        # remove user
        PR_HOST=""
        PR_USER=""
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($templatesize + $pwdsize + $rubysize)))..${PR_HBAR}.)}"
    else
        # shrink pwd
        PR_HOST=""
        PR_USER=""
        PR_PWD="%$(($TERMWIDTH - $templatesize - $rubysize))<...<%~%<<"
    fi

    local gitmin=10
    local TERMWIDTH3=$(($TERMWIDTH / 3))

    if [[ "$gitsize + $moesize" -lt $TERMWIDTH3 ]]; then
    elif [[ "$gitmin + $moesize" -lt $TERMWIDTH3 ]]; then
        PR_GIT="%$(($TERMWIDTH3 - $moesize))>...>$PR_GIT%<<"
    elif [[ "$gitmin" -lt $TERMWIDTH3 ]]; then
        PR_MOE=""
        PR_GIT="%$(($TERMWIDTH3))>...>$PR_GIT%<<"
    fi
}

setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
          local CMD=${1[(wr)^(*=*|sudo|-*)]}
          echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
        colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
        eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
        eval PR_LIGHT_$color='%{$terminfo[sgr0]$fg[${(L)color}]%}'
        (( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    ###
    # See if we can use extended characters to look nicer.

    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}


    ###
    # Decide if we need to set titlebar text.

    case $TERM in
        xterm*)
            PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
            ;;
        screen)
            PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
            ;;
        *)
            PR_TITLEBAR=''
            ;;
    esac


    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
        PR_STITLE=$'%{\ekzsh\e\\%}'
    else
        PR_STITLE=''
    fi


    ###
    # Finally, the prompt.

    UL_corner="$PR_SHIFT_IN$PR_ULCORNER$PR_HBAR$PR_SHIFT_OUT"
    LL_corner="$PR_SHIFT_IN$PR_LLCORNER$PR_HBAR$PR_SHIFT_OUT"
    UR_corner="$PR_SHIFT_IN$PR_HBAR$PR_URCORNER$PR_SHIFT_OUT"
    LR_corner="$PR_SHIFT_IN$PR_HBAR$PR_LRCORNER$PR_SHIFT_OUT"

    PROMPT='\
$PR_STITLE${(e)PR_TITLEBAR}\
$PR_SET_CHARSET\
$PR_BLUE$UL_corner\
($PR_YELLOW$PR_PWD$PR_BLUE)\
$PR_LIGHT_YELLOW$PR_RUBY\
$PR_BLUE$PR_SHIFT_IN${(e)PR_FILLBAR}$PR_SHIFT_OUT\
($PR_LIGHT_BLUE$PR_USER$PR_HOST$PR_BLUE)\
$UR_corner\

$LL_corner\
($PR_GIT$PR_BLUE)\
$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_MOE>\
$PR_NO_COLOUR'

    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
    RPROMPT='\
$PR_SHIFT_IN$return_code$PR_SHIFT_OUT\
$PR_BLUE($PR_YELLOW$PR_TIME$PR_BLUE)\
$LR_corner\
$PR_NO_COLOUR'

    PS2='\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR'
}

setprompt
