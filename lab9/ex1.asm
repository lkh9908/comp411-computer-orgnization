.data
	#...
        pattern: .space 80
.text 

main:
	# read input
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
	
	# N, and currentlevel
	add	$a1, $0, $v0			# N, copy input to a1
	addi	$a2, $0, 0			# currentLevel
	jal makePattern
	j end
end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               
	
makePattern:
	# save ra and fp
	addiu $sp, $sp, -8
	sw $ra, 4($sp)	# save ra
	sw $fp, 0($sp)	# save fp
	addi $fp, $sp, 4 # Set $fp
	
	# save a2, currentLevel
	addiu $sp, $sp, -4
	sw $a2, 0($sp)
	
	# if currentLevel == N, print result
	beq $a1, $a2, printResult
	
	# else
	# case 0
	sll $t1, $a2, 2
	addi  $t0, $0, 0
	sw    $t0, pattern($t1)
	addi  $a2, $a2, 1
	jal makePattern
	
	# restore a2
	lw $a2, -8($fp)
	
	#case 1
	sll $t1, $a2, 2
	addi  $t0, $0, 1
	sw    $t0, pattern($t1)
	addi  $a2, $a2, 1
	jal makePattern
	
	# restore a2
	lw $a2, -8($fp)
	
return:
	# restore fp and ra
	addi $sp, $fp, 4 	# Restore $sp
    	lw $ra, 0($fp) 		# Restore $ra
    	lw $fp, -4($fp) 	# Restore $fp
    	jr $ra 			# Return

	
printResult:
	#set i
	addi  $t0, $0, 0
	j loopPrint
loopPrint:
	beq   $a1, $t0, printNewLine
	# print answer
	sll $t1, $t0, 2
	lw $a0, pattern($t1)
	addi $v0, $0, 1
	syscall
	# increment i
	addi $t0, $t0, 1
	j loopPrint
printNewLine:
	# print new line after the answer
	addi $v0, $0, 11
	addi $a0, $0, '\n'
	syscall
	j return

