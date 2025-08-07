# 02 - Basic Deployment on Kubernetes (Minikube)

This example demonstrates how to deploy a simple `nginx` application on Kubernetes using Minikube. It includes:

- A basic `Deployment` object with 2 replicas
- A `NodePort` `Service` for external access
- Verification steps to access the app from your browser

---

## 📁 Files

- `nginx-deployment.yaml` — Defines the nginx deployment
- `nginx-service.yaml` — Exposes the deployment as a NodePort service

---

## 🚀 Steps to Run

### 1. Start Minikube (if not running)

```bash
minikube start


kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
```

## kubectl get pods
kubectl get svc nginx-service

## Check the status

kubectl get pods
kubectl get svc nginx-service
minikube ip

## open in browser
http://<minikube-ip>:30007
