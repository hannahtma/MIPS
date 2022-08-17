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

smash_or_sad:	# smash_or_sad function

                    # memory diagram
            ##################################
            # smash_count	 -   -8($fp) #
            # i                  -   -4($fp) #
            # fp                 -    0($fp) #
            # ra                 -   +4($fp) #
            # hulk_power         -   +8($fp) #
            # the_list           -  +12($fp) #
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
		
		# smash_count = 0
		lw $t0, -8($fp)
		sw $0, -8($fp)
		
		# i = 0
		lw $t0, -4($fp)
		sw $0, -4($fp)
		
		whileloop:		
		# While i < len(the_list)
		lw $t0, +12($fp)
		lw $t1, ($t0)
		lw $t0, -4($fp)
		slt $t2, $t0, $t1
		beq $t2, $0, end

		# the_list[i]
		lw $t0, -4($fp) # t0 = i
		lw $t1, +12($fp)
		sll $t0, $t0, 2 # t0 = 4*t0
		add $t0, $t0, $t1
		lw $a0, 4($t0)
		
		lw $t3, +8($fp) # t3 = hulk_power
		slt $t4, $t3, $a0 # If t2 < t3 (the_list[i] < hulk_power), then t4 = 1
		bne $t4, $0, hulksad # Branch if t4 = 0

		# Print "Hulk SMASH! >:("
		la $a0, hulk_smash
		addi $v0, $0, 4
		syscall
		la $a0, newline
		addi $v0, $0, 4
		syscall
		
		# smash_count += 1
		lw $t0, -8($fp)
		addi $t0, $t0, 1
		sw $t0, -8($fp)
		
		j continue
		
		hulksad:
		# Print "Hulk Sad :("
		la $a0, hulk_sad
		addi $v0, $0, 4
		syscall
		la $a0, newline
		addi $v0, $0, 4
		syscall
		
		continue:
		# i += 1
		lw $t0, -4($fp)
		addi $t0, $t0, 1
		sw $t0, -4($fp)
		
		j whileloop
		
		end:
		# Set $v0 = smash_count
		lw $t0, -8($fp)
		addi $v0, $t0, 0
		
		# Clear local variables off stack
		addi $sp, $sp, 16
		
		# Restores saved $fp off stack
		lw $fp, ($sp)
		addi $sp, $sp, +4
		
		# Restores saved $ra off stack
		lw $ra, ($sp)
		addi $sp, $sp, +4

		jr $ra

# Main
main:	

                    # memory diagram
            ##################################
            # hulk_power	 -   -8($fp) #
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
	
	addi $a0, $0, 16
	addi $v0, $0, 9
	syscall
	sw $v0, -4($fp)
	
	# Set array = [10, 14, 16]
	lw $t0, -4($fp)
	
	addi $t1, $0, 3
	sw $t1, ($t0)
	
	addi $t1, $0, 10
	sw $t1, 4($t0)
	
	addi $t1, $0, 14
	sw $t1, 8($t0)
	
	addi $t1, $0, 16
	sw $t1, 12($t0)
	
	# Store hulk_power = 15
	lw $t0, -8($fp)
	addi $t0, $0, 15
	sw $t0, -8($fp)
	
	# Pass list_of_numbers into arg the_list
	addi $sp $sp, -4
	lw $t0, -4($fp)
	sw $t0, ($sp)
	
	# Pass hulk_power into arg hulk_power
	addi $sp, $sp, -4
	lw $t0, -8($fp)
	sw $t0, ($sp)
	
	# Call function smash_or_sad
	jal smash_or_sad
	
	# Clears arguments off stack
	addi $sp, $sp, 8
	
	#addi $a0, $v0, 0#
	
	la $a0, front_output
	addi $v0, $0, 4
	syscall
	
	# Print the return value
	addi $a0, $t0, 0
        addi $v0, $0, 1
        syscall
	
	la $a0, back_output
	add $v0, $0, 4
	syscall
	la $a0, newline
	add $v0, $0, 4
	syscall
	
	addi $sp, $sp, +4
	lw $fp, ($sp)	
	addi $sp, $sp, +4
	lw $ra, ($sp)	
	
	addi $v0, $0, 10
	syscall
	