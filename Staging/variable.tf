variable "staging_aws_region" {
    description = "aws region"
    type        = string
}
variable "staging_vpc_cidr" {
    description = "cidr value for prod"
    type        = string
}
variable "staging_public_subnets" {
    description = "cidr value for prod public_subnets"
    type        = list(string)
}
variable "staging_private_subnets" {
    description = "cidr value for prod private_subnets"
    type        = list(string)
}
variable "staging_env" {
    description = "the environment"
    type        = string
}
variable "staging_desired_size" {
    description = "desired size for prod cluster"
    type        = number
}
variable "staging_max_size" {
    description = "max size for prod cluster"
    type        = number
}
variable "staging_min_size" {
    description = "min size for prod cluster"
    type        = number
}
variable "staging_instance_types" {
    description = "instance type for prod env worker nodes"
    type        = list(string)
}
variable "staging_ec2_ssh_key" {
    description = "ssh key name for ec2 instance"
    type        = string
}
variable "staging_tags" {
  description = "Tags to apply to prod resources"
  type        = map(string)
}