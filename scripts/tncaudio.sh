#!/bin/sh

: "${ALSA_SPEAKER_LEVEL:=50%}"
: "${ALSA_SPEAKER_CONTROL:="Speaker Playback Volume"}"
: "${ALSA_CAPTURE_LEVEL:=0%}"
: "${ALSA_CAPTURE_CONTROL:="Mic Capture Volume"}"
: "${ALSA_AGC_CONTROL:="Auto Gain Control"}"

ADEVICE=$(awk '$1 == "ADEVICE" {print $2}' /etc/radio/direwolf.conf)

echo "Setting sound levels on $ADEVICE"
amixer -D "${ADEVICE}" -s <<EOF
cset name='$ALSA_SPEAKER_CONTROL' $ALSA_SPEAKER_LEVEL
cset name='$ALSA_CAPTURE_CONTROL' $ALSA_CAPTURE_LEVEL
cset name='$ALSA_AGC_CONTROL' off
EOF
