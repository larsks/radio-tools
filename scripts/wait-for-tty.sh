#!/bin/sh

echo "waiting for device $1"
while :; do
	ax25_tty=$(readlink -f "$1")
	[ -c "${ax25_tty}" ] && break
	sleep 1
done
echo "device $1 ($ax25_tty) is ready"
