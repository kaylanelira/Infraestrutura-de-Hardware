addi x9, x0, 13
# a (x10)
addi sp, sp, -36
jal x14, gets	
addi x10, x15, 0
sb x10, 24(sp)

# b (x11)
jal x14, gets
addi x11, x15, 0
sb x11, 16(sp)

# c (x12)
jal x14, gets
addi x12, x15, 0
sb x12, 8(sp)

# x (x13)
jal x14, gets
addi x13, x15, 0
sb x13, 0(sp)

# funcao p/ pegar numero
gets:
	lb x15, 1025(x0)
	# sb x15, 1024(x0)
	beq x15, x9, done
	jal x14, loop
done:
	jalr x0, 0(x1)
# x = 0
addi x13, x0, 0
# a >= 0
bge x10, x0, and_

# b <= 64 (0040)
and_:
	addi x14, x0, 0040
	bge x14, x11, and__
	jalr x0, 0(x1)
and__:
	addi x14, x0, 0017
	blt x14, x12, if
if:
	addi x13, x13, 1
halt

# ENUNCIADO DA QUESTAO
# Encontre a menor sequência de instruções RISC-V que implementa a código abaixo, onde a,b,c e x são variáveis na memória. 
# Teste um array de entrada com 15 sequencias diferentes de a, b e c, que deverão ser dadas pelo teclado. 
# Os resultados e as entradas deverão ser visualizadas no display.
# int a = ...; int b = ...; int c = ...; int x = ...;
# x = 0;
# if ( a >= 0 && b <= 64 && c > 23 ) x = 1;
