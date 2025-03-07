#!/bin/bash
read -p "Enter the VPC CIDR block: " vpc_cidr
read -p "Enter the VPC name: " vpc_name
aws ec2 create-vpc --cidr-block $vpc_cidr --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=$vpc_name}]"
 