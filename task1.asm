# Your job to fill in! :)

    .data

fill: .asciiz "You haven't started task 1 yet\n"
tier_one_price: .word 9
tier_two_price: .word 11
tier_three_price: .word 14
discount_flag: .word 0
newline: .asciiz "\n"
start: .asciiz "Welcome to the Thor Electrical Company"
age_prompt: .asciiz "Enter your age: "
consumption: .asciiz "Enter your total consumption in kWh: "
age: .word 0
high_age: .word 65
age_difference: .word 0

    .text

la $a0, fill
addi $v0, $0, 4
syscall

# Print "Welcome to the Thor Electrical Company"
la $a0, start
addi $v0, $0, 4
syscall
la, $a0, newline
addi, $v0, $0, 4
syscall

# Print "Enter your age: "
la $a0, age_prompt
addi $v0, $0, 4
syscall
la, $a0, newline
addi, $v0, $0, 4
syscall

# Take input for age
addi $v0, $0, 5
syscall
sw $v0, age

# Check age
lw $t0, high_age
lw $t1, age
sub $t2, $t1, $t0
sw $t2, age_difference



addi $v0, $0, 10
syscall
