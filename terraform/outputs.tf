output "public_ip" {
  value = aws_instance.app.public_ip
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}