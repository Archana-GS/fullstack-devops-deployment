output "public_ip" {
  value = aws_eip.app_eip.public_ip
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}