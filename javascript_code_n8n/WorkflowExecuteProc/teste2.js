// Loop over input items and add a new field called 'myNewField' to the JSON of each one
const custo = $input.all();

const resumo = custo.map((item, index) => 
  `${index + 1}. *${item.json.tipo}* 
  Janeiro:${item.json.vlr_jan}
  \n Fevereiro:${item.json.vlr_fev}
  \n Março:${item.json.vlr_mar}
  \n Abril:${item.json.vlr_abr}
  \n Maio:${item.json.vlr_mai}
  \n Junho:${item.json.vlr_jun}
  \n Julho:${item.json.vlr_jul}
  \n Agosto:${item.json.vlr_ago}
  \n Setembro:${item.json.vlr_set}
  \n Outubro:${item.json.vlr_out}
  \n Novembro:${item.json.vlr_nov}
  \n Dezembro:${item.json.vlr_dez}`
                        ).join('\n\n');

const mensagem = `📝 *Custo mensal*

Resumo dos custos:
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