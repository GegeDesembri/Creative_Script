#!/bin/bash
pid_now="$$"
mkdir /tmp/$pid_now
mount -o bind /tmp/$pid_now /proc/$pid_now
rm -rf /tmp/$pid_now
sfile="https://script.gegevps.com"
ts3='http://dl.4players.de/ts/releases/3.12.1/teamspeak3-server_linux_amd64-3.12.1.tar.bz2'
MYIP="$(wget --inet4-only -T 2 -qO- checkip.amazonaws.com || wget --inet4-only -T 2 -qO- ipv4.icanhazip.com || wget --inet4-only -T 2 -qO- ipinfo.io/ip || wget --inet4-only -T 2 -qO- ifconfig.co || wget --inet4-only -T 2 -qO- ifconfig.me || wget --inet4-only -T 2 -qO- diagnostic.opendns.com/myip)"

#Set Password
if [[ $1 == '' ]]; then
	pass=$(LC_CTYPE=C tr -dc 'A-HJ-NPR-Za-km-z2-9' < /dev/urandom | head -c 8)
else
	pass="$1"
fi

# wget custom command
until [[ -e /usr/bin/wgetcommand ]]; do
	wget --inet4-only --no-check-certificate --timeout=5 --waitretry=2 --read-timeout=10 --tries=0 -qO /usr/bin/wgetcommand "$sfile/custom-modules/wgetcommand"
	chmod +x /usr/bin/wgetcommand
done

apt-get update

#Clearing
if [[ $(ps ax | grep teamspeak | wc -l) == 1  ]]; then
	systemctl stop teamspeak.service
fi
if [[ -e /home/teamspeak ]]; then
	userdel teamspeak
fi
if [[ -e /home/teamspeak ]]; then
	rm -rf /home/teamspeak
	rm -rf /home/teamspeak/*
fi
if [[ -e /lib/systemd/system/teamspeak.service ]]; then
	rm -rf /lib/systemd/system/teamspeak.service
fi

#Install TeamSpeak3
adduser --disabled-login --gecos "" teamspeak
cd /home/teamspeak
wgetcommand ~/ts3.tar.bz2 "$ts3"
tar xvf ~/ts3.tar.bz2
rm -rf ~/ts3.tar.bz2
mv ./teamspeak3-server_linux_amd64/* /home/teamspeak
rm -rf ./teamspeak3-server_linux_amd64
sed -i 's/COMMANDLINE_PARAMETERS=""/COMMANDLINE_PARAMETERS="$2"/g' /home/teamspeak/ts3server_startscript.sh
touch /home/teamspeak/.ts3server_license_accepted

#Install TeamSpeak3 as a Service
wgetcommand /lib/systemd/system/teamspeak.service "$sfile/file/teamspeak.service"
sed -i "s/PASSWORDDDD/$pass/g" /lib/systemd/system/teamspeak.service
chmod +x /lib/systemd/system/teamspeak.service

systemctl enable teamspeak.service
systemctl start teamspeak.service

#Collect Data
script="TeamSpeak 3"
cekipdata=$(wget --inet4-only --no-check-certificate --no-cache -qO - 'https://docs.google.com/spreadsheets/d/e/2PACX-1vQTGbhB6vibhWKMyfDiiPupi3rMoaj8lI29YIlVHv5CoQwr7Mr2m6VUlH5tncFr-SNHgiQbi9n6Ebhl/pub?gid=130347063&single=true&output=csv' | cut -d ',' -f 3 | grep "$(wget --inet4-only -T 2 -qO- checkip.amazonaws.com || wget --inet4-only -T 2 -qO- ipv4.icanhazip.com || wget --inet4-only -T 2 -qO- ipinfo.io/ip || wget --inet4-only -T 2 -qO- ifconfig.co || wget --inet4-only -T 2 -qO- ifconfig.me || wget --inet4-only -T 2 -qO- diagnostic.opendns.com/myip)" | wc -l)
if [[ ${cekipdata} == 0 ]]; then
	curl -4 -so /dev/null https://docs.google.com/forms/d/e/1FAIpQLScb1rLxbUeIjgr6TKzP4rTMO28w3Ft8Os5vq_fDz4egOaPmLQ/formResponse?usp=pp_url -d "entry.1227234025=$(curl -4 -s http://ip-api.com/$MYIP?fields=as | grep 'as' | cut -d '"' -f 4 | cut -d ' ' -f 1)" -d "entry.743374772=$(curl -4 -s http://ip-api.com/$MYIP?fields=as | grep 'as' | cut -d '"' -f 4 | cut -d ' ' -f 2-10)" -d "entry.447085545=$(curl -4 -s http://ip-api.com/$MYIP?fields=countryCode | grep 'countryCode' | cut -d '"' -f 4)" -d "entry.1277609272=$script" -d "entry.481572831=$HOSTNAME" -d "entry.232452015=$(wget --inet4-only -T 2 -qO- checkip.amazonaws.com || wget --inet4-only -T 2 -qO- ipv4.icanhazip.com || wget --inet4-only -T 2 -qO- ipinfo.io/ip || wget --inet4-only -T 2 -qO- ifconfig.co || wget --inet4-only -T 2 -qO- ifconfig.me || wget --inet4-only -T 2 -qO- diagnostic.opendns.com/myip)" -d submit=Submit
fi

clear
echo -e "Write to System, please wait..."
sleep 10
clear
echo -e "=============================" | tee -a ~/ts3.txt
echo -e "          TeamSpeak 3" | tee -a ~/ts3.txt
echo -e "=============================" | tee -a ~/ts3.txt
echo -e "Host     : $MYIP" | tee -a ~/ts3.txt
echo -e "Nickname : Your Name" | tee -a ~/ts3.txt
echo -e "Password : $pass" | tee -a ~/ts3.txt
echo -e "Token    : $(cat /home/teamspeak/logs/ts3server_* | grep 'token' | cut -d'=' -f 2)" | tee -a ~/ts3.txt
echo -e "=============================" | tee -a ~/ts3.txt
echo -e "Server details save to $HOME/ts3.txt"


