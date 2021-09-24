	AREA	StringReverse, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =strSrc
	LDR	R2, =strDst
	LDR R4, =0
while
	LDRB R3, [R1]
	CMP R3, #0
	BEQ endwhile
	ADD R4, R4, #1
	ADD R1, R1, #1
	B while
endwhile
while2
	CMP R4, #0
	BEQ endwhile2
	SUB R4, R4, #1
	SUB R1, R1, #1
	LDRB R3, [R1]
	STRB R3, [R2]
	ADD R2, R2, #1
	B while2
endwhile2	
stop	B	stop


	AREA	TestData, DATA, READWRITE

strSrc	DCB	"hello",0
strDst	SPACE	128

	END
