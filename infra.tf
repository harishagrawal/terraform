resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "terraformDemoKeyPair"       # Create a "terraformDemoKeyPair" to AWS!!
  public_key = tls_private_key.private_key.public_key_openssh

  provisioner "local-exec" { # Create a "terraformDemoKeyPair.pem" to your computer!!
    command = "echo '${tls_private_key.private_key.private_key_pem}' > ./terraformDemoKeyPair.pem"
  }
}


resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "SG to allow ssh for demo"
  vpc_id      = aws_default_vpc.default.id

  ingress = [
    {
      description      = "ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      self = false
      security_groups = []
      prefix_list_ids = []
    }
  ]

  egress = [
    {
      description      = "all egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      self = false
      security_groups = []
      prefix_list_ids = []
    }
  ]

  tags = {
    Name = "demo-sg"
  }
}

resource "aws_instance" "demo" {
  instance_type = var.instance_type
  ami           = var.default-ami

  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  key_name = aws_key_pair.key_pair.id

  provisioner "file" {
    source      = "./scripts"
    destination = "/tmp"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      host        = self.public_ip
      private_key = file("terraformDemoKeyPair.pem")
    }
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/scripts/docker.sh",
  #     "/tmp/scripts/docker.sh",
  #   ]

  #   connection {
  #     type     = "ssh"
  #     user     = "ubuntu"
  #     host        = self.public_ip
  #     private_key = file("terraformDemoKeyPair.pem")
  #   }
  # }

  tags = {
    type = "demo"
  }
}