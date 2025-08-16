# 🚀 Kubernetes Production Preparation Example

This guide demonstrates a **production-ready** Kubernetes configuration for a Spring Boot application.  
It covers:

- **Namespace usage**
- **Liveness & Readiness probes**
- **Resource requests/limits**
- **Horizontal Pod Autoscaler (HPA)**
---

## 📂 Files

- `k8s-prod-demo.yaml` → Contains **all** the Kubernetes resources:
  - Namespace
  - Deployment (with probes & resource limits)
  - Service
  - Horizontal Pod Autoscaler (HPA)

---

## 1️⃣ Prerequisites

Before running the example:

- Kubernetes cluster up & running
- `kubectl` installed & configured
- Metrics Server installed (required for HPA)

Install **Metrics Server**:
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

## 2️⃣ Apply the Configuration

``` bash kubectl apply -f k8s-prod-demo.yaml ```

## 3️⃣ Verify the Deployment

``` bash
 bash kubectl get pods -n prod-demo
kubectl get svc -n prod-demo
kubectl get hpa -n prod-demo ```

## 4️⃣ Understanding the Configuration

✅ Namespace
``` bash
apiVersion: v1
kind: Namespace
metadata:
  name: prod-demo
```

✅ Liveness & Readiness Probes
``` bash
livenessProbe:
  httpGet:
    path: /actuator/health/liveness
    port: 8080
readinessProbe:
  httpGet:
    path: /actuator/health/readiness
    port: 8080

```

✅ Resource Limits
``` bash
resources:
  requests:
    cpu: "250m"
    memory: "256Mi"
  limits:
    cpu: "500m"
    memory: "512Mi"

```

✅ Horizontal Pod Autoscaler (HPA)
``` bash
minReplicas: 2
maxReplicas: 5
metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50

```

## 5️⃣ Test HPA with Load

``` bash kubectl run -it load-generator --rm --image=busybox --restart=Never -- \
  sh -c "while true; do wget -q -O- http://springboot-service.prod-demo.svc.cluster.local; done" 
  ```
  After a few minutes, check HPA scaling:

```bash  kubectl get hpa -n prod-demo ```

  You should see the replica count increase automatically.

🧹 Cleanup
``` bash kubectl delete namespace prod-demo ```

kubectl delete all --all -n tutor --force --grace-period=0
kubectl patch namespace tutor -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl delete namespace tutor --force --grace-period=0

forced delete with json

``` bash kubectl get namespace prod-demo -o json > tmp.json
"spec": {
    "finalizers": [
        "kubernetes"
    ]
}
```

delete kubernetes scope 

``` bash kubectl replace --raw "/api/v1/namespaces/prod-demo/finalize" -f tmp.json ```

after apply this namespace deleted immediately












