.text
main:                           # mover main para o início
        addi    sp,sp,-16
        lui     a0,%hi(v)       # substituir .LANCHOR0 por v
        sw      s0,8(sp)
        sw      ra,12(sp)
        addi    a0,a0,%lo(v)    # substituir .LANCHOR0 por v
        li      s0,30
        mv      t0,a0
        mv      t1,s0
        mv      t2,zero
loop1:  beq     t2,t1,fim1    # indexar labels loop1 e fim1
        li      a7,1
        lw      a0,0(t0)
        ecall
        li      a7,11
        li      a0,9
        ecall
        addi    t0,t0,4
        addi    t2,t2,1
        j       loop1         # indexar label loop1
fim1:   li      a7,11           # indexar label fim1
        li      a0,10
        ecall

        lui     a4,%hi(v)       # (nova linha)
        addi    a0,a4,%lo(v)    # passar a0 como endereço de v (nova linha)
        mv      a1,s0
        call    sort
        lui     a4,%hi(v)       # substituir .LANCHOR0 por v
        addi    a0,a4,%lo(v)    # substituir .LANCHOR0 por v
        mv      t0,a0
        mv      t1,s0
        mv      t2,zero
loop2:  beq     t2,t1,fim2    # indexar labels loop1 e fim1
        li      a7,1
        lw      a0,0(t0)
        ecall
        li      a7,11
        li      a0,9
        ecall
        addi    t0,t0,4
        addi    t2,t2,1
        j       loop2
fim2:   li      a7,11           # indexar label fim1
        li      a0,10
        ecall

        lw      ra,12(sp)
        lw      s0,8(sp)
        li      a0,0
        addi    sp,sp,16
	li	a7,10
	ecall                   # syscall 10
show:
        mv      t0,a0
        mv      t1,a1
        mv      t2,zero
loop3:  beq     t2,t1,fim3    # indexar labels loop1 e fim1
        li      a7,1
        lw      a0,0(t0)
        ecall
        li      a7,11
        li      a0,9
        ecall
        addi    t0,t0,4
        addi    t2,t2,1
        j       loop3         # indexar label loop1
fim3:   li      a7,11           # indexar label fim1
        li      a0,10
        ecall

        ret
swap:
        slli    a1,a1,2
        add     a0,a0,a1
        lw      a4,0(a0)
        lw      a5,4(a0)
        sw      a4,4(a0)
        sw      a5,0(a0)
        ret
sort:
        ble     a1,zero,.L4
        li      a6,-1
        add     a7,a1,a6
        mv      a1,a6
.L7:
        mv      a4,a6
        mv      a5,a0
        bne     a6,a1,.L6
        j       .L8
.L9:
        sw      a3,-4(a5)
        sw      a2,0(a5)
        addi    a5,a5,-4
        beq     a4,a1,.L8
.L6:
        lw      a2,-4(a5)
        lw      a3,0(a5)
        addi    a4,a4,-1
        bgt     a2,a3,.L9
.L8:
        addi    a6,a6,1
        addi    a0,a0,4
        bne     a7,a6,.L7
        ret
.L4:
        ret

        .set    .LANCHOR0,. + 0 # desconsiderado no RARS
.data
v:
        .word   9, 2, 5, 1, 8, 2, 4, 3, 6, 7, 10, 2, 32, 54, 2, 12, 6, 3, 1, 78, 54, 23, 1, 54, 2, 65, 3, 6, 55, 31
