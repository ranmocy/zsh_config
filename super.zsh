# Prompt
export LC_TIME=POSIX
source ~/.zshrc.d/functions/update-current-git-info.zsh
source ~/.zshrc.d/functions/current-git-branch-status.zsh
source ~/.zshrc.d/jonathan.zsh

# RVM init
[[ -s "/Users/ranmocy/.rvm/scripts/rvm" ]] && source "/Users/ranmocy/.rvm/scripts/rvm"

# Alias
unalias gs
unalias ls
source ~/.zshrc.d/alias.zsh



# Calculator
arith-eval-echo() {
    LBUFFER="${LBUFFER}echo \$(( "
    RBUFFER=" ))$RBUFFER"
}
zle -N arith-eval-echo
bindkey "\e\e" arith-eval-echo

# Extend Math 
zmodload zsh/mathfunc
autoload -U zsh-mime-setup
zsh-mime-setup

#[Esc][h] man 当前命令时，显示简短说明
alias run-help >&/dev/null && unalias run-help
autoload run-help

user-complete() {
    case $BUFFER in
        "" )                       # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd --" )                  # "cd --" 替换为 "cd +"
            BUFFER="cd +"
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd +-" )                  # "cd +-" 替换为 "cd -"
            BUFFER="cd -"
            zle end-of-line
            zle expand-or-complete
            ;;
        * )
            zle expand-or-complete
            ;;
    esac
}
