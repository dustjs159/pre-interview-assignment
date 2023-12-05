module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
    source = "./modules/sg"
    vpc_id = "./modules.vpc.vpc_id"
}

module "ec2" {
    source = "./modules/ec2"
    vpc_id = "./modules.vpc.vpc_id"
    ec2_security_group = "./modules.sg.ec2_sg_id"
    private_subnet_2a = "./modules.vpc.private_subnet_2a_id"
    private_subnet_2c = "./modules.vpc.private_subnet_2c_id"
    public_subnet_2a = "./modules.vpc.public_subnet_2a_id"
    public_subnet_2c = "./modules.vpc.public_subnet_2c_id"
}

module "alb" {
    source = "./modules/alb"
    vpc_id = "./modules.vpc.vpc_id"
    target_instance_id = "./module.ec2.instance_id"
    alb_security_group = "./modules.sg.alb_sg_id"
    public_subnet_2a = "./modules.vpc.public_subnet_2a_id"
    public_subnet_2c = "./modules.vpc.public_subnet_2c_id"
}

module "route53" {
    source = "./modules/route53"
    alb_arn = "./modules.alb.alb_arn"
    alb_dns_name = "./modules.alb_dns_name"
}