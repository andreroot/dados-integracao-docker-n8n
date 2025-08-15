// Loop over input items and add a new field called 'myNewField' to the JSON of each one
const session = $input.all();
const nrotelefonezap = $('WAHA Trigger').first().json.payload.from
//const valorProcurado2 = "9768134fa4cc47369e1b1b842a2ad92x";

// Usando find para obter o objeto
const resultado1 = session
  .filter(match => match.json.telefone === nrotelefonezap)
 .map((item, index) => `${item.json.nome}`)

//const resultado2 = session.find(item => item.json.sessionId === //valorProcurado2);


if (resultado1) {

  return [{ json: { resultado: true, sessionid: resultado1 } }];
} else  {

        const nome = 'Novo';

  return [{ json: { resultado2:  true, sessionid: nome } }];
}