#!/bin/bash

changeHostname() {

# Function to change the hostname temporarily
change_temp_hostname() {
    new_hostname=$1
    sudo hostname "$new_hostname"
    # echo "Temporary hostname changed to: $new_hostname"
    whiptail --msgbox "Temporary Hostname successfully changed to $new_hostname!" 8 40
}

# Function to change the hostname permanently
change_perm_hostname() {
    new_hostname=$1
    sudo sed -i "s/$(cat /etc/hostname)/$new_hostname/g" /etc/hostname
    sudo sed -i "s/$(grep 127.0.0.1 /etc/hosts | awk '{print $2}')/$new_hostname/g" /etc/hosts
    # echo "Permanent hostname changed to: $new_hostname"
    whiptail --msgbox "Permanent Hostname successfully chnged to $new_hostname!" 8 40
}

# Display Whiptail input box to get the new hostname
new_hostname=$(whiptail --inputbox "Enter the new hostname:" 10 40 "" 3>&1 1>&2 2>&3)

# Check if the user entered a hostname
if [[ -n "$new_hostname" ]]; then
    # Prompt the user to choose between temporary and permanent changes
    choice=$(whiptail --menu "Choose an option:" 12 60 5 \
        "1" "Change hostname temporarily" \
        "2" "Change hostname permanently" \
        3>&1 1>&2 2>&3)
    
    case $choice in
        1)
            change_temp_hostname "$new_hostname";;
        2)
            change_perm_hostname "$new_hostname";;
        *)
            # echo "Invalid choice. Exiting...";;
	    whiptail --msgbox "Invalid choice!" 8 40;;
    esac
else
    #echo "No hostname entered. Exiting..."
    whiptail --msgbox "No hostname entered!" 8 40
fi

}
