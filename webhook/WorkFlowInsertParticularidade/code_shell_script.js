// Código para extrair JSON de um stdout de comando Docker no n8n
// Este código assume que o stdout contém uma string JSON dentro de colchetes após a frase
const stdout = $json.stdout;

const not_insert = stdout.match(/Não foi inserido dados na tabela ErrosParticularidadesBoletas_v2/);

// Encontra o JSON embutido com regex
const match = stdout.match(/Resultados da operação:\s*(\[.*\])/);

// Se encontrou
if ((not_insert==null) && (match && match[1])) {
  const jsonString = match[1]
    .replace(/'/g, '"'); // troca aspas simples por aspas duplas

  try {
    // Faz o parse do JSON
    //const codes = jsonString.match(/"code":\s*"([^"]+)"/);
    // const tipos = jsonString.match(/"tipo_erro":\s*"([^"]
    const list_alerta = JSON.parse(jsonString);
    //OR
    // const tipo_erro = parsed.map(item => item.tipo_erro);
    // const Thunders = parsed.map(item => item.Thunders);
    // const t_erros = parsed.map(item => item.erros);
    // const t_boletas = parsed.map(item => item.boletas);
    
    return [
      {
        json: {
          insert_table: list_alerta
        }
      }
    ];
  } catch (err) {
    return [{ json: { error: "Erro ao fazer parse do JSON", detalhe: err.message, resultado: not_insert } }];
  }
} else {
  return [{ json: { resultado: not_insert } }];
}