#!/bin/sh

# Package
PACKAGE="burp"
DNAME="burp"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp"
PATH="${INSTALL_DIR}/bin:${INSTALL_DIR}/sbin:${PATH}"

SERVICETOOL="/usr/syno/bin/servicetool"
FWPORTS="/var/packages/${PACKAGE}/scripts/${PACKAGE}.sc"

preinst ()
{
    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}

    # Put burp in the PATH
    mkdir -p /usr/local/sbin
    ln -s ${INSTALL_DIR}/sbin/burp /usr/local/sbin/burp
    ln -s ${INSTALL_DIR}/sbin/bedup /usr/local/sbin/bedup
    ln -s ${INSTALL_DIR}/sbin/vss_strip /usr/local/sbin/vss_strip
    ln -s ${INSTALL_DIR}/sbin/burp_ca /usr/local/sbin/burp_ca
    ln -s ${INSTALL_DIR}/bin/bash /usr/local/bin/bash
    ln -s ${INSTALL_DIR}/bin/mktemp /usr/local/bin/mktemp
    
    mkdir -p ${INSTALL_DIR}/etc/CA-client
    mkdir -p ${INSTALL_DIR}/etc/clientconfdir
    mkdir -p ${INSTALL_DIR}/etc/autoupgrade/client
    mkdir -p ${INSTALL_DIR}/etc/autoupgrade/server/win32/1.4.40
    mkdir -p ${INSTALL_DIR}/etc/autoupgrade/server/win64/1.4.40
   
    sed -i -e "s|/etc/burp|/usr/local/burp/etc|g" ${INSTALL_DIR}/sbin/burp_ca

    if [ ! -f ${INSTALL_DIR}/etc/burp-server.conf ] ; then
        cp ${INSTALL_DIR}/etc/burp-server.conf.dist ${INSTALL_DIR}/etc/burp-server.conf
    fi
    if [ ! -f ${INSTALL_DIR}/etc/burp.conf ] ; then
        cp ${INSTALL_DIR}/etc/burp.conf.dist ${INSTALL_DIR}/etc/burp.conf
    fi
    
    # Add firewall config
    ${SERVICETOOL} --install-configure-file --package ${FWPORTS} >> /dev/null

    exit 0
}

preuninst ()
{
    # Stop the package
    ${SSS} stop > /dev/null
    
    # Remove firewall config
    if [ "${SYNOPKG_PKG_STATUS}" == "UNINSTALL" ]; then
        ${SERVICETOOL} --remove-configure-file --package ${PACKAGE}.sc >> /dev/null
    fi

    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}
    rm -f /usr/local/bin/burp
    rm -f /usr/local/bin/bedup
    rm -f /usr/local/bin/vss_strip
    rm -f /usr/local/bin/burp_ca
    rm -f /usr/local/bin/bash
    rm -f /usr/local/bin/mktemp
    rm -f /etc/burp

    exit 0
}

preupgrade ()
{
    # Stop the package
    ${SSS} stop > /dev/null

    # Save some stuff
    rm -fr ${TMP_DIR}/${PACKAGE}
    mkdir -p ${TMP_DIR}/${PACKAGE}
    mv ${INSTALL_DIR}/var ${TMP_DIR}/${PACKAGE}/
    mv ${INSTALL_DIR}/etc ${TMP_DIR}/${PACKAGE}/

    exit 0
}

postupgrade ()
{
    # Restore some stuff
    rm -fr ${INSTALL_DIR}/var
    rm -fr ${INSTALL_DIR}/etc
    mv ${TMP_DIR}/${PACKAGE}/var ${INSTALL_DIR}/
    mv ${TMP_DIR}/${PACKAGE}/etc ${INSTALL_DIR}/
    rm -fr ${TMP_DIR}/${PACKAGE}

    exit 0
}
