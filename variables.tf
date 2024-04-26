variable "aws_region" {
  description = "The region where the resources will be created."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID within the VPC"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the Jenkins server"
  type        = string
}

variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to the instance"
  type        = string
}