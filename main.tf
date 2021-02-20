provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tfexample" {
  ami                    = "ami-02fe94dee086c0c37"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_instance.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "sg_instance" {
  name = "terraform-sg_instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

output "public_ip" {
  value       = aws_instance.tfexample.public_ip
  description = "The public IP address of the web server"
}