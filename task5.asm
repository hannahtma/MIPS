# Your job to fill in! :)

    .data



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
			addi $sp, $sp, -8
			
			# data = [0] * r
			lw $t0, +12($fp)
			addi $t0, $t0, 1
			sll $a0, $t0, 2
			syscall
			sw $v0, -4($fp)
			
			lw $t0, +12($fp)
			lw $t1, -4($fp)
			sw $t0, ($t1)
			
			jal combination_aux
			
			# Clear local variables off stack
			addi $sp, $sp, 8
		
			# Restores saved $fp off stack
			lw $fp, ($sp)
			addi $sp, $sp, +4
		
			# Restores saved $ra off stack
			lw $ra, ($sp)
			addi $sp, $sp, +4
			
			jr $ra
			
combination_aux:	

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
			addi $sp, $sp, -8
			
			TODO	
			
			# Clear local variables off stack
			addi $sp, $sp, 8
		
			# Restores saved $fp off stack
			lw $fp, ($sp)
			addi $sp, $sp, +4
		
			# Restores saved $ra off stack
			lw $ra, ($sp)
			addi $sp, $sp, +4
			
			jr $ra		
			
main:	
	
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
	
	# Clear local variables off stack
	addi $sp, $sp, 12
		
	# Restores saved $fp off stack
	lw $fp, ($sp)
	addi $sp, $sp, +4
		
	# Restores saved $ra off stack
	lw $ra, ($sp)
	addi $sp, $sp, +4

	jal print_combination

	addi $v0, $0, 10
	syscall
