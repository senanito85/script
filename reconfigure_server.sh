#!/bin/bash
# Author: Sanan Ibrahimov
# Last Modified: 9/8/2017
# Purpose: To set critical settings after CentOS has been deployed via VMWare template

clear
echo ""
echo "  /****************\\"
echo "  |  Server Setup  |"
echo "  \\****************/"
echo ""
echo "To exit press CTRL + C"
echo "To skip past a question press ENTER"
echo ""

#HOSTNAME
echo "Please enter the new hostname of this server:"
read hostname
if [[ $hostname ]]; then
        hostname $hostname
        sed -i "s/destemail = root@localhost/destemail = root@$hostname/" /etc/fail2ban/jail.local
        echo "MailFrom = logwatch@$hostname" >> /etc/logwatch/conf/logwatch.conf
fi

#IP ADDRESS
echo ""
echo "Please enter the main IP address:"
read ipaddress
if [[ $ipaddress ]]; then
        echo "IPADDR=$ipaddress" >> /etc/sysconfig/network-scripts/ifcfg-eno16777984
fi
echo "Please enter the bitmask - ie 24:"
read ipmask
if [[ $ipmask ]]; then
        echo "PREFIX=$ipmask" >> /etc/sysconfig/network-scripts/ifcfg-eno16777984
fi
echo "Please enter the gateway IP address:"
read ipgateway
if [[ $ipgateway ]]; then
        echo "GATEWAY=$ipgateway" >> /etc/sysconfig/network-scripts/ifcfg-eno16777984
fi
if [[ $ipaddress || $ipmask || $ipgateway ]]; then
        systemctl restart network
fi

#DNS SERVERS
echo ""
echo "Please enter the primary DNS server:"
read dns1
if [[ $dns1 ]]; then
        echo "DNS1=$dns1" >> /etc/sysconfig/network-scripts/ifcfg-eno16777984
fi
echo "Please enter the secondary DNS server:"
read dns2
if [[ $dns2 ]]; then
        echo "DNS2=$dns2" >> /etc/sysconfig/network-scripts/ifcfg-eno16777984
fi
echo "Please enter any search domains/DNS suffixes:"
read searchdomain
if [[ $searchdomain ]]; then
        echo "DOMAIN=$searchdomain" >> /etc/sysconfig/network-scripts/ifcfg-eno16777984
fi
if [[ $dns1 || $dns2 || $searchdomain ]]; then
        systemctl restart network
fi

#SMTP SERVER
echo ""
echo "Please enter an SMTP relay \(leave blank to use MX lookup - send direct\):"
read smtp
if [[ $smtp ]]; then
        $string = "relayhost = $smtp"
        sed -i "s/#relayhostplaceholder/$string/" /etc/postfix/main.cf
        systemctl restart postfix
fi

# TIMEZONE
echo ""
echo "Please enter the timezone:"
echo "Possible values -"
timedatectl list-timezones | grep Australia
read timezone
if [[ $timezone ]]; then
        timedatectl set-timezone $timezone
fi

#ALERTS EMAIL ADDRESS
echo ""
echo "Please enter an email address to receive alerts from this server:"
read alertsemail
if [[ $alertsemail ]]; then
        sed -i "s/sender = root@localhost/sender = $alertsemail/" /etc/fail2ban/jail.local
        systemctl restart fail2ban
        echo "root: $alertsemail" >> /etc/aliases
        newaliases
fi
echo "Please enter an email address to receive logs from this server:"
read logsemail
if [[ $logsemail ]]; then
        echo "MailTo = $logsemail" >> /etc/logwatch/conf/logwatch.conf
fi

#SNMP
echo "Please enter the community string that the monitoring server will use:"
read snmpcommunity
if [[ $snmpcommunity ]]; then
        echo "rocommunity $snmpcommunity" > /etc/snmp/snmpd.conf
fi
echo "Please enter the location of this server -ie \'NDC IAAS Virtual\':"
read snmplocation
if [[ $snmplocation ]]; then
        echo "syslocation $snmplocation" >> /etc/snmp/snmpd.conf
fi
echo "Please enter the contact name for this server:"
read snmpcontact
if [[ $snmpcontact && $alertsemail ]]; then
        echo "syscontact $snmpcontact <$alertsemail>" >> /etc/snmp/snmpd.conf
fi
if [[ $snmpcommunity || $snmplocation || $snmpcontact ]]; then
        systemctl restart snmpd
fi

#ROOT PW
echo ""
passwd

#A-ADMIN PW
echo ""
passwd a-admin

#STOP THIS SCRIPT FROM RUNNING AGAIN
sed -i "s/\/bin\/bash \/usr\/local\/bin\/reconfigure_server.sh/#\/bin\/bash \/usr\/local\/bin\/reconfigure_server.sh/" ~/.bash_profile
clear

echo "Server configuration complete!"


