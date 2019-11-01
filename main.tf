data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.nano"
  vpc_security_group_ids = [ aws_security_group.server.id ]

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, Terraform!" > index.html
    nohup busybox httpd -f -p "${var.port}" &
  EOF
}

resource "aws_security_group" "server" {
  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
