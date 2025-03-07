# AWS VPC with Public/Private Subnets, EC2, and RDS

![Architecture Diagram](https://github.com/ibrahim-reda-2001/photo/blob/master/image.png)

This Terraform configuration deploys a multi-tier AWS infrastructure with:
- A VPC with public and private subnets
- NAT Gateway for private subnet internet access
- EC2 instance in a public subnet (NGINX accessible via HTTP/SSH)
- MySQL RDS instance in private subnets (Multi-AZ)
- Security groups and route tables

## Prerequisites
- AWS account with IAM credentials
- Terraform v1.0+ installed
- AWS CLI configured (`aws configure`)
- Existing VPC to import (CIDR: `10.0.1.0/24`)
- SSH key pair in AWS region `us-east-1`

## Quick Start

### 1. Clone Repository
```bash
git clone <your-repo-url>
cd <repo-directory>
```
## 2. Initialize Terraform
```bash
terraform init
```
## Run script
```bash
chmod +x vpc-create.sh
./vpc-create.sh
```
## 3. Import Existing VPC
```bash
terraform import aws_vpc.main <EXISTING_VPC_ID>
```
## 4. Review Configuration
**Update these values if needed:**

ami in aws_instance.my_ec2 (current: ami-05b10e08d247fb927)

RDS credentials in aws_db_instance.my_rds

CIDR blocks if different from existing VPC
## 5. Apply Configuration
```bash
terraform apply
```
## Cleanup
```bash
terraform destroy
```
