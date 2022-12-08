#!/bin/bash

ifes="$(ip -o -4 route show to default | awk '{print $5}')";

apt-get update
apt-get install -y wget nano dante-server netcat

mv /etc/danted.conf /etc/danted.conf.bak
danteconf='logoutput: /tmp/socks.log
internal: 0.0.0.0 port = CCCCCCC
external: AAAAAAA
socksmethod: username
user.privileged: root
user.notprivileged: nobody

client pass {
 from: 0.0.0.0/0 to: 0.0.0.0/0
 log: error connect disconnect
 }
 
client block {
 from: 0.0.0.0/0 to: 0.0.0.0/0
 log: connect error
 }
 
socks pass {
 from: 0.0.0.0/0 to: 0.0.0.0/0
 log: error connect disconnect
 command: bind connect udpassociate
 }
 
socks pass {
 from: 0.0.0.0/0 to: 0.0.0.0/0
 log: error connect disconnect
 command: bindreply udpreply
 }
 
socks block {
 from: 0.0.0.0/0 to: 0.0.0.0/0
 log: connect error
 }
'
echo -e "${danteconf}" > /etc/danted.conf

touch /tmp/socks.log
sed -i "s/AAAAAAA/${ifes}/g" /etc/danted.conf
sed -i "s/CCCCCCC/990/g" /etc/danted.conf

systemctl enable danted
systemctl start danted