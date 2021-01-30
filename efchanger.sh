#!/bin/sh
#Little shell script to make all files in a directory and all its subdirectories no longer have

#Just run the script, give the file mode you want to give (e.g 0700)
# and the directory you wish for it to act

find "$2" -type f -name "*" -exec chmod "$1" -c "{}" +;
