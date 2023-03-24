#! /bin/sh

VAULT_TOKEN="${VAULT_TOKEN:=root}"

# ./remove-volume.sh

./create-volume.sh

EXEC_CONTAINER=${VAULT_CONTAINER:=vault-vault-1}

export VAULT_ADDR='http://127.0.0.1:8200'

# unseal the vault with 1 key share
# use vault operator unseal --help for more details

./run.sh

# note needs to be initialized

./unseal.sh

./enable-transit.sh

