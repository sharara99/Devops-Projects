# CloudKode Project

## Overview

The **CloudKode Project** is designed to create a scalable and secure AWS infrastructure using Terraform. This project sets up a Virtual Private Cloud (VPC), subnets, security groups, an Auto Scaling Group (ASG), an Application Load Balancer (ALB), and other resources to host a web application in the AWS cloud.

### Features

- **VPC and Subnets**: Creates a main VPC with public and private subnets.
- **Security Groups**: Configures security groups to manage access to resources.
- **Auto Scaling Group**: Sets up an ASG with EC2 instances to ensure high availability.
- **Load Balancer**: Implements an ALB to distribute incoming traffic to the instances.
- **State Management**: Uses S3 for state storage and DynamoDB for state locking to ensure safe deployments.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- AWS account with appropriate permissions.
- AWS CLI configured with your credentials.

**Task Diagram**

├── README.md
├── backend.tf
├── provider.tf
├── variable.tf
├── terraform.tfvars
├── s3-buckets.tf
├── dynamo.tf
├── vpc.tf
├── route_tables.tf
├── nagw.tf
├── iam_role.tf
├── sg.tf
├── load_balancer.tf
├── auto_scalling_group.tf
├── rsa_private_key.tf
├── sg.tf
├── output.tf