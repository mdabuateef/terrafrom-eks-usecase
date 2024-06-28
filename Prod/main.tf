provider "aws" {
  region = "ap-south-1"
}

module "eks" {
  source          = "../modules/eks"
  region          = var.prod_aws_region
  vpc_cidr        = var.prod_vpc_cidr
  public_subnets  = var.prod_public_subnets 
  private_subnets = var.prod_private_subnets
  environment     = var.prod_env
  desired_size    = var.prod_desired_size
  max_size        = var.prod_max_size
  min_size        = var.prod_min_size
  instance_types  = var.prod_instance_types
  ec2_ssh_key     = var.prod_ec2_ssh_key
  tags            = var.prod_tags
}
