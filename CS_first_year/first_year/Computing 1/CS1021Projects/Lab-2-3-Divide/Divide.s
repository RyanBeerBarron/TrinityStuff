	AREA	Divide, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, =0		;quotient = 0
	LDR R2, =16		; a = 16
	LDR R3, =0		;	 b = 0
	MOV R1, R2		; remainder = a
	CMP R3, #0 		;if ( b = 0 )
	BEQ endwhile	;	end
while				;while ( remainder >= b )
	CMP R3, R1		;{
	BHS endwhile	;	
	SUB R1, R1, R3	;	remainder = remainder - b
	ADD R0, R0, #1	;	quotient = quotient + 1
	B while			;}
endwhile
	
stop	B	stop

	END	