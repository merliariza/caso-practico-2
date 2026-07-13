#!/bin/bash

echo "=== Deploy Caso Practico 2 ==="

ansible-playbook \
-i ansible/hosts \
ansible/playbook.yml

echo "=== Deployment finalizado ==="
