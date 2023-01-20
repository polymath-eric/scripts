VAULT_TOKEN="${VAULT_TOKEN:=root}"

echo "Starting Vault: Root Token: "$VAULT_TOKEN", Docker ID:"
docker run \
  --name=vault \
  --rm \
  --publish=8200:8200 \
  --detach \
  --env VAULT_DEV_ROOT_TOKEN_ID=$VAULT_TOKEN \
  vault

sleep 3

echo 'enabling vault transit engine'
docker exec --env VAULT_ADDR='http://localhost:8200' --env VAULT_TOKEN=$VAULT_TOKEN vault sh -c 'vault secrets enable transit'
