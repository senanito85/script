#!/bin/bash

for i in `cat users.txt`; do useradd -d "/home/$i" $i ; echo "$i@123" | passwd $i --stdin; done


# Usernames from users.txt"
#---------------------------------

mae
keh
ctm
jkk
wbs
ccp
jxm
mxc
mdc
sbb
lxu
jxb
dxh
axd
kxp
pyk
bxh
bza
eyh
sxk
szl
dap
ryf
dlh
exk
lxf
gxn
rzr
jxz
ggs
lyh
sxb
ixg
