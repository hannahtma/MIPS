# Name: Hannah Tang Mei Ann
# Student ID: 32950624

    .data
height: .word 0
space: .asciiz " "
valid_input: .word 0

height_prompt: .asciiz "How tall do you want the tower: "
height_difference: .word 0

i: .word 0
s: .word 0
r: .word 0

final_s: .word 0
final_r: .word 0

a: .asciiz "A "
star: .asciiz "* "

emptystring: .asciiz ""
newline: .asciiz "\n"

    .text
whilezero:	# While valid_input == 0:
			# Print "How tall do you want the tower: "
			la $a0, height_prompt
			addi $v0, $0, 4
			syscall

			# Take input for height
			addi $v0, $0, 5
			syscall
			sw $v0, height
			
			# Calculate if the height is >= 5 (height < 5)
			lw $t0, height # t0 = height
			addi $t1 $0, 5 # t1 = 5
			slt $t2, $t0, $t1 # if height < 5, then t2 = 1
			bne $t2, $0, whilezero
			
			# valid_input = 1
			lw $t0, valid_input # t0 = valid_input
			addi $t0, $0, 1 # t0 = t0 + 1
			sw $t0, valid_input # valid_input = t0
	
whileloop:	# While i < height:
			lw $t0, i # t0 = i
			lw $t1, height # t1 = height
			slt $t2, $t0, $t1 # if i < height, then t2 = 1
			beq $t2, $0, end # if t2 = 0, then branch to end
			
			lw $t0, height # t0 = height
			addi $t1, $0, 1 # t1 = 1
			add $t2, $t0, $t1 # t2 = height + 1
			addi $t3, $0, -1 # t3 = -1
			mult $t2, $t3 # (height + 1) * -1
			mflo $t4 # t4 = (height + 1) * -1
			sw $t4, s # s = (height + 1) * -1
			
			lw $t0, i # t0 = i
			addi $t1, $0, -1 # t1 = -1
			mult $t0, $t1 # i * -1
			mflo $t2 # t2 = i * -1
			sw $t2, final_s # final_s = 0
			
			lw $t0, i # t0 = i
			addi $t1, $0, 1 # t1 = 1
			add $t2, $t0, $t1 # t2 = i + 1
			sw $t2, final_r # final_r = i + 1
	
spaceloop:	# r = 0
			sw $0, r
			
			# for s in range((height+1)*-1, -i):
			lw $t0, s # t0 = s
			lw $t1, final_s # t1 = -i
			slt $t2, $t0, $t1 # if s < -i, then t2 = 1
			beq $t2, $0, starloop # if t2 = 0, then branch to starloop
			
			# Print space
			la $a0, space
			addi $v0, $0, 4
			syscall
			# Print empty string
			la $a0, emptystring
			add $v0, $0, 4
			syscall
			
			# s += 1
			lw $t0, s # t0 = s
			addi $t0, $t0, 1 # t0 = s + 1
			sw $t0, s # s = t0
			
			# Jump back to spaceloop
			j spaceloop
	
starloop: 	# for r in range(i+1):
			lw $t0, r # t0 = r
			lw $t1, final_r # t1 = i+1
			slt $t2, $t0, $t1 # if r < i + 1, then t2 = 1
			beq $t2, $0, continue # if t2 = 0, then branch to end
			
			# if i == 0:
			lw $t0, i # t0 = i
			beq $t0, $0, ifzero # if i == 0, then branch to ifzero
			
			# Jump to notzero
			j notzero
	
ifzero:		# print("A ", end="")
			la $a0, a
			addi $v0, $0, 4
			syscall
			add $v0, $0, 4
			la $a0, emptystring
			syscall
				
			# Jump to skipnotzero
			j skipnotzero
        
notzero:	# print("* ", end="")
			la $a0, star
			addi $v0, $0, 4
			syscall
			add $v0, $0, 4
			la $a0, emptystring
			syscall
	
skipnotzero:	# r += 1
				lw $t0, r # t0 = r
				addi $t0, $t0, 1 # t0 = r + 1
				sw $t0, r # r = t0
				
				# Jump back to starloop
				j starloop
	
continue:	# Print newline
			la $a0, newline
			addi $v0, $0, 4
			syscall

			# i += 1
			lw $t0, i # t0 = i
			addi $t0, $t0, 1 # t0 = i + 1
			sw $t0, i # i = t0

			# Jump back to whileloop	
			j whileloop
	
end:	# End program
		addi $v0, $0, 10
		syscall
