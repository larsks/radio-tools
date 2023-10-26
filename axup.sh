#!/bin/bash

FULLDUPLEX=y

if [[ -z $1 ]]; then
	echo "ERROR: missing port" >&2
	exit 1
fi

set -e

kissattach $(readlink /tmp/kisstnc) $1 $2
kissparms -p $1 -c 1 \
	${FULLDUPLEX:+-f ${FULLDUPLEX}} \
	${TXDELAY:+-t ${TXDELAY}} \
	${TXTAIL:+-l ${TXTAIL}} \
	${PERSIST:+-r ${PERSIST}} \
	${SLOTTIME:+-s ${SLOTTIME}}

# https://thomask.sdf.org/blog/2017/08/06/improving-arp-performance-on-slow-ax-25-links.html
sysctl net.ipv4.neigh.ax0.retrans_time_ms=5000
sysctl net.ipv4.neigh.ax0.base_reachable_time_ms=1200000

