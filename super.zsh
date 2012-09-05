# Path
export PATH=~/Codespace/bin:$PATH
# export PATH=$PATH:/usr/local/Cellar/ruby/1.9.3-p0/bin
# export PATH=$PATH:/usr/local/Cellar/git/1.7.9.1/libexec/git-core
# export PATH=$PATH:/usr/local/Cellar/emacs/HEAD/bin
# for d in /usr/bin/*; do
#     if [ -d $d ]; then
#         PATH+=":$d"
#     fi
# done

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

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export EDITOR="emacsclient -c -a 'vim'"
export SHELL="/bin/zsh"

# RVM init
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

#==========CUSTOMS==========##
# Functions
source ~/.zshrc.d/functions.zsh

# Alias
source ~/.zshrc.d/alias.zsh

# Prompt
export LC_TIME=POSIX
source ~/.zshrc.d/jonathan.zsh

#==========SETUPS==========#
# As a word
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# Extend Math
zmodload zsh/mathfunc
autoload -U zsh-mime-setup
zsh-mime-setup

#[Esc][h] short man
alias run-help >&/dev/null && unalias run-help
autoload run-help
