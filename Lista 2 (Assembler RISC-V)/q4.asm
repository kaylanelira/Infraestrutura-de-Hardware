addi x6, x0, 10	# auxilia dezena
addi x7, x0, 100	# auxilia centena
# enter
addi x10, x0, 13
# contador
addi x9, x0, 0
# salvando regs com aeiouAEIOU (nessa ordem)
addi x13, x0, 97
addi x14, x0, 101
addi x15, x0, 105
addi x16, x0, 111
addi x17, x0, 117
addi x19, x0, 65
addi x20, x0, 69
addi x21, x0, 73
addi x22, x0, 79
addi x23, x0, 85

# recebe a string do teclado
# a string acaba quando chega no enter
gets:
	lb x11, 1025(x0)
	beq x11, x10, end
	jal x12, comp

# comparando com as vogais e incrementando x9 se encontrar
comp:
	beq x11, x13, incCount
	beq x11, x14, incCount
	beq x11, x15, incCount 
	beq x11, x16, incCount
	beq x11, x17, incCount
	beq x11, x19, incCount
	beq x11, x20, incCount
	beq x11, x21, incCount
	beq x11, x22, incCount
	beq x11, x23, incCount
	jal x12, gets

incCount:
	addi x9, x9, 1
	jal x12, gets

# fim da string -> printa quantidade de vogais
end:
	jal x0, dividC # printa numero

# printando centena
dividC:
	blt x9, x7, printC
	# cada vez que for possível retirar 100 do num, adiciona 1 no reg que guarda as centenas (x20)
	addi x9, x9, -100
	addi x24, x24, 1
	jal x1, dividC

printC:
	addi x24, x24, 48	# converte centena (x20) de acordo com tabela ASCII
	sb x24, 1024(x0)	# printa centena
	jal x1, dividDU		# segue para calcular dezena e unidade

# printando dezena e unidade
dividDU:
	blt x9, x6, printDU
	# cada vez que for possível retirar 10 do num, adiciona 1 no reg que guarda as dezenas (x15)
	addi x9, x9, -10
	addi x25, x25, 1
	jal x1, dividDU

printDU: 
	addi x25, x25, 48	# converte dezena (x15) de acordo com tabela ASCII
	addi x9, x9, 48	# converte unidade (x14) de acordo com tabela ASCII
	sb x25, 1024(x0)	# printa dezena
	sb x9, 1024(x0)	# printa unidade
	sb x10, 1024(x0)	# printa enter (para organizacao)
	halt
