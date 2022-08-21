# Your job to fill in! :)

    .data

hulk_smash: .asciiz "Hulk SMASH! >:("
hulk_sad: .asciiz "Hulk Sad :("

front_output: .asciiz "Hulk smashed "
back_output: .asciiz " people"

newline: .asciiz "\n"

    .text
    
    .globl smash_or_sad

jal main    

smash_or_sad:	# smash_or_sad(the_list, hulk_power)

                    	# memory diagram
            	##################################
            	# smash_count	     -   -8($fp) #
            	# i                  -   -4($fp) #
            	# fp                 -    0($fp) #
           	 	# ra                 -   +4($fp) #
            	# the_list           -   +8($fp) #
            	# hulk_power         -  +12($fp) #
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
				
				# smash_count = 0
				sw $0, -8($fp)
				
				# i = 0
				sw $0, -4($fp)
				
				whileloop:		
					# While i < len(the_list)
					lw $t0, +8($fp) # t0 = address of the_list
					lw $t1, ($t0) # t1 = len(the_list)
					lw $t0, -4($fp) # t0 = i
					slt $t2, $t0, $t1 # if i < len(the_list), then t2 = 1
					beq $t2, $0, end # if t2 == 0, then branch to end

					# if the_list[i] <= hulk_power:
					lw $t0, -4($fp) # t0 = i
					lw $t1, +8($fp) # t1 = address of the_list
					sll $t0, $t0, 2 # t0 = 4 * i
					add $t0, $t0, $t1 # t0 = 4 * i + address of the_list
					lw $t0, 4($t0) # a0 = the_list[i]
					
					lw $t3, +12($fp) # t3 = hulk_power
					slt $t4, $t3, $t0 # if hulk_power < the_list[i], then t4 = 1
					bne $t4, $0, hulksad # if t4 != 0, then branch to hulksad

					# print("Hulk SMASH! >:(")
					la $a0, hulk_smash
					addi $v0, $0, 4
					syscall
					# Print newline
					la $a0, newline
					addi $v0, $0, 4
					syscall
					
					# smash_count += 1
					lw $t0, -8($fp) # t0 = smash_count
					addi $t0, $t0, 1 # t0 = t0 + 1
					sw $t0, -8($fp) # smash_count += 1
					
					# Jump to continue
					j continue
					
					hulksad:
						# print("Hulk Sad :(")
						la $a0, hulk_sad
						addi $v0, $0, 4
						syscall
						# Print newline
						la $a0, newline
						addi $v0, $0, 4
						syscall
					
					continue:
						# i += 1
						lw $t0, -4($fp)
						addi $t0, $t0, 1
						sw $t0, -4($fp)
						
						# Jump back to whileloop
						j whileloop
				
				end:
					# Set $v0 = smash_count
					lw $t0, -8($fp) # t0 = smash_count
					addi $v0, $t0, 0 # v0 = t0
					
					# Clear local variables off stack
					addi $sp, $sp, 8
					
					# Restores saved $fp off stack
					lw $fp, ($sp)
					addi $sp, $sp, +4
					
					# Restores saved $ra off stack
					lw $ra, ($sp)
					addi $sp, $sp, +4

					# Leave smash_or_sad() function
					jr $ra

main:		# main()

                    # memory diagram
            ##################################
            # hulk_power	     -   -8($fp) #
            # list_of_numbers    -   -4($fp) #
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
			
			# Allocate space for my_list
			addi $a0, $0, 16
			addi $v0, $0, 9
			syscall

			# Save my_list to stack
			sw $v0, -4($fp)
			
			# my_list = [10, 14, 16]
			lw $t0, -4($fp)
			
			# len(my_list)
			addi $t1, $0, 3
			sw $t1, ($t0)
			
			# my_list[0] = 10
			addi $t1, $0, 10
			sw $t1, 4($t0)
			
			# my_list[0] = 14
			addi $t1, $0, 14
			sw $t1, 8($t0)
			
			# my_list[0] = 16
			addi $t1, $0, 16
			sw $t1, 12($t0)
			
			# hulk_power = 15
			lw $t0, -8($fp) # t0 = hulk_power
			addi $t0, $t0, 15 # t0 = t0 + 15
			sw $t0, -8($fp) # hulk_power = t0
			
			# Pass my_list as argument
			addi $sp $sp, -4
			lw $t0, -4($fp)
			sw $t0, ($sp)
			
			# Pass hulk_power as argument
			addi $sp, $sp, -4
			lw $t0, -8($fp)
			sw $t0, ($sp)
			
			# call smash_or_sad(my_list, hulk_power)
			jal smash_or_sad
			
			# Clears arguments off stack
			addi $sp, $sp, 8
			
			# Print "Hulk smashed "
			la $a0, front_output
			addi $v0, $0, 4
			syscall
			
			# Print smash_count (return value)
			addi $a0, $t0, 0
			addi $v0, $0, 1
			syscall
			
			# Print " people"
			la $a0, back_output
			add $v0, $0, 4
			syscall
			# Print newline
			la $a0, newline
			add $v0, $0, 4
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
			