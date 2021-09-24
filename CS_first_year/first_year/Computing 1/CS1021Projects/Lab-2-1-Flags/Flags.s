	AREA	Flags, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R1, =4
	
	CMP R1, #5
	BLO idk
	LDR R1, =0
idk

stop	B	stop

	END