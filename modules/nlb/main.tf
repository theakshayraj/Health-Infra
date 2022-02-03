# module "alb" {
#   source = "git@github.com:terraform-aws-modules/terraform-aws-alb.git?ref=v6.0.0"

#   name = "interview-alb"

#   load_balancer_type = "application"

#   vpc_id          = var.vpc_alb
#   subnets         = var.subnet_alb
#   security_groups = [var.sec_group_alb]

#   target_groups = [
#     {
#       name             = "target-group"
#       backend_protocol = "HTTP"
#       backend_port     = 80
#       target_type      = "instance"
#       health_check = {
#         enabled             = true
#         interval            = 110
#         path                = "/"
#         port                = "traffic-port"
#         healthy_threshold   = 3
#         unhealthy_threshold = 3
#         timeout             = 100
#         protocol            = "HTTP"
#         matcher             = "200-399"
#       }
#     }
#   ]

#   http_tcp_listeners = [
#     {
#       port               = 80
#       protocol           = "HTTP"
#       target_group_index = 0
#       action_type        = "forward"
#     }
#   ]

#   tags = {
#     Project = "terraform_interview"
#     Name    = "terraform_asg_cluster"
#     BU      = "project-testing"
#     Owner   = ""
#     Purpose = "health project"
#   }
# }

module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "my-nlb"

  load_balancer_type = "network"

   vpc_id          = var.vpc_nlb
   subnets         = var.subnet_nlb

  # access_logs = {
  #   bucket = "my-nlb-logs"
  # }

  target_groups = [
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

  # https_listeners = [
  #   {
  #     port               = 443
  #     protocol           = "TLS"
  #     # certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
  #     target_group_index = 0
  #   }
  # ]

  http_tcp_listeners = [
    # {
    #   port               = 80
    #   protocol           = "TCP"
    #   target_group_index = 0
    # }

    {
      port               = 3306
      protocol           = "TCP"
      target_group_index = 0
    },

    {
      port               = 27017
      protocol           = "TCP"
      target_group_index = 1
    },

    {
      port               = 5432
      protocol           = "TCP"
      target_group_index = 2
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

# output "nlb_dns" {
#   value = module.nlb.lb_dns_name
# }