locals {
  name = "project-asg"
}

resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${terraform.workspace}-instance-key"
  public_key = tls_private_key.dev_key.public_key_openssh

  provisioner "local-exec" {    
    command = "echo '${tls_private_key.dev_key.private_key_pem}' > ./${terraform.workspace}-instance-key.pem"
  }

  provisioner "local-exec" {
    command = "chmod 400 ./${terraform.workspace}-instance-key.pem"
  }
}
module "aws_autoscaling_group" {
  
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "4.1.0"

  # Autoscaling group
  name = "project-testing"

  min_size                  = 1
  max_size                  = 5
  desired_capacity          = 2
  wait_for_capacity_timeout = "5m"
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.subnet_asg
  security_groups           = [var.sec_group_asg]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      min_healthy_percentage = 50
    }
  }

  # Launch template
  lt_name     = "foobar"
  description = "Complete launch template example"
  use_lt      = true
  create_lt   = true

  image_id      = "ami-04505e74c0741db8d"
  instance_type = "m5.large"
  key_name      = "${terraform.workspace}-instance-key"
  #user_data_base64 = base64encode(local.user_data)
  user_data_base64 = base64encode(templatefile("${path.module}/userdata.sh", {
  }))

  target_group_arns = var.target_gp

  health_check_grace_period = 300

  tags = [
    {
      key                 = "Project"
      value               = "terraform_interview"
      propagate_at_launch = "true"
    },
    {
      key                 = "Name"
      value               = "project-test"
      propagate_at_launch = "true"
    },
    {
      key                 = "Owner"
      value               = ""
      propagate_at_launch = "true"
    },
    {
      key                 = "Purpose"
      value               = "health project"
      propagate_at_launch = "true"
    }
  ]
}
