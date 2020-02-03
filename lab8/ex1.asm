# Starter file for ex1.asm

.data
	#...
        
.text 

main:
	#...
	#...

	#----------------------------------------------------------------#
	# Write code here to do exactly what main does in the C program.
	#
	# Please follow these guidelines:
	#
	#	Use syscall 5 each time to read an integer (scanf("%d", ...))
	#	Then call NchooseK to compute the function
	#	Then use syscall 1 to print the result
	#   Put all of the above inside a loop
	#----------------------------------------------------------------#
	
	j loop
	
loop:	
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
	add	$a0, $0, $v0			# copy input to a0
	
	beq	$a0, $0, end
	
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
	add	$a1, $0, $v0			# copy input to a1
	jal NchooseK
	jal printResult
	j loop
	
end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.



NchooseK:    		# PLEASE DO NOT CHANGE THE NAME "NchooseK"
	#----------------------------------------------------------------#
	# $a0 has the number n, $a1 has k, from which to compute n choose k
	#
	# Write code here to implement the function you wrote in C.
	# Your implementation MUST be recursive; an iterative
	# implementation is not acceptable.
	#
	# $v0 should have the NchooseK result to be returned to main.
	#----------------------------------------------------------------#

	#...
	#...
	
	# save ra and fp
	addiu $sp, $sp, -8
	sw $ra, 0($sp)	# save ra
	sw $fp, 4($sp)	# save fp
	addi $fp, $sp, 4 # Set $fp
	
	# save s registers
	addiu $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	
	beq $a1, $0, return1 # if k = 0, return 1
	beq $a0, $a1, return1 # if n = k, return 1
	blt $a0, $a1, return0 # if n < k, return 0
	
	# c(n, k) = c(n-1, k) + c(n-1, k-1)
	# do c(n-1, k) first so only one variable need to be changed
	addi $a0, $a0, -1 # n - 1
	add $s0, $a0, $0
	add $s1, $a1, $0
	jal NchooseK
	
	add $s2, $v0, $0 # c(n-1, k)
	
	# do c(n-1, k-1)
	add $a0, $s0, $0 # old n
	addi $a1, $s1, -1 # k - 1
	jal NchooseK
	
	add $v0, $v0, $s2 # additon
	j return

# exception when n < k, which gives no result
return0:
	add $v0, $0, $0
	j return
return1:
	addi $v0, $0, 1
return:
	# restore s registers
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 12
	
	# restore fp and ra
	lw $fp, 4($sp)	# Restore $fp
	lw $ra, 0($sp) 	# Restore $ra
	addi $sp, $sp, 8 # Restore $sp
	
	jr $ra 		# Return

printResult:
	# print answer
	add $a0, $v0, $0
	addi $v0, $0, 1
	syscall
	# print new line after the answer
	addi $v0, $0, 11
	addi $a0, $0, '\n'
	syscall
	jr $ra
