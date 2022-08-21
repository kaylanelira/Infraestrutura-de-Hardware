init:
	lb x10, 0(x0) 
	sb x10, 1030(x0) # potenciometro
	addi x12, x0, 0x0e1 # maior que 10 
	addi x15, x0, 0x133 # maior que 15
	addi x16, x0, 0x19a # maior que 20
	addi x17, x0, 0x200 # maior que 25
	addi x18, x0, 0x266 # maior que 30
	
loop:
	lh x10, 1031(x0)
	bge x10, x18, ledVD	# >= 31
	bge x10, x17, ledVdD_if	# >= 26
	bge x10, x16, ledVdE_if	# >= 21
	bge x10, x15, ledAD_if	# >= 16
	bge x10, x12, ledAE_if	# >= 11
	blt x10, x12, ledVE	# < 11
	jal x0, loop

ledAE_if:
	blt x10, x15, ledAE
	jal x0, loop

ledAD_if:
	blt x10, x16, ledAD
	jal x0, loop

ledVdE_if:
	blt x10, x17, ledVdE
	jal x0, loop

ledVdD_if:
	blt x10, x18, ledVdD
	jal x0, loop

ledVE:
	addi x14, x0, 3	# LED 3
	sb x14, 1033(x0)
	addi x14, x0, 255
	sb x14, 1034(x0)

	jal x1, desligLED_AE
	jal x1, desligLED_AD
	jal x1, desligLED_VdE
	jal x1, desligLED_VdD
	jal x1, desligLED_VD

	jal x0, loop

ledAE:
	addi x14, x0, 5
	sb x14, 1033(x0)
	addi x14, x0, 255
	sb x14, 1034(x0)

	jal x1, desligLED_VE
	jal x1, desligLED_AD
	jal x1, desligLED_VdE
	jal x1, desligLED_VdD
	jal x1, desligLED_VD

	jal x0, loop

ledAD:
	addi x14, x0, 6
	sb x14, 1033(x0)
	addi x14, x0, 255
	sb x14, 1034(x0)

	jal x1, desligLED_AE
	jal x1, desligLED_VE
	jal x1, desligLED_VdE
	jal x1, desligLED_VdD
	jal x1, desligLED_VD

	jal x0, loop

ledVdE:
	addi x14, x0, 9 # led 9
	sb x14, 1033(x0)
	addi x14, x0, 255
	sb x14, 1034(x0)

	jal x1, desligLED_AE
	jal x1, desligLED_AD
	jal x1, desligLED_VE
	jal x1, desligLED_VdD
	jal x1, desligLED_VD
	jal x0, loop

ledVdD:
	addi x14, x0, 10
	sb x14, 1033(x0)
	addi x14, x0, 255
	sb x14, 1034(x0)
	
	jal x1, desligLED_AE
	jal x1, desligLED_AD
	jal x1, desligLED_VdE
	jal x1, desligLED_VE
	jal x1, desligLED_VD
	jal x0, loop

ledVD:
	addi x14, x0, 11
	sb x14, 1033(x0)
	addi x14, x0, 255
	sb x14, 1034(x0)

	jal x1, desligLED_AE
	jal x1, desligLED_AD
	jal x1, desligLED_VdE
	jal x1, desligLED_VdD
	jal x1, desligLED_VE
	jal x0, loop

# desligando led 3
desligLED_VE:
	addi x14, x0, 3	
	sb x14, 1033(x0)
	addi x14, x0, 0
	sb x14, 1034(x0)
	jalr x0, 0(x1)
	
# desligando led 5
desligLED_AE:
	addi x14, x0, 5
	sb x14, 1033(x0)
	addi x14, x0, 0
	sb x14, 1034(x0)
	jalr x0, 0(x1)

# desligando led 6
desligLED_AD:
	addi x14, x0, 6
	sb x14, 1033(x0)
	addi x14, x0, 0
	sb x14, 1034(x0)
	jalr x0, 0(x1)

# desligando led 9
desligLED_VdE:
	addi x14, x0, 9
	sb x14, 1033(x0)
	addi x14, x0, 0
	sb x14, 1034(x0)
	jalr x0, 0(x1)

# desligando led 10
desligLED_VdD:
	addi x14, x0, 10
	sb x14, 1033(x0)
	addi x14, x0, 0
	sb x14, 1034(x0)
	jalr x0, 0(x1)

# desligando led 11
desligLED_VD:
	addi x14, x0, 11
	sb x14, 1033(x0)
	addi x14, x0, 0
	sb x14, 1034(x0)
	jalr x0, 0(x1)

# 11 -> 0011100001	0e1
# 15 -> 0100110010 132
# 20 -> 0110011001 199
# 25 -> 0111111111 lff
# 30 -> 1001100101 265
