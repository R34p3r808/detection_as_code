provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "wazuh_key" {
  key_name   = "wazuh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "wazuh_sg" {
  name        = "wazuh-sg"
  description = "Allow SSH and Wazuh ports"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 1514
    to_port     = 1515
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

resource "aws_instance" "wazuh" {
  ami                         = "ami-0c7217cdde317cfec"  # Ubuntu Server 22.04 LTS in us-east-1
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.wazuh_key.key_name
  vpc_security_group_ids      = [aws_security_group.wazuh_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "wazuh-instance"
  }

  user_data = file("install-wazuh.sh")
}

output "wazuh_instance_ip" {
  value = aws_instance.wazuh.public_ip
}
