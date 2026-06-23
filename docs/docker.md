## Container Debugging Practice

To troubleshoot a running or failing container, use:

```bash
docker ps
docker logs azure-cloud-devops-api
docker logs -f azure-cloud-devops-api
docker exec -it azure-cloud-devops-api sh
docker port azure-cloud-devops-api
docker inspect azure-cloud-devops-api

## What I checked
Whether the container is running
Application startup logs
Live request logs
Files inside the container
Python/runtime version inside the container
Port mapping between host and container
Container configuration using inspect
Interview Answer

If a container is not starting or not reachable, I would first check docker ps -a to see its status and exit code. Then I would check docker logs for application errors. If it is running but not reachable, I would verify the port mapping with docker port or docker ps. If needed, I would enter the container with docker exec to inspect files, environment variables, runtime version, and application configuration.
