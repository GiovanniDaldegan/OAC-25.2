.text
main:                           # mover main para o início
        lui     a0,%hi(v)       # substituir .LANCHORO por v
        addi    sp,sp,-16
        addi    a0,a0,%lo(v)    # substituir .LANCHORO por v
        li      a1,30
        sw      ra,12(sp)
        sw      s0,8(sp)
        call    show
        lui     s0,%hi(v)       # substituir .LANCHORO por v
        addi    a0,s0,%lo(v)    # substituir .LANCHORO por v
        li      a1,30
        call    sort
        addi    a0,s0,%lo(v)    # substituir .LANCHORO por v
        li      a1,30
        call    show
        lw      ra,12(sp)
        lw      s0,8(sp)
        li      a0,0
        addi    sp,sp,16
        li      a7,10
        ecall                   # syscall 10
show:
        mv      t0,a0
        mv      t1,a1
        mv      t2,zero
loop1:  beq     t2,t1,fim1
        li      a7,1
        lw      a0,0(t0)
        ecall
        li      a7,11
        li      a0,9
        ecall
        addi    t0,t0,4
        addi    t2,t2,1
        j       loop1
fim1:   li      a7,11
        li      a0,10
        ecall

        ret
swap:
        slli    a1,a1,2
        add     a5,a0,a1
        addi    a1,a1,4
        add     a0,a0,a1
        lw      a3,0(a0)
        lw      a4,0(a5)
        sw      a3,0(a5)
        sw      a4,0(a0)
        ret
sort:
        addi    sp,sp,-48
        sw      s1,36(sp)
        sw      s2,32(sp)
        sw      s3,28(sp)
        sw      ra,44(sp)
        sw      s0,40(sp)
        mv      s3,a1
        li      s1,0
        li      s2,-1
.L4:
        blt     s1,s3,.L9
        lw      ra,44(sp)
        lw      s0,40(sp)
        lw      s1,36(sp)
        lw      s2,32(sp)
        lw      s3,28(sp)
        addi    sp,sp,48
        jr      ra
.L9:
        slli    s0,s1,2
        addi    a1,s1,-1
        add     s0,a0,s0
.L5:
        bne     a1,s2,.L6
.L8:
        addi    s1,s1,1
        j       .L4
.L6:
        lw      a4,-4(s0)
        addi    s0,s0,-4
        lw      a5,4(s0)
        ble     a4,a5,.L8
        sw      a1,12(sp)
        sw      a0,8(sp)
        call    swap
        lw      a1,12(sp)
        lw      a0,8(sp)
        addi    a1,a1,-1
        j       .L5

        .set    .LANCHOR0,. + 0 # desconsiderado pelo RARS
.data
v:	.word   9, 2, 5, 1, 8, 2, 4, 3, 6, 7, 10, 2, 32, 54, 2, 12, 6, 3, 1, 78, 54, 23, 1, 54, 2, 65, 3, 6, 55, 31
	# resumir o vetor