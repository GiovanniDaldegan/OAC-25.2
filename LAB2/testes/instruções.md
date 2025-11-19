instruções obtidas na simulação funcional do processador uniciclo e o seu
disassembly de acordo com o ISCTools
<https://isc-tools.vercel.app/disassembler>


### 00 - Programa de1.s montado
Concide com o resultado do TopDE.vwf no envio do LAB2 pelo aprender3, ou seja,
sem pulos condicionais ou incondicionais, apenas PC + 4

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
10 00028663     #       beq     t0, zero, 12            # tomado, -> PULA
11 EEE00293     #       addi    t0, zero, -274          # t0: 0xFFFFFEEE
12 00C0006F     #       jal     zero, 12                # 
13 00C000EF     # PULA: jal     ra, 12                  # -> PROC
14 CCC00293     #       addi    t0, zero, -820          # t0: 0xFFFFFCCC
15 0000006F     # FIM:  jal     zero, 0                 #
16 07F00293     # PROC: addi    t0, zero, 127           # t0: 0x0000007F
17 0051A223     #       sw      t0, 4(gp)               # 4(gp): 0x0000007F
18 0001A283     #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F
19 0041A283     #       lw      t0, 4(gp)               # t0: 0x0000007F
20 00008067     #       jalr    zero, ra, 0             # -> PULA + 4
21 00000000     #       Error: Opcode desconhecido (00000000)
```

### 01 - Sequência de instruções esperada
Execução pelo RARS

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
10 00028663     #       beq     t0, zero, 12            # tomado, -> PULA
13 00C000EF     # PULA: jal     ra, 12                  # -> PROC
16 07F00293     # PROC: addi    t0, zero, 127           # t0: 0x0000007F
17 0051A223     #       sw      t0, 4(gp)               # 4(gp): 0x0000007F
18 0001A283     #       lw      t0, 0(gp)               # t0: 0xFFFFFF0F
19 0041A283     #       lw      t0, 4(gp)               # t0: 0x0000007F
20 00008067     #       jalr    zero, ra, 0             # -> PULA + 4
14 CCC00293     #       addi    t0, zero, -820          # t0: 0xFFFFFCCC
15 0000006F     # FIM:  jal     zero, 0                 #
15 ... loop infinito
```

### 02 - Waveform3.vwf (18/11 22h)
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
