#! /bin/sh

echo "Making key deletable with name: $1"
curl --header "X-Vault-Token: $VAULT_TOKEN" "$VAULT_ADDR" -d '{ "deletion_allowed": true }'
