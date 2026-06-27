# CI/CD Documentation

## Purpose

This project includes a basic CI pipeline definition for validating and building the application automatically.

The current focus is Continuous Integration, not full Continuous Deployment. The pipeline is designed to verify that the application can be checked and packaged successfully after a code change.

## Current CI Pipeline Scope

The pipeline performs the following actions:

1. Triggers on changes to the `main` branch
2. Triggers on pull requests targeting `main`
3. Uses an Ubuntu build agent
4. Sets the required Python version
5. Installs Python dependencies
6. Runs project validation
7. Builds and verifies the Docker image

At this stage, the pipeline does not deploy the application to a live environment.

## Pipeline Structure

The Azure Pipelines YAML file is located at:

`pipelines/azure-pipelines.yml`

The pipeline structure is organized as:

```text
Pipeline
  └── Stage
        └── Job
              └── Steps
```

### Pipeline

The pipeline represents the full automation workflow.

In this project, the pipeline is used as a CI workflow for validating and building the application.

### Stage

A stage is a logical phase in the pipeline.

The current pipeline has one stage:

`Build`

This stage is responsible for validation and Docker image build.

### Job

A job is a group of steps that runs on a build agent.

The current job runs on an Ubuntu agent.

### Steps

Steps are the individual actions executed by the job.

In this project, steps include checking out the repository, setting Python, installing dependencies, running validation, and building the Docker image.

## Validation Script

Project validation is handled by:

`scripts/validate.sh`

The script checks that required project files exist and performs a basic Python syntax validation using:

`python -m compileall app`

This is not a replacement for a full test suite. It is a lightweight validation step intended to catch basic project or syntax issues early.

## Docker Build Script

Docker image build logic is handled by:

`scripts/build-image.sh`

The script builds the Docker image from the project Dockerfile and verifies that the image exists after the build.

The script supports environment variables:

```text
IMAGE_NAME
IMAGE_TAG
```

This allows the same script to be used both locally and in the CI pipeline.

Example local usage:

```bash
bash scripts/build-image.sh
```

Example CI usage:

```bash
IMAGE_NAME="azure-cloud-devops-api" IMAGE_TAG="$(Build.BuildId)" bash scripts/build-image.sh
```

## Why Scripts Are Used

Validation and Docker build logic are kept in separate scripts instead of being written only inside the YAML file.

This has several benefits:

* The same logic can be executed locally and in CI
* The YAML file stays cleaner and easier to read
* Troubleshooting is easier because scripts can be tested independently
* The project structure is more reusable and maintainable

## Current Limitations

The current pipeline does not yet:

* Run a full unit test suite
* Start the container and test live endpoints
* Publish the Docker image to a container registry
* Deploy to an environment
* Use approvals or rollback logic

## Possible Next Improvements

Future improvements could include:

1. Add a smoke test step that starts the container and checks `/health`
2. Publish the Docker image to a container registry
3. Add environment-specific variables
4. Add deployment to a controlled environment
5. Add manual approvals before production deployment
6. Add rollback strategy using previous image tags

## Summary

The current pipeline is a clean first CI implementation. It validates the project structure, checks Python syntax, builds the Docker image, and verifies that the image was created successfully.

It is intentionally focused on CI first. Deployment can be added later once there is a target environment, registry, credentials, and rollback strategy.
