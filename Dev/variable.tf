variable "dev_aws_region" {
    description = "aws region"
    type        = string
}
variable "dev_vpc_cidr" {
    description = "cidr value for dev"
    type        = string
}
variable "dev_public_subnets" {
    description = "cidr value for public_subnets"
    type        = list(string)
}
variable "dev_private_subnets" {
    description = "cidr value for private_subnets"
    type        = list(string)
}
variable "dev_env" {
    description = "the environment"
    type        = string
}
variable "dev_desired_size" {
    description = "desired size for dev cluster"
    type        = number
}
variable "dev_max_size" {
    description = "max size for dev cluster"
    type        = number
}
variable "dev_min_size" {
    description = "min size for dev cluster"
    type        = number
}
variable "dev_instance_types" {
    description = "instance type for dev env worker nodes"
    type        = list(string)
}
variable "dev_ec2_ssh_key" {
    description = "ssh key name for ec2 instance"
    type        = string
}
variable "dev_tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}