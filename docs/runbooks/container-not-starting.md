## If a container is not starting, check:

 # Container status:
- docker ps -a
 # Logs:
- docker logs <container-name>
# Exit code and configuration:
 - docker inspect <container-name>
# Common causes:
- Wrong startup command
- Missing environment variable
- Application crash
- Port conflict
- Missing dependency
- Wrong image tag
- Permission issue
