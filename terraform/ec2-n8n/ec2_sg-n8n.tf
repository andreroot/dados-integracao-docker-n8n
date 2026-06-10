

resource "aws_security_group" "n8n-integ_alb" {
  name   = "n8n-integ_alb_sg"
  vpc_id = aws_vpc.n8n-integ_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 443
    to_port     = 443
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


# create security group for the ec2 instance
resource "aws_security_group" "n8n-integ_ec2-sg" {
  name        = "n8n-integ-ec2-sg"
  description = "allow access on ports 80 and 22"
  vpc_id      = aws_vpc.n8n-integ_vpc.id

  # ingress {
  #   description = "http access"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    from_port       = 5678
    to_port         = 5678
    protocol        = "tcp"
    security_groups = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # ingress {
  #   description = "n8n access"
  #   from_port       = 5678
  #   to_port         = 5678
  #   protocol        = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

resource "aws_security_group" "n8n-integ_ec2-rds" {
  name   = "n8n-integ-ec2-rds"
  vpc_id = aws_vpc.n8n-integ_vpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.n8n-integ_alb.id]
  }
}

output "ec2_tags" {
  value = aws_security_group.n8n-integ_ec2-sg.tags
}