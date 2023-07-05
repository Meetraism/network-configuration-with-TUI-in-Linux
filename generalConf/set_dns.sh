#!/bin/bash
source whiptail_functions.sh
source ./generalConf/validation.sh

change_dns() {
    export FAILED=0

    # Display Whiptail input box to get DNS IP from user
    dns_ip=$(show_inputbox "Enter a nameserver ip:")

    validate_ip "$dns_ip"
  
    if [[ $failed != 0 ]]; then
        is_dns_ip "$dns_ip"
    else
        dns_ip=$(show_inputbox "Enter a nameserver ip:")
    fi 

    # Function to change DNS configuration permanently
    change_dns_permanent() {
        if [[ $failed != 0 ]]; then
            # Backup the original resolv.conf file
            cp /etc/resolv.conf /etc/resolv.conf.bak   
            # Create a new resolv.conf file with the specified DNS IP
            echo "nameserver $dns_ip" | tee /etc/resolv.conf > /dev/null   
            show_msgbox "DNS configuration changed permanently."
        else
            show_menu
        fi
    }

    # Function to change DNS configuration temporarily
    change_dns_temporary() {
        # Set the DNS IP using the 'resolvconf' command
        echo "nameserver $dns_ip" | resolvconf -a eth0.inet > /dev/null    
        show_msgbox "DNS configuration changed temporarily."
    }

    # change dns | menu options :
    options_temp_perm=(
        "Change DNS temporarily" change_dns_temporary 
        "Change DNS permanently" change_dns_permanent
    )

    if [[ ! $failed ]]; then
        show_menu "Select an option:" "${options_temp_perm[@]}"
    fi

}
