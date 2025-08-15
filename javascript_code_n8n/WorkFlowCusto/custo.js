// Loop over input items and add a new field called 'myNewField' to the JSON of each one
const custo = $input.all();

const cab = `*Mes Referencia: ${custo[0].json.dt_custo}*`;

const resumo = custo.map((item, index) => 
  `*detalhes: ${index + 1}. descrição: ${item.json.tipo_custo} / dia: ${item.json.dt_custo} / valor: R$ ${item.json.valor_custo}`).join('\n\n');

const mensagem = `💥*Custo detalhe - Item e Periodo*
${cab}

🐾Detalhes:
${resumo}


consulta finalizada🙉
`;


return [

🐾Detalhes:
${resumo}


consulta finalizada🙉
`;


return [
  {
    json: {
      mensagemFormatada: mensagem
    }
  }
];