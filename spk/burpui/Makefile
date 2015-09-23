SPK_NAME = burpui
SPK_VERS = git62c84386
SPK_REV = 1
SPK_ICON = src/burpui.png
DSM_UI_DIR = app

BUILD_DEPENDS  = cross/python cross/setuptools cross/pip cross/wheel cross/$(SPK_NAME)
WHEELS = $(SPK_NAME)==$(SPK_VERS)
SPK_DEPENDS = "python>=2.7.6-8"

MAINTAINER = SynoCommunity
DESCRIPTION = Burp-UI is a web-ui for burp backup written in python with Flask and jQuery/Bootstrap
DESCRIPTION_FRE = Burp UI est une interface graphique pour burp écrit en python avec Flask et jQuery/Bootstrap
ADMIN_PROTOCOL = http
ADMIN_PORT = 4973
RELOAD_UI = yes
DISPLAY_NAME = Burp-UI
CHANGELOG = "Update to revision 62c84386"

HOMEPAGE   = https://git.ziirish.me/ziirish/burp-ui
LICENSE    = BSD 3-clause LICENSE

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

COPY_TARGET = nop
POST_STRIP_TARGET = burpui_extra_install

include ../../mk/spksrc.spk.mk

.PHONY: burpui_extra_install
burpui_extra_install:
	install -m 755 -d ${STAGING_DIR}/share
	install -m 755 -d ${STAGING_DIR}/share/wheelhouse
	install -m 644 ${WORK_DIR}/wheelhouse/* ${STAGING_DIR}/share/wheelhouse/
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/tmp
	install -m 755 -d $(STAGING_DIR)/etc
	install -m 600 src/burpui.cfg $(STAGING_DIR)/etc/burpui.cfg
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done
