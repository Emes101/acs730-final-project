# ACS730 Final Project – Two-Tier Web Application Automation with Terraform

## Overview

This project deploys Dev, Staging, and Prod environments on AWS using Terraform.

The solution includes:

- VPCs and Subnets
- Application Load Balancers (ALB)
- Launch Templates
- Security Groups
- Auto Scaling Groups (ASG)
- GitHub Actions (TFLint and Trivy)
- Website hosting with images loaded from Amazon S3

---

## Prerequisites

Before deployment:

1. AWS Academy Learner Lab account
2. Terraform installed
3. Git installed
4. AWS credentials configured
5. S3 buckets created:
   - Terraform remote state bucket
   - Image bucket
6. Website image uploaded manually into the S3 bucket

---

## Project Structure

```text
acs730-final-project/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
├── modules/
│   ├── networking/
│   ├── security-group/
│   ├── alb/
│   ├── launch-template/
│   └── autoscaling/
└── .github/workflows/
```

## Deployment

### Clone Repository

```bash
git clone https://github.com/Emes101/acs730-final-project.git
cd acs730-final-project
```

### Deploy Dev

```bash
cd environments/dev
terraform init
terraform apply
```

### Deploy Staging

```bash
cd ../staging
terraform init
terraform apply
```

### Deploy Prod

```bash
cd ../prod
terraform init
terraform apply
```

After deployment Terraform outputs the Load Balancer DNS used to access the website.

---

## Cleanup

Destroy resources in reverse order.

### Prod

```bash
cd environments/prod
terraform destroy
```

### Staging

```bash
cd ../staging
terraform destroy
```

### Dev

```bash
cd ../dev
terraform destroy
```

---

## GitHub Actions

The repository uses:

- TFLint
- Trivy

for automated Terraform linting and security scanning.

---

## S3 Image Requirement

Website images are stored in a private Amazon S3 bucket and downloaded to EC2 instances during startup.

The website displays images loaded from Amazon S3 as required by the assignment.

