#Assignment 4
#Problem 2
#Group Number 23
#Semester 5
#Team Members: Yash Kumar(21CS30059)
#              Sampreeth R S(21CS30038)


#Constant data
.data
#Print statements
    prompt: .asciiz "Input an integer n: "
    prompt2: .asciiz "\nPlease enter valid value of n: "
    result: .asciiz "No. of steps = "
#Code begins
.text
main:
    li        $v0, 4
    la        $a0, prompt	#Printing the prompt to enter valid value of n
    syscall
    li        $v0, 5
    syscall			#Scanning value of n
loop1:
    bgt $v0,$zero,exit_loop2    #If n is greater than 0, continue normally and jump to exit_loop
    li        $v0, 4
    la        $a0, prompt2	#If n is not greater than 0, print prompt to enter a valid value
    syscall
    li $v0, 5			#Scanning value of n
    syscall
    b loop1			#Go back to loop1 to check for the validity of n
exit_loop2:    
    move      $a0, $v0          # $a0 <-- n
    jal      sum       
    move      $t0, $v0  	#Storing the return value temporarily in $t0
    li        $v0, 4
    la        $a0, result	#Printing the result string
    syscall
    li        $v0, 1        
    move      $a0, $t0          #Printing the no. of steps
    syscall     
    li        $v0, 10        
    syscall

sum:
    addi    $sp, $sp, -8	# adjust stack pointer to store return address and argument
    sw      $s0, 4($sp)		# s0 stores the parameter value of argument (Stores x if we are calling from f(x))
    sw      $ra, 0($sp)		# ra stores the return address
    beq     $a0,1,base_case     # If n is 1, go to the base_case label
    li	    $t8,2
    div     $a0,$t8		# Divide n by 2
    mfhi    $t8			# Store remainder in t8
    beq     $t8, 1, else2       # If n is odd, go to label else2
    beq     $t8,0,else1   	# If n is even, go to label else1
base_case:				
    addi    $v0, $zero, 0    	# For base case (n=1), number of steps is 0
    j return

else1:
    move    $s0, $a0		# s0 stores the paramter value of argument
    li $t8,2			
    div $a0,$t8			# Divide n by 2
    mflo $a0			# Move the quotient to a0
    jal     sum			# Calling recursion
    #When we get here we have the value of no_of_steps(n/2) in v0
    addi $v0, $v0, 1		# Adding 1 to the number of steps
    b return

else2:
    move    $s0, $a0		# s0 stores the paramter value of argument
    li $t9,3
    mul $a0,$a0,$t9		# Multiplying n by 3
    addi $a0,1			# Adding 1 to 3n
    jal     sum			# Calling recursion
    #When we get here we have the value of no_of_steps(3n+1) in v0
    addi $v0, $v0, 1		# Adding 1 to the number of steps		
    b return

return:
    lw      $s0, 4($sp)		# s0 stores the parameter value of callee (Stores x if we are calling from f(x))
    lw      $ra, 0($sp)		# ra stores the return address
    addi    $sp, $sp, 8		
    jr      $ra			# Rolling back the recursion