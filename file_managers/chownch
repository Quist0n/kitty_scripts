#!/bin/sh
#Little shell script change the owner of all files and subdirectories in a directory.

#Just run the script, give the new owner you want to set (e.g john)
# and the directory you wish for it to act on, or none to use the current working directory

DIR=$2

[ -z $DIR  ] && DIR=$(pwd)

find "$DIR" -exec sudo chown "$1" -c "{}" +;
