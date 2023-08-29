AX25_DIR = /etc/ax25
DIREWOLF_CONFIG_DIR = $(HOME)/.config/direwolf
SYSTEMD_UNIT_DIR = $(HOME)/.config/systemd/user
UDEV_RULES = $(wildcard udev/*.rules)
UDEV_RULES_DIR = /etc/udev/rules.d

all:

install-user:
	install -d -m 755 $(DIREWOLF_CONFIG_DIR)
	install -d -m 755 $(SYSTEMD_UNIT_DIR)
	install -m 644 direwolf.conf $(DIREWOLF_CONFIG_DIR)/
	install -m 644 direwolf.env $(DIREWOLF_CONFIG_DIR)/
	install -m 644 direwolf-tnc.env $(DIREWOLF_CONFIG_DIR)/
	install -m 644 direwolf-amixer.sh $(DIREWOLF_CONFIG_DIR)/
	install -m 644 direwolf-service-helper.sh $(DIREWOLF_CONFIG_DIR)/
	install -m 644 systemd/direwolf@.service $(SYSTEMD_UNIT_DIR)/
	ln -sf direwolf.conf $(DIREWOLF_CONFIG_DIR)/direwolf-tnc.conf
	ln -sf direwolf.conf $(DIREWOLF_CONFIG_DIR)/direwolf-notnc.conf
	systemctl --user daemon-reload

install-system:
	install -m 644 axports $(AX25_DIR)/axports
	install $(UDEV_RULES) $(UDEV_RULES_DIR)/
	install -m 644 ax25.nft /etc/nftables/
	udevadm control --reload-rules && udevadm trigger
