// Loop over input items and add a new field called 'myNewField' to the JSON of each one
function formatarData(dataStr) {
  // Espera data no formato "DD/MM/YYYY"
  const [ano, mes, dia] = dataStr.split('-');
  return `${dia}/${mes}`; // Retorna "YYYY-MM-DD"
}

const venda = $input.all();


// CASO SEJA AVISTA A VENDA
if ($input.first().json.avista==="sim") {
  
  const resumo = venda.map((item, index) => 
  `🐶Cliente ${item.json.nome}, pagou o valor de ${item.json.valor} a vista no dia ${formatarData(item.json.data_pgto)}`).join('\n');
  
const mensagem = `🥳 *Parabéns mais uma venda realizada* 

${resumo}
🙏
`;  
return [
  {
    json: {
      mensagemFormatada: mensagem
    }
  }
];  
}
// CASO SEJA A PRAZO A VENDA
else
{

const resumo = venda.map((item, index) => 
  `🐾Cliente ${item.json.nome}, optou pelo pagamento a prazo do valor de ${item.json.valor} e combinou na data do pagamento ${formatarData(item.json.data_pgto)}, aguardar pagamento`).join('\n');
  
const mensagem = `☺️ *Parabéns mais uma venda realizada* 

${resumo}
🙏
`;  

  return [
  {
    json: {
      mensagemFormatada: mensagem
    }
  }
];
}




