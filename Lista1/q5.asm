addi x10, x0, 13 # enter
addi x14, x0, 0 # contador 1 de pontos
gets:
	lb x11, 1025(x0)
	beq x11, x10, end
	addi x12, x0, 18
	addi x13, x0, 0 # contador
	iterar_string:
		lb x5, 0(x12)
		beq x5, x11, cmp
		addi x12, x12, 1
		addi x13, x13, 1 # vendo onde ta na str
	bne x5, x0, iterar_string
	
	jal x0, gets

cmp:
	addi x6, x0, 5
	blt x13, x6, ad1
	addi x6, x0, 8
	blt x6, x0, ad2
	addi x6, x0, 13
	blt x6, x0, ad3
	addi x6, x0, 18
	blt x6, x0, ad4
	addi x6, x0, 21
	blt x6, x0, ad5
	addi x6, x0, 24
	blt x6, x0, ad8
	addi x6, x0, 26
	blt x6, x0, ad10
	jal x0, print

print:
	addi x14, x14, 48
	sb x14, 1024(x0)

ad1:
	addi x14, x14, 1
	jalr x1, 0(x1)

ad2:
	addi x14, x14, 2
	jalr x1, 0(x1)

ad3:
	addi x14, x14, 3
	jalr x1, 0(x1)

ad4:
	addi x14, x14, 4
	jalr x1, 0(x1)

ad5:
	addi x14, x14, 5
	jalr x1, 0(x1)

ad8:
	addi x14, x14, 8
	jalr x1, 0(x1)

ad10:
	addi x14, x14, 10
	jalr x1, 0(x1)



end: halt



letras: .string "AEIOUDGTBCMNPFHVWYKRSJLXQZ"

