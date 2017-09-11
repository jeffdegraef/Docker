provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = ""
}

resource "aws_security_group" "terraform" {
  name        = "terraform_security"
  description = "Used in the terraform"


  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access for Node-Red
  ingress {
    from_port   = 1880
    to_port     = 1880
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access for MQTT
  ingress {
    from_port   = 1883
    to_port     = 1883
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # HTTP access from the website
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access
  ingress {
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the Norsonic website
  ingress {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "example" {
  ami           = "ami-efd0428f"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer.id}"

  user_data = "${data.template_file.user_data_shell.rendered}"

  tags {
    Name = "Terraform Dicker Node-Red Server"
  }


  # Our Security group to allow HTTP and SSH access
  security_groups = ["terraform_security"]


}

output "ip" {
  value = "${aws_instance.example.public_ip}"
}

output "dns" {
  value = "${aws_instance.example.public_dns}"
}

data "template_file" "user_data_shell" {
  template = "${file("batch.txt")}"
}

output "Node-Red" {
  value = "http://${aws_instance.example.public_dns}:1880"
}