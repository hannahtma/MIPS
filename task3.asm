# Your job to fill in! :)

    .data

hulk_smash: .asciiz "Hulk SMASH! >:("
hulk_sad: .asciiz "Hulk Sad :("

newline: .asciiz "\n"

    .text
smash_or_sad:	# smash_or_sad function

                    # memory diagram
            ##################################
            # smash_count	 -   -8($fp) #
            # i                  -   -4($fp) #
            # fp                 -    0($fp) #
            # ra                 -   +4($fp) #
            # the_list           -   +8($fp) #
            # hulk_power         -  +12($fp) #
            ##################################

		addi $sp, $sp, -4
		sw $ra, ($sp)
		addi $sp, $sp, -4
		sw $fp, ($sp)
		addi $fp, $sp, 0
		addi $sp, $sp, -16
		
		lw $t0, -8($fp)
		sw $0, -8($fp)
		
		lw $t0, -4($fp)
		sw $0, -4($fp)
		
		lw $t0, -4($fp)
		lw $t1, +8($fp)
		slt $t2, $t0, $t1 # If t0 < t1, then t2 = 1
		beq $t2, $0, end
		
		arrayloop:
		lw $t0, -4($fp)
		addi $t0, $t0, 4
		sw $t0, -4($fp)
		lw $t1, +12($fp)
		sub $t2, $t1, $t0 # $t2 = $t1 - $t0
		slt $t3, $t2, $0 # If t2 < 0, then t3 = 1
		bne $t3 $0, equalsone # Branch if t3 = 0 (t3 >= 0)
		
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
		
		equalsone:
		# Print "Hulk Sad :("
		la $a0, hulk_sad
		addi $v0, $0, 4
		syscall
		la $a0, newline
		addi $v0, $0, 4
		syscall
		
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
	