/*# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.eks.eks_vpc.id
}

# Output the Public Subnet IDs
output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.eks.aws_subnet.public_subnet[*].id
}

# Output the EKS Cluster Name
output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.aws_eks_cluster.eks_cluster.name
}

# Output the EKS Cluster Endpoint
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.aws_eks_cluster.eks_cluster.endpoint
}

# Output the EKS Cluster ARN
output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = module.eks.aws_eks_cluster.eks_cluster.arn
}

# Output the Node Group ARN
output "node_group_arn" {
  description = "The ARN of the EKS node group"
  value       = module.eks.aws_eks_node_group.example.arn
}

# Output the Security Group IDs
output "security_group_ids" {
  description = "The IDs of the security groups"
  value       = module.aws_security_group.eks_security_group[*].id
}

# Output the IAM Role for EKS Cluster
output "eks_cluster_role_arn" {
  description = "The ARN of the IAM role for EKS cluster"
  value       =  module.eks.aws_iam_role.eks_cluster_role.arn
}

# Output the IAM Role for Worker Nodes
output "worker_role_arn" {
  description = "The ARN of the IAM role for worker nodes"
  value       =  module.eks.aws_iam_role.worker_role.arn
}
*/

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.eks.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.eks.public_subnet_ids
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name 
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

/*output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}*/

output "node_group_arn" {
  description = "The ARN of the EKS node group"
  value       = module.eks.node_group_arn
}

output "security_group_ids" {
  description = "The IDs of the security groups"
  value       = module.eks.security_group_ids
}

output "eks_cluster_role_arn" {
  description = "The ARN of the IAM role for EKS cluster"
  value       = module.eks.cluster_role_arn
}

output "worker_role_arn" {
  description = "The ARN of the IAM role for worker nodes"
  value       = module.eks.worker_role_arn
}

output "cluster_certificate_authority" {
  description = "The certificate authority data for the EKS cluster"
  value       = module.eks.cluster_certificate_authority
}
