	AREA	Val2Dec, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R6, =10		; divisor = 10
	LDR	R4, =788439	; number = 7890
	LDR	R5, =decstr	; r5 = starting string address
	LDR R8, =0		; number of digits counter = 0;
while1				; 
	CMP R4, #0		; while number>0 
	BLE endwhile1	; {
	MOV R0, R4 		; 	number = 7890(R4)
	MOV R1, R6 		; 	divisor = 10(R6)
	BL divide		; 	get quotient and remainder
	MOV R4, R2 		; 	number = quotient
	MOV R7, R0 		; 	R7 = remainder
	MOV R0, R7		;	R0 = remainder
	MOV R1, R5		; 	R1 = string address
	BL val2dec		;	store remainder as ASCII digit in string address, update string address
	MOV R5, R1		;	string address = updated string address	
	ADD R8, R8, #1	;	digit counter += 1
	B while1		; }	
endwhile1			;
	LDR R5, =decstr	; r5 = starting string address
	MOV R9, R8		; R9 = number of digits in original number	
while2				; 
	CMP R8, #0			; while ( digit counter > 0 ) 
	BLE endwhile2		; {
	LDRB R0, [R5], #1	;	load digit from string address, update after accessing memory  
	STRB R0, [SP, #-1]!	;	push digit in full descending stack
	ADD R8, R8, #-1		;	digit counter = digit counter - 1
	B while2			; }
endwhile2				;
	LDR R5, =decstr		; r5 = starting string address
	MOV R8, R9			; digit counter = r9
while3					; while ( digit counter > 0 )
	CMP R8, #0			; {
	BLE endwhile3		;	 
	LDRB R0, [SP], #1	;	pop digit from empty ascending stack
	STRB R0, [R5], #1	;	store in string address, update after accesing memory
	ADD R8, R8, #-1		;	digit counter  = digit counter - 1
	B while3			; } 	
endwhile3				;

	B stop
	
	
	
	
	
;divide subroutine
;Take a number and a divisor, returns the remainder and quotient of the division
;parameters R0: number to be divided
;			R1: divisor
;return R0: remainder
;		R1: divisor
;		R2: quotient
divide
	STMFD sp!, {lr}
	LDR R2, =0
subwhile
	CMP R0, R1
	BLT subendwhile
	SUB R0, R0, R1
	ADD R2, R2, #1
	B subwhile
subendwhile
	LDMFD sp!, {pc}

;val2dec subroutine
;Take an integer between 0-9 and saves it as an decimal ASCII character in a string in memory
;parameters R0: remainder between 0-9
;			R1: memory address of string
;return	R1: updated memory address of string
val2dec
	STMFD sp!, {lr}
	ADD R0, R0, #0x30
	STRB R0, [R1], #1 
	LDMFD sp!, {pc}
stop	B	stop


	AREA	TestString, DATA, READWRITE

decstr	SPACE	16

	END	