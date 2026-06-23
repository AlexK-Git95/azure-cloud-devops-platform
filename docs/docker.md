## Container Debugging Practice

To troubleshoot a running or failing container, use:

```bash
docker ps
docker logs azure-cloud-devops-api
docker logs -f azure-cloud-devops-api
docker exec -it azure-cloud-devops-api sh
docker port azure-cloud-devops-api
docker inspect azure-cloud-devops-api
