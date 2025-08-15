variable "GIT_REPOSITORY_NAME" {
    default = "pipeline-site-receita-s3"
    type = string
}

variable "region" {
  default = "us-east-1"
  type    = string
}


variable "aws_access_key_id" {
}


variable "aws_secret_access_key" {
}

variable "environment" {
}


# variable "ECR_REPOSITORY_REGISTRY" {
#   default = "967201331463.dkr.ecr.us-east-1.amazonaws.com"
#   type        = string
# }

# variable "ECR_REPOSITORY_NAME" {
#   default = "dados_webhook_integ"
#   type        = string
# }