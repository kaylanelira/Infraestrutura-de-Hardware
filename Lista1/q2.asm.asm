addi x9, x0, 0xd
xor x12, x12, x12

# a (x10)
jal x1, inic
addi x10, x12, 0
add x12, x0, x0
#b (x14)
jal x1, inic
addi x14, x12, 0
add x12, x0, x0

# c (x15)
jal x1, inic
addi x15, x12, 0
add x12, x0, 0

# x (x16)
addi x16, x0, 0

# a >= 0
blt x10, x0, end

# b <= 64 (0040)
and_:
	addi x18, x0, 0040
	bge x18, x14, end	
# c > 23 (0017)
and__:
	addi x18, x0, 0017
	blt x18, x15, end

if:
	addi x16, x16, 1
end: halt

# jalr x0,0(x0)
inic:
	lb x11, 1025(x0)
	beq x11, x9, endloop
	sb x11, 1024(x0)
	jal x0, gets
gets:
	slli x13, x12, 1
	slli x12, x12, 3
	add x12, x13, x12
	addi x11, x11, -48
	add x12, x12, x11
	jal x0, inic
endloop:
	jalr x0, 0(x1)
