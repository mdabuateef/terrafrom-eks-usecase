/*provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  tags = var.tags
}

data "aws_availability_zones" "available" {}

# Subnets
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = var.tags
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = var.tags
}

# Route Table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "public_rt_assoc" {
  count = length(var.public_subnets)
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# IAM Role for EKS Cluster
data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.environment}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public_subnet[*].id
  }
}

# IAM Role for Worker Nodes
data "aws_iam_policy_document" "worker_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "worker_role" {
  name               = "eks-worker-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.worker_assume_role.json
}

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_role.name
}

# EKS Node Group
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "example-node-group"
  node_role_arn   = aws_iam_role.worker_role.arn
  subnet_ids      = aws_subnet.public_subnet[*].id

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = var.instance_types

  remote_access {
    ec2_ssh_key = var.ec2_ssh_key
  }

  tags = var.tags
}*/


provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
}

data "aws_availability_zones" "available" {}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags                    = merge(var.tags, { "Type" = "Public" })
}

#Private Subnets
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.tags, { "Type" = "Private" })
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags   = var.tags
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

#eip 
resource "aws_eip" "nat_eip" {
  count = length(var.public_subnets)
  domain  = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.public_subnets)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  tags          = var.tags
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gw[*].id, count.index % length(var.public_subnets))
  }
  tags = var.tags
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}

# IAM Role for EKS Cluster
data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.environment}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = concat(aws_subnet.public_subnet[*].id, aws_subnet.private_subnet[*].id)
  }
}

# IAM Role for Worker Nodes
data "aws_iam_policy_document" "worker_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "worker_role" {
  name               = "eks-worker-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.worker_assume_role.json
}

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_role.name
}

# EKS Node Group
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.environment}-node-group"
  node_role_arn   = aws_iam_role.worker_role.arn
  subnet_ids      = aws_subnet.private_subnet[*].id

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = var.instance_types

  remote_access {
    ec2_ssh_key = var.ec2_ssh_key
  }

  tags = var.tags
}
# Security Group for EKS Cluster
resource "aws_security_group" "eks_security_group" {
  vpc_id = aws_vpc.eks_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-eks-cluster-sg"
  }
}
