	AREA	MotionBlur, CODE, READONLY
	IMPORT	main
	IMPORT	getPicAddr
	IMPORT	putPic
	IMPORT	getPicWidth
	IMPORT	getPicHeight
	EXPORT	start
	PRESERVE8
start

	BL	getPicAddr	; load the start address of the image in R4
	MOV	R4, R0
	BL	getPicHeight	; load the height of the image (rows) in R5
	MOV	R5, R0
	BL	getPicWidth	; load the width of the image (columns) in R6
	BL putPic
	MOV	R6, R0
	ADD R11, R6, #1
	MOV R11, R11, LSL #2	; diagonal offset ((width+1)*4)
	MUL R5, R6, R5		
	MOV R5, R5, LSL #2		; maximum offset 
	MOV R6, #0				; offset
	MOV R10, #5				; radius
loop	
	CMP R6, R5			; while (offset<=maximum offset) //main loop	
	BGT endLoop			; {
	LDR R9, =0			; pixel counter = 0
	ADD R7, R4, R6		; pixel address = starting address + offset
	MUL R0, R10, R11	; R0 = radius*diagonale offset
	ADD R7, R7, R0		; last pixel in the diagonal = pixel address + R0
	ADD R0, R4, R5		; last pixel address = starting address + maximum offset
while2					; 
	CMP R7, R0			; while ( last pixel in the diagonale address < last pixel address )
	BLS else2			; {
	SUB R7, R7, R11		;	last pixel in the diagonale address = last pixel in the diagonale address - diagonale offset
	ADD R9, R9, #1		;	pixel counter++
	B while2			; }
else2					;
	ADD R7, R4, R6		; pixel address
	MUL R0, R10, R11	; radius*diagonale offset
	SUB R7, R7, R0		; first pixel in the diagonale = pixel address - radius*diagonale offset
while1					; 
	CMP R7, R4			; while ( first pixel in the diagonale > first pixel address )
	BHS else1			; {
	ADD R7, R7, R11		; 	first pixel in the diagonale =first pixel in the diagonale + diagonale offset
	ADD R9, R9, #1		; 	pixel count++ diagonale
	B while1			; }
else1					
	LDR R8, =1			; divisor = 1
	STMFD sp!, {R4-R6} 	; push starting address, maximum offset and offset on stack
	LDR R4, =0
	LDR R5, =0
	LDR R6, =0
loop2	
	ADD R0, R10, R10	 
	ADD R0, R0, #1		; number of pixel in diagonale blur = radius + radius + 1
	STMFD sp!, {R10}	; push radius on stack
	CMP R9, R0			; while ( pixel counter < number of pixel in diagonale ) 
	BHS endLoop2	 	; {
	LDR R4, =0			
	LDR R10, =0
	LDR R10, [R7]		; pixel = load pixel from diagonale pixel address
	MOV R0, R10			
	BL getColours		; getColours(pixel)
	ADD R7, R7, R11		; pixel address = pixel address + diagonale offset
	ADD R9, R9, #1		; pixel counter++
	ADD R8, R8, #1		; divisor++
	ADD R6, R6, R1		; green total
	ADD R5, R5, R2		; blue total 
	ADD R4, R4, R3		; red total
	LDMFD sp!, {R10}	; pop radius from stack
	B loop2				; }
endLoop2
	LDR R10, =0			; colour counter = 0
	LDR R7, =0			; new pixel value
loop3					
	CMP R10, #3			; while (pixel counter < 3)
	BHS endLoop3		; {
	MOV R7, R7, LSL #8	;	shift pixel value to the left by 2 hexadecimal digit
	MOV R0, R4			
	MOV R1, R8
	BL divide			;	divide(colour total, divisor)
	ADD R7, R7, R2		;	pixel value = pixel value + new colour value	
	ADD R10, R10, #1	;	colour counter++
	MOV R4, R5			;	red total = blue total
	MOV R5, R6			;	blue total = green total
	B loop3				; }
endLoop3				;
	LDMFD sp!, {R10}	; load radius from stack 
	LDMFD sp!, {R4-R6}  ; load back starting address, maximum offset and offset from stack
	ADD R8, R4, R6		; original pixel address = starting address + offset
	STR R7, [R8]		; store new pixel value in its address
	ADD R6, R6, #4		; offset += 4
	B loop				; }
endLoop		
	BL	putPic		; re-display the updated image
	B stop
	
;divide subroutine
;Take a number and a divisor, returns the remainder and quotient of the division
;parameters R0: number to be divided
;			R1: divisor
;return R0: remainder
;		R1: divisor
;		R2: quotient
divide
	STMFD sp!, {lr}
	LDR R2, =0
subwhile
	CMP R0, R1
	BLT subendwhile
	SUB R0, R0, R1
	ADD R2, R2, #1
	B subwhile
subendwhile
	LDMFD sp!, {pc}	
	
;getColours subroutine
;Takes a word size RGB-pixel and seperate the three color with a mask and the AND operation
;parameter r0:pixel value
;return r1:blue value
;		r2:green value
;		r3:red value	
getColours
	STMFD sp!, {R4, lr}
	MOV R4, #0x000000FF
	AND R1, R0, R4		; blue
	MOV R0, R0, LSR #8
	AND R2, R0, R4		; green
	MOV R0, R0, LSR #8
	AND R3, R0, R4		; red
	LDMFD sp!, {R4, PC}
	
	
stop	B	stop
	END	