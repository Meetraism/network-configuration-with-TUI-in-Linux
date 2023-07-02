#!/bin/bash
# dnsConfig.sh

source getUserInput.sh

# Take IPs from user

IP=$(get_user_input "DNS Configuration" "Please Enter a Nameserver:")

pattern="^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"

# validate ip

validateIP() {
    local ip=$1	
    if ! [[ $ip=~$pattern ]] ; then
	  echo "$ip is not valid!"
	  exit 0
    fi
}

# Test Reachablity 
# Test if ip is a dns server ip

isDns() {
    local ip=$1	
    if ! dig +short google.com @${ip} >/dev/null; then
        echo "${ip} is not a DNS server!"
        exit 0
    fi
}


# Backup existing resolv.conf

cp /etc/resolv.conf /etc/resolve.conf.bak

# Set DNS servers

setDns() {
    local ip=$1
    echo "nameserver $ip" > /etc/resolv.conf
    #sudo echo "nameserver $ip2" >> /etc/resolv.conf
}

validateIP IP
isDns IP
setDns IP

