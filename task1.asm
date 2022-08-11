# Your job to fill in! :)

    .data

fill: .asciiz "You haven't started task 1 yet\n"
tier_one_price: .word 9
tier_two_price: .word 11
tier_three_price: .word 14
discount_flag: .word 0

start: .asciiz "Welcome to the Thor Electrical Company"
age_prompt: .asciiz "Enter your age: "
age: .word 0

low_age: .word 18
high_age: .word 65
age_difference: .word 0

consumption_prompt: .asciiz "Enter your total consumption in kWh: "
consumption: .word 0
total_cost: .word 0

thousand: .word 1000
consumption_difference: .word 0

gst: .word 0
total_bill: .word 0
end: .asciiz "Mr Loki Laufeyson, your electricity bill is $"
final_amount: .word 0

newline: .asciiz "\n"

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

# Check for less than 18
lw $t0, age
lw $t1, low_age
sub $t2, $t1, $t0
sw $t2, age_difference

lw $t0, age_difference
slt $t1, $t0, $0 # if t0 < 0, then t1 = 1. if not, t1 = 0
beq $t0, $0, iszero # if t0 = 0, branch to iszero
bne $t0, $0, checkhigh # if t0 != 0, branch to isnotzero

addi $t0, $0, 1
sw $t0, discount_flag

j continue

# If zero, set discount_flag = 1
iszero:
addi $t0, $0, 1
sw $t0, discount_flag

j continue

# Check for more than 65
checkhigh:
lw $t0, high_age
lw $t1, age
sub $t2, $t1, $t0
sw $t2, age_difference

lw $t0, age_difference
slt $t1, $t0, $0 # if t0 < 0, then t1 = 1. if not, t1 = 0
beq $t1, $0, iszero # check if t1 is zero

addi $t0, $0, 0
sw $t0, discount_flag

continue:
la $a0, discount_flag
addi $v0, $0, 1
syscall
la, $a0, newline
addi, $v0, $0, 4
syscall

# Print "Enter your total consumption in kWh: "
la $a0, consumption_prompt
addi $v0, $0, 4
syscall
la, $a0, newline
addi, $v0, $0, 4
syscall

# Take input for consumption
addi $v0, $0, 5
syscall
sw $v0, consumption

lw $t0, discount_flag
beq $t0, $0, discounted
bne $t0, $0, normal

discounted:
lw $t0, consumption
lw $t1, thousand
sub $t2, $t1, $t0
sw $t2, consumption_difference

lw $t0, consumption_difference
slt $t1, $t0, $0 # if consumption_difference < 0, t1 = 1
bne $t1, $0, normal

lw $t0, consumption
sub $t1, $t0, 1000
lw $t0, tier_three_price
mult $t0, $t1
mflo $t2
lw $t0, total_cost
add $t3, $t0, $t2
sw $t4, total_cost

lw $t0, consumption
sub $t1, $t0, $t0
sw $t1, consumption

normal:
lw $t0, consumption
sub $t1, $t0, 1000
lw $t0, tier_three_price
sub $t2, $t0, 2
mult $t1, $t2
mflo $t3
lw $t0, total_cost
add $t4, $t3, $t0
sw $t5, total_cost

lw $t0, consumption
sub $t1, $t0, $t0
sw $t1, consumption

# Print final amount
la $a0, end
addi $v0, $0, 4
syscall
la, $a0, final_amount
addi, $v0, $0, 1
syscall

# End program
addi $v0, $0, 10
syscall
