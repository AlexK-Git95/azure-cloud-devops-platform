# Azure Cloud DevOps Platform

This is a hands-on DevOps platform project designed to strengthen and demonstrate practical skills in containerization, CI/CD, infrastructure as code, Kubernetes basics, Azure cloud fundamentals, and production-style troubleshooting.

The application itself is intentionally simple. The main purpose of this project is not to build a complex business application, but to demonstrate the DevOps lifecycle around it: building, containerizing, deploying, configuring, documenting, monitoring, and troubleshooting a cloud-ready service.

## Project Purpose

The goal of this project is to build a production-style DevOps workflow around a small API service. It is intended to demonstrate the ability to work systematically with core DevOps practices such as:

* Building and running a containerized application with Docker
* Managing a local multi-container environment with Docker Compose
* Creating a CI/CD pipeline structure with Azure DevOps YAML
* Writing Kubernetes manifests for application deployment
* Defining basic Azure infrastructure with Terraform
* Documenting operational troubleshooting steps through runbooks
* Explaining the full build, deploy, troubleshoot, and improve cycle


Local Development

This section explains how to run the project locally using Docker Compose.

The local environment contains two services:

- Flask API service
- Redis service

The Flask API is exposed on the host machine through port "5001".

Start the Local Environment

From the project root, run:

docker compose up --build -d

This command builds the API image if needed and starts all services in detached mode.

Check Running Services

docker compose ps

Expected result:

- API service is running
- Redis service is running

Test the API Manually

Health endpoint:

http://localhost:5001/health

Expected response:

{
  "service": "azure-cloud-devops-api",
  "status": "healthy",
  "timestamp": "..."
}

Redis connectivity endpoint:

http://localhost:5001/redis

Expected response:

{
  "redis_status": "connected",
  "redis_host": "redis",
  "redis_port": 6379,
  "test_key": "health_check",
  "test_value": "ok"
}

Run Smoke Tests

The project includes a simple smoke test script that validates the main service endpoints.

From the project root, run:

./scripts/smoke-test.sh

Expected output:

Running smoke tests against: http://localhost:5001

Checking /health endpoint...
/health check passed

Checking /redis endpoint...
/redis check passed

All smoke tests passed successfully.

View Logs

View API logs:

docker compose logs api

View Redis logs:

docker compose logs redis

Follow API logs live:

docker compose logs -f api

Stop the Local Environment

docker compose down

This stops and removes the containers created by Docker Compose.

Local Architecture

Browser / curl
      |
      v
localhost:5001
      |
      v
Flask API container
      |
      v
Redis container

The Flask API runs in one container and Redis runs in a second container. Docker Compose manages both services in the same local environment.

The API connects to Redis using the Compose service name "redis" as the hostname. This demonstrates a basic multi-container setup with service discovery, environment-based configuration, and dependency validation.
