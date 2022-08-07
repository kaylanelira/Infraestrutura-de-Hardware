ponto1: .string "AEIOU" # 0  # salvando string
ponto2: .string "DGT" # 4
ponto3: .string "BCMNP" # 8
ponto4: .string "FHVWY" # 12
ponto5: .string "KRS" # 16
ponto8: .string "JLX" # 20
ponto10: .string "QZ"   # 24

addi x12, x0, 13 # enter
# pegando inputs (x10 e x11)
gets:
    lw x10, 1025(x0)
    addi sp, sp, -8
	sw x10, 0(sp)
    beq x10, x12, cmp
	beq x0, x0, gets

# iterar e comparar pelas strings
cmp:
    addi x5, x0, 0 # i
    lw x13, 0(x0)
    loop1:
        # comparando com ponto2
        lw x14, 4(x0)
        add x14, x5, x0
        lb x14, 0(x14)
        beq x14, x12, count
        # comparando com ponto3
        lw x15, 8(x0)
        # comparando com ponto4
        lw x16, 12(x0)
        # comparando com ponto5
        lw x17, 16(x0)
        # comparando com ponto8
        lw x18, 20(x0)
        # comparando com ponto10
        lw x19, 24(x0)
        addi x10, x0, 0
        # ir p/ cmp2

# incrementando pontuacao
# exibir valor
