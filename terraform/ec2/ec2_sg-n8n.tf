
# create security group for the ec2 instance
resource "aws_security_group" "n8n-integ_ec2-sg" {
  name        = "n8n-integ-ec2-sg"
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

  ingress {
    from_port       = 5678
    to_port         = 5678
    protocol        = "tcp"
    security_groups = [aws_security_group.my-ec2-sg.id]
  }  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

output "ec2_tags" {
  value = aws_security_group.n8n-integ_ec2-sg.tags
}