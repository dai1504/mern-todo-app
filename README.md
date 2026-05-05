# 🚀 MERN DevOps CI/CD Platform

A production-style DevOps project implementing a fully automated CI/CD pipeline for a MERN Stack application using **Terraform, Ansible, Jenkins, Docker, and AWS EC2**.

This project demonstrates a real-world DevOps workflow from infrastructure provisioning to application deployment and monitoring.

---

# ⚙️ Tech Stack

## Application
- React.js
- Node.js + Express
- MongoDB

## DevOps
- Terraform (Infrastructure as Code)
- Ansible (Configuration Management)
- Jenkins (CI/CD Pipeline)
- Docker & Docker Compose (Containerization)
- AWS EC2 (Cloud Infrastructure)
- Prometheus (Monitoring)

---

# 🧠 System Architecture

Terraform → Ansible → Jenkins → Docker → AWS EC2 → Monitoring

---

# ☁️ Infrastructure (Terraform)

Provision AWS infrastructure:

- EC2 instance
- Security Groups (SSH, HTTP, custom ports)
- Public IP output for deployment

```bash
terraform init
terraform apply
```

---

# ⚙️ Configuration (Ansible)

Configure server environment:

```bash
ansible-playbook -i inventory.ini deploy.yml
```

---

# 🚀 CI/CD Pipeline (Jenkins)

Triggered by GitHub push:

- Build application
- Build Docker images
- Inject environment variables securely
- SSH into EC2
- Deploy via Docker Compose
- Cleanup old images

```bash
docker compose pull
docker compose up -d
docker image prune -f
```
- URL: http://47.128.218.162:8080
- Default login:
  - user: admin
  - pass: 123123
---

# 🐳 Application Deployment

- Frontend (React + Nginx)
- Backend (Node.js API)
- MongoDB

```bash
docker compose up --build -d
```

- URL: http://47.128.218.162
---

# 🔐 Security Design

- Jenkins Credentials Store
- SSH key authentication
- AWS Security Groups
- No hardcoded secrets

---

# 📊 Monitoring (Prometheus)

- CPU usage
- Memory usage
- Container health

---

# 🔄 End-to-End Workflow

Terraform → Ansible → Git Push → Jenkins → Docker → EC2 → Monitoring

---

# 🧠 DevOps Principles

- Infrastructure as Code
- Configuration as Code
- CI/CD Automation
- Immutable Infrastructure
- Separation of Concerns

---

# 📊 Monitoring System (Prometheus + Grafana)

The system includes a full observability stack using **Prometheus + Grafana**.

## Components:
- Prometheus: collects metrics (CPU, memory, containers)
- Grafana: visualizes metrics via dashboards

## Setup Overview:

```bash
# Run Prometheus
docker run -d -p 9090:9090 prom/prometheus

# Run Grafana
docker run -d -p 3001:3000 grafana/grafana
```

## Grafana Access:
- URL: http://47.128.218.162:3001
- Default login:
  - user: admin
  - pass: 123123

## Benefits:
- Real-time system monitoring
- Visual dashboards for infrastructure health
- Alerting capability (extendable)

---

# 👨‍💻 Author

Nguyễn Đại
DevOps Engineering Project
