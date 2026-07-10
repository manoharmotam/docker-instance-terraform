resource "aws_instance" "docker" {
  ami                    = local.ami
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.docker_sg.id]
  user_data = templatefile("${path.module}/docker.sh.tftpl", {
    partition_number = 4
    extend_size      = 30
  })

  root_block_device {
    delete_on_termination = true
    volume_size           = 50
    volume_type           = "gp3"

    tags = {
      "Name"       = "Docker-volume"
      "Managed By" = "Terraform"
    }
  }

  tags = {
    "Name"       = "Docker-instance"
    "Managed By" = "Terraform"
  }
}

resource "aws_security_group" "docker_sg" {
  name   = "docker"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = local.my_ip
  }
  ingress {
    from_port   = 80
    to_port     = 90
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8000
    to_port     = 9000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"       = "Docker-instance"
    "Managed By" = "Terraform"
  }
}