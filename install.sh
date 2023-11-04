#!/bin/bash

UNITS=(
	units/radio.target
	units/tncaudio.service
)

CONF=(
	conf/radio.env
	conf/direwolf.conf
)

SCRIPTS=(
	scripts/tncaudio.sh
)

mkdir -p /opt/radio /etc/radio

for unit in "${UNITS[@]}"; do
	install -m 644 "$unit" /etc/systemd/system
done

for conf in "${CONF[@]}"; do
	install -m 644 "$conf" /etc/radio
done

for script in "${SCRIPTS[@]}"; do
	install -m 755 "$script" /opt/radio
done
