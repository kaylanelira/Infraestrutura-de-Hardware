addi x18, x0, 13 # enter
addi x9, x0, 1
addi x16, x0, 10	# auxilia dezena
addi x17, x0, 100	# auxilia centena
# declarando fat 8! e 9!
# 8! = 40320
addi x19, x0, 40320
# 9! = 362880
addi x20, x0, 362880 
# recebendo string do teclado (x11)
gets:
	lb x11, 1025(x0)	# recebe char
	addi x12, x11, -1 # x9 = num-1
	beq x11, x18, enter	# verifica se foi enter/fim da string
	
	addi x28, x0, 8
	beq x11, x28, soma8
	addi x28, x0, 9
	beq x11, x28,	soma9

	fat:
		jal x1, mul
		beq x12, x9, gets
		addi x11, x11, -1
		addi x12, x12, -1
		beq x0, x0, fat

	jal x1, gets

# multiplicando x12 e x11
# n = x11
# n-1 = x12
# const = x9
# resultado = x10

mul:
	addi x6, x11, 0
	addi x7, x12, 0
	beq x0, x6, voltar
	addi x6, x6, -1
	add x10, x10, x7
	beq x0, x0, mul
voltar: jalr x0, 0(x1)
soma8:
	addi x10, x10, x19
soma9:
	addi x10, x10, x20

# printando centena
dividC:
	blt x10, x17, printC
	# cada vez que for possível retirar 100 do num, adiciona 1 no reg que guarda as centenas (x20)
	addi x10, x10, -100
	addi x20, x20, 1
	jal x1, dividC

printC:
	addi x20, x20, 48	# converte centena (x20) de acordo com tabela ASCII
	sb x20, 1024(x0)	# printa centena
	jal x1, dividDU		# segue para calcular dezena e unidade

# printando dezena e unidade
dividDU:
	blt x10, x16, printDU
	# cada vez que for possível retirar 10 do num, adiciona 1 no reg que guarda as dezenas (x15)
	addi x10, x10, -10
	addi x15, x15, 1
	jal x1, dividDU

printDU: 
	addi x15, x15, 48	# converte dezena (x15) de acordo com tabela ASCII
	addi x10, x10, 48	# converte unidade (x14) de acordo com tabela ASCII
	sb x15, 1024(x0)	# printa dezena
	sb x10, 1024(x0)	# printa unidade
	sb x18, 1024(x0)	# printa enter (para organizacao)
	jal x0, enter

enter:
	jal x0, dividC
	halt
	# printando resultado
