#!/bin/bash

initialize() {
    
    # Install necessary packages
    packages=("apt" "whiptail")
    total=${#packages[@]}
    current=0

    # Create temporary file for capturing progress output
    tmpfile=$(mktemp)

    # Update progress function
    update_progress() {
        current=$((current + 1))
        percent=$((current * 100 / total))
        echo $percent
        echo "Installing ${packages[current-1]}..."
        echo "$percent Installing ${packages[current-1]}" >$tmpfile
    }

    # Show progress dialog
    whiptail --title "Initialization" --gauge "Initializing..." 6 50 0 <$tmpfile &
    pid=$!

    # Perform package installation
    for package in "${packages[@]}"; do
        update_progress
        sleep 1 # Simulating installation time

        # Install package using apt
        apt-get install -y $package >/dev/null 2>&1
    done

    # Clean up temporary file
    rm $tmpfile

    # Wait for progress dialog to finish
    wait $pid

    # Display completion message
    whiptail --msgbox "Initialization completed!" 8 40
}

initialize
