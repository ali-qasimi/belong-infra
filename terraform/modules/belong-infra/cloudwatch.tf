resource "aws_cloudwatch_log_group" "belong_eks_logging" {

  name              = "/aws/eks/${var.eks_cluster_name}/cluster"
  retention_in_days = 7

}