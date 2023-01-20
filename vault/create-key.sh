echo "Making key with name: $1"
curl  --header "X-Vault-Token: $VAULT_TOKEN" "$VAULT_ADDR" -d '{"type": "ed25519", "deletion_allowed": true }'
./get-address.sh $1
