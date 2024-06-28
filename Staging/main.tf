provider "aws" {
  region = "ap-south-1"
}

module "eks" {
  source          = "../modules/eks"
  region          = var.staging_aws_region
  vpc_cidr        = var.staging_vpc_cidr
  public_subnets  = var.staging_public_subnets
  private_subnets = var.staging_private_subnets
  environment     = var.staging_env
  desired_size    = var.staging_desired_size
  max_size        = var.staging_max_size
  min_size        = var.staging_min_size
  instance_types  = var.staging_instance_types
  ec2_ssh_key     = var.staging_ec2_ssh_key
  tags            = var.staging_tags
}
