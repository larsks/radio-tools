#!/bin/sh

: "${DIREWOLF_CONFIG:=${XDG_CONFIG_HOME:-$HOME/.config}/direwolf/direwolf.conf}"
: "${ALSA_SPEAKER_LEVEL:=80%}"
: "${ALSA_CAPTURE_LEVEL:=40%}"

ADEVICE=$(awk '$1 == "ADEVICE" {print $2}' $DIREWOLF_CONFIG)

echo "Setting sound levels on $ADEVICE"
amixer -D "${ADEVICE}" -s <<EOF
cset name='Speaker Playback Volume' $ALSA_SPEAKER_LEVEL
cset name='Mic Capture Volume' $ALSA_CAPTURE_LEVEL
cset name='Auto Gain Control' off
EOF
