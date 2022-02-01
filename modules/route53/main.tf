resource "aws_route53_zone" "private" {
  name = "sandboxes.acko.com"

  vpc {
    vpc_id = var.vpc_route53
  }
}
resource "aws_route53_record" "myRecord" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "acko.com"
  type    = "CNAME"
  ttl     = 300
  records = [var.dns_alb]
}

