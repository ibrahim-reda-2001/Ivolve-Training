#!/bin/bash
read -p "Enter your AWS Access Key ID" AWS_ACCESS_KEY_ID
read -p "Enter your AWS Secret Access Key" AWS_SECRET_ACCESS_KEY
read -p "Enter your AWS Region" AWS_REGION
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_REGION=$AWS_REGION

