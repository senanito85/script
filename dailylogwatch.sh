#!/bin/bash

#Send general system info
logwatch --detail Low --mailto sibrahimov@ast.com --service all --range today

#Send logs via mail.
mailx -s "Logs From astrp01" -q /tmp/logfile.txt  sibrahimov@ast.com








#---------------------------------------------------------------------------------
# Config File
"/etc/logwatch/conf/logwatch.conf" 3L, 179C

# Local configuration options go here (defaults are in /usr/share/logwatch/default.conf/logwatch.conf)
MailFrom = logwatch@astrp01.ast.lan
MailTo = sibrahimov@ast.com


