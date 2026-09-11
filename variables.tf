variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_a" {
  description = "Availability Zone for public subnet A"
  type        = string
  default     = "ap-south-1a"
}

variable "availability_zone_b" {
  description = "Availability Zone for public subnet B"
  type        = string
  default     = "ap-south-1b"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c0fd09cfe77b59dc"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "keypair"
}