#!/bin/bash
set -e
# visualiza info
# lsblk -o NAME,MOUNTPOINT,SIZE,FSTYPE
# execução com sudo su

# Cria e monta o EBS extra (xvdb ou nvme1n1 dependendo do tipo da instância)
DEVICE=/dev/xvdb
sudo mkfs -t ext4 $DEVICE
sudo mkdir -p /mnt/ebs
sudo mount $DEVICE /mnt/ebs


# Montagem automática no boot
UUID=$(blkid -s UUID -o value $DEVICE)
sudo echo "UUID=$UUID /mnt/ebs ext4 defaults,nofail 0 2" >> sudo /etc/fstab


# Para o Docker antes de mover os dados
sudo systemctl enable docker
sudo service docker stop
sudo service containerd stop

# Cria pasta para o Docker no EBS
sudo mkdir -p /mnt/ebs/docker

# # Move dados existentes do Docker (se houver)
# rsync -aP /var/lib/docker/ /mnt/ebs/docker/ || true
# sudo rsync -aP /var/lib/containerd/ /mnt/ebs/docker/containerd/ || true

# # Remove dados antigos do Docker
# rm -rf /var/lib/docker 
# rm -rf /var/lib/containerd/ 

# Configura Docker para usar o EBS
sudo mkdir -p /etc/docker
cat <<'EOT' > sudo /etc/docker/daemon.json
{
"data-root": "/mnt/ebs/docker"
}
EOT

# alterar permissões
sudo chown -R root:docker /mnt/ebs/docker
sudo chmod -R 711 /mnt/ebs/docker

# alterar arquivo container
# sudo containerd config default > /etc/containerd/config.toml
# root = "/mnt/ebs/containerd"


# Reinicia Docker
sudo systemctl daemon-reexec
sudo service docker start
sudo service containerd start
