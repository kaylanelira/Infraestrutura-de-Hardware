# carregando valores a e b nos regs
lw x10, a
lw x11, b
# criando x em x12 (zerado)
addi x12, x10, 0

# if (b == m)
beq x11, x12, equal
# m = a - b
sub x12, x10, x11
halt

# m = b - a
equal:
	sub x12, x11, x10	
	halt

a: .word 10	# define entrada a
b: .word 10	# define entrada b
