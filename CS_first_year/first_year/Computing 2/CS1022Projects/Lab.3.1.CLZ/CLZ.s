	AREA	CLZ, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	; install the start address of your exception handler
	; in the exception vector lookup table
	ldr r4, =0x40000024
	ldr r5, =UndefHandler
	str r5, [r4]

	ldr r6, =0x00050003
	DCD 0x77FFF716
	; write a program to test your exception handler

	
stop	B	stop


	; write your exception handler
UndefHandler
	STMFD sp!, {r0-r12,lr}
	ldr r4, [lr, #-4]
	bic r6, r4, #0xFFFFF0FF
	mov r6, r6, LSR #8
	bic r5, r4, #0xFFF0FFFF
	teq r5, #0x000F0000
	BNE endif1
	
	bic r5, r4, #0xFFFFFFF0
	ldr r1, [sp, r5, LSL #2]
	
	BL clzSubroutine
	
	str r0, [sp, r6, LSL #2]
endif1
	LDMFD sp!, {r0-r12,PC}^
	
clzSubroutine
	STMFD sp!, {lr}
	mov r2, #0x80000000
	mov r0, #0
subroutineloop	
	and r3, r1, r2
	cmp r3, #0
	bne endSubroutine
	add r0, r0, #1
	mov r2, r2, lsr #1
	b subroutineloop
endSubroutine
	LDMFD sp!, {PC}
	
	
	END	
	
	
	
