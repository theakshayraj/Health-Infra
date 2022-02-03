#!/bin/bash
sudo apt update
# Install Docker Using The Lastest Documentation
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo apt install git-all
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg # Official Docker GPG Key
# Setup The Stable Docker Repo

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update Mirrors And Install Docker
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y

# Enable Docker Service
sudo systemctl enable docker
sudo systemctl start docker

# Create mount points for docker volumes
sudo mkdir /usr/share/mysql && sudo chmod 777 /usr/share/mysql
sudo mkdir /usr/share/postgres && sudo chmod 777 /usr/share/postgres
sudo mkdir /usr/share/mongodb && sudo chmod 777 /usr/share/mongodb

# Get the docker compose file from GitHub
git clone https://github.com/anubhavuniyal/DemoInfra && cd DemoInfra
sudo docker-compose up &
sleep 5