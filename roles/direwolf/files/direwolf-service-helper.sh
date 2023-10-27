#!/bin/bash

DEFAULT_DIREWOLF_CONFIG="/etc/radio/direwolf.conf"

: "${DIREWOLF:=direwolf}"
: "${DIREWOLF_FX25:=1}"
: "${DIREWOLF_CONFIG:=$DEFAULT_DIREWOLF_CONFIG}"

: "${ALSA_SPEAKER_LEVEL:=0%}"
: "${ALSA_MIC_LEVEL:=0%}"
: "${ALSA_CAPTURE_LEVEL:=0%}"

set -e

ADEVICE=$(awk '$1 == "ADEVICE" {print $2}' $DIREWOLF_CONFIG)

echo "Setting sound levels on $ADEVICE"
amixer -D "${ADEVICE}" -s <<EOF
cset name='Speaker Playback Volume' $ALSA_SPEAKER_LEVEL
cset name='Mic Playback Volume' $ALSA_MIC_LEVEL
cset name='Mic Capture Volume' $ALSA_CAPTURE_LEVEL
cset name='Auto Gain Control' off
EOF

exec ${DIREWOLF} -t 0 \
	-X ${DIREWOLF_FX25} \
	${DIREWOLF_KISSTNC:+-p} \
	-c ${DIREWOLF_CONFIG}
