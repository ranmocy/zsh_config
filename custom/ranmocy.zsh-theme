# Two lines promot, with RVM and Git support
# Better with my iTerm color scheme
#
# Mar 2015 - May 2020, Ranmocy

# See if we can use colors.
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
    eval PR_$color='%{$fg_bold[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg_no_bold[${(L)color}]%}'
done
PR_RESET_COLOR="%{$reset_color%}"

# Use Unicode to format layout
PR_HBAR="$(echo -e "\u2500")"
PR_ULCORNER="$(echo -e "\u250c")"
PR_URCORNER="$(echo -e "\u2510")"
PR_LLCORNER="$(echo -e "\u2514")"
PR_LRCORNER="$(echo -e "\u2518")"
PR_MOE="(～￣▽￣)～"
# PR_MOE="ʕ•̫͡•ʔ"
PR_SHRUG="¯\_(ツ)_/¯"
# Use `echo -n ▽ | hexdump` to get the escaped hex code
# PR_MOE="$(echo -e "\x28\xef\xbd\x9e\xef\xbf\xa3\xe2\x96\xbd\xef\xbf\xa3\x29\xef\xbd\x9e")"
PR_RETURN_CODE="%(?..%{$PR_RED%}%?%{$PR_RESET_COLOR%})"
PR_TIME="%D{%H:%M:%S %b %d}"

# Config Git Prompt
ZSH_THEME_GIT_PROMPT_PREFIX="$PR_GREEN"
ZSH_THEME_GIT_PROMPT_SUFFIX="$PR_RESET_COLOR"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$PR_RED%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %{$PR_YELLOW%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %{$PR_YELLOW%}↑"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=" %{$PR_YELLOW%}↕"

# Decide if we need to set titlebar text.
case $TERM in
    xterm*)
        PR_TITLEBAR_FORMAT=$'%{\e]0;$(title_prompt_info)\a%}'
        PR_STITLE=''
        ;;
    screen)
        PR_TITLEBAR_FORMAT=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~  | %y\e\\%}'
        PR_STITLE=$'%{\ekzsh\e\\%}'
        ;;
    *)
        PR_TITLEBAR_FORMAT=''
        PR_STITLE=''
        ;;
esac

# Dynamic parts placeholder
PR_TEMPLATE1="${PR_ULCORNER}${PR_HBAR}()()${PR_HBAR}${PR_URCORNER}"
PR_TEMPLATE2="${PR_LLCORNER}${PR_HBAR}()${PR_HBAR}>"
PR_FILLBAR_DYNAMIC_FORMAT=""
PR_PWD_DYNAMIC=""
PR_USER_DYNAMIC=""
PR_HOST_AT_DYNAMIC=""
PR_HOST_DOMAIN_DYNAMIC=""
PR_GIT_DYNAMIC=""
PR_VERSIONS_DYNAMIC=""
PR_MOE_DYNAMIC=""

# Need this to expand parameters in the prompt template
setopt prompt_subst

# Finally, the prompt.
PROMPT='\
$PR_STITLE${(e)PR_TITLEBAR_FORMAT}\
$PR_BLUE$PR_ULCORNER$PR_HBAR\
($PR_YELLOW$PR_PWD_DYNAMIC$PR_BLUE)\
$PR_LIGHT_YELLOW$PR_VERSIONS_DYNAMIC\
$PR_BLUE${(e)PR_FILLBAR_DYNAMIC_FORMAT}\
($PR_LIGHT_BLUE$PR_USER_DYNAMIC$PR_GREY$PR_HOST_AT_DYNAMIC$PR_GREEN$PR_HOST_DOMAIN_DYNAMIC$PR_BLUE)\
$PR_HBAR$PR_URCORNER\

$PR_LLCORNER$PR_HBAR\
($PR_GIT_DYNAMIC$PR_BLUE)\
$PR_HBAR\
$PR_MOE_DYNAMIC>\
$PR_RESET_COLOR'

# display exitcode on the right when >0
RPROMPT='\
$PR_RETURN_CODE\
$PR_BLUE($PR_YELLOW$PR_TIME$PR_BLUE)\
$PR_HBAR$PR_LRCORNER\
$PR_RESET_COLOR'

PS2='\
$PR_CYAN$PR_HBAR\
$PR_BLUE$PR_HBAR\
($PR_LIGHT_GREEN%_$PR_BLUE)$PR_HBAR\
$PR_CYAN$PR_HBAR$PR_RESET_COLOR'

function pwd_prompt_info {
    echo "%~"
}

function title_prompt_info {
    echo "%(!.-=*[ROOT]*=- | .)%n@%m:%~ | %y"
}

# Load all dynamic infomation
function _prompt_load_dynamic_info {
    PR_FILLBAR_DYNAMIC_FORMAT=""
    PR_PWD_DYNAMIC="$(pwd_prompt_info)"
    PR_USER_DYNAMIC="%(!.%SROOT%s.%n)"
    PR_HOST_AT_DYNAMIC="@"
    PR_HOST_DOMAIN_DYNAMIC="%m:%l"
    PR_MOE_DYNAMIC="%(?.${PR_MOE:s/)/%)/}.${PR_SHRUG:s/)/%)/})"
    PR_GIT_DYNAMIC="$(git_prompt_info)$(git_remote_status)"
    PR_VERSIONS_DYNAMIC=""
    if [[ -n "$rvm_path" ]]; then
        PR_VERSIONS_DYNAMIC="${PR_VERSIONS_DYNAMIC}r`rvm_prompt_info`"
    elif [[ -n "$rbenv_path" ]]; then
        PR_VERSIONS_DYNAMIC="${PR_VERSIONS_DYNAMIC}rb(`current-rbenv-info`)"
    fi
    if [[ -n "$NVM_LOADED" ]]; then
        PR_VERSIONS_DYNAMIC="${PR_VERSIONS_DYNAMIC}n(`nvm_prompt_info`)"
    fi
}

# Calculate sizes and shrink info as needed
function _prompt_layout_dynamic_info {

    local zero='%([BSUbfksu]|([FK]|){*})'

    # Calc sizes
    local TERMWIDTH=$(( $COLUMNS - 1 ))
    local templatesize=${#${(%)PR_TEMPLATE1//$~zero/}}
    local pwdsize=${#${(S%%)PR_PWD_DYNAMIC//$~zero/}}
    local versionsize=${#${(S%%)PR_VERSIONS_DYNAMIC//$~zero/}}
    local usersize=${#${(S%%)PR_USER_DYNAMIC//$~zero/}}
    local hostall="$PR_HOST_AT_DYNAMIC$PR_HOST_DOMAIN_DYNAMIC"
    local hostsize=${#${(S%%)hostall//$~zero/}}
    local gitsize=${#${(S%%)PR_GIT_DYNAMIC//$~zero/}}
    local moesize=${#${(S%%)PR_MOE//$~zero/}}
    local shrugsize=${#${(S%%)PR_SHRUG//$~zero/}}
    # use the longest between PR_MOE and PR_SHRUG
    local kaosize=$(( moesize > shrugsize ? moesize : shrugsize ))

    # First line
    # Full info => remove host => remove user => remove versions => shrink pwd
    if [[ "$templatesize + $pwdsize + $versionsize + $usersize + $hostsize" -gt $TERMWIDTH ]]; then
        # remove @host
        PR_HOST_AT_DYNAMIC=""
        PR_HOST_DOMAIN_DYNAMIC=""
        hostsize=0
    fi
    if [[ "$templatesize + $pwdsize + $versionsize + $usersize" -gt $TERMWIDTH ]]; then
        # remove user
        PR_USER_DYNAMIC=""
        usersize=0
    fi
    if [[ "$templatesize + $pwdsize + $versionsize" -gt $TERMWIDTH ]]; then
        # remove versions
        PR_VERSIONS_DYNAMIC=""
        versionsize=0
    fi
    if [[ "$templatesize + $pwdsize" -gt $TERMWIDTH ]]; then
        # shrink pwd
        PR_PWD_DYNAMIC="%$(($TERMWIDTH - $templatesize - $versionsize))<...<%~%<<"
        pwdsize=${#${(%):-${PR_PWD_DYNAMIC}}}
    fi
    PR_FILLBAR_DYNAMIC_FORMAT="\${(l.(($TERMWIDTH - ($templatesize + $pwdsize + $versionsize + $usersize + $hostsize)))..${PR_HBAR}.)}"

    # Second line
    local templatesize=${#${(%)PR_TEMPLATE2//$~zero/}}
    local gitmin=10
    local TERMWIDTH3=$(($TERMWIDTH / 3))

    if [[ "$templatesize + $gitsize + $kaosize" -gt $TERMWIDTH3 ]]; then
        # remove kaomoji
        PR_MOE_DYNAMIC=""
    fi
    if [[ "$templatesize + $gitsize" -gt $TERMWIDTH3 ]]; then
        if [[ "$templatesize + $gitmin" -gt $TERMWIDTH3 ]]; then
            # remove git prompt
            PR_GIT_DYNAMIC=""
        else
            # shrink git prompt
            local restsize=$(($TERMWIDTH3 - $templatesize))
            local gitsize=$(( $restsize > $gitmin ? $restsize : $gitmin ))
            PR_GIT_DYNAMIC="%$gitsize>...>$PR_GIT_DYNAMIC%<<"
        fi
    fi
}

autoload -U add-zsh-hook

function _prompt_precmd {
    benchmark _prompt_load_dynamic_info
    benchmark _prompt_layout_dynamic_info
}
# precmd is triggered right before the prompt is about to be shown
add-zsh-hook precmd _prompt_precmd

if [[ "$TERM" == "screen" ]]; then
    function _screen_title {
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -n "\ek$CMD\e\\"
    }

    setopt extended_glob
    # preexec() is triggered right before an command is about to be executed
    add-zsh-hook preexec _screen_title
fi
