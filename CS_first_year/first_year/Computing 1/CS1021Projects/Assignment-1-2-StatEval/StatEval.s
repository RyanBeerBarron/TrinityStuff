	AREA	StatEval, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R6, =10			; constant = 10
	LDR R7, =0			; count = 0
	LDR R8, =0			; sum = 0
	LDR R9, =0x7FFFFFFF	; min = (2^31)-1 
	LDR R10, =0x80000000; max = -(2^31)
endspacebar
	LDR R4, =0			; number = 0
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
	MOV R5, R0			;	singledigit = key
	CMP R5, #0x20		; 	if (singledigit != spacebar)
	BEQ spacebar		; 	{
	MUL R4, R6, R4		;		number = number * constant
	SUB R5, R5, #0x30	;		singledigit = singledigit - ASCII conversion
	ADD R4, R4, R5		;		number = number + singledigit
						;	} else break
	B read				; }
endRead					; if (key == CR )
	MOV R5, #0			; quotient = 0
	MOV R6, #0			; remainder = 0 
spacebar				;
	CMP R11, #0			; if ( positiveNumber == 0 )
	BNE notNegative		; {
	SUB R4, R11, R4		; 	number = 0 - number
notNegative				; }
	ADD R7, R7, #1		; count += 1	
	ADD R8, R8, R4		; sum += number
	CMP R4, R9			; if ( number < min )
	BGT notLower		; {
	MOV R9, R4			; 	min = number
notLower				; }
	CMP R4, R10			; if ( number > max )
	BLT notHigher		; {	
	MOV R10, R4			; 	max = number
notHigher				; }	
	CMP	R0, #0x0D  		; if (key == CR)
	BEQ	mean			;	stop reading, compute mean 
	B endspacebar		; else get next key
mean					;
	LDR R11, =1			; positiveNumber = 1
	SUB R4, R10, R9		; range = max - min
	MOV R6, R8			; remainder = quotient
	CMP R6, #0x80000000	; if ( remainder >= 2^31 )
	BLO while			; {
	LDR R11, =0			; 	positiveNumber = 0
	SUB R6, R11, R6		;	remainder = 0 - remainder
while					;} else
	CMP R7, R6			;while ( remainder >= count )
	BGT endwhile		;{
	SUB R6, R6, R7		;	remainder = remainder - count
	ADD R5, R5, #1		;	quotient = quotient + 1
	B while				;}
endwhile			
	CMP R11, #0			; if ( positiveNumber == 0)
	BNE stop			; {
	SUB R6, R11, R6		;	remainder = 0 - remainder
	SUB R5, R11, R5		;	quotient = 0 - quotient }
stop	B	stop

	END	