# Full Stack DevOps Deployment using AWS, Terraform, Docker & GitHub Actions

## Project Overview

This project demonstrates end-to-end DevOps automation using AWS cloud services, Terraform Infrastructure as Code (IaC), Docker containerization, and GitHub Actions CI/CD pipeline.

The application is automatically deployed to an AWS EC2 instance whenever code is pushed to the main branch.

---

# Architecture

User → Application Load Balancer (ALB) → EC2 Instance → Docker Container → Flask Application

Infrastructure is provisioned using Terraform.

CI/CD is automated using GitHub Actions.

Docker images are stored in AWS Elastic Container Registry (ECR).

---

# Technologies Used

## Cloud
- AWS EC2
- AWS VPC
- AWS IAM
- AWS ECR
- AWS Elastic IP
- AWS ALB

## DevOps & Automation
- Terraform
- Docker
- GitHub Actions
- Linux
- Bash Scripting

## Application
- Python Flask

---

# Features Implemented

- Infrastructure as Code using Terraform
- Automated CI/CD Pipeline
- Dockerized Application Deployment
- AWS ECR Integration
- EC2 Automated Deployment
- Elastic IP Configuration
- Application Load Balancer
- IAM Role-based Authentication
- Automated Container Restart
- Health Check Validation

---

# Folder Structure

```bash
fullstack-devops-deployment/
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
└── README.md
```

---

# Infrastructure Provisioning using Terraform

The following infrastructure is provisioned:

## VPC
Custom VPC with public and private subnets.

## Public Subnet
Hosts EC2 instance.

## Private Subnet
Prepared for future database deployment.

## Internet Gateway
Provides internet access.

## Route Tables
Routes internet traffic.

## Security Groups
Allows:
- HTTP (80)
- SSH (22)

## EC2 Instance
Runs Dockerized Flask application.

## IAM Role
Allows EC2 to access ECR securely.

## Elastic IP
Provides static public IP.

## Application Load Balancer
Distributes traffic to EC2 instance.

---

# CI/CD Pipeline Workflow

GitHub Actions pipeline performs:

1. Checkout source code
2. Configure AWS credentials
3. Login to AWS ECR
4. Build Docker image
5. Push Docker image to ECR
6. SSH into EC2
7. Pull latest Docker image
8. Restart container automatically
9. Verify deployment

---

# Terraform Commands

## Initialize Terraform

```bash
terraform init
```

## Validate Terraform

```bash
terraform validate
```

## Preview Infrastructure

```bash
terraform plan
```

## Apply Infrastructure

```bash
terraform apply
```

## Destroy Infrastructure

```bash
terraform destroy
```

---

# Docker Commands

## Build Docker Image

```bash
docker build -t app .
```

## Run Container

```bash
docker run -d -p 5000:5000 app
```

## View Running Containers

```bash
docker ps
```

## View Logs

```bash
docker logs container_id
```

---

# GitHub Actions Setup

## Required GitHub Secrets

Add the following secrets in GitHub repository settings:

| Secret Name | Description |
|---|---|
| AWS_ACCESS_KEY_ID | AWS Access Key |
| AWS_SECRET_ACCESS_KEY | AWS Secret Key |
| EC2_HOST | EC2 Elastic IP |
| EC2_SSH_KEY | EC2 Private SSH Key |

---

# Deployment Workflow

Whenever code is pushed to the main branch:

1. GitHub Actions triggers automatically
2. Docker image is built
3. Image is pushed to AWS ECR
4. Deployment starts on EC2
5. Old container is stopped
6. Latest container starts automatically

---

# Security Considerations

- IAM role used for secure ECR access
- Sensitive credentials stored in GitHub Secrets
- Security groups restricted to required ports
- Docker container isolated from host system

---

# Monitoring & Troubleshooting

## Check Docker Containers

```bash
docker ps -a
```

## Check Application Logs

```bash
docker logs app
```

## Check GitHub Actions Logs

GitHub Repository → Actions → Workflow Runs

## SSH into EC2

```bash
ssh -i ec2-key ubuntu@<EC2_PUBLIC_IP>
```

---

# Challenges Faced

## ECR Authentication Failure
Resolved using IAM roles and AWS ECR login command.

## Docker Port Conflict
Resolved by stopping and removing old containers before deployment.

## EC2 Public IP Change
Resolved using Elastic IP.

## GitHub Actions SSH Timeout
Resolved by updating EC2 security group rules and SSH configuration.

---

# Future Improvements

- Kubernetes Deployment
- Auto Scaling Group
- HTTPS using ACM
- Monitoring using Prometheus & Grafana
- Centralized Logging using CloudWatch
- Blue-Green Deployment Strategy

---

# Outcome

Successfully implemented:
- Infrastructure automation
- CI/CD pipeline automation
- Dockerized deployment
- AWS cloud deployment
- Automated application delivery

This project demonstrates practical DevOps, Cloud, Infrastructure Automation, and CI/CD implementation skills.
