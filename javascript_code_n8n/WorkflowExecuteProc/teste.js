// Loop over input items and add a new field called 'myNewField' to the JSON of each one
const custo = $input.all();
const mes = $('Edit Fields').first().json.query.mes


let resumo = '';
let label = '';

if (mes === "janeiro") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_fev}`).join('\n\n');
  label = 'JAN';
} else if (mes === "fevereiro") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jan}`).join('\n\n');
  label = 'FEV';
} else if (mes === "março") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jan}`).join('\n\n');
  label = 'MAR';
} else if (mes === "abril") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jan}`).join('\n\n');
  label = 'ABR';
} else if (mes === "maio") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jan}`).join('\n\n');
  label = 'MAI';
} else if (mes === "junho") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jan}`).join('\n\n');
  label = 'JUN';        
} else if (mes === "julho") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jul}`).join('\n\n');
  label = 'JUL';
} else if (mes === "agosto") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jul}`).join('\n\n');
  label = 'AGO';
} else if (mes === "setembro") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jul}`).join('\n\n');
  label = 'SET';
} else if (mes === "outubro") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_jul}`).join('\n\n');
  label = 'OUT';
} else if (mes === "novembro") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_nov}`).join('\n\n');
  label = 'NOV';
} else if (mes === "dezembro") {
  resumo = custo.map((item, index) => `${index + 1}. *${item.json.tipo}*\n\n${item.json.vlr_dez}`).join('\n\n');
  label = 'DEZ';
} else {
  resumo = 'Mês não reconhecido.';
  label = mes.toUpperCase();
}

const mensagem = `📝 *Custo mensal*

[${label}] Resumo dos custos:
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