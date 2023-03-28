#!/bin/bash

# Check if vault-volume exists and create if needed
docker volume ls | grep vault-volume &> /dev/null
if [ $? -ne 0 ]; then
  echo "Creating vault-volume..."
  docker volume create vault-volume
fi

# Start Docker Compose with the appropriate profile
if grep -q "ENABLE_VAULT=1" .env; then
  echo "Starting Docker Compose with Vault..."
  docker compose --env-file .env --profile vault up -d
else
  echo "Starting Docker Compose without Vault..."
  docker compose --env-file .env up -d
fi
