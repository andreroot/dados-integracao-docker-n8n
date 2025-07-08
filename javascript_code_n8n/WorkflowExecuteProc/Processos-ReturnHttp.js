// Codigo para formatar a resposta de uma consulta de processos
// no n8n, extraindo o total e a lista de processos consultados
// e formatando a mensagem para ser enviada como resposta
// Assumindo que o input é um array de objetos JSON com os campos necessários
// const 'total' contém o total de processos consultados
// const 'consultas' contém a lista de processos consultados
// const 'mensagem' contém o JSON retornado pelo comando
// return 'mensagemFormatada' é o campo que será retornado com a mensagem formatada

const total = $input.first().json.totalexecutados;
const consultas = $input.first().json.processosexecutados;

const listaFormatada = consultas
  .map((item, index) => `${index + 1}. ${item}`)
  .join('\n');

const mensagem = `📝 *Processos consultados*

Total de processos consultados: *${total}*

${listaFormatada}

consulta finalizada
`;

return [
  {
    json: {
      mensagemFormatada: mensagem
    }
  }
];