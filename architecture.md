<img width="2000" height="1200" alt="architecture-diagram" src="https://github.com/user-attachments/assets/2ca195f5-c8e7-48c7-8b6b-05f284e28219" />








# Architecture Overview

This document explains the system architecture for deploying the Node.js application on AWS using **Docker Swarm**.

## Components

1. **AWS VPC**

   * The entire infrastructure is hosted inside an **AWS Virtual Private Cloud (VPC)** for isolation, security, and control over networking.
   * Ensures private communication between EC2 instances.

2. **Nginx Proxy**

   * Acts as the **entry point** for all incoming user HTTP requests.
   * Handles **reverse proxying** and **load balancing**, directing traffic to the backend services.
   * Provides a scalable way to manage multiple services behind a single endpoint.

3. **Swarm Manager (EC2)**

   * The control plane of the **Docker Swarm cluster**.
   * Responsible for managing services, maintaining the cluster state, and distributing workloads across worker nodes.
   * Deployed on an **EC2 instance** with appropriate IAM roles and security groups.

4. **Worker Nodes (EC2)**

   * Two EC2 instances configured as **Docker Swarm workers**.
   * They execute containers that run the actual **Node.js backend application**.
   * Workloads are distributed across workers for **scalability** and **high availability**.

5. **Node.js Backend**

   * The main application deployed inside Docker containers.
   * Provides REST API / backend services that are consumed by clients.
   * Scaled across worker nodes to handle concurrent requests efficiently.

---

## Request Flow

1. The **user** sends an HTTP request.
2. The request first hits the **Nginx Proxy** running inside the VPC.
3. Nginx forwards the request to the **Node.js Backend** service running on worker nodes.
4. The **Swarm Manager** ensures service discovery and container orchestration across the workers.
5. The backend processes the request and sends the response back to the user through Nginx.

---

## Key Architectural Decisions

* **Docker Swarm**: Chosen for orchestration because it is lightweight, easy to set up, and integrates seamlessly with Docker CLI.
* **Nginx Proxy**: Ensures load balancing, security (TLS termination), and reverse proxy functionality.
* **Multiple Worker Nodes**: Improve scalability and reliability. Even if one worker fails, the application continues running.
* **AWS VPC**: Provides isolation, security, and networking control over the infrastructure.

---

## Scalability & Maintainability

* New worker nodes can be added to the Swarm cluster easily to handle increased load.
* Nginx configuration allows horizontal scaling of backend services.
* Using Docker containers ensures portability, version control, and easier CI/CD integration.
* The modular design ensures that services (proxy, backend, manager) can be updated independently.



