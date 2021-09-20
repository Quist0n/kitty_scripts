#!/bin/bash
#Making the config file requires that you specify key-value pairs. E.g ssh-script=<your ssh script>.

NAME="abduco_manager"
CONFIG_FILE="$HOME/.config/$NAME/$NAME.conf";

usage() {
cat <<- _end_help_message
Usage:  $NAME [-l|-h]
        $NAME.sh -s [SESSION_NAME] [SSH_OPTIONS]
        $NAME -a [SESSION_NAME]
        MODES:
                --ssh | -s, Use abduco to connect via SSH. Using ssh-script variable in $CONFIG_FILE
                --help | -h, Print this help screen, also comes up if a mode is not specified.
                --list | -l, List all abduco sessions.
                --attach | -a, Attach to an existing session
_end_help_message
}

if [ -f "$CONFIG_FILE" ]; then
        SSH_SCRIPT=$( sed "s/^ssh-script=//g" $CONFIG_FILE );
else
        printf "Please consider making a config file at $CONFIG_FILE";
        SSH_SCRIPT="ssh";
fi

while [ "$1" ]; do
        case "$1" in
                --help | -h)
                        usage ; exit 0 ;;
                --attach | -a)
                        shift
                        exec abduco -a "$1" ;;
                --ssh | -s)
                        shift
                        exec abduco -c "$1" "$SSH_SCRIPT" "${@:2}" ;;
                --list | -l)
                        exec abduco && exit ;;
                *)
                        printf 'Flag does not found. Use --help or -h for usage info\n';
        esac
done
