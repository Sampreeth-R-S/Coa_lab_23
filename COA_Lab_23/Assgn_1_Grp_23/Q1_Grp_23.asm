#Assignment 1
#Problem 1
#Group Number 23
#Semester 5
#Team Members: Yash Kumar(21CS30059)
#               Sampreeth R S(21CS30038)


#Constant data
.data
#Print statements
input:  
 .asciiz "Please enter x (Enter a value less than 21): "
message1:
 .asciiz "\nThe value of e^x is: "
message2:
 .asciiz "\nThe number of terms taken into account is "
newline:
 .asciiz "\n"
#Code begins
 .text
 .globl main
main:
 la $a0,input #Printing the prompt to provide x as input
 li $v0,4
 syscall
 li $v0,5  #Scanning x
 syscall
 move $t0,$v0  #t0 stores x
 la $a0,message1
 li $v0,4
 syscall
 move $t6,$t0 #t6 stores x^(k)/k!
 li $t4,1  #t4 stores k
 li $t3,1  #t3 stores sum
 li $t2,1  #t2 stores sum of previous iteration 
loop:
 add $t3,$t3,$t6  #Updating Current Sum
 beq $t3 $t2,exit  #Exiting the loop if sum does not change
 addi $t4,1  #updating the iteration count(k)
 mul $t6,$t6,$t0  #multiplying x with the previous term (t6=x^(k)/(k-1)!)
 div $t6,$t4  #Dividing term by k
 mflo $t6  #storing the quotient in t6
 move $t2,$t3  #Updating prev sum for the next iteration
 b loop  #loop continues
 

exit:
 move $a0,$t3  #Printing the value of e^x
 li $v0,1
 syscall
 la $a0,message2  #Printing the Number of iterations
 li $v0,4
 syscall
 move $a0,$t4
 li $v0,1
 syscall
 li $v0,10  #Exiting the function
 syscall
#test