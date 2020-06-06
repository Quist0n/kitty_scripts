#!/bin/bash

## Author: Qurtin
# This is a small script to read from a file so that I don't have to copy-paste the address of ssh servers....so I guess I am addicted to SSH
# and linux and bash and scripting at this point.

# Change the FILE variable pointing to the file containing the ssh command you want to execute
# E.G you want to connect to a server on port 11 and the address is 10.13.12.2 and the user is bob you would put:
#   bob@10.13.12.2 -p 11;
# and so on in that same format with all your ssh servers. If you want to add comments,
# put a semicolon at the end of your server listing and then a # symbol followed by your comment.
# This is good for naming servers to remember them. These are single-line ONLY! 
# Do be careful to not put ; or # in your comment as well, has been proven to break string manipulation

FILE="$HOME/.ssh_hosters"
#while loop which taking in the FILE var and prints to the screen
cat -n $FILE
read -r INPUT
#var to use to make sure the INPUT is not a letter
MATCH="^[abcdefghijklmnopqrstuvwxyz]$/i"
 ! [[ $INPUT =~ $MATCH ]]
        DET=$(sed --regex -n "$INPUT"p "$FILE" | sed --regex -e 's/;\s*.*#.*// g') && exec ssh $DET
