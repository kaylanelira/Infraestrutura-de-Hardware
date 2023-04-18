addi x9, x0, 4	# indica quant de numeros na entrada

# pegando entrada
gets:
	slli x14, x14, 1
	lb x12, 1025(x0)
	addi x12, x12, -48
	add x14, x14, x12	# salvando num convertido em x14
	addi x13, x13, 1
	beq x9, x13, cmp	# verifica se foi 4 num na entrada
	jal x0, gets

# fazendo comparacoes com x15 aumentando
cmp:
	beq x14, x15, print0	# 0000 
	addi x15, x15, 1 
	beq x14, x15, print1	# 0001
	addi x15, x15, 1 
	beq x14, x15, print2	# 0010
	addi x15, x15, 1 
	beq x14, x15, print3	# 0011
	addi x15, x15, 1 
	beq x14, x15, print4	# 0100
	addi x15, x15, 1 
	beq x14, x15, print5	# 0101
	addi x15, x15, 1 
	beq x14, x15, print6	# 0110
	addi x15, x15, 1 
	beq x14, x15, print7	# 0111
	addi x15, x15, 1 
	beq x14, x15, print8	# 1000
	addi x15, x15, 1 
	beq x14, x15, print9	# 1001
	addi x15, x15, 6	# adiciona 6 pois 1111 = 15
	beq x14, x15, limpaDisplay

# funcoes de printar
print0:
	addi x10, x10, 0b0111111
	jal x0, printDisplay
print1:
	addi x10, x0, 0b000110
	jal x0, printDisplay
print2:
	addi x10, x0, 0b011011
	addi x16, x0, 0b1
	jal x0, printDisplay
print3:
	addi x10, x0, 0b001111
	addi x16, x0, 0b1
	jal x0, printDisplay
print4:
	addi x10, x0, 0b100110
	addi x16, x0, 0b1
	jal x0, printDisplay
print5:
	addi x10, x0, 0b101101
	addi x16, x0, 0b1
	jal x0, printDisplay
print6:
	addi x10, x0, 0b111101
	addi x16, x0, 0b1
	jal x0, printDisplay
print7:
	addi x10, x0, 0b000111
	jal x0, printDisplay
print8:
	addi x10, x0, 0b111111
	addi x16, x0, 0b1
	jal x0, printDisplay
print9:
	addi x10, x0, 0b101111
	addi x16, x0, 0b1
	jal x0, printDisplay
limpaDisplay:
	addi x10, x0, 0
	jal x0, printDisplay
	
printDisplay:
	sh x10, 1029(x0)
	sh x16, 1027(x0)
	halt
