module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                 = "project-vpc"
  cidr                 = "10.99.0.0/18"
  azs             = ["ap-south-1a"]
  public_subnets  = ["10.99.0.0/24"]
  private_subnets = ["10.99.3.0/24"]
  enable_dns_hostnames = true
  enable_nat_gateway = true
  single_nat_gateway = true

}

module "security_group_asg" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git?ref=v4.0.0"

  name   = "security-group_asg"
  vpc_id = module.vpc.vpc_id
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "all"
      description = "Open internet"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 5050
      to_port     = 5050
      protocol    = "tcp"
      description = "Pntr"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 1336
      to_port     = 1336
      protocol    = "tcp"
      description = "mysql"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 1446
      to_port     = 1446
      protocol    = "tcp"
      description = "postg"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 1556
      to_port     = 1556
      protocol    = "tcp"
      description = "mongo"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

