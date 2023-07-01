#!/bin/bash
#function to display the main menu
show_main_menu() {
	choice=$(whiptail --title "Configuration type" --menu "Choose an option:" 15 30 4 \
		"1" "General Configuration" \
		"2" "Firewall confguration" \
		"3" "Exit" 3>&1 1>&2 2>&3) #????

	case $choice in
		1)
			general_config_func
			;;
		2)
			firewall_config_func
			;;
		3)
			exit 0
			;;
		*) # is it necessary ???
			whiptail --msgbox "inavalid option! Please try again." 8 40 
			show_main_menu
			;;
	esac
}

#function for general config - phase 1 of project

general_config_func() {
	whiptail --title "General Configuration" 
	--menu "Choose an option:" 
	15 30 4 \
	"1" "Change Hostname"
	"2" "Change DNS"
	"3" "Set IP for an Interface"
	"4" "Routing (add/remove routes)"
}

#function for firewall config - phase 2 of project

firewall_config_func() {
	echo "nfTables"
}

#start program by showing the main menu
show_main_menu
