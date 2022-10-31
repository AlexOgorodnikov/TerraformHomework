variable "instance_name" {
        description = "Name of the instance to be created"
        default = "hw-terraform"
}

variable "instance_type" {
        default = "t2.micro"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "subnet-0c3b88d08d2ebd335"
}

variable "ami_id" {
        description = "The AMI to use"
        default = "ami-08c40ec9ead489470"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}


variable "ami_key_pair_name" {
        default = "ansinstances"
}
#tested