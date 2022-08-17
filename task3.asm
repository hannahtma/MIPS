# Your job to fill in! :)

    .globl smash_or_sad

    .data

hulk_smash: .asciiz "Hulk SMASH! >:("
hulk_sad: .asciiz "Hulk Sad :("

newline: .asciiz "\n"

    .text

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

		whileloop:
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
		
		# While i < len(the_list)
		lw $t0, -4($fp)
		lw $t1, +12($fp)
		slt $t2, $t0, $t1 # If t0 < t1, then t2 = 1
		beq $t2, $0, end
		
		# if the_list[i] <= hulk_power
		lw $t0, -4($fp)
		lw $t1, +8($fp)
		sub $t2, $t1, $t0 # $t2 = $t1 - $t0
		slt $t3, $t2, $0 # If t2 < 0, then t3 = 1
		bne $t3 $0, equalsone # Branch if t3 = 1 (t3 >= 0)
		beq $t3, $0, equalszero # Branch if t3 = 0
		beq $t2, $0, equalszero
		
		equalsone:
		# Print "Hulk SMASH! >:("
		la $a0, hulk_smash
		addi $v0, $0, 4
		syscall
		la $a0, newline
		addi $v0, $0, 4
		syscall
		
		lw $t0, -8($fp)
		addi $t0, $t0, 1
		sw $t0, -8($fp)
		
		j arrayloop
		
		equalszero:
		# Print "Hulk Sad :("
		la $a0, hulk_sad
		addi $v0, $0, 4
		syscall
		la $a0, newline
		addi $v0, $0, 4
		syscall
		
		arrayloop:
		lw $t0, -4($fp)
		addi $t0, $t0, 4
		sw $t0, -4($fp)
		
		lw $t0, -4($fp)
		addi $t0, $t0, 1
		sw $t0, -4($fp)
		
		lw $t0, -8($fp)
		mflo $v0
		
		addi $sp, $sp, 16
		lw $fp, ($sp)
		addi $sp, $sp, +4
		lw $ra, ($sp)
		addi $sp, $sp, +4
		
		j whileloop

		# End program
		end:
		jr $ra

# Main
main:	

                    # memory diagram
            ##################################
            # hulk_power	 -   -8($fp) #
            # list_of_numbers    -   -4($fp) #
            # fp                 -    0($fp) #
            ##################################

	addi $sp, $sp, -4
	sw $fp, ($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	
	addi $a0, $0, 16
	addi $v0, $0, 9
	syscall
	sw $v0, -4($fp)
	
	lw $t0, -4($fp)
	
	addi $t1, $0, 3
	sw $t1, ($t0)
	
	addi $t1, $0, 10
	sw $t1, 4($t0)
	
	addi $t1, $0, 14
	sw $t1, 8($t0)
	
	addi $t1, $0, 16
	sw $t1, 12($t0)
	
	lw $t0, -8($fp)
	addi $t0, $0, 15
	sw $t0, -8($fp)
	
	jal smash_or_sad
	