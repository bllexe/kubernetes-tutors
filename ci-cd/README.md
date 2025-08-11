# 08 - CI/CD Pipeline & GitOps with GitHub Actions and ArgoCD

## Overview
This guide covers how to build a CI/CD pipeline using GitHub Actions to build and deploy a Spring Boot application to Kubernetes. It also shows how to set up GitOps with ArgoCD to continuously sync your Kubernetes cluster state with your Git repository.

---

## 1. Prerequisites
- Kubernetes cluster running (e.g., Minikube)
- Helm installed
- GitHub repository containing:
  - Spring Boot source code
  - Helm chart or Kubernetes manifests

---

## 2. GitHub Actions Workflow

Create `.github/workflows/ci-cd.yaml` in your repo with the following content:

```yaml
name: CI/CD Pipeline

on:
  push:
    branches:
      - main

env:
  REGISTRY: docker.io
  IMAGE_NAME: yourdockerhubusername/helloworld
  KUBE_NAMESPACE: helm-demo

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Set up JDK 17
      uses: actions/setup-java@v3
      with:
        distribution: 'temurin'
        java-version: '17'

    - name: Build with Maven
      run: ./mvnw clean package -DskipTests=false

    - name: Log in to Docker Hub
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build and push Docker image
      uses: docker/build-push-action@v4
      with:
        push: true
        tags: ${{ env.IMAGE_NAME }}:latest

    - name: Setup Helm
      uses: azure/setup-helm@v3

    - name: Setup kubectl
      uses: azure/setup-kubectl@v3
      with:
        version: 'latest'

    - name: Configure kubectl
      run: |
        kubectl config set-cluster minikube --server=https://your-k8s-api-server --insecure-skip-tls-verify=true
        kubectl config set-credentials admin --token=${{ secrets.K8S_TOKEN }}
        kubectl config set-context minikube --cluster=minikube --user=admin --namespace=${{ env.KUBE_NAMESPACE }}
        kubectl config use-context minikube

    - name: Helm upgrade/install
      run: |
        helm upgrade --install springbootapp ./spring-boot-app --namespace ${{ env.KUBE_NAMESPACE }} --set image.repository=${{ env.IMAGE_NAME }} --set image.tag=latest

```

## Install ArogCD on kubernetes

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

## Access ArgoCD UI

kubectl port-forward svc/argocd-server -n argocd 8080:443
https://localhost:8080

## Login to ArgoCd

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

## Create ArgoCD Application

argocd app create springbootapp \
  --repo https://github.com/yourusername/yourrepo.git \
  --path spring-boot-app \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace helm-demo

## Sync Application

argocd app sync springbootapp
