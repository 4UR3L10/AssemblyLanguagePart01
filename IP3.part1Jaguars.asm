#################################################################################################
# "RAM"
      .data
arr:  .word   0 : 12        # array of 12 ints (assuming 32-bit machine, 1 word=32 bits)
N:   .word  12             # size of array 
      .text
      la $s0, arr          # $s0 = arr (its starting address)
      la $t0, N          
      lw $s1, 0($t0)	   # $s1 = N
      
      #####################################################################
      # Populate arr
      addi $t0, $zero, 55  
      sw $t0, 0($s0)        # arr[0] = 55
      addi $t0, $zero, 88
      sw $t0, 4($s0)        # arr[1] = 88
      addi $t0, $zero, 0
      sw $t0, 8($s0)        # arr[2] = 0
      addi $t0, $zero, 22
      sw $t0, 12($s0)       # arr[3] = 22
      addi $t0, $zero, 77
      sw $t0, 16($s0)       # arr[4] = 77
      addi $t0, $zero, 11
      sw $t0, 20($s0)       # arr[5] = 11
      addi $t0, $zero, 99
      sw $t0, 24($s0)       # arr[6] = 99
      addi $t0, $zero, 33
      sw $t0, 28($s0)       # arr[7] = 33
      addi $t0, $zero, 110
      sw $t0, 32($s0)       # arr[8] = 110
      addi $t0, $zero, 66
      sw $t0, 36($s0)       # arr[9] = 66
      addi $t0, $zero, 121
      sw $t0, 40($s0)       # arr[10] = 121
      addi $t0, $zero, 44
      sw $t0, 44($s0)       # arr[11] = 44
      ###################################################################

      ###################################################################
      # PRINT ARRAY
      addi $sp, $sp, -8
      sw $a0, 0($sp)
      sw $a1, 4($sp)
      add $a0, $s0, $zero
      add $a1, $s1, $zero
      jal print
      lw $a1, 4($sp)
      lw $a0, 0($sp)
      addi $sp, $sp, 8
      ######################################################################
      
      ######################################################################
      # i and j values
      addi $s2, $zero, 2   # $s2 = Value for i (try different values)
      addi $s3, $zero, 5   # $s3 = Value for j (try different values)
      ######################################################################
      
      ######################################################################
      # PUT SWAP CODE HERE (IP3 Part 1)    
      
      # Getting the value of i to a variable.     
      sll $t1, $s2, 2      # int tempI = 2 * i (Creates a temp register to get the index of i)      
      addu $t1, $s0, $t1   # tempI = BaseRAM + tempI (Add the base RAM plus the index to get the exac location in RAM)
      lw $s4, 0($t1)       # int variable = arr[i] 
           
      # Getting the value of j to a temporary.                 
      sll $t2, $s3, 2      # int tempJ = 2 * j (Creates a temp register to get the index of j)
      addu $t2, $s0, $t2   # tempJ = BaseRAM + tempJ (Add the base RAM plus the index to get the exac location in RAM)     
      lw $t3, 0($t2)       # int temporary = arr[j]
      
      # Swapping the values.
      sw $t3, 0($t1)       # arr[i] = temporary (Saves the value of temporary variable in arr[i])
      sw $s4, 0($t2)       # arr[j] = variable  (Saves the value of i in arr[j])
      ######################################################################
      
      ######################################################################
      # PRINT ARRAY AGAIN
      addi $sp, $sp, -8
      sw $a0, 0($sp)
      sw $a1, 4($sp)
      add $a0, $s0, $zero
      add $a1, $s1, $zero
      jal print
      lw $a1, 4($sp)
      lw $a0, 0($sp)
      addi $sp, $sp, 8
      ######################################################################

      ######################################################################
      # MARS STUFF, DO NOT MODIFY
      li   $v0, 10          # system call for exit
      syscall               # we are out of here.
      ######################################################################


###########################################################################
# PRINT FUNCTION, DO NOT MODIFY
      .data
space:.asciiz  " "          # space to insert between numbers
head: .asciiz  "\nArray:\n"
      .text
print:  addi $sp, $sp, -4
      sw $s0, 0($sp)
      add  $s0, $zero, $a0  # starting address of array
      add  $t1, $zero, $a1  # initialize loop counter to array size
      la   $a0, head        # load address of print heading
      li   $v0, 4           # specify Print String service
      syscall               # print heading
again: lw   $a0, 0($s0)      # load number for syscall
      li   $v0, 1           # specify Print Integer service
      syscall               # print number
      la   $a0, space       # load address of spacer for syscall
      li   $v0, 4           # specify Print String service
      syscall               # output string
      addi $s0, $s0, 4      # increment address
      addi $t1, $t1, -1     # decrement loop counter
      bne $t1, $zero, again # repeat if not finished
      lw $s0, 0($sp)
      addi $sp, $sp, 4      
      jr   $ra              # return
###########################################################################
