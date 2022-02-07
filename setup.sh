sudo apt upgrade

# Install docker if not installed
if [ -x "$(command -v docker)" ]; then
    echo "Docker installed."
else
    echo "Installing docker"
    curl -sSL https://get.docker.com | sh
    sudo usermod -aG docker pi
    sudo usermod -aG docker ${USER}
    groups ${USER}
fi

# Install docker compose
sudo apt-get install -y  libffi-dev libssl-dev python3-dev python3 python3-pip
sudo pip3 install docker-compose

# Initialise docker on restart
sudo systemctl enable docker

# Start building docker stack
docker-compose up -d
sleep 10
docker ps