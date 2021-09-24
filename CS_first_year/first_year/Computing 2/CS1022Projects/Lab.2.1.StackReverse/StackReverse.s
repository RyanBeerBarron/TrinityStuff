	AREA	StackReverse, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R5, =string		; load string starting address in R5
	LDR R1, =0			; counter = 0
while1					; while( !null_terminated_string) 
	LDRB R0, [R5], #1	; { R0 = load byte from string address and increment address by 1
	CMP R0, #0			;	
	BEQ endString		;
	STRB R0, [SP, #-1]!	;	(decrement before) stack pointer = store R0
	ADD R1, R1, #1		;	counter = counter + 1
	B while1			; }	
endString				;
	LDR R5, =string		; load string starting address in R5
while2					; while ( counter >0 )	
	CMP R1, #0			; {
	BLE endReverse		;		
	ADD R1, R1, #-1		;	counter = counter - 1
	LDRB R0, [SP], #1	;	R0  = load byte from stack pointer ( increment after ) 
	STRB R0, [R5], #1	;	(increment after ) string address = store R0
	B while2			; }
endReverse	



stop	B	stop


	AREA	TestString, DATA, READWRITE

string	DCB	"abcdef"

	END