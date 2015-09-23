PKG_NAME = burp
PKG_VERS = 1.4.40
PKG_EXT = tar.bz2
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://sourceforge.net/projects/$(PKG_NAME)/files/$(PKG_NAME)-1.4.40
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/openssl cross/zlib cross/librsync cross/bash cross/mktemp cross/ncurses

HOMEPAGE = http://sourceforge.net/projects/burp/
COMMENT  = burp backup and restore
LICENSE  = BSD License

GNU_CONFIGURE = 1
CONFIGURE_ARGS = --sbindir=/usr/local/burp/sbin

INSTALL_TARGET = myInstall

include ../../mk/spksrc.cross-cc.mk

.PHONY: myInstall
myInstall:
	$(RUN) $(MAKE) install DESTDIR=$(INSTALL_DIR) 
