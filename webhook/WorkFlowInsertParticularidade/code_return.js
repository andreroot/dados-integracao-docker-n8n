// Loop over input items and add a new field called 'myNewField' to the JSON of each one
//for (const item of $input.all()) {
//  item.json.myNewField = 1;
//}

//return $input.all();

if ($input.first().json.resultado==null) {
  
const resumo_alertas = $input.first().json.insert_table;

const dadosParticularidade = resumo_alertas
  .map((item, index) => `${index + 1}. Boleta: ${item.code} | Data de fornecimento: ${item.DataFornecimento} | Data de inserção: ${item.DataInsertTable})`)
  .join('\n');

const totalDadosInseridos = resumo_alertas.length;

const mensagem = `📝 *Inserção de Particularidade*

🔔 Inserido: ${dadosParticularidade}

consulta finalizada
`;

return [
  {
    json: {
      mensagemFormatada: mensagem
    }
  }
]
}
else{
  return [
  {
    json: {
      mensagemFormatada: $input.first().json.resultado
    }
  }
]
};