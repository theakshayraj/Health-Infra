
module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "my-nlb"

  load_balancer_type = "network"

   vpc_id          = var.vpc_nlb
   subnets         = var.subnet_nlb

  

  target_groups = [

    {
      name_prefix      = "ptnr"
      backend_protocol = "TCP"
      backend_port     = 9000
      
      target_type      = "instance"
    },
    {
      name_prefix      = "mysql"
      backend_protocol = "TCP"
      backend_port     = 3306
      target_type      = "instance"
    },

    {
      name_prefix      = "mongo"
      backend_protocol = "TCP"
      backend_port     = 27017
      target_type      = "instance"
    },

    {
      name_prefix      = "pg"
      backend_protocol = "TCP"
      backend_port     = 5432
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    # {
    #   port               = 80
    #   protocol           = "TCP"
    #   target_group_index = 0
    # }
    {
      port               = 9000
      protocol           = "TCP"
      target_group_index = 0
    },
    {
      port               = 3306
      protocol           = "TCP"
      target_group_index = 1
    },

    {
      port               = 27017
      protocol           = "TCP"
      target_group_index = 2
    },

    {
      port               = 5432
      protocol           = "TCP"
      target_group_index = 3
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
