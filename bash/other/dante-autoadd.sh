#!/bin/bash

# User AutoAdd
user_prefix="$1"
range_min="$2"
range_max="$3"
for USERPASS in $(eval echo "{$range_min..$range_max}"); do
	dante-add "${user_prefix}${USERPASS}"
	echo "${user_prefix}${USERPASS}" | tee -a /root/dante_generated.txt
	sleep 0.5
done

# Usage
# dante-autoadd usertest 1 100