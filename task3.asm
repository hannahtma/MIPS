# Your job to fill in! :)

    .data

fill: .asciiz "You haven't started task 3 yet\n"
smash_count: .word 0


    .text

la $a0, fill
addi $v0, $0, 4
syscall

addi $v0, $0, 10
syscall
