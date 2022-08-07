# enter
addi x10, x0, 13
# contador
addi x9, x0, 0
# aeiouyAEIOUY (nessa ordem)
addi x13, x0, 97
addi x14, x0, 101
addi x15, x0, 105
addi x16, x0, 111
addi x17, x0, 117
addi x18, x0, 121
addi x19, x0, 65
addi x20, x0, 69
addi x21, x0, 73
addi x22, x0, 79
addi x23, x0, 85
addi x24, x0, 89

gets:
	lb x11, 1025(x0)
	beq x11, x10, end
	jal x12, comp

comp:
	beq x11, x13, incCount
	beq x11, x14, incCount
	beq x11, x15, incCount 
	beq x11, x16, incCount
	beq x11, x17, incCount
	beq x11, x18, incCount
	beq x11, x19, incCount
	beq x11, x20, incCount
	beq x11, x21, incCount
	beq x11, x22, incCount
	beq x11, x23, incCount
	beq x11, x24, incCount
	jal x12, gets

incCount:
	addi x9, x9, 1
	jal x12, gets
end:
	addi x9, x9, 48
	sb x9, 1024(x0) # print quantidade
	halt



