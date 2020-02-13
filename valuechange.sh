#!/bin/bash
USER="username"
PASWOD="somepassword"

for test in `cat ips.list`
do
  HOST=`echo $test |awk -F, '{print $1}'`
  IP=`echo $test |awk -F, '{print $2}'`
  sshpass -p "$PASWOD" ssh -l "${USER}" -q -o StrictHostKeyChecking=no -p 22 "${HOST}" "
sed -i 's/"222,700-702"/"80-88"/g' /etc/sysconfig/network-scripts/ifcfg-cloudbr0
sed -i 's/"cloudbr 702"/"cloudbr 84"/g' /etc/sysconfig/network-scripts/ifcfg-publicbr0
sed -i 's/"cloudbr 701"/"cloudbr 88"/g' /etc/sysconfig/network-scripts/ifcfg-storagebr0
systemctl restart network"
done
exit 0
