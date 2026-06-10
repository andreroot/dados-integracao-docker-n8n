
# use data source to get a registered amazon linux 2 ami
data "aws_ami" "pentecoste-ubuntu" {
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


resource "aws_ebs_volume" "db-pentecoste_volume" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp3"
}

resource "aws_volume_attachment" "db-pentecoste_attachment" {
  volume_id   = aws_ebs_volume.db-pentecoste_volume.id
  instance_id = aws_instance.db-pentecoste_instance.id
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

data "local_file" "init" {
  filename = "${path.module}/resource/init.sql"
}


# launch the ec2 instance
resource "aws_instance" "db-pentecoste_instance" {
  ami                    = data.aws_ami.pentecoste-ubuntu.id
  instance_type          = "t3.large" # ou "t2.micro" para o menor tamanho # 
  key_name               = aws_key_pair.db-pentecoste_ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.db-pentecoste_ec2-sg.id]
  availability_zone      = "us-east-1b"
  subnet_id = aws_subnet.db-pentecoste_subnet.id


  user_data = <<-EOT
              #!/bin/bash
              set -ex
              exec > >(tee /var/log/user_data.log|logger -t user-data -s 2>/dev/console) 2>&1

              sudo mkfs -t xfs -f /dev/nvme1n1
              sudo mkdir -p /data/ebs
              sudo mount /dev/nvme1n1 /data/ebs

              sudo mkdir /data/ebs/postgres_data
              sudo chown -R 999:999  /data/ebs/postgres_data
              sudo chmod 700 /data/ebs/postgres_data

              sudo mkdir /data/ebs/pgadmin_data
              sudo chown -R 999:999  /data/ebs/pgadmin_data
              sudo chmod 700 /data/ebs/pgadmin_data

              # Cria deployment
              cat <<'EOF' > /home/ubuntu/instalar_docker.sh
              ${data.local_file.instalardocker.content}
              EOF

              # Cria dockercompose
              cat <<'EOF' > /home/ubuntu/docker-compose.yml
              ${data.local_file.dockercompose.content}
              EOF


              # Cria init
              cat <<'EOF' > /home/ubuntu/init.sql
              ${data.local_file.init.content}
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
  

  depends_on = [aws_security_group.db-pentecoste_ec2-sg]
  tags = {
    Name = "db-pentecoste"
  }
}


resource "aws_eip" "db-pentecoste_eip" {
  instance = aws_instance.db-pentecoste_instance.id
  domain   = "vpc"
}

output "db-pentecoste_public_ip" {
  value = aws_eip.db-pentecoste_eip.public_ip
}
