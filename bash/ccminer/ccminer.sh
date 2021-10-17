#!/bin/bash

# Module Check
screen_bin_exist="$(which screen | wc -l)"
if [[ "${screen_bin_exist}" == '0' ]]; then
    apt update
    apt install -y screen
fi

# Binary Check
if [[ -f "/root/ccminer/ccminer" ]]; then
    ccminer_bin="/root/ccminer/ccminer"
else
    echo -e 'Silahkan compile ccminer pada folder /root terlebih dahulu'
    exit 1
fi

# Config
mkdir /etc/ccminer &>/dev/null
cat >/etc/ccminer/runner <<-EOF
LINE#!/bin/bash
LINE${ccminer_bin} -a verus -o stratum+tcp://ap.luckpool.net:3956 -u RPZEpdP31QR4a4f7HsR3ukT3baRrZrUnq1.R1 -p x -t 4
EOF
sed -i '/^$/d;s/^LINE//g' /etc/ccminer/runner
chmod +x /etc/ccminer/runner

# Crontab
ccminer_cron="$(crontab -l | grep -wc 'screen -dmS ccminer')"
if [[ "${ccminer_cron}" == '0' ]]; then
	crontab -l > /tmp/cron.txt
	echo -e "@reboot screen -dmS ccminer ${ccminer_bin}" >> /tmp/cron.txt
	crontab /tmp/cron.txt
	rm -rf /tmp/cron.txt
	systemctl restart cron
fi
