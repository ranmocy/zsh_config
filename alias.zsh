# System Alias
alias ls="ls -G -F" #macos
#alias ls="ls --color=auto" #linux
alias l="ls -l"
alias la="ls -a"
alias ll="ls -al"
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'
alias grep='grep --colour=auto'
alias g='git'
alias t='tmuxinator'
alias emacs="/usr/local/Cellar/emacs/24.1/bin/emacs -nw"
alias emacsclient="/usr/local/Cellar/emacs/24.1/bin/emacsclient -t"
alias e="emacs"
alias ec="emacsclient -a ''"

# Path Alias //进入相应的路径时只要 cd ~xxx
hash -d gitcafe='/Users/ranmocy/codes/gitcafe/'
hash -d memo='/Users/ranmocy/Documents/Memories/'

# zsh alias
alias history_top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias cpu10='ps aux | sort -nr -k 3 | head -10'
alias mem10='ps aux | sort -nr -k 4 | head -10'
alias topcpu='top -F -R -o cpu'
alias topmem='top -F -R -o reg'
alias listtask='ps aux | grep'
alias lt='listtask'
alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias record="ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/out.mpg"
alias mountt="(echo \"DEVICE PATH TYPE FLAGS\" && mount | awk '\$2=\"\";1') | column -t"


alias checkmail="curl -u ranmocy@gitcafe.com --silent \"https://mail.google.com/mail/feed/atom\" | perl -ne 'print \"Subject: $1 \" if /<title>(.+?)<\/title>/ && $title++;print \"(from $1)\n\" if /<email>(.+?)<\/email>/; '"
