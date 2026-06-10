-- create a table
CREATE TABLE pentecoste_config (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  sistema TEXT NOT NULL,
  active BOOLEAN NOT NULL DEFAULT FALSE
);

-- add test data
INSERT INTO pentecoste_config (sistema, active)
  VALUES ('my_cust', true),
  ('yakult', true),
  ('copy_csv', true);


CREATE SCHEMA IF NOT EXISTS pentecoste;


CREATE TABLE IF NOT EXISTS yakult_vendas (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  cliente TEXT,
  endereco TEXT,
  produto TEXT,
  quantidade INTEGER,
  valor NUMERIC(10,2),
  data_pagamento DATE,
  opcao_pagamento_avista BOOLEAN,
  opcao_pagamento_aprazo BOOLEAN
);

CREATE TABLE yakult_vendas_tmp (
   cliente TEXT,
    endereco TEXT,
    produto TEXT,
    quantidade INTEGER,
    valor NUMERIC(10,2),
    data_pagamento DATE,
    opcao_pagamento_avista TEXT,
    opcao_pagamento_aprazo TEXT,
    process_time TIMESTAMP(timezone=True)
);



INSERT INTO yakult_vendas (cliente, endereco, produto, quantidade, valor, data_pagamento, opcao_pagamento_avista, opcao_pagamento_aprazo)
  VALUES ('Cliente A', 'Endereço A', 'Produto A', 2, 29.90, '2025-01-01', true, false),
         ('Cliente B', 'Endereço B', 'Produto B', 1, 19.90, '2025-01-02', false, true);


-- CREATE TABLE tickets (
--     id_ticket                      int4           NOT NULL,
--     id_tenant                      int4           NOT NULL,
--     id_workflow                    uuid,
--     ds_workflow                    varchar(1024),
--     id_departamento                int4,
--     ds_departamento                varchar(1024),
--     dt_criacao_ticket              date,
--     dt_ultima_atualizacao          date,
--     dt_finalizacao                 date,
--     qt_interacoes                  int4,
--     ic_cliente_respondeu           boolean,
--     id_ticket_uuid                 uuid           NOT NULL,
--     dt_sla_geral                   timestamp,
--     dt_sla                         timestamp,
--     ic_dentro_sla_geral            boolean,
--     ds_motivo_contato              varchar(1024),
--     id_cliente                     varchar(1024),
--     nm_ticket                      varchar(1023),
--     ds_ticket                      text,
--     vl_crm_preco                   numeric,
--     PRIMARY KEY (id_ticket, id_tenant)
-- );

CREATE SCHEMA IF NOT EXISTS yakult;

ALTER TABLE yakult_vendas_tmp
  ADD COLUMN insertion_ts TIMESTAMPTZ DEFAULT now();


-- conectar docker exec -it postgres_db psql -U admin -d pentecoste
/**
\l or \\list	List all databases on the server.
\c [dbname]	Connect to a specific database.
\dt	List tables in the current database's public schema.
\dt *.*	List all tables across all schemas in the current database.
\d [table_name]	Describe a table, showing column details, types, and constraints.
\dn	List all schemas in the current database.
\du	List all users (roles) and their permissions.
\?	Display help information and a list of all available psql commands.
\q	Quit the psql session.

**/