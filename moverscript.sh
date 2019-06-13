#!/bin/bash

###################################################################
#Script Name	: Archiving Script                                                                                            
#Description	: Script runs monthly and moves files older than one year from /u03/interface/ to archive folder.                               
#Author       	: Sanan Ibrahimov                                                
#Date Created 	: 15.06.2019
#Last Modified  : 15.06.2019                                
###################################################################

# to find and delete. Legacy.
#find /u03/interface/inbound/biztalk/edi/cfwa/po -maxdepth 1 -mtime +500 -type f -exec ls -l {} \;
#find /u03/interface/inbound/biztalk/edi/cfwa/po -maxdepth 1 -mtime +500 -type f -exec mv --verbose "{}" /tmp/biztalk >> /tmp/moverlogs.log \;


echo "Start copying files $(date)" >> /tmp/moverlogs.log

find /u03/interface/inbound/biztalk/edi/cfwa/po/ -maxdepth 1 -mtime +365 -type f -exec mv --verbose "{}" /sys/fs/cgroup/sys/fs/cgroup/inbound/biztalk/edi/cfwa/po >> /tmp/moverlogs.log \;

find /u03/interface/outbound/finance/auspost/ -maxdepth 1 -mtime +365 -type f -exec mv --verbose "{}" //sys/fs/cgroup/sys/fs/cgroup/outbound/finance/auspost >> /tmp/moverlogs.log \;

find /u03/interface/inbound/finance/daily-banking/6909/  -maxdepth 1 -mtime +365 -type f -exec mv --verbose "{}" /sys/fs/cgroup/sys/fs/cgroup/inbound/finance/daily-banking/6909 >> /tmp/moverlogs.log \;


