.data
	array:		.space 1000
	StringEnd:	.asciiz "\0"
	newline:      	.asciiz "\n"
	str:		.asciiz "cnm"

.text

main:
# read input
# read n: number of strings
	li	$v0, 5				# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
	add	$a2, $0, $v0			# N, copy input to a2
	
	addi $t0, $0, 0				# counter + 100
	addi $t1, $0, 0        			# counter + 1

read:
	beq $t1, $a2, sort			# if ($t0 > n) --> sort
	la $a0, array($t0)
	li $v0, 8
	li $a1, 100
	syscall

	addi $t0, $t0, 100
	addi $t1, $t1, 1
	
	j read

# bubble sort
sort:
	li $t0, 0				# counter
	li $t1, 0        			# counter for inner loop
	li $t3, 0				# memory adder
	
outer:
	beq $t0, $a2, printBefore
inner:
	addi $t2, $a2, -1
	beq $t1, $t2, continue
	
	lb $t4, array($t3)
	addi $t3, $t3, 100
	lb $t5, array($t3)
	
	addi $t1, $t1, 1
	blt $t4, $t5, inner
	bgt $t4, $t5, swap
	beq $t4, $t5, nextBit
	j inner
	
continue:
	addi $t0, $t0, 1
	li $t3, 0
	li $t1, 0
	j outer	

nextBit:
	addi $t6, $t3, 0
	addi $t7, $t6, -100
nextBitLoop:
	beq $t7, $t3, inner
	addi $t6, $t6, 1
	addi $t7, $t7, 1
	lb $t4, array($t7)
	lb $t5, array($t6)
	blt $t4, $t5, inner
	bgt $t4, $t5, swap
	beq $t4, $t5, nextBitLoop
	
# swap
swap:
	add $t6, $0, $t3
	addi $t7, $t6, -100
	li $t8, 0
loopSwap:
	beq $t8, 100, inner
	lb $t4, array($t6)
	lb $t5, array($t7)
	sb $t4, array($t7)
	sb $t5, array($t6)
	
	addi $t6, $t6, 1
	addi $t7, $t7, 1
	addi $t8, $t8, 1
	j loopSwap

# print
printBefore:	
	addi $t0, $0, 0				# counter + 100
	addi $t1, $0, 0        			# counter + 1
	j print
	
print:
	beq $t1, $a2, end
	li $v0, 4
	la $a0, array($t0)
	syscall
	
	addi $t1, $t1, 1
	addi $t0, $t0, 100
	j print

end:
	ori   $v0, $0, 10     # system call 10 for exit
	syscall      
	