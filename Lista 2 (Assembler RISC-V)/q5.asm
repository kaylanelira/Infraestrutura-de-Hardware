Um estudante de graduação resolveu criar um jogo e pediu a sua ajuda! O jogo,
que é em dupla, começa quando os jogadores 1 e 2 enviam uma palavra (string) cada
um pelo teclado. Após enviar, esperam o cálculo de sua pontuação que é mostrado
no visor. Além disso o visor deve informar o jogador que ganhou ou se houve empate.
A pontuação de cada jogador é calculada baseada na soma dos valores referentes as
letras da tabela abaixo:

Letras 				Valor
A, E, I, O, U 		  1
D, G, T 			  2
B, C, M, N, P 		  3
F, H, V, W, Y 		  4
K, R, S 			  5
J, L, X 			  8
Q, Z 				 10

Exemplo:
A pontuação da palavra "GOTICO" é 10, pois:
- 2 pontos para G
- 1 ponto para O, duas vezes
- 2 pontos para T
- 1 ponto para I
- 3 pontos para C
Obs: O jogo só aceitará letras maiúsculas.
Obs2: Acentuação será desconsiderada (não serão enviadas palavras com
acentuação ou cedilha).

addi x10, x0, 13 	# enter
addi x21, x0, 1		# indica qual string foi digitada (vai ser decrementada)
addi x16, x0, 10	# auxilia dezena
addi x17, x0, 100	# auxilia centena

# limpando regs antes de nova string
clear:	
	addi x14, x0, 0
	addi x15, x0, 0
	addi x20, x0, 0
	
# recebe a nova string 
gets:
	addi x1, x0, 0x001c	# endereco de gets em x1 para retorno futuro
	lb x11, 1025(x0)	# recebe char
	beq x11, x10, enter	# verifica se foi enter/fim da string
	addi x12, x0, 0x015c	# x12 aponta 1a letra da string "letrasJogo"
	addi x13, x0, 0 	# contador
	
	iterar_string:
		lb x5, 0(x12)
		beq x5, x11, cmp
		addi x12, x12, 1	# x12 vai passando de char em char em "letrasJogo"
		addi x13, x13, 1 	# verifica em qual parte da string está (0-25)
		bne x5, x0, iterar_string	# verifica se chegou ao final de "letrasJogo"
		
	jal x1, gets

# fazendo comparacoes com a letra que coincidiu com a da string (indicada por x13) utilizando x6 para verificar intervalo para calcular pontuacao
cmp:
	addi x6, x0, 5		# esta entre A, E, I, O, U
	blt x13, x6, ad1	
	addi x6, x0, 8		# esta entre D, G, T
	blt x13, x6, ad2
	addi x6, x0, 13		# esta entre B, C, M, N, P
	blt x13, x6, ad3
	addi x6, x0, 18		# esta entre F, H, V, W, Y
	blt x13, x6, ad4
	addi x6, x0, 21		# esta entre K, R, S
	blt x13, x6, ad5
	addi x6, x0, 24		# esta entre J, L, X
	blt x13, x6, ad8
	addi x6, x0, 27		# esta entre Q, Z
	blt x13, x6, ad10
	
	jal x0, gets		# volta para receber outro char

# calculando pontuacao em x14
ad1:
	addi x14, x14, 1
	jalr x0, 0(x1)
ad2:
	addi x14, x14, 2
	jalr x0, 0(x1)
ad3:
	addi x14, x14, 3
	jalr x0, 0(x1)
ad4:
	addi x14, x14, 4
	jalr x0, 0(x1)
ad5:
	addi x14, x14, 5
	jalr x0, 0(x1)
ad8:
	addi x14, x14, 8
	jalr x0, 0(x1)
ad10:
	addi x14, x14, 10
	jalr x0, 0(x1)

enter: 
	blt x0, x21, salvarJ1	# se x21 = 1 -> string do jogador 1
	# se nao for jogador 1, salvando pontuacao do jogador 2 em x31
	add x31, x14, x0
	jal x1, dividC

salvarJ1:
	add x30, x14, x0 	# salvando pontuacao do jogador 1 em x30
	jal x1, dividC
	

# printando centena
dividC:
	blt x14, x17, printC
	# cada vez que for possível retirar 100 do num, adiciona 1 no reg que guarda as centenas (x20)
	addi x14, x14, -100
	addi x20, x20, 1
	jal x1, dividC

printC:
	addi x20, x20, 48	# converte centena (x20) de acordo com tabela ASCII
	sb x20, 1024(x0)	# printa centena
	jal x1, dividDU		# segue para calcular dezena e unidade

# printando dezena e unidade
dividDU:
	blt x14, x16, printDU
	# cada vez que for possível retirar 10 do num, adiciona 1 no reg que guarda as dezenas (x15)
	addi x14, x14, -10
	addi x15, x15, 1
	jal x1, dividDU

printDU: 
	addi x15, x15, 48	# converte dezena (x15) de acordo com tabela ASCII
	addi x14, x14, 48	# converte unidade (x14) de acordo com tabela ASCII
	sb x15, 1024(x0)	# printa dezena
	sb x14, 1024(x0)	# printa unidade
	sb x10, 1024(x0)	# printa enter (para organizacao)
	beq x21, x0, verifVencedor	# se x21 = 0 -> ambos os jogadores digitaram suas strings
	# se x21 != 0 -> decrementa x21 e pega a string do jogador 2
	addi x21, x21, -1	
	jal x0, clear

# printando vencedor
# 1: jogador 1 venceu
# 2: jogador 2 venceu
# 3: houve empate
# x31: pontuacao do jogador 2	x30: pontuacao do jogador 1
verifVencedor:
	blt x31, x30, printV1	# x30 > x31 -> jogador 1 venceu
	blt x30, x31, printV2	# x30 < x31 -> jogador 2 venceu
	beq x30, x31, printE	# x30 = x31 -> empate

printV1:
	addi x12, x0, 1 	# salvando '1' em x12 e convertendo tabela ASCII
	addi x12, x12, 48
	sb x12, 1024(x0)	# printando '1'
	jal x0, fimJogo

printV2:
	addi x12, x0, 2 	# salvando '2' em x12 e convertendo tabela ASCII
	addi x12, x12, 48
	sb x12, 1024(x0)	# printando '2'
	jal x0, fimJogo

printE:
	addi x12, x0, 3 	# salvando '3' em x12 e convertendo tabela ASCII
	addi x12, x12, 48
	sb x12, 1024(x0)	# printando '3'
	jal x0, fimJogo

fimJogo: halt

letrasJogo: .string "AEIOUDGTBCMNPFHVWYKRSJLXQZ"
