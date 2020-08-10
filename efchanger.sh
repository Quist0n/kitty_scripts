#!/bin/sh
#Little shell script to make all files in a directory and all its subdirectories no longer have
#execute permissions, this is good for large media folders. Just run the script and all the files
#will no longer be executable. The script has issues with directories and files with spaces in
#them, so replace them with underscores (_). 

#Just run the script in the directory and you wish for it to act on and then you are okay.

FIL=$(find . -type f -name "*"); for LINE in $FIL; do chmod -c -x $LINE; done;
