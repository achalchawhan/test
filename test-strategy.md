# Test Strategy

## 1. Infrastructure
- Run `terraform plan` before apply to validate resources
- Verify EC2 instances are created with correct security groups
- Test SSH access to all nodes

## 2. Swarm Setup
- After init, run:
  ```bash
  docker node ls
