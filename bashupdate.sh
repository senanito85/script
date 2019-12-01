#!/usr/bin/env bash

for f in *; do
    if [ "${#f}" -eq 3 ]; then
    #if [ -d ${f} -eq 5 ]; then

        #echo $f
        #chage -d 0 $f
        echo "exec /home/bravura/.bash_profile-vicsuper" >> /home/$f/.bash_profile

    fi
done
