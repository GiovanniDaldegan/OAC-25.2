PS: esse comentário foi feito considerando a simulação [LAB2/dev/uniciclo.vwf](../../LAB2/dev/uniciclo.vwf), sem considerar que no [TopDE.vwf](../../LAB2/dev/TopDE.vwf) é fornecido apenas um clock e que no TopDE.v ele é dividido no próprio hardware

o uniciclo tá funcionando praticamente perfeito, mas achei muito estranho ele funcionar bem APENAS quando eu "atraso" o clockMem em 10ns, não faz sentido pra mim

eu achava intuitivo fazer o clockCPU e o clockMem começarem juntos em 1 e sempre subirem juntos a cada 40 ns. mas ele nunca funcionava bem, sempre tinha problema na escrita no banco de registradores

aí, só quando fui testar atrasar o clockMem um pouco, ele passa a funcionar LINDAMENTE. de fato, era um problema surreal que não fazia sentido nenhum: passei mais de 4 dias no total tentando entender esse problema e nenhum erro aparente nos módulos, na simulação, em lugar nenhum. realmente foi preciso uma solução surreal que nem sentido faz

pra mim é totalmente contraintuitivo esse descompasso dos clocks, pq:
- do jeito q eu pensava, a instrução estaria disponível na saída da ramI (memória de instruções) na segunda subida do clockMem, que é a descida do clockCPU, dando ao processador 20ns pra decodificar/"interpretar" essa instrução e executá-la, mas isso não funciona
- aí, a solução é deixar a primeira subida do clockMem em 1/4 do clockCPU ao invés de ser junto com ele ????

enfim, o resultado é quase perfeito, só tem alguma falha na hora que deveria escrever uma palavra em 0x10010004, carregar outra de 0x10010000 e depois carregar de novo a de 0x10010004, mas tem um resultado diferente. t0 continua com o mesmo valor durante o sw e o primeiro lw, depois muda de valor pro que deveria ser lido na instrução anterior e não recebe o valor que deveria ser lido no último lw

a execução definitiva:
![execução definitiva (bizarra).png](./execução%20definitiva%20(bizarra).png)

PPS: passei o dia inteiro tentando resolver esse problema e a solução é idiota assim, é duro. pior que estaria perfeito se eu desde o começo usasse o TopDE.vwf. pelo menos arrumei algumas coisinhas, como a execução do lui, as seleções muxOrigReg e muxOrigPC e o nome do Dado2 que tava Dados2


PPPS: tentei a simulação pelo TopDE.vwf e não tem como fazer a execução ser correta. não faço ideia de onde ele tira os X (don't care) do PC e pq a execução falha, com a escrita no BancoReg funcionando de vez em quando e os pulos sendo ignorados. vai ficar só na simulação pelo uniciclo.vwf msm