locals{

vpc_id = "vpc-08ddf31f32937734b"

subnet_id = "subnet-016f46d1cadcabd7e"

ssh_user = "ec2-user"

key_name = "mumbai"

private_key_path = "./mumbai.pem"

}

provider "aws" {
region = "ap-south-1"
access_key = "AKIA2DEAK7L05F76ID5N"
secret_key = "+AzGdYaeUtv42EOPN6w/ZM1X3EgGnK+8d06uNlok"
}

resource "aws_security_group" "tomcat" {
name = "tomcat_access"
vpc_id= local.vpc_id
ingress {
from_port - 22
to_port 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 8080
to_port = 8080
protocol - "tcp"
cidr_blocks ["0.0.0.0/0"]

}

egress {
from_port = 0
to_port   =0
protocol  ="-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_instance" "tomcat" {
ami="ami-0451f2687182e0411"
subnet_id=local.subnet_id
instance_type= "t2.micro"
tags = { Name = "terraform-docker" }
associate_public_ip_address = true
security_groups=[aws_security_group.tomcat.id]
key_name=local.key_name

provisioner "remote-exec" {
inline = ["echo 'Wait until SSH is ready""]

connection {
type = "ssh"
user = local.ssh_user
private_key = file(local.private_key_path)
host =aws_instance.tomcat.public_ip
}
}
provisioner "local-exec" {
command = "ansible-playbook -1 $(aws_instance.tomcat.public_ip), --private-key $(local.private_key_path) tomcat.yml"
}
}

output "tomcat_ip" {
value aus instance.tomcat.public_ip
}
