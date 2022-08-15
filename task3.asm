# Your job to fill in! :)

    .data

fill: .asciiz "You haven't started task 3 yet\n"

the_list: .word 0

smash_count: .word 0
i: .word 0
temp: .word 0
diff: .word 0
hulk_smash: .asciiz "Hulk SMASH! >:("
hulk_sad: .asciiz "Hulk Sad :("

newline: .asciiz "\n"

    .text

la $a0, fill
addi $v0, $0, 4
syscall

inputloop:
lw $t0, i
lw $t1, array_length
slt $t2, $t0, $t1 # if t0 < t1, then t2 = 1
beq $t2, $0, while # if t2 = 0, branch to end

lw # Load the_list[i] 
# Subtract hulk_power
# If 

while:
lw $t0, size
sw $t0, len_the_list

lw $t0, i
lw $t1, len_the_list
slt $t2, $t0, $t1 # if t0 < t1, then t2 = 1
beq $t2, $0, end # if t2 = 0, branch to end

lw $t0, i
sll $t0, $t0, 2
lw $t1, the_list
addi $t0, $t1, 0
lw $t2, 4($t1)
sw $t2, temp

lw $t0, temp
lw $t1, hulk_smash
sub $t2, $t0, $t1
sw $t2, diff

lw $t0, diff
slt $t1, $t0, $0 # if t0 < 0, then t1 = 1
bne $t0, $0, hulksmash

la $a0, hulk_sad
addi $v0, $0, 4
syscall
la $a0, newline
addi $v0, $0, 4
syscall

hulksmash:
la $a0, hulk_smash
addi $v0, $0, 4
syscall
la $a0, newline
addi $v0, $0, 4
syscall

lw $t0, smash_count
addi $t1, $t0, 1
sw $t1, smash_count

# End program
end:
lw $a0, smash_count
addi $v0, $0, 1
syscall
la $a0, newline
addi $v0, $0, 4
syscall

addi $v0, $0, 10
syscall
