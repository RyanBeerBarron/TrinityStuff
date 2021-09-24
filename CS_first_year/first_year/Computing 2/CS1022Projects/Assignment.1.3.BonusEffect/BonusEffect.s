	AREA	BonusEffect, CODE, READONLY
	IMPORT	main
	IMPORT	getPicAddr
	IMPORT	putPic
	IMPORT	getPicWidth
	IMPORT	getPicHeight
	EXPORT	start
	PRESERVE8
start				; This program applies a 3x3 convolution matrix to each pixel to produce different type of effects
					; depending on the coefficents in the matrix.
					; for example, the coefficient could be as follow:
					; -1	-1	-1
					; -1	9	-1
					; -1	-1	-1
								
	BL	getPicAddr		; load the start address of the image in R4
	MOV	R4, R0
	BL	getPicHeight	; load the height of the image (rows) in R5
	MOV	R5, R0					; height
	BL	getPicWidth		; load the width of the image (columns) in R6
	MOV	R6, R0			; width
	LDR R7, =0			; row
	LDR R8, =0			; column
rowLoop
	CMP R7, R5			; while(row <= height)
	BHI endRowLoop		; {
columnLoop
	CMP R8, R6			; while (column <= width)
	BHI endColumnLoop	; {
	CMP R7, #0			
	BLE notThisPixel
	CMP R8, #0
	BLE notThisPixel
	CMP R7, #0x97
	BGE notThisPixel
	CMP R8, #0x78
	BGE notThisPixel			; if (column>0 && column<width && row>0 && row<heigtht) //if the pixel is not on the edge
	MOV R9, R8, LSL #2			; column offset memory = column * 4
	MUL R10, R7, R6				; 
	MOV R10, R10, LSL #2		; row offset memory = row * width * 4
	ADD R11, R4, R10			; 
	ADD R11, R11, R9			; pixel address = starting address + row offset + column offset
	LDR R10, =0					; pixel counter=0
	MOV R0, R11					; 
	MOV R1, R10					;
	BL pixelNeighborhood		; pixelNeighborhood(pixel address, pixel counter)
	
	STR R3, [R11]				; store new pixel value in pixel address
notThisPixel					;
	ADD R8, R8, #1				; column++
	B columnLoop				; }
endColumnLoop					;
	LDR R8, =0					; column = 0
	ADD R7, R7, #1				; row++
	B rowLoop					; }
endRowLoop

	BL	putPic		; re-display the updated image

	B stop
	
	
; parameter R0:pixel address R1:divisor
; return R0:pixel address R1:divisor R2:new pixel value	
pixelNeighborhood
	STMFD sp!, {lr, R4-R11}		; push EVERYTHING
	MOV R11, #0			; blue
	MOV R10, #0			; green
	MOV R9, #0			; red
	MOV R8, #-1			;coefficent
	MOV R4, R0			;pixel address
	MOV R5, R6, LSL #2	;row offset
	MOV R6, R1			;divisor // pixel counter
	SUB R4, R4, R5		; 
	ADD R4, R4, #-4		;pixel address = first pixel in the matrix
pnLoop	
	CMP R6, #9			;while(pixel counter < 9)
	BHS pnEndLoop		; {	
	ADD R6, R6, #1		;	pixel counter++
	MOV R0, R6			;	
	BL coefficient		;	coefficient(pixel counter)
	MOV R8, R1			;	
	LDR R0, [R4]		;	pixel = word size RGB-pixel in pixel address
	BL getColours		;	getColours(pixel)
	MUL R1, R8, r1		;
	MUL R2, R8, R2		;
	MUL R3, R8, R3		;
	ADD R11, R11, R1	;	blue total
	ADD R10, R10, R2	;	green total
	ADD R9, R9, R3		;	red total
	MOV R0, R6			;
	MOV R1, R4			;
	MOV R2, R5			;
	BL getNextAddress	;	getNextAddress(pixel counter, pixel address, row offset)
	MOV R4, R1			;	pixel address = new pixel address
	B pnLoop			; }
pnEndLoop				;
	MOV R8, #0			;colour counter
	LDR R3, =0			;
ColourLoop				
	CMP R8, #3			;
	BHS endColourLoop
	mov r3, r3, lsl #8
	cmp r9, #0xff
	blt lowerThan0xff
	mov r9, #0xff
	b higherThanZero
lowerThan0xff
	cmp r9, #0
	bge higherThanZero
	mov r9, #0
	b higherThanZero
higherThanZero	
	ADD R3, r3, r9
	mov r9, r10
	mov r10, r11
	add r8, r8, #1
	b ColourLoop
endColourLoop	
	MOV R0, R4
	LDMFD sp!, {R4-R11, PC}

;getNextAddress
;Takes which pixel in the matrix we're holding and return the address in memory for the next pixel
;parameter 	R0:pixel counter
;			R2:row offset
;return 	R1:next address
getNextAddress
	STMFD sp!, {lr}
	CMP R0, #3			; if((pixel counter>0 && <3) || (pixel counter>3 && <6) || (pixel counter>6 && <9)) 
	BLO pnIf1
	CMP R0, #4
	BLO pnOr1
	CMP R0, #6
	BLO pnIf1
pnOr1
	CMP R0, #7
	BLO pnElse1
	CMP R0, #9
	BHS pnElse1 
pnIf1
	ADD R1, R1, #4		;		 return (address = address +4)		
	B pnEndIf
pnElse1
	CMP R0, #3			; if (pixel counter==3)||(pixel counter==6)
	BEQ pnIf2		
	CMP R0, #6
	BEQ pnIf2
	CMP R0, #9
	BEQ pnIf3
pnIf2
	ADD R1, R1, R2
	SUB R1, R1, #8		;		return (address = address + row offset - 8)
	B pnEndIf
pnIf3					; else
	SUB R1, R1, R2		;	
	SUB R1, R1, #4		;		return (address = address - rowoffset - 4)
pnEndIf
	LDMFD sp!, {PC}
	


;coefficient subroutine
;Takes which pixel in matrix we're holding and return its corresponding coefficient in the convulution matrix
;parameter R0:pixel counter
;return R1:coefficient
coefficient
	STMFD sp!, {lr}
	CMP R0, #1
	BNE coefficient1
	LDR R1, =-1				; coefficient for the pixel 1,1 in the matrix
	B return				
coefficient1
	CMP R0, #2
	BNE coefficient2
	LDR R1, =-1				; coefficient for the pixel 1,2 in the matrix
	B return
coefficient2
	CMP R0, #3
	BNE coefficient3
	LDR R1, =-1				; coefficient for the pixel 1,3 in the matrix
	B return
coefficient3
	CMP R0, #4
	BNE coefficient4
	LDR R1, =-1				; coefficient for the pixel 2,1 in the matrix
	B return
coefficient4
	CMP R0, #5
	BNE coefficient5
	LDR R1, =9				; coefficient for the pixel 2,2 in the matrix
	B return
coefficient5
	CMP R0, #6
	BNE coefficient6
	LDR R1, =-1				; coefficient for the pixel 2,3 in the matrix
	B return
coefficient6
	CMP R0, #7
	BNE coefficient7
	LDR R1, =-1				; coefficient for the pixel 3,1 in the matrix
	B return
coefficient7
	CMP R0, #8
	BNE coefficient8
	LDR R1, =-1				; coefficient for the pixel 3,2 in the matrix
	B return
coefficient8
	CMP R0, #9
	BNE return
	LDR R1, =-1				; coefficient for the pixel 3,3 in the matrix
return
	LDMFD sp!, {PC}

;getColours subroutine
;Takes a word size RGB-pixel and seperate the three color with a mask and the AND operation
;parameter r0:pixel value
;return r1:blue value
;		r2:green value
;		r3:red value
getColours
	STMFD sp!, {R4, lr}
	MOV R4, #0x000000FF
	AND R1, R0, R4			;blue
	MOV R0, R0, LSR #8
	AND R2, R0, R4			;green
	MOV R0, R0, LSR #8
	AND R3, R0, R4			;red
	LDMFD sp!, {R4, PC}
stop	B	stop
	END	