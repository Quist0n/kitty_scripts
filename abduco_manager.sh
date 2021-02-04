#!/bin/bash
#Making the config file requires that you specify key-value pairs. E.g ssh-script=<your ssh script>.

NAME="abduco_manager"
CONFIG_FILE="$HOME/.config/$NAME/$NAME.conf";
HELP_MESSAGE="Usage: $NAME [-l|-h]\n\t$NAME.sh -s [SESSION_NAME] [SSH_OPTIONS]\n\t$NAME -a [SESSION_NAME]\n\tMODES:\n\t\t--ssh | -s, Use abduco to connect via SSH. Using ssh-script variable in $CONFIG_FILE\n\t\t--help | -h, Print this help screen, also comes up if a mode is not specified.\n\t\t--list | -l, List all abduco sessions.\n\t\t--attach | -a, Attach to an existing session\n";

if [ -f "$CONFIG_FILE" ]; then
        SSH_SCRIPT=$( sed "s/^ssh-script=//g" $CONFIG_FILE );
else
        printf "Please consider making a config file at $CONFIG_FILE";
        SSH_SCRIPT="ssh";
fi

#[ "$MODE" = "--ssh" ] || [ "$MODE" = "-s" ] && exec abduco -c "$2" "$SSH_SCRIPT" ${@:3};
#[ "$MODE" = "--attach" ] || [ "$MODE" = "-a" ] && exec abduco -a "$2";

#[ "$MODE" = "--help" ] || [ "$MODE" = "-h" ] || [ -z "$MODE" ] && echo -e "$HELP_MESSAGE";


while [ "$1" ]; do
        case "$1" in
                --help | -h)
                        printf "$HELP_MESSAGE" ; exit 0 ;;
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
