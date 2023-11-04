#!/bin/sh

port=$1
exec ax25ipd -f -d /run/radio/pty$port -c /etc/radio/ax25ipd-$port.conf
