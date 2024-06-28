provider "aws" {
  region = "ap-south-1"
}

module "eks" {
  source          = "../modules/eks"
  region          = var.dev_aws_region
  vpc_cidr        = var.dev_vpc_cidr
  public_subnets  = var.dev_public_subnets
  private_subnets = var.dev_private_subnets 
  environment     = var.dev_env
  desired_size    = var.dev_desired_size
  max_size        = var.dev_max_size
  min_size        = var.dev_min_size
  instance_types  = var.dev_instance_types
  ec2_ssh_key     = var.dev_ec2_ssh_key
  tags            = var.dev_tags

}