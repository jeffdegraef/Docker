variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION
  default = "${file(\"ssh/insecure-deployer.pub\")}"

}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "deployer-key"
}

variable "region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}

variable "AmiLinux" {
  type = "map"
  default = {
    us-east-1 = "ami-cd0f5cb6"
    us-west-2 = "ami-efd0428f"
  }
  description = "I add only 3 regions (Virginia, Oregon, Ireland) to show the map feature but you can add all the r"
}
variable "access_key" {
  default = "”
  description = "the user aws access key"
}
variable "secret_key" {
  default = "”
  description = "the user aws secret key"
}
