# System Alias
alias l="ls -l"
alias la="ls -a"
alias ll="ls -al"
#alias cp='cp -i'
#alias mv='mv -i'
#alias rm='rm -i'

alias b='brew'
alias bup='brew update && brew outdated && brew upgrade --all && brew cleanup && brew cask cleanup'
alias g='git'
alias ga='g a'
alias gb='g b'
alias gl='g l'
alias gs='g s'
alias t='trash'
alias ta='tmux -CC attach'
alias tc='tmux -CC'
alias e="emacs -nw"
alias et="emacsclient -t -a 'vim'"
alias ec="emacsclient -c --no-wait -a 'vim'"
alias lt='listtask'
alias lk='listkill'

# Path Alias //进入相应的路径时只要 cd ~xxx
hash -d assign="$HOME/Codespace/Assignments/"
hash -d code="$HOME/Codespace/"
hash -d work="$HOME/Codespace/Works/"
hash -d test="$HOME/Codespace/Tests/"
hash -d hosted="$HOME/Codespace/Hosted/"
hash -d usaco="$HOME/Codespace/USACO/"
hash -d brain="$HOME/Codespace/Brain/"
hash -d guard-rails="$HOME/Codespace/Hosted/guard-rails/"

# zsh alias
alias history_top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias topcpu='top -F -R -o cpu'
alias topmem='top -F -R -o reg'
alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias record="ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/out.mpg"
alias sha1="shasum -a 1"
alias sha256="shasum -a 256"
