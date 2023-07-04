#!/bin/bash
# This script assigns an IP address to a selected network interface using DHCP.

source set_interface_ip
source validation.sh

# Function to release and request a new IP address
release_and_request_ip() {
    local interface=$1

	# Release any existing lease on the interface
	dhclient -r "$interface"

    # Request a new IP address
    if ! dhclient "$interface"; then
        show_msgbox "Error: Failed to obtain a DHCP lease for interface '$interface'."
        return 1
    fi
}

# Function to assign a DHCP IP address temporarily
assign_dhcp_ip_temporarily() {
	local interface="$selected_interface"
   
    # Check if dhclient command is available, install it if not
    check_install_package "isc-dhcp-client"
   
    release_and_request_ip "$interface"

    # Verify if IP assignment was successful
    local ip=$(ip -o -4 addr show dev "$interface" | awk '{print $4}')
    if [[ -z "$ip" ]]; then
        show_msgbox "Error: Failed to assign temporary IP address to $interface"
        return 1
    else
        show_msgbox "IP address assigned to interface '$interface' by DHCP successfully!"
    fi

	# Retrieving the IP address assigned by dhcp and store it in global var ip_address
	ip_address=$(ifconfig $interface | awk '/inet /{print $2}')
}

# Function to assign DHCP IP address permanently
assign_dhcp_ip_permanently() {
    local interface="$selected_interface"

    # Check if the required packages are installed
    check_install_package "isc-dhcp-client"
    check_install_package "net-tools"
    
    release_and_request_ip "$interface"

    # Get the assigned IP address
    local ip=$(ip addr show dev "$interface" | awk '/inet / {print $2}')
    
    # Validate the obtained IP address
    if [[ -z "$ip_address" ]]; then
        show_msgbox "Error: Failed to obtain a valid IP address for interface '$interface'."
        return 1
    fi

    show_msgbox "Successfully assigned IP address $ip_address to interface '$interface'."
    return 0
}