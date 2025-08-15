const text = $json["stdout"];
//const regex = /(\w+):\s*([^\n]+)/g; // Pega todos os pares tipo Chave: Valor

// Expressão regular para capturar todas as ocorrências de DESCRICAO_STATUS
//const matches = [...text.matchAll(/"DESCRICAO_STATUS"\s*:\s*"([^"]+)"/g)];
//const matches = [...text.match(/(\w+:)\s*([^"]+)/g)];

//return [{ processosExecutados: matches }];

// Verifica se há ao menos duas ocorrências
//
  
//if (matches.length >= 2) {
   
//} else {
//  return [{ erro: matches + "Menos de 2 ocorrências encontradas" }];
//}

// Regex para extrair conteúdo entre colchetes
const match = text.match(/\[(.*?)\]/);

// Se encontrou, quebra a string em um array removendo aspas e espaços
let resultado = [];
let total = 0;

if (match && match[1]) {
  resultado = match[1]
    .split(",")
    .map(item => item.trim().replace(/^'|'$/g, ''));
}
total = resultado.length;
return [
  {
    json: {
      totalexecutados: total, processosexecutados: resultado
    }
  }
];
