terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}

provider "aws" {
    shared_credentials_file = "~/.aws/credentials"
    region = "us-east-1"
}

resource "aws_instance" "builder" {
    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}"

  provisioner "local-exec" {  
command = "sudo apt update && sudo apt install -y default-jdk maven"
  }

  provisioner "local-exec" {
command = "mkdir /tmp/app"
}

  provisioner "local-exec" {
working_dir = "/tmp/app"
command = "git clone https://github.com/AlexOgorodnikov/Java-app.git"
  }

  provisioner "local-exec" {
working_dir = "/tmp/app/Java-app"
command = "mvn package"
  }

  provisioner "local-exec" {
command = "aws s3 cp /tmp/app/Java-app/target/hello-1.0.war s3://ansible-bucket-hw1"
 }
} 

resource "aws_instance" "appnode" {
    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}" 

provisioner "local-exec" {  
command = "sudo apt update && sudo apt install -y default-jdk tomcat9"
}

provisioner "local-exec" {
command = "aws s3 cp s3://ansible-bucket-hw1/hello-1.0.war /var/lib/tomcat9/webapps"
 }
}
#tested