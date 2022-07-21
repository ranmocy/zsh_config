# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR="s"
fi

# Android
export ANDROID_SDK_ROOT=$HOME/Android/Sdk/

# Color utils
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
# export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # black background

# History
export HISTSIZE=10000 #历史纪录条目数量
export SAVEHIST=10000 #注销后保存的历史纪录条目数量
export HISTFILE=~/.zsh_history #历史纪录文件
setopt INC_APPEND_HISTORY #以附加的方式写入历史纪录
setopt HIST_IGNORE_DUPS #如果连续输入的命令相同，历史纪录中只保留一个
setopt EXTENDED_HISTORY #为历史纪录中的命令添加时间戳
setopt AUTO_PUSHD #启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt PUSHD_IGNORE_DUPS #相同的历史路径只保留一个
setopt HIST_IGNORE_SPACE #在命令前添加空格，不将此命令添加到纪录文件中

# As a word
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# Extend Math [SLOW]
# zmodload zsh/mathfunc
# autoload -U zsh-mime-setup
# zsh-mime-setup

#[Esc][h] short man
# alias run-help >&/dev/null && unalias run-help
# autoload run-help

# Double-ESC for Calculator
# arith-eval-echo() {
#     LBUFFER="${LBUFFER}echo \$(( "
#     RBUFFER=" ))$RBUFFER"
# }
# zle -N arith-eval-echo
# bindkey "\e\e" arith-eval-echo

# ls after cd
chpwd() {
    l
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
