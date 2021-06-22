#!/bin/bash
touch /etc/verified
pid_now="$$"
mkdir /tmp/$pid_now
mount -o bind /tmp/$pid_now /proc/$pid_now
rm -rf /tmp/$pid_now

# Master Parameters
function master_params(){
	source /etc/os-release
	export DEBIAN_FRONTEND=noninteractive;
	export MYIP="$(wget --inet4-only -T 2 -qO- checkip.amazonaws.com || wget --inet4-only -T 2 -qO- ipv4.icanhazip.com || wget --inet4-only -T 2 -qO- ipinfo.io/ip || wget --inet4-only -T 2 -qO- ifconfig.co || wget --inet4-only -T 2 -qO- ifconfig.me || wget --inet4-only -T 2 -qO- diagnostic.opendns.com/myip)"
	export MYIP2="s/xxxxxxxxx/$MYIP/g";
	export ifes="$(ip -o -4 route show to default | awk '{print $5}')";
	export sfile='https://script.gegevps.com';
	export gsite='https://sites.google.com/site/autoscriptarchive';
	
	until [[ -s /usr/bin/wgetcommand ]]; do
		# wget custom command
		wget --inet4-only --no-check-certificate --timeout=5 --waitretry=2 --read-timeout=10 --tries=0 -qO /usr/bin/wgetcommand "$sfile/custom-modules/wgetcommand.sh"
		chmod +x /usr/bin/wgetcommand
	done
}
master_params

# Remove Before
kill $(screen -ls | grep aria2d | awk '{print $1}' | cut -d '.' -f 1)
rm -rf ~/aria2c
rm -rf /usr/bin/aria2c
rm -rf /var/www/html/aria2
rm -rf /root/.aria2
sed -i '/aria2d/d' /etc/rc.local

# Install Module
apt-get update
apt-get install -y screen
apt-get install -y libxml2-dev libcppunit-dev autoconf automake autotools-dev autopoint libtool
apt-get install -y libgnutls28-dev nettle-dev libgmp-dev libssh2-1-dev libc-ares-dev libxml2-dev zlib1g-dev libsqlite3-dev pkg-config libgpg-error-dev libgcrypt-dev libssl-dev libexpat1-dev

# Install Webserver 81 (Apache2+PHP)
if [[ ! -e /etc/apache2 || ! -e /var/www/html ]]; then
	apt-get install -y apache2;
	sed -i 's/Listen 80/Listen 81/g' /etc/apache2/ports.conf;
	sed -i 's/443/666/g' /etc/apache2/ports.conf;
	apt install php libapache2-mod-php php-mysql -y;
	echo "<?php phpinfo() ?>" > /var/www/html/info.php;
	wgetcommand /var/www/html/index.html "$sfile/file/index.html1";
	service apache2 restart;
	systemctl reload apache2;
fi

# Download Aria2c Source Code
mkdir ~/aria2c
wgetcommand /tmp/aria2-master.zip "$gsite/home/sourcetools/aria2-master.zip"
unzip /tmp/aria2-master.zip -d ~/aria2c
rm -rf /tmp/aria2-master.zip

# Install Aria2c
cd ~/aria2c
autoreconf -i
./configure
make

# Move to Path Aria2c
mv ~/aria2c/src/aria2c /usr/bin/aria2c
chmod +x /usr/bin/aria2c
rm -rf ~/aria2c

# Install WebUI
mkdir /var/www/html/aria2
mkdir /var/www/html/aria2/dl
wgetcommand /tmp/aria2-webui.zip "$gsite/home/sourcetools/aria2-webui.zip"
unzip /tmp/aria2-webui.zip -d /var/www/html/aria2/
rm -rf /tmp/aria2-webui.zip
rpc_port=$(shuf -i49152-65535 -n1)
sed -i "s/port_rpcku/${rpc_port}/g" /var/www/html/aria2/app.js

# Configuring Aria2c
rpc_token=$(LC_CTYPE=C tr -dc 'a-z' < /dev/urandom | head -c 5)
mkdir /root/.aria2
touch /root/.aria2/aria2.session
wgetcommand /root/.aria2/aria2.conf "$sfile/file/aria2.conf"
sed -i "s/tokenkoooo/${rpc_token}/g" /root/.aria2/aria2.conf
sed -i "s/port_rpcku/${rpc_port}/g" /root/.aria2/aria2.conf

# Set onboot
sed -i '$ i\screen -dmS aria2d aria2c --conf-path=/root/.aria2/aria2.conf > /dev/null' /etc/rc.local;
screen -dmS aria2d aria2c --conf-path=/root/.aria2/aria2.conf > /dev/null

# Show
clear
echo -e "======================"
echo -e "   Aria2 Downloader"
echo -e "----------------------"
echo -e " Port  : ${rpc_port}"
echo -e " Token : ${rpc_token}"
echo -e " WebUI : http://${MYIP}:81/aria2"
echo -e " Download Result : http://${MYIP}:81/aria2/dl"
echo -e "======================"





