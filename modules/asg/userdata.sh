#!/bin/bash

# Get the docker compose file from GitHub
cd /home/ubuntu
sudo git clone https://github.com/anubhavuniyal/DemoInfra && cd /home/ubuntu/DemoInfra
sudo chmod +x setup.sh
./setup.sh
