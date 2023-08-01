#!/bin/bash
export $(cat /vault/env/vault-unseal-env | xargs)

i=0
while [ $i -lt $REPLICAS ] 
do
  if [ $REPLICAS -gt 1 ]
  then
    VAULT_ADDR="http://vault-$i.vault-internal:8200"
  fi
  vault operator unseal $KEY1 && vault operator unseal $KEY2 && vault operator unseal $KEY3
  i=$((i+1))
done