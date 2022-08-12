addi x9, x0, 4
xor x15, x15, x15

gets:
	lb x12, 1025(x0) # teclado
	addi x12, x12, -48
	add x14, x14, x12
	add x14, x14, x14 # multiplicando por 2
	addi x13, x13, 1 # flag
	beq x9, x13, cmp
	jal x0, gets

cmp:
	beq x14, x15, print0
	addi x15, x15, 1 
	beq x14, x15, print1
	addi x15, x15, 1 
	beq x14, x15, print2
	addi x15, x15, 1 
	beq x14, x15, print3
	addi x15, x15, 1 
	beq x14, x15, print4
	addi x15, x15, 1 
	beq x14, x15, print5
	addi x15, x15, 1 
	beq x14, x15, print6
	addi x15, x15, 1 
	beq x14, x15, print7
	addi x15, x15, 1 
	beq x14, x15, print8
	addi x15, x15, 1 
	beq x14, x15, print9
	beq x14, x15, limpaDisplay

print0:
	lh x10, 0b0111111
	jal x0, printDisplay
print1:
	addi x10, x0, 0b0000110
	jal x0, printDisplay
print2:
	addi x10, x0, 0b1011011
	jal x0, printDisplay
print3:
	addi x10, x0, 0b1001111
	jal x0, printDisplay
print4:
	addi x10, x0, 0b1100110
	jal x0, printDisplay
print5:
	addi x10, x0, 0b1101101
	jal x0, printDisplay
print6:
	addi x10, x0, 0b1111101
	jal x0, printDisplay
print7:
	addi x10, x0, 0b0000111
	jal x0, printDisplay
print8:
	addi x10, x0, 0b1111111
	jal x0, printDisplay
print9:
	addi x10, x0, 0b1101111
	jal x0, printDisplay
limpaDisplay:
	addi x10, x0, 0b0000001
	jal x0, printDisplay

printDisplay:
	sh x10, 1029(x0)
	addi x10, x10, 1
	jal x0, printDisplay

end: halt

