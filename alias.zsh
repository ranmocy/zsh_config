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

alias g='git'
alias t='trash'
alias z="RAILS_ENV='' zeus"
alias e="emacs -nw"
alias et="emacsclient -t -a 'vim'"
alias ec="emacsclient -c -a 'vim'"
alias gc='env -u RAILS_ENV bundle exec guard -c'
alias lt='listtask'
alias lk='listkill'

alias mp='mosh gitcafe@gitcafe.com'
alias ms='mosh gitcafe@gitcafe.staging'

# Path Alias //进入相应的路径时只要 cd ~xxx
hash -d code='/Users/ranmocy/Codespace/'
hash -d work='/Users/ranmocy/Codespace/Works'
hash -d test='/Users/ranmocy/Codespace/Tests'
hash -d hosted='/Users/ranmocy/Codespace/Hosted'
hash -d brain='/Users/ranmocy/Documents/Brain/'
hash -d gitcafe='/Users/ranmocy/Codespace/Works/GitCafe'
hash -d guard-rails='/Users/ranmocy/Codespace/Hosted/guard-rails'

# zsh alias
alias history_top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias topcpu='top -F -R -o cpu'
alias topmem='top -F -R -o reg'
alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias record="ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/out.mpg"

alias checkmail="curl -u ranmocy@gmail.com --silent \"https://mail.google.com/mail/feed/atom\" | perl -ne 'print \"Subject: $1 \" if /<title>(.+?)<\/title>/ && $title++;print \"(from $1)\n\" if /<email>(.+?)<\/email>/; '"
