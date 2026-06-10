
# create security group for the ec2 instance
resource "aws_security_group" "db-pentecoste_ec2-sg" {
  name        = "db-pentecoste-ec2-sg"
  description = "allow access on ports 80 and 22"
  vpc_id      = aws_vpc.db-pentecoste_vpc.id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 15432
    to_port         = 15432
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

output "ec2_tags" {
  value = aws_security_group.db-pentecoste_ec2-sg.tags
}