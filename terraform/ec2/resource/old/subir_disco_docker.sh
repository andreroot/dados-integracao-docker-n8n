#!/bin/bash
set -e

systemctl enable docker
systemctl stop docker

# Cria e monta o EBS extra (xvdb ou nvme1n1 dependendo do tipo da instância)
DEVICE=/dev/xvdb
mkfs -t ext4 $DEVICE
mkdir -p /mnt/ebs
mount $DEVICE /mnt/ebs

# Cria pasta para o Docker no EBS
mkdir -p /mnt/ebs/docker

# Move dados existentes do Docker (se houver)
rsync -aP /var/lib/docker/ /mnt/ebs/docker/ || true

# Configura Docker para usar o EBS
mkdir -p /etc/docker
cat <<'EOT' > /etc/docker/daemon.json
{
"data-root": "/mnt/ebs/docker"
}
EOT

# Montagem automática no boot
UUID=$(blkid -s UUID -o value $DEVICE)
echo "UUID=$UUID /mnt/ebs ext4 defaults,nofail 0 2" >> /etc/fstab

# Reinicia Docker
systemctl daemon-reexec
systemctl start docker
EOF