# 📡 n8n Webhook

Gerar fluxo que possam integrar mais nossos processos.

### 💡 1.Workflows | Fluxos

1. Fluxo | WorkFlowExecuteProc 👀

    >integração com processos na maq remota via ssh

    >criado um script shell para execução dos processos via ssh

        sh /home/node/scripts/executa_remoto.sh
        recebe parametros <user@localhost> <path do script shell>

    >conteudo da pasta:
        - json_webhook: josn dos fluxos que podem ser importados
        - javascript_code_n8n: script em js usando nos code dos fluxos
        - pasta scripts, nao versionar. Faça upload via ssh

    >teste
        curl -X POST http://172.16.128.133:5678/webhook/execute-python?processo=alertas_erros_operacionais' \
        -H "Content-Type: application/json

2. Fluxo | Agent IA ⚡

    >integração com docker waha e um agent IA com openIa, que acessa o workflow WorkFlowExecuteProc e responde solicitações usando os retornos dos workflows

        necesário:subir pacote no N8N - @devlikeapro/n8n-nodes-waha

3. Fluxo | TriggerErrosOperacionais 🔈

    >integração webhook com waha envio de msg no whatsapp, trigger acionada pelo alertas de portifolio(erros operacionais)

        necesário:subir pacote no N8N - @devlikeapro/n8n-nodes-waha

    >teste
        curl -X POST 'http://172.16.128.133:5678/webhook/trigger_erros_operacionais?processo=inconsistencia_resultado' \
        -H "Content-Type: application/json" \
        -d '{"chatId": "nro_valido_celular@c.us","mensagem": "Agent, essas informações sobre portifolio"}'

### 2.Administração | Dockers 🐳

1. comandos docker: a estrutura dos docker esta baseada em docker compose

    docker-compose: 
        - serviço: n8n
        - bd: redis, postgres
        - ngrok
        - network: docker-n8n-waha
        - volumes

[baixar]

    docker-compose down

[subir]

    docker-compose up -d 

[update]

    docker-compose up --build -d

    docker-compose down --volumes --remove-orphans

    docker-compose build --no-cache

    docker-compose up -d

2. definir acesso do user administrador na maq remota no projeto

```sudo chmod 777 /home/administrador/projetos/n8n/dados-integracao-docker-n8n/n8n_data/```

```sudo chown -R administrador:administrador /home/administrador/projetos/n8n/dados-integracao-docker-n8n/n8n_data/```

```sudo chgrp administrador /home/administrador/projetos/n8n/dados-integracao-docker-n8n/n8n_data/```

3. copia de arquivos para maq remota
    
    scp n8n_data/_data/* administrador@host:/home/administrador/projetos/n8n/dados-integracao-docker-n8n/n8n_data/_data
    
4. permissoes para docker ler/escrever no volume n8n
    
    sudo chown -R 1000:1000 ./n8n_data

5. permissoes para docker ler/escrever nno volume postgres 
    
    sudo chown -R 999:999 ./db-data

### 3.Administração | Fluxos 🔔

Como definir parametros de entrada para webhook

[params]

    http://localhost:5678/webhook-test/39b27ed9-bf7f-4d15-b40c-d13b596b7196/recebe-params/:item/item


    http://localhost:5678/webhook-test/39b27ed9-bf7f-4d15-b40c-d13b596b7196/recebe-params/3/item

    *resultado:

        "params": 
        {
        "item":"3"
        },

[query]

    http://localhost:5678/webhook-test/execute-python


    http://localhost:5678/webhook-test/execute-python?processo=curva

    *resultado:

        "query": 
        {
            "processo": "curva"
        },

[body]

    curl --location 'http://localhost:5678/webhook/ehub' \
    --header 'Content-Type: application/json' \
    --data '{"nome":"teste", "mensagem": "Teste vindo do n8n", "origem": "n8n"}'

    resultado:

        "body":
        {
         "nome":"teste", "mensagem": "Teste vindo do n8n", "origem": "n8n"
        }

