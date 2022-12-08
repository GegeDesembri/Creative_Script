#!/bin/bash

USERNAME="$1"
PASSWORD="$2"

useradd $USERNAME -g users -s /bin/false
echo "${USERNAME}:${PASSWORD}" | chpasswd
echo -e "Username : ${USERNAME} | Password : ${PASSWORD}"