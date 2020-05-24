# confirm function

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
