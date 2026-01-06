@ IMPORTS
@ =============================================================================================
.extern printf
.extern scanf
.include "Rx_Tx.s"

@ TEXT
@ =============================================================================================
.text
.global main

@ MAIN
@ =============================================================================================
main:
    GPIOExport    pin24                    @ config GPIO24
    setSleepTime    #0, #100000000        @ 0.1 sec
    doSleep                                @ sleep
    GPIODirectionOut  pin24                @ GPIO24 is output

    GPIOExport    pin23                    @ config GPIO23
    setSleepTime    #0, #100000000        @ 0.1 sec
    doSleep                                @ sleep
    GPIODirectionIn  pin23                @ GPIO23 is input

    GPIOWrite    pin24, high                @ Tx high
    setSleepTime    #0, #100000000        @ 0.1 sec
    doSleep                                @ sleep

    @ print bord
    @----------------------------------------------------------------------------------------------
print_bord:   
    ldr     R0, =bord_top
    bl      printf

print_line_speelveld:
    push    {r4, lr}        @ preserve callee-saved + align stack

    ldr     r0, =bord_speel_lijn
    sub     sp, sp, #16     @ space for 4 more ints (4 × 4 bytes)

    mov     r4, #4
    str     r4, [sp, #0]    @ %d #4
    mov     r4, #5
    str     r4, [sp, #4]    @ %d #5
    mov     r4, #6
    str     r4, [sp, #8]    @ %d #6
    mov     r4, #7
    str     r4, [sp, #12]   @ %d #7
    mov     r4, []
    str     r4, [sp, #16]    @ %d #4
    mov     r4, []
    str     r4, [sp, #20]    @ %d #4
    mov     r4, []
    str     r4, [sp, #24]    @ %d #4

    bl      printf

    add     sp, sp, #16     @ clean up stack
    pop     {r4, lr}
    bx      lr

exit:
    mov        R0, #0            @ return code 0
    mov        R7, #1            @ exit
    svc        0                @ call Linux

@ DATA
@ =================================================================================================
.data
pin23:    .asciz    "23"
pin24:    .asciz    "24"
low:    .asciz    "0"
high:    .asciz    "1"
pin_val: .asciz    "?"

bord_top: .asciz "┌---------------------------┐\n"
bord_speel_lijn: .asciz "| %d | %d | %d | %d | %d | %d | %d |\n"
bord_bottom: .asciz "└---------------------------┘\n"
input_from_user: .asciz "Welke lijn wil je invoegen: \n"


lijst_van_waarden: .word 168
