#!/bin/bash

TXDELAY=100
TXTAIL=100
FULLDUPLEX=n

if [[ -z $1 ]]; then
	echo "ERROR: missing port" >&2
	exit 1
fi

kissattach $(readlink /tmp/kisstnc) $1 $2
kissparms -p $1 -c 1 \
	${FULLDUPLEX:+-f ${FULLDUPLEX}} \
	${TXDELAY:+-t ${TXDELAY}} \
	${TXTAIL:+-l ${TXTAIL}} \
	${PERSIST:+-r ${PERSIST}} \
	${SLOTTIME:+-s ${SLOTTIME}}
