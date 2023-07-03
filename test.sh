#!/bin/bash

show_inputbox() {
	local msg=$1
	local result=$(whiptail --inputbox "$msg" 10 40 "" 3>&1 1>&2 2>&3)
	echo "$result"
}

show_messagebox() {
	local msg=$1
	whiptail --msgbox "$msg" 10 40
}

# Example usage:
input_text=$(show_inputbox "Enter your text:")
show_messagebox "You entered: $input_text"
