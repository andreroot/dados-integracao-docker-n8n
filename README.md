# 📡 n8n Webhook

Gerar fluxo que possam integrar processos.

### 1. Estrutura 🏢

    db-data: dados  do volumne de 

    n8n_data

    scripts

    webhook
        /<nomes dos workfkows>

    terraform
        /ec2
        /resource

### 2. Deploy ✈️🐋

    - via terraform criar uma ambiente ec2 e criar estrutura do n8n com docker

    ec2:
        liberado 22, 5678

    acessar maq via ssh
        ssh -i "credencial/my-ec2.pem" user@localhost

    comandos:
        docker-compose up --build -d
        docker-compose up -d

### 3. Acessar console N8N ☂️

    ip_public aws:5678/

    teste de fluxos:

        curl -X POST 'http://<ip public aws>:5678/webhook-test/fluxo_venda_yakult_v0?operacao=insert_venda' \
        -H "Content-Type: application/json" \
        -d '{"chatId": "5511946552467@c.us","mensagem": "Inserir nova vendas de yakult","venda":        {"nome":"Bruno", "end":"NSLoreto", "data_pagto":"30/07/2025", "produto":"sucos","valor_venda":"142,00","qtde_venda":"5"}}'

        curl -X POST 'http://<ip public aws>:5678/webhook/trigger_erros_operacionais?processo=inconsistencia_resultado' \
        -H "Content-Type: application/json" \
        -d '{"chatId": "nro_valido_celular@c.us","mensagem": "Agent, essas informações sobre portifolio"}'


### 4. Montar fluxos com IA 🧠 


### 5. Comunicação Waha para Whastapp 📞

    install:
    @devlikeapro/n8n-nodes-waha no console n8n

    doc:
    https://waha.devlike.pro/docs/integrations/n8n/



comandos basicos:

  terraform

  * ec2
  criar uma instancia com docker e usa a estrutura na pasta resource/
  - terrform init
  - ao alterar backend executar:
  terraform init -reconfigure
  - terraform plan
  - terraform apply
  - terraform workspace list / terraform workspace select staging


  conecta:
  - ssh -i "~/.ssh/my-ec2.pem" ec2-user@ec2-54-237-57-75.compute-1.amazonaws.com

  copia

  - scp -i "~/.ssh/my-ec2.pem" -r /home/andre/projetos/waha-n8n/dados-integracao-docker-n8n/terraform/ec2/resource/docker-compose.yml  ec2-user@ec2-54-237-57-75.compute-1.amazonaws.com:/home/ec2-user/          
  - scp -i "~/.ssh/my-ec2.pem" -r Dockerfile  ec2-user@ec2-54-237-57-75.compute-1.amazonaws.com:/home/ec2-user/    
  - scp -i "~/.ssh/my-ec2.pem" -r deployment.sh  ec2-user@ec2-54-237-57-75.compute-1.amazonaws.com:/home/ec2-user/