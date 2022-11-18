#!/bin/bash

if ! which expect; then
	apt-get install -y expect
fi

clear
echo -e "See account list /root/squid_generated.txt"

function autocreate(){
proxy_userpass="$1"
/usr/bin/expect <(cat << EOF
spawn squid-add-user
expect "Enter Proxy username: "
send "user$proxy_userpass\r"
expect "New password: "
send "user$proxy_userpass\r"
expect "Re-type new password: "
send "user$proxy_userpass\r"
interact
EOF
)
}

function loop_range(){
	range_min="$1"
	range_max="$2"
	
	for USERPASS in $(eval echo "{$range_min..$range_max}"); do
		autocreate "proxyuser${USERPASS}"
		echo "proxyuser${USERPASS}" | tee -a /root/squid_generated.txt
		sleep 0.5
	done
}

loop_range $1 $2