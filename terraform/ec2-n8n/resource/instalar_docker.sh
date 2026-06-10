curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg


echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER

### ALTERAR PATH DE ARMAZENAMENTO #####

# Para o Docker antes de mover os dados
sudo systemctl enable docker
sudo service docker stop
sudo service containerd stop

# Cria pasta para o Docker no EBS
sudo mkdir -p /data/ebs/docker

# Configura Docker para usar o EBS
sudo mkdir -p /etc/docker
sudo touch /etc/docker/daemon.json

cat <<'EOT' > sudo /etc/docker/daemon.json
{
"data-root": "/data/ebs/docker"
}
EOT

# sudo nano /lib/systemd/system/docker.service
# EDIYTAR ARQUIVO
# ExecStart=/usr/bin/dockerd -g /data/ebs/Docker -H fd://

# alterar permissões
sudo chown -R root:docker /data/ebs/docker
sudo chmod -R 711 /data/ebs/docker

sudo rsync -aqxP /var/lib/docker/ /data/ebs/docker

#docker info | grep "Root Dir"

# ALTERAR PATH CONTAINERD - /var/lib/

sudo chown -R root:docker /data/ebs/containerd
sudo chmod -R 711 /data/ebs/containerd

# ACÕES 
# https://medium.com/@jitendra93266/moving-docker-and-containerd-storage-to-a-custom-directory-on-rhel-9-e-g-app-ac69410838ca
sudo apt install policycoreutils-python-utils

sudo semanage fcontext -a -t container_var_lib_t "/data/ebs/containerd(/.*)?"
sudo restorecon -Rv /data/ebs/containerd

# Reinicia Docker
sudo systemctl daemon-reexec
sudo service docker start
sudo service containerd start
