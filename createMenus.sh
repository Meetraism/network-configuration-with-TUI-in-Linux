#!/bin/bash
source show_menu_func.sh

# options: main menu

mainMenu_options=(
    "General Configuration" generalConf_func
    "Firewall Configuration" firewall_func
)

# options: main menu > general configuration

generalConf_options=(
    "Change Hostname" hostname_func
    "Change DNS" dns_func
    "Set IP" ip_func
    "Add/Del Route" route_func
)


# Define the action functions for each option

generalConf_func() {
    echo "You chose general"
    # Add your code here for handling Option 1
}

firewall_func() {
    echo "You chose firewall"
    # Add your code here for handling Option 2
}

hostname_func() {
    echo "host..."
}

dns_func() {
    echo "dns..."
}

ip_func() {
    echo "ip..."	
}

route_func() {
    echo "route..."
}

show_menu "Main Menu" "${mainMenu_options[@]}"
