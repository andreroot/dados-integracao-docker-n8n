// Script para extrair informações de uma string JSON retornada por um comando Docker
const text = $json["stdout"];

// Expressão regular para capturar todas as ocorrências de DESCRICAO_STATUS
// const matches = [...text.matchAll(/"DESCRICAO_STATUS"\s*:\s*"([^"]+)"/g)];
// Regex para capturar o conteúdo entre colchetes
// const matches = [...text.matchAll(/\[(.*?)\]/g)];
// const matches = [...text.matchAll(/Resultados da operação:\s*(\[.*?\])/g)];

// Se encontrou, quebra a string em um array removendo aspas e espaços
// const boleta = [...text.matchAll(/'code':\s*'([^']+)/g)];

// Regex para extrair conteúdo entre colchetes
const match = text.match(/\[(.*?)\]/);

// iniciar variaveis
let resultado = [];
let total = 0;

// Pega todos os pares tipo Chave: Valor
if (match && match[1]) {
  resultado = match[1]
    .split(",")
    .map(item => item.trim().replace(/^'|'$/g, ''));
}

// Remove aspas simples e quebra a string em um array
total = resultado.length;

// Retorna o resultado como um array de objetos JSON
return [
  {
    json: {
      totalboletas: total, boletas: resultado
    }
  }
];

