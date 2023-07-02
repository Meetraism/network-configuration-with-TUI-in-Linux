#!/bin/bash

# Function to display the menu using whiptail
show_menu() {
    local title=$1
    shift
    local options=("$@")
    local num_options=${#options[@]}
    local height=$((num_options + 6))
    # Prepare the options for whiptail
    local whiptail_options=()
    for ((i = 0; i < ${#options[@]}; i+=2)); do
        whiptail_options+=("$((i/2+1))" "${options[$i]}")
    done

    # Display the menu using whiptail
    choice=$(whiptail --title "$title" --menu "Choose an option:" $height 60 $num_options "${whiptail_options[@]}" 3>&1 1>&2 2>&3)

    # Handle the chosen option
    if [[ $? -eq 0 ]]; then
        local index=$((choice*2-1))
        ${options[$index]}
	#echo "u choose $choice"
    else
        echo "No option chosen. Exiting."
    fi
}