
module "asg" {
  source        = "./modules/asg/"
  subnet_asg    = module.network.private_sn_asg
  sec_group_asg = module.network.security_group_id_asg
  target_gp     = module.nlb.tg
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

