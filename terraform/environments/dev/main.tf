module "vpc" {

  source = "../../modules/vpc"

  project_name = var.project_name

  environment = var.environment

  cluster_name = var.cluster_name

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs

  admin_cidr = var.admin_cidr

}
