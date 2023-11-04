#!/bin/sh

ax25_tty_resolved=$(readlink -f "$AX25_TTY")

/usr/sbin/kissattach "${ax25_tty_resolved}" "${AX25_PORT}" -m ${AX25_MTU:-128}
