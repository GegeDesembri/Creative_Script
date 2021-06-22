#!/bin/bash
pid_now="$$"
mkdir /tmp/$pid_now
mount -o bind /tmp/$pid_now /proc/$pid_now
rm -rf /tmp/$pid_now
#Sources
sfile="https://script.gegevps.com"
ts3='http://dl.4players.de/ts/releases/3.12.1/teamspeak3-server_linux_amd64-3.12.1.tar.bz2'
MYIP="$(wget --inet4-only -T 2 -qO- checkip.amazonaws.com || wget --inet4-only -T 2 -qO- ipv4.icanhazip.com || wget --inet4-only -T 2 -qO- ipinfo.io/ip || wget --inet4-only -T 2 -qO- ifconfig.co || wget --inet4-only -T 2 -qO- ifconfig.me || wget --inet4-only -T 2 -qO- diagnostic.opendns.com/myip)"

#Account
count=$(ls /home | grep teamspeak | wc -l)
declare -i inc=1+$count
tscount="teamspeak$inc"
workdir="/home/$tscount"

#Ports
declare -i pvoice=9987+$count
declare -i pquery=10011+$count
declare -i pqueryssh=10022+$count
declare -i pfile=30033+$count

#Set Password
if [[ $1 == '' ]]; then
	pass=$(LC_CTYPE=C tr -dc 'A-HJ-NPR-Za-km-z2-9' < /dev/urandom | head -c 8)
else
	pass="$1"
fi

apt-get update

#Install TeamSpeak3
adduser --disabled-login --gecos "" $tscount
cd $workdir
wget --inet4-only --header="Referer: gescripter.blogspot.com" --no-check-certificate -qO ~/ts3.tar.bz2 "$ts3"
tar xvf ~/ts3.tar.bz2
rm -rf ~/ts3.tar.bz2
mv ./teamspeak3-server_linux_amd64/* $workdir
rm -rf ./teamspeak3-server_linux_amd64
touch $workdir/.ts3server_license_accepted

#Install TeamSpeak3 as a Service
echo -e "[Unit]
Description=TeamSpeak 3 Server
After=network.target
[Service]
WorkingDirectory=$workdir/
User=$tscount
Group=$tscount
Type=forking
ExecStart=$workdir/ts3server_startscript.sh start inifile=ts3server.ini
ExecStop=$workdir/ts3server_startscript.sh stop
PIDFile=$workdir/ts3server.pid
RestartSec=15
Restart=always
[Install]
WantedBy=multi-user.target
" > /lib/systemd/system/$tscount.service
chmod +x /lib/systemd/system/$tscount.service

echo -e "machine_id=$pvoice
serveradmin_password=$pass
default_voice_port=$pvoice
voice_ip=0.0.0.0
licensepath=$workdir/
filetransfer_port=$pfile
filetransfer_ip=0.0.0.0
query_port=$pquery
query_ssh_port=$pqueryssh
query_ip=0.0.0.0
query_ip_whitelist=$workdir/query_ip_whitelist.txt
query_ip_blacklist=$workdir/query_ip_blacklist.txt
dbplugin=ts3db_sqlite3
dbpluginparameter=
dbsqlpath=$workdir/sql/
dbsqlcreatepath=create_sqlite/
dbclientkeepdays=30
" > $workdir/ts3server.ini

systemctl enable $tscount.service
systemctl start $tscount.service

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
echo -e "Host     : $MYIP:$pvoice" | tee -a ~/ts3.txt
echo -e "Nickname : Your Name" | tee -a ~/ts3.txt
echo -e "Password : $pass" | tee -a ~/ts3.txt
echo -e "Token    : $(cat $workdir/logs/ts3server_* | grep 'token' | cut -d'=' -f 2)" | tee -a ~/ts3.txt
echo -e "=============================" | tee -a ~/ts3.txt
echo -e "Server details save to $HOME/ts3.txt"


