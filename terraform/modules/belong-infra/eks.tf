resource "aws_eks_cluster" "belong_eks" {
  name = join("-", [var.eks_cluster_name, var.environment])
  role_arn = aws_iam_role.eks_iam_role.arn

  vpc_config {
    subnet_ids = [
        aws_subnet.belong_private_subnet_a.cidr_block,
        aws_subnet.belong_private_subnet_b.cidr_block,
        aws_subnet.belong_private_subnet_c.cidr_block
    ]
  }

  depends_on = [ 
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.belong_eks_logging
    ]

    enabled_cluster_log_types = ["api", "audit"]
}

resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "node_group_ssh_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.generated_key.public_key_openssh
}

resource "aws_eks_node_group" "belong_eks_node_group" {
  cluster_name = aws_eks_cluster.belong_eks.name
  node_group_name = join("-", [var.eks_node_group_name, var.environment])
  node_role_arn = aws_iam_role.worker_node_iam_role.arn

  subnet_ids = [ 
    aws_subnet.belong_private_subnet_a.cidr_block,
    aws_subnet.belong_private_subnet_b.cidr_block,
    aws_subnet.belong_private_subnet_c.cidr_block
  ]

  update_config {
    max_unavailable = 1
  }

  instance_types = var.instance_types

  scaling_config {
    desired_size = 1
    min_size = 1
    max_size = 5
  }

  remote_access {
    ec2_ssh_key = aws_key_pair.node_group_ssh_key.key_name
    source_security_group_ids = [ 
      aws_security_group.sg_http_access.id,
      aws_security_group.sg_https_access.id,
      aws_security_group.sg_ssh_access.id
    ]
  }
}