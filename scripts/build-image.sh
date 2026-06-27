#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${PROJECT_ROOT}"

IMAGE_NAME="${IMAGE_NAME:-azure-cloud-devops-api}"
IMAGE_TAG="${IMAGE_TAG:-local}"

FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"

echo "Building Docker image: ${FULL_IMAGE_NAME}"
echo "Project root: ${PROJECT_ROOT}"

docker build -t "${FULL_IMAGE_NAME}" .

echo "Verifying Docker image exists..."
docker image inspect "${FULL_IMAGE_NAME}" > /dev/null

echo "Docker image built successfully: ${FULL_IMAGE_NAME}"