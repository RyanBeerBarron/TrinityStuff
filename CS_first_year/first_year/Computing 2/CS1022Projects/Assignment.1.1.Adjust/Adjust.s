	AREA	Adjust, CODE, READONLY
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
	MOV	R6, R0
	MUL R5, R6, R5
	MOV R5, R5, LSL #2	; R5 = maximum offset
	MOV R6, #0			; R6 = offset
loop					; while(offset<=maximum offset)
	CMP R6, R5			; {
	BHS endLoop			;
	LDR R7, [R4, R6]	; pixel = load from starting address + offset
	MOV R0, R7			;
	BL getColours		; getColours(pixel) 
	BL changeColours	; changeColours(green, blue, red)
	MOV R7, R0			; R7 = new pixel
	STR R7, [R4, R6]	; store in starting address + offset = new pixel
	ADD R6, R6, #4		; offset += 4
	B loop				; }
endLoop					;
	
	BL	putPic		; re-display the updated image
	B stop
	
	
	
;getColours subroutine
;Takes a word size RGB-pixel and seperate the three color with a mask and the AND operation
;parameter r0:pixel value
;return r1:green value
;		r2:blue value
;		r3:red value
getColours
	STMFD sp!, {R4, lr}
	MOV R4, #0x000000FF
	AND R1, R0, R4			;green
	MOV R0, R0, LSR #8			
	AND R2, R0, R4			;blue
	MOV R0, R0, LSR #8
	AND R3, R0, R4			;red
	LDMFD sp!, {R4, PC}
	
	
	
	
;changeColours subroutine
;Takes the seperated RGB values of a pixel and changes the contrast and brightness
;and combines them back into a single word size RGB-pixel
;parameters r1:green value
;			r2:blue value
;			r3:red value
;return		r0:new RGB-pixel
changeColours	
	STMFD sp!, {lr, R5-R7}
	BIC R0, #0xFFFFFFFF		; clear bits from return pixel
	MOV R5, #40				; contrast
	MOV R6, #0				; brightness
	MOV R7, #0				; pixel counter = 0
changeColoursLoop			;
	CMP R7, #3				; while(pixel counter<3)
	BGE endChangeColoursLoop; {
	MOV R0, R0, LSL #8		; shifts to the left the return pixel by 2 hexadecimal digit
	MUL R3, R5, R3			; multiply the colour by contrast
	MOV R3, R3, LSR #4		; divide colour by 16
	ADD R3, R3, R6			; add the brightness to the colour
	CMP R3, #0x000000FF		; 
	BLE else1				; if(color>255)	
	MOV R3, #0x000000FF		;	color = 255
	B else2					
else1									
	CMP R3, #0				
	BGE else2			; if(color<0)
	MOV R3, #0			;	color = 0
else2						
	ADD R0, R0, R3		; return pixel += colour
	ADD R7, R7, #1		; pixel counter++
	MOV R3, R2			; red = blue
	MOV R2, R1			; blue = green
	B changeColoursLoop	; }
endChangeColoursLoop	
	LDMFD sp!, {R5-R7, PC}	
stop	B	stop


	END	