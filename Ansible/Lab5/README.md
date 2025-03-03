# Ansible Dynamic Inventory & Apache Deployment

Automate infrastructure discovery using Ansible dynamic inventory and deploy Apache with an Ansible Galaxy role.

---

## Table of Contents
- [Objective](#objective)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [AWS Credentials Configuration](#aws-credentials-configuration)
  - [Dynamic Inventory Setup](#dynamic-inventory-setup)
  - [Apache Role Installation](#apache-role-installation)
  - [Playbook Creation](#playbook-creation)
- [Execution](#execution)
- [Verification](#verification)
- [Alternative: Custom Dynamic Inventory](#alternative-custom-dynamic-inventory)
- [Folder Structure](#folder-structure)
- [Troubleshooting](#troubleshooting)
- [References](#references)

---

## Objective
- Use Ansible dynamic inventory to auto-discover AWS EC2 instances.
- Deploy Apache using the `geerlingguy.apache` role from Ansible Galaxy.

---

## Prerequisites
- Ansible installed on the control node.
- AWS account with running EC2 instances.
- Python libraries `boto3` and `botocore`.
- SSH access to EC2 instances (key pair configured).
- AWS security groups allowing ports 22 (SSH) and 80 (HTTP).

---

## Setup

### AWS Credentials Configuration
Configure AWS credentials using **one** of these methods:

#### **Option 1: Environment Variables**
```bash
export AWS_ACCESS_KEY_ID='YOUR_AWS_ACCESS_KEY'
export AWS_SECRET_ACCESS_KEY='YOUR_AWS_SECRET_KEY'
export AWS_REGION='us-east-1'
```
## Dynamic Inventory Setup
#### **1. Install AWS Collection**
```bash
ansible-galaxy collection install amazon.aws
```
#### **2. Create Inventory File**
```yaml
# aws_ec2.yml
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1  # Replace with your region
keyed_groups:
  - key: tags
    prefix: tag
```   
#### **3. Test Inventory**
```bash
ansible-inventory -i aws_ec2.yml --graph
```
#### **Apache Role Installation**
```bash
ansible-galaxy role install geerlingguy.apache
```
## Playbook Creation
Create install_apache.yml
```yaml
# install_apache.yml
---
- name: Install Apache
  hosts: tag_Role_Web  # Target instances with tag "Role: Web"
  become: yes
  roles:
    - role: geerlingguy.apache
      vars:
        apache_listen_port: 80
 ```
 ## Execution
 ```bash
 ansible-playbook -i aws_ec2.yml install_apache.yml
```
## Folder Structure
```
.
├── ansible.cfg            # Optional configuration
├── aws_ec2.yml           # AWS dynamic inventory
├── install_apache.yml    # Apache playbook
└── roles/
    └── geerlingguy.apache/  # Installed role       

```
