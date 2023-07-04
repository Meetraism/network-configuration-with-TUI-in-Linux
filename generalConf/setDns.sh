#!/bin/bash
#source ./generalConf/getUserInput.sh
source showMenu.sh

change_dns() {

# Display Whiptail input box to get DNS IP from user
dns_ip=$(show_inputbox "Enter a nameserver ip:")

# pattern of a valid ip 
pattern="^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"

# Function to change DNS configuration permanently
change_dns_permanent() {
    # Backup the original resolv.conf file
    cp /etc/resolv.conf /etc/resolv.conf.bak   
    # Create a new resolv.conf file with the specified DNS IP
    echo "nameserver $dns_ip" | tee /etc/resolv.conf > /dev/null   
    show_msgbox "DNS configuration changed permanently."
}

# Function to change DNS configuration temporarily
change_dns_temporary() {
    # Set the DNS IP using the 'resolvconf' command
    echo "nameserver $dns_ip" | resolvconf -a eth0.inet > /dev/null    
    show_msgbox "DNS configuration changed temporarily."
}

# validate ip
validate_ip() {
    local ip=$1	
    if ! [[ $ip =~ $pattern ]] ; then # fixed: spaces needed around the operator!
	  show_msgbox "${dns_ip} is not valid!"
	  # exit 0
    fi
}

# Test Reachablity 
# Test if ip is a dns server ip
is_dns_ip() {
    local ip=$1	
    if ! dig +short google.com @${dns_ip} &>/dev/null; then # fixed: Double quote to prevent word splitting.
        show_msgbox "${dns_ip} is not a DNS server!"
        # exit 0
    fi
}

validate_ip $dns_ip
is_dns_ip $dns_ip

# change dns | menu options :
options_temp_perm=(
	"Change DNS temporarily" change_dns_temporary 
	"Change DNS permanently" change_dns_permanent
)

show_menu "Select an option:" "${options_temp_perm[@]}"

}
