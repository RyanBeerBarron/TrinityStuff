	AREA	MatMul, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =matR
	LDR	R1, =matA
	LDR	R2, =matB
	LDR	R3, =N
	LDR R4, =0			; row =  0
	LDR R5, =0			; count = 0
	LDR R6, =0			; sum = 0
	LDR R11, =0			; column = 0
while2					; while ( row < 4 && column < 4 )
	CMP R5, R3			; {		while ( count < 4 ) 
	BEQ endwhile		;		{
	MUL R7, R4, R3		; 			offset = row * row size
	ADD R7, R7, R5		; 			offset = offset + count
	MUL R7, R3, R7		;			offset = offset * word size
	LDR R8, [R1, R7]	;			numberA  = address + offset
	MUL R7, R3, R5		;			offset = count * row size
	ADD R7, R7, R11		; 			offset = offset + column
	MUL R7, R3, R7		;			offset = offset * word size
	LDR R9, [R2, R7]	;			numberB = address + offset
	MUL R10, R8, R9		; 			productAB = numberA * numberB 
	ADD R6, R6, R10		; 			sum = sum + productAB
	ADD R5, R5, #1		; 			count = count + 1
	B while2			;		}
endwhile				;		
	LDR R5, =0			; 		count = 0
	STR R6, [R0], #4	; 		index matriceR = store sum / next index
	ADD R11, R11, #1	;		column = column + 1
	LDR R6, =0			;		sum = 0
	CMP R11, R3			;		if column = 4
	BNE ifend			;		{		
	ADD R4, R4, #1		;			row = row + 1
	CMP R4, R3			;			if row = 4
	BEQ stop			;				end program
	LDR R11, =0			;			else column = 0
ifend					;		}
	B while2			; }
stop	B	stop	


	AREA	TestArray, DATA, READWRITE

N	EQU	4

matA	DCD	5,4,3,2
	DCD	3,4,3,4
	DCD	2,3,4,5
	DCD	4,3,4,3

matB	DCD	5,4,3,2
	DCD	3,4,3,4
	DCD	2,3,4,5
	DCD	4,3,4,3

matR	SPACE	64

	END	