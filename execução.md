instruções obtidas na simulação funcional do processador uniciclo e o seu
disassembly de acordo com o ISCTools
<https://isc-tools.vercel.app/disassembler>


## 1 Geral

### 1.1 Programa de1.s montado
Concide com o resultado do TopDE.vwf no envio do LAB2 pelo aprender3, ou seja,
sem pulos condicionais ou incondicionais, apenas PC + 4

```
nº endereço
00 00400000 100101B7     #       lui     gp, 0x10010             # gp: 0x10010000 (.data)
01 00400004 00018193     #       addi    gp, gp, 0               #
02 00400008 0001A303     # MAIN: lw      t1, 0(gp)               # t1: 0xFFFFFF0F
03 0040000C 77700393     #       addi    t2, zero, 1911          # t2: 0x00000777
04 00400010 007372B3     #       and     t0, t1, t2              # t0: 0x00000707
05 00400014 007362B3     #       or      t0, t1, t2              # t0: 0xFFFFFF7F
06 00400018 006382B3     #       add     t0, t2, t1              # t0: 0x00000686 (overflow)
07 0040001C 406382B3     #       sub     t0, t2, t1              # t0: 0xFFFFF798
08 00400020 007322B3     #       slt     t0, t1, t2              # t0: 0x00000001
09 00400024 0063A2B3     #       slt     t0, t2, t1              # t0: 0x00000000
10 00400028 00028663     #       beq     t0, zero, 12            # tomado, -> PULA
11 0040002C EEE00293     #       addi    t0, zero, -274          # t0: 0xFFFFFEEE
12 00400030 00C0006F     #       jal     zero, 12                # 
13 00400034 00C000EF     # PULA: jal     ra, 12                  # -> PROC
14 00400038 CCC00293     #       addi    t0, zero, -820          # t0: 0xFFFFFCCC
15 0040003C 0000006F     # FIM:  jal     zero, 0                 #
16 00400040 07F00293     # PROC: addi    t0, zero, 127           # t0: 0x0000007F
17 00400044 0051A223     #       sw      t0, 4(gp)               # 4(gp): 0x0000007F
18 00400048 0001A283     #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F
19 0040004C 0041A283     #       lw      t0, 4(gp)               # t0: 0x0000007F
20 00400050 00008067     #       jalr    zero, ra, 0             # -> PULA + 4
```

### 1.2 imediatos das instruções
```
100101B7        # lui     gp, 0x10010       # imm: 10010000
00018193        # addi    gp, gp, 0         # imm: 00000000
0001A303        # lw      t1, 0(gp)         # imm: 00000000
77700393        # addi    t2, zero, 1911    # imm: 00000777
00028663        # beq     t0, zero, 12      # imm: 0000000C
EEE00293        # addi    t0, zero, -274    # imm: FFFFFEEE
00C0006F        # jal     zero, 12          # imm: 0000000C
00C000EF        # jal     ra, 12            # imm: 0000000C
CCC00293        # addi    t0, zero, -820    # imm: FFFFFFCC
0000006F        # jal     zero, 0           # imm: 00000000
07F00293        # addi    t0, zero, 127     # imm: 0000007F
0051A223        # sw      t0, 4(gp)         # imm: 00000004
0001A283        # lw      t0, 0(gp)         # imm: 00000000
0041A283        # lw      t0, 4(gp)         # imm: 00000004
00008067        # jalr    zero, ra, 0       # imm: 00000000
```


### 1.3 Sequência de instruções esperada
contagem de ciclos considerando a máquina de estados do controle do multiciclo! \
BEQ_EX, JALR_EX, JALR_EX -> ID, pulando os 2 estados de IF

```
nº endereço instr        # disassembly                           # regs                      # ciclos
00 00400000 100101B7     #       lui     gp, 0x10010             # gp: 0x10010000 (.data)    # 5
01 00400004 00018193     #       addi    gp, gp, 0               #                           # 5
02 00400008 0001A303     # MAIN: lw      t1, 0(gp)               # t1: 0xFFFFFF0F            # 7
03 0040000C 77700393     #       addi    t2, zero, 1911          # t2: 0x00000777            # 5
04 00400010 007372B3     #       and     t0, t1, t2              # t0: 0x00000707            # 5
05 00400014 007362B3     #       or      t0, t1, t2              # t0: 0xFFFFFF7F            # 5
06 00400018 006382B3     #       add     t0, t2, t1              # t0: 0x00000686 (overflow) # 5
07 0040001C 406382B3     #       sub     t0, t2, t1              # t0: 0xFFFFF798            # 5
08 00400020 007322B3     #       slt     t0, t1, t2              # t0: 0x00000001            # 5
09 00400024 0063A2B3     #       slt     t0, t2, t1              # t0: 0x00000000            # 5
10 00400028 00028663     #       beq     t0, zero, 12            # tomado, -> PULA           # 4
13 00400034 00C000EF     # PULA: jal     ra, 12                  # -> PROC                   # 2 (4 -2)
16 00400040 07F00293     # PROC: addi    t0, zero, 127           # t0: 0x0000007F            # 3 (5 -2)
17 00400044 0051A223     #       sw      t0, 4(gp)               # 4(gp): 0x0000007F         # 6
18 00400048 0001A283     #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F            # 7
19 0040004C 0041A283     #       lw      t0, 4(gp)               # t0: 0x0000007F            # 7
20 00400050 00008067     #       jalr    zero, ra, 0             # -> PULA + 4               # 5
14 00400038 CCC00293     #       addi    t0, zero, -820          # t0: 0xFFFFFCCC            # 3 (5 -2)
15 0040003C 0000006F     # FIM:  jal     zero, 0                 #                           # 4
15 0040003C 0000006F     # FIM:  jal     zero, 0                 #                           # 2* inf (4 -2) (não conta)
15 0040003C ... loop infinito                                                                # total: 93
```

com clock de 20 ns, a execução total toma 93 * 20 = 1860 ns = 1,860 us \
1,980 us se não arrumar a máquina de estados e nunca pular o IF

## 2 Execuções nos processadores

### 2.1 Simulação Uniciclo
PC guarda sempre o próximo PC (n sei se tá certo isso)

   00400000 - 00400024     # -- tipo R, RegOut sempre 0x0 --
10 00400028 00028663  #       beq     t0, zero, 12
11 0040002C 0002  

### 2.2 Simulação Multiciclo (18/11 22h)
Esse ponto foi após correções no Controle e mexidas em vários módulos
comparando com o envio

```
00 100101B7     #       lui     gp, 0x10010             # gp: 0x10010000 (.data)
01 00018193     #       addi    gp, gp, 0               #
02 0001A303     # MAIN: lw      t1, 0(gp)               # t1: 0xFFFFFF0F
03 77700393     #       addi    t2, zero, 1911          # t2: 0x00000777
04 007372B3     #       and     t0, t1, t2              # t0: 0x00000707
05 007362B3     #       or      t0, t1, t2              # t0: 0xFFFFFF7F
06 006382B3     #       add     t0, t2, t1              # t0: 0x00000686 (overflow)
07 406382B3     #       sub     t0, t2, t1              # t0: 0xFFFFF798
08 007322B3     #       slt     t0, t1, t2              # t0: 0x00000001
09 0063A2B3     #       slt     t0, t2, t1              # t0: 0x00000000
10 00028663     #       beq     t0, zero, 12            # ! devia ir para PULA; não considera F0F < 777
11 EEE00293     #       addi    t0, zero, -274          # t0: 0xFFFFFEEE
12 00C0006F     #       jal     zero, 12                # ! devia pular para FIM
13 00C000EF     # PULA: jal     ra, 12                  # -> PROC
16 07F00293     # PROC: addi    t0, zero, 127           # t0: 0x0000007F
18 0001A283     #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F
20 00008067     #       jalr    zero, ra, 0             # -> PULA + 4
21 00000000     #                                       # ! pula para 
17 0051A223     #       sw      t0, 4(gp)               # 4(gp): 0x0000007F
18 0001A283     #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F
19 0041A283     #       lw      t0, 4(gp)               # t0: 0x0000007F
20 00008067     #       jalr    zero, ra, 0             # -> PULA + 4
21 00000000     #
17 0051A223     #       sw      t0, 4(gp)               # 4(gp): 0x0000007F
18 ... entrou em um loop nada a ver
```

Aparentemente, o `ret` atrasava 1 ciclo, e retornava para PROC + 4. Então,
possivelmente o `jalr` fazia ra = PC + imm + 4 (????)

Talvez o PC esteja sendo atualizado antes do próximo clock, atualizando para
PC + imm antes da subida de clock e gravando (PC + imm) + 4

Não sei se isso pode ter relação com a definição de entradas e saídas como
logic, ou se algo tava errado já e não ajeitei

