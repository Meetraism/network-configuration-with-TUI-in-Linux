#!/bin/bash

# Function to display a message box
show_message() {
  local title="$1"
  local message="$2"
  whiptail --title "$title" --msgbox "$message" 10 40
}

# Ask the user if they want to proceed
if whiptail --title "Confirmation" --yesno "Do you want to proceed?" 10 40; then
  # User chose "Yes"
  show_message "Success" "Operation completed successfully!"
else
  # User chose "No" or closed the dialog
  show_message "Cancelled" "Operation cancelled."
fi
