instruções obtidas na simulação funcional do processador uniciclo e o seu
disassembly de acordo com o ISCTools
<https://isc-tools.vercel.app/disassembler>


## 1 Geral

### 1.1 Programa de1.s montado - Uniciclo, Multiciclo
Concide com o resultado do TopDE.vwf no envio do LAB2 pelo aprender3, ou seja,
sem pulos condicionais ou incondicionais, apenas PC + 4
02028063
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

### 1.2 Programa de1.s montado - Pipeline
```
nº endereço
00 00400000 100101B7    #       lui     gp, 0x10010             # gp: 0x10010000 (.data)
01 00400004 00000013    #       nop
02 00400008 00000013    #       nop
03 0040000C 00000013    #       nop
04 00400010 0001A303    # MAIN: lw      t1, 0(gp)               # t1: 0xFFFFFF0F
05 004000 77700393    #       addi    t2, zero, 1911          # t2: 0x00000777
06 00400004 00000013    #       nop
06 00400004 00000013    #       nop
06 00400004 00000013    #       nop
04 004000 007372B3    #       and     t0, t1, t2              # t0: 0x00000707
05 004000 007362B3    #       or      t0, t1, t2              # t0: 0xFFFFFF7F
06 004000 006382B3    #       add     t0, t2, t1              # t0: 0x00000686 (overflow)
07 004000 406382B3    #       sub     t0, t2, t1              # t0: 0xFFFFF798
08 004000 007322B3    #       slt     t0, t1, t2              # t0: 0x00000001
09 004000 0063A2B3    #       slt     t0, t2, t1              # t0: 0x00000000
06 00400004 00000013    #       nop
06 00400004 00000013    #       nop
06 00400004 00000013    #       nop
10 004000 00028663    #       beq     t0, zero, 12            # tomado, -> PULA
01 00400004 00000013    #       nop
11 004000 EEE00293    #       addi    t0, zero, -274          # t0: 0xFFFFFEEE
06 00400004 00000013    #       nop
06 00400004 00000013    #       nop
06 00400004 00000013    #       nop
12 004000 00C0006F    #       jal     zero, 12                # 
01 00400004 00000013    #       nop
13 004000 00C000EF    # PULA: jal     ra, 12                  # -> PROC
01 00400004 00000013    #       nop
14 004000 CCC00293    #       addi    t0, zero, -820          # t0: 0xFFFFFCCC
01 00400004 00000013    #       nop
01 00400004 00000013    #       nop
01 00400004 00000013    #       nop
15 004000 0000006F    # FIM:  jal     zero, 0                 #
16 004000 07F00293    # PROC: addi    t0, zero, 127           # t0: 0x0000007F
17 004000 0051A223    #       sw      t0, 4(gp)               # 4(gp): 0x0000007F
18 004000 0001A283    #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F
19 004000 0041A283    #       lw      t0, 4(gp)               # t0: 0x0000007F
20 004000 00008067    #       jalr    zero, ra, 0             # -> PULA + 4
21
22
23
24
25
26

```

### 1.2 imediatos das instruções
```
00 00400000 100101B7        # lui     gp, 0x10010       # imm: 10010000
01 00400004 00018193        # addi    gp, gp, 0         # imm: 00000000
02 00400008 0001A303        # lw      t1, 0(gp)         # imm: 00000000
03 0040000C 77700393        # addi    t2, zero, 1911    # imm: 00000777
10 00400028 00028663        # beq     t0, zero, 12      # imm: 0000000C
11 0040002C EEE00293        # addi    t0, zero, -274    # imm: FFFFFEEE
12 00400030 00C0006F        # jal     zero, 12          # imm: 0000000C
13 00400034 00C000EF        # jal     ra, 12            # imm: 0000000C
14 00400038 CCC00293        # addi    t0, zero, -820    # imm: FFFFFFCC
15 0040003C 0000006F        # jal     zero, 0           # imm: 00000000
16 00400040 07F00293        # addi    t0, zero, 127     # imm: 0000007F
17 00400044 0051A223        # sw      t0, 4(gp)         # imm: 00000004
18 00400048 0001A283        # lw      t0, 0(gp)         # imm: 00000000
19 0040004C 0041A283        # lw      t0, 4(gp)         # imm: 00000004
20 00400050 00008067        # jalr    zero, ra, 0       # imm: 00000000
```


### 1.3 Sequência de instruções esperada - Uniciclo, Multiciclo

```
nº endereço instr        # disassembly                           # regs
00 00400000 100101B7     #       lui     gp, 0x10010             # gp: 0x10010000 (.data)
01 00400004 00018193     #       addi    gp, gp, 0               #
02 00400008 0001A303     # MAIN: lw      t1, 0(gp)               # t1: 0xFFFFFF0F
03 0040000C 77700393     #       addi    t2, zero, 1911          # t2: 0x00000777
04 00400010 007372B3     #       and     t0, t1, t2              # t0: 0x00000707
05 00400014 007362B3     #       or      t0, t1, t2              # t0: 0xFFFFFF7F
06 00400018 006382B3     #       add     t0, t2, t1              # t0: 0x00000686 (overflow)
07 0040001C 406382B3     #       sub     t0, t2, t1              # t0: 0x00000868 (underflow)
08 00400020 007322B3     #       slt     t0, t1, t2              # t0: 0x00000001
09 00400024 0063A2B3     #       slt     t0, t2, t1              # t0: 0x00000000
10 00400028 00028663     #       beq     t0, zero, 12            # tomado, -> PULA
13 00400034 00C000EF     # PULA: jal     ra, 12                  # -> PROC
16 00400040 07F00293     # PROC: addi    t0, zero, 127           # t0: 0x0000007F
17 00400044 0051A223     #       sw      t0, 4(gp)               # 4(gp): 0x0000007F
18 00400048 0001A283     #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F
19 0040004C 0041A283     #       lw      t0, 4(gp)               # t0: 0x0000007F
20 00400050 00008067     #       jalr    zero, ra, 0             # -> PULA + 4 (ra)
14 00400038 CCC00293     #       addi    t0, zero, -820          # t0: 0xFFFFFCCC
15 0040003C 0000006F     # FIM:  jal     zero, 0                 #
15 0040003C ... loop infinito
```

### 1.3 Sequência de instruções esperada - Uniciclo, Multiciclo

```
nº endereço instr        # disassembly                           # regs
00 00400000 100101B7     #       lui     gp, 0x10010             # gp: 0x10010000 (.data)
01 
02 00400008 0001A303     # MAIN: lw      t1, 0(gp)               # t1: 0xFFFFFF0F
03 0040000C 77700393     #       addi    t2, zero, 1911          # t2: 0x00000777
04 00400010 007372B3     #       and     t0, t1, t2              # t0: 0x00000707
05 00400014 007362B3     #       or      t0, t1, t2              # t0: 0xFFFFFF7F
06 00400018 006382B3     #       add     t0, t2, t1              # t0: 0x00000686 (overflow)
07 0040001C 406382B3     #       sub     t0, t2, t1              # t0: 0x00000868 (underflow)
08 00400020 007322B3     #       slt     t0, t1, t2              # t0: 0x00000001
09 00400024 0063A2B3     #       slt     t0, t2, t1              # t0: 0x00000000
10 00400028 00028663     #       beq     t0, zero, 12            # tomado, -> PULA
13 00400034 00C000EF     # PULA: jal     ra, 12                  # -> PROC
16 00400040 07F00293     # PROC: addi    t0, zero, 127           # t0: 0x0000007F
17 00400044 0051A223     #       sw      t0, 4(gp)               # 4(gp): 0x0000007F
18 00400048 0001A283     #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F
19 0040004C 0041A283     #       lw      t0, 4(gp)               # t0: 0x0000007F
20 00400050 00008067     #       jalr    zero, ra, 0             # -> PULA + 4 (ra)
14 00400038 CCC00293     #       addi    t0, zero, -820          # t0: 0xFFFFFCCC
15 0040003C 0000006F     # FIM:  jal     zero, 0                 #
16
17
18 
19
 0040003C ... loop infinito
```

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

