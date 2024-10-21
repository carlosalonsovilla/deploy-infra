# Overview

This repository automates the creation of a cloud infrastructure using Terraform and Ansible. The project begins by using Terraform to deploy an EC2 instance in AWS. Once the instance is up, Ansible will be used to install Apache, set up a web server, and deploy a basic HTML website. This project is designed for hands-on experience with cloud automation, infrastructure-as-code (IaC), and configuration management.

## Terraform and Ansible: EC2 Deployment and Apache Web Server Setup

### Steps:
1. **Terraform** is used to:
   - Create an EC2 instance in AWS.
   - Configure security groups to allow SSH access from a specific IP.
   - Generate an SSH key pair for secure access to the instance.

2. **Ansible** will be used to:
   - SSH into the EC2 instance.
   - Install Apache on the server.
   - Deploy a sample HTML file to the web root directory.

## Prerequisites
- AWS account with necessary permissions to create EC2 instances.
- Terraform installed on your machine.
- Ansible installed on your machine.
- SSH access to the EC2 instance using the private key.

## How to Run
1. Clone this repository.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Apply the terraform config.
   ```bash
   terraform plan
   terraform apply
   ```
4. Use the generated private key to ssh into the ec2 instance.
5. Run the ansible playbook to install Apache and deploy the website. 

