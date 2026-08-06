module "networking" {
  source = "../../modules/networking"

  environment = "Staging"

  vpc_cidr = "10.200.0.0/16"

  public_subnet_1 = "10.200.1.0/24"
  public_subnet_2 = "10.200.2.0/24"
  public_subnet_3 = "10.200.3.0/24"

  private_subnet_1 = "10.200.11.0/24"
  private_subnet_2 = "10.200.12.0/24"
  private_subnet_3 = "10.200.13.0/24"

  az_1 = "us-east-1a"
  az_2 = "us-east-1b"
  az_3 = "us-east-1c"
}

module "security_group" {
  source = "../../modules/security-group"

  environment = "Staging"

  vpc_id = module.networking.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  environment = "Staging"

  vpc_id = module.networking.vpc_id

  public_subnet_ids = module.networking.public_subnet_ids

  alb_security_group_id = module.security_group.alb_security_group_id
}

module "launch_template" {
  source = "../../modules/launch-template"

  environment = "Staging"

  instance_type = "t3.small"

  web_security_group_id = module.security_group.web_security_group_id

  instance_profile_name = "LabInstanceProfile"
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  environment = "Staging"

  launch_template_id = module.launch_template.launch_template_id

  private_subnet_ids = module.networking.private_subnet_ids

  target_group_arn = module.alb.target_group_arn

  min_size         = 3
  max_size         = 6
  desired_capacity = 3
}