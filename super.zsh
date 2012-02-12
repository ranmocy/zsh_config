export PATH=/usr/local/bin:$PATH:/usr/local/Cellar/ruby/1.9.3-p0/bin:/usr/local/Cellar/git/1.7.9/bin

# Prompt
export LC_TIME=POSIX
source ~/.zshrc.d/functions/update-current-git-info.zsh
source ~/.zshrc.d/functions/current-git-branch-status.zsh
source ~/.zshrc.d/jonathan.zsh

# History
export HISTSIZE=10000 #历史纪录条目数量
export SAVEHIST=10000 #注销后保存的历史纪录条目数量
#export HISTFILE=~/.zhistory #历史纪录文件
setopt INC_APPEND_HISTORY #以附加的方式写入历史纪录
setopt HIST_IGNORE_DUPS #如果连续输入的命令相同，历史纪录中只保留一个
setopt EXTENDED_HISTORY #为历史纪录中的命令添加时间戳
setopt AUTO_PUSHD #启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt PUSHD_IGNORE_DUPS #相同的历史路径只保留一个
setopt HIST_IGNORE_SPACE #在命令前添加空格，不将此命令添加到纪录文件中


# RVM init
[[ -s "/Users/ranmocy/.rvm/scripts/rvm" ]] && source "/Users/ranmocy/.rvm/scripts/rvm"
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

# Alias
unalias gs
unalias ls
source ~/.zshrc.d/alias.zsh

# As a word
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'


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

#[Esc][h] short man
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
zle -N user-complete
bindkey "\t" user-complete
