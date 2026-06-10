


resource "tls_private_key" "n8n-integ_ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "n8n-integ_ec2_key" {
  key_name   = "my-ec2-key-terraform"
  public_key = tls_private_key.n8n-integ_ec2_private_key.public_key_openssh
}

# resource "aws_key_pair" "my_ec2_key" {
#   key_name   = "my-ec2"
#   public_key = file("/home/andre/.ssh/my-ec2.pub")
# }


output "n8n-integ_private_key" {
  value     = tls_private_key.n8n-integ_ec2_private_key.private_key_pem
  sensitive = true
}