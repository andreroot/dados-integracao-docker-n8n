// Código para extrair JSON de um stdout de comando Docker no n8n
// Este código assume que o stdout contém uma string JSON dentro de colchetes após a frase
const stdout = $json.stdout;

// Encontra o JSON embutido com regex
const match = stdout.match(/Yakult/);

// Se encontrou
if (match && match[1]) {
  const jsonString = match[1]
    .replace(/'/g, '"'); // troca aspas simples por aspas duplas

  try {
    // Faz o parse do JSON
    // const codes = jsonString.match(/"code":\s*"([^"]+)"/);
    // const tipos = jsonString.match(/"tipo_erro":\s*"([^"]
    const lista_processo = JSON.parse(jsonString);
    //OR
    // const tipo_erro = parsed.map(item => item.tipo_erro);
    // const Thunders = parsed.map(item => item.Thunders);
    // const t_erros = parsed.map(item => item.erros);
    // const t_boletas = parsed.map(item => item.boletas);
    
    return [
      {
        json: {
          processos: lista_processo
        }
      }
    ];
  } catch (err) {
    return [{ json: { error: "Erro ao fazer parse do JSON", detalhe: err.message } }];
  }
} else {
  return [{ json: { error: "Não encontrou os dados no stdout" } }];
}