# System Alias
alias l="ls -lah"
alias la="ls -ah"
alias ll="ls -lah"
#alias cp='cp -i'
#alias mv='mv -i'
#alias rm='rm -i'

# define the open command
case "$OSTYPE" in
  darwin*)  ;;
  cygwin*)  alias open='cygstart' ;;
  linux*)
    if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then
      alias open='explorer.exe'
    else
      alias open='xdg-open'
    fi
  ;;
  msys*)    alias open='start ""' ;;
  *)        echo "Platform $OSTYPE not supported" ;;
esac

# Custom alias
alias b='brew'
alias bup="brew update && brew outdated && brew upgrade && brew cleanup"
alias nup="(type npm &> /dev/null) && npm -g upgrade"
alias up='configs_upgrade && (bup; nup;)'
alias g='git'
alias ga='g a'
alias gb='g b'
alias gl='g l'
alias gs='g s'
alias t='trash'
alias ta='tmux -CC attach'
alias tc='tmux -CC'
# alias e="emacs -nw"
# alias et="emacsclient -t -a 'vim'"
# alias ec="emacsclient -c --no-wait -a 'vim'"
alias lt='listtask'
alias lk='listkill'
# alias tzh='trans :zh'
alias history_top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias topcpu='top -F -R -o cpu'
alias topmem='top -F -R -o reg'
alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias record="ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/out.mpg"
alias sha1="shasum -a 1"
alias sha256="shasum -a 256"
alias jarsignature="jarsigner -verify -verbose -certs"
alias apksignature="~/Android/Sdk/build-tools/30.0.1/apksigner verify --print-certs"

# Path Alias //进入相应的路径时只要 cd ~xxx
hash -d code="$HOME/Code/"
hash -d pnm="$HOME/Code/pnm/"
hash -d meson="$HOME/Code/mesonfi/"
