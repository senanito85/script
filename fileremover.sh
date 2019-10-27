#!/bin/bash

echo Start
printf "%d\n" 13
printf "%s\n" Word
printf "Hello! Bash is wonderful.\n"
echo ""

USERS=`who | wc -l`
if [ $USERS -eq 0 ] ; then
    printf "No End Users are currently connected here, So the Script can continue \n"
else 
    echo "Cannot run as Users are logged in"
    exit 1
fi

printf "How many Archive files do you want to delete? "
read ARCHIVE_DAYS
USERNAME=$(whoami)
DATE=$(date)
printf "User $USERNAME asked to delete $ARCHIVE_DAYS archive files on $DATE \n" >> /home/sam/archmgmt.log

let TOPAF=$ARCHIVE_DAYS+1
files=$(ls -ltr /home/sam/archive/ | awk '{print $9}' | head -n $TOPAF)
printf "The following files will be deleted\n"
for file in $files; do
    #echo "$(basename "$file")"
    echo $file
    #rm -rf /home/sam/archive/$file
done

exit 0 # all is well
