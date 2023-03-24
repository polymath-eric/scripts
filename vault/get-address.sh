#! /bin/sh

echo "getting address for: $1"

curl -s --header "X-Vault-Token: $VAULT_TOKEN" "$VAULT_ADDR" |
  jq '.data.keys | .["1"].public_key' |
  sed 's/"//g' |
  base64 -d | \
  hexdump -e '16/1 "%02x"' |
  sed 's/.*/0x&/' |
  xargs subkey inspect --public
