	AREA	Unique, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, =2				; Unique values = tbd
	LDR	R1, =VALUES			; address1 = address of first value from set
	LDR R2, =COUNT			; R2 = address of count
	LDR R2, [R2]			; count1 = loading count from address
loop						; while ( count1 > 0 )
	MOV R4, R1				; {		address2 = address of first value from set
	MOV R6, R2				; 		count2 = count1
	LDR R3, [R1]			;   	value1 = load value from address1
	CMP R2, #0				; 	
	BEQ endloopgoodending	; 
loop2						;		while ( count2 > 0 )
	SUB R6, R6, #1			;		{	count2 = count2 - 1
	ADD R4, R4, #4			;			address2 = address2 + 4 ( next word size value ) 
	LDR R5, [R4]			;			value2 = load value from address2
	CMP R3, R5				;			if ( value1 == value2 ) 
	BEQ endloopbadending	;				break from loop 1 & 2
	CMP R6, #0				;			
	BEQ endloop2			;
	B loop2					;		}
endloop2					;
	SUB R2, R2, #1			;		count1 = count1 - 1
	ADD R1, R1, #4			;		address1 = address1 + 4 ( next word size value )
	B loop					; }
endloopbadending			; if ( (value1==value2) )
	LDR R0, =1				; Unique values = false 
	B end					; 
endloopgoodending			; else
	LDR R0, =0				; Unique values = true
end		
	


stop	B	stop


	AREA	TestData, DATA, READWRITE

COUNT	DCD	10
VALUES	DCD	5, 2, 7, 4, 13, 4, 18, 8, 9, 12


	END
