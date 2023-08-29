#!/bin/bash

DEFAULT_DIREWOLF_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/direwolf/direwolf.conf"

: "${DIREWOLF:=direwolf}"
: "${DIREWOLF_FX25:=1}"
: "${DIREWOLF_CONFIG:=$DEFAULT_DIREWOLF_CONFIG}"

exec ${DIREWOLF} -t 0 \
	-X ${DIREWOLF_FX25} \
	${DIREWOLF_KISSTNC:+-p} \
	-c ${DIREWOLF_CONFIG}
