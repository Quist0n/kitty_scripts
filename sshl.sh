#!/bin/sh

## Author: Qurtin
# This is a small script to read from a file so that I don't have to copy-paste the address of ssh servers....so I guess I am addicted to SSH
# and Linux and bash and scripting at this point.

# Change the FILE variable pointing to the file containing the ssh command you want to execute
# E.G you want to connect to a server on port 11 and the address is 10.13.12.2 and the user is bob you would put:
#   bob@10.13.12.2 -p 11;
# and so on in that same format with all your ssh servers.

# If you wish to specify additional options for the ssh to use, simply specify them when you run the script and they will be added in
# Be sure not to make contradictions or specify an option twice by accident, since this will cause issues. The options in the file and the
# options specified on the command-line are not checked in anyway so it may break a few things and ssh may be very angry with you.

# If you want to add comments,
# put a semicolon at the end of your server listing and then a # symbol followed by your comment.
# This is good for naming servers to remember them. These are single-line ONLY! 
# Do be careful to not put ; or # in your comment as well, has been proven to break string manipulation

FILE="$HOME/.ssh_hosters";
MESSAGE="Connecting to SSH server with command: ssh";

cat -n $FILE;
read -r INPUT;

DET=$(sed -n "$INPUT"p "$FILE" | sed 's/;\s*#.*// g');
echo "$MESSAGE $DET" "$@";
ssh $@ $DET;
