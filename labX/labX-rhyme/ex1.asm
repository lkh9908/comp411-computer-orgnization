.data
	space:		.asciiz " "
	newline:      	.asciiz "\n"
	end:		.asciiz "END"
	semiColon:	.asciiz ";\n"
	arrayName:	.space 315
	arrayLine:	.space 1200
	
	begin:		.asciiz "There was an old lady who swallowed a "
	mid:		.asciiz "She swallowed the "
	mid2:		.asciiz " to catch the "
	
	begin2:		.asciiz "I don't know why she swallowed a "
	mid22:		.asciiz " - "
	
	Space:	.space 100
	


.text

main:
	li $s0, 0	# name string addr counter
	li $s1, 0	# line string addr counter
	li $s2, 0	# number of pairs counter
	
	li $s3, 15	# space for each slot in each array
	li $s4, 60
	
read:
	la $a0, arrayName($s0)
	li $v0, 8
	li $a1, 15
	syscall

	# compare variables
	li $t0, 0
	li $t1, 0
	li $t2, 2 # end has 0, 1, 2
compareEnd:
	# see if END is coming
	lb $t3, end($t0)
	add $t1, $t0, $s0
	lb $t4, arrayName($t1)
	bne $t3, $t4, continueRead
	beq $t0, $t2, printStart
	
	addi $t0, $t0, 1
	j compareEnd
continueRead:
	# enter the LINE paired with the animal
	addi $s0, $s0, 15
	
	la $a0, arrayLine($s1)
	li $v0, 8
	li $a1, 60
	syscall
	
	addi $s1, $s1, 60
	add $s2, $s2, 1
	j read

printStart:
	li $v0, 4
	la $a0, begin
	syscall
	
	li $t1, 0
	add $t2, $s1, $0
	addi $t2, $t2, -60
	
	# name of animal 1
	la $a0, arrayName($t1)
	la $a2, Space
	jal noEnd
	
	li $v0, 4
	la $a0, Space
	syscall
	
	# semicolon
	li $v0, 4
	la $a0, semiColon
	syscall

	li $t0, 1 # currentLevel
	li $t6, 1 # space needed
	j loopPrint1
	
loopPrint1:
	beq $t0, $s2, loopPrint2SetUP
	
	# space
	li $t9, 0
	jal printSpace
	
	# she swallowed the 
	la $a0, mid
	la $a2, Space
	jal noEnd
	
	li $v0, 4
	la $a0, Space
	syscall

	# name of animal 1
	la $a0, arrayName($t1)
	la $a2, Space
	jal noEnd
	
	li $v0, 4
	la $a0, Space
	syscall
	
	# to catch the
	la $a0, mid2
	la $a2, Space
	jal noEnd
	
	li $v0, 4
	la $a0, Space
	syscall
		
	# animal two
	addi $t1, $t1, 15
	la $a0, arrayName($t1)
	la $a2, Space
	jal noEnd
	
	li $v0, 4
	la $a0, Space
	syscall
	
	# semicolon
	li $v0, 4
	la $a0, semiColon
	syscall
	
	addi $t0, $t0, 1
	addi $t6, $t6, 1
	j loopPrint1
	
loopPrint2SetUP:
	# set up the space for second loop
	addi $t6, $t6, -1
	
loopPrint2:
	beq $t0, $0, endOfProgram
	
	# space
	li $t9, 0
	jal printSpace
	
	# I dont know why...
	la $a0, begin2
	la $a2, Space
	jal noEnd
	
	li $v0, 4
	la $a0, Space
	syscall
	
	# animal one
	la $a0, arrayName($t1)
	la $a2, Space
	jal noEnd
	
	li $v0, 4
	la $a0, Space
	syscall
	
	# -
	la $a0, mid22
	la $a2, Space
	jal noEnd
	
	li $v0, 4
	la $a0, Space
	syscall
	
	# line
	li $v0, 4
	la $a0, arrayLine($t2)
	syscall
	
	addi $t1, $t1, -15
	addi $t0, $t0, -1
	addi $t6, $t6, -1
	addi $t2, $t2, -60
	
	j loopPrint2


printSpace:
	beq $t9, $t6, endPrint
	li $v0, 4
	la $a0, space
	syscall
	addi $t9, $t9, 1
	j printSpace

endPrint:
	jr $ra
	
endOfProgram:
	ori   $v0, $0, 10     # system call 10 for exit
	syscall
	
	
noEnd:
	# take off the \0
	li $t8 10 #store newline in $t8
	
    #loop through first string take away \0
   CopyFirst:

        lb   $t7 0($a0)
        beq  $t7 $zero Done #exit loop on null byte
        beq  $t7 $t8 Done   #exit loop on new-line
        sb   $t7 0($a2)
        addi $a0 $a0 1
        addi $a2 $a2 1
        b CopyFirst

    Done:

        sb $zero 0($a2) #null terminate string
        jr $ra
