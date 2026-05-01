provider "aws" {
  region = var.region
}

# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# -------------------------
# SUBNETS
# -------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
}

# -------------------------
# INTERNET GATEWAY
# -------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

# -------------------------
# SECURITY GROUP (EC2)
# -------------------------
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -------------------------
# SECURITY GROUP (RDS) ⭐ FIXED
# -------------------------
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
}

# -------------------------
# EC2 INSTANCE
# -------------------------
resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              EOF
}

# -------------------------
# RDS SUBNET GROUP
# -------------------------
resource "aws_db_subnet_group" "db" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private.id]
}

# -------------------------
# RDS POSTGRESQL ⭐ FINAL FIXED VERSION
# -------------------------
resource "aws_db_instance" "postgres" {
  identifier        = "app-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"

  allocated_storage = 20

  db_name  = "appdb"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible     = false
  storage_encrypted       = true
  backup_retention_period = 7

  skip_final_snapshot = true
}
