provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tfexample" {
  ami           = "ami-047a51fa27710816e"
  instance_type = "t2.micro"
  
  tags = {
    Name = "terraform-example"
  }
}