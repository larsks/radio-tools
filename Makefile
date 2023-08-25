AX25_DIR = /etc/ax25
DIREWOLF_CONFIG_DIR = $(HOME)/.config/direwolf
SYSTEMD_UNIT_DIR = $(HOME)/.config/systemd/user

all:

install: install-system install-user

install-user:
	install -d -m 755 $(DIREWOLF_CONFIG_DIR)
	install -d -m 755 $(SYSTEMD_UNIT_DIR)
	install -m 644 direwolf.conf $(DIREWOLF_CONFIG_DIR)/
	install -m 644 direwolf.env $(DIREWOLF_CONFIG_DIR)/
	install -m 644 direwolf-amixer.sh $(DIREWOLF_CONFIG_DIR)/
	install -m 644 systemd/direwolf.service $(SYSTEMD_UNIT_DIR)/
	systemctl --user daemon-reload

install-system:
	sudo install axports $(AX25_DIR)/axports
