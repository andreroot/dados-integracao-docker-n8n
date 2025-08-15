
# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon_linux_2" {
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


# launch the ec2 instance
resource "aws_instance" "receita-ec2-instance" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro" # ou "t2.micro" para o menor tamanho

  # instance_type          = "t3.large"
  vpc_security_group_ids = [aws_security_group.receita-sg.id]
  availability_zone      = "us-east-1b"
  key_name               = "receita-ec2"

  # tags = {
  #   Name = "docker server"
  # }
  #   cpu_options {
  #   core_count       = 2
  #   threads_per_core = 2
  # }

  # ebs_block_device {
  #   device_name   = "/dev/xvda"
  #   volume_size   = 70
  #   volume_type   = "gp3"

  # }

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("receita-ec2.pem")
    host        = aws_instance.receita-ec2-instance.public_ip
  }

  # # copy the dockerfile from your computer to the ec2 instance 
  # provisioner "file" {
  #   source      = "Dockerfile"
  #   destination = "/home/ec2-user/Dockerfile"
  # }

  # # copy the deployment.sh from your computer to the ec2 instance 
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
}

# resource "aws_ebs_volume" "volume" {
#   availability_zone = "us-east-1b"
#   size              = 20
#   type              = "gp3"
# }

# resource "aws_volume_attachment" "attachment" {
#   volume_id   = aws_ebs_volume.volume.id
#   instance_id = aws_instance.receita-ec2-instance.id
#   device_name = "/dev/xvdh"
# }

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
