#!/bin/bash
USERNAME="sam"
SCRIPT="hostname; date"

for HOSTNAME in `cat hosts.list`
do
   ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done
exit 0
