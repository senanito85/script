#!/bin/bash
USER="someusername"
PWD="somepassword"
for host in `cat hosts.list`
do
   sshpass -p "${PWD}" ssh -t -q -o StrictHostKeyChecking=no  "${USER}@${host}" \
### Commands go here
         'echo "some text here iteration 3" >> /tmp/testfile; \
          cat /tmp/testfile; \
          hostname; \
          date;'
done
exit 0
