output "public_ip" {
  description = "Elastic IP of EC2 instance"
  value       = aws_eip.app_eip.public_ip
}

output "alb_dns" {
  description = "Application Load Balancer DNS"
  value       = aws_lb.alb.dns_name
}

output "rds_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = aws_db_instance.postgres.endpoint
}

