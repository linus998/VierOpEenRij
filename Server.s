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
    @----------------------------------------------------------------------------------------------
print_bord:   
    ldr     R0, =bord_top
    bl      printf

print_line_speelveld:
    ldr     R0, =bord_speel_lijn    
    mov     R1, "S"
    bl      printf

exit:
	mov		R0, #0			@ return code 0
	mov		R7, #1			@ exit
	svc		0				@ call Linux

@ DATA
@ =================================================================================================
.data
pin23:	.asciz	"23"
pin24:	.asciz	"24"
low:	.asciz	"0"
high:	.asciz	"1"
pin_val: .asciz	"?"

bord_top: .asciz "┌---------------------------┐\n"
bord_speel_lijn: .asciz "| %s |\n"
bord_bottom: .asciz "└---------------------------┘\n"
input_from_user: .asciz "Welke lijn wil je invoegen: \n"
