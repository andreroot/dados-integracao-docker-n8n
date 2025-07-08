// Loop over input items and add a new field called 'myNewField' to the JSON of each one
//for (const item of $input.all()) {
//  item.json.myNewField = 1;
//}

//return $input.all();

const resumoProcessos = $input.first().json.processos;

// const regex = /sql-server\/extract_(\w+)/g;
const processosFiltrados = resumoProcessos.filter(item =>
  /sql-server\/extract_/.test(item.processo)
);

const resumosql = processosFiltrados
  .map((item, index) => `${index + 1}. *${item.processo}*\n\n${item.data} | Total de linhas: ${item.linhas}`)
  .join('\n\n');


// const resumo_processo_sql = [...resumo_processos.matchAll(regex)];

const resumo = resumoProcessos
  // .filter((item, index) => /sql-server\/extract_/.test(item.processo)
  .map((item, index) => `${index + 1}. *${item.processo}*\n\n${item.data} | Total de linhas: ${item.linhas}`)
  .join('\n\n');


const total = resumo_processos.length;

const mensagem = `📝 *Processos consultados*

Total de processos consultados: *${total}*

Resumo dos processos executados na madrugada:
${resumosql}

Resumo dos processos executados Hoje:
${resumo}

consulta finalizada
`;

return [
  {
    json: {
      mensagemFormatada: mensagem
    }
  }
];