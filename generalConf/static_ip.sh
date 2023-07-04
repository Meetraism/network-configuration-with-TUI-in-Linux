#!/bin/bash
source set_interface_ip
source validation.sh

# Function to assign a static IP address temporarily to an interface
assign_static_ip_temporarily() {
    # Check if necessary packages are installed
    check_install_package "iproute2"
	
	# Get IP address from user
    get_ip_from_user

    # Assign the IP address temporarily
    if ! ip addr add "$ip_address/$subnet_mask" dev "$selected_interface"; then
        show_msgbox "Failed to assign the IP address temporarily."
        return 1
    fi

	# Set the default gateway
	get_gateway
	validate_gateway "$gateway"
    ip route add default via "$gateway"
    if [ $? -ne 0 ]; then
        show_msgbox "Error: Failed to set the default gateway."
        return 1
    fi

	show_msgbox "Temporary IP address $ip_address/$subnet_mask Statically assigned to $interface."
}

# Function to assign a static IP address permanently to an interface
assign_static_ip_permanently() {
    # Check if NetworkManager is installed
    check_install_package "network-manager"

    # Get IP address from user
    get_ip_from_user

    # Assign the IP address permanently by updating /etc/network/interfaces
    echo -e "auto $interface_name\niface $interface_name inet static\n\taddress $ip_address" | tee -a /etc/network/interfaces > /dev/null

	# Restart the networking service to apply the changes
    systemctl restart networking

	# Modify connection using nmcli
    if ! nmcli connection modify "$selected_interface" ipv4.address "$ip_address/$subnet_mask"; then
        echo "Failed to assign the IP address permanently." >&2
        return 1
    fi
  show_msgbox "Permanent IP address $ip_address/$subnet_mask Statically assigned to $interface."
}