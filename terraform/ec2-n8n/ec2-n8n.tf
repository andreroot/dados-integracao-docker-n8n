
data "aws_ami" "n8n-ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# use data source to get a registered amazon linux 2 ami
# data "aws_ami" "n8n-integ_amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"]
#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }
#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023*"]
#   }
#}  
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "owner-alias"
#     values = ["amazon"]
#   }

#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }
#   # filter {
#   #   name   = "name"
#   #   values = ["amzn2-ami-hvm*"]
#   # }
# }

resource "aws_ebs_volume" "n8n-integ_volume" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp3"
}

resource "aws_volume_attachment" "n8n-integ_attachment" {
  volume_id   = aws_ebs_volume.n8n-integ_volume.id
  instance_id = aws_instance.n8n-integ_instance.id
  device_name = "/dev/xvdb"
}


# Lê arquivos locais
# Lê arquivos locais
data "local_file" "instalardocker" {
  filename = "${path.module}/resource/instalar_docker.sh"
}

data "local_file" "dockercompose" {
  filename = "${path.module}/resource/docker-compose.yml"
}

data "local_file" "dockerfile" {
  filename = "${path.module}/resource/Dockerfile"
}


# launch the ec2 instance
resource "aws_instance" "n8n-integ_instance" {
  ami                    = data.aws_ami.n8n-ubuntu.id
  instance_type          = "t3.large" # ou "t2.micro" para o menor tamanho # 
  key_name               = aws_key_pair.n8n-integ_ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.n8n-integ_ec2-sg.id]
  availability_zone      = "us-east-1b"
  subnet_id = aws_subnet.n8n-integ_subnet.id


  user_data = <<-EOT
              #!/bin/bash
              set -ex
              exec > >(tee /var/log/user_data.log|logger -t user-data -s 2>/dev/console) 2>&1

              sudo mkfs -t xfs /dev/nvme1n1
              sudo mkdir -p /mnt/ebs
              sudo mount /dev/nvme1n1 /mnt/ebs

              sudo mkdir /data/ebs/n8n_data
              sudo chown -R 1000:1000 /data/ebs/n8n_data
              sudo chmod -R 755 /data/ebs/n8n_data

              sudo mkdir /data/ebs/scripts
              sudo chown -R 999:999 /data/ebs/scripts

              # create directories
              sudo mkdir /data/ebs/db-data
              sudo chown -R 999:999 /data/ebs/db-data

              # create directories
              sudo mkdir /data/ebs/redis
              sudo chown -R 999:999 /data/ebs/redis

              # create directories
              sudo mkdir /data/ebs/waha
              sudo chown -R 999:999 /data/ebs/waha

              sudo mkdir /data/ebs/ngrok-config
              sudo chown -R 999:999 /data/ebs/ngrok-config

              # Cria deployment
              cat <<'EOF' > /home/ubuntu/instalar_docker.sh
              ${data.local_file.instalardocker.content}
              EOF

              # Cria dockercompose
              cat <<'EOF' > /home/ubuntu/docker-compose.yml
              ${data.local_file.dockercompose.content}
              EOF

              # Cria dockerfile
              cat <<'EOF' > /home/ubuntu/Dockerfile
              ${data.local_file.dockerfile.content}
              EOF


              # Ajusta permissões
              chown ubuntu:ubuntu /home/ubuntu/instalar_docker.sh
              chmod 777 /home/ubuntu/instalar_docker.sh

              # usuario ubuntu
              cd /home/ubuntu/

              # para gerar key do waha
              touch .env

              # subir docker
              ./instalar_docker.sh
              EOT
  

  depends_on = [aws_security_group.n8n-integ_ec2-sg]
  tags = {
    Name = "n8n-integ"
  }
}


resource "aws_eip" "n8n-integ_eip" {
  instance = aws_instance.n8n-integ_instance.id
  domain   = "vpc"
}

output "n8n-integ_public_ip" {
  value = aws_eip.n8n-integ_eip.public_ip
}



