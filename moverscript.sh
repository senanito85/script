#!/bin/bash

###################################################################
#Script Name    : Archiving Script
#Description    : Script runs monthly and moves files older than one year from /u03/interface/ to archive folder.                                                 
#Date Created   : 15.06.2019
#Last Modified  : 15.06.2019
###################################################################

#find /u03/interface/inbound/biztalk/edi/cfwa/po -maxdepth 1 -mtime +500 -type f -exec ls -l {} \;
#find /u03/interface/inbound/biztalk/edi/cfwa/po -maxdepth 1 -mtime +500 -type f -exec mv --verbose "{}" /tmp/biztalk >> /tmp/moverlogs.log \;


echo "Start copying files $(date)" >> /var/log/filearchivelogs.log

find /u03/interface/inbound/biztalk/edi/cfwa/po/ -maxdepth 1 -mtime +365 -type f -exec mv --verbose "{}" /u05/archive/inbound/biztalk/edi/cfwa/po >> /var/log/filearchivelogs.log \;

find /u03/interface/outbound/finance/auspost/ -maxdepth 1 -mtime +365 -type f -exec mv --verbose "{}" /u05/archive/outbound/finance/auspost >> /var/log/filearchivelogs.log \;

#find /u03/interface/inbound/finance/daily-banking/6909/  -maxdepth 1 -mtime +365 -type f -exec mv --verbose "{}" /u05/archive/inbound/finance/daily-banking/6909 >> /var/log/filearchivelogs.log \;














