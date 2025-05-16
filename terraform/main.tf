module "vpc" {
  source = "./modules/vpc"
}

module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.vpc.vpc_id
}

module "launch_template" {
  source         = "./modules/launch_template"
  ami_id         = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (us-east-1)
  instance_type  = "t3.micro"
  key_name       = "docker_project"
  ec2_sg_id      = module.security_groups.ec2_sg_id
  aws_region     = "us-east-1"
  ecr_url        = "321552776361.dkr.ecr.us-east-1.amazonaws.com"
  backend_image  = "banking-backend"
}

module "rds" {
  source               = "./modules/rds"
  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  rds_sg_id            = module.security_groups.rds_sg_id
  db_name              = "bankingdb"
  db_username          = var.db_username
  db_password          = var.db_password
}

module "alb" {
  source           = "./modules/alb"
  alb_sg_id        = module.security_groups.alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id           = module.vpc.vpc_id
}

module "asg" {
  source              = "./modules/asg"
  max_size            = 3
  min_size            = 1
  desired_capacity    = 1
  launch_template_id  = module.launch_template.launch_template_id
  private_subnet_ids  = module.vpc.private_web_subnet_ids
  target_group_arn    = module.alb.target_group_arn
}

module "s3_cloudfront" {
  source      = "./modules/s3_cloudfront"
  bucket_name = "docker-project-frontend-bucket1989" 
}
