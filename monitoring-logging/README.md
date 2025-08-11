# Spring Boot Deployment on Minikube with Observability Namespace

This guide describes how to deploy a Spring Boot application to a **Minikube** Kubernetes cluster in a dedicated `observability` namespace.  
The setup assumes that your Spring Boot Docker image is already available locally.

---

## Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/docs/start/) running locally  
- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed  
- [Docker](https://docs.docker.com/get-docker/) installed and configured  
- A Spring Boot Docker image (in this example: `helloworld:latest`)

---

## 1. Create Namespace

We keep monitoring/logging and our app under the same dedicated namespace.

```bash
kubectl create namespace observability
```

## 2.Load Docker Image into Minikube

# Switch Docker context to Minikube
eval $(minikube docker-env)

# Build the image inside Minikube

docker build -t helloworld:latest .

## 3.Create Deployment 
``` bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: spring-boot-app
  namespace: observability
spec:
  replicas: 1
  selector:
    matchLabels:
      app: spring-boot-app
  template:
    metadata:
      labels:
        app: spring-boot-app
    spec:
      containers:
        - name: spring-boot-app
          image: helloworld:latest
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 8080
          env:
            - name: JAVA_OPTS
              value: "-Xms256m -Xmx512m"
          readinessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 5
          livenessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
            initialDelaySeconds: 20
            periodSeconds: 10
```

## 4.Crate Service
``` bash
apiVersion: v1
kind: Service
metadata:
  name: spring-boot-service
  namespace: observability
spec:
  type: NodePort
  selector:
    app: spring-boot-app
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
      nodePort: 30080
```

## 5.Apply Configurations

``` bash
kubectl apply -f spring-boot-deployment.yaml
kubectl apply -f spring-boot-service.yaml
```

## 6.Veriry the Deployment

kubectl get pods -n observability

kubectl get svc -n observability

## 7.Access the application

minikube ip 

curl http://<minikube_ip>:30080

## 8.View Logs

kubectl logs -n observability -l app=spring-boot-app

## 9. Delete all staff 

kubectl delete namespace observability


