
# use data source to get a registered amazon linux 2 ami
data "aws_ami" "n8n-integ_amazon_linux" {
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
resource "aws_instance" "n8n-integ_instance" {
  ami                    = data.aws_ami.n8n-integ_amazon_linux.id
  instance_type          = "c7g.medium" # ou "t2.micro" para o menor tamanho
  key_name               = aws_key_pair.n8n-integ_ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.n8n-integ-sg.id]
  availability_zone      = "us-east-1b"
  subnet_id = aws_subnet.my_subnet.id
  depends_on = [aws_security_group.n8n-integ-sg]
  tags = {
    Name = "n8n-integ"
  }
}


resource "aws_ebs_volume" "n8n-integ_volume" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp3"
}

resource "aws_volume_attachment" "n8n-integ_attachment" {
  volume_id   = aws_ebs_volume.n8n-integ_volume.id
  instance_id = aws_instance.n8n-integ_instance.id
  device_name = "/dev/xvdh"
}

resource "aws_eip" "n8n-integ_eip" {
  instance = aws_instance.n8n-integ_instance.id
  domain   = "vpc"
}

output "n8n-integ_public_ip" {
  value = aws_eip.n8n-integ_eip.public_ip
}



