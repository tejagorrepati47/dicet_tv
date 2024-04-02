provider "aws" {
  region = "us-east-1" # Update with your desired region
}

resource "aws_instance" "project1" {
  ami           = "ami-0c55b159cbfafe1f0" # Update with your desired AMI ID
  instance_type = "t2.micro"               # Update with your desired instance type
  key_name      = "your-keypair"           # Update with your key pair name

  tags = {
    Name = "project1"
  }
}
