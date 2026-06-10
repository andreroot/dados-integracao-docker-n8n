#!/bin/bash
set -e
# COMANDO INFO VOLUMES
# lsblk -o NAME,MOUNTPOINT,SIZE,FSTYPE
# execução com sudo su

# Cria e monta o EBS extra (xvdb ou nvme1n1 dependendo do tipo da instância)
DEVICE=/dev/xvdb #/dev/xvdh #dev/nvme1n1
sudo mkfs -t ext4 $DEVICE
sudo mkfs -t xfs -f /dev/nvme1n1

sudo mkdir -p /mnt/ebs
sudo mount $DEVICE /mnt/ebs

# Montagem automática no boot
# UUID=$(blkid -s UUID -o value $DEVICE)
# sudo echo "UUID=$UUID /mnt/ebs ext4 defaults,nofail 0 2" >> sudo /etc/fstab
# sudo echo "UUID=$UUID /data/ebs xfs defaults,nofail 0 2" >> sudo /etc/fstab

