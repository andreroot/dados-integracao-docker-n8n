#!/bin/bash
set -e
# visualiza info
export NGROK_AUTHTOKEN=
export HASH_WORKER=
#echo $(uuidgen | tr -d '-')

# create directories
sudo mkdir /mnt/ebs/n8n_data

sudo chown -R 1000:1000 /mnt/ebs/n8n_data

# create directories
sudo mkdir /mnt/ebs/db-data

sudo chown -R 999:999 /mnt/ebs/db-data

# usuario ec2-user
cd /home/ec2-user/

# subir docker
docker-compose up -d

