#!/bin/bash

UNITS=(
	units/radio.target
	units/tncaudio.service
)

ENVS=(
	envs/radio.env
)

SCRIPTS=(
	scripts/tncaudio.sh
)

mkdir -p /opt/radio /etc/radio

for unit in "${UNITS[@]}"; do
	install -m 644 "$unit" /etc/systemd/system
done

for env in "${ENVS[@]}"; do
	install -m 644 "$env" /etc/radio
done

for script in "${SCRIPTS[@]}"; do
	install -m 755 "$script" /opt/radio
done
