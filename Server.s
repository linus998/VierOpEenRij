linusbeheydt
linusbeheydt
Online

linusbeheydt — 09:02
https://github.com/linus998/Projectdag2_CA.git
GitHub
linus998/Projectdag2_CA
Contribute to linus998/Projectdag2_CA development by creating an account on GitHub.
linus998/Projectdag2_CA
ELPepe — 11:52
@ IMPORTS
@ =============================================================================================
.extern printf
.extern scanf
.include "Rx_Tx.s"
Expand
message.txt
4 KB
linusbeheydt — 12:35
https://github.com/linus998/VierOpEenRij.git
GitHub
linus998/VierOpEenRij
Contribute to linus998/VierOpEenRij development by creating an account on GitHub.
linus998/VierOpEenRij
ELPepe — 12:56
bord: asciz. "┌---------------------------┐\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              └---------------------------┘\n"
"┌---------------------------┐\n| %s | %s | %s | %s | %s | %s | %s |\n| %s | %s | %s | %s | %s | %s | %s |\n| %s | %s | %s | %s | %s | %s | %s |\n| %s | %s | %s | %s | %s | %s | %s |\n| %s | %s | %s | %s | %s | %s | %s |\n| %s | %s | %s | %s | %s | %s | %s |\n└---------------------------┘\n"
ELPepe — 13:12
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
    ldr     R0, =bord_speel_lijn
    mov     R1, #0
    mov        R2, #0
    mov     R3, #0
    mov     R4, #0
    mov        R5, #0
    mov     R6, #0
    mov     R7, #0
    bl      printf

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
ELPepe — 14:38
@ IMPORTS
@ =============================================================================================
.extern printf
.extern scanf
.include "Rx_Tx.s"
Expand
message.txt
4 KB
﻿
ELPepe
el_pepe_1
 
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

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ print bord
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
print_bord:
    ldr     R0, =bord_top
    bl      printf
    mov R8, #0          @line counter
    ldr R10, =lijst_van_waarden @adress couter

print_6_lines:

    add R8, R8, #1
    cmp R8, #7
    beq bord_greprint

    mov R9, #0          @col counter

print_7_cols:
    add R9, R9, #1
    cmp R9, #8
    beq next_line

    push    {r4, lr}        @ preserve callee-saved + align stack

    ldr     r0, =bord_cell
    ldr     r1, [R10], #4           @ %d #1
    ldr     r2, [R10], #4          @ %d #2
    ldr     r3, [R10], #4          @ %d #3

    sub     sp, sp, #16     @ space for 4 more ints (4 × 4 bytes)

    ldr     r4, [R10], #4
    str     r4, [sp, #0]    @ %d #4
    ldr     r4, [R10], #4
    str     r4, [sp, #4]    @ %d #5
    ldr     r4, [R10], #4
    str     r4, [sp, #8]    @ %d #6
    ldr     r4, [R10], #4
    str     r4, [sp, #12]   @ %d #7

    bl      printf

    add     sp, sp, #16     @ clean up stack
    pop     {r4, lr}


next_line:
    ldr R0, =bord_border_right
    ldr R1, =col_counter
    str R2, [R1]
    ldr R2, =line_counter
    b print_6_lines

bord_greprint:
    ldr R0, =bord_bottom
    bl printf

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ elias zijn deel
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
drop_piece:
    mov R2, #2
    mov R1, #1
    @R2 = column to drop piece
    @R1 = speler nr

    ldr R0, =bord

    mov R2, R2, lsl #2
    add R0, R0, R2
    ldr R2, [R0]
    cmp R2, #0
    beq no_col_space

loop:
    add R0, R0, #28
    ldr R2, [R0]
    cmp R2, #0
    beq space_found
    b   loop

no_col_space:
    @geef een error message

space_found:
    sub R0, R0, #28
    str R1, [R0]

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

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
bord_cell: .asciz "| %d | %d | %d | %d | %d | %d | %d |\n"
bord_border_right: .asciz "|\n"
bord_bottom: .asciz "└---------------------------┘\n"
input_from_user: .asciz "Welke lijn wil je invoegen: \n"

lijst_van_waarden: .word 0, 0, 0, 0, 0, 0, 0
                   .word 0, 0, 0, 0, 0, 0, 0
                   .word 0, 0, 0, 0, 0, 0, 0
                   .word 0, 0, 0, 0, 0, 0, 0
                   .word 0, 0, 0, 0, 0, 0, 0
                   .word 0, 0, 0, 0, 0, 0, 0
                   
line_counter: .space 4
col_counter: .space 4