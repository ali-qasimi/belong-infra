module "belong-infra" {
  source = "./modules/belong-infra"

  eks_cluster_name = "belong-eks"
  environment = "prod"

  vpc_cidr_block = "10.0.0.0/16"
  private_subnet_a = "10.0.2.0/24"
  private_subnet_b = "10.0.3.0/24"
  private_subnet_c = "10.0.4.0/24"
  public_subnet = "10.0.1.0/24"

  instance_types = [ "t3a.medium" ]

}