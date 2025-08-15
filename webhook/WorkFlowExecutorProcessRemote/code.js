// Loop over input items and add a new field called 'myNewField' to the JSON of each one
const process = $input.all()
const processwebhook = $('Webhook').first().json.query.process
//const valorProcurado2 = "9768134fa4cc47369e1b1b842a2ad92x";

const resultado = process
.filter(match => match.json.depara_url === processwebhook)
.map((item, index)=>`${item.json.path}${item.json.processo}${item.json.runnig}`)
// Usando find para obter o objeto

return [{json: {processo: processwebhook, executar: resultado}}]

