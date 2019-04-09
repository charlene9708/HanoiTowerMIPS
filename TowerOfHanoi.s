.data
userPrompt:		.asciiz "Enter number of disks: "
moveMsg:	.asciiz " \nMove disk "
fromMsg:	.asciiz " from peg "
toMsg:		.asciiz " to peg "
start: 		.word 1
finish: 	.word 2
extra: 		.word 3

.text
.globl main

main:
	li $v0, 4				#print a string
	la $a0, userPrompt 		#print the prompt
	syscall					
	
	li $v0, 5   	 		# Get the user input	
	syscall				
	
	lw $a1, start			#initialize peg 1
	lw $a2, finish			#initialize peg 2
	lw $a3, extra			#initialize peg 3
	
	move $a0, $v0			# Now $a0 = input n
	li $t0, 0				# set $t0 = 0 for the base case later
		
	jal TOH

	li $v0, 10  			# system service 10: exit
	syscall
	
TOH:
	addi $sp, $sp, -20 		#store register pointers for 5 words
	sw $ra, 0($sp) 			#store $ra
	sw $s0, 4($sp) 			
	sw $s1, 8($sp) 			
	sw $s2, 12($sp) 		
	sw $s3, 16($sp) 		
	
	move $s0, $a0 			#$s0 = $a0 = n
	move $s1, $a1			#$s1 = $a1 (= start)
	move $s2, $a2			#$s2 = $a2 (= finish)
	move $s3, $a3			#$s3 = $a3 (= extra)
	
    beq $s0, $t0, EXIT 		# Base case: stop when n = 0 
    
Recursion:
	#------------ TOH (n-1, start, extra, finish) ------------
	addi $a0, $s0, -1		# $a0 = $s1 - 1 = n - 1
	move $a1, $s1 			#$a1 = $s1 (= start)
	move $a2, $s3			#$a2 = $s3 (= extra)
	move $a3, $s2			#$a3 = $s2 (= finish)
	
    jal TOH					# calling TOH (n-1, start, extra, finish)

	#------------------ Printing ------------------
	li $v0, 4  				# print string
	la $a0,  moveMsg		# print "\nMove disk"
    syscall					
    li $v0,  1              # print integer
    move $a0, $s0			# print $s0
    syscall
    
    li $v0,  4              # print string
    la $a0,  fromMsg		# print " from peg "
    syscall
    li $v0,  1             	# print int
    move $a0, $s1			# print $s1 (= start)
    syscall
    
    li $v0,  4              # print string
    la $a0,  toMsg			# print " to peg "
    syscall
    li $v0,  1              # print int
    move $a0, $s2   		# print $s2 (finish)
    syscall
 
 	#------------ TOH (n-1, extra, finish, start) ------------
    beq $s0, $t0, EXIT		# Base case: stop when n = 0 
    addi $a0, $s0, -1 		# $a0 = $s1 - 1 = n - 1
	move $a1, $s3			#$a1 = $s3 (= extra)
	move $a2, $s2			#$a2 = $s2 (= finish)
    move $a3, $s1			#$a3 = $s1 (= start)
    
    jal TOH					# calling TOH (n-1, extra, finish, start)
    
EXIT:
	lw $ra, 0($sp)      	# load $ra back
	lw $s0, 4($sp) 			# load these registers back
	lw $s1, 8($sp) 
	lw $s2, 12($sp) 
	lw $s3, 16($sp) 
	addi $sp, $sp, 20 		#restore stack pointer
	jr $ra
	

	
	
	
