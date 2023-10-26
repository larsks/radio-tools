#!/bin/bash

FULLDUPLEX=y

set -e

kissparms -p $AX25_PORT -c 1 \
	${AX25_FULLDUPLEX:+-f ${AX25_FULLDUPLEX}} \
	${AX25_TXDELAY:+-t ${AX25_TXDELAY}} \
	${AX25_TXTAIL:+-l ${AX25_TXTAIL}} \
	${AX25_PERSIST:+-r ${AX25_PERSIST}} \
	${AX25_SLOTTIME:+-s ${AX25_SLOTTIME}}

# https://thomask.sdf.org/blog/2017/08/06/improving-arp-performance-on-slow-ax-25-links.html
sysctl net.ipv4.neigh.ax0.retrans_time_ms=5000
sysctl net.ipv4.neigh.ax0.base_reachable_time_ms=1200000

