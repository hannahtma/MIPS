# Your job to fill in! :)

    .data

fill: .asciiz "You haven't started task 2 yet\n"
height: .word 0
space: .asciiz " "
emptystring: .asciiz ""
valid_input: .word 0
zero: .word 0
five: .word 5

height_prompt: .asciiz "How tall do you want the tower: "
height_difference: .word 0

i: .word 0
s: .word 0
addheight: .word 0
plusi: .word 0
r: .word 0
a: .asciiz "A "
star: .asciiz "* "
negativeone: .word -1
one: .word 1

newline: .asciiz "\n"

    .text

la $a0, fill
addi $v0, $0, 4
syscall

# While valid_input == 0:
whilezero:
	
	# Print "How tall do you want the tower: "
	la $a0, height_prompt
	addi $v0, $0, 4
	syscall
	la $a0, newline
	addi $v0, $0, 4
	syscall

	# Take input for height
	addi $v0, $0, 5
	syscall
	sw $v0, height
	
	# Calculate if the height is >= 5
	lw $t0, height
	lw $t1, five
	sub $t2, $t0, $t1
	sw $t2, height_difference
	
	# If the height is less than 5, go back to whilezero
	lw $t0, height_difference
	slt $t1, $t0, $0
	bne $t1, $0, whilezero
	
	# Set valid_input to 1
	lw $t0, valid_input
	addi $t0, $0, 1
	sw $t0, valid_input

	lw $t0, height # load height
	lw $t1, one
	add $t2, $t1, $t0 # add 1 to height
	lw $t3, negativeone # load -1
	mult $t2, $t3 # (height + 1) * -1
	mflo $t4
	sw $t4, s # s = -5
	
continue:
	# While i < height:
	lw $t0, i # i = 0
	lw $t1, height # height = 5
	slt $t2, $t0, $t1 # if t0 < t1, then t2 = 1
	beq $t2, $0, end # if t2 = 0, branch to end
	
	lw $t0, i
	lw $t1, one
	add $t2, $t1, $t0 
	sw $t2, plusi # plusi = i + 1 = 1
	
	lw $t0, i
	lw $t1, negativeone
	mult $t0, $t1
	mflo $t2
	sw $t2, addheight # addheight = 0
	
firstloop:
	lw $t0, s
	lw $t1, addheight
	slt $t2, $t0, $t1 # if t0 < t1, then t2 = 1
	beq $t2, $0, secondloop # if t2 = 0, then branch to secondloop
	
	la $a0, space
	addi $v0, $0, 4
	syscall
	add $v0, $0, 4
        la $a0, emptystring
        syscall
	
	# s += 1
	lw $t0, s
	lw $t1, one
	add $t2, $t0, $t1 # s += 1
	sw $t2, s # s = -5
	
	j firstloop
	
secondloop:
	lw $t0, r
	lw $t1, plusi
	slt $t2, $t0, $t1 # if t0 < t1, then t2 = 1
	beq $t2, $0, next # if t2 = 0, then branch to end
	
	lw $t0, i
	beq $t0, $0, ifzero
	
	j notzero
	
	ifzero:
	la $a0, a
	addi $v0, $0, 4
	syscall
	add $v0, $0, 4
        la $a0, emptystring
        syscall
        
        notzero:
        la $a0, star
	addi $v0, $0, 4
	syscall
	add $v0, $0, 4
        la $a0, emptystring
        syscall
	
	# r += 1
	lw $t0, r
	lw $t1, one
	add $t2, $t1, $t0
	sw $t2, r
	
	j secondloop
	
next:
	la $a0, newline
	addi $v0, $0, 4
	syscall

	# i += 1
	lw $t0, i
	lw $t1, one
        add $t2, $t0, $t1
        sw $t2, i
        
        j continue
	
end:
# End program
addi $v0, $0, 10
syscall
