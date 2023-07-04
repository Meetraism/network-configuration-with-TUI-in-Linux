#!/bin/bash
source whiptail_functions.sh
source validation.sh
source static_ip.sh
source dhcp_ip.sh

# Function to display the list of network interfaces
display_interfaces() {
	  # Get the list of network interfaces
	  interfaces=$(ip link show | awk -F': ' '/^[0-9]+: [^ ]/ {print $2}')
	  # Create an array to hold the menu options (interfaces)
	  interfaces_options=()
	  for interface in $interfaces; do
			interfaces_options+=("$interface" static_or_dhcp_menu)
	  done
	  # Display the whiptail menu and store the selected option
	  selected_interface=$(show_menu "Available Network Interfaces" "${interfaces_options[@]}")
}

static_or_dhcp_menu() {
    # menu options and corresponding functions
    options_static_dhcp=(
        "Static" static_selected 
        "DHCP" dhcp_selected
    )
    # save user option
    selected_static_dhcp=$(show_menu "Select ip assignment type (static/dynamic):" "${options_static_dhcp[@]}")
}

# Function to be executed when user selects "Static"
static_selected() {
    static_flag=1
    dhcp_flag=0
    temp_or_perm_menu
}

# Function to be executed when user selects "DHCP"
dhcp_selected() {
    static_flag=0
    dhcp_flag=1
    temp_or_perm_menu
}


temp_or_perm_menu() {
	options_temp_perm=(
	"Assign a temporary IP address" temp_selected 
    "Assign a permanent IP address" perm_selected
	)
	selected_temp_perm=$(show_menu "Please Select an option:" "${options_temp_perm[@]}")
}

# Function to be executed when user selects "temporary ip addr"
temp_selected() {
    temp_flag=1
    perm_flag=0
    assign_temporary_ip
}

# Function to be executed when user selects "permanent ip addr"
perm_selected() {
    temp_flag=0
    perm_flag=1
    assign_permanent_ip
}


get_gateway() {
	gateway="$(show_inputbox "Enter IP gateway: ")"
	return 1
}

get_ip_from_user() {
	local ip_subnet=$(show_inputbox "Enter IP Address and Subnet (e.g., 192.168.0.1/24): ")
	# Parse the IP address and subnet from the input
	local ip=$(echo "$ip_subnet" | cut -d '/' -f 1)
	local subnet=$(echo "$ip_subnet" | cut -d '/' -f 2)
    # Check if all arguments are provided
	validate_ip "$ip"
	validate_subnet "$subnet"
	# store local vars into global vars
	ip_address=$ip 
	subnet_mask=$subnet
}

