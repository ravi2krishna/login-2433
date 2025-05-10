module "login_vpc" {
  source             = "./vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "us-west-2a"
  vpc_name           = "login"
}

module "login_ec2" {
  source                 = "./ec2"
  ami                    = "ami-03f8acd418785369b"
  instance_type          = "t2.micro"
  subnet_id              = module.login_vpc.public_subnet_id
  vpc_security_group_ids = [module.login_vpc.public_sg_id]
  key_name               = "2433"
  user_data              = file("login_app.sh")
  instance_name          = "login"
}

output "instance_ip" {
  value = module.login_ec2.instance_ip
}
