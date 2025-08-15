// Loop over input items and add a new field called 'myNewField' to the JSON of each one
const service = $('Webhook').first().json.query.service
//const valorProcurado2 = "9768134fa4cc47369e1b1b842a2ad92x";

return [{ json: { service: service } }];