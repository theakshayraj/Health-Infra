#!/bin/bash
sudo apt update
# Install Docker Using The Lastest Documentation
sudo apt install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg # Official Docker GPG Key
# Setup The Stable Docker Repo
echo “deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable” | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Update Mirrors And Install Docker
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
# Enable Docker Service
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
