webhook 
resposnavel em enviar execução de um processo para maq remota

*url: 
http://172.16.128.133:5678/webhook-test/service-executor

*parametros:
?process=Boletim_Focus_Inflacao
?process=Curva-Oficial-30min

*realiza uma execução:
sh /home/node/scripts/executa_remoto.sh administrador@172.16.128.133  {{ $json.executar[0] }}

Os Parametros são importantes:

parametros é o nome da "pasta do processo" ou "github" em execução
https://github.com/grupo-safira/Curva-Oficial-30min
https://github.com/grupo-safira/Boletim_Focus_Inflacao


dentro de cada processo existe a pasta /running que tem um executavel do processo em .sh
que faz a chamada do python
