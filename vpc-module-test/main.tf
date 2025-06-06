module "Roboshop" {
  source               = "../terraform-vpc-module"
  enable_dns_hostnames = var.enable_dns_hostnames
  common_tags          = var.common_tags
  project_name         = var.project_name
  environment          = var.environment

  #public subnet
  public_subnets_cidr = var.public_subnets_cidr

  #private subnet
  private_subnets_cidr = var.private_subnets_cidr

  #database subnet
  database_subnets_cidr = var.database_subnets_cidr

}





