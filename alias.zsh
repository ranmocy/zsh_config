# System Alias
alias ls="ls -G -F"
alias l="ls -al"
alias la="ls -a"
alias ll="ls -l"
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'
alias grep='grep --colour=auto'
alias e="emacs -nw"
alias ec='emacsclient -t'
alias g='git'

# Path Alias //进入相应的路径时只要 cd ~xxx
# hash -d E="/etc/"
# hash -d DC="/Users/ranmocy/Documents"
# hash -d DL="/Users/ranmocy/Downloads"

# zsh alias
# History Command TOP10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
