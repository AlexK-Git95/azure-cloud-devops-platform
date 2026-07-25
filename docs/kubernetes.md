# Kubernetes Local Deployment

This document explains how to run the Flask API in a local Kubernetes cluster using Minikube.

## Architecture

```text
localhost:8080
      |
kubectl port-forward
      |
Service :80
      |
      | selector: app=devops-platform-api
      |
+----------------+   +----------------+
| API Pod        |   | API Pod        |
| Flask :5000    |   | Flask :5000    |
+----------------+   +----------------+
        ^
        |
 ConfigMap and Secret
```

The Deployment maintains two API Pods.

The Service finds the Pods through their labels and forwards traffic from port `80` to container port `5000`.

## Kubernetes Resources

| File | Resource | Purpose |
|---|---|---|
| `namespace.yaml` | Namespace | Groups the project resources |
| `configmap.yaml` | ConfigMap | Stores non-sensitive configuration |
| `secret-example.yaml` | Secret | Demonstrates secret injection |
| `deployment.yaml` | Deployment | Runs two API Pods |
| `service.yaml` | Service | Provides a stable endpoint for the Pods |

## Prerequisites

- Docker Desktop with Linux containers
- Minikube
- kubectl

## Start Minikube

```bash
minikube start --driver=docker
kubectl get nodes
```

## Build and Load the Image

Build the Docker image:

```bash
bash scripts/build-image.sh
```

Load it into Minikube:

```bash
minikube image load azure-cloud-devops-api:local
```

The Deployment uses the local image:

```yaml
image: azure-cloud-devops-api:local
imagePullPolicy: IfNotPresent
```

## Deploy the Application

Apply the manifests in dependency order:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret-example.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

The ConfigMap and Secret are created before the Deployment because the Pods reference them during startup.

## Check the Resources

```bash
kubectl get all -n devops-platform
kubectl get configmap,secret -n devops-platform
```
Traffic flow:

```text
localhost:8080 -> Service:80 -> Pod:5000
```

Keep the command running and test from another terminal.

## Test the API

```bash
curl -i http://localhost:8080/
curl -i http://localhost:8080/health
curl -i http://localhost:8080/version
curl -i http://localhost:8080/api/status
curl -i http://localhost:8080/redis
```

The Redis endpoint will not work until Redis is deployed in Kubernetes.

## Configuration

The Deployment loads non-sensitive configuration from the ConfigMap:

```yaml
envFrom:
  - configMapRef:
      name: devops-platform-api-config
```

The Redis password is loaded from the example Secret:

```yaml
env:
  - name: REDIS_PASSWORD
    valueFrom:
      secretKeyRef:
        name: devops-platform-api-secret
        key: REDIS_PASSWORD
```

The committed Secret contains only a placeholder value. Real credentials must not be stored in Git.

## Self-Healing Test

Delete one Pod:

```bash
kubectl delete pod "$POD" -n devops-platform
```

The Deployment creates a replacement because it maintains two replicas.

## Troubleshooting

Inspect the Pods:

```bash
kubectl get pods -n devops-platform
kubectl describe pod <pod-name> -n devops-platform
kubectl logs <pod-name> -n devops-platform
```

Check the Service and Pod labels:

```bash
kubectl describe service devops-platform-api -n devops-platform
kubectl get pods -n devops-platform --show-labels
```

Reload the local image if it is unavailable inside Minikube:

```bash
minikube image load azure-cloud-devops-api:local
kubectl rollout restart deployment/devops-platform-api -n devops-platform
```

## Rollout and rollback

A rollout is the process of applying a new Pod template to a Deployment. Changes to the image, probes, resource settings, environment variables, `command`, or `args` create a new ReplicaSet.

The Deployment controller manages the rollout. It creates new Pods from the new ReplicaSet, waits for them to become Ready, and then gradually scales down the old ReplicaSet.

Check the status of the current rollout:

```bash
kubectl rollout status deployment/devops-platform-api \
  -n devops-platform \
  --timeout=120s
```

View the available Deployment revisions:

```bash
kubectl rollout history deployment/devops-platform-api \
  -n devops-platform
```

Restore the previous revision:

```bash
kubectl rollout undo deployment/devops-platform-api \
  -n devops-platform
```

Restore a specific revision:

```bash
kubectl rollout undo deployment/devops-platform-api \
  -n devops-platform \
  --to-revision=<REVISION>
```

`rollout status` only monitors a rollout. `rollout history` displays stored revisions, while `rollout undo` starts a new rollout using a previous Pod template.

A rollback repairs the live Kubernetes Deployment. If the faulty configuration is committed to Git, it must also be corrected in the repository to prevent a future deployment from reintroducing the problem.