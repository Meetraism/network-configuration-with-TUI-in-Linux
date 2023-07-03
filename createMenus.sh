#!/bin/bash
source showMenu.sh 
source ./generalConf/changeHostname_func2.sh

# ============ OPTIONS =============

# phase 1 

# options: main menu

mainMenu_options=(
    "General Config" general_conf_menu # main menu > general config - phase 1
    "Firewall Config" firewall_conf_menu
)

# options: main menu > general config

general_main_options=(
    "Change Hostname" setHostname
    "Change DNS" setDNS
    "Set IP" setIP
    "Add/Del Route" addDelroute
    "Back" back_func
    "Exit" exit_func
    )

# options: main menu > firewall config

firewall_main_options=(
    "General NFtables Config" generalNFtables_menu
    "NFtables Wrapper!" NFtablesWrapper_menu
)

# phase 2 - part 1
# options: main menu > firewall config > general NFtables config

generalNFtables_options=(
    "Limit SSH Connections" limitSSH
    "Flush/Reset the NFtables Ruleset" flushNFtables
    "Traffic Redirection" trafficRedirect
    "Disconnecting Internet (Network Isolation)" disconnectInternet
    "Reject Connections from specific user" rejectUserConnection
    "Make current configurations Permanent" makePermanent
    "Back" back_func
    "Exit" exit_func    
    )
NFtablesWrapper_options=(
    "Create Table" createTable
    "Create Chain" createChain
    "Packet Filtering Rules (Limit Access)" packetFilter
    "NAT Rules" createNatRule
)

# phase 2 - part 2
# options: main menu > firewall config > NFtablesWrapper

# ============== ACTIONS ===============

# Define the action functions for each option

back_func() {
   echo "back"
}

exit_func() {
    echo "exit"
}

# actions: main menu

general_conf_menu() { # main menu > general config (phase 1)
    show_menu "General Config" "${general_main_options[@]}"
}

firewall_conf_menu() { # main menu > firewall config (phase 1)
    show_menu "Firewall Config" "${firewall_main_options[@]}"
}

# actions: main menu > general configuration

setHostname() {
    changeHostname
}

setDNS() {
    echo "dns..."
}

setIP() {
    echo "ip..."	
}

addDelRoute() {
    echo "route..."
}


# actions: main menu > firewall config

generalNFtables_menu() {
    show_menu "General NFtables Config" "${generalNFtables_options[@]}"
}

NFtablesWrapper_menu() {
    show_menu "NFtables Wrapper!" "${NFtablesWrapper_options[@]}"
}

# actions: main menu > firewall config > general config

limitSSH() {
    echo "limited"
}

trafficRedirect() {
    echo "redirect"
}

disconnectInternet() {
    echo "disconnect"
}

rejectUserConnection() {
    echo "reject"
}

makePermanent() {
    echo "permanent"
}

# actions: main menu > firewall configuration > wrapper

createTable() {
   echo "table created"
}

createChain() {
    echo "chain created"
}

packetFilter() {
    echo "limit access"
}

createNatRule() {
    echo "nat..."
}

show_menu "Main Menu" "${mainMenu_options[@]}"
