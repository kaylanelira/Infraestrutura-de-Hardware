Encontre a menor sequência de instruções RISC-V que extrai os bits 15 até 8 do
registrador x10 e usa o valor desse campo para substituir os bits 31 até 24 no registrador
x11 sem alterar os outros bits dos registradores x10 ou x11. Teste com 5 valores
diferentes no registrador x10.

lw x10, a
lw x11, b
lw x12, bitmask1
lw x13, bitmask2

add x14, x10, x0	# x14 auxiliar para nao alterar bits de x10 e x11
and x14, x14, x12	# bits 15-8 de x10 em x14
and x11, x11, x13	# retira bits 31-24 de x11
slli x14, x14, 16	# shift em x14 para bits 31-24
or x11, x14, x11	# substitui bits em x11

halt

# bitmasks
bitmask1: .word 0x0000ff00
bitmask2: .word 0x00ffffff

# valores
a: .word 0x12345678
b: .word 0xabababab
