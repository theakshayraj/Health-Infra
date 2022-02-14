
module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  tags = [
   {
    app_name        = "Interview-Health"
    lob             = "health"
    team            = "devops"
    owner           = "devops@acko.tech"
  }
  ]

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
      backend_port     = 50500
      
      target_type      = "instance"
    },
    {
      name_prefix      = "mysql"
      backend_protocol = "TCP"
      backend_port     = 13360
      target_type      = "instance"
    },

    {
      name_prefix      = "mongo"
      backend_protocol = "TCP"
      backend_port     = 15560
      target_type      = "instance"
    },

    {
      name_prefix      = "pg"
      backend_protocol = "TCP"
      backend_port     = 14460
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
      port               = 443
      protocol           = "TCP"
      target_group_index = 1
    },
    {
      port               = 13360
      protocol           = "TCP"
      target_group_index = 2
    },

    {
      port               = 15560
      protocol           = "TCP"
      target_group_index = 3
    },

    {
      port               = 14460
      protocol           = "TCP"
      target_group_index = 4
    }
  ]
}

output "tg" {
  value = module.nlb.target_group_arns
}
