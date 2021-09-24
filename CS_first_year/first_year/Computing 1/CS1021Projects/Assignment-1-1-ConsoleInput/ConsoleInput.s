	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R4, =0			; number = 0
	LDR R6, =10			; constant = 10
	LDR R11, =1			; positiveNumber = 1
read
	BL	getkey			; read key from console
	CMP	R0, #0x0D  		; while (key != CR)
	BEQ	endRead			; {
	BL	sendchar		;   echo key back to console
	CMP R0, #0x2D		;	if ( key == "-")
	BNE positiveValue	;	{
	LDR R11, =0			;		positiveNumber = 0		
	B read				;		get next key
positiveValue			;	}
	MUL R4, R6, R4		;	number = number * 10
	MOV R5, R0			;	singledigit = key
	SUB R5, R5, #0x30	;	singledigit = singledigit - ASCII character code
	ADD R4, R4, R5		;	number = number + singledigit
	B	read			; }
	
endRead
	CMP R11, #0			; if ( positiveNumber == 0 )	
	BNE positiveNumber	; {	
	SUB R4, R11, R4		;	number = 0 - number
positiveNumber			; }	
	stop	B	stop

	END	