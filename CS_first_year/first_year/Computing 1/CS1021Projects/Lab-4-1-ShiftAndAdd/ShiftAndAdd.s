	AREA	ShiftAndAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =9
	LDR	R2, =10
	LDR R3, =0xFFFFFFFE
	LDR R4, =0
while
	CMP R2, #0
	BEQ endwhile
	AND R5, R2, R3
	CMP R5, #0
	BEQ else
	MOV R6, R1,	LSL R4
else
	ADD R4, R4, #1
	MOV R2, R2 LSR #1
	ADD R0, R0, R6
	B while
endwhile	

	
stop	B	stop


	END	
	