


resource "tls_private_key" "db-pentecoste_ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "db-pentecoste_ec2_key" {
  key_name   = "my-ec2-pentecoste-key-terraform"
  public_key = tls_private_key.db-pentecoste_ec2_private_key.public_key_openssh
}

# resource "aws_key_pair" "my_ec2_key" {
#   key_name   = "my-ec2"
#   public_key = file("/home/andre/.ssh/my-ec2.pub")
# }


output "db-pentecoste_private_key" {
  value     = tls_private_key.db-pentecoste_ec2_private_key.private_key_pem
  sensitive = true
}