// Loop over input items and add a new field called 'myNewField' to the JSON of each one
//for (const item of $input.all()) {
//  item.json.myNewField = 1;
//
//}

//return $input.all();
 

const texto = $input.first().json.payload.body || "";

const palavrasChave = ["agent", "campeao", "barbosa", "bora bill"];
const textoLower = texto.toLowerCase();

const contemTrecho = palavrasChave.some(palavra => textoLower.includes(palavra));
//console.log(`Texto contém trecho: ${contemTrecho}`);
return [
  {
    json: {
      validado: contemTrecho,
      mensagem_original: texto
    }
  }
];