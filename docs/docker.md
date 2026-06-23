## Container Debugging Practice

To troubleshoot a running or failing container, use:

```bash
docker ps                          # List all containers
docker logs azure-cloud-devops-api # View container logs
docker logs -f azure-cloud-devops-api # Follow live logs
docker exec -it azure-cloud-devops-api sh # Enter container shell
docker port azure-cloud-devops-api # Check port mapping
docker inspect azure-cloud-devops-api # View container details
```

## What I Checked

- Whether the container is running
- Application startup logs
- Live request logs
- Files inside the container
- Python/runtime version inside the container
- Port mapping between host and container
- Container configuration using inspect

## Interview Answer

If a container is not starting or not reachable:

1. **Check container status**: `docker ps -a` to see status and exit code
2. **Review logs**: `docker logs` for application errors
3. **Verify connectivity**: If running but unreachable, check port mapping with `docker port` or `docker ps`
4. **Debug inside**: Use `docker exec` to inspect files, environment variables, runtime version, and application configuration
