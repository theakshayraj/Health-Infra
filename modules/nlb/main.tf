
module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "project-health-nlb"

  load_balancer_type = "network"

   vpc_id          = var.vpc_nlb
   subnets         = var.subnet_nlb

  

  target_groups = [
{
      name_prefix      = "ssh"
      backend_protocol = "TCP"
      backend_port     = 22
      
      target_type      = "instance"
    },
    {
      name_prefix      = "ptnr"
      backend_protocol = "TCP"
      backend_port     = 5050
      
      target_type      = "instance"
    },
    {
      name_prefix      = "mysql"
      backend_protocol = "TCP"
      backend_port     = 1336
      target_type      = "instance"
    },

    {
      name_prefix      = "mongo"
      backend_protocol = "TCP"
      backend_port     = 1556
      target_type      = "instance"
    },

    {
      name_prefix      = "pg"
      backend_protocol = "TCP"
      backend_port     = 1446
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 22
      protocol           = "TCP"
      target_group_index = 0
    },
    {
      port               = 5050
      protocol           = "TCP"
      target_group_index = 1
    },
    {
      port               = 1336
      protocol           = "TCP"
      target_group_index = 2
    },

    {
      port               = 1556
      protocol           = "TCP"
      target_group_index = 3
    },

    {
      port               = 1446
      protocol           = "TCP"
      target_group_index = 4
    }
  ]

    tags = {
    Project = "terraform_interview"
    Name    = "terraform_asg_cluster"
    BU      = "project-testing"
    Owner   = ""
    Purpose = "health project"
  }
}

output "tg" {
  value = module.nlb.target_group_arns
}
