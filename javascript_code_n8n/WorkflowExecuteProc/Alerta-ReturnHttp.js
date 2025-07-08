// Loop over input items and add a new field called 'myNewField' to the JSON of each one
//for (const item of $input.all()) {
//  item.json.myNewField = 1;
//}

//return $input.all();

const resumo_alertas = $input.first().json.alertas;

const SafiraListaFormatada = resumo_alertas
  .filter(match => match.Thunders === 'Safira')
  .map((item, index) => `${index + 1}. ${item.tipo_erro} - ${item.erros}`)
  .join('\n');

const totalSafira = resumo_alertas
  .filter(match => match.Thunders === 'Safira')
  .reduce((soma, item) => soma + item.erros, 0);

const ComercialListaFormatada = resumo_alertas
  .filter(match => match.Thunders === 'Comercial')
  .map((item, index) => `${index + 1}. ${item.tipo_erro} - ${item.erros}`)
  .join('\n');

const totalComercial = resumo_alertas
  .filter(match => match.Thunders === 'Comercial')
  .reduce((soma, item) => soma + item.erros, 0);

const mensagem = `📝 *Alertas com possiveis erros operacionais*

Resumo:

*Safira | erros | ${totalSafira}*
${SafiraListaFormatada}

*Comercial | erros | ${totalComercial}*
${ComercialListaFormatada}


consulta finalizada
`;

return [
  {
    json: {
      mensagemFormatada: mensagem
    }
  }
];