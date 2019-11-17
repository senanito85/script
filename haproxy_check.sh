#!/bin/bash

if killall -0 haproxy > /dev/null 2>&1; then
        rm -f /usr/local/bin/HAPROXYFAILED
elif [ ! -e /usr/local/bin/HAPROXYFAILED ]; then
        systemctl start haproxy
        sleep 5
        if ! killall -0 haproxy > /dev/null 2>&1; then
                printf %b "Subject: [`hostname`] Unable to start HAProxy service
                Hi,\n
                The HAProxy service has failed and is unable to start.\n\n
                This may provide more information:\n
                \n
                `systemctl status haproxy`\n\n
                Regards,\n
                Root" | /usr/sbin/sendmail -f root@`hostname` sibrahimov@asta.com.au
                touch /usr/local/bin/HAPROXYFAILED
        fi
fi

