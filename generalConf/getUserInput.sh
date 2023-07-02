#!/bin/bash

# prompt user for input
get_user_input() {
    local title="$1"
    local message="$2"
    local default_value=""


    local input=$(whiptail --title "$title" --inputbox "$message" 8 60 "$default_value" 3>&1 1>&2 2>&3)

    # chack the whiptail exit status
    local status=$?

    # return user input if OK pressed
    # otherwise return an empty string
    if [ $status -eq 0 ]; then # exit status = 0 means user pressed OK
	    echo "$input"
    else # nonzero exit status means user pressed cancel
	    echo ""
    fi
}

# it was a test:
#name=$(get_user_input "Enter:" "plz enter name")
#echo $name
