const dados_yakult = $input.all();

// Data de 7 dias atrás
const seteDiasAtras = new Date();
seteDiasAtras.setDate(seteDiasAtras.getDate() + 15);

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
//console.log(dataFormatada); // ex: "23-07-2025"

let total_nf = 0;
let total_recebido = 0;
let total_lucro = 0;


const yakult_resumo = dados_yakult
  .filter(item => {
    const dataNota = parseDataBR(item.json.dia);
    return dataNota <= parseDataBR(dataFormatada);
  })
  .map((item) => {
    const valor_nf = parseFloat(item.json.valor_nf) || 0;
    const valor_recebido = parseFloat(item.json.valor_recebido) || 0;
    const valor_saldo_lucro = parseFloat(item.json.valor_saldo_lucro) || 0;
    
    total_nf += valor_nf;
    total_recebido += valor_recebido;
    total_lucro += valor_saldo_lucro;

    return `📅 Dia: ${item.json.dia}\n
    🧾 Valor NF: R$ ${valor_nf.toFixed(2)}\n
    💰 Valor Recebido: R$ ${valor_recebido.toFixed(2)}\n
    🙏 Valor Lucro: R$ ${valor_saldo_lucro.toFixed(2)}\n`;
  })
  .join('\n');

const totalizador = `\n📊 Totalizando periodo solicitado 
de 29-07-2025 ate ${dataFormatada} :\n
🧾 Valor da NF: R$ ${total_nf.toFixed(2)}\n
💰 Valor a receber: R$ ${total_recebido.toFixed(2)}\n
🙏 Lucro preço venda do produtos recebidos: R$ ${total_lucro.toFixed(2)}`;

return [{
  json: {
    mensagemFormatada: yakult_resumo + totalizador
  }
}];