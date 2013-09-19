export EDITOR="emacsclient -t -a 'vim'"
export SHELL="/bin/zsh"

# Path
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=$HOME/bin:$PATH
# export PATH=$HOME/.rbenv/bin:$PATH
PATH="$HOME/Library/Haskell/bin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# GitCafe ENV
export RAILS_ENV="development"
export GITCAFE_SERVER="localhost"
export HTTP_OR_HTTPS="http"
export MONGOID_HOST="localhost"
export MONGOID_DATABASE="git_cafe_development"

# Boost Ruby
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

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

# Rbenv
# eval "$(rbenv init -)"

# RVM init
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Highlight command
source $HOME/.zshrc.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#==========CUSTOMS==========##
# As a word
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# Extend Math [SLOW]
# zmodload zsh/mathfunc
# autoload -U zsh-mime-setup
# zsh-mime-setup

#[Esc][h] short man
alias run-help >&/dev/null && unalias run-help
autoload run-help
