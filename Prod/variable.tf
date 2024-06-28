variable "prod_aws_region" {
    description = "aws region"
    type        = string
}
variable "prod_vpc_cidr" {
    description = "cidr value for prod"
    type        = string
}
variable "prod_public_subnets" {
    description = "cidr value for prod public_subnets"
    type        = list(string)
}
variable "prod_private_subnets" {
    description = "cidr value for prod private_subnets"
    type        = list(string)
}
variable "prod_env" {
    description = "the environment"
    type        = string
}
variable "prod_desired_size" {
    description = "desired size for prod cluster"
    type        = number
}
variable "prod_max_size" {
    description = "max size for prod cluster"
    type        = number
}
variable "prod_min_size" {
    description = "min size for prod cluster"
    type        = number
}
variable "prod_instance_types" {
    description = "instance type for prod env worker nodes"
    type        = list(string)
}
variable "prod_ec2_ssh_key" {
    description = "ssh key name for ec2 instance"
    type        = string
}
variable "prod_tags" {
  description = "Tags to apply to prod resources"
  type        = map(string)
}