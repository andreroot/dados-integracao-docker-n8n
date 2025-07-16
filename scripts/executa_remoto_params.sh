#!/bin/bash
set -e

# Uso: ./executa_remoto.sh usuario@host /caminho/do/script.sh [args...]

if [ $# -lt 2 ]; then
  echo "Uso: $0 usuario@host /caminho/do/script.sh [args...]"
  exit 1
fi

REMOTE_HOST="$1"
REMOTE_SCRIPT="$2"
shift 2

sshpass -p "password" ssh -v -o StrictHostKeyChecking=no "$REMOTE_HOST" "bash $REMOTE_SCRIPT \"$PARAM1\" \"$PARAM2\" \"$PARAM3\" \"$PARAM4\""