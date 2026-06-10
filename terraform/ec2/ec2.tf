
# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# # Render a part using a `template_file`
# data "template_file" "script" {
#   template = "${file("${path.module}/init.tpl")}"

#   vars = {
#     consul_address = "${aws_instance.consul.private_ip}"
#   }
# }

# # Render a multi-part cloud-init config making use of the part
# # above, and other source files
# data "template_cloudinit_config" "config" {
#   gzip          = true
#   base64_encode = true

#   # Main cloud-config configuration file.
#   part {
#     filename     = "init.cfg"
#     content_type = "text/cloud-config"
#     content      = "${data.template_file.script.rendered}"
#   }

#   part {
#     content_type = "text/x-shellscript"
#     content      = "baz"
#   }

#   part {
#     content_type = "text/x-shellscript"
#     content      = "ffbaz"
#   }
# }

# Lê arquivos locais
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

  instance_type          = "c7g.medium" # ou "t2.micro" para o menor tamanho

  key_name               = aws_key_pair.my_ec2_key.key_name

  vpc_security_group_ids = [aws_security_group.my-ec2-sg.id]

  availability_zone      = "us-east-1b"
  
  subnet_id = aws_subnet.my_subnet.id

  user_data = <<-EOT
              #!/bin/bash
              set -ex
              exec > >(tee /var/log/user_data.log|logger -t user-data -s 2>/dev/console) 2>&1

              # Cria arquivo1
              cat <<'EOF' > /home/ec2-user/deploy_service.sh
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

              # Ajusta permissões
              chown ec2-user:ec2-user /home/ec2-user/subir_disco_docker.sh
              chmod 777 /home/ec2-user/subir_disco_docker.sh

              chown ec2-user:ec2-user /home/ec2-user/deployment.sh
              chmod 777 /home/ec2-user/deployment.sh

              # usuario ec2-user
              cd /home/ec2-user/

              # subir docker
              ./subir_disco_docker.sh
              ./deployment.sh
              EOT
  


# connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file("./credencial/my-ec2.pem")
#     host        = aws_instance.my-ec2-instance.public_ip
#   }

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

# output "ec2_instance_tags" {
#   value = aws_instance.receita-ec2-instance.tags
# }



# # an empty resource block
# resource "null_resource" "receita" {

#   }

#   # wait for ec2 to be created
#   depends_on = [aws_instance.receita-ec2-instance]

# }
# print the url of the container
# output "container_url" {
#   value = join("", ["http://", aws_instance.ec2_instance.public_dns])
# }

# output "public_ip" {
#   value = aws_instance.receita-ec2-instance.public_ip
# }


# # create security group for the ec2 instance
# resource "aws_security_group" "receita-sg" {
#   name        = "receita-sg"
#   description = "allow access on ports 80 and 22"
#   vpc_id      = "vpc-b00d7ccd"

#   # ingress {
#   #   description = "http access"
#   #   from_port   = 80
#   #   to_port     = 80
#   #   protocol    = "tcp"
#   #   cidr_blocks = ["0.0.0.0/0"]
#   # }

#   ingress {
#     description = "ssh access"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }


# }

# output "ec2_tags" {
#   value = aws_security_group.receita-sg.tags
# }
# 3) Elastic IP
resource "aws_eip" "ec2_eip_n8n" {
  instance = aws_instance.my-ec2-instance.id
  domain   = "vpc"
}

output "public_ip" {
  value = aws_eip.ec2_eip_n8n.public_ip
}


  # user_data = <<-EOF
  #             #!/bin/bash
  #             mkdir -p /home/ec2-user/.ssh
  #             echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcstO52NZuvh/U/T0ZA412+7rG5B1QFKxdKtEfoirDrkudWQ3kP5m07wwM42EFKs6PskEK0wDM/1+hq7RYZuPJXZycPQUrrh+r1JRtzwsf5OhU50Weiel1JHoTI+OsEwMDUVPr13sOK8/ZaPFXB/N2oFTJl8gLCK9BgOklsxmx6XbcQ7V3J+nLN/MIxdz913I400uYb51pClAijU7bG90Sv/K5AQXGxNlTtUZHMDe1TgGI+wJ+K7bPgaauzLp1MnRl5QGAPMYF9NtBm7THzQYuoZHcVjVfQvDguddleriVcvrw3mxpHR+5xlFHl3wJfZ3utQ0wMs6pWRoSLKi+swr1 andre@samelo" >> /home/ec2-user/.ssh/authorized_keys
  #             chmod 600 /home/ec2-user/.ssh/authorized_keys
  #             chown -R ec2-user:ec2-user /home/ec2-user/.ssh
  #             EOF
  
  # user_data_base64 = "${data.template_cloudinit_config.config.rendered}"
  # user_data = each.value.user_data != "" ? file("${path.module}/../${each.value.user_data}") : null


  # user_data = <<-EOF
  #           #!/bin/bash
  #           mkdir -p /home/ec2-user/.ssh
  #           echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcstO52NZuvh/U/T0ZA412+7rG5B1QFKxdKtEfoirDrkudWQ3kP5m07wwM42EFKs6PskEK0wDM/1+hq7RYZuPJXZycPQUrrh+r1JRtzwsf5OhU50Weiel1JHoTI+OsEwMDUVPr13sOK8/ZaPFXB/N2oFTJl8gLCK9BgOklsxmx6XbcQ7V3J+nLN/MIxdz913I400uYb51pClAijU7bG90Sv/K5AQXGxNlTtUZHMDe1TgGI+wJ+K7bPgaauzLp1MnRl5QGAPMYF9NtBm7THzQYuoZHcVjVfQvDguddleriVcvrw3mxpHR+5xlFHl3wJfZ3utQ0wMs6pWRoSLKi+swr1 andre@samelo" >> /home/ec2-user/.ssh/authorized_keys
  #           chmod 600 /home/ec2-user/.ssh/authorized_keys
  #           chown -R ec2-user:ec2-user /home/ec2-user/.ssh
  #           EOF


  # # copy the dockerfile from your computer to the ec2 instance 
  # provisioner "file" {
  #   source      = "Dockerfile"
  #   destination = "/home/ec2-user/Dockerfile"
  # }

  # # copy the dockerfile from your computer to the ec2 instance 
  # provisioner "file" {
  #   source      = "docker-compose.yml"
  #   destination = "/home/ec2-user/docker-compose.yml"
  # }

 # copy the deployment.sh from your computer to the ec2 instance 
  # provisioner "file" {
  #   source      = "deployment.sh"
  #   destination = "/home/ec2-user/deployment.sh"
  # }

  # set permissions and run the build_docker_image.sh file
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo chmod +x /home/ec2-user/deployment.sh",
  #     "sh /home/ec2-user/deployment.sh"
  #   ]
  # }

