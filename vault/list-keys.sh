curl -s \
--header "X-Vault-Token: $VAULT_TOKEN" \
--request LIST \
"$VAULT_ADDR"
