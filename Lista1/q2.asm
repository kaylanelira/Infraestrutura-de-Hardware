addi x9, x0, 0xd # enter

# a (x10)
jal x1, inic	# a em x12
add x10, x12, x0
xor x12, x12, x12 # reset x12

# b (x14)
jal x1, inic
add x14, x12, x0
xor x12, x12, x12 # reset x12

# c (x15)
jal x1, inic
add x15, x12, x0
# xor x12, x12, x12 # reset x12

# x (x16)
add x16, x0, x0

# a >= 0
addi x20, x0, 0
blt x10, x20, end 	# a < 0

# b <= 64 (65: 0041)
and_:
	addi x18, x0, 0x041
	bge x14, x18, end	# b >= 65

# c > 23 (0017)
and__:
	addi x19, x0, 0x017
	bge x19, x15, end	# 23 >= c

inc:
	addi x16, x0, 1

end:
	addi x16, x16, 48 # pintar num
	sw x9, 1024(x0)	# printar '/n'
	sw x16, 1024(x0) # print x 
	halt

inic:
	lw x11, 1025(x0)
	beq x11, x9, endloop
	sw x11, 1024(x0)

gets:
	slli x13, x12, 1
	slli x12, x12, 3
	add x12, x13, x12
	addi x11, x11, -48
	add x12, x12, x11
	jal x0, inic

endloop:
	jalr x0, 0(x1)
