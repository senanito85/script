#!/bin/bash
#
# Compresses syslog files and archive
# Sanan Ibrahimov, Aug 2020

### Vars ###
#NFSLOGS=/var/log/remotesyslog/
NFSARCHIVE=/var/log/archive
ARCHIVE=syslog-$(date '+%Y-%m-%d').tar.gz
ARCHDIR="${NFSARCHIVE}/$(date '+%Y-%m-%d')"
LOGLOCATION=/var/log/remotesyslog
HS=`hostname`

### Log Delete function ###

function logdelfunc {
        echo "Value equals to One (1) and Logs got deleted (simulated)"
        # Actual delete will go here
        # find /var/log/remotesyslog -name "*.log" -type f -exec rm -f {} \;
        # find "${BACKUP_HOME}/${HOSTNAME}" -name "*.sql" -mtime +30 -type f -exec rm -f {} \;
        # find "${COPY_HOME}/${HOSTNAME}" -name "*.sql" -mtime +30 -type f -exec rm -f {} \;
        find "$ARCHDIR" -name "*.log" -type f -exec rm -f {} \;
}
###---------------------###

if [ $(/sbin/ip addr | grep -o '192.168.81.17') ]; then

      /bin/mkdir "$ARCHDIR"
      /bin/mv "$LOGLOCATION"/* "$ARCHDIR"

      cd "$ARCHDIR"
      # tar -zcvf "${ARCHIVE}" *
      # Do tar with cndition, 
      if tar -zcvf "${ARCHIVE}" *; then
            mv "${ARCHIVE}" ../
            logdelfunc
            echo "LOG ARCHIVAL SUCCESSFULL on  $(date '+%Y-%m-%d') "${NFSARCHIVE}/${ARCHIVE}" from ${HS} " >> /var/log/archival.log
      fi

else
      exit 1
fi

exit 0
