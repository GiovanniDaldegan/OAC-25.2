########################################
# Programa p/ cálculo da DFT aproximada
# de um vetor X de tamanho N
########################################

.data

# 3.4 - descomente esse trecho e o primeiro trecho na main e comente os demais vetores
#N: .word 8
#X: .float 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
#X1: .float 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X2: .float 1.0, 0.7071, 0.0, -0.7071, -1.0, -0.7071, 0.0, 0.7071
#X3: .float 0.0, 0.7071, 1.0, 0.7071, 0.0, -0.7071, -1.0, -0.7071
#X4: .float 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# 3.5 - descomente um item por vez e comente os demais
# a)
N: .word 8
X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0
X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# b)
#N: .word 12
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# c)
#N: .word 16
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# d)
#N: .word 20
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# e)
#N: .word 24
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# f)
#N: .word 28
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# g)
#N: .word 32
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# h)
#N: .word 36
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# i)
#N: .word 40
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

# j)
#N: .word 44
#X: .float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_real: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#X_imag: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0



# constantes num ricas utilizadas

oitoFatorial: .float 40320.0
dezFatorial: .float 3628800.0
dozeFatorial: .float 479001600.0
quatorzeFatorial: .float 87178291200.0
dezeseisFatorial: .float 20922789888000.0
dezoitoFatorial: .float 6402373705728000.0
vinteFatorial: .float 2432902008176640000.0
vintedoisFatorial: .float 1124000727777607680000.0
vintequatroFatorial: .float 620448401733239439360000.0
vinteseisFatorial: .float 403291461126605635584000000.0
vinteoitoFatorial: .float 304888344611713860501504000000.0
trintaFatorial: .float 265252859812191058636308480000000.0
trintadoisFatorial: .float 263130836933693530167218012160000000.0

seteFatorial: .float 5040.0
noveFatorial: .float 362880.0
onzeFatorial: .float 39916800.0
trezeFatorial: .float 6227020800.0
quinzeFatorial: .float 1307674368000.0
dezeseteFatorial: .float 355687428096000.0
dezenoveFatorial: .float 121645100408832000.0
vinteumFatorial: .float 51090942171709440000.0
vintetresFatorial: .float 25852016738884976640000.0
vintecincoFatorial: .float 15511210043330985984000000.0
vinteseteFatorial: .float 10888869450418352160768000000.0
vintenoveFatorial: .float 8841761993739701954543616000000.0
trintaumFatorial: .float 8222838654177922817725562880000000.0
trintatresFatorial: .float 8683317618811886495518194401280000000.0

pi: .float 3.1415926535

s: .word 0, 0, 0, 0, 0, 0, 0, 0
fs: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

RA: .word 0

# strings utilizadas

mais: .string "+"

menos: .string "-"

imaginario: .string "i"

barraN: .string "\n"

xn: .string "x[n]"

Xk: .string "X[k]"

tab: .string "\t"


.text

main:

	# trecho - descomentar para 3.4
	#la a0,X1
	#la a1,X_real
	#la a2,X_imag
	#la t0,N
	#lw a3,0(t0)
	
	#jal DFT
	
	#la a0,barraN
	#li a7,4
	#ecall
	
	#la a0,X2
	#la a1,X_real
	#la a2,X_imag
	#la t0,N
	#lw a3,0(t0)
	
	#jal DFT
	
	#la a0,barraN
	#li a7,4
	#ecall
	
	#la a0,X3
	#la a1,X_real
	#la a2,X_imag
	#la t0,N
	#lw a3,0(t0)
	
	#jal DFT
	
	#la a0,barraN
	#li a7,4
	#ecall
	
	#la a0,X4
	#la a1,X_real
	#la a2,X_imag
	#la t0,N
	#lw a3,0(t0)
	
	#jal DFT
	
	#la a0,barraN
	#li a7,4
	#ecall

	# fim do trecho


	# trecho - descomentar para 3.5
	la a0,X
	la a1,X_real
	la a2,X_imag
	la t0,N
	lw a3,0(t0)
	
	csrr	s11, 3074	# instr
	csrr	s10, 3073	# tempo em ms

	jal DFT

	csrr	t5, 3073
	csrr	t6, 3074

	sub	s10, t5, s10	# s10: tempo total de CPU em ms
	sub	s11, t6, s11
	addi	s11, s11, -3	# s11: contagem total de instru  es

	# fim do trecho

	li a7,10
	ecall


DFT:
	# a0: vetor X
	# a1: vetor X_real
	# a2: vetor X_imag
	# a3: N

	mv s8,a0

	la t0,RA
	sw ra, 0(t0)
	
	li t0,2
	fcvt.s.w ft0,t0
	
	la t0,pi
	flw ft1,0(t0)
	
	# fs0 = 2pi
	fmul.s fs0,ft0,ft1
	
	# fs1 = N (4)
	fcvt.s.w fs1,a3
	
	# m = s5
	li s5,0
	
	
while_externo:


	# k = N?
	beq s5,a3,fora_externo
	
	fcvt.s.w fs5,s5
	
	# s4 = n
	li s4,0
	
	li t0,0
	fcvt.s.w fs3,t0
	fcvt.s.w fs7,t0
	
	
while_interno:

	
	#n = N?
	beq s4,a3,fora_interno
	
	fcvt.s.w fs4,s4
	
	fmul.s fa0,fs0,fs5
	fmul.s fa0,fa0,fs4
	fdiv.s fa0,fa0,fs1	
	
	call sincos
	
	slli t1,s4,2
	add t0,s8,t1
	flw fs2,0(t0)
	
	fmul.s fa0,fa0,fs2
	fmul.s fa1,fa1,fs2
	
	li t0,-1
	fcvt.s.w ft0,t0
	
	fmul.s fa1,fa1,ft0
	
	li a7,2
	#ecall
	
	la a0,barraN
	li a7,4
	#ecall
	
	fadd.s fs3,fs3,fa0
	fadd.s fs7,fs7,fa1
	
	addi s4,s4,1
	
	j while_interno
	

fora_interno:

	slli t1,s5,2
	add t0,a1,t1
	fsw fs3,0(t0)
	
	add t0,a2,t1
	fsw fs7,0(t0)
	
	fmv.s fa0,fs3
	li a7,2
	#ecall
	
	la a0,barraN
	li a7,4
	#ecall
	
	addi s5,s5,1
	
	j while_externo
	
	
fora_externo:

	la a0,xn
	li a7,4
	ecall
	
	la a0,tab
	li a7,4
	ecall

	la a0,Xk
	li a7,4
	ecall
	
	la a0,barraN
	li a7,4
	ecall

	li s6,0

loop_impressao:

	beq s6,a3,return
	
	slli t1,s6,2
	add t0,s8,t1
	flw fa0,0(t0)
	li a7,2
	ecall
	
	la a0,tab
	li a7,4
	ecall
	
	slli t1,s6,2
	add t0,a1,t1
	flw fs3,0(t0)
	
	add t0,a2,t1
	flw fs7,0(t0)
	
	fmv.s fa0,fs3
	li a7,2
	ecall

	
	li t0,0
	fcvt.s.w ft0,t0
	
	flt.s t1,fs7,ft0
	
	bne t1,t0,negativo

positivo:
	
	la a0,mais
	li a7,4
	ecall
	
	j fim
	
	
negativo:

	li t1,-1
	fcvt.s.w ft1,t1	
	
	fmul.s fs7,fs7,ft1
	
	la a0,menos
	li a7,4
	ecall
	
fim:		
	
	
	fmv.s fa0,fs7
	li a7,2
	ecall
	
	la a0,imaginario
	li a7,4
	ecall
	
	la a0,barraN
	li a7,4
	ecall

	addi s6,s6,1
	
	j loop_impressao
	
return:

	la t0,RA
	lw ra, 0(t0)
	
	ret


	
# Serie de taylor do cosseno: 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1124000727777607680000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/620448401733239439360000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/403291461126605635584000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/304888344611713860501504000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/265252859812191058636308480000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/263130836933693530167218012160000000
	
# Serie de taylor do seno: x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000 - *x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/25852016738884976640000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*X/15511210043330985984000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/10888869450418352160768000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8841761993739701954543616000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8222838654177922817725562880000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8683317618811886495518194401280000000

sincos:
	# fa0: resto de theta / pi

	# A S rie de Taylor   boa para calcular o valor de seno/cosseno perto do 0, mas ruim para valores distantes
	# Para ter precis o, o valor do angulo vai ser ajustado para ficar entre -pi e pi
	# Se o angulo for positivo, vai ser subtraido 2pi at  o valor ficar dentro do intervalo
	# Se o angulo for negativo, vai ser somado 2pi at  o valor ficar dentro do intervalo
	# sen(-2pi) = sen(0) = sen(2pi) 
	# cos(-2pi) = cos(0) = cos(2pi)

	li s9,0
	fcvt.s.w fs8,s9


	# se fa0 < fs8, t0 = 1, ct, t0 = 0
	# fs8 = 0
	flt.s t0,fa0,fs8
	
	beq t0,s9,angulo_positivo


angulo_negativo:

	li t0,-1
	fcvt.s.w ft2,t0
	la t1,pi
	flw ft3, 0(t1)
	fmul.s ft2,ft2,ft3
	
	li t1,1
	
loop_negativo:

	fgt.s t0,fa0,ft2
	
	beq t0,t1,fim_angulo
	
	fadd.s fa0,fa0,ft3
	fadd.s fa0,fa0,ft3
	
	j loop_negativo
	
				
angulo_positivo:

	la t1,pi
	flw ft3, 0(t1)
	
	li t1,1
	
loop_positivo:

	flt.s t0,fa0,ft3
	
	beq t0,t1,fim_angulo
	
	fsub.s fa0,fa0,ft3
	fsub.s fa0,fa0,ft3
	
	j loop_positivo
	
fim_angulo:	

	# O valor de x est  em fa0
	# O registrador ft0 sera usado para guardar o resultado parcial do calculo do seno/cosseno
	# O registrador ft1 sera usado para guardar valores de constantes 
	# O registrador ft2 sera usado para guardar o valor das potencias de x
	# O registrador ft3 sera usado para guardar resultados dos termos da serie de taylor

# Seno	

	# ft2 = x*x*x
	fmul.s ft0,fa0,fa0
	fmul.s ft2,ft0,fa0
	
	# ft1 = 6
	li t0,6
	fcvt.s.w ft1,t0
	
	# ft0 = x*x*x/6
	fdiv.s ft0,ft2,ft1
	
	# ft0 = x - x*x*x/6 
	fsub.s ft0,fa0,ft0
	
	
	# ft2 = x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 120
	li t0,120
	fcvt.s.w ft1,t0
	
	# ft3 = x*x*x*x*x/120
	fdiv.s ft3,ft2,ft1
	
	#ft0 = x - x*x*x/6 + x*x*x*x*x/120
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 5040
	la t0,seteFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x/5040
	fdiv.s ft3,ft2,ft1
	
	#ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 362880
	la t0,noveFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x/362880
	fdiv.s ft3,ft2,ft1
	
	#ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 39916800
	la t0,onzeFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x/39916800
	fdiv.s ft3,ft2,ft1
	
	#ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 6227020800
	la t0,trezeFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800
	fdiv.s ft3,ft2,ft1
	
	#ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 1307674368000
	la t0,quinzeFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000
	fdiv.s ft3,ft2,ft1
	
	#ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 355687428096000
	la t0,dezeseteFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000
	fdiv.s ft3,ft2,ft1
	
	#ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 121645100408832000
	la t0,dezenoveFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 51090942171709440000
	la t0,vinteumFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000
	fadd.s ft0,ft0,ft3
	
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 25852016738884976640000
	la t0,vintetresFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/25852016738884976640000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000 - *x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/25852016738884976640000
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 15511210043330985984000000
	la t0,vintecincoFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/15511210043330985984000000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000 - *x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/25852016738884976640000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*X/15511210043330985984000000
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 10888869450418352160768000000
	la t0,vinteseteFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/10888869450418352160768000000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000 - *x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/25852016738884976640000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*X/15511210043330985984000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/10888869450418352160768000000
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 8841761993739701954543616000000
	la t0,vintenoveFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8841761993739701954543616000000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000 - *x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/25852016738884976640000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*X/15511210043330985984000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/10888869450418352160768000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8841761993739701954543616000000
	fadd.s ft0,ft0,ft3
	
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 8222838654177922817725562880000000
	la t0,trintaumFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8222838654177922817725562880000000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000 - *x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/25852016738884976640000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*X/15511210043330985984000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/10888869450418352160768000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8841761993739701954543616000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8222838654177922817725562880000000
	fsub.s ft0,ft0,ft3


	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 8683317618811886495518194401280000000
	la t0,trintatresFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8683317618811886495518194401280000000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = x - x*x*x/6 + x*x*x*x*x/120 - x*x*x*x*x/5040 + x*x*x*x*x*x*x*x*x/362880 - x*x*x*x*x*x*x*x*x*x*x/39916800 + x*x*x*x*x*x*x*x*x*x*x*x*x/6227020800 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1307674368000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/355687428096000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/121645100408832000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/51090942171709440000 - *x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/25852016738884976640000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*X/15511210043330985984000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/10888869450418352160768000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8841761993739701954543616000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8222838654177922817725562880000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/8683317618811886495518194401280000000
	fadd.s fa1,ft0,ft3


# Cosseno 

	# ft0 = 1
	li t0,1
	fcvt.s.w ft0,t0
	
	# ft2 = x*x
	fmul.s ft2,fa0,fa0
	
	# ft1 = 2
	li t0,2
	fcvt.s.w ft1,t0
	
	# ft3 = x*x/2
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 
	fsub.s ft0,ft0,ft3
	

	# ft2 = x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 24
	li t0,24
	fcvt.s.w ft1,t0
	
	# ft3 = x*x*x*x/24
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 720
	li t0,720
	fcvt.s.w ft1,t0
	
	# ft3 = x*x*x*x*x*x/720
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720
	fsub.s ft0,ft0,ft3	
	
	
	# ft2 = x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 40320
	la t0,oitoFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x/40320
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 3628800
	la t0,dezFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x/3628800
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 479001600
	la t0,dozeFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x/479001600
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 87178291200
	la t0,quatorzeFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 20922789888000
	la t0,dezeseisFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 6402373705728000
	la t0,dezoitoFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 2432902008176640000
	la t0,vinteFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 1124000727777607680000
	la t0,vintedoisFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1124000727777607680000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1124000727777607680000
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 620448401733239439360000
	la t0,vintequatroFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/620448401733239439360000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1124000727777607680000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/620448401733239439360000
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 403291461126605635584000000
	la t0,vinteseisFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/403291461126605635584000000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1124000727777607680000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/620448401733239439360000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/403291461126605635584000000
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 304888344611713860501504000000
	la t0,vinteoitoFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/304888344611713860501504000000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1124000727777607680000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/620448401733239439360000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/403291461126605635584000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/304888344611713860501504000000
	fadd.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 265252859812191058636308480000000
	la t0,trintaFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/265252859812191058636308480000000
	fdiv.s ft3,ft2,ft1
	
	# ft0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1124000727777607680000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/620448401733239439360000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/403291461126605635584000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/304888344611713860501504000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/265252859812191058636308480000000
	fsub.s ft0,ft0,ft3
	
	
	# ft2 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x
	fmul.s ft2,ft2,fa0
	fmul.s ft2,ft2,fa0
	
	# ft1 = 263130836933693530167218012160000000
	la t0,trintadoisFatorial
	flw ft1,0(t0)
	
	# ft3 = x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/263130836933693530167218012160000000
	fdiv.s ft3,ft2,ft1
	
	# fa0 = 1 - x*x/2 + x*x*x*x/24 - x*x*x*x*x*x/720 + x*x*x*x*x*x*x*x/40320 - x*x*x*x*x*x*x*x*x*x/3628800 + x*x*x*x*x*x*x*x*x*x*x*x/479001600 - x*x*x*x*x*x*x*x*x*x*x*x*x*x/87178291200 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/20922789888000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/6402373705728000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/2432902008176640000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/1124000727777607680000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/620448401733239439360000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/403291461126605635584000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/304888344611713860501504000000 - x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/265252859812191058636308480000000 + x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x/263130836933693530167218012160000000
	fadd.s fa0,ft0,ft3
	
	ret
