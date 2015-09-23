SPK_NAME = burp
SPK_VERS = 1.4.40
SPK_REV = 1
SPK_ICON = src/burp.png

DEPENDS = cross/coreutils cross/$(SPK_NAME)

MAINTAINER = SynoCommunity
DESCRIPTION = burp backup and restore
RELOAD_UI = no
DISPLAY_NAME = Burp
#STARTABLE = yes
BETA = 1

HOMEPAGE   = http://sourceforge.net/projects/burp/
LICENSE    = AGPL version 3

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = burp_extra_install

include ../../mk/spksrc.spk.mk

.PHONY: burp_extra_install
burp_extra_install:
	install -m 700 -d $(STAGING_DIR)/var/spool/burp
	install -m 700 -d $(STAGING_DIR)/var/run
	install -m 600 src/burp-server.conf $(STAGING_DIR)/etc/burp-server.conf.dist
	install -m 600 src/burp.conf $(STAGING_DIR)/etc/burp.conf.dist
	install -m 600 src/CA.cnf $(STAGING_DIR)/etc/CA.cnf
