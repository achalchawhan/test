# Architecture Overview

## Infrastructure
- Provisioned using **Terraform**.
- AWS resources created:
  - **VPC** with a public subnet
  - **Internet Gateway** and **Route Table**
  - **Security Group** with rules for SSH (22), HTTP (80), HTTPS (443), and Swarm ports (2377, 7946, 4789).
  - **EC2 Instances**:
    - 1 Manager
    - 2 Workers

## Container Orchestration
- Orchestration is handled by **Docker Swarm**.
- Manager node initializes the swarm and generates a join token.
- Worker nodes join using the token.
- An **overlay network** ensures service-to-service communication across nodes.

## Application
- **Backend**: A Node.js Express application running on port 3000.
- **Reverse Proxy**: Nginx forwards traffic from port 80 to backend.
- **Compose File**: Uses `docker-compose.yml` (Swarm-compatible) with:
  - 2 replicas of backend
  - 1 replica of nginx
- Deployment uses:
  ```bash
  docker stack deploy -c docker-compose.yml techtest
