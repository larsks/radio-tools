#!/bin/bash

UNITS=(
	units/radio.target
	units/tncaudio.service
	units/direwolf.service
	units/rigctld.service
	units/ax25tnc@.service
)

CONF=(
	conf/radio.env
	conf/direwolf.conf
)

AX25CONF=(
	conf/axports
)

SCRIPTS=(
	scripts/tncaudio.sh
	scripts/direwolf-start.sh
	scripts/direwolf-cleanup.sh
	scripts/ax25tnc-start.sh
	scripts/ax25tnc-startpost.sh
	scripts/wait-for-tty.sh
)

PORTS=(
	conf/ports/vhf0.env
)

mkdir -p /opt/radio /etc/radio /etc/radio/ports

for unit in "${UNITS[@]}"; do
	install -m 644 "$unit" /etc/systemd/system
done

for conf in "${CONF[@]}"; do
	install -m 644 "$conf" /etc/radio
done

for conf in "${AX25CONF[@]}"; do
	install -m 644 "$conf" /etc/ax25
done

for script in "${SCRIPTS[@]}"; do
	install -m 755 "$script" /opt/radio
done

for port in "${PORTS[@]}"; do
	install -m 644 "$port" /etc/radio/ports
done

systemctl daemon-reload
systemctl enable radio.target tncaudio.service direwolf.service rigctld.service ax25tnc@vhf0.service
