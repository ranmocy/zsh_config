function confirm() {
    # /usr/bin/read -p "${1:- [y/N]} " response
    read response\?"$1 [y/N] "
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

function wiki() {
    dig +short txt $1.wp.dg.cx;
}

# CPU MEM info
function cpu() {
    local num=10;
    if [ ! -z $1 ]; then num=$1; fi
    ans=`ps -eo pcpu,pid,args | sort -r | head -$num | sed '/%CPU/d' | sed 's/\/Applications\///g' | sed 's/\/Utilities\///g' | sed 's/\/Contents.*//g' | sed 's/\/System\/Library\/Frameworks\///g'| sed 's/\.framework.*/\.framework/g'| sed 's/\/System\/Library\/PrivateFrameworks\///g'`
    echo $ans
}
function mem() {
    local num=10;
    if [ ! -z $1 ]; then num=$1; fi
    ans=`ps -eo pmem,pid,args | sort -r | head -$num | sed '/%MEM/d' | sed 's/\/Applications\///g' | sed 's/\/Utilities\///g' | sed 's/\/Contents.*//g' | sed 's/\/System\/Library\/Frameworks\///g'| sed 's/\.framework.*/\.framework/g'| sed 's/\/System\/Library\/PrivateFrameworks\///g'`
    echo $ans
}

# Pretty UI
function mountt() {
    ans=`(echo "DEVICE PATH TYPE FLAGS" && mount )| sed 's/map /map::/g' | sed 's/on//g' | column -t`
    echo $ans
}

function listtask() {
    if [ -z $1 ]; then
        echo "USAGE: listtask PROGRAM_NAME"
        return 127
    fi
    ps aux | grep -v grep | grep -i $1
}

function listkill() {
    if [ -z $1 ]; then
        echo "USAGE: listkill PROGRAM_NAME [SIGNAL]"
        return 127
    fi

    if [[ -z $2 ]]; then
        local sig=3
    else
        local sig=$2
    fi

    echo "kill $1 with signal $sig."
    (listtask $1 | awk '{print $2}' | xargs kill -s $sig) && listtask $1
}

function bak() {
    if [[ -z $1 ]]; then
        echo "USAGE: bak FILENAME"
        echo "This will cp FILENAME to FILENAME.bak"
        return 127
    fi

    cp -i $1 $1.bak
}

function telephone() {
    if [[ -z $1 ]]; then
        echo "USAGE: telephone REMOTEHOST"
        echo "This will give you a telephone via SSH."
        return 127
    fi

    rec -t wav - | ssh $1 play -t wav
}

function httpserver() {
    local host=$2;
    local port=$1;
    if [[ -z $1 ]]; then
        port="3000"
    fi
    if [[ -z $2 ]]; then
        host='localhost'
    fi
    echo "Server will be started at http://$host:$port"
    # Python2 only
    # python -c "import BaseHTTPServer as bhs, SimpleHTTPServer as shs; bhs.HTTPServer(('$host', $port), shs.SimpleHTTPRequestHandler).serve_forever()" 2>/dev/null &

    # Python3 only
    # python3 -m http.server $port --bind $host

    # 2 or 3
    python -m $(python -c 'import sys; print("http.server" if sys.version_info[:2] > (2,7) else "SimpleHTTPServer")') $port --bind $host
}

function replaceall() {
    if [[ -z $3 ]]; then
        echo "USAGE: $0 FILE_PATTERN OLD_PATTERN NEW_STRING"
        echo "This will replace lines matches OLD_PATTERN to NEW_STRING in all files matches FILE_PATTERN."
        return 127
    fi

    local file_pattern=$1;
    local old_pattern=$2;
    local new_string=$3;

    find . -type f -name "$1" -exec sed -i "s/$2/$3/g" {} +
    # grep -rl "$2" "$1" | xargs sed -i "s/$2/$3/g"
}

function logapp() {
    local package=$1;
    adb logcat | grep `adb shell ps | grep $package | cut -c10-15`
}
