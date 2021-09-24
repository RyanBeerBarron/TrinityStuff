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
	
IO1PIN EQU 0xE0028010	
IO1DIR EQU 0xE0028018
IO1SET EQU 0xE0028014
IO1CLR EQU 0xE002801C
	
	
	ldr	r1,=IO0DIR
	;ldr r2, =0xff00	; select P0.08--P.0.15
	;ldr	r2,=0x0001f700	;select P0.08--P0.10 U P0.12--P0.16  P0.11 is skipped because it has dimmer light.
	ldr r2, =0x3b700	;select P0.08--P0.10 U P0.12--P0.13 U P0.15--P.017, P0.11 and P0.14 are skipped because the light is dimmer.
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO0SET
	str	r2,[r1]		;turn all the lights
	ldr	r2,=IO0CLR
	ldr	r3,=0x3b700
	str	r3,[r2]		;clear all the lights
	ldr r3, =IO1DIR
	ldr r4, =0x00000000		; select pin P1.20 -- P1.23 as input
	str r4, [r3]
	ldr r8, =IO1PIN
	ldr r4,=DISPLAY_11_14
; r1 points to the SET register
; r2 points to the CLEAR register


	ldr r5,=0		; offset
floop	
	ldr r3, [r4, r5]	; load bit pattern
	str	r3,[r1]			; set bit to 1 ---> turn off the LED
	
	
	ldr r6, =10000000
dloop	
	sub r6, r6, #1
	cmp r6, #0
	bne dloop
	
	
	ldr r7, [r8]
	and r7, r7, #0x00f00000
	eor r7, r7, #0x00f00000
	
	cmp r7, #0x00F00000
	beq increment
	cmp r7, #0x00700000
	beq increment
	cmp r7, #0x00E00000
	beq increment
	cmp r7, #0x00D00000
	beq increment
	cmp r7, #0x00B00000
	beq increment
	cmp r7, #0x00000000
	beq clearbit
	cmp r7, #0x00100000
	beq decrement
	cmp r7, #0x00200000
	beq decrement
	cmp r7, #0x00400000
	beq decrement
	cmp r7, #0x00800000
	beq decrement
	cmp r7, #0x00300000
	beq decrement
	cmp r7, #0x00500000
	beq decrement
	cmp r7, #0x00900000
	beq decrement
	cmp r7, #0x00600000
	beq decrement
	cmp r7, #0x00A00000
	beq decrement
	cmp r7, #0x00C00000
	beq decrement
	

	
	
	
decrement	
	add r5, r5, #4
	cmp r5, #60
	bls clearbit
	ldr r5, =0
	b clearbit
	
increment 
	sub r5, r5, #4
	cmp r5, #0
	bge clearbit
	ldr r5, =60
	
clearbit	
	str	r3,[r2]	   	; set bit to 1 ---> turn on the LED
	
	b floop

stop	B	stop
	END