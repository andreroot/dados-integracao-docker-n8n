#!/bin/bash
set -e
# visualiza info

# install and configure docker on the ec2 instance
sudo yum update -y

sudo amazon-linux-extras install epel -y
sudo yum install docker -y
sudo amazon-linux-extras install docker -y
sudo yum install htop -y
sudo yum install git -y
sudo yum groupinstall "Development Tools" -y
sudo yum install -y gcc gcc-c++ make glibc libstdc++ libstdc++.so*

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# create a dockerfile
sudo chown $USER /var/run/docker.sock

sudo service docker start
sudo systemctl enable docker
sudo systemctl enable containerd

