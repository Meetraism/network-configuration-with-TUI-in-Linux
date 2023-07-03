#!/bin/bash
initialize() {
	apt-get update >/dev/null 2>&1
        apt-get install apt >/dev/null 2>&1
	apt update >/dev/null 2>&1
	apt install whiptail >/dev/null 2>&1
	# sudo apt-get install -y bind9 bind9utils bind9-doc dnsutils >/dev/null 2>&1
	apt install xterm >/dev/null 2>&1
	echo "initialized"
}
