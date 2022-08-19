# Your job to fill in! :)

    .data

space: .asciiz " "
newline: .asciiz "\n"

    .text
    
    .globl insertion_sort

jal main    

insertion_sort:	

                   	# memory diagram
            	##################################
            	# j                  -  -16($fp) #
            	# key                -  -12($fp) #
            	# i	    	     -   -8($fp) #
            	# length             -   -4($fp) #
            	# fp                 -    0($fp) #
            	# ra                 -   +4($fp) #
            	# the_list           -   +8($fp) #
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
		
		# length = len(the_list)
		lw $t0, +8($fp) 
		lw $t1, ($t0) # len(this_list)
		sw $t1, -4($fp)
		
		# Set i = 1
		lw $t0, -8($fp) # Load i into t0
		addi $t0, $0, 1 # Add 1 to t0
		sw $t0, -8($fp) # Store t0 into i
		
		gothroughthelist:	
			# While i < length
			lw $t0, -8($fp) # Load i into t0
			lw $t1, -4($fp) # Load length into t1
			slt $t2, $t0, $t1 # If i < length, then t2 = 1
			beq $t2, $0, finish # If t2 = 0, then branch to finish
		
			# key = the_list[i]
			lw $t0, -8($fp) # Load i into t0
			lw $t1, +8($fp) # Load the_list
			sll $t0, $t0, 2 # t0 = 4*t0
			add $t0, $t0, $t1 # t0 = the_list[i]
			lw $t1, 4($t0) # Load key value
			sw $t1, -12($fp) # Store t0 into key

			# j = i - 1
			lw $t0, -8($fp) # Load i into t0
			addi $t0, $t0 -1 # Add -1 to i
			sw $t0, -16($fp) # Store t0 into j
		
			while:
				# while j >= 0 and  key < the_list[j]
				lw $t0, -16($fp) # Load j into t0
				slt $t1, $t0, $0 # If t0 < 0, then t1 = 1
				bne $t1, $0, continue
			
				lw $t0, -12($fp) # t0 = key
				lw $t1, -16($fp) # t0 = j
				sll $t1, $t1, 2 # t1 = 4*t1
				lw $t2, +8($fp) # Load list address
				add $t3, $t2, $t1
				lw $t4, 4($t3)
			
				slt $t5, $t0, $t4
				beq $t5, $0, continue
			
				# the_list[j+1] = the_list[j]
				lw $t0, -16($fp) # t0 = j
				sll $t0, $t0, 2 # t0 = 4*t0
				lw $t1, +8($fp)
				add $t0, $t0, $t1
				lw $t0, 4($t0)
			
				lw $t1, -16($fp)
				addi $t1, $t1, 1
				sll $t1, $t1, 2 #(j+1)*4
				lw $t2, +8($fp)
				add $t1, $t2, $t1

				
				sw $t0, 4($t1)
			
				# j -= 1
				lw $t0, -16($fp)
				addi $t0, $t0, -1
				sw $t0, -16($fp)
			
				j while
			
			continue:
				# the_list[j+1] = key
				lw $t0, -12($fp) # t0 = key
				lw $t1, -16($fp) # t1 = j
				addi $t1, $t1, 1 # t1 = j + 1
				sll $t1, $t1, 2  # t1 = 4 * t1
				lw $t2, +8($fp) # t2 = address of the_list
				add $t3, $t1, $t2
				sw $t0, 4($t3)
			
				# i += 1
				lw $t0, -8($fp)
				addi $t0, $t0, 1
				sw $t0, -8($fp)
			
				# jump back to whileloop
				j gothroughthelist
		
		finish:
			# Clear local variables off stack
			addi $sp, $sp, 16
		
			# Restores saved $fp off stack
			lw $fp, ($sp)
			addi $sp, $sp, +4
		
			# Restores saved $ra off stack
			lw $ra, ($sp)
			addi $sp, $sp, +4

			# Returns to caller
			jr $ra

main:	
                 # memory diagram         
        ##################################
        # i            	     -   -8($fp) #
        # arr                -   -4($fp) #
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
	addi $sp, $sp, -8
	
	# Allocate space for array 
	addi $a0, $0, 24
	addi $v0, $0, 9
	syscall
	sw $v0, -4($fp)
	
	# Set arr = [6, -2, 7, 4, -10]
	lw $t0, -4($fp)
	
	addi $t1, $0, 5
	sw $t1, ($t0)
	
	addi $t1, $0, 6
	sw $t1, 4($t0)
	
	addi $t1, $0, -2
	sw $t1, 8($t0)
	
	addi $t1, $0, 7
	sw $t1, 12($t0)
	
	addi $t1, $0, 4
	sw $t1, 16($t0)
	
	addi $t1, $0, -10
	sw $t1, 20($t0)
	
	# Store i = 0
	lw $t0, -8($fp)
	sw $0, -8($fp)
	
	# Pass arr into arg the_list
	addi $sp $sp, -4
	lw $t0, -4($fp)
	sw $t0, ($sp)
	
	jal insertion_sort
	
	gothrougharr:		
		# While i < len(arr)
		lw $t0, -8($fp) # t0 = i
		lw $t1, -4($fp) # t1 = address of arr
		lw $t2, ($t1) # t2 = len(arr)
		slt $t3, $t0, $t2
		beq $t3, $0, end

		# arr[i]
		lw $t0, -8($fp) # t0 = i
		lw $t1, -4($fp)
		sll $t0, $t0, 2 # t0 = 4*t0
		add $t0, $t0, $t1
		lw $a0, 4($t0)
		
		addi $a0, $a0, 0
		addi $v0, $0, 1
		syscall
		add $v0, $0, 4
		la $a0, space
		syscall
		
		# i += 1
		lw $t0, -8($fp)
		addi $t0, $t0, 1
		sw $t0, -8($fp)
		
		j gothrougharr
		
	end:
		la $a0, newline
		addi $v0, $0, 4
		syscall
		
		lw $ra, ($sp)
		addi $sp, $sp, +4
		lw $fp, ($sp)
		addi $sp, $sp, +4

		addi $v0, $0, 10
		syscall
		