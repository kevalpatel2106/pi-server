#!/bin/bash

# Set up OS
sudo apt upgrade
bash log2ram

# Set up docker and docker compose
if [ -x "$(command -v docker)" ]; then
    echo "Docker installed."
else
    echo "Installing docker"
    curl -sSL https://get.docker.com | sh
    sudo usermod -aG docker pi
    sudo usermod -aG docker ${USER}
    groups ${USER}
fi
sudo apt-get install -y  libffi-dev libssl-dev python3-dev python3 python3-pip
sudo pip3 install docker-compose
sudo systemctl enable docker    # Initialise docker on restart

# Install shell in a box
sudo apt install shellinabox

# Memory monitoring permissions
echo " systemd.unified_cgroup_hierarchy=0 cgroup_enable=memory cgroup_memory=1" >> /boot/cmdline.txt

# Power saving
vcgencmd display_power 0    # Turn off HDMI

# Build and start stack
docker-compose up -d
sleep 10
docker ps

echo "Steps remainign:
1. Set up dynamic dns. If using duckDNS here is the guide: https://www.duckdns.org/install.jsp?tab=pi
2. Reboot your PI"
