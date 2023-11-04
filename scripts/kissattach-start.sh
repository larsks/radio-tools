#!/bin/sh

ax25_port=$1
ax25_tty=$2

ax25_tty_resolved=$(readlink -f "$ax25_tty")

/usr/sbin/kissattach -l "${ax25_tty_resolved}" "${ax25_port}"
