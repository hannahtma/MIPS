# Your job to fill in! :)

    .data

space: .asciiz " "
newline: .asciiz "\n"

    .text

    .globl print_combination
    .globl combination_aux

jal main    

print_combination: 	# print_combination function

            		        # memory diagram
            		##################################
            		# data               -   -4($fp) #
            		# fp                 -    0($fp) #
            		# ra                 -   +4($fp) #
            		# arr                -   +8($fp) #
            		# r	             -  +12($fp) #
            		# n	             -  +16($fp) #
            		##################################

			# Save value of $ra on stack
			addi $sp, $sp, -4
			sw $ra, ($sp)
		
			# Save value of $fp on stack
			addi $sp, $sp, -4
			sw $fp, ($sp)
		
			# Copy $sp to $fp
			addi $fp, $sp, 0
		
			# Allocate local variables on stack
			addi $sp, $sp, -4
			
			# data = [0] * r
			lw $t0, +12($fp)
			addi $t0, $t0, 1
			sll $a0, $t0, 2
			addi $v0, $0, 9
			syscall
			sw $v0, -4($fp)
			
			lw $t0, +12($fp) 
			lw $t1, -4($fp)
			sw $t0, ($t1)
			
			# Pass arr as argument
			addi $sp, $sp, -4
			lw $t0, +8($fp)
			sw $t0, ($sp)
			
			# Pass n as argument
			addi $sp $sp, -4
			lw $t0, +12($fp)
			sw $t0, ($sp)
	
			# Pass r as argument
			addi $sp, $sp, -4
			lw $t0, +16($fp)
			sw $t0, ($sp)
			
			# Pass 0 as argument
			addi $t0, $0, 0
			sw $t0, 4($sp)
			
			# Pass data as argument
			addi $sp $sp, -4
			lw $t0, -4($fp)
			sw $t0, ($sp)
	
			# Pass 0 as argument
			addi $t0, $0, 0
			sw $t0, 4($sp)
			
			# Call combination_aux
			jal combination_aux
			
			# Clear local variables off stack
			addi $sp, $sp, 4
		
			# Restores saved $fp off stack
			lw $fp, ($sp)
			addi $sp, $sp, +4
		
			# Restores saved $ra off stack
			lw $ra, ($sp)
			addi $sp, $sp, +4
			
			# Leave function
			jr $ra
			
combination_aux:	# combination_aux funtion

            		        # memory diagram
            		##################################
            		# i		     -  -12($fp) #   
            		# j		     -   -8($fp) #
            		# index		     -   -4($fp) #
            		# fp                 -    0($fp) #
            		# ra                 -   +4($fp) #
            		# data       	     -   +8($fp) #
            		# arr                -  +12($fp) #
            		# r	             -  +16($fp) #
            		# n	             -  +20($fp) #
            		##################################

			# Save value of $ra on stack
			addi $sp, $sp, -4
			sw $ra, ($sp)
		
			# Save value of $fp on stack
			addi $sp, $sp, -4
			sw $fp, ($sp)
		
			# Copy $sp to $fp
			addi $fp, $sp, 0
		
			# Allocate local variables on stack
			addi $sp, $sp, -16
			
			# if (index == r)
			lw $t0, -4($fp) # t0 = index
			lw $t1, +16($fp) # t1 = r
			bne $t0, $t1, secondblock # if index != r, then branch to secondblock
			
			# Initialise j = 0
			lw $t0, -8($fp) # t0 = j
			sw $0, -8($fp) # j = 0
			
			forjinranger:	# While j < r
					lw $t0, -8($fp) # t0 = j
					lw $t1, +16($fp) # t1 = r
					slt $t2, $t0, $t1 # if t0 < t1, then t2 = 1
					beq $t2, $0, leaveforloop # if t2 == 0, then branch to secondblock
					
					# data[j]
					lw $t0, -8($fp) # t0 = j
					sll $t0, $t0, 2 # t0 = 4 * t0
					lw $t1, +8($fp) # t1 = address of data
					add $t2, $t0, $t1 # t2 = data[j]
					
					# print(data[j], end = " ")
					lw $a0, 4($t2) # Load data[j]
					addi $v0, $0, 1 # Print data[j]
					syscall
					add $v0, $0, 4
					la $a0, space
					syscall # print space
					
					# jump back to for loop
					j forjinranger
			
			leaveforloop: 	# print()
					lw $a0, newline
					addi $v0, $0, 4
					syscall # print newline
					
					# jump to return
					j return
			
			secondblock:	# if (i >= n) 
					lw $t0, -12($fp) # t0 = i
					lw $t1, +20($fp) # t1 = n
					slt $t2, $t0, $t1 # if i < n, then t2 = 1
					bne $t2, $0, lastpart # if t2 != 0 (i >= n), then branch to lastpart
					
					# jump to return
					j return
			
			lastpart:	# arr[i]
					lw $t0, -12($fp) # t0 = i
					sll $t0, $t0, 2 # t0 = 4 * i
					lw $t1, +12($fp) # t1 = address of arr
					add $t2, $t0, $t1 # t2 = arr[i]
					
					# data[index]
					lw $t0, -4($fp) # t0 = index
					sll $t0, $t0, 2 # t0 = 4 * index
					lw $t1, +8($fp) # t1 = address of data
					add $t3, $t0, $t1 # t3 = data[index]
					
					# data[index] = arr[i]
					lw $t0, 4($t2)
					sw $t0, 4($t3)
					
					# Pass arr as argument
					addi $sp, $sp, -4
					lw $t0, +12($fp)
					sw $t0, ($sp)
			
					# Pass n as argument
					addi $sp $sp, -4
					lw $t0, +20($fp)
					sw $t0, ($sp)
	
					# Pass r as argument
					addi $sp, $sp, -4
					lw $t0, +16($fp)
					sw $t0, ($sp)
			
					# Pass index+1 as argument
					addi $sp, $sp, -4
					lw $t0, -4($fp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
			
					# Pass data as argument
					addi $sp $sp, -4
					lw $t0, +8($fp)
					sw $t0, ($sp)
	
					# Pass i+1 as argument
					addi $sp, $sp, -4
					lw $t0, -12($fp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
					
					# call combination_aux
					jal combination_aux
					
					# Pass arr as argument
					addi $sp, $sp, -4
					lw $t0, +12($fp)
					sw $t0, ($sp)
			
					# Pass n as argument
					addi $sp $sp, -4
					lw $t0, +20($fp)
					sw $t0, ($sp)
	
					# Pass r as argument
					addi $sp, $sp, -4
					lw $t0, +16($fp)
					sw $t0, ($sp)
			
					# Pass index as argument
					addi $sp, $sp, -4
					lw $t0, -4($fp)
					sw $t0, ($sp)
			
					# Pass data as argument
					addi $sp $sp, -4
					lw $t0, +8($fp)
					sw $t0, ($sp)
	
					# Pass i+1 as argument
					addi $sp, $sp, -4
					lw $t0, -12($fp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
					
					# call combination_aux
					jal combination_aux
				
			return:		# Clear local variables off stack
					addi $sp, $sp, 8
			
					# Restores saved $fp off stack
					lw $fp, ($sp)
					addi $sp, $sp, +4
		
					# Restores saved $ra off stack
					lw $ra, ($sp)
					addi $sp, $sp, +4
			
					# Leave function
					jr $ra		
			
main:	# Main program
	
		# memory diagram
	##################################
	# n		     -  -12($fp) #
	# r		     -   -8($fp) #
	# arr		     -   -4($fp) #
	# fp                 -    0($fp) #
	##################################

	# Save value of $ra on stack
	addi $sp, $sp, -4
	sw $ra, ($sp)
		
	# Save value of $fp on stack
	addi $sp, $sp, -4
	sw $fp, ($sp)
	
	# Copy $sp to $fp
	addi $fp, $sp, 0
	
	# Allocate local variables on stack
	addi $sp, $sp, -12
	
	# Create space for array
	addi $a0, $0, 24
	addi $v0, $0, 9
	syscall
	sw $v0, -4($fp)
	
	# Set arr = [1, 2, 3, 4, 5]
	lw $t0, -4($fp)
	
	addi $t1, $0, 5
	sw $t1, ($t0)
	
	addi $t1, $0, 1
	sw $t1, 4($t0)
	
	addi $t1, $0, 2
	sw $t1, 8($t0)
	
	addi $t1, $0, 3
	sw $t1, 12($t0)
	
	addi $t1, $0, 4
	sw $t1, 16($t0)
	
	addi $t1, $0, 5
	sw $t1, 20($t0)
	
	# r = 3
	lw $t0, -8($fp)
	addi $t0, $0, 3
	sw $t0, -8($fp)
	
	# n = len(arr)
	lw $t0, -4($fp)
	lw $t1, ($t0)
	sw $t1, -12($fp)
	
	# Pass arr as argument
	addi $sp, $sp, -4
	lw $t0, -4($fp)
	sw $t0, ($sp)
	
	# Pass r as argument
	addi $sp, $sp, -4
	lw $t0, -8($fp)
	sw $t0, ($sp)
	
	# Pass n as argument
	addi $sp, $sp, -4
	lw $t0, -12($fp)
	sw $t0, ($sp)
	
	# Call print_combination
	jal print_combination
	
	# Clear local variables (arguments) off stack
	addi $sp, $sp, 12
		
	# Restores saved $fp off stack
	lw $fp, ($sp)
	addi $sp, $sp, +4
		
	# Restores saved $ra off stack
	lw $ra, ($sp)
	addi $sp, $sp, +4

	# End program
	addi $v0, $0, 10
	syscall
