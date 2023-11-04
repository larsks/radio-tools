#!/bin/sh

ax25_port=$1
/usr/sbin/kissparms -p "${ax25_port}" -c 1
