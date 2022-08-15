# Your job to fill in! :)

    .data

tier_one_price: .word 9
tier_two_price: .word 11
tier_three_price: .word 14
discount_flag: .word 0

start: .asciiz "Welcome to the Thor Electrical Company!"
age_prompt: .asciiz "Enter your age: "
age: .word 0

low_age: .word 18
high_age: .word 65
age_difference: .word 0

consumption_prompt: .asciiz "Enter your total consumption in kWh: "
consumption: .word 0
total_cost: .word 0

thousand: .word 1000
six_hundred: .word 600
consumption_difference: .word 0

gst: .word 0
total_bill: .word 0
end: .asciiz "Mr Loki Laufeyson, your electricity bill is $"
dollars: .word 0
cents: .word 0

fullstop: .asciiz "."
newline: .asciiz "\n"

    .text

# Print "Welcome to the Thor Electrical Company"
la $a0, start
addi $v0, $0, 4
syscall
la $a0, newline
addi $v0, $0, 4
syscall

# Print "Enter your age: "
la $a0, age_prompt
addi $v0, $0, 4
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
# Print "Enter your total consumption in kWh: "
la $a0, consumption_prompt
addi $v0, $0, 4
syscall

# Take input for consumption
addi $v0, $0, 5
syscall
sw $v0, consumption

lw $t0, discount_flag
beq $t0, $0, normal
bne $t0, $0, discounted

normal:
# Normal more than 1000kWh
lw $t0, thousand
lw $t1, consumption
sub $t2, $t1, $t0
sw $t2, consumption_difference

lw $t0, consumption_difference
slt $t1, $t0, $0 # if consumption_difference < 0, t1 = 1
bne $t1, $0, next

lw $t0, consumption
lw $t1, thousand
sub $t2, $t0, $t1
lw $t0, tier_three_price
mult $t0, $t2
mflo $t3
lw $t0, total_cost
add $t4, $t0, $t3
sw $t4, total_cost

lw $t0, thousand
sw $t1, consumption

j next

# Discounted more than 1000kWh
discounted:
lw $t0, thousand
lw $t1, consumption
sub $t2, $t1, $t0
sw $t2, consumption_difference

lw $t0, consumption_difference
slt $t1, $t0, $0 # if consumption_difference < 0, t1 = 1
bne $t1, $0, next

lw $t0, consumption
lw $t1, thousand
sub $t2, $t0, $t1
lw $t0, tier_three_price
subi $t1, $t0, 2
mult $t1, $t2
mflo $t3
lw $t0, total_cost
add $t4, $t0, $t3
sw $t4, total_cost

lw $t0, thousand
sw $t0, consumption

next:
# more than 600
lw $t0, consumption
lw $t1, six_hundred
sub $t2, $t0, $t1
sw $t2, consumption_difference

lw $t0, consumption_difference
slt $t1, $t0, $0 # if consumption_difference < 0, t1 = 1
bne $t1, $0, finish

lw $t0, consumption
lw $t1, six_hundred
sub $t2, $t0, $t1
lw $t0, tier_two_price
mult $t0, $t2
mflo $t3
lw $t0, total_cost
add $t4, $t0, $t3
sw $t4, total_cost

lw $t0, six_hundred
sw $t1, consumption

finish:
lw $t0, consumption
lw $t1, tier_one_price
mult $t0, $t1
mflo $t2
lw $t0, total_cost
add $t1, $t0, $t2
sw $t1, total_cost

lw $t0, total_cost
addi $t1, $0, 10
div $t0, $t1
mflo $t0
sw $t0, gst

lw $t0, total_cost
lw $t1, gst
add $t2, $t1, $t0
sw $t2, total_bill

lw $t0, total_bill
addi $t1, $0, 100
div $t0, $t1
mflo $t0
sw $t0, dollars

lw $t0, total_bill
addi $t1, $0, 100
div $t0, $t1
mfhi $t0
sw $t0, cents

# Print final amount
la $a0, end
addi $v0, $0, 4
syscall
lw $a0, dollars
addi $v0, $0, 1
syscall
la $a0, fullstop
addi $v0, $0, 4
syscall
lw $a0, cents
addi $v0, $0, 1
syscall

# End program
addi $v0, $0, 10
syscall
