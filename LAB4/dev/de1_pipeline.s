.eqv N 30

.data
.word 0xFFFFFF0F

.text
        lui     gp, 0x10010   # descomentar para rodar no Rars ou no Pipeline
        #li      gp, 0x10010000
        nop
        nop
        nop
MAIN:	lw      t1, 0(gp)		# gp: 0x1001_0000
        addi    t2, zero, 0x777
        nop
        nop
        nop				# t1: 0xFFFFFF0F
        and     t0, t1, t2		# t2: 0x00000777
        or      t0, t1, t2
        add     t0, t2, t1
        sub     t0, t2, t1
        slt     t0, t1, t2		# t0: 0x00000707 t1 and t2
        slt     t0, t2, t1		# t0: 0xFFFFFF7F
        nop				# t0: 0x00000686
        nop				# t0: 0xFFFFF798
        nop				# t0: 0x00000001
        beq     t0, zero, PULA		# t0: 0x00000000
        nop				# -> PULA
        addi    t0, zero, 0xFFFFFEEE
        nop
        nop
        nop
        j       FIM
        nop
PULA:	jal     PROC
        nop				# -> PROC
        addi    t0, zero, 0xFFFFFCCC
        nop
        nop
        nop
FIM:	j       FIM			# t0: 0xFFFFFCCC
        nop				# -> FIM
        
PROC:	addi    t0, t0, 127
        nop
        nop
        nop
        sw      t0, 4(gp)		# t0: 0x0000007F
        lw      t0, 0(gp)		# sw 0x0000007F 4(gp)
        lw      t0, 4(gp)
	nop
	nop
	nop				# t0: 0xFFFFFF0F
        ret				# t0: 0x0000007F
        nop
        nop				# total de 27 nops, apenas 23 deve ser executadas até a primeira execução de j FIM
