# Azure Cloud DevOps Platform

This is a hands-on DevOps platform project designed to strengthen and demonstrate practical skills in containerization, CI/CD, infrastructure as code, Kubernetes basics, Azure cloud fundamentals, and production-style troubleshooting.

The application itself is intentionally simple. The main purpose of this project is not to build a complex business application, but to demonstrate the DevOps lifecycle around it: building, containerizing, deploying, configuring, documenting, monitoring, and troubleshooting a cloud-ready service.

What is included

Current project scope:

Flask API with basic endpoints
Dockerfile for the API
Docker Compose setup with API and Redis
Bash scripts for validation and Docker image build
Azure Pipelines YAML for validation and image build
Terraform foundation for Azure resources
Basic Kubernetes manifests
Documentation for Docker, CI/CD, Terraform, Linux, and runbooks

This is a learning and portfolio project. It is not meant to represent production infrastructure.
The Flask API runs in one container and Redis runs in a second container. Docker Compose manages both services in the same local environment.

The API connects to Redis using the Compose service name "redis" as the hostname. This demonstrates a basic multi-container setup with service discovery, environment-based configuration, and dependency validation.

Project structure
.
├── app/                  # Flask API code
├── docs/                 # Project documentation and runbooks
├── k8s/                  # Kubernetes practice manifests
├── pipelines/            # Azure Pipelines YAML
├── scripts/              # Validation and build scripts
├── terraform/            # Terraform Azure foundation
├── Dockerfile
├── docker-compose.yml
└── README.md
Local run with Docker Compose

Start the local environment:

docker compose up --build -d

This starts:

the Flask API container
the Redis container

The API runs locally on:

http://localhost:5001

Check running containers:

docker compose ps

Test the API:

curl http://localhost:5001/health
curl http://localhost:5001/version
curl http://localhost:5001/status

Stop the environment:

docker compose down
Scripts

The scripts/ folder contains reusable scripts for local checks and CI usage.

Run validation:

./scripts/validate.sh

Build the Docker image:

./scripts/build-image.sh

I wanted the main validation/build logic to be reusable instead of putting everything only inside the pipeline YAML.

CI/CD

The Azure Pipelines file is located here:

pipelines/azure-pipelines.yml

Current pipeline flow:

install Python dependencies
run validation script
build Docker image
check that the image builds successfully
install Terraform
run Terraform formatting and validation checks

At this stage, the pipeline validates and builds the project. It does not deploy to a live environment.

Terraform

Terraform code is located in:

terraform/

Current Terraform scope:

Azure provider setup
variables
resource group
storage account
outputs
basic tagging
provider lock file

Validated locally:

terraform fmt
terraform init
terraform validate

In CI, Terraform is initialized without backend:

terraform init -backend=false

I have not run terraform apply yet. That is intentional because it would require Azure authentication and could create real billable resources.

For now, the Terraform part demonstrates structure and validation, not live Azure infrastructure ownership.

Kubernetes

The k8s/ folder contains basic Kubernetes manifests.

This part is still in progress and is mainly for practice with:

deployment structure
service definition
basic Kubernetes concepts
troubleshooting mindset

I do not present this project as production Kubernetes experience.

Documentation

The docs/ folder contains notes and documentation for different parts of the project, including:

Docker workflow
CI/CD pipeline
Terraform
Terraform concepts
Linux troubleshooting
runbooks

I added these docs because platform work is not only writing config files. It also involves making systems easier to understand, validate, and troubleshoot.

Current limitations

This project is not production-ready.

Current limitations:

no live Azure deployment yet
no Terraform remote backend yet
no terraform apply executed
no Azure Container Registry integration yet
no real hosting target yet
no Key Vault or secrets management yet
Kubernetes layer is basic
no monitoring or alerting setup yet

These are areas I plan to improve step by step.

Next improvements

Possible next steps:

add Terraform remote state in Azure Storage
add Azure Container Registry
add a controlled deployment target
improve Kubernetes manifests with probes and resource limits
add environment-specific Terraform variables
improve runbooks with more troubleshooting scenarios
add basic monitoring/logging notes
How I would describe this project

I would describe this as a practical learning project focused on DevOps and Platform Engineering fundamentals.

It shows how I approach:

containerization
CI validation
infrastructure-as-code structure
scripting
troubleshooting
documentation
platform thinking

I would not describe it as production Terraform, Kubernetes, or Azure experience. It is a hands-on project that helps me connect my previous production support and platform/admin background with modern DevOps tooling.
