# Name: Hannah Tang Mei Ann
# Student ID: 32950624

    .data

space: .asciiz " "
newline: .asciiz "\n"

    .text
    
    .globl insertion_sort

jal main    

insertion_sort:		# insertion_sort(the_list)

						# memory diagram
					##################################
					# j                  -  -16($fp) #
					# key                -  -12($fp) #
					# i	    	     	 -   -8($fp) #
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
					lw $t0, +8($fp) # t0 = address of the_list
					lw $t1, ($t0) # len(this_list)
					sw $t1, -4($fp) # length = len(the_list)
					
					# Set i = 1
					lw $t0, -8($fp) # t0 = i
					addi $t0, $0, 1 # t0 = t0 + 1
					sw $t0, -8($fp) # i = t0
					
					gothroughthelist:	
						# While i < length
						lw $t0, -8($fp) # t0 = i
						lw $t1, -4($fp) # t1 = length
						slt $t2, $t0, $t1 # if i < length, then t2 = 1
						beq $t2, $0, finish # if t2 = 0, then branch to finish
					
						# key = the_list[i]
						lw $t0, -8($fp) # t0 = i
						lw $t1, +8($fp) # t1 = address of the_list
						sll $t0, $t0, 2 # t0 = 4 * i
						add $t0, $t0, $t1 # t0 = the_list[i]
						lw $t1, 4($t0) # t1 = key
						sw $t1, -12($fp) # key = the_list[i]

						# j = i - 1
						lw $t0, -8($fp) # t0 = i
						addi $t0, $t0 -1 # t0 = i - 1
						sw $t0, -16($fp) # j = i - 1
					
						while:
							# while j >= 0 and  key < the_list[j]
							lw $t0, -16($fp) # t0 = j
							slt $t1, $t0, $0 # if j < 0, then t1 = 1
							bne $t1, $0, continue # if t1 != 0, then branch to continue
						
							lw $t0, -12($fp) # t0 = key
							lw $t1, -16($fp) # t0 = j
							sll $t1, $t1, 2 # t1 = 4 * j
							lw $t2, +8($fp) # t2 = address of the_list
							add $t3, $t2, $t1 # t3 = address of the_list + 4 * j
							lw $t4, 4($t3) # t4 = the_list[j]
						
							slt $t5, $t0, $t4 # if key < the_list[j], then t5 = 1
							beq $t5, $0, continue # if t5 = 0, then branch to continue
						
							# the_list[j+1] = the_list[j]
							lw $t0, -16($fp) # t0 = j
							sll $t0, $t0, 2 # t0 = 4 * j
							lw $t1, +8($fp) # t1 = address of the_list
							add $t0, $t0, $t1 # t0 = the_list[j]
						
							lw $t1, -16($fp) # t1 = j
							addi $t1, $t1, 1 # # t1 = j + 1
							sll $t1, $t1, 2 # t1 = 4 * (j + 1)
							lw $t2, +8($fp) # t2 = address of the_list
							add $t1, $t2, $t1 # t1 = the_list[j+1]

							# the_list[j + 1] = the_list[j]
							lw $t0, 4($t0)  # t0 = the_list[j]
							sw $t0, 4($t1) # 4(t1) = t0
						
							# j -= 1
							lw $t0, -16($fp) # t0 = j
							addi $t0, $t0, -1 # t0 = j - 1
							sw $t0, -16($fp) # j = t0
						
							# Jump back to while loop
							j while
						
						continue:
							# the_list[j+1] = key
							lw $t0, -12($fp) # t0 = key
							lw $t1, -16($fp) # t1 = j
							addi $t1, $t1, 1 # t1 = j + 1
							sll $t1, $t1, 2  # t1 = 4 * (j + 1)
							lw $t2, +8($fp) # t2 = address of the_list
							add $t3, $t1, $t2 # t3 = 4 * (j + 1) + address of the_list
							sw $t0, 4($t3) # t0 = the_list[j + 1]
						
							# i += 1
							lw $t0, -8($fp) # t0 = i
							addi $t0, $t0, 1 # t0 = i + 1
							sw $t0, -8($fp) # i = t0
						
							# Jump back to for loop
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
		
		# Allocate space for arr
		addi $a0, $0, 24
		addi $v0, $0, 9
		syscall

		# Store arr into space
		sw $v0, -4($fp)
		
		# arr = [6, -2, 7, 4, -10]
		lw $t0, -4($fp)
		
		# len(arr)
		addi $t1, $0, 5
		sw $t1, ($t0)
		
		# arr[0] = 6
		addi $t1, $0, 6
		sw $t1, 4($t0)
		
		# arr[1] = -2
		addi $t1, $0, -2
		sw $t1, 8($t0)
		
		# arr[2] = 7
		addi $t1, $0, 7
		sw $t1, 12($t0)
		
		# arr[3] = 4
		addi $t1, $0, 4
		sw $t1, 16($t0)
		
		# arr[4] = -10
		addi $t1, $0, -10
		sw $t1, 20($t0)
		
		# i = 0
		sw $0, -8($fp)
		
		# Pass arr as argument
		addi $sp $sp, -4
		lw $t0, -4($fp)
		sw $t0, ($sp)
		
		# insertion_sort(arr)
		jal insertion_sort
		
		gothrougharr:		
			# While i < len(arr)
			lw $t0, -8($fp) # t0 = i
			lw $t1, -4($fp) # t1 = address of arr
			lw $t2, ($t1) # t2 = len(arr)
			slt $t3, $t0, $t2 # if i < len(arr), then t3 = 1
			beq $t3, $0, end # if t3 == 0, then branch to end

			# arr[i]
			lw $t0, -8($fp) # t0 = i
			lw $t1, -4($fp) # t1 = address of arr
			sll $t0, $t0, 2 # t0 = 4 * i
			add $t0, $t0, $t1 # t0 = 4 * i + address of arr
			lw $a0, 4($t0) # a0 = arr[i]
			
			# Print arr[i]
			addi $v0, $0, 1
			syscall
			# Print space
			add $v0, $0, 4
			la $a0, space
			syscall
			
			# i += 1
			lw $t0, -8($fp) # t0 = i
			addi $t0, $t0, 1 # t0 = i + 1
			sw $t0, -8($fp) # i = t0
			
			# Jump back to for loop
			j gothrougharr
			
		end:
			# Print newline
			la $a0, newline
			addi $v0, $0, 4
			syscall
			
			# Restores saved $ra off stack
			lw $ra, ($sp)	
			addi $sp, $sp, +4

			# Restores saved $fp off stack
			lw $fp, ($sp)
			addi $sp, $sp, +4
			
			# End program
			addi $v0, $0, 10
			syscall
			