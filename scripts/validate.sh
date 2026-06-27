#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${PROJECT_ROOT}"

check_file() {
  local file_path="$1"

  if [[ ! -f "${file_path}" ]]; then
    echo "ERROR: Required file not found: ${file_path}"
    exit 1
  fi

  echo "OK: ${file_path}"
}

echo "Running project validation..."
echo "Project root: ${PROJECT_ROOT}"

echo "Checking Python version..."
python --version

echo "Checking required project files..."
check_file "app/app.py"
check_file "app/requirements.txt"
check_file "Dockerfile"
check_file "docker-compose.yml"

echo "Validating Python syntax..."
python -m compileall app

echo "Project validation completed successfully."