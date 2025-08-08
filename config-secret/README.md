# 03 - Configuration Management with ConfigMap & Secret

This example demonstrates how to provide configuration data and sensitive information to a Kubernetes application using **ConfigMap** and **Secret**.

We use a real-world scenario:  
A Spring Boot application that requires:
- Application metadata (name, environment)
- Database credentials (username, password)

These values are injected into the container as **environment variables**, allowing you to change them without rebuilding the Docker image.

---

## 📌 Scenario

In a production environment, hardcoding configuration values into code is a bad practice.  
Instead, we will:

1. Create a **ConfigMap** for non-sensitive data (`APP_NAME`, `APP_ENV`).
2. Create a **Secret** for sensitive data (`DB_USERNAME`, `DB_PASSWORD`).
3. Inject them into a Spring Boot container as environment variables.
4. Access these values via a `/env` REST endpoint.

---

## 📁 Files

- `configmap.yaml` → Stores non-sensitive key-value pairs.
- `secret.yaml` → Stores sensitive values (base64 encoded in Kubernetes).
- `spring-app-deployment.yaml` → Deploys the Spring Boot app and injects env variables.
- `spring-app-service.yaml` → Exposes the app via NodePort.

---

## 🛠️ Steps

### 1. Create ConfigMap & Secret

```bash
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f spring-app-deployment.yaml
kubectl apply -f spring-app-service.yaml
kubectl get pods
kubectl get svc spring-app-service
minikube ip
http://minikube-ip:30008/env

```

## Clean up