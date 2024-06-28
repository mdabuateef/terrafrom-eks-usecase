variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "instance_types" {
  description = "List of instance types for worker nodes"
  type        = list(string)
}

variable "ec2_ssh_key" {
  description = "SSH key name for EC2 instances"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "private_subnets" {
  description = "CIDR block for the private subnet"
  type        = list(string)
}