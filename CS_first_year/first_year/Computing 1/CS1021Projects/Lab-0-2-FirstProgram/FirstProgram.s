	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR r0, =0x33000000
	ldr r1, =0xB1000001
	subs r2, r0, r1
	; your program goes here

stop	B	stop

	END
