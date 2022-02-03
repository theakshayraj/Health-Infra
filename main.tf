
module "asg" {
  source        = "./modules/asg/"
  subnet_asg    = module.network.public_sn_asg
  sec_group_asg = module.network.security_group_id_asg
  target_gp     = module.nlb.tg
  # dns_name      = module.efs.dns_name_efs
}

module "network" {
  source = "./modules/network/"
}

module "nlb" {
  source        = "./modules/nlb/"
  vpc_nlb       = module.network.vpc_id_all
  sec_group_nlb = module.network.security_group_id_asg
  subnet_nlb    = module.network.public_sn_asg
}

# module "route53" {
#   source      = "./modules/route53/"
#   dns_alb     = module.alb.alb_dns
#   vpc_route53 = module.network.vpc_id_all
# }
