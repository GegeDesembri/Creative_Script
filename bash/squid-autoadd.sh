#!/bin/bash

if ! which expect; then
	apt-get install -y expect
fi

clear
echo -e "See account list /root/squid_generated.txt"

function autocreate(){
squid_add_user="$1"
proxy_userpass="$2"
/usr/bin/expect <(cat << EOF
spawn ${squid_add_user}
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
	port_use="$4"
	
	if [[ "${port_use}" == '' ]]; then
		spawn_bin="/usr/local/bin/squid-add-user"
	else
		if [[ $(cat /etc/squid/squid.conf | grep -wce "^include ")  == 0 ]]; then
			echo -e "\ninclude /etc/squid/conf.d/*.conf" >> /etc/squid/squid.conf
		fi
		default_port="$(cat /etc/squid/squid.conf | grep "http_port" | cut -d ' ' -f 2)"
		conf_perport="/etc/squid/conf.d/${port_use}.conf"
		passwd_perport="/etc/squid/conf.d/${port_use}"
		spawn_bin="/usr/local/bin/squid-add-user-${port_use}"
		cp /etc/squid/squid.conf ${conf_perport}
		touch ${passwd_perport}
		cp /usr/local/bin/squid-add-user ${spawn_bin}
		chmod +x ${spawn_bin}
		sed -i "s|${default_port}|${port_use}|g" ${conf_perport}
		sed -i "s|/etc/squid/passwd|${passwd_perport}|g" ${conf_perport}
		sed -i "/^include /d" ${conf_perport}
		sed -i "s|/etc/squid/passwd|${passwd_perport}|g" ${spawn_bin}
	fi
	
	for USERPASS in $(eval echo "{$range_min..$range_max}"); do
		autocreate "${spawn_bin}" "${user_prefix}${USERPASS}"
		echo "${user_prefix}${USERPASS}" | tee -a /root/squid_generated.txt
		sleep 0.5
	done
}

loop_range $1 $2 $3 $4
