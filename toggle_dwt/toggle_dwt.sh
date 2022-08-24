#!/bin/sh
APPNAME="Toggle DWT"
TOUCHPAD_REGEX='[Tt]ouch[pP]ad'
DWT_REGEX='[Dd]isable\s+[Ww]hile\s+[Tt]yping\s+[Ee]nabled'
ENABLE_DWT_MESSAGE="Disable while typing set to on"
DISABLE_DWT_MESSAGE="Disable while typing set to off"
TOUCHPAD_ID=$(xinput list --short | awk "/$TOUCHPAD_REGEX/ {print};" | grep -o 'id=[[:digit:]]*' | sed 's/id=//g')
DWT_ID=$(xinput list-props $TOUCHPAD_ID | awk "/$DWT_REGEX/" | grep -o '[[:digit:]]*' | awk 'NR==1{print $1}')
DWT_STATE=$(xinput list-props $TOUCHPAD_ID | awk "/$DWT_REGEX/" | grep -o '[[:digit:]]*' | awk 'NR==2{print $1}')

if [ $DWT_STATE = 0 ]; then
        NEW_DWT_STATE=1
        echo "$ENABLE_DWT_MESSAGE"
        notify-send -u low -a "$APPNAME" "$ENABLE_DWT_MESSAGE"
else

        NEW_DWT_STATE=0
        echo "$DISABLE_DWT_MESSAGE"
        notify-send -u low -a "$APPNAME" "$DISABLE_DWT_MESSAGE"
fi

xinput set-prop $TOUCHPAD_ID $DWT_ID $NEW_DWT_STATE
