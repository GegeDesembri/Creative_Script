#!/bin/bash

# User AutoAdd
user_prefix="$1"
range_min="$2"
range_max="$3"
for USERPASS in $(eval echo "{$range_min..$range_max}"); do
	userdel "${user_prefix}${USERPASS}"
	sleep 0.5
done

# Usage
# dante-autodel usertest 1 100