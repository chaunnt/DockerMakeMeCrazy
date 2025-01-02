
sudo apt-get install -y curl jq 
sudo apt-get install -y iptables-persistent
sudo netfilter-persistent save

#!/bin/bash

# Function to add iptables rules
add_iptables_rule() {
    local ip=$1
    if [[ $ip == *":"* ]]; then
        # IPv6 address
        sudo ip6tables -I INPUT -s "$ip" -j DROP
    else
        # IPv4 address
        sudo iptables -I INPUT -s "$ip" -j DROP
    fi
}

# Array of JSON file URLs
json_urls=(
    "https://developers.google.com/static/search/apis/ipranges/googlebot.json"
    "https://developers.google.com/static/search/apis/ipranges/special-crawlers.json"
    "https://developers.google.com/static/search/apis/ipranges/user-triggered-fetchers.json"
)

# Loop through each JSON URL
for url in "${json_urls[@]}"; do
    # Fetch and parse the JSON
    prefixes=$(curl -s "$url" | jq -r '.prefixes[] | .ipv4Prefix, .ipv6Prefix' | grep -v null)
    for ip in $prefixes; do
        add_iptables_rule "$ip"
    done
done

echo "Blocked all specified Google IP ranges."

sudo iptables -L -v -n
sudo ip6tables -L -v -n

echo "iptables rules saved."