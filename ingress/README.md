# 05 - Advanced Networking: NGINX Ingress Controller

## Overview
In this lesson, we will use **NGINX Ingress Controller** to route traffic to multiple services under a single domain.  
We will configure **path-based routing** so that both frontend and backend applications are served from the same domain.

---

## Scenario
We will deploy two applications:
- **Frontend** (Angular) → accessible at `/`
- **Backend** (Spring Boot REST API) → accessible at `/api`

Both will be served under the same domain: `app.local`.

---

## Steps

### 1. Enable NGINX Ingress Controller in Minikube
```bash
minikube addons enable ingress

kubectl get pods -n ingress-nginx

kubectl apply -f ingress.yaml

```

## Update Hosts file

/etc/hosts  -> minikube ip app.local

## Test

Frontend: http://app.local/

Backend API: http://app.local/api/hello

