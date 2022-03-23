#!/bin/bash

# autoterminate after some time
echo "sudo shutdown now" | at now + 60 minutes

# swapfile
fallocate -l 1G /swapfile
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# install required packages
apt-get update
apt-get install --assume-yes git python3-pip
cd /tmp
git clone https://github.com/abionics/attacker
cd attacker

# install deps
pip3 install -r requirements.txt
# burn, burn
python3 main.py
