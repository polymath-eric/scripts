#!/bin/bash

# Check if the Vault profile is enabled
if grep -q "ENABLE_VAULT=1" .env; then
  echo "Stopping Docker Compose with Vault..."
  docker compose --env-fiile .env --profile vault down
else
  echo "Stopping Docker Compose without Vault..."
  docker compose --env-file .env down
fi
