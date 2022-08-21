addi x10, x0, 13 # enter
addi x22, x0, 0 # incrementa quant.de players
addi x21, x0, 2 # quantidade de players
addi x16, x0, 10
addi x17, x0, 100
addi x7, x0, 0x019f # empate
addi x28, x0, 0 # vencedor 1
addi x29, x0, 0 # vencedor 2

clear:
	addi x14, x0, 0
	addi x15, x0, 0
	addi x20, x0, 0
	addi x22, x22, 1

gets:
	addi x1, x0, 0x030
	lb x11, 1025(x0)
	beq x11, x10,	end
	addi x12, x0, 0x0124
	addi x13, x0, 0 # contador
	iterar_string:
		lb x5, 0(x12)
		beq x5, x11, cmp
		addi x12, x12, 1
		addi x13, x13, 1 # vendo onde ta na str
		bne x5, x0, iterar_string
	jal x1, gets

cmp:
	addi x6, x0, 5
	blt x13, x6, ad1
	addi x6, x0, 8
	blt x13, x6, ad2
	addi x6, x0, 13
	blt x13, x6, ad3
	addi x6, x0, 18
	blt x13, x6, ad4
	addi x6, x0, 21
	blt x13, x6, ad5
	addi x6, x0, 24
	blt x13, x6, ad8
	addi x6, x0, 27
	blt x13, x6, ad10
	jal x0, gets

ad1:
	addi x14, x14, 100
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

end: 
	jal x1, dividC

# printando centena
dividC:
	blt x14, x17, printC
	addi x14, x14, -100
	addi x20, x20, 1
	jal x1, dividC

printC:
	addi x20, x20, 48
	sb x20, 1024(x0)
	jal x1, dividDU

# printando dezena e unidade
dividDU:
	blt x14, x16, printDU
	addi x14, x14, -10
	addi x15, x15, 1
	jal x1, dividDU

printDU: 
	addi x15, x15, 48
	addi x14, x14, 48
	sb x15, 1024(x0)
	sb x14, 1024(x0)
	sb x10, 1024(x0)
	blt x22, x21, clear

salvaP1:
	add x30, x14, x0
	jal x0, dividC

fimJogo: halt

letras: .string "AEIOUDGTBCMNPFHVWYKRSJLXQZ"
v1: .string "1 venceu0"
v2: .string "2 venceu0"
empate: .string "empatou0"
