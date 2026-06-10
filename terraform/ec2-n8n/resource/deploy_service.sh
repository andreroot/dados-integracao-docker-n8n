#!/bin/bash
set -e
# visualiza info
# export NGROK_AUTHTOKEN=
# export HASH_WORKER=
#echo $(uuidgen | tr -d '-')

# create directories


# usuario ec2-user
cd /home/ubuntu/

# subir docker
docker-compose up -d

