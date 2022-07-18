provider "aws" {
  profile = "default"
#  shared_credentials_file = "${HOME}/.aws/credentials"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_key_id
  token      = var.aws_session_token
  region     = var.aws_region
}

provider "tls" {
}
