provider "aws" {
  region = var.aws_region
}

# 🔐 Generate SSH key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 🔐 Upload public key to AWS
resource "aws_key_pair" "generated_key" {
  key_name   = "devops-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# 💾 Save private key locally
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "devops-key.pem"
  file_permission = "0400"
}

# 🔥 Security Group (clean + secure)
resource "aws_security_group" "devops_sg" {
  name = "devops-sg"

  # SSH 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # HTTP (nginx)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Grafana
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Prometheus (optional public)
  ingress {
    from_port   = 9090
    to_port     = 9090
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

# 🔍 Latest Ubuntu 22.04
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 🖥️ EC2 Instance
resource "aws_instance" "devops_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name

  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  # 🚀 Setup Docker (modern)
  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y docker.io git

    # install docker compose v2
    mkdir -p /usr/local/lib/docker/cli-plugins
    curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
      -o /usr/local/lib/docker/cli-plugins/docker-compose
    chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

    systemctl start docker
    systemctl enable docker
    usermod -aG docker ubuntu
    EOF

  tags = {
    Name        = "mern-devops-server"
    Environment = "dev"
    Project     = "mern-devops"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Server ready'"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
    }
  }
}