#!/bin/bash
set -e
# visualiza info
# lsblk -o NAME,MOUNTPOINT,SIZE,FSTYPE

# Cria e monta o EBS extra (xvdb ou nvme1n1 dependendo do tipo da instância)
DEVICE=/dev/xvdb
mkfs -t ext4 $DEVICE
mkdir -p /mnt/ebs
mount $DEVICE /mnt/ebs


# Montagem automática no boot
UUID=$(blkid -s UUID -o value $DEVICE)
echo "UUID=$UUID /mnt/ebs ext4 defaults,nofail 0 2" >> /etc/fstab


# Para o Docker antes de mover os dados
systemctl enable docker
systemctl stop docker
systemctl stop containerd


# Cria pasta para o Docker no EBS
mkdir -p /mnt/ebs/docker

# Move dados existentes do Docker (se houver)
rsync -aP /var/lib/docker/ /mnt/ebs/docker/ || true
sudo rsync -aP /var/lib/containerd/ /mnt/ebs/docker/containerd/ || true

# Remove dados antigos do Docker
rm -rf /var/lib/docker 
rm -rf /var/lib/containerd/ 

# Configura Docker para usar o EBS
mkdir -p /etc/docker
cat <<'EOT' > /etc/docker/daemon.json
{
"data-root": "/mnt/ebs/docker"
}
EOT

# alterar permissões
chown -R root:docker /mnt/ebs/docker
chmod -R 711 /mnt/ebs/docker

# alterar arquivo container
# sudo containerd config default > /etc/containerd/config.toml
# root = "/mnt/ebs/containerd"


# Reinicia Docker
systemctl daemon-reexec
systemctl start docker
systemctl start containerd