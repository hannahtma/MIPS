# Your job to fill in! :)

    .data
tier_one_price: .word 9
tier_two_price: .word 11
tier_three_price: .word 14
discount_flag: .word 0

start: .asciiz "Welcome to the Thor Electrical Company!"
age_prompt: .asciiz "Enter your age: "
age: .word 0

consumption_prompt: .asciiz "Enter your total consumption in kWh: "
consumption: .word 0
total_cost: .word 0

gst: .word 0
total_bill: .word 0
end: .asciiz "Mr Loki Laufeyson, your electricity bill is $"
dollars: .word 0
cents: .word 0

fullstop: .asciiz "."
newline: .asciiz "\n"

    .text
                # Print "Welcome to the Thor Electrical Company!"
                la $a0, start
                addi $v0, $0, 4
                syscall
                # Print newline
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

                # if age <= 18
                lw $t0, age # t0 = age
                add $t1, $0, 18 # t1 = 18 
                slt $t2, $t1, $t0 # if 18 < age, then t2 = 1
                bne $t2, $0, nodiscount # if t2 != 0, branch to nodiscount

                # if age >= 65
                lw $t0, age # t0 = age
                addi $t1, $0, 65 # t1 = 65
                slt $t2, $t0, $t1 # if age < 65, then t2 = 1
                bne $t2, $0, nodiscount # if t2 != 0, then branch to nodiscount

                # discount_flag = 1
                sw $0, discount_flag
        
                j continue

nodiscount:     # discount_flag = 0
                sw $0, discount_flag

                j continue

continue:   # Print "Enter your total consumption in kWh: "
            la $a0, consumption_prompt
            addi $v0, $0, 4
            syscall

            # Take input for consumption
            addi $v0, $0, 5
            syscall
            sw $v0, consumption

            lw $t0, discount_flag
            bne $t0, $0, discounted

            # Tier 3 with no discount
            # if consumption > 1000 and discount_flag == 0:
            addi $t0, $0, 1000 # t0 = 1000
            lw $t1, consumption # t1 = consumption
            slt $t2, $t0, $t1 # if 1000 < consumption, then t2 = 1
            beq $t2, $0, next # if t2 == 0, then branch to next

            # total_cost = total_cost + ((consumption - 1000) * tier_three_price)
            lw $t0, consumption # t0 = consumption
            addi $t1, $0, 1000 # t1 = 1000
            sub $t2, $t0, $t1 # t2 = consumption - 1000
            lw $t0, tier_three_price # t0 = tier_three_price
            mult $t0, $t2 # tier_three_price * t2
            mflo $t3 # t3 = tier_three_price * t2
            lw $t0, total_cost # t0 = total_cost
            add $t4, $t0, $t3 # t4 = total_cost + tier_three_price * (consumption-1000)
            sw $t4, total_cost # total_cost = t4

            # consumption = 1000
            addi $t0, $0, 1000 # t0 = 1000
            sw $t0, consumption # consumption = 1000

            j next

discounted: # Tier 3 with discount
            # elif consumption > 1000:
            addi $t0, $0, 1000 # t0 = 1000
            lw $t1, consumption # t1 = consumption
            slt $t2, $t0, $t1 # if 1000 < consumption, then t2 = 1
            beq $t2, $0, next # if t2 == 0, then branch to next

            # total_cost = total_cost + ((consumption - 1000) * (tier_three_price - 2))
            lw $t0, consumption # t0 = consumption
            addi $t1, $0, 1000 # t1 = 1000
            sub $t2, $t0, $t1 # t2 = consumption - 1000
            lw $t0, tier_three_price # t0 = tier_three_price
            addi $t1, $t0, -2 # t1 = tier_three_price + (-2)
            mult $t1, $t2 # (tier_three_price - 2) * (consumption - 1000)
            mflo $t3 # t3 = (tier_three_price - 2) * (consumption - 1000)
            lw $t0, total_cost # t0 = total_cost
            add $t4, $t0, $t3 # t4 = total_cost + (tier_three_price - 2) * (consumption - 1000)
            sw $t4, total_cost # total_cost = t4

            # consumption = 1000
            addi $t0, $0, 1000 # t0 = 1000
            sw $t0, consumption # consumption = 1000

next:   # Tier 2
        # if consumption > 600:
        lw $t0, consumption # t0 = consumption
        addi $t1, $0, 600 # t1 = 600
        slt $t2, $t1, $t0 # if 600 < consumption, then t2 = 1
        beq $t2, $0, finish # if t2 == 0, then branch to finish

        # total_cost = total_cost + ((consumption - 600) * tier_two_price)
        lw $t0, consumption # t0 = consumption
        addi $t1, $0, 600 # t1 = 600
        sub $t2, $t0, $t1 # t2 = consumption - 600
        lw $t0, tier_two_price # t0 = tier_two_price
        mult $t0, $t2 # tier_two_price * (consumption - 600)
        mflo $t3 # t3 = tier_two_price * (consumption - 600)
        lw $t0, total_cost # t0 = total_cost
        add $t4, $t0, $t3 # t4 = total_cost + tier_two_price * (consumption - 600)
        sw $t4, total_cost # total_cost = t4

        # consumption = 600
        addi $t0, $0, 600 # t0 = 600
        sw $t0, consumption # consumption = 600

finish: # Tier 1
        # total_cost = total_cost + (consumption * tier_one_price)
        lw $t0, consumption # t0 = consumption
        lw $t1, tier_one_price # t1 = tier_one_price
        mult $t0, $t1 # consumption * tier_one_price
        mflo $t2 # t2 = consumption * tier_one_price
        lw $t0, total_cost # t0 = total_cost
        add $t1, $t0, $t2 # t1 = total_cost + consumption * tier_one_price
        sw $t1, total_cost # total_cost = t1

        # gst = total_cost // 10
        lw $t0, total_cost # t0 = total_cost
        addi $t1, $0, 10 # t1 = 10
        div $t0, $t1 # total_cost / 10
        mflo $t0 # t0 = total_cost // 10
        sw $t0, gst # gst = total_cost // 10

        # total_bill = total_cost + gst
        lw $t0, total_cost # t0 = total_cost
        lw $t1, gst # t1 = gst
        add $t2, $t0, $t1 # t2 = total_cost + gst
        sw $t2, total_bill # total_bill = total_cost + gst

        # print(f"Mr Loki Laufeyson, your electricity bill is ${total_bill // 100}.{total_bill % 100}"))
        lw $t0, total_bill # t0 = total_bill
        addi $t1, $0, 100 # t1 = 100
        div $t0, $t1 # t0 / t1
        mflo $t0 # t0 = t0 // t1
        mfhi $t1 # t2 = t0 % t1

        # print(f"Mr Loki Laufeyson, your electricity bill is ${total_bill // 100}.{total_bill % 100}")
        # Print "Mr Loki Laufeyson, your electricity bill is $"
        la $a0, end 
        addi $v0, $0, 4
        syscall
        # Print the dollars amount
        addi $a0, $t0, 0
        addi $v0, $0, 1
        syscall
        # Print a fullstop
        la $a0, fullstop
        addi $v0, $0, 4
        syscall
        # Print the cents amount
        addi $a0, $t1, 0
        addi $v0, $0, 1
        syscall
        # Print newline
        la $a0, newline
        addi $v0, $0, 4
        syscall

        # End program
        addi $v0, $0, 10
        syscall
