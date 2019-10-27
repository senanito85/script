#!/bin/bash

echo "JMS Archival Started"

# Defining variables
SRCTFLDR=~/jmsbin/
DSTFLDR=~/PycharmProjects/scraper/AWSSCRIPT/
today=$(date '+%Y-%m-%d')

tar czvf $DSTFLDR/jmsarchive_$today.tar.gz  $SRCTFLDR
echo "Archival Completed"

# copy archive to S3 bucket
aws s3 cp $DSTFLDR/*.tar.gz s3://buckets/cgl-backup/test/

# wait 30 sec 
sleep 30

# check if the archive is successfully delivered to AWS S3 bucket
SRCFILE=$(basename DSTFLDR/jmsarchive_$today.tar.gz)
DSTFILE=$(aws s3 ls s3://cgl-filestore/jmsarchive_$today.tar.gz | awk '{print $4}')

# if copied file equals to destination file, aka "copy job was successfull", the delete Source file. Otherwise create log entry on failed job.
if [ $SRCFILE == $DSTFILE ]; then
   # rm $SRCFILE
   echo "Files are equal it will be removed"
else
   echo "Copy job was unsuccessfull on $today" > /var/log/weeklyarchiveal.log
   #echo "Copy job for jmsarchive_$today.tar.gz FAILED!" | mail -s "CGL AWS Backup Job Failed" sananib@cgl.com.au
fi

exit 0
