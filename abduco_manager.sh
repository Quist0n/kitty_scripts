#!/bin/bash
#Making the config file requires that you specify key-value pairs. E.g ssh_script=<your ssh script>.
MODE=$1;
NAME="abduco_manager"
CONFIG_FILE="$HOME/.$NAME.conf";
HELP_MESSAGE="Usage: $NAME [-l|-h]\n\tabduco_manger.sh -s SESSION_NAME SSH_OPTIONS\n\t$NAME -a SESSION_NAME\n\tMODES:\n\t\t--ssh | -s, Use abduco to connect via SSH. Using ssh_script variable in $CONFIG_FILE\n\t\t--help | -h, Print this help screen, also comes up if a mode is not specified.\n\t\t--list | -l, List all abduco sessions.\n\t\t--attach | -a, Attach to an existing session";

if [ -f "$CONFIG_FILE" ]; then
        SSH_SCRIPT=$(grep -E "ssh_script" "$CONFIG_FILE"| sed "s/^.*=//g");
else
        echo "Please consider making a config file at $CONFIG_FILE";
        SSH_SCRIPT="ssh";
fi

[ "$MODE" = "--ssh" ] || [ "$MODE" = "-s" ] && exec abduco -c "$2" "$SSH_SCRIPT" ${@:3};
[ "$MODE" = "--attach" ] || [ "$MODE" = "-a" ] && exec abduco -a "$2";
[ "$MODE" = "--list" ] || [ "$MODE"  = "-l" ] && exec abduco;
[ "$MODE" = "--help" ] || [ "$MODE" = "-h" ] || [ -z "$MODE" ] && echo -e "$HELP_MESSAGE";
