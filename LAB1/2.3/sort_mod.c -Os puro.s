show(int*, int):
         mv     t0,a0 
         mv     t1,a1 
         mv     t2,zero 
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
swap(int*, int):
        slli    a1,a1,2
        add     a5,a0,a1
        addi    a1,a1,4
        add     a0,a0,a1
        lw      a3,0(a0)
        lw      a4,0(a5)
        sw      a3,0(a5)
        sw      a4,0(a0)
        ret
sort(int*, int):
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
        call    swap(int*, int)
        lw      a1,12(sp)
        lw      a0,8(sp)
        addi    a1,a1,-1
        j       .L5
main:
        lui     a0,%hi(.LANCHOR0)
        addi    sp,sp,-16
        addi    a0,a0,%lo(.LANCHOR0)
        li      a1,30
        sw      ra,12(sp)
        sw      s0,8(sp)
        call    show(int*, int)
        lui     s0,%hi(.LANCHOR0)
        addi    a0,s0,%lo(.LANCHOR0)
        li      a1,30
        call    sort(int*, int)
        addi    a0,s0,%lo(.LANCHOR0)
        li      a1,30
        call    show(int*, int)
        lw      ra,12(sp)
        lw      s0,8(sp)
        li      a0,0
        addi    sp,sp,16
        jr      ra
        .set    .LANCHOR0,. + 0
v:
        .word   9
        .word   2
        .word   5
        .word   1
        .word   8
        .word   2
        .word   4
        .word   3
        .word   6
        .word   7
        .word   10
        .word   2
        .word   32
        .word   54
        .word   2
        .word   12
        .word   6
        .word   3
        .word   1
        .word   78
        .word   54
        .word   23
        .word   1
        .word   54
        .word   2
        .word   65
        .word   3
        .word   6
        .word   55
        .word   31