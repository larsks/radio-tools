#!/bin/bash

UNITS=(
	units/radio.target
	units/tncaudio.service
	units/direwolf.service
	units/rigctld.service
	units/kissattach@.service
	units/mheardd.service
	units/ax25ports.target
	units/ptyproxy@.service
	units/ax25ipd@.service
)

OVERRIDES=(
	kissattach@vhf0.service:units/wants-direwolf.conf
	kissattach@udp0.service:units/wants-ax25ipd-udp0.conf
	kissattach@udp1.service:units/wants-ax25ipd-udp1.conf
)

CONF=(
	conf/radio.env
	conf/direwolf.conf
	conf/ax25ipd-udp0.conf
	conf/ax25ipd-udp1.conf
)

AX25CONF=(
	conf/axports
)

SCRIPTS=(
	scripts/tncaudio.sh
	scripts/direwolf-start.sh
	scripts/direwolf-cleanup.sh
	scripts/kissattach-start.sh
	scripts/kissattach-startpost.sh
	scripts/wait-for-tty.sh
	scripts/mheardd-start.sh
	scripts/ptyproxy-start.sh
	scripts/ax25ipd-start.sh
)

PORTS=(
	conf/ports/vhf0.env
	conf/ports/udp0.env
	conf/ports/udp1.env
)

TMPFILES=(
	conf/tmpfiles.d/radio.conf
)

mkdir -p /opt/radio /etc/radio /etc/radio/ports

for unit in "${UNITS[@]}"; do
	install -m 644 "$unit" /etc/systemd/system
done

for spec in "${OVERRIDES[@]}"; do
	unit=${spec%:*}
	override=${spec#*:}

	mkdir -p "/etc/systemd/system/${unit}.d"
	install -m 644 "$override" "/etc/systemd/system/${unit}.d/"
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
	kissattach@vhf0.service kissattach@udp0.service kissattach@udp1.service \
	ax25ports.target mheardd.service \
	ptyproxy@udp0.service ptyproxy@udp1.service \
	ax25ipd@udp0.service ax25ipd@udp1.service
