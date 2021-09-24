	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0 ,=0xFFFFFFFF
	LDR R1 ,=0xFFFF00FF
	LDR R2 ,=0x00004400
	AND R0, R0, R1
	ORR R0, R0, R2
	
	
	
stop	B	stop

	END	