	AREA	Closure, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	;
	; Your program goes here!!
	;

stop	B	stop


	AREA	TestData, DATA, READWRITE

ASize	DCD	8			; Number of elements in A
AElems	DCD	+4,-6,-4,+3,-8,+6,+8,-3	; Elements of A

	END
