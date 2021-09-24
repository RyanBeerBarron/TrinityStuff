	AREA	DisplayResult, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R6, =10			; constant = 10
	LDR R7, =0			; count = 0
	LDR R8, =0			; sum = 0
	LDR R9, =0x7FFFFFFF	; min = (2^31)-1 
	LDR R10, =0x80000000; max = -(2^31)
endspacebar
	LDR R4, =0			; number = 0
	LDR R11, =1			; positiveNumber = 1
read
	BL	getkey			; read key from console
	CMP	R0, #0x0D  		; while (key != CR)
	BEQ	endRead			; {
	BL	sendchar		;   echo key back to console
	CMP R0, #0x2D		;	if ( key == "-") 
	BNE positiveValue	;	{ 
	LDR R11, =0			;		positiveNumber = 0
	B read				;		get next key
positiveValue			;	}
	MOV R5, R0			;	singledigit = key
	CMP R5, #0x20		; 	if (singledigit != spacebar)
	BEQ spacebar		; 	{
	MUL R4, R6, R4		;		number = number * constant
	SUB R5, R5, #0x30	;		singledigit = singledigit - ASCII conversion
	ADD R4, R4, R5		;		number = number + singledigit
						;	} else break
	B read				; }
endRead					; if (key == CR )
	MOV R5, #0			; quotient = 0
	MOV R6, #0			; remainder = 0 
spacebar				;
	CMP R11, #0			; if ( positiveNumber == 0 )
	BNE notNegative		; {
	SUB R4, R11, R4		; 	number = 0 - number
notNegative				; }
	ADD R7, R7, #1		; count += 1	
	ADD R8, R8, R4		; sum += number
	CMP R4, R9			; if ( number < min )
	BGT notLower		; {
	MOV R9, R4			; 	min = number
notLower				; }
	CMP R4, R10			; if ( number > max )
	BLT notHigher		; {	
	MOV R10, R4			; 	max = number
notHigher				; }	
	CMP	R0, #0x0D  		; if (key == CR)
	BEQ	mean			;	stop reading, compute mean 
	B endspacebar		; else get next key
mean					;
	LDR R11, =1			; positiveNumber = 1
	SUB R4, R10, R9		; range = max - min
	MOV R6, R8			; remainder = quotient
	CMP R6, #0x80000000	; if ( remainder >= 2^31 )
	BLO while			; {
	LDR R11, =0			; 	positiveNumber = 0
	SUB R6, R11, R6		;	remainder = 0 - remainder
while					;} else
	CMP R7, R6			;while ( remainder >= count )
	BGT endwhile		;{
	SUB R6, R6, R7		;	remainder = remainder - count
	ADD R5, R5, #1		;	quotient = quotient + 1
	B while				;}
endwhile			
	
	MOV R0, #0x0A						; key = new line
	BL sendchar							; command next line
	MOV R0, #0x4D						; key = "M"
	BL sendchar							; print key
	MOV R0, #0x65						; key = "e"
	BL sendchar							; print key
	MOV R0, #0x61						; key = "a"
	BL sendchar							; print key
	MOV R0, #0x6E						; key = "n"
	BL sendchar							; print key
	MOV R0, #0x3D						; key = "="
	BL sendchar							; print key
	CMP R8, #0							; if sum < 0
	BGT positiveSum						; { 
	MOV R0, #0x2D						;	key = "-"
	BL sendchar							;	print key
positiveSum								; }
	LDR R11, =0							; leadingNumber = 0
	LDR R9, =0							; Most significant digit = 0
	LDR R8, =1000000000					; divider = 10^9, billion highest power of 10 register can represent.
	CMP R5, R8							; if ( quotient > divider )
	BLO lessThanBillion					; {
billionDivision							; 	while ( quotient > divider)
	CMP R5, R8							;	{ 				
	BLO endBillionDivision				;		
	SUB R5, R5, R8						;		quotient = quotient - divider
	ADD R9, R9, #1						;		Most significant digit += 1
	B billionDivision					;	}
endBillionDivision						;
	ADD R9, R9, #0x30					;	Most significant digit += ASCII character code
	MOV R0, R9							;	key = Most significant digit
	BL sendchar							;	print key
	MOV R11, #1							;  	leadingNumber = 1
lessThanBillion							; }
	LDR R8, =100000000					; divider = 10^8
	LDR R9, =0							; Most significant digit = 0
	CMP R5, R8							; if ( quotient > divider)
	BLO lessThanHundredMillion			; { 
hundredMillionDivision					;	while ( quotient > divider ) 	
	CMP R5, R8							;	{
	BLO endHundredMillionDivision		;	
	SUB R5, R5, R8						;		quotient = quotient - divider
	ADD R9, R9, #1						;		Most significant digit +=1
	B hundredMillionDivision			;	}
endHundredMillionDivision				;
	ADD R9, R9, #0x30					;	Most significant digit += ASCII character code
	MOV R0, R9							;	key = Most significant digit
	BL sendchar							;	print key
	MOV R11, #1							;	leadingNumber = 1
	B dontprintzero1					;	next division
lessThanHundredMillion					; }
	CMP R11, #1							; if leadingNumber = 1
	BNE dontprintzero1					;
	MOV R9, #0x30						; Most significant digit += "0" ASCII character code
	MOV R0, R9							; key = Most significant digit
	BL sendchar							; print key
dontprintzero1							;
	LDR R8, =10000000					; divider = 10^7
	LDR R9, =0							; Most significant digit = 0
	CMP R5, R8							; if ( quotient > divider )
	BLO lessThanTenMillion				; {	
tenMillionDivision						;	while ( quotient > divider )
	CMP R5, R8							;	 {
	BLO endTenMillionDivision			;		
	SUB R5, R5, R8						;		quotient = quotient - divider
	ADD R9, R9, #1						;		Most significant digit += 1
	B tenMillionDivision				;	 }
endTenMillionDivision					;	
	ADD R9, R9, #0x30					;	 Most significant digit += ASCII character code
	MOV R0, R9							;	 key = Most significant digit
	BL sendchar							;	 print key
	MOV R11, #1							;	 leadingNumber = 1
	B dontprintzero2					;	 next division
lessThanTenMillion						; }
	CMP R11, #1							;if leadingNumber = 1	
	BNE dontprintzero2	
	MOV R9, #0x30						;Most significant digit += "0" ASCII character code
	MOV R0, R9							;key = Most significant digit
	BL sendchar							;print key
dontprintzero2	
	LDR R8, =1000000					; divider = 10^6
	LDR R9, =0							; Most significant digit = 0
	CMP R5, R8							; if ( quotient > divider )
	BLO lessThanMillion					; {
millionDivision							;	while ( quotient > divider )
	CMP R5, R8							;	{
	BLO endMillionDivision				;	 	
	SUB R5, R5, R8						;		quotient = quotient - divider
	ADD R9, R9, #1						;		Most significant digit +=1
	B millionDivision					;	 }
endMillionDivision						;
	ADD R9, R9, #0x30					;	Most significant digit += ASCII character code
	MOV R0, R9							;	key = Most significant digit
	BL sendchar							;	print key
	MOV R11, #1
	B dontprintzero3
lessThanMillion							; }
	CMP R11, #1
	BNE dontprintzero3
	MOV R9, #0x30
	MOV R0, R9
	BL sendchar
dontprintzero3	
	LDR R8, =100000						; divider = 10^5
	LDR R9, =0							; Most significant digit = 0
	CMP R5, R8							; if ( quotient > divider )
	BLO lessThanHundredThousand			; {
hundredThousandDivision					;
	CMP R5, R8
	BLO endHundredThousandDivision
	SUB R5, R5, R8
	ADD R9, R9, #1
	B hundredThousandDivision
endHundredThousandDivision
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
	MOV R11, #1
	B dontprintzero4
lessThanHundredThousand
	CMP R11, #1
	BNE dontprintzero4
	MOV R9, #0x30
	MOV R0, R9
	BL sendchar
dontprintzero4	
	LDR R8, =10000
	LDR R9, =0
	CMP R5, R8
	BLO lessThanTenThousand
tenThousandDivision
	CMP R5, R8
	BLO endTenThousandDivision
	SUB R5, R5, R8
	ADD R9, R9, #1
	B tenThousandDivision
endTenThousandDivision
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
	MOV R11, #1
	B dontprintzero5
lessThanTenThousand
	CMP R11, #1
	BNE dontprintzero5
	MOV R9, #0x30
	MOV R0, R9
	BL sendchar
dontprintzero5	
	LDR R8, =1000
	LDR R9, =0
	CMP R5, R8
	BLO lessThanThousand
thousandDivision	
	CMP R5, R8
	BLO endThousandDivision
	SUB R5, R5, R8
	ADD R9, R9, #1
	B thousandDivision
endThousandDivision
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
	MOV R11, #1
	B dontprintzero6
lessThanThousand
	CMP R11, #1
	BNE dontprintzero6
	MOV R9, #0x30
	MOV R0, R9
	BL sendchar
dontprintzero6	
	LDR R8, =100
	LDR R9, =0
	CMP R5, R8
	BLO lessThanHundred
hundredDivision
	CMP R5, R8
	BLO endHundredDivision
	SUB R5, R5, R8
	ADD R9, R9, #1
	B hundredDivision
endHundredDivision
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
	MOV R11, #1
	B dontprintzero7
lessThanHundred
	CMP R11, #1
	BNE dontprintzero7
	MOV R9, #0x30
	MOV R0, R9
	BL sendchar
dontprintzero7	
	LDR R8, =10
	LDR R9, =0
	CMP R5, R8
	BLO lessThanTen
tenDivision
	CMP R5, R8
	BLO endTenDivision
	SUB R5, R5, R8
	ADD R9, R9, #1
	B tenDivision
endTenDivision
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
	CMP R11, #1
	B dontprintzero8
lessThanTen
	CMP R11, #1
	BNE dontprintzero8
	MOV R9, #0x30
	MOV R0, R9
	BL sendchar
dontprintzero8	
	MOV R9, R5
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
	CMP R6, #0
	BEQ noDecimal
	LDR R9, =0
	MOV R0, #0x2E
	BL sendchar
	LDR R11, =100
	MUL R6, R11, R6
decimalDivision
	CMP R6, R7
	BLO endDecimalDivision
	SUB R6, R6, R7
	ADD R9, R9, #1
	B decimalDivision
endDecimalDivision
	MOV R6, R9
	LDR R8, =100
	LDR R9, =0
	CMP R6, R8
	BLO lessThanThreeDecimal
threeDecimalDivision
	CMP R6, R8
	BLO endThreeDecimalDivision
	SUB R6, R6, R8
	ADD R9, R9, #1
	B threeDecimalDivision
endThreeDecimalDivision
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
	CMP R6, #0
	BEQ noDecimal
lessThanThreeDecimal
	LDR R8, =10
	LDR R9, =0
	CMP R6, R8
	BLO lessThanTwoDecimal
twoDecimalDivision
	CMP R6, R8
	BLO endTwoDecimalDivision
	SUB R6, R6, R8
	ADD R9, R9, #1
	B twoDecimalDivision
endTwoDecimalDivision
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
lessThanTwoDecimal	
	CMP R6, #0
	BEQ noDecimal
	MOV R9, R6
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
noDecimal	
	MOV R0, #0x0A
	BL sendchar
	MOV R0, #0x43
	BL sendchar
	MOV R0, #0x6F
	BL sendchar
	MOV R0, #0x75
	BL sendchar
	MOV R0, #0x6E
	BL sendchar
	MOV R0, #0x74
	BL sendchar
	MOV R0, #0x3D
	BL sendchar
	LDR R9, =0
	CMP R7, R8
	BLO lessThanTenNumber
tenNumberDivision
	CMP R7, R8
	BLO endTenNumberDivision
	SUB R7, R7, R8
	ADD R9, R9, #1
	B tenNumberDivision
endTenNumberDivision
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
lessThanTenNumber	
	CMP R7, #0
	BEQ endOfProgram
	MOV R9, R7
	ADD R9, R9, #0x30
	MOV R0, R9
	BL sendchar
endOfProgram	
stop	B	stop

	END