#!/bin/sh

#
# Mullvad switch
#

_main() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            -s) _NEW_SERVER="$2"; shift 2;;

            --server=*) _NEW_SERVER="${1#*=}"; shift 1;;
            
            --server)
                echo "$1 requires an argument" >&2; exit 1;;
            
            -*) echo "unknown option: $1" >&2; exit 1;;
            *) handle_argument "$1"; shift 1;;
        esac
    done

    if [ -z "$_NEW_SERVER" ]; then
        echo "New server missing" >&2; exit 1;
    fi

    _CURRENT_SERVER="$(ip -o link show | awk -F': ' '{print $2}' | grep mullvad)"

    pkexec <<EOF sh
        if [ ! -z "$_CURRENT_SERVER" ]; then
            systemctl stop wg-quick@$_CURRENT_SERVER.service
        fi

        systemctl start wg-quick@$_NEW_SERVER.service
EOF
}

_main $@

CURRENT_CONNECTION="$(ip -o link show | awk -F': ' '{print $2}' | grep mullvad)"
NEW_CONNECTION=
