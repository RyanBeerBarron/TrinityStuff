; Definitions  -- references to 'UM' are to the User Manual.

; Timer Stuff -- UM, Table 173

T0	equ	0xE0004000		; Timer 0 Base Address
T1	equ	0xE0008000

IR	equ	0			; Add this to a timer's base address to get actual register address
TCR	equ	4
MCR	equ	0x14
MR0	equ	0x18

TimerCommandReset	equ	2
TimerCommandRun	equ	1
TimerModeResetAndInterrupt	equ	3
TimerResetTimer0Interrupt	equ	1
TimerResetAllInterrupts	equ	0xFF

; VIC Stuff -- UM, Table 41
VIC	equ	0xFFFFF000		; VIC Base Address
IntEnable	equ	0x10
VectAddr	equ	0x30
VectAddr0	equ	0x100
VectCtrl0	equ	0x200

Timer0ChannelNumber	equ	4	; UM, Table 63
Timer0Mask	equ	1<<Timer0ChannelNumber	; UM, Table 63
IRQslot_en	equ	5		; UM, Table 58

IO1DIR	EQU	0xE0028018
IO1SET	EQU	0xE0028014
IO1CLR	EQU	0xE002801C
IO1PIN	EQU	0xE0028010

	AREA	InitialisationAndMain, CODE, READONLY
	IMPORT	main

; (c) Mike Brady, 2014–2016.

	EXPORT	start
start
; initialisation code
	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr r2, =0x80000
	ldr r1, =IO1CLR
	str r2, [r1]
	ldr r1, =currentLED
	str r2, [r1]
	
; Initialise the VIC
	ldr	r0,=VIC			; looking at you, VIC!

	ldr	r1,=irqhan
	str	r1,[r0,#VectAddr0] 	; associate our interrupt handler with Vectored Interrupt 0

	mov	r1,#Timer0ChannelNumber+(1<<IRQslot_en)
	str	r1,[r0,#VectCtrl0] 	; make Timer 0 interrupts the source of Vectored Interrupt 0

	mov	r1,#Timer0Mask
	str	r1,[r0,#IntEnable]	; enable Timer 0 interrupts to be recognised by the VIC

	mov	r1,#0
	str	r1,[r0,#VectAddr]   	; remove any pending interrupt (may not be needed)

; Initialise Timer 0
	ldr	r0,=T0			; looking at you, Timer 0!

	mov	r1,#TimerCommandReset
	str	r1,[r0,#TCR]

	mov	r1,#TimerResetAllInterrupts
	str	r1,[r0,#IR]

	ldr	r1,=73727				;(14745600/200)-1, 5 ms = 1/200 second
	str	r1,[r0,#MR0]

	mov	r1,#TimerModeResetAndInterrupt
	str	r1,[r0,#MCR]

	mov	r1,#TimerCommandRun
	str	r1,[r0,#TCR]

;from here, initialisation is finished, so it should be the main body of the main program


	ldr r10, =IfInterrupt
wloop	
	ldr r2, [r10]
	cmp r2, #1
	bne wloop
	
	
	mov r2, #0
	str r2, [r10]
	
	LDR R0, =msCount
	LDR R4, [R0]
	CMP R4, #200
	BLT updateCount
	ldr r1,=IO1SET
	ldr	r2,=IO1CLR
	
	ldr	r5,=currentLED
	ldr r3, [r5]
	str r3, [r1]
	mov r3, r3, lsr #1
	CMP R3, #0x00008000
	BNE not
	LDR R3,=0x00080000
not
	str r3, [r2]
	str r3, [r5]
	LDR R4, =0
	STR R4, [R0]
	B wloop
updateCount
	ADD R4, R4, #1
	STR R4, [R0]
	
	b	wloop  		; branch always
;main program execution will never drop below the statement above.

	AREA	InterruptStuff, CODE, READONLY
irqhan	sub	lr,lr,#4
	stmfd	sp!,{r0-r10,lr}	; the lr will be restored to the pc

;this is the body of the interrupt handler

;here you'd put the unique part of your interrupt handler
;all the other stuff is "housekeeping" to save registers and acknowledge interrupts


;this is where we stop the timer from making the interrupt request to the VIC
;i.e. we 'acknowledge' the interrupt
	ldr	r0,=T0
	mov	r1,#TimerResetTimer0Interrupt
	str	r1,[r0,#IR]	   	; remove MR0 interrupt request from timer

;here we stop the VIC from making the interrupt request to the CPU:
	ldr	r0,=VIC
	mov	r1,#0
	str	r1,[r0,#VectAddr]	; reset VIC
	
;here we set up the variable so that the main call the subroutine we want	
	ldr r0, =IfInterrupt
	mov r1, #1
	str r1, [r0]
	
	
	ldmfd	sp!,{r0-r10,pc}^	; return from interrupt, restoring pc from lr
				; and also restoring the CPSR

	AREA	Subroutines, CODE, READONLY

	AREA	Stuff, DATA, READWRITE

IfInterrupt DCD 0x0
msCount DCB 0
currentLED DCD 0x00080000

	END