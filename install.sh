#!/bin/bash

UNITS=(
	units/radio.target
	units/tncaudio.service
	units/direwolf.service
	units/rigctld.service
	units/ax25tnc@.service
	units/mheardd.service
	units/ax25ports.target
	units/ptyproxy@.service
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
	scripts/mheardd-start.sh
	scripts/ptyproxy-start.sh
)

PORTS=(
	conf/ports/vhf0.env
)

TMPFILES=(
	conf/tmpfiles.d/radio.conf
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

for conf in "${TMPFILES[@]}"; do
	install -m 644 "$conf" /etc/tmpfiles.d
done

systemctl daemon-reload
systemd-tmpfiles --create
systemctl enable radio.target tncaudio.service direwolf.service rigctld.service \
	ax25tnc@vhf0.service ax25ports.target mheardd.service \
	ptyproxy@udp0.service ptyproxy@udp1.service
