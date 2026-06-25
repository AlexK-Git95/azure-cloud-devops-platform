#!/bin/bash

set -e

BASE_URL="http://localhost:5001"

echo "Running smoke tests against: $BASE_URL"
echo ""

echo "Checking /health endpoint..."
HEALTH_RESPONSE=$(curl --fail --silent --show-error "$BASE_URL/health")

echo "$HEALTH_RESPONSE" | grep -q '"status":"healthy"\|"status": "healthy"'

echo "/health check passed"
echo ""

echo "Checking /redis endpoint..."
REDIS_RESPONSE=$(curl --fail --silent --show-error "$BASE_URL/redis")

echo "$REDIS_RESPONSE" | grep -q '"redis_status":"connected"\|"redis_status": "connected"'

echo "/redis check passed"
echo ""

echo "All smoke tests passed successfully."
