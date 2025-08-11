# - Helm Packaging

In this section, we will package and deploy a Spring Boot application on Kubernetes using **Helm**.

---

# Directory Structure

``` bash
spring-boot-app/
  ├── charts/
  ├── templates/
  ├── values.yaml
  ├── Chart.yaml
  └── ...
```

# Verify Deployment

kubectl get all -n helm-demo
kubectl describe pod <pod-name> -n helm-demo
kubectl logs <pod-name> -n helm-demo

# Uninstall and CleanUp

helm uninstall springbootapp -n helm-demo
