#!/bin/sh

PRESET_FILE="$XDG_CONFIG_HOME/kitty_runner/presets";
MESSAGE="Loading preset";
MENU_COMMAND="dmenu -l 5 -i"
MODE="normal_mode"
ARGS=""

err(){
        echo "$1"; exit 1
}

dmenu_mode(){
        DET=$(cat "$PRESET_FILE" | $MENU_COMMAND | sed 's/;\s*#.*// g');
        echo "$MESSAGE $DET" "$@";
}

normal_mode(){
        cat -n "$PRESET_FILE";
        read -r INPUT;
        DET=$(sed -n "$INPUT"p "$PRESET_FILE" | sed 's/;\s*#.*// g');
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
        printf "Plese select a preset";
else
        $DET $ARGS
fi
