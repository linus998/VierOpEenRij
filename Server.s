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
	GPIOExport	pin24					@ config GPIO24
	setSleepTime	#0, #100000000		@ 0.1 sec
	doSleep								@ sleep
	GPIODirectionOut  pin24				@ GPIO24 is output

	GPIOExport	pin23					@ config GPIO23
	setSleepTime	#0, #100000000		@ 0.1 sec
	doSleep								@ sleep
	GPIODirectionIn  pin23				@ GPIO23 is input

	GPIOWrite	pin24, high				@ Tx high
	setSleepTime	#0, #100000000		@ 0.1 sec
	doSleep								@ sleep

    @ print bord
    ldr     R0, =bord
    bl      printf

exit:
	mov		R0, #0			@ return code 0
	mov		R7, #1			@ exit
	svc		0				@ call Linux

@ DATA
@ =============================================================================================
.data
command: .space 4
pin23:	.asciz	"23"
pin24:	.asciz	"24"
low:	.asciz	"0"
high:	.asciz	"1"
pin_val: .asciz	"?"
f_str_i: .asciz "%d"
f_str_s: .asciz "%s"
fout_com: .asciz "fout commando\n"
give_com: .asciz "Blad(1) Steen(2) Schaar(3) Exit(4) >>"
loser_str: .asciz "You lost!\n"
winner_str: .asciz "You won!\n"
draw_str: .asciz "Draw!\n"
get_answer_str: .asciz "Waiting for opponent's move...\n"
str_buffer: .space 128
bord: .asciz "┌---------------------------┐\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              | O | O | O | O | O | O | O |\n
              └---------------------------┘\n"
