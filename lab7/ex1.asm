
.data
  AA:     .space 400  		# int AA[100]
  BB:     .space 400  		# int BB[100]
  CC:     .space 400  		# int CC[100]
  m:      .space 4   		# m is an int whose value is at most 10
                     		# actual size of the above matrices is mxm

      # You may add more variables here if you need to
  newline:	.asciiz "\n"


.text

main:


#------- INSERT YOUR CODE HERE for main -------
#
#  Best is to convert the C program line by line
#    into its assembly equivalent.  Carefully review
#    the coding templates near the end of Lecture 8.
#
#
#  1.  First, read m (the matrices will then be size mxm).
#  2.  Next, read matrix A followed by matrix B.
#  3.  Compute matrix product.  You will need triple-nested loops for this.
#  4.  Print the result, one row per line, with one (or more) space(s) between
#      values within a row.
#  5.  Exit.
#
#------------ END CODE ---------------

addi	$v0, $0, 5			# system call 5 is for reading an integer
syscall 				# integer value read is in $v0
add	$s0, $0, $v0			# copy size to t1
mult $s0, $s0
mflo $s1				# s1 = size*size
sw $s0, m				# m = size
   
addi	$t1, $0, 0			# i = 0
readA:
  beq $s1, $t1, reset
  addi	$v0, $0, 5			# system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  add	$t2, $0, $v0			# copy input to t2
  sll  $t3,$t1,2  
  sw $t2, AA($t3)
  addi $t1, $t1, 1			# i++
  j readA

reset:
  addi	$t1, $0, 0			# i = 0
  j readB
  
readB:
  beq $s1, $t1, resetAndReadyForCompute
  addi	$v0, $0, 5			# system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  add	$t2, $0, $v0			# copy input to t2
  sll  $t3,$t1,2			
  sw $t2, BB($t3)
  addi $t1, $t1, 1			# i++
  j readB

resetAndReadyForCompute:
  addi  $t0, $0, 0			# x = 0 x = roll of A;
  addi  $t1, $0, 0			# y = 0 y = col of B;
  addi  $t2, $0, 0			# z = 0 z = colOfA and rolOfB
  j compute
  
compute:
  beq $s0, $t0, finalReset
  beq $s0, $t1, ifYSize			# if y < size
  beq $s0, $t2, ifZSize			# if z < size
  
  mult $t0, $s0				# x*size
  mflo $t3				
  add $t3, $t3, $t1 			# x*size + y
  sll $t3, $t3, 2
 
  mult $t0, $s0				# x*size
  mflo $t4				
  add $t4, $t4, $t2 			# x*size + z
  sll $t4, $t4, 2
 
  mult $t2, $s0				# z*size
  mflo $t5				
  add $t5, $t5, $t1 			# z*size + y
  sll $t5, $t5, 2
  
  lw $t6, AA($t4)			# CC[x*size+y] += AA[x*size+z] * BB[z*size+y];
  lw $t7, BB($t5)
  lw $t8, CC($t3)
  mult $t6, $t7
  mflo $t9
  add $t8, $t8, $t9
  sw $t8, CC($t3)

  addi $t2, $t2, 1
  j compute
 
ifZSize:
  addi $t2, $0, 0
  addi $t1, $t1, 1
  j compute
  
ifYSize:
  addi $t1, $0, 0
  addi $t0, $t0, 1
  j compute
  
finalReset:
  addi	$t1, $0, 0			# i = 0
  addi	$t4, $0, 0			# j = 0
  j finalPrint
	
finalPrint:
  beq $s1, $t1, exit
  beq $s0, $t4, printNewLine
  sll $t3, $t1, 2			
  lw $t2, CC($t3)
  li $v0, 1
  addi $a0, $0, 0
  add $a0, $a0, $t2
  syscall
  addi $t1, $t1, 1			# i++
  addi $t4, $t4, 1
  
  li $v0, 11				# print space
  li $a0, 32
  syscall
  
  j finalPrint
  
printNewLine:
 			  # Print a newline
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, newline 			# address of areaIs string is in $a0
  syscall           			# print the string
  addi	$t4, $0, 0			# j = 0
  j finalPrint

exit:                     # this is code to terminate the program -- don't mess with this!
  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program



#------- If you decide to make other functions, place their code here -------
#
#  You do not have to use helper methods, but you may if you would like to.
#  If you do use them, be sure to do all the proper stack management.
#  For this exercise though, it is easy enough to write all your code
#  within main.
#
#------------ END CODE ---------------
