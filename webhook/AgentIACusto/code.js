// Loop over input items and add a new field called 'myNewField' to the JSON of each one
const session = $input.all()
const nrotelefonezap = $('Webhook').first().json.body.chatId
//const valorProcurado2 = "9768134fa4cc47369e1b1b842a2ad92x";


// Usando find para obter o objeto
const resultado1 = session
  .filter(match => match.json.telefone === nrotelefonezap)
 .map((item, index) => `${item.json.nome}`)

//const resultado2 = session.find(item => item.json.sessionId === //valorProcurado2);

// Usando find para obter o objeto
const grupo = session
  .filter(match => match.json.telefone === nrotelefonezap)
 .map((item, index) => `${item.json.grupo_usuario}`)

if (resultado1) {
  const payloadzap = $('Webhook').first().json.body
  const operacao = $('Edit Fields').first().json.query.operacao
  return [{ json: { validacao: true, grupo: grupo, operacao: operacao, sessionid: resultado1, payload: payloadzap  } }];
} else  {

        const nome = 'Novo';
        const payloadzap = $('Webhook').first().json.body
        const operacao = $('Edit Fields').first().json.query.operacao

  return [{ json: { validacao:  true, grupo: null, operacao: operacao, sessionid: nome, payload: payloadzap } }];
}
