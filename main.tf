module "networking" {
  source = "./modules/networking"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_b_cidr = var.public_subnet_b_cidr
  availability_zone_a  = var.availability_zone_a
  availability_zone_b  = var.availability_zone_b
}

module "compute" {
  source = "./modules/compute"

  environment          = var.environment
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet_id            = module.networking.public_subnet_a_id
  security_group_id    = module.networking.security_group_id
  iam_instance_profile = aws_iam_instance_profile.ec2.name
}