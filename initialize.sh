#!/bin/bash
source ./generalConf/validation.sh
apt-get update >/dev/null 2>&1
check_install_package "apt-utils"
check_install_package "dialog"
check_install_package "whiptail"
check_install_package "resolvconf"
