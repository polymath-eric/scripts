#! /bin/sh

EXEC_CONTAINER=${VAULT_CONTAINER:=vault-vault-1}

export VAULT_ADDR='http://1.127.0.1:8200'

echo 'enabling vault transit engine'
docker exec --env VAULT_ADDR='http://localhost:8200' --env VAULT_TOKEN=$VAULT_TOKEN $EXEC_CONTAINER sh -c 'vault secrets enable transit'