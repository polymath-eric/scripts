echo "exporting key: $1"

echo 'exporting as hmac: '
curl -s --header "X-Vault-Token: $VAULT_TOKEN" "$VAULT_ADDR" 
echo '\nexporting as signing key: '
curl -s --header "X-Vault-Token: $VAULT_TOKEN" "$VAULT_ADDR" 

