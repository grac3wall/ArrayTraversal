#Name: Grace Wall



#general setup:
#took user input for array size and for array itself
#traversed through the array and ordered pairs of 2
#ordered double the amount of numbers each time traversed fully through array until i could merge the whole thign
#printed and exited 

.data


arg0:
	.space 64
arg1: 
	.space 64
ordered:
	.space 128
list:
	.space 128
seperation:
	.asciiz ", "
instruction0:
	.asciiz "please enter the size of the array (pwr of 2) >>> "
instruction1:
	.asciiz "please enter the integers for the unordered array >>> "
	
	
.text
.globl main

main:
	#print user instructions for size of array
	la $a0, instruction0
	li $v0, 4
	syscall
	
	#read int from console
	li $v0, 5 #code to read integer
	syscall  #reads integer from console
	
	move $t0, $v0 #saves size of the array to be inputted into t0 register
	
	#multiply by 4 so its more workable in terms of bytes
	
	sll $t0, $t0, 2
	
	#print second set of user instructionss
	la $a0, instruction1
	li $v0, 4
	syscall
	
	addi $t1, $t1, 0 #will be offset value
	
	input:
	
	#la $t2, list	#loads the address of the first array for use putting the values in the array	
	
	#read int from console
	li $v0, 5 
	syscall 
	
	#input current read into array	
	sw $v0, list($t1) #saves the integer just read by syscall into the correct byte of the array (offset 4 to put in second byte)
	addi $t1, $t1, 4 #increments offset
	
	bne $t1, $t0, input
	move $t2, $0 #clears t2 for use if wantsies
	move $t1, $0 #same as above w t1
	
	li $s5, 0#overall index of list:
	addi $s3, $s3, 8 #sets size to be used in merge function for2
	li $t1, 0
for2:
	li $t9, 0
	
	whiler2:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg0($t9)
		addi $t9, $t9, 4
		blt $t9, 4, whiler2
	whiler2arg1:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg1($t9)
		addi $t9, $t9, 4
		blt $t9, 8, whiler2arg1
	
	jal merge
	#addi $t1, $t1, 4
	j fin
	bne $t1, $t0, for2	
	addi $s3, $s3, 8
for4:
	
	li $t9, 0
	
	whiler4:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg0($t9)
		addi $t9, $t9, 4
		blt $t9, 8, whiler4
	whiler4arg1:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg1($t9)
		addi $t9, $t9, 4
		blt $t9, 16, whiler4arg1
	
	jal merge
	#addi $t1, $t1, 4
	bne $t1, $t0, for4	
	addi $s3, $s3, 32
	
	
	addi $s3, $s3, 16
	beq $t0, 8, fin
for8:
	li $t9, 0
	
	whiler8:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg0($t9)
		addi $t9, $t9, 4
		blt $t9, 16, whiler8
	whiler8arg1:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg1($t9)
		addi $t9, $t9, 4
		blt $t9, 32, whiler8arg1
	
	jal merge
	#addi $t1, $t1, 4
	bne $t1, $t0, for8	
	addi $s3, $s3, 32
	beq $t0, 16, fin
for16:
	li $t9, 0
	
	whiler16:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg0($t9)
		addi $t9, $t9, 4
		blt $t9, 32, whiler16
	whiler16arg1:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg1($t9)
		addi $t9, $t9, 4
		blt $t9, 64, whiler16arg1
	
	jal merge
	#addi $t1, $t1, 4
	bne $t1, $t0, for16	
	addi $s3, $s3, 64
	beq $t0, 32, fin
for32:
	
	li $t9, 0
	
	whiler32:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg0($t9)
		addi $t9, $t9, 4
		blt $t9, 64, whiler32
	whiler32arg1:
		addi $t1, $t1, 4
		lw $t4, list($t1)
		sw $t4, arg1($t9)
		addi $t9, $t9, 4
		blt $t9, 128, whiler32arg1
	
	jal merge
	addi $t1, $t1, 4
	bne $t1, $t0, for32	
	#addi $s3, $s3, 32 
fin:#printing copied from merge program, needs work??
	li $t8, 0 #sets a value to be used as index when outputting the values later in output:
output:	
	lw  $t5, list($t8) #load the integer to be printed 
	move $a0, $t5 #set integer to be printed as the value of the current index of the merged list
	li $v0, 1 #set to print an integer
	syscall # print the int.
	
	la $a0, seperation #adds the previously declared comma and space
	li $v0, 4 #string call code
	syscall #prints comma and space 
	
	add $t8,$t8,4 #increases index so that next value will be printed.
	bne $t8, $t0, output #goes to print next index if haven't printed entire merged list
	
	li	$v0, 10		#returns value of 10 - so syscall will terminate program below
	syscall			#ends program... (terminate code 10 above)
merge:
# initialize indexes / offset value for each array as 0
	li $s0,  0 #index of arg0 = $s0
	li $s1, 0#index of arg1 = $s1
	li $s2, 0 #saves index of returned array (index of ordered = $s2)
	
	
	#move $s4, $0#clears s4
	
	srl $s4, $s3, 1 #gives size of one of the lists for use in conditional
	
while:
	lw $t2, arg0($s0)#creates temporary variable with the value at the working index of arg0
	lw $t3, arg1($s1)#creates temporary variable with the value at the working index of arg1
	
	beq $s0, $s4, oneless #jumps to add final value of arg1 if arg0 has already had all its values added to merged list
	blt $t3, $t2, oneless #goes to add the current arg1 array value to merged list if the value is less
	
zeroless:
	sw $t2, ordered($s2) #saves arg0 value to merged list...
	#sw $0, arg0($s0)#clears value
	add $s0, $s0, 4 #increments working index of arg0 array
	add $s2, $s2, 4 #increments offset index in merged list
	j conditional #jumps to the comparison that sees if the loop needs to be gone through again
	
oneless : 
	beq $s1, $s4, zeroless #jumps to add final arg0 value if all arg1 values are already in merged list
	sw $t3, ordered($s2) #saves current arg1 value to the merged list
	#sw $0, arg1($s1)#clear value 
	
	
	add $s1, $s1, 4 #increments working index of arg1 array...
	add $s2, $s2, 4 # increments offset of merged list

conditional: #checks if either input list has not been fully added to merged list
	bne $s0, $s4, while 
	blt $s1, $s4, while
	li $t7, 0
saving:
	lw $t5, ordered($t7)#loads current value from reordered mini array to t5
	sw $t5, list($s5)#saves that value to the list
	#sw $0, ordered($t7)
	
	#move $a0, $t5
	#li $v0, 1
	#syscall
	
	addi $s5, $s5, 4#increases total indeex position of the entire list 
	addi $t7, $t7, 4 #increase the value of the index in the current reordered list.
	
	blt $t7, $s3, saving	

	jr $ra