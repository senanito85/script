#!/bin/bash

echo "JMS Archival Started"

# Defining variables
SRCTFLDR=/jmsbin/
DSTFLDR=/PycharmProjects/scraper/AWSSCRIPT/
today=$(date '+%Y-%m-%d')

tar czvf $DSTFLDR/jmsarchive_$today.tar.gz  $SRCTFLDR
echo "Archival Completed"

# copy archive to S3 bucket
aws s3 cp $DSTFLDR/*.tar.gz s3://cgl-backup/

# wait 60 sec to wait till file appears in S3 
sleep 60

# check if the archive is successfully delivered to AWS S3 bucket
SRCFILE=$(basename DSTFLDR/jmsarchive_$today.tar.gz)
DSTFILE=$(aws s3 ls s3://cgl-filestore/jmsarchive_$today.tar.gz | awk '{print $4}')

# if copied file equals to destination file, aka "copy job was successfull", the delete Source file. Otherwise create log entry on failed job.
if [ $SRCFILE == $DSTFILE ]; then
   rm $SRCFILE
   echo "Files are equal it will be removed" > /var/log/weeklyarchiveal.log
else
   echo "Copy job was unsuccessfull on $today" > /var/log/weeklyarchiveal.log
   # send an email line to be added
fi

exit 0
