	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main
		
		
					;F			E		 	d			C			B			A			9			8			7		6			5			4			3			2			1		0	
DISPLAY DCD	 		0x7100, 	0x7900, 	0x5E00, 	0x3900,		0x7C00,		0x7700,		0x6F00,		0x7F00,		0x0700, 0x7D00,		0x6D00,		0x6600, 	0x4F00,		0x5B00,		0x0600, 0x3F00     	
DISPLAY_11 DCD 		0x7100,		0x17100,	0x15600,	0x13100,	0x17400,	0x7700,		0x16700,	0x17700,	0x0700,	0x17500,	0x16500,	0x6600,		0x14700,	0x15300,	0x0600,	0x13700
DISPLAY_11_14 DCD	0x23100,	0x33100,	0x31600,	0x13100,	0x33400,	0x23700,	0x32700,	0x33700,	0x0700, 0x33500,	0x32500,	0x22600,	0x30700,	0x31300,	0x0600,	0x13700	
	EXPORT	start
start

IO0DIR	EQU	0xE0028008
IO0SET	EQU	0xE0028004
IO0CLR	EQU	0xE002800C

	ldr	r1,=IO0DIR
	;ldr r2, =0xff00	; select P0.08--P.0.15
	;ldr	r2,=0x0001f700	;select P0.08--P0.10 U P0.12--P0.16  P0.11 is skipped because it has dimmer light.
	ldr r2, =0x3b700	;select P0.08--P0.10 U P0.12--P0.13 U P0.15--P.017, P0.11 and P0.14 are skipped because the light is dimmer.
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO0SET
	str	r2,[r1]		;turn all the lights
	ldr	r2,=IO0CLR
	ldr	r3,=0x3f700
	str	r3,[r2]		;clear all the lights
	ldr r4,=DISPLAY_11_14
; r1 points to the SET register
; r2 points to the CLEAR register


wloop	ldr r5,=0		; offset
floop	
	ldr r3, [r4, r5]	; load bit pattern
	str	r3,[r1]			; set bit to 1 ---> turn off the LED
	
	ldr r6,=10000000
dloop	sub r6,r6,#1
	cmp r6, #0
	bne dloop

	str	r3,[r2]	   	; set bit to 1 ---> turn on the LED
	add r5,r5,#4
	cmp r5, #60
	bhi wloop
	b floop

stop	B	stop
	END