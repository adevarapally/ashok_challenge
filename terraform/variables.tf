variable "name" {
    description = "The project name to use for unique resource naming"
    type = string
    default = "webserver"
}

variable "vpcid" {
    description = "VPC ID to create resources"
    type = any
    default = "vpc-68dce812"
}

variable "region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"

}

variable "subnet_id" {
    description = "Subnet ID AZ2"
    type = any
    default = "subnet-f9f412d8"
}

variable "instance_type" {
    description = "AWS EC2 Instance type"
    type = any
    default = "t3a.micro"
}
