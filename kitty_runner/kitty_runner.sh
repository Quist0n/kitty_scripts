#!/bin/sh
PRESET_FILE="$XDG_CONFIG_HOME/kitty_runner/presets";
MESSAGE="Loading preset";
MENU_COMMAND="dmenu"
MODE="normal_mode"
ARGS=""

err(){
        echo "$1"; exit 1
}

prep(){
        sed '/^#.*$/d;' "$1"
}

dmenu_mode(){
        DET=$(prep "$PRESET_FILE" | $MENU_COMMAND | sed 's/;\s*#.*$//');
        echo "$MESSAGE $DET" "$@";
}

normal_mode(){
        DET=$( prep "$PRESET_FILE" | fzf | sed 's/;\s*#.*$//');
}

if [ "$1" ]; then
while [ "$1" ]; do
        case "$1" in
                --dmenu-mode | -d )
                        MODE="dmenu_mode"; shift;;
                --normal-mode | -n )
                        MODE="normal_mode"; shift;;
                -p | --preset-file )
                        shift;
                        if [ ! -e "$1" ]; then
                                err "Presets file $1 does not exist"

                        else
                                PRESET_FILE="$1"
                                shift

                        fi
                        ;;

                * )
                        ARGS="$ARGS $1";
                        shift;;

        esac
done
fi

echo "Using Presets file: $PRESET_FILE"
$MODE
if [ -z "$DET" ]; then
        printf "Please select a preset";
else
        eval exec $DET $ARGS;
fi
