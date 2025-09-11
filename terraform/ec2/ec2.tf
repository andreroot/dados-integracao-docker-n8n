

# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  # filter {
  #   name   = "name"
  #   values = ["amzn2-ami-hvm*"]
  # }
  # update para image AL2023
  filter {
    name   = "name"
    values = ["al2023-ami-ecs-hvm*"]
  }
}

# create security group for the ec2 instance
resource "aws_security_group" "my-ec2-sg" {
  name        = "my-ec2-sg"
  description = "allow access on ports 80 and 22"
  vpc_id      = aws_vpc.my_vpc.id

  # ingress {
  #   description = "http access"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}


# Lê arquivos locais
data "local_file" "arquivo1" {
  filename = "${path.module}/resource/deployment.sh"
}

data "local_file" "arquivo2" {
  filename = "${path.module}/resource/docker-compose.yml"
}

data "local_file" "arquivo3" {
  filename = "${path.module}/resource/Dockerfile"
}

data "local_file" "arquivo4" {
  filename = "${path.module}/resource/subir_disco_docker.sh"
}

data "local_file" "arquivo5" {
  filename = "${path.module}/resource/deploy_service.sh"
}

# launch the ec2 instance
resource "aws_instance" "my-ec2-instance" {
  ami                    = data.aws_ami.amazon_linux_2.id

  instance_type          = "t2.small" # ou "t2.micro" para o menor tamanho

  key_name               = aws_key_pair.my_ec2_key.key_name

  vpc_security_group_ids = [aws_security_group.my-ec2-sg.id]

  availability_zone      = "us-east-1b"
  
  subnet_id = aws_subnet.my_subnet.id

  user_data = <<-EOT
              #!/bin/bash
              # Cria arquivo1
              cat <<'EOF' > /home/ec2-user/deployment.sh
              ${data.local_file.arquivo1.content}
              EOF

              # Cria arquivo2
              cat <<'EOF' > /home/ec2-user/docker-compose.yml
              ${data.local_file.arquivo2.content}
              EOF

              # Cria arquivo3
              cat <<'EOF' > /home/ec2-user/Dockerfile
              ${data.local_file.arquivo3.content}
              EOF


              # Cria arquivo4
              cat <<'EOF' > /home/ec2-user/subir_disco_docker.sh
              ${data.local_file.arquivo4.content}
              EOF

              # Cria arquivo5
              cat <<'EOF' > /home/ec2-user/deploy_service.sh
              ${data.local_file.arquivo5.content}
              EOF 

              # Ajusta permissões
              chown ec2-user:ec2-user /home/ec2-user/deployment.sh
              chmod 777 /home/ec2-user/deployment.sh

              cd /home/ec2-user/
              ./deployment.sh
              EOT


  depends_on = [aws_security_group.my-ec2-sg]
}


resource "aws_ebs_volume" "volume" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp3"
}

resource "aws_volume_attachment" "attachment" {
  volume_id   = aws_ebs_volume.volume.id
  instance_id = aws_instance.my-ec2-instance.id
  device_name = "/dev/xvdh"
}

# 3) Elastic IP
resource "aws_eip" "ec2_eip" {
  instance = aws_instance.my-ec2-instance.id
  domain   = "vpc"
}

output "public_ip" {
  value = aws_eip.ec2_eip.public_ip
}

output "ec2_tags" {
  value = aws_security_group.my-ec2-sg.tags
}
