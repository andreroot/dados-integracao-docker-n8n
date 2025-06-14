# 📡 n8n Webhook

objetivo: gerar fluxo que possam integrar mais nossos processos.


### Workflows | Montar Fluxo 

- **Fluxo | execução de processo py via shell com ssh**

    **endpoint ExecutePy** http://localhost:5678/webhook/execute-python?processo=curva


    *formas de enviar parametros para webhook - configuração:*

    [params]
        http://localhost:5678/webhook-test/39b27ed9-bf7f-4d15-b40c-d13b596b7196/recebe-params/:item/item


        http://172.16.128.133:5678/webhook-test/39b27ed9-bf7f-4d15-b40c-d13b596b7196/recebe-params/3/item

    resultado:
        "params": 
        {
        "item": 
        "3"
        },
    [query]
        http://localhost:5678/webhook-test/execute-python


        http://172.16.128.133:5678/webhook-test/execute-python?processo=curva

    resultado:

        "query": 
        {
            "processo": "curva"
        },

    [body]

    curl --location 'http://localhost:5678/webhook/ehub' \
    --header 'Content-Type: application/json' \
    --data '{"nome":"teste", "mensagem": "Teste vindo do n8n", "origem": "n8n"}'


    **comandos ssh** criado um script shell para execução dos processos via ssh

        sh /home/node/scripts/executa_remoto.sh
        recebe parametros <user@localhost> <path do script shell>

    **exemplo da execução que ocorre no shell script** 
    
    ```sshapass <pass> sh /home/node/scripts/executa_remoto.sh administrador@172.16.128.133 /home/administrador/projetos/Curva-Oficial-30min/```

    **usando ngrok** http://c987-189-39-40-177.ngrok-free.app/webhook/execute-python?processo=curva

    **execução de ssh via docker run**

    ```docker run --rm -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro my-ssh-image user@host "ls"```

    ```docker exec n8n_start-n8n-1 "/home/node/scripts/executa_remoto.sh"```

    ```docker run --rm -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro my-ssh-image /home/node/scripts/executa_remoto.sh```

    **objetivo:** fluxo que recebe um parametro ?processo=<nome do processo>

- **Fluxo | integração com waha**

    **Waha** subir pacote no N8N - @devlikeapro/n8n-nodes-waha

    **objetivo:** fluxo que recebe via whatsapp comandos e são criados fluxos para as msgs com palavras chave

### Administração | Dockers 

- **comandos docker** a estrutura dos docker esta baseada em docker compose

[baixar]

    docker-compose down

[subir]

    docker-compose up -d 

[update]

    docker-compose up --build -d

    docker-compose down --volumes --remove-orphans

    docker-compose build --no-cache

    docker-compose up -d

- **migrar arquivos para maq local**

    ```sudo chmod 777 /home/administrador/projetos/n8n/dados-integracao-docker-n8n/n8n_data/```

    ```sudo chown -R administrador:administrador /home/administrador/projetos/n8n/dados-integracao-docker-n8n/n8n_data/```
    
    ```sudo chgrp administrador /home/administrador/projetos/n8n/dados-integracao-docker-n8n/n8n_data/```

    **copiar de arquivos** scp n8n_data/_data/* administrador@host:/home/administrador/projetos/n8n/dados-integracao-docker-n8n/n8n_data/_data
    
    **permissoes para docker ler/escrever na pasta volume** sudo chown -R 1000:1000 ./n8n_data