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
 .space 400
message1:
 .asciiz "Enter the size of the array(<=100): "
message2:
 .asciiz "\nEnter the elements of the array: "
message3:
 .asciiz "\nMaximum circular subarray sum is: "
#Code begins
 .text
 .globl main

read_n:  #Function to Read value of n and store in s0
 li $v0,5  #Scanning number of cycles
 syscall
 move $s0,$v0  #s0 stores number of cycles
 jr $ra

read_array:  #Function to read the array
 li $t0,0
loop:  #Reading the elements of the array in loop
 beq $t0,$s0,exit_loop
 la $t1,array1  #Pointer to array1
 mul $t2,$t0,4
 addi $t0,1
 add $t2,$t1,$t2  #Pointer to array1+i
 li $v0,5
 syscall
 sw $v0,($t2)
 b loop
exit_loop:
 jr $ra

calculate_sum:  #function to calculate the maximum sum
 li $t0,1
 la $t1,array1  #Pointer to array
 lw $t2,($t1)  #Running Maximum sum
 move $t3,$t2  #Maximum sum
 move $t4,$t2  #Running minimum sum
 move $t5,$t2  #Minimum sum
 move $t9,$t2  #Total sum
loop2:  #looping over the input
 beq $t0,$s0,exit_loop2
 mul $t6,$t0,4
 add $t6,$t6,$t1  #t6 = array1+i
 addi $t0,1
 lw $t6,($t6)  #t6=*(array1+1)
 add $t9,$t6,$t9  #update total sum
 add $t7,$t6,$t2  #t7=running max+arr[i]
 ble $t7,$t6,label1  #updating running max=max(running max+arr[i],arr[i])
 move $t2,$t7
 b label3
label1:
 move $t2,$t6
label3:
 ble $t2,$t3,label4  #updating max sum to max(maximum sum,running max)
 move $t3,$t2
label4:
 add $t7,$t6,$t4  #updating running min to min(running min+arr[i],arr[i])
 bge $t7,$t6,label5
 move $t4,$t7
 b label6
label5:
 move $t4,$t6
label6:
 bge $t4,$t5,loop2  #updating Minimum sum to min(minimum sum,running sum)
 move $t5,$t4
 b loop2
exit_loop2:
 sub $t9,$t9,$t5
 ble $t3,$t9,label7
 move $v0,$t3  #maximum circular subarray sum=max(maximum subarray sum,sum of elements of the array-minimum subarray sum)
 jr $ra  #return to main
label7:
 move $v0,$t9
 jr $ra

main:
 la $a0,message1 #Printing the prompt to provide number of elements
 li $v0,4
 syscall
 jal read_n  #Read n
 la $a0,message2  #Printing prompt to enter the elements of the array
 li $v0,4
 syscall
 jal read_array  #read the elements of the array
 jal calculate_sum  #calculate sum
 move $t0,$v0  #store the return value
 la $a0,message3  #print the maximum circular subarray sum
 li $v0,4
 syscall
 move $a0,$t0
 li $v0,1
 syscall
exit:
 li $v0,10  #Exiting the function
 syscall
#test