Um outro aluno resolveu testar suas habilidades matemáticas fazendo fatoriais.
Para dificultar o treino ele resolveu somar os valores do fatorial de cada dígito de um
número. Escreva um código em Assembly do RISC-V que simule o raciocínio desse
aluno recebendo um número de até 6 dígitos e devolvendo a soma dos fatoriais.
Ex 1.: Entrada => 1234
Saída => 33 (1! + 2! + 3! + 4! = 33)
Ex 2.: Entrada => 678
Saída => 46080 (6! + 7! + 8! = 46080)

addi x5, x0, 1
addi x6, x0, 48
addi x7, x0, 10		# auxilia dezena
addi x8, x0, 100 	# auxilia centena
addi x16, x0, 1000	# auxilia milhar
lw x17, dezmil		# auxilia dezena de milhar
lw x18, cemmil		# auxilia centena de milhar
addi x9, x0, 13		# enter

# leitura do teclado n em x11
gets:
	lb x11, 1025(x0)
	beq x11, x9, enter
	sub x11, x11, x6	# transformando em int
# se x11 == 1 -> 1!
beq x11, x5, fat1
# salvando n em x12 para fazer calculo da multiplicacao
add x12, x0, x11
# salvando n em x13
add x13, x0, x11
# x11 = n-1
sub x11, x11, x5
	
# Calculando fatorial
fat:
	beq x11, x5, endFat	# se chegar no 1, acaba fatorial
	
loopFat:
	beq x12, x5, endLoopFat
	add x14, x14, x13	# fazendo a multiplicacao por meio de soma
	sub x12, x12, x5	# decrementa x12(n)
	jal x0, loopFat

endLoopFat:
	add x13, x0, x14 	# coloca x14 em x13
	sub x11, x11, x5 	# decrementa n lido pelo teclado para voltar para fatorial
	add x12, x0, x11	# salvando n-1 em x12
	jal x0, fat

endFat:
	add x21, x21, x13	# fazendo soma dos fatoriais lidos pelo teclado e salvando em x21
	# limpando registradores para reutilizar
	add x13, x0, x0
	add x14, x0, x0

	jal x0, gets

# fazendo fatorial de 1
fat1:
	add x13, x0, x5
	jal x0, endFat

# Se for enter imprime o resultado
enter:
	jal x1, divid100000

divid100000:
	blt x21, x18, print100000
	# cada vez que for possível retirar 100000 do num, adiciona 1 no reg (x22)
	sub x21, x21, x18
	add x22, x22, x5
	jal x1, divid100000

print100000:
	add x22, x22, x6 	# convertendo para printar
	sb x22, 1024(x0)	# # printa centena de milhar
	jal x1, divid10000

divid10000:
	blt x21, x17, print10000
	# cada vez que for possível retirar 10000 do num, adiciona 1 no reg (x22)
	sub x21, x21, x17
	add x23, x23, x5
	jal x1, divid10000

print10000:
	add x23, x23, x6 	# convertendo para printar
	sb x23, 1024(x0)	# printa dezena de milhar
	jal x1, divid1000

divid1000:
	blt x21, x16, print1000
	# cada vez que for possível retirar 1000 do num, adiciona 1 no reg (x22)
	sub x21, x21, x16
	add x24, x24, x5
	jal x1, divid1000

print1000:
	add x24, x24, x6 	# convertendo para printar
	sb x24, 1024(x0)	# printa milhar
	jal x1, divid100

divid100:
	blt x21, x8, print100
	# cada vez que for possível retirar 100 do num, adiciona 1 no reg que guarda as centenas (x20)
	sub x21, x21, x8
	add x25, x25, x5
	jal x1, divid100

print100:
	add x25, x25, x6	# converte centena (x20) de acordo com tabela ASCII
	sb x25, 1024(x0)	# printa centena
	jal x1, divid10		# segue para calcular dezena e unidade

# printando dezena e unidade
divid10:
	blt x21, x7, print10
	# cada vez que for possível retirar 10 do num, adiciona 1 no reg que guarda as dezenas (x15)
	sub x21, x21, x7
	add x26, x26, x5
	jal x1, divid10

print10: 
	add x26, x26, x6	# converte dezena (x15) de acordo com tabela ASCII
	add x21, x21, x6	# converte unidade (x14) de acordo com tabela ASCII
	sb x26, 1024(x0)	# printa dezena
	sb x21, 1024(x0)	# printa unidade
	sb x9, 1024(x0)		# printa enter (para organizacao)
halt

dezmil: .word 10000
cemmil: .word 100000
