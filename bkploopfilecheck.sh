#!/bin/bash

echo "APPBINS Archival Started"

# Defining variables
SRCTFLDR=/jmsbins/CMS/
DSTFLDR=/jmsbins/APP/

echo "APP Bin Archival Completed"

echo "copy job completed"

# check if the archive is successfully delivered to AWS S3
SRCFILE=$(basename $DSTFLDR/apparchive_today.txt)
DSTFILE=$(basename $SRCFLDR/apparchive_today.txt)

#DSTFILE=$(aws s3 ls s3://cgl-filestore/apparchive_$today.tar.gz | awk '{print $4}')


until [ -e /jmsbins/APP/apparchive_today.txt ]; do
    echo "apparchive_today.txt doesn't exist as of yet..."
    sleep 1
done

echo "apparchive_today.txt now exists!!!"
sleep 1

if [ $SRCFILE == $DSTFILE ]; then

   echo "Both files are exist and in place"
else
   echo "Something went wrong"
fi

exit 0

