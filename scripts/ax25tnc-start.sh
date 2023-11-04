#!/bin/sh

ax25_tty_resolved=$(readlink -f "$AX25_TTY")
ax25_port=$2
ax25_speed=$3

  /usr/sbin/kissattach "${ax25_tty}" "${ax25_port}" -m 256
