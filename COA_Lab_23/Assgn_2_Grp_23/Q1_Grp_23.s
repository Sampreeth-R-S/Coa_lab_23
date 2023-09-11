#Assignment 2
#Problem 1
#Group Number 23
#Semester 5
#Team Members: Yash Kumar(21CS30059)
#               Sampreeth R S(21CS30038)


#Constant data
.data
#Print statements
array1:
 .word 0,1,2,3,4,5,6,7,8,9
array2:
 .word 0,1,2,3,4,5,6,7,8,9
array3:
 .word 0,1,2,3,4,5,6,7,8,9
visited:
 .word 0,0,0,0,0,0,0,0,0,0,0
message1:
 .asciiz "\nEnter number of cycles in permutation 1: "
message2:
 .asciiz "\nEnter number of cycles in permutation 2: "
message3:
 .asciiz "\nEnter the cycle size: "
message4:
 .asciiz "\nEnter the cycle elements: "
open_paren:
 .asciiz "("
close_paren:
 .asciiz ")\n"
delim:
 .asciiz ", "
newline:
 .asciiz "\n"
error_msg:
 .asciiz "Incorrect value has been entered\n"
#Code begins
 .text
 .globl main
main:
 la $a0,message1 #Printing the prompt to provide number of cycles
 li $v0,4
 syscall
 li $v0,5  #Scanning number of cycles
 syscall
 move $t0,$v0  #t0 stores number of cycles
 li $t1,0
loop: #Loop to take in each of the cycle
 beq $t0 $t1,exit_loop1  #Exiting the loop if all the cycles have been entered
 addi $t1,1  #updating the iteration count
 la $a0,message3  #Printing prompt to enter cycle size
 li $v0,4
 syscall
 li $v0,5
 syscall
 move $t2,$v0 #t2 stores the size of cycle
 li $t3,0
 la $a0,message4  #Prompt to enter the cycle elements
 li $v0,4
 syscall
loop2:  #Loop to take in cycle elements of a pareticular cycle
 beq $t3,$t2,loop  #End loop if all elements are taken
 addi $t3,1  #incrementing loop count
 beq $t3,1,firstiter  #Special case for first iteration
 beq $t3,$t2,lastiter  #Special case for last iteration
 li $v0,5
 syscall
 move $t6,$v0  #t6 stores the ith value of cycle
 li $t9,0
 blt $t6,$t9,error
 li $t9,9
 bgt $t6,$t9,error
 la $t7,array1  #setting arr[t5]=t6(t5 stores the previous value of the cycle)
 mul $t5,$t5,4
 add $t7,$t7,$t5
 sw $t6,($t7)
 move $t5,$t6  #updating prev value for the next iteration
 b loop2
lastiter:
 li $v0,5  #In last iteration, we have to update the value of arr[current value of cycle] to first value of cycle in addition to the regular step
 syscall
 move $t6,$v0
 li $t9,0
 blt $t6,$t9,error
 li $t9,9
 bgt $t6,$t9,error
 la $t7, array1
 mul $t5,$t5,4
 add $t7,$t7,$t5
 sw $t6,($t7)  #updating arr[prev]=current value
 sub $t7,$t7,$t5
 mul $t6,$t6,4
 add $t7,$t7,$t6
 sw $t4,($t7)  #updating arr[current value] to first value(t4 stores the first value)
 b loop2
firstiter:
 li $v0,5  #In first iteration, we do not have to change the value of arr, just store the value of the current input for further iterations
 syscall
 move $t4,$v0  #t4 stores the value for the last iteration
 move $t5,$v0  #t5 stores the value for next iteration
 li $t9,0
 blt $t5,$t9,error
 li $t9,9
 bgt $t5,$t9,error
 b loop2


exit_loop1:
 la $a0,message2 #Printing the prompt to provide number of cycles for the second permutation
 li $v0,4
 syscall
 li $v0,5  #Scanning number of cycles
 syscall
 move $t0,$v0  #t0 stores number of cycles in second permutation
 li $t1,0
loop3:
 beq $t0 $t1,process  #Exiting the loop after all the cycles of second permutation have been entered
 addi $t1,1  #updating the iteration count
 la $a0,message3  #prompt to enter size of cycle
 li $v0,4
 syscall
 li $v0,5
 syscall
 move $t2,$v0 #t2 stores the size of cycle
 li $t3,0
 la $a0,message4  #prompt to enter value of cycle components
 li $v0,4
 syscall
loop4:
 beq $t3,$t2,loop3  #Continuing the last
 addi $t3,1 #incrementing loop count
 beq $t3,1,firstiter1  #special cases as explained in the last permutation
 beq $t3,$t2,lastiter1
 li $v0,5
 syscall
 move $t6,$v0
 li $t9,0
 blt $t6,$t9,error
 li $t9,9
 bgt $t6,$t9,error
 la $t7,array2
 mul $t5,$t5,4
 add $t7,$t7,$t5
 sw $t6,($t7)
 move $t5,$t6
 b loop4
lastiter1:
 li $v0,5
 syscall
 move $t6,$v0
 li $t9,0
 blt $t6,$t9,error
 li $t9,9
 bgt $t6,$t9,error
 la $t7, array2
 mul $t5,$t5,4
 add $t7,$t7,$t5
 sw $t6,($t7)
 sub $t7,$t7,$t5
 mul $t6,$t6,4
 add $t7,$t7,$t6
 sw $t4,($t7)
 b loop4
firstiter1:
 li $v0,5
 syscall
 move $t4,$v0
 move $t5,$v0
 li $t9,0
 blt $t5,$t9,error
 li $t9,9
 bgt $t5,$t9,error
 b loop4

process:  #Updating the value of array 3 according to the product of the cycles
 la $t1,array1  
 la $t2,array2
 la $t3,array3
 li $t0,0  #t0 stores the value of current i*4
final_loop:
 beq $t0,40,exit  #In an iteration of the loop, we set arr3[i]=arr2[arr1[i]]
 add $t1,$t0,$t1
 lw $t4,($t1)
 mul $t4,$t4,4
 add $t2,$t4,$t2
 add $t3,$t0,$t3
 lw $t5,($t2)
 sw $t5,($t3)
 sub $t3,$t3,$t0
 sub $t1,$t1,$t0
 sub $t2,$t2,$t4
 addi $t0,$t0,4
 b final_loop



exit:  #Printing the cycles in the product permutation
 li $t0,0  #t0 stores index
 la $t9,visited
 la $t8,array3
final_loop2:
 beq $t0,10,exit2  #We iterate over each cycle and print the components of the cycle
 mul $t1,$t0,4
 add $t9,$t9,$t1
 lw $t2,($t9)
 sub $t9,$t9,$t1
 beq $t2,1,increment  #If the value of arr3[i]==i(single element cycle), iteration is continued
 add $t2,$t8,$t1  
 lw $t2,($t2)
 beq $t2,$t0,increment  #If vis[arr[i]] is true(which means cycle of which this value is a part of has already been printed), we move to the next iteration
 la $a0,open_paren  #Else printing begins
 li $v0,4
 syscall
 move $a0,$t2  #Print arr3[i]
 li $v0,1
 syscall
 la $a0,delim #Print delimiter
 li $v0,4
 syscall
 mul $t7,$t0,4
 add $t7,$t9,$t7
 li $t6,1
 sw $t6,($t7)
 mul $t7,$t2,4
 add $t7,$t9,$t7
 li $t6,1
 sw $t6,($t7)
 
 
final_loop3:  #Loop till the entire cycle has been printed
 mul $t2,$t2,4
 add $t2,$t2,$t8
 lw $t2,($t2)  #set t2 to arr3[t2]
 move $a0,$t2  #print t2
 li $v0,1
 syscall
 mul $t3,$t2,4  #load the value of visited[t2]
 add $t3,$t3,$t9
 lw $t3,($t3)
 beq $t3,1,increment2  #if visited[t2]==1(that is the entire cycle has been printed and we have come back to the first element), loop breaks
 mul $t7,$t2,4
 add $t7,$t9,$t7 #visited[t2] is set as 1
 li $t6,1
 sw $t6,($t7)
 la $a0,delim  #delimiter is printed
 li $v0,4
 syscall
 b final_loop3
 

increment2:  #Breaking out of the inner loop
 mul $t7,$t0,4
 add $t7,$t9,$t7
 li $t6,1
 sw $t6,($t7)  #Set visited[i] as 1
 addi $t0,$t0,1
 la $a0,close_paren  #print closing parenthesis
 li $v0,4
 syscall
 b final_loop2
increment:  #Moving to the next iteration in outer loop
 mul $t7,$t0,4   #Set visited[i] as 1
 add $t7,$t9,$t7
 li $t6,1
 sw $t6,($t7)
 addi $t0,$t0,1
 b final_loop2
exit2:
 li $v0,10  #Exiting the function
 syscall
error:
 la $a0,error_msg
 li $v0,4
 syscall
 li $v0,10  #Exiting the function
 syscall
#test