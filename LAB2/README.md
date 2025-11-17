o relatório do lab e o envio na tarefa do aprender3 estão sem os itens 1.7 c) e
d) por dois motivos (aparentes até agora):
- as simulações funcional e temporal em .vwf PRECISAM da flag `-voptargs="+acc"` pra terem resultado (ou eu tô com alguma configuração errada no meu projeto ou realmente o Quartus Prime v24.1 Lite exige que a remoção da flag `-novopt` E a adição de `-voptargs="+acc"`)
- o banco de registradores não têm seus pinos de entrada e saída reconhecidos (pelo menos iReadRegister2, iWriteData, oRegDisp, são os que eu tenho print do warning, mas provavelmente são todos ou só os vetores de pinos). testei uma simulação com o `Registers.v` como top level e tive erros

TODO:
- reescrever o banco de registradores pra ver se funciona
- testar os demais módulos:
    - [x] testar o imm pelo TopDE
    - [ ] testar o oRegDisp pelo TopDE
    - [ ] testar a saída da ULA pelo TopDE
