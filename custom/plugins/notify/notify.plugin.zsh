# Show notification
#
# Dependence:
# * Mac OS X: terminal-notifier
#
# Usage:
# notify message [title] [urgency]

function _notify-echo() {
  local msg
  msg=""
  [[ "x$2" != "x" ]] && msg+="$2: "
  msg+="$1"
  echo $msg
}

function _notify-terminal-notifier() {
  local args
  args=(-message "$1")
  [[ "x$2" != "x" ]] && args+=(-title "$2")
  terminal-notifier $args >/dev/null 2>&1
}

function _notify-notify-send() {
  # -u, --urgency=LEVEL               Specifies the urgency level (low, normal, critical).
  # -t, --expire-time=TIME            Specifies the timeout in milliseconds at which to expire the notification.
  # -a, --app-name=APP_NAME           Specifies the app name for the icon
  # -i, --icon=ICON[,ICON...]         Specifies an icon filename or stock icon to display.
  # -c, --category=TYPE[,TYPE...]     Specifies the notification category.
  # -h, --hint=TYPE:NAME:VALUE        Specifies basic extra data to pass. Valid types are int, double, string and byte.
  [[ "x$3" == "x" ]] && 3="normal"
  notify-send --urgency="$3" --expire-time=1000 --app-name="$2" -- "$1" >/dev/null 2>&1
}

alias notify=_notify-echo
case `uname -s` in
  Darwin)
    if [[ $(whence terminal-notifier) != "" ]]; then
      alias notify=_notify-terminal-notifier
    fi
    ;;
  Linux)
    if [[ $(whence notify-send) != "" ]]; then
      alias notify=_notify-notify-send
    fi
    ;;
esac
