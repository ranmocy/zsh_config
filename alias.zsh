# System Alias
#alias ls="ls -G -F" #macos
alias ls="ls --color=auto -hF" #coreutils or linux
alias l="ls -l"
alias la="ls -a"
alias ll="ls -al"
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'
alias grep='grep --colour=auto'

alias g='git'
alias t='tmuxinator'
alias z='zeus'
alias e="emacs -nw"
alias et="emacsclient -t -a ''"
alias ec="emacsclient -c -a ''"

# Path Alias //进入相应的路径时只要 cd ~xxx
hash -d code='/Users/ranmocy/Codespace/'
hash -d gitcafe='/Users/ranmocy/Codespace/Works/GitCafe'
hash -d brain='/Users/ranmocy/Documents/Brain/'

# zsh alias
alias history_top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias topcpu='top -F -R -o cpu'
alias topmem='top -F -R -o reg'
alias listtask='ps aux | grep -i'
alias lt='listtask'
alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias record="ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/out.mpg"

alias checkmail="curl -u ranmocy@gmail.com --silent \"https://mail.google.com/mail/feed/atom\" | perl -ne 'print \"Subject: $1 \" if /<title>(.+?)<\/title>/ && $title++;print \"(from $1)\n\" if /<email>(.+?)<\/email>/; '"
