const dados_yakult = $input.all();

let total_avista = 0;
let total_aprazo = 0;
let total_pendente = 0;
let total_pago = 0;
let total_total = 0;

dados_yakult
  .forEach(item => {
    const valor_total = item.json.valor || 0;
    total_total += valor_total;
  });

// Total à vista
dados_yakult
  .filter(item => item.json.avista?.toLowerCase() === 'sim')
  .forEach(item => {
    const valor_avista = item.json.valor || 0;
    total_avista += valor_avista;
  });

dados_yakult
  .filter(item => item.json.avista?.toLowerCase() === 'não' && item.json.pago?.toLowerCase() === 'sim')
  .forEach(item => {
    const valor_pago = item.json.valor || 0;
    total_pago += valor_pago;
  });

dados_yakult
  .filter(item => item.json.avista?.toLowerCase() === 'não')
  .forEach(item => {
    const valor_aprazo = item.json.valor || 0;
    total_aprazo += valor_aprazo;
  });

dados_yakult
  .filter(item => item.json.pago?.toLowerCase() === 'não')
  .forEach(item => {
    const valor_pendente = item.json.valor || 0;
    total_pendente += valor_pendente;
  });

const resumo = `
🍎Total de vendas - Yakult

🐶 au au au
Total venda:  R$ ${total_total.toFixed(2)}
-------------------
        RESUMO
-------------------
RECEBIDO:
Total a Vista R$ ${total_avista.toFixed(2)} | Total Pago R$ ${total_pago.toFixed(2)}

A RECEBER:
Total Pendente R$ ${total_pendente.toFixed(2)}

🙏 Deus abençoe `;
return [{
  json: {
    mensagemFormatada: resumo
  }
}];