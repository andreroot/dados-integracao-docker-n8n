FROM ubuntu:22.04

USER root

# ARG GITHUB_TOKEN

# Instala dependências básicas
RUN apt-get update && \
    apt-get install -y curl git sshpass openssh-client
# apt-get install -y curl python3 python3-pip python3-venv git sshpass openssh-client


# Instala Node.js (LTS) e npm
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# Instala n8n globalmente
RUN npm install -g n8n

# # (Opcional) Instala pacotes Python
# RUN python3 -m venv /opt/venv && \
#     /opt/venv/bin/pip install --upgrade pip && \
#     /opt/venv/bin/pip install pandas requests boto3 sqlalchemy pymssql pyodbc

# # Instala Python
# RUN apk update && apk add --no-cache python3 py3-pip py3-virtualenv

# # Cria virtualenv
# RUN python3 -m venv /opt/venv

# # Ativa virtualenv e instala pacotes
# RUN /opt/venv/bin/pip install --upgrade pip && \
#     /opt/venv/bin/pip install pandas requests boto3 sqlalchemy pymssql \
#     git+https://${GITHUB_TOKEN}:x-oauth-basic@github.com/grupo-safira/geralog-monitoria.git#egg=geralog \
#     git+https://${GITHUB_TOKEN}:x-oauth-basic@github.com/grupo-safira/dados-process-management.git#egg=dynamically
    

# Adiciona virtualenv ao PATH
# ENV PATH="/opt/venv/bin:$PATH"

# # Cria usuário para rodar o n8n
# RUN useradd --create-home --shell /bin/bash n8n
# USER n8n
# WORKDIR /home/n8n

# # Porta padrão do n8n
# EXPOSE 5678

# # Comando para iniciar o n8n
# CMD ["n8n"]

# Adiciona virtualenv ao PATH
ENV PATH="/opt/venv/bin:$PATH"

RUN useradd --create-home --shell /bin/bash node

# Instala o node WAHA dentro do diretório custom
WORKDIR /home/node/.n8n/custom

RUN npm init -y && \
    npm install https://github.com/devlikeapro/n8n-nodes-waha.git

# Define a variável de ambiente pra N8N carregar extensões
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/custom

# Instale tini (init system para containers)
RUN apt-get update && apt-get install -y tini

USER node

RUN chown -R node:node /home/node/.n8n

ENTRYPOINT ["tini", "--"]
CMD ["n8n"]

# Instala SSH client e outras dependências
# RUN apt-get update && apt-get install -y openssh-client

# (Opcional) Copie sua chave privada para dentro do container
# COPY id_rsa /root/.ssh/id_rsa
# RUN chmod 600 /root/.ssh/id_rsa

# Adiciona um script de execução
# COPY run-ssh.sh /run-ssh.sh
# RUN chmod +x /home/node/scripts/run-ssh.sh

# COPY scripts/executa_remoto.sh /executa_remoto.sh
# RUN chmod +x /home/node/scripts/executa_remoto.sh

# ENTRYPOINT ["/run-ssh.sh"]