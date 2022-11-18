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
send "${proxy_userpass}\r"
expect "New password: "
send "${proxy_userpass}\r"
expect "Re-type new password: "
send "${proxy_userpass}\r"
interact
EOF
)
}

function loop_range(){
	user_prefix="$1"
	range_min="$2"
	range_max="$3"
	
	for USERPASS in $(eval echo "{$range_min..$range_max}"); do
		autocreate "${user_prefix}${USERPASS}"
		echo "${user_prefix}${USERPASS}" | tee -a /root/squid_generated.txt
		sleep 0.5
	done
}

loop_range $1 $2 $3