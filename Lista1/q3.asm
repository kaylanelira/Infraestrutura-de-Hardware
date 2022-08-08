lw x10, a
lw x11, b
lw x12, bitmask1
lw x13, bitmask2

add x14, x10, x0
and x14, x14, x12
and x11, x11, x13
slli x14, x14, 16
or x11, x14, x11

halt

bitmask1: .word 0x0000ff00
bitmask2: .word 0x00ffffff
# valores
a: .word 0x12345678
b: .word 0x09876543
