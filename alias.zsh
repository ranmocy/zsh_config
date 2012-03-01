# System Alias
alias ls="ls -G -F"
alias l="ls -al"
alias la="ls -a"
alias ll="ls -l"
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'
alias grep='grep --colour=auto'
alias g='git'
alias e="/usr/local/Cellar/emacs/HEAD/bin/emacs -nw"
alias ec="/usr/local/Cellar/emacs/HEAD/bin/emacsclient -t -a '/usr/local/Cellar/emacs/HEAD/bin/emacs --daemon && /usr/local/Cellar/emacs/HEAD/bin/emacsclient -t'"
alias emacs="/usr/local/Cellar/emacs/HEAD/bin/emacs"

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
