output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
}

output "node_group_arn" {
  value = aws_eks_node_group.example.arn
}

output "security_group_ids" {
  #value = [for sg in aws_security_group.eks_security_group : sg.id]
  description = "The IDs of the security groups"
  value       = [aws_security_group.eks_security_group.id]
}

output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "worker_role_arn" {
  value = aws_iam_role.worker_role.arn
}
