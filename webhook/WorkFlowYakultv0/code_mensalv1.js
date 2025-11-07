const dados_yakult = $input.all();

let total_vend_julho = 0;
let total_vend_agosto = 0;
let total_vend_setembro = 0;
let total_vend_outubro = 0;


dados_yakult
  .filter(item => item.json.info?.toLowerCase() === 'Vendas na rua')
  .forEach(item => {
    const vlr_julho = item.json.julho || 0;
    total_vend_julho += vlr_julho;
    
    const vlr_agosto = item.json.agosto || 0;
    total_vend_agosto += vlr_agosto;    
    
    const vlr_setembro = item.json.setembro || 0;
    total_vend_setembro += vlr_setembro;
    
    const vlr_outubro = item.json.outubro || 0;
    total_vend_outubro += vlr_outubro;       
  });

const total_vend = total_vend_julho+total_vend_agosto+total_vend_setembro+total_vend_outubro



let total_nf_julho = 0;
let total_nf_agosto = 0;
let total_nf_setembro = 0;
let total_nf_outubro = 0;

dados_yakult
  .filter(item => item.json.info?.toLowerCase() === 'Vendas ao cliente')
  .forEach(item => {
    const vlr_julho = item.json.julho || 0;
    total_nf_julho += vlr_julho;
    
    const vlr_agosto = item.json.agosto || 0;
    total_nf_agosto += vlr_agosto;    
    
    const vlr_setembro = item.json.setembro || 0;
    total_nf_setembro += vlr_setembro;
    
    const vlr_outubro = item.json.outubro || 0;
    total_nf_outubro += vlr_outubro;       
  });
const total_nf = total_nf_julho+total_nf_agosto+total_nf_setembro+total_nf_outubro




let total_custonf_julho = 0;
let total_custonf_agosto = 0;
let total_custonf_setembro = 0;
let total_custonf_outubro = 0;

dados_yakult
  .filter(item => item.json.info?.toLowerCase() === 'Compras Notas Fiscais')
  .forEach(item => {
    const vlr_julho = item.json.julho || 0;
    total_nf_julho += vlr_julho;
    
    const vlr_agosto = item.json.agosto || 0;
    total_nf_agosto += vlr_agosto;    
    
    const vlr_setembro = item.json.setembro || 0;
    total_nf_setembro += vlr_setembro;
    
    const vlr_outubro = item.json.outubro || 0;
    total_nf_outubro += vlr_outubro;       
  });
const total_custonf = total_custonf_julho+total_custonf_agosto+total_custonf_setembro+total_custonf_outubro


let total_luc_julho = 0;
let total_luc_agosto = 0;
let total_luc_setembro = 0;
let total_luc_outubro = 0;

dados_yakult
  .filter(item => item.json.info?.toLowerCase() === 'Lucro Final')
  .forEach(item => {
    const vlr_julho = item.json.julho || 0;
    total_luc_julho += vlr_julho;
    
    const vlr_agosto = item.json.agosto || 0;
    total_luc_agosto += vlr_agosto;    
    
    const vlr_setembro = item.json.setembro || 0;
    total_luc_setembro += vlr_setembro;
    
    const vlr_outubro = item.json.outubro || 0;
    total_luc_outubro += vlr_outubro;       
  });
const total_luc = total_luc_julho+total_luc_agosto+total_luc_setembro+total_luc_outubro

const resumo = `
🍎Total de vendas Mes - Yakult

🐶 au au au

Total Vendas ao Cliente R$ ${total_nf.toFixed(2)} 
Total Compras Notas Fiscais R$ ${total_custonf.toFixed(2)} 

Total Lucro Final R$ ${total_luc.toFixed(2)} 

*Vendas cadastradas do mês*
Total venda na rua ( a vista / a prazo):  R$ ${total_vend.toFixed(2)}

----------------------------------------------------------------------------
RESUMO
----------------------------------------------------------------------------

MES JULHO:
Total Vendas ao Cliente R$ ${total_nf_julho.toFixed(2)} 
Total Compras Notas Fiscais R$ ${total_custonf_julho.toFixed(2)} 

Total Lucro Final R$ ${total_luc_julho.toFixed(2)} 

*Vendas cadastradas do mês*
Total venda na rua ( a vista / a prazo):  R$ ${total_custonf_julho.toFixed(2)}

----------------------------------------------------------------------------
MES AGOSTO:
Total Vendas ao Cliente R$ ${total_nf_agosto.toFixed(2)} 
Total Compras Notas Fiscais R$ ${total_custonf_agosto.toFixed(2)} 

Total Lucro Final R$ ${total_luc_agosto.toFixed(2)} 

*Vendas cadastradas do mês*
Total venda na rua ( a vista / a prazo):  R$ ${total_custonf_agosto.toFixed(2)}

----------------------------------------------------------------------------
MES SETEMBRO:
Total Vendas ao Cliente R$ ${total_nf_setembro.toFixed(2)} 
Total Compras Notas Fiscais R$ ${total_custonf_setembro.toFixed(2)} 

Total Lucro Final R$ ${total_luc_setembro.toFixed(2)} 

*Vendas cadastradas do mês*
Total venda na rua ( a vista / a prazo):  R$ ${total_custonf_setembro.toFixed(2)}

----------------------------------------------------------------------------
MES OUTUBRO:
Total Vendas ao Cliente R$ ${total_nf_outubro.toFixed(2)} 
Total Compras Notas Fiscais R$ ${total_custonf_outubro.toFixed(2)} 

Total Lucro Final R$ ${total_luc_outubro.toFixed(2)} 

*Vendas cadastradas do mês*
Total venda na rua ( a vista / a prazo):  R$ ${total_custonf_outubro.toFixed(2)}


🙏 Deus abençoe `;
return [{
  json: {
    mensagemFormatada: resumo
  }
}];