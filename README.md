# 🧰 Kubernetes Tutorial: Hands-On with Real-World Scenarios

This repository is a step-by-step, hands-on tutorial for learning Kubernetes through practical scenarios.  
Each section focuses on a key Kubernetes concept and includes ready-to-use YAML files, clear instructions, and real-world applications.

---

## 📌 Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/docs/start/) installed locally
- Docker installed and configured
- Basic knowledge of containerization and Linux terminal

---

## 🗂️ Tutorial Structure

Each directory represents a self-contained project or scenario.

| Section | Title | Description |
|--------|-------|-------------|
| 01 | [Minikube Setup](01-minikube-setup/) | Setup and verify Minikube on your local machine *(Optional, if already installed)* |
| 02 | [Basic Deployment](02-basic-deployment/) | Deploy a simple `nginx` app using `Deployment` and `NodePort` service |
| 03 | [ConfigMap & Secret](03-configmap-secret/) | Use ConfigMaps and Secrets to inject config data and secure values |
| 04 | [Persistent Volume](04-persistent-volume/) | Add persistent storage to a pod using `PV` and `PVC` |
| 05 | [Ingress Controller](05-ingress/) | Route external traffic using Ingress and NGINX Controller |
| 06 | [Monitoring & Logging](06-monitoring-logging/) | Setup Prometheus, Grafana, and Loki for observability |
| 07 | [Helm Packaging](07-helm/) | Deploy applications using Helm charts and package your own |
| 08 | [CI/CD Integration](08-ci-cd/) | Automate Kubernetes deployments with GitHub Actions |
| 09 | [Production Practices](09-prod-practices/) | Health checks, resource limits, autoscaling, and namespaces |
| 10 | [Fullstack App Deployment](10-fullstack-example/) | Deploy a complete Angular + Spring Boot + PostgreSQL stack |

---

## ✅ How to Use

You can start from any section, but it's recommended to follow the order:

```bash
cd 02-basic-deployment
kubectl apply -f nginx-deployment.yaml
