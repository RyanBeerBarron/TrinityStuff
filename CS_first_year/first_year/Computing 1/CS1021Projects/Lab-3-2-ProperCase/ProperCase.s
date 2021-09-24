	AREA	ProperCase, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =testStr	; address = test String starting adress
	LDR R0, =1			; first letter of word = true
while					; 
	LDRB R3, [R1]		; load character from address
	CMP R3, #0			; while ( character != null ) 
	BEQ endwhile		; {
	CMP R3, #0x20		;		if ( character == space )				
	BEQ space			;			branch to space
	CMP R3, #'A'		;		else if ( character == UPPERCASE && !first letter of word )
	BLO else			;		{
	CMP R3, #'Z'		;
	BHI else			;
	CMP R0, #1			;			make lowercase
	BEQ endif			;			
	ADD R3, R3, #0x20	;			character = character + 0x20
	STRB R3, [R1]		;			store charater in address
	B endif				;		}
else					;		else if ( character == lowercase && first letter of word ) 
	CMP R0, #1			;		{
	BNE endif			;			make UPPERCASE
	SUB R3, R3, #0x20	;			character = character - 0x20	
	STRB R3, [R1]		;			store character in adress
	B endif				;		}
space					;		space
	ADD R1, R1, #1		;		{	adress = adress + 1 ( next byte address )
	LDR R0, =1			;			first letter of word = true
	B while				;		}
endif					;		
	ADD R1, R1, #1		;		adress = adress + 1 ( next byte address )
	LDR R0, =0			;		first letter of word = false
	B while				;}
endwhile	
stop	B	stop



	AREA	TestData, DATA, READWRITE

testStr	DCB	"hello WORLD",0

	END
