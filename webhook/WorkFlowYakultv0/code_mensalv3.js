const dados_yakult = $input.all();

// Preparar filtro de datas
const hoje = new Date();

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

// vendas no prazo pra recebimento

const atualDias = new Date();
atualDias.setDate(hoje.getDate() + 0);

const atualdataFormatada = formatarDataParaBR(atualDias);

// listagem para validacao
const dados_areceber_prazo = dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data >= parseDataBR(atualdataFormatada);

})
    .map((item) => {
    const nome = item.json.nome;
    const end = item.json.end;
    const data_pagto = item.json.data_pgto;
    const valor = item.json.valor;
      
    return `${nome} ${end} ${data_pagto} ${valor}`;
  }).join('\n\,');

/// valores no prazo pra recebimento
let total_areceber_noprazo = 0;

dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data >= parseDataBR(atualdataFormatada);

})
  .filter(item => item.json.pago?.toLowerCase() === 'não')
  .forEach(item => {
    const valor_areceber_noprazo = item.json.valor || 0;
    total_areceber_noprazo += valor_areceber_noprazo;
  });

/// NÃO RECEBIDO VENCIDO valores totais que passou do prazo pra recebimento e nao recebeu

// listagem para validacao
const dados_arecber_vencidos = dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data < parseDataBR(atualdataFormatada);

})
    .map((item) => {
    const nome = item.json.nome;
    const end = item.json.end;
    const data_pagto = item.json.data_pgto;
    const valor = item.json.valor;
      
    return `${nome} ${end} ${data_pagto} ${valor}`;
  }).join('\n\,');

/// valores no prazo pra recebimento
let total_areceber_vencido = 0;

dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data < parseDataBR(atualdataFormatada);

})
  .filter(item => item.json.pago?.toLowerCase() === 'não')
  .forEach(item => {
    const valor_areceber_vencido = item.json.valor || 0;
    total_areceber_vencido += valor_areceber_vencido;
  });

/// TOTAL DE RECEBIMENTO NO UTLIMOS 15 DIAS
const quinzeDiasAtras = new Date();
quinzeDiasAtras.setDate(hoje.getDate() - 15);

const quinzediasFormatada = formatarDataParaBR(quinzeDiasAtras);

let total_vendas_ultimos_quinze_dias = 0;

// listagem para validacao
const dados_ultimos_quinze_dias = dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data > parseDataBR(quinzediasFormatada) && data < parseDataBR(atualdataFormatada);

})
    .map((item) => {
    const nome = item.json.nome;
    const end = item.json.end;
    const data_pagto = item.json.data_pgto;
    const valor = item.json.valor;
      
    return `${nome} ${end} ${data_pagto} ${valor}`;
  }).join('\n\,');

//valores totais dos 
dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data > parseDataBR(quinzediasFormatada) && data < parseDataBR(atualdataFormatada);

})
.forEach(item => {
    const valor_vendas_ultimos_quinze_dias = item.json.valor || 0;
    total_vendas_ultimos_quinze_dias += valor_vendas_ultimos_quinze_dias;
  });

let total_vendas_ultimos_quinze_dias_avista = 0;


// // Total à vista
dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data > parseDataBR(quinzediasFormatada) && data < parseDataBR(atualdataFormatada);

})
  .filter(item => item.json.avista?.toLowerCase() === 'sim')
  .forEach(item => {
    const valor_vendas_ultimos_quinze_dias_avista = item.json.valor || 0;
    total_vendas_ultimos_quinze_dias_avista += valor_vendas_ultimos_quinze_dias_avista;
  });

let total_vendas_ultimos_quinze_dias_aprazo = 0;

// // Total a prazo
dados_yakult
  .filter(item => 
  {
  const dataStr = item.json.data_pgto;
  if (!dataStr) return false;
  const data = parseDataBR(dataStr);
  return data > parseDataBR(quinzediasFormatada) && data < parseDataBR(atualdataFormatada);

})
  .filter(item => item.json.avista?.toLowerCase() === 'não')
  .forEach(item => {
    const valor_vendas_ultimos_quinze_dias_aprazo = item.json.valor || 0;
    total_vendas_ultimos_quinze_dias_aprazo += valor_vendas_ultimos_quinze_dias_aprazo;
  });

// dados_yakult
//   .filter(item => 
//   {
//   const dataStr = item.json.data_pgto;
//   if (!dataStr) return false;
//   const data = parseDataBR(dataStr);
//   return data >= parseDataBR(atualdataFormatada);

// })
//   .filter(item => item.json.avista?.toLowerCase() === 'não' && item.json.pago?.toLowerCase() === 'sim')
//   .forEach(item => {
//     const valor_pago = item.json.valor || 0;
//     total_pago += valor_pago;
//   });

// dados_yakult
//   .filter(item => 
//   {
//   const dataStr = item.json.data_pgto;
//   if (!dataStr) return false;
//   const data = parseDataBR(dataStr);
//   return data >= parseDataBR(atualdataFormatada);

// })  .filter(item => item.json.avista?.toLowerCase() === 'não')
//   .forEach(item => {
//     const valor_aprazo = item.json.valor || 0;
//     total_aprazo += valor_aprazo;
//   });



const resumo = `
🍎Total de vendas - Yakult
-------------------
        RESUMO
-------------------
🐶 au au au
Resumo do dia ${atualdataFormatada}

A RECEBER NO PRAZO:
Total Pendente no prazo R$ ${total_areceber_noprazo.toFixed(2)}

A RECBER VENCIDO:
Total Pendente no prazo R$ ${total_areceber_vencido.toFixed(2)}


🐶 au au au
Vendas nos ultimos 15 dias ${quinzediasFormatada}

A VISTA:
Total a Vista recebidos nos ultimos 15 dias R$ ${total_vendas_ultimos_quinze_dias_avista.toFixed(2)} 

A PRAZO:
Total a Vista recebidos nos ultimos 15 dias R$ ${total_vendas_ultimos_quinze_dias_aprazo.toFixed(2)} 

🙏 Deus abençoe `;
// const resumo2 = `${dados_filtrados}`;
return [{
  json: {
    mensagemFormatada: resumo
  }
 }];