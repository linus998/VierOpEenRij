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

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ R2 is line of col counter
@ R3 is adress van cel inhoud in de aray
@ R0 is formatted string
@ R1 is inhoud cel
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    mov R2, #0          @line counter
    ldr R3, =lijst_van_waarden @adress couter

print_6_lines:

    add R2, R2, #1
    cmp R2, #7
    beq bord_greprint

    str R2, =line_counter

    mov R2, #0          @ col counter

print_7_cols:
    add R2, R2, #1
    cmp R2, #8
    beq next_line

    ldr R0, =bord_cell
    mov R1, [R3]
    bl printf

    add R3, R3, #4 

next_line:
    ldr R0, =bord_border_right
    str R2, =col_counter
    ldr R2, =line_counter
    b print_6_lines

bord_greprint:





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
bord_cell: .asciz "| %d "
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