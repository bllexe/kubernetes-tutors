# 04 - Using Storage (PersistentVolume & PersistentVolumeClaim)

## 🎯 Goal
In this section, we will deploy a **stateful** application (PostgreSQL) on Kubernetes and ensure that the data persists even if the pod is deleted.  
We will use **PersistentVolume (PV)** and **PersistentVolumeClaim (PVC)** for this purpose.

---

## 📌 Steps

###  Define PersistentVolume
`postgres-pv.yaml`
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: postgres-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data/postgres

This PV uses the /mnt/data/postgres directory on the Minikube node.
```

###  Define PersistentVolumeClaim
``` yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi

```
The PVC will bind the storage to the PostgreSQL pod.



### Apply the resoukubectl apply -f postgres-pv.yaml

kubectl apply -f postgres-pv.yaml
kubectl apply -f postgres-pvc.yaml
kubectl apply -f postgres-deployment.yaml

## Check the status

kubectl get pv,pvc,pods

## Test Data Persistence

kubectl exec -it <postgres-pod-name> -- psql -U user -d mydb

CREATE TABLE test(id SERIAL PRIMARY KEY, name TEXT);
INSERT INTO test(name) VALUES ('Kubernetes PV Test');
\q

kubectl delete pod <postgres-pod-name>

kubectl exec -it <new-postgres-pod-name> -- psql -U user -d mydb -c "SELECT * FROM test;"

📌 The data is still there!

###  How to Completely Remove the Data

kubectl delete pvc postgres-pvc
kubectl delete pv postgres-pv
minikube ssh
sudo rm -rf /mnt/data/postgres
exit

