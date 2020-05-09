#!/bin/bash

## Author: Qurtin

# This is a small script to read from a file so that I don't have to copy-paste the address of ssh servers....so I guess I am addicted to SSH
# and linux and bash and scripting at this point. 

# Change the FILE variable pointing to the file containing the ssh command you want to execute
# E.G you want to connect to a server on port 11 and the address is 10.13.12.2 and the user is bob you would put:
#   bob@10.13.12.2 -p 11 
# and so on in that same format with all your ssh servers. 

FILE="$HOME/.ssh_hosters"
COUNT=1
DET=""
while read -r CUR_LINE 
        do echo "$COUNT:::$CUR_LINE";
            ((COUNT++))
done < "$FILE"
COUNT=1
read -r INPUT
MATCH="^[abcdefghijklmnopqrstuvwxyz]$/i"
if ! [[ $INPUT =~ $MATCH ]]
    then 
        while read -r CUR_LINE
            do 
              if [ "$COUNT" -eq "$INPUT" ]
                then 
                    DET=$CUR_LINE
              fi
              ((COUNT++))

        done < "$FILE"
else 
   exit 
fi
exec ssh "$DET"
