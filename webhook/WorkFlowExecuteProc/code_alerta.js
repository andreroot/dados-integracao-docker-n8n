// Loop over input items and add a new field called 'myNewField' to the JSON of each one
//for (const item of $input.all()) {
//  item.json.myNewField = 1;
//}

//return $input.all();

const resumo_alertas = $input.first().json.alertas;

const dadosInconsistenciaValoresResultado = resumo_alertas
  .filter(match => match.tipo_erro === 'erros_resultado')
  .map((item, index) => `${index + 1}. ${item.DataFornecimento} | ${item.valor} )`)
  .join('\n');

const totalInconsistenciaResultado = resumo_alertas
  .filter(match => match.tipo_erro === 'erros_resultado')
  .reduce((soma, item) => soma + Number(item.valor), 0);

let alertaResultado;

if (totalInconsistenciaResultado > 50000 || totalInconsistenciaResultado < -50000) {
    alertaResultado = '🙀 DETECTADO ERRO necessário verificar dash Alertas: erros_resultado: valores estão acima de 50.000 ou abaixo de -50.000';
  }
else
  {
    alertaResultado = '🚨 Valores dentro da margem de erro';
  }

const mensagem = `📝 *Alertas inconsistencia no Resultado*

🔔 Verificar com urgencia:

*🚦Resultado | ${totalInconsistenciaResultado}*
detalhes: ${dadosInconsistenciaValoresResultado}

${alertaResultado}

consulta finalizada
`;

return [
  {
    json: {
      mensagemFormatada: mensagem
    }
  }
];