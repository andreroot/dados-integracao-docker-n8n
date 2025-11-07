const dados_yakult = $input.all();

// Filtro: últimos 7 dias
const hoje = new Date();
const seteDiasAtras = new Date();
seteDiasAtras.setDate(hoje.getDate() + 0);

function formatarDataParaBR(data) {
  const dia = String(data.getDate()).padStart(2, '0');
  const mes = String(data.getMonth() + 1).padStart(2, '0');
  const ano = data.getFullYear();
  return `${dia}-${mes}-${ano}`;
}
// Função para converter 'dd-mm-yyyy' para Date
function parseDataBR(dataStr) {
  const [dia, mes, ano] = dataStr.split('-');
  return new Date(`${ano}-${mes}-${dia}`);
}

const dataFormatada = formatarDataParaBR(seteDiasAtras);

const dados_filtrados = dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data >= parseDataBR(dataFormatada);

})
    .map((item) => {
    const nome = item.json.nome;
    const end = item.json.end;
    const data_pagto = item.json.data_pgto;
    const valor = item.json.valor;
      
    return `${nome} ${end} ${data_pagto} ${valor}`;
  }).join('\n\,');

// .forEach(item => {
//     const valor_pendente = item.json.valor || 0;
//     total_total_filtrado += valor_pendente;
//   });


let total_avista = 0;
let total_aprazo = 0;
let total_pendente = 0;
let total_pago = 0;
let total_total = 0;
let total_total_filtrado = 0;

dados_yakult
  .forEach(item => {
    const valor_total = item.json.valor || 0;
    total_total += valor_total;
  });

dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data >= parseDataBR(dataFormatada);

})
.forEach(item => {
    const valor_pendente = item.json.valor || 0;
    total_total_filtrado += valor_pendente;
  });


// // Total à vista
dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data >= parseDataBR(dataFormatada);

})
  .filter(item => item.json.avista?.toLowerCase() === 'sim')
  .forEach(item => {
    const valor_avista = item.json.valor || 0;
    total_avista += valor_avista;
  });

dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data >= parseDataBR(dataFormatada);

})
  .filter(item => item.json.avista?.toLowerCase() === 'não' && item.json.pago?.toLowerCase() === 'sim')
  .forEach(item => {
    const valor_pago = item.json.valor || 0;
    total_pago += valor_pago;
  });

dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data >= parseDataBR(dataFormatada);

})  .filter(item => item.json.avista?.toLowerCase() === 'não')
  .forEach(item => {
    const valor_aprazo = item.json.valor || 0;
    total_aprazo += valor_aprazo;
  });

dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data >= parseDataBR(dataFormatada);

})
  .filter(item => item.json.pago?.toLowerCase() === 'não')
  .forEach(item => {
    const valor_pendente = item.json.valor || 0;
    total_pendente += valor_pendente;
  });

const resumo = `
🍎Total de vendas - Yakult

🐶 au au au
Total venda apartir do dia ${dataFormatada}:  R$ ${total_total_filtrado.toFixed(2)}

-------------------
        RESUMO
-------------------
RECEBIDO:
Total a Vista R$ ${total_avista.toFixed(2)} 
Total Pago R$ ${total_pago.toFixed(2)}

A RECEBER:
Total Pendente R$ ${total_pendente.toFixed(2)}


🙏 Deus abençoe `;
// const resumo2 = `${dados_filtrados}`;
return [{
  json: {
    mensagemFormatada: resumo
  }
}];



// dados_yakult
//   .forEach(item => {
//     const valor_total = item.json.valor || 0;
//     total_total += valor_total;
//   });


// .forEach(item => {
//     const valor_pendente = item.json.valor || 0;
//     total_total_filtrado += valor_pendente;
//   });
