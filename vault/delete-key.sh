#! /bin/sh

echo "Deleting key with name: $1"
curl --request DELETE  --header "X-Vault-Token: $VAULT_TOKEN" "$VAULT_ADDR"
