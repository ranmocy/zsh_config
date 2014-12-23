# System Alias
# alias ls="ls -G -F" #macos
alias ls="ls --color=auto -hF" #coreutils or linux
alias l="ls -l"
alias la="ls -a"
alias ll="ls -al"
#alias cp='cp -i'
#alias mv='mv -i'
#alias rm='rm -i'
alias grep='grep --colour=auto' #coreutils or linux

alias b='brew'
alias bup='brew update && brew outdated && brew upgrade && brew cleanup'
alias g='git'
#alias t='trash'
alias e="emacs -nw"
alias et="emacsclient -t -a 'vim'"
alias ec="emacsclient -c --no-wait -a 'vim'"
alias gc='env -u RAILS_ENV bundle exec guard -c'
alias lt='listtask'
alias lk='listkill'

alias mp='mosh gitcafe@gitcafe.com'
alias ms='mosh gitcafe@gitcafe.staging'
alias sshproxy='ssh -TfnND 4444 gitcafe@gitcafe.staging'

# Path Alias //进入相应的路径时只要 cd ~xxx
hash -d code="$HOME/Codespace/"
hash -d work="$HOME/Codespace/Works"
hash -d test="$HOME/Codespace/Tests"
hash -d hosted="$HOME/Codespace/Hosted"
hash -d usaco="$HOME/Codespace/USACO/"
hash -d brain="$HOME/Codespace/Brain/"
hash -d gitcafe="$HOME/Codespace/Works/GitCafe"
hash -d guard-rails="$HOME/Codespace/Hosted/guard-rails"

# zsh alias
alias history_top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias topcpu='top -F -R -o cpu'
alias topmem='top -F -R -o reg'
alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias record="ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/out.mpg"
