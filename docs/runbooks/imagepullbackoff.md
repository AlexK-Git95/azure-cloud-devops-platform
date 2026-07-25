# ImagePullBackOff Runbook

## Purpose

Use this runbook when a Kubernetes Pod cannot start because its container image cannot be pulled.

## Common symptoms

```text
ErrImagePull
ImagePullBackOff
Back-off pulling image

Initial checks

List the Pods:

kubectl get pods -n devops-platform

Identify the Pod with ErrImagePull or ImagePullBackOff.

Inspect the Pod:

kubectl describe pod <POD_NAME> -n devops-platform

Check the Events section for messages such as:

Failed to pull image
repository does not exist
pull access denied
unauthorized
context deadline exceeded

Check the image configured in the Deployment:

kubectl get deployment devops-platform-api \
  -n devops-platform \
  -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
Common root causes
Incorrect image name or tag
Image does not exist in the registry
Missing credentials for a private registry
Registry or network connectivity problem
Local image is not loaded into Minikube

Application logs are usually not useful because the container has not started.

Recovery

Review the Deployment revision history:

kubectl rollout history deployment/devops-platform-api \
  -n devops-platform

If the problem was introduced by the latest rollout, restore the previous revision:

kubectl rollout undo deployment/devops-platform-api \
  -n devops-platform

Monitor the recovery:

kubectl rollout status deployment/devops-platform-api \
  -n devops-platform \
  --timeout=120s
Verification

Confirm that the expected number of Pods is running:

kubectl get pods -n devops-platform

Confirm the active image:

kubectl get deployment devops-platform-api \
  -n devops-platform \
  -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'

Test the application:

kubectl port-forward service/devops-platform-api 8080:80 \
  -n devops-platform

In another terminal:

curl -i http://localhost:8080/health