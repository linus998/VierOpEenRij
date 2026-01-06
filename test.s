print_line_speelveld:
    push    {r4, lr}        @ preserve callee-saved + align stack

    ldr     r0, =bord_speel_lijn
    mov     r1, #1          @ %d #1
    mov     r2, #2          @ %d #2
    mov     r3, #3          @ %d #3

    sub     sp, sp, #16     @ space for 4 more ints (4 × 4 bytes)

    mov     r4, #4
    str     r4, [sp, #0]    @ %d #4
    mov     r4, #5
    str     r4, [sp, #4]    @ %d #5
    mov     r4, #6
    str     r4, [sp, #8]    @ %d #6
    mov     r4, #7
    str     r4, [sp, #12]   @ %d #7

    bl      printf

    add     sp, sp, #16     @ clean up stack
    pop     {r4, lr}
    bx      lr