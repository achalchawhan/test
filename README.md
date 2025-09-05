# DevOps Tech Test

This repository contains a sample project to demonstrate Infrastructure as Code, Docker Swarm setup, and application deployment.

## Contents
- **infrastructure/** → Terraform code for AWS
- **swarm-setup/** → Scripts to initialize and join Swarm nodes
- **app/** → Node.js backend + Nginx reverse proxy

## Steps to Run

### 1. Provision Infrastructure
```bash
cd infrastructure
terraform init
terraform apply
