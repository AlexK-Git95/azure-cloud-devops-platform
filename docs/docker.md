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

## Docker Compose Basics

Docker Compose is used to define and run multi-container Docker applications.

Instead of running a long `docker run` command manually, Compose allows the application configuration to be written in a YAML file.

Example manual Docker command:

```bash
docker run -p 5001:5000 --name azure-cloud-devops-api azure-cloud-devops-api:local
```

With Docker Compose, this configuration can be described in a docker-compose.yml file and started with:

```bash
docker compose up --build
```

## Key Concepts

- **services** define the containers that should run
- **build** tells Compose how to build the image
- **ports** maps host ports to container ports
- **environment** sets environment variables inside the container
- **depends_on** defines startup dependency between services

- ## Final Docker Recap

In this project, I practiced the full local container workflow:

- Built a Docker image for a Flask API using a Dockerfile
- Ran the API as a Docker container
- Debugged port mapping between host and container
- Added Docker Compose to define the local environment as code
- Added Redis as a second service dependency
- Connected the API container to Redis using the Compose service name `redis`
- Added a `/redis` endpoint to validate Redis connectivity
- Added a smoke test script to validate `/health` and `/redis`

### Interview Summary

I used Docker first to package the Flask API into an image and run it as a container. Then I moved to Docker Compose to make the local setup repeatable and to add Redis as a second service. This helped me practice not only containerization, but also service-to-service communication, environment variables, port mapping, logs, and basic troubleshooting.

A useful issue I encountered was a port mapping mistake. The container was running correctly, but I initially opened the wrong localhost port. After checking the mapping, I used the correct host port and confirmed the `/health` endpoint worked.

Another issue was with the smoke test script. The script failed because a URL was accidentally pasted in a Markdown-style format, which broke bash syntax. I inspected the script with line numbers, corrected the syntax, and reran the test successfully.
