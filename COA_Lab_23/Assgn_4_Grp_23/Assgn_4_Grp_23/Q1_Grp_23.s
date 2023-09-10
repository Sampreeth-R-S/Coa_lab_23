#Assignment 4
#Problem 2
#Group Number 23
#Semester 5
#Team Members: Yash Kumar(21CS30059)
#              Sampreeth R S(21CS30038)


#Constant data
.data
#Print statements
    prompt: .asciiz "Input an integer n (<=10): "
    prompt2: .asciiz "\nPlease enter valid value of n: "
    result: .asciiz "Sum of series = "
#Code begins
.text
main:
    li        $v0, 4
    la        $a0, prompt	#Prompting to input an integer
    syscall
    li        $v0, 5		#Scanning n
    syscall
loop1:
    bgt       $v0,$zero,exit_loop2	#If n is greater than 0, go to exit_loop2 label
loop2:    
    li        $v0, 4
    la        $a0, prompt2		#If n is not greater than 0, the prompt user to enter a valid value of n
    syscall
    li $v0, 5				#Scanning n
    syscall	
    b loop1				#Go back to loop1 again to check validity of n
exit_loop2:    
    bgt	      $v0,9,loop2		# If n is more than 9, prompt user to re-enter
    move      $a0, $v0			# $a0 <-- n
    jal      sum       
    move      $t0, $v0 	  	        #Storing the return value temporarily in $t0
    li        $v0, 4
    la        $a0, result		#Printing the result string
    syscall
    li        $v0, 1        
    move      $a0, $t0 		        #Printing the series sum      
    syscall     
    li        $v0, 10        
    syscall

sum:
    addi    $sp, $sp, -8		# adjust stack pointer to store return address and argument
    sw      $s0, 4($sp)			# s0 stores the parameter value of argument (Stores x if we are calling from f(x))
    sw      $ra, 0($sp)			# ra stores the return address
    bne     $a0, 1, else		# If n is not equal to 1 (base case), goto else label
    addi    $v0, $zero, 1   	        # If n is 1, return 1
    j return

else:
    move    $s0, $a0			# s0 stores the paramter value of argument
    addi    $a0, $a0, -1 		# n -= 1
    jal     sum				# Calling recursion
    li $t0,0				# Counter
    li $t1,1				# n^counter (n<=counter) (n: recursion argument)
loop:
    beq $t0,$s0,exit_loop		# If counter is n, goto exit_loop label
    multu $s0,$t1			# Multiply t1 with n
    mflo $t1				# Move product to t1
    addi $t0,1				# Increment counter	 	
    b loop
exit_loop:
    add   $v0, $v0,$t1 			# Add the term to the series

return:
    lw      $s0, 4($sp)			# s0 stores the parameter value of argument (Stores x if we are calling from f(x))		
    lw      $ra, 0($sp)			# ra stores the return address
    addi    $sp, $sp, 8
    jr      $ra				# Rolling back to the recursion