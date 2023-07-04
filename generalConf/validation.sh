#!bin/bash

# pattern of a valid ip 
pattern="^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"

# validate ip
validate_ip() {
    local ip=$1	
    if ! [[ $ip =~ $pattern ]] ; then # fixed: spaces needed around the operator!
      show_msgbox "${dns_ip} is not valid!"
      # exit 0
      failed=1
    fi
}

# validate subnet
validate_subnet() {
    local subnet=$1 # X.X.X.X/subnet
    if ! [[ "$subnet" =~ ^[0-9]+$ && "$subnet" -le 32 ]]; then
        show_msgbox "Invalid subnet mask: $subnet";
        failed=1
    fi
}


# Test Reachablity 
# Test if ip is a dns server ip
is_dns_ip() {
    local ip=$1	
    if ! dig +short google.com @${dns_ip} &>/dev/null; then # fixed: Double quote to prevent word splitting.
        show_msgbox "${dns_ip} is not a DNS server!"
        failed=1
        # exit 0
    fi
}

# Function to validate and correct the gateway IP address
validate_gateway() {
  local gateway=$1
  # Check if the gateway IP address is in a valid format
  if ! [[ $ip =~ $pattern ]] ; then
    show_msgbox "Error: Invalid gateway IP address format."
    failed=1
    #return 1
  fi

  # Ping the gateway IP address to check reachability
  if ! ping -c 1 -W 1 "$gateway" &> /dev/null; then
#     echo "Gateway IP address is valid: $gateway"
#     return 0
#   else
    show_msgbox "Gateway IP address is unreachable: $gateway"
    failed=1
    # Attempt to find a valid gateway IP address automatically
    local default_route
    default_route=$(ip route | awk '/^default/ {print $3}')
    
    if [ -n "$default_route" ]; then
      show_msgbox "Changing gateway IP to the default route: $default_route"
      gateway="$default_route"
      return 0
    else
      show_msgbox "Failed to find a valid default gateway IP address."
      failed=1
      return 1
    fi
  fi
}

# Function to check if a package is installed and install it if not
check_install_package() {
    local package=$1
    if ! dpkg -s "$package" &> /dev/null 2>&1; then
        apt-get install -y "$package" > /dev/null 2>&1
        return 1
    fi
}