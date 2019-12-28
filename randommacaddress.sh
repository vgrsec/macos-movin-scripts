#!/bin/bash
# Source: http://osxdaily.com/2010/11/10/random-mac-address-generator/

# This gets a random mac address

macaddressen1=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//');
macaddressen0=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//');

# This sets the hostname of the laptop to the random word
ifconfig en1 ether $macaddressen1
ifconfig en0 ether $macaddressen0

