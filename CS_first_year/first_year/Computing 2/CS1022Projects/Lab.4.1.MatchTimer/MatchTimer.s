	AREA	MatchTimer, CODE, READONLY
	IMPORT	main
	EXPORT	start

;
; Memory-mapped device registers
;
VICIntSelect	EQU	0xFFFFF00C
VICIntEnable	EQU	0xFFFFF010
VICVectAddr0	EQU	0xFFFFF100

VICVectPri0		EQU	0xFFFFF200
VICVectAddr		EQU	0xFFFFFF00

PINSEL1			EQU	0xE002C004
	
PINSEL4			EQU	0xE002C010
EXTINT			EQU	0xE01FC140
EXTMODE			EQU	0xE01FC148
EXTPOLAR		EQU	0xE01FC14C

T0TCR			EQU	0xE0004004
T0CTCR			EQU	0xE0004070
T0MR0			EQU	0xE0004018
T0MCR			EQU	0xE0004014
T0PR			EQU	0xE000400C
T0IR			EQU	0xE0004000

T1TCR			EQU	0xE0008004
T1CTCR			EQU	0xE0008070
T1MR0			EQU	0xE0008018
T1MR1 			EQU 0xE000801C
T1MCR			EQU	0xE0008014
T1PR			EQU	0xE000800C
T1IR			EQU	0xE0008000

DACR			EQU	0xE006C000


;
; A value between 0 and 1023 representing the volume
;
volume 		EQU 	1023


start

	;
	; Configure P2.10 for EINT0 functionality
	; (i.e. a rising/falling edge on P2.10 will
	; raise an interrupt (EINT0 interrupt)
	;
	
	
	MOV R0, #0
	LDR R1,=count
	STR R0,[R1]

	; Enable P2.10 for EINT0
	LDR	R5, =PINSEL4
	LDR	R6, [R5]	
	BIC	R6, #(0x03 << 20)
	ORR	R6, #(0x01 << 20)
	STR	R6, [R5]
	
	; Set edge-sensitive mode for EINT0 (rather than level sensitive)
	LDR	R5, =EXTMODE
	LDR	R6, [R5]
	ORR	R6, #1
	STRB	R6, [R5]
	
	; Set rising-edge mode for EINT0
	; (initially rising-edge sensitivity to detect button down)
	LDR	R5, =EXTPOLAR
	LDR	R6, [R5]
	BIC	R6, #1
	STRB	R6, [R5]
	
	; Reset EINT0
	LDR	R5, =EXTINT
	MOV	R6, #1
	STRB	R6, [R5]


	;
	; Configure TIMER1 for 1 second interrupts
	;
	
	; Stop and reset TIMER0 using Timer Control Register
	; Set bit 0 of TCR to 0 to diasble TIMER
	; Set bit 1 of TCR to 1 to reset TIMER
	LDR	R5, =T1TCR
	LDR	R6, =0x2
	STRB	R6, [R5]

	; Clear any previous TIMER0 interrupt by writing 0xFF to the TIMER0
	; Interrupt Register (T0IR)
	LDR	R5, =T1IR
	LDR	R6, =0xFF
	STRB	R6, [R5]

	; Set timer mode using Count Timer Control Register
	; Set bits 0 and 1 of CTCR to 00
	; for timer mode
	LDR	R5, =T1CTCR
	LDR	R6, =0x00
	STRB	R6, [R5]

	
	; Set match register for 40 mins using match register
	; (Set match register for 4 sec for testing)
	; Assuming a 12Mhz clock
	LDR	R5, =T1MR0
	LDR	R6, =48000000
	STR	R6, [R5]



	; Interrupt and restart on match using Match Control Register
	; Set bit 0 of MCR to 1 to turn on interrupts
	; Set bit 1 of MCR to 1 to reset counter to 0 after every match
	; Set bit 2 of MCR to 0 to leave the counter enabled after match
	LDR	R5, =T1MCR
	LDR	R6, =0x01
	STRH	R6, [R5]

	; Turn off prescaling using Prescale Register
	; (prescaling is only needed to measure long intervals)
	LDR	R5, =T1PR
	LDR	R6, =0
	STR	R6, [R5]



	
	;
	; Configure VIC for pushbutton
	;

	; Just some useful values
	MOV	R3, #14			; vector = 14; (EINT0 VIC vector)
	MOV	R4, #1			; vmask = 1;
	MOV	R4, R4, LSL R3		; vmask = vmask << vector;
	
	; VICIntSelect - Set Vector 0x14 for IRQ (not FIQ) (clear bit 14)
	LDR	R5, =VICIntSelect	; addr = VICIntSelect;
	LDR	R6, [R5]		; tmp = Memory.Word(addr);		
	BIC	R6, R6, R4		; Clear bit for Vector 0x14
	STR	R6, [R5]		; Memory.Word(addr) = tmp;
	
	; Set Priority to lowest (15)
	LDR	R5, =VICVectPri0	; addr = VICVectPri0;
	MOV	R6, #0xF		; pri = 15;
	STR	R6, [R5, R3, LSL #2]	; Memory.Word(addr + vector * 4) = pri;
	
	; Set handler address
	LDR	R5, =VICVectAddr0	; addr = VICVectAddr0;
	LDR	R6, =ButtonHandler	; handler = address of ButtonHandler;
	STR	R6, [R5, R3, LSL #2]	; Memory.Word(addr + vector * 4) = handler

	; VICIntEnable
	LDR	R5, =VICIntEnable	; addr = VICVectEnable;
	STR	R4, [R5]		; enable interrupts for vector 0x14
	
	
	;
	; Configure TIMER0 to generate frequency for middle C
	;
	
	; Stop and reset TIMER0
	LDR	R5, =T0TCR
	LDR	R6, =0x2
	STRB	R6, [R5]

	; Set timer mode
	LDR	R5, =T0CTCR
	LDR	R6, =0x00
	STRB	R6, [R5]

	; Set match register for 1 sec
	LDR	R5, =T0MR0
	LDR	R6, =22934 ;  12MHz / (261.626Hz * 2)
	STR	R6, [R5]
	

	; Configure to interrupt and restart on match
	LDR	R5, =T0MCR
	LDR	R6, =0x03
	STRH	R6, [R5]

	; Set prescale = 1 (no prescaling)
	LDR	R5, =T0PR
	LDR	R6, =0		; Set to (wanted prescale - 1)
	STR	R6, [R5]	
	
	; NOTE: We won't start TIMER0 until the button is pressed down!!
	;       (See ButtonHandler)
	
	
	;
	; Configure VIC for TIMER0
	;
	
	; Just some useful values
	LDR	R3, =4			; vector 4
	LDR	R4, =1			;
	MOV	R4, R4, LSL R3 		; vector mask
	
	; VICIntSelect - Set Vector 0x04 for IRQ (clear bit 4)
	LDR	R5, =VICIntSelect	; addr = VICVectSelect;
	LDR	R6, [R5]		; tmp = Memory.Word(addr);		
	BIC	R6, R6, R4		; Clear bit for Vector 0x04
	STR	R6, [R5]		; Memory.Word(addr) = tmp;
	
	; Set Priority to lowest (15)
	LDR	R5, =VICVectPri0	; addr = VICVectPri0;
	MOV	R6, #0xF		; pri = 15;
	STR	R6, [R5, R3, LSL #2]	; Memory.Word(addr + vector * 4); = pri;
	
	; Set handler address
	LDR	R5, =VICVectAddr0	; addr = VICVectAddr0;
	LDR	R6, =TimerBuzzHandler	; handler = address of TimerBuzzHandler;
	STR	R6, [R5, R3, LSL #2]	; Memory.Word(addr + vector * 4) = handler

	; VICIntEnable
	LDR	R5, =VICIntEnable	; addr = VICIntEnable;
	STR	R4, [R5]		; enable Timers for vector 0x4
	
	
	
	;
	; Configure VIC for TIMER1 interrupts
	;

	; Useful VIC vector numbers and masks for following code
	LDR	R3, =5			; vector 5
	LDR	R4, =(1 << 5) 	; bit mask for vector 5
	
	; VICIntSelect - Clear bit 5 of VICIntSelect register to cause
	; channel 5 (TIMER1) to raise IRQs (not FIQs)
	LDR	R5, =VICIntSelect	; addr = VICVectSelect;
	LDR	R6, [R5]		; tmp = Memory.Word(addr);		
	BIC	R6, R6, R4		; Clear bit for Vector 0x05
	STR	R6, [R5]		; Memory.Word(addr) = tmp;
	
	; Set Priority for VIC channel 5 (TIMER1) to lowest (15) by setting
	; VICVectPri4 to 15. Note: VICVectPri4 is the element at index 4 of an
	; array of 4-byte values that starts at VICVectPri0.
	; i.e. VICVectPri4=VICVectPri0+(4*4)
	LDR	R5, =VICVectPri0	; addr = VICVectPri0;
	MOV	R6, #15			; pri = 15;
	STR	R6, [R5, R3, LSL #2]	; Memory.Word(addr + vector * 4); = pri;
	
	; Set Handler routine address for VIC channel 5 (TIMER1) to address of
	; our handler routine (TimerHandler). Note: VICVectAddr4 is the element
	; at index 4 of an array of 4-byte values that starts at VICVectAddr0.
	; i.e. VICVectAddr4=VICVectAddr0+(4*4)
	LDR	R5, =VICVectAddr0	; addr = VICVectAddr1;
	LDR	R6, =TimerHandler	; handler = address of TimerHandler;
	STR	R6, [R5, R3, LSL #2]	; Memory.Word(addr + vector * 4) = handler

	
	; Enable VIC channel 5 (TIMER0) by writing a 1 to bit 5 of VICIntEnable
	LDR	R5, =VICIntEnable	; addr = VICIntEnable;
	STR	R4, [R5]		; enable Timers for vector 0x5
	

	
	;
	; Configure DAC	(Digital to Audio Converter)
	;

	; Configure pin P0.26 for AOUT (DAC analog out)
	LDR	R5, =PINSEL1
	LDR	R6, [R5]
	BIC	R6, R6, #(0x03 << 20)
	ORR	R6, R6, #(0x02 << 20)
	STR	R6, [R5]

	; DAC is always on so no further configuration required


	;
	; Infinite loop
	;
	LDR R11,=count	
	MOV R10, #0
	STR R10, [R11]
	LDR R11,=delay
	STR R10, [R11]
	
stop	B	stop


TimerHandler
	SUB	LR, LR, #4		
	STMFD	sp!, {r0-r12, LR}
	LDR	R5, =T1IR
	MOV	R6, #0xFF
	STRB	R6, [R5]		; Reset TIMER1 interrupt by writing 0xFF to T1IR
	LDR R5, =T1TCR
	LDR	R6, =0x2
	STRB	R6, [R5]
	LDR	R5, =T1MR0
	LDR	R6, =24000000		; 2 second buzzer
	STR	R6, [R5]
	LDR	R5, =T0TCR
	LDR R6, [R5]
	LDR R5, =0x01
	CMP R5, R6
	BEQ noBuzz

	;
	; Start TIMER0 (starts sound)
	;

	LDR	R5, =T0TCR
	LDR	R6, =0x01
	STRB	R6, [R5]
	
	LDR R10, =count
	LDR R11, =1
	STR R11, [R10]
	
	B dobuzz
	
noBuzz

	;;
	;; Stop TIMER0 (stops sound)
	;;

	LDR	R5, =T0TCR
	LDR	R6, =0x0
	STRB	R6, [R5]
	
	;Stop timer
	LDR	R5, =T1TCR
	LDR	R6, =0x0
	STRB	R6, [R5]
	B endTimerHandler
dobuzz

	LDR	R5, =T1TCR
	LDR	R6, =0x01
	STRB	R6, [R5]

endTimerHandler	
	; Clear source of interrupt by writing 0 to VICVectAddr
	LDR	R5, =VICVectAddr
	MOV	R6, #0		
	STR	R6, [R5]	
	
	; Return
	LDMFD	sp!, {r0-r12, PC}^	; restore register and CPSR	

	
	
	

;
;  Button Handler
;
ButtonHandler

	SUB	LR, LR, #4		; Adjust return address
	STMFD	sp!, {r0-r12, LR}	; save registers
	
	
	
	;
	; Reset EINT0
	;
	LDR	R5, =EXTINT
	MOV	R6, #1
	STRB	R6, [R5]
	
	; Invert edge-sensitivity (rising/falling) mode for EINT0
	LDR	R5, =EXTPOLAR
	LDR	R6, [R5]
	EOR	R6, #1
	STRB	R6, [R5]
	
	
	;
	; Examing polarity to determine if we should start or stop timer
	;
	EOR R6, #1
	CMP R6, #0
	BEQ	endPause
	
	LDR	R10, =T1TCR
	LDR R9, [R10]
	CMP R9, #0x01
	BEQ pause
	
	; Start TIMER1 using the Timer Control Register
	; Set bit 0 of TCR to enable the timer
	LDR	R5, =T1TCR
	LDR	R6, =0x01
	STRB R6, [R5]
	
	B endPause
pause
	
	LDR	R5, =T1TCR
	LDR	R6, =0x0
	STRB R6, [R5]	
	
	LDR R11,=count
	LDR R10, =0x0
	STR R10, [R11]

	
endPause

	LDR	R3, =VICVectAddr	; addr = VICVectAddr
	MOV	R4, #0			; tmp = 0;
	STR	R4, [R3]		; Memory.Word(addr) = tmp;

	LDMFD	sp!, {r0-r12, PC}^	; restore register and CPSR



;
; Timer buzz interrupt handler
;
TimerBuzzHandler

	SUB	LR, LR, #4		; Adjust return address
	STMFD	sp!, {r0-r12, LR}	; save registers
	LDR	R5, =T0IR
	MOV	R6, #0xFF		;Reset TIMER0 interrupt by writing 0xFF to T0IR
	STRB R6, [R5]
	
	; Change analog output to cause square wave signal
	; If signal is currently high, send it low. If its low, send it high
	;

	LDR	R5, =DACR
	LDR	R6, [R5]
	
	LDR	R7, =0x0000FFC0
	AND	R6, R6, R7
	
	CMP	R6, #0			; if (DACR == 0)
	BNE	high			; {
	LDR	R6, =(volume << 6)	;  DACR = volume << 6
	B	endif			; }
high					; else {
	LDR	R6, =0			;  DACR = 0
endif					; }
	STR	R6, [R5]		; store new DACR

quitBuzzer	
	LDR	R5, =VICVectAddr
	MOV	R6, #0		
	STR	R6, [R5]	
	LDMFD	sp!, {r0-r12, PC}^	; restore register and CPSR
	
	
	AREA	TestData, DATA, READWRITE
	
count	SPACE	4
delay	SPACE	4
	

	END