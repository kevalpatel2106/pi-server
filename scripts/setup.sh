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

# Memory monitoring permissions
echo " systemd.unified_cgroup_hierarchy=0 cgroup_enable=memory cgroup_memory=1" >> /boot/cmdline.txt

# Build and start stack
docker-compose up -d
sleep 10
docker ps

# Reboot
sudo reboot