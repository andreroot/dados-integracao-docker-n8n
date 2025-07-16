#!/bin/bash
set -e

# Exemplo de uso: ./run-ssh.sh user@host "ls -l /tmp"
ssh -o StrictHostKeyChecking=no "$@"