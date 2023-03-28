#!/bin/bash

## This script helps generate a `.env` to ensure consistent images are pulled

## Note this is WIP, you can manually look at the tags to find the right ones - https://hub.docker.com/u/polymeshassociation

function check_image_exists() {
  image=$1
  tag=$2
  token=$(curl -s "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$image:pull" | jq -r .token)
  curl -s -H "Authorization: Bearer $token" -o /dev/null -w "%{http_code}" "https://registry-1.docker.io/v2/$image/manifests/$tag" | grep -q "200"
  return $?
}

# Prompt user for configuration values
read -p "Enter Chain Image [default: polymeshassociation/polymesh:latest-develop-debian]: " CHAIN_IMAGE
read -p "Enter REST Image [default: polymeshassociation/polymesh-rest-api:latest]: " REST_IMAGE
read -p "Enter Subquery Image [default: polymeshassociation/polymesh-subquery:latest]: " SUBQUERY_IMAGE
read -p "Enter Postgres Port [default: 5432]: " PG_PORT
read -p "Enter REST Port [default: 3004]: " REST_PORT
read -p "Enter Subquery Port [default: 3001]: " SQ_PORT
read -p "Enter Vault Version [default: latest]: " VAULT_VERSION
read -p "Enter Vault Port [default: 8200]: " VAULT_PORT
read -p "Enter Vault REST Port [default: 3014]: " VAULT_REST_PORT
read -p "Enable Vault (0/1) [default: 0]: " ENABLE_VAULT

# Validate image tags
IFS=':' read -ra CHAIN_IMAGE_ARR <<< "${CHAIN_IMAGE:-polymeshassociation/polymesh:latest-develop-debian}"
IFS=':' read -ra REST_IMAGE_ARR <<< "${REST_IMAGE:-polymeshassociation/polymesh-rest-api:latest}"
IFS=':' read -ra SUBQUERY_IMAGE_ARR <<< "${SUBQUERY_IMAGE:-polymeshassociation/polymesh-subquery:latest}"

check_image_exists "${CHAIN_IMAGE_ARR[0]}" "${CHAIN_IMAGE_ARR[1]}"
if [ $? -ne 0 ]; then
  echo "Invalid Chain Image tag. Exiting."
  exit 1
fi

check_image_exists "${REST_IMAGE_ARR[0]}" "${REST_IMAGE_ARR[1]}"
if [ $? -ne 0 ]; then
  echo "Invalid REST Image tag. Exiting."
  exit 1
fi

check_image_exists "${SUBQUERY_IMAGE_ARR[0]}" "${SUBQUERY_IMAGE_ARR[1]}"
if [ $? -ne 0 ]; then
  echo "Invalid Subquery Image tag. Exiting."
  exit 1
fi

# Create .env file with user-provided values
cat << EOF > .env
COMPOSE_PROJECT_NAME=polymesh

CHAIN_IMAGE=${CHAIN_IMAGE:-polymeshassociation/polymesh:latest-develop-debian}
REST_IMAGE=${REST_IMAGE:-polymeshassociation/polymesh-rest-api:latest}
SUBQUERY_IMAGE=${SUBQUERY_IMAGE:-polymeshassociation/polymesh-subquery:latest}
PG_PORT=${PG_PORT:-5432}
REST_PORT=${REST_PORT:-3004}
SQ_PORT=${SQ_PORT:-3001}
VAULT_VERSION=${VAULT_VERSION:-latest}
VAULT_PORT=${VAULT_PORT:-8200}
VAULT_REST_PORT=${VAULT_REST_PORT:-3014}
ENABLE_VAULT=${ENABLE_VAULT:-0}
EOF

docker volume ls | grep vault-volume &> /dev/null
if [ $? -ne 0 ]; then
  echo "Creating vault-volume..."
  docker volume create vault-volume
fi
