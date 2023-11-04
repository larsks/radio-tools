#!/bin/bash

set -e

DIREWOLF_ARGS=()

if [[ -n $DIREWOLF_FX25 ]]; then
	DIREWOLF_ARGS+=(-X 1)
fi

if [[ -n $DIREWOLF_IL2P ]]; then
	if [[ -n $DIREWOLF_IL2P_INV ]]; then
		DIREWOLF_ARGS+=(-i 1)
	else
		DIREWOLF_ARGS+=(-I 1)
	fi
fi

if [[ -n $DIREWOLF_KISSPTY ]]; then
	DIREWOLF_ARGS+="-p"
fi

exec direwolf -t 0 -q d -c /etc/radio/direwolf.conf "${DIREWOLF_ARGS[@]}"

