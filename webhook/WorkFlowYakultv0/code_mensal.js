const dados_yakult = $input.all();

let total_agosto = 0;
let total_setembro = 0;


dados_yakult
  .filter(item => item.json.info?.toLowerCase() === 'venda')
  .forEach(item => {
    const vlr_agosto = item.json.agosto || 0;
    total_agosto += vlr_agosto;
    const vlr_setembro = item.json.setembro || 0;
    total_setembro += vlr_setembro;    
  });

const total = total_agosto+total_setembro

const resumo = `
🍎Total de vendas Mes - Yakult

🐶 au au au
Total venda:  R$ ${total.toFixed(2)}
-------------------
        RESUMO
-------------------
MES AGOSTO:
Total venda R$ ${total_agosto.toFixed(2)} 
MES SETEMBRO:
Total venda R$ ${total_setembro.toFixed(2)} 

🙏 Deus abençoe `;
return [{
  json: {
    mensagemFormatada: resumo
  }
}];