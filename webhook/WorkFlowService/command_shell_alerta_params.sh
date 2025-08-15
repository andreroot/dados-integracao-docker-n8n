#!/bin/bash

# This script is used to execute a remote shell script on a specified server using SSH.
# sh <user@local> <path.sh> <user/alerta> <params>
sh /home/node/scripts/executa_remoto_params.sh administrador@172.16.128.133 /home/administrador/projetos/dados-agent-ia/script_process_monitoria/shell_script/run_workflow_n8n_consulta_particularity.sh "User" "{{ $json.user }}" "" "" "" ""