provider "aws" {
  access_key = "AKIAJNO2FPN3K7R4I7RA"
  secret_key = "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"
  region     = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = "${file("public.pub")}"
}

resource "aws_security_group" "terraform" {
  name        = "terraform_example"
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

  user_data = <<-EOF
              #!/bin/bash
              sudo timedatectl set-timezone Europe/Brussels
              sudo apt-get install python-pip -y
              sudo apt-get install libpq-dev build-essential python-dev -y
              sudo apt-get install git -y
              sudo apt-get install libxml2 libxml2-dev libxslt1-dev -y
              sudo apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev  -y
              sudo apt-get install libwebp-dev tcl8.6-dev tk8.6-dev python-tk -y
              curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
              sudo apt-get install -y nodejs build-essential -y
              sudo apt-get install python-pip -y
              sudo npm install -g --unsafe-perm node-red
              sudo npm install -g pm2
              pm2 start `which node-red` -- -v
              pm2 info node-red
              pm2 save
              pm2 startup systemd
              sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
              pm2 startup systemd
              cd $HOME/.node-red
              sudo npm install node-red-node-mongodb --save
              sudo npm install node-red-contrib-mongodb2 --save
              sudo npm install node-red-contrib-meraki-cmx --save
              sudo npm install node-red-node-twilio --save
              sudo npm install node-red-contrib-spark --save
              sudo npm install node-red-contrib-dns --save
              sudo npm install node-red-contrib-excel --save
              sudo npm install node-red-contrib-googlechart --save
              sudo npm install node-red-contrib-apiai --save
              sudo npm install node-red-contrib-asterisk --save
              sudo npm install node-red-contrib-ftp --save
              sudo npm install node-red-contrib-json --save
              sudo npm install node-red-contrib-slackbot --save
              sudo npm install node-red-node-google --save
              sudo npm install node-red-node-swagger --save
              sudo npm install thethingbox-node-color --save
              sudo npm install thethingbox-node-timestamp --save
              pm2 restart node-red

              EOF

  tags {
    Name = "Terraform Server"
  }


  # Our Security group to allow HTTP and SSH access
  security_groups = ["terraform_example"]


}

output "ip" {
  value = "${aws_instance.example.public_ip}"
}

output "dns" {
  value = "${aws_instance.example.public_dns}"
}
