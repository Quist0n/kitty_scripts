#!/bin/sh
#Little shell script to make all files in a directory and its subdirectories set to have certain file permissions

#Just run the script, give the file mode you want to set (e.g 0700)
# and the directory you wish for it to act on, or none to use the current working directory

DIR=$2

[ -z $DIR  ] && DIR=$(pwd)

find "$DIR" -type f -exec chmod "$1" -c "{}" +;
