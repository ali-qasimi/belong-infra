variable "eks_iam_role_name" {
  type = string
  default = "eks-iam-role"
}

variable "eks_cluster_name" {
  type = string
  default = "belong-eks"
}

variable "environment" {
  type = string
  default = "prod"
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_a" {
  type = string
  default = "10.0.2.0/24"
}

variable "private_subnet_b" {
  type = string
  default = "10.0.3.0/24"
}

variable "private_subnet_c" {
  type = string
  default = "10.0.4.0/24"
}

variable "eks_node_group_name" {
  type = string
  default = "belong-node-group"
}

variable "eks_node_group_iam_role" {
  type = string
  default = "belong-node-group-iam-role"
}

variable "instance_types" {
  type = list(string)
  default = [ "t3a.medium" ]
}

variable "ssh_key_name" {
  type = string
  default = "node-group-ssh-key"
}