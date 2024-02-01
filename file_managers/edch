#!/bin/sh
#Little shell script to make all directories and subdirectories in a
#given directory have certain permissions on them

#Just run the script, give the directory permissions you want to set (e.g 0700)
# and the directory you wish for it to act, or none to use the current working
# directory

DIR=$2

[ -z $DIR  ] && DIR=$(pwd)

find "$DIR" -type d -exec chmod "$1" -c "{}" +;
