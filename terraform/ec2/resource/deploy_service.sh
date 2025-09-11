#!/bin/bash
set -e
# visualiza info
export NGROK_AUTHTOKEN=2vls36KLZYno3gHbaO7yr82hTl6_6TBmA8hFU3bsPK79gAupy
export HASH_WORKER=709cef8796be4aea9fe8eab886ffbb8c
#echo $(uuidgen | tr -d '-')

# create directories
mkdir /home/ec2-user/n8n_data

sudo chown -R 1000:1000 /home/ec2-user/n8n_data

# create directories
mkdir /home/ec2-user/db-data

sudo chown -R 999:999 /home/ec2-user/db-data

# usuario ec2-user
cd /home/ec2-user/

# subir docker
docker-compose up -d

