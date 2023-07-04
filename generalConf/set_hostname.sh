#!/bin/bash
source whiptail_functions.sh
#source create_menus.sh

change_hostname() {

# Display Whiptail input box to get the new hostname
new_hostname=$(show_inputbox "Enter the new hostname:")

# Function to change the hostname temporarily
change_temp_hostname() {
   # new_hostname=$1
    hostname "$new_hostname" 2>/dev/null >/dev/null
	show_msgbox "Temporary Hostname successfully changed to $new_hostname!"
    general_conf_menu
}

# Function to change the hostname permanently
change_perm_hostname() {
   # new_hostname=$1
    sed -i "s/$(cat /etc/hostname)/$new_hostname/g" /etc/hostname >/dev/null 2>&1
    sed -i "s/$(grep 127.0.0.1 /etc/hosts | awk '{print $2}')/$new_hostname/g" /etc/hosts >/dev/null 2>&1
    show_msgbox "Permanent Hostname successfully changed to $new_hostname!"
    general_conf_menu
}

# change hostname | menu options :
options_temp_perm=(
	"Change hostname temporarily" change_temp_hostname 
	"Change hostname permanently" change_perm_hostname
)

# Check if the user entered a hostname
# in other words: checks if the length of new_hostname is non-zero
if [[ -n "$new_hostname" ]]; then
    # Prompt the user to choose between temporary and permanent changes
	show_menu "Select an option:" "${options_temp_perm[@]}"
else
    #echo "No hostname entered. Exiting..."
    show_msgbox "No hostname entered!"
fi
}
