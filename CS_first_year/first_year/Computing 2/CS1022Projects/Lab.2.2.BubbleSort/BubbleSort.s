	AREA	BubbleSort, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, =array	; address of array
	LDR	R5, =arrayN	; address of array size
	LDR	R5, [R5]	; load array size
	LDR R8, =0	; swapped = false
	B sort


; swap subroutine
; Take two elements from a one-dimensional array and swap them.
; parameters R0 : array address
;			 R1 : index of first element
;			 R2 : index of second element
swap
	STMFD sp!, {R6-R7, lr}		
	LDR R6, [R0, R1, LSL #2]	; load first element from first index
	LDR R7, [R0, R2, LSL #2]	; load second element from second index
	STR R6, [R0, R2, LSL #2]	; store first element in second index
	STR R7, [R0, R1, LSL #2]	; store second element in first index
	LDMFD sp!, {R6-R7, pc}	


; sort program
;
sort
	B do
while1				; while ( swapped == true )
	CMP R8, #0		; {
	BEQ endwhile1
do
	LDR R8, =0		;	swapped = false
	ADD R5, R5, #-1	;	array size = array size - 1
	LDR R6, =1		;	index = 1 
	LDR R7, =0		;	index bis = index - 1
while2						;	while ( index < array size )
	CMP R6, R5				;	{
	BGT endwhile2
	LDR R9, [R4, R6, LSL #2];		load first element from index
	LDR R10, [R4, R7, LSL #2];		load second element from index bis
	CMP R9, R10				;		if ( first element < second element )
	BGT elseif				;		{
	MOV R0, R4				;			R0 = array address
	MOV R1, R6				;			R1 = first element
	MOV R2, R7				;			R2 = second element
	BL swap					;			swap ( R0, R1, R2)
	LDR R8, =1				;			swapped = true
elseif						;		}
	ADD R6, R6, #1			;	index += 1
	ADD R7, R7, #1			; 	index bis += 1
	B while2				;	}
endwhile2			;		
	B while1		; }
endwhile1	
stop	B	stop


	AREA	TestArray, DATA, READWRITE

; Array Size
arrayN	DCD	15

; Array Elements
array	DCD	33,17,18,92,49,28,78,75,22,13,19,13,8,44,35

	END	