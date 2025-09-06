
# DevOps Tech Test

This repository demonstrates Infrastructure as Code, container orchestration with **Docker Swarm**, and deployment of a sample **Node.js application** behind an **Nginx reverse proxy**.  
It follows clean coding practices with consistent formatting, clear variable naming, and modular organization.

📌 **Public Repository**: [GitHub - devops-tech-test](https://github.com/<your-username>/devops-tech-test)  
*(Replace `<your-username>` with your actual GitHub username once you push this repo.)*

---

## 📂 Repository Structure

```

devops-tech-test/
│── infrastructure/     # Terraform code for AWS provisioning
│── swarm-setup/        # Scripts to initialize and join Docker Swarm
│── app/                # Node.js backend + Nginx reverse proxy
│── architecture.md     # Detailed architecture overview
│── test-strategy.md    # Testing approach and validation
│── README.md           # Main documentation

````

---

## 🛠 Steps to Run

### 1. Provision Infrastructure (Terraform)
```bash
cd infrastructure
terraform init
terraform apply
````

This creates:

* 1 Swarm Manager EC2 instance
* 2 Worker EC2 instances
* Security group with open ports for Swarm and HTTP(S)

---

### 2. Setup Docker Swarm

SSH into the **manager node**:

```bash
bash swarm-setup/init-swarm.sh
```

Copy the join command it prints. Then SSH into each **worker node** and run:

```bash
bash swarm-setup/join-workers.sh
```

*(Paste the join command inside.)*

---

### 3. Deploy Application

On the **manager node**:

```bash
cd app
docker stack deploy -c docker-compose.yml techtest
```

Check running services:

```bash
docker service ls
```

---

### 4. Access Application

Visit:

```
http://<manager-public-ip>/
```

Expected output:

```json
{ "message": "Hello from Node.js backend running on Docker Swarm!" }
```

---

## 🏗 Architectural Overview

### Technology Choices

* **Terraform** → reproducible infrastructure provisioning on AWS
* **Docker Swarm** → lightweight container orchestrator for scaling and service discovery
* **Node.js (Express)** → backend service containerized for demo logic
* **Nginx** → reverse proxy to route incoming HTTP traffic to backend services
* **Overlay Network** → enables container-to-container communication across swarm nodes

---

### Key Decisions

* **Swarm over single Docker host** → horizontal scaling across multiple replicas
* **Infrastructure as Code (Terraform)** → ensures maintainability and repeatability
* **Separation of Concerns**:

  * Backend logic runs in Node.js containers
  * Proxy handled by Nginx
  * Infrastructure handled by Terraform
* **Replicated services** → Backend runs with 2 replicas by default, ensuring availability and load balancing

---

### Scalability

* Scale backend services with a single command:

  ```bash
  docker service scale techtest_backend=4
  ```
* Add new worker nodes with the swarm join token
* Stateless containers → easy scale up/down

---

### Maintainability

* Clear directory structure for infra, setup, and app code
* Documented files (`README.md`, `architecture.md`, `test-strategy.md`)
* Clean coding practices:

  * Consistent formatting
  * Descriptive variable names
  * Minimal but sufficient comments

---

## ✅ Optional AWS Enhancements

These steps make the system **production-ready** on AWS.

---

### a. Use AWS Route 53 for DNS

1. Go to **Route 53** → create a **hosted zone** for your domain
2. Add an **A record** pointing to your **Elastic Load Balancer (ELB)** or **EC2 public IP**
3. Update your domain registrar (GoDaddy, Namecheap, etc.) to use Route 53 name servers
4. Verify with:

   ```bash
   dig yourdomain.com
   nslookup yourdomain.com
   ```

---

### b. Use S3 for Storing App Logs or Assets

1. Create an S3 bucket:

   ```bash
   aws s3 mb s3://my-app-logs-bucket
   ```
2. Configure your app or Docker containers to write logs to `/var/log/app`
3. Sync logs to S3:

   ```bash
   aws s3 sync /var/log/app s3://my-app-logs-bucket --delete
   ```
4. For assets (static files), upload them to S3 and serve via **CloudFront**

---

### c. Auto-renew TLS Certificates with Let’s Encrypt

1. Install **Certbot** on your EC2 instance:

   ```bash
   sudo apt-get update
   sudo apt-get install certbot python3-certbot-nginx -y
   ```
2. Request a certificate:

   ```bash
   sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
   ```
3. Enable auto-renewal via cron:

   ```bash
   crontab -e
   0 0 * * * certbot renew --quiet
   ```

---

### d. Use EC2 Auto Scaling Groups (ASG) or Spot Instances

1. Go to **EC2 > Launch Templates** → create a template with your app’s AMI
2. Go to **Auto Scaling Groups** → create a group from the template
3. Define scaling policies:

   * Min / Max / Desired capacity
   * Scale on CPU, memory, or network usage
4. (Optional) Save cost with **Spot Instances**:

   * Create a **Spot Fleet Request**
   * Configure interruption handling (graceful container shutdown)

---

## 📊 Monitoring & Alerts

* **Prometheus** scrapes container metrics
* **Grafana** dashboards for visualization
* Alerts configured for downtime, high CPU usage, or failed services

---

## 🔒 Security Considerations

* Use **IAM roles** instead of static AWS keys
* Enable **VPC security groups** to restrict access
* Store secrets in **AWS Secrets Manager** or **Vault**
