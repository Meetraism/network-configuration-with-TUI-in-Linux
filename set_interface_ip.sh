#!/bin/bash
source showMenu.sh

# menu options and corresponding function
IpAssignType=(
	"Assign a temporary IP address" assign_temperary_ip 
    "Assign a permanent IP address" assign_permanent_ip
)

# Function to display the list of network interfaces
display_interfaces() {
	  echo "Available network interfaces:"
	  ip link show | awk -F': ' '/^[0-9]+: [^ ]/ {print $2}'
        }

# Function to assign a temporary IP address to a selected interface
assign_temporary_ip() {
	  read -p "Enter the name of the interface to assign IP address: " interface_name
	  read -p "Enter the IP address (CIDR notation) to assign: " ip_address

	  # Assign the IP address temporarily
    	  ip addr add "$ip_address" dev "$interface_name"
          echo "Temporary IP address $ip_address assigned to $interface_name"
         }

  # Function to assign a permanent IP address to a selected interface
  assign_permanent_ip() {
	    read -p "Enter the name of the interface to assign IP address: " interface_name
	    read -p "Enter the IP address (CIDR notation) to assign: " ip_address

            # Update the interface configuration file to assign the IP address permanently
	    echo -e "auto $interface_name\niface $interface_name inet static\n\taddress $ip_address" | tee -a /etc/network/interfaces > /dev/null

            # Restart the networking service to apply the changes
            sudo systemctl restart networking
	    echo "Permanent IP address $ip_address assigned to $interface_name"
	 }

	# Main script execution
	display_interfaces

	echo "Select an option:"
	echo "1. Assign a temporary IP address"
	echo "2. Assign a permanent IP address"
	read -p "Enter your choice: " choice

	case $choice in
	1)
          	assign_temporary_ip
	;;
	
	2)
		assign_permanent_i
	;;

    *)
		echo "Invalid choice. Exiting."
		exit 1
	;;
	esac

