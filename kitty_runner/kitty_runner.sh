#!/bin/sh

FILE="$XDG_CONFIG_HOME/kitty_runner/presets";
MESSAGE="Loading preset";

dmenu_mode(){
        DET=$(cat "$FILE" | dmenu -l 5 -i -p "Choose program preset" | sed 's/;\s*#.*// g');
        echo "$MESSAGE $DET" "$@";
}

normal_mode(){
        cat -n $FILE;
        read -r INPUT;
        DET=$(sed -n "$INPUT"p "$FILE" | sed 's/;\s*#.*// g');
}
if [ "$1" ]; then
while [ "$1" ]; do
        case "$1" in
                --dmenu-mode )
                        dmenu_mode; shift;;
                * )
                        shift; break;;

        esac
done
else
        normal_mode
fi
if [ -z "$DET" ]; then
        printf "Plese select a preset";
else
        $DET $@
fi

