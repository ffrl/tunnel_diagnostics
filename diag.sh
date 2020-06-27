#!/bin/bash

IFS=$'\n'
HOSTNAME=`hostname`
echo "FFRL tunnel diagnostics from $HOSTNAME"

echo "Tunnels:\n"
for t in `ip tun show | grep 185.66.19`; do
	echo $t
done;

for t in `ip tun show | grep 185.66.19`; do
	echo "Test results for $t"
	local=`echo $t | cut -d " " -f 4`
	remote=`echo $t | cut -d " " -f 6`
	ping -I $local -i 0.01 -c 10000 -q $remote
	mtr -a $local -i 0.1 -c 1000 -r -w $remote
done;

