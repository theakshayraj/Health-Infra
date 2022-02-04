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

# Create mount points for docker volumes, so that data can persist
sudo mkdir /usr/share/mysql && sudo chmod 777 /usr/share/mysql
sudo mkdir /usr/share/postgres && sudo chmod 777 /usr/share/postgres
sudo mkdir /usr/share/mongodb && sudo chmod 777 /usr/share/mongodb

# Get the docker compose file from GitHub
cd /home/ubuntu
git clone https://github.com/anubhavuniyal/DemoInfra && cd /home/ubuntu/DemoInfra
sudo docker-compose up -d
sleep 100

# Copy mock data to their respective docker container mount points, so that the container can access them to execute
sudo cp /home/ubuntu/DemoInfra/mockdata.sql /usr/share/mysql
sudo cp /home/ubuntu/DemoInfra/AddDummyData.sh /usr/share/mysql
sudo cp /home/ubuntu/DemoInfra/mockdata.sql /usr/share/postgres
sudo cp /home/ubuntu/DemoInfra/AddDummyData.sh /usr/share/postgres
sudo cp /home/ubuntu/DemoInfra/mockdata.json /usr/share/mongodb
sudo cp /home/ubuntu/DemoInfra/AddDummyData.sh /usr/share/mongodb


# Docker exec to insert mock data into databases
sudo docker exec mysql_db /bin/bash /var/lib/mysql/AddDummyData.sh --mysql
sudo docker exec postgresql_db /bin/bash /var/lib/postgresql/data/AddDummyData.sh --postgres
sudo docker exec mongo_db /bin/bash /data/db/AddDummyData.sh --mongodb