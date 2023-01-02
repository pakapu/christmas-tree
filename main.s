    .text
    .global main
main:
    call draw_tree

    xorq %rax, %rax
    ret

draw_tree:
    movq $4, %rdi # thingy on top
    movq $spacer, %rsi
    call print_times

    movq $star, %rdi
    xorq %rax, %rax
    call printf

    movq $1, %rcx
    continue_tree_loop: # prints all branches
        pushq %rcx
        movq $2, %rax
        tree_branches_loop: # prints a branch
            pushq %rax # spaces at the front
            pushq %rcx

            xorq %rdx, %rdx
            movq %rcx, %rax
            movq $2, %rbx
            divq %rbx

            movq $3, %rbx
            subq %rax, %rbx

            movq %rbx, %rdi
            movq $spacer, %rsi
            call print_times

            popq %rcx
            popq %rax

            pushq %rax # pretty stuff at the front
            pushq %rcx
            movq $slash, %rdi
            xorq %rax, %rax
            call printf
            popq %rcx
            popq %rax

            pushq %rax # main fluff
            pushq %rcx
            movq %rcx, %rdi
            movq $background, %rsi
            call print_times
            popq %rcx
            popq %rax

            pushq %rax # pretty stuff at the end
            pushq %rcx
            movq $backslash, %rdi
            xorq %rax, %rax
            call printf
            popq %rcx
            popq %rax

            decq %rax
            cmpq $0, %rax
            jne tree_branches_loop
        popq %rcx

        addq $2, %rcx
        cmpq $7, %rcx
        jle continue_tree_loop

    movq $3, %rdi # trunk
    movq $spacer, %rsi
    call print_times

    movq $trunk, %rdi
    xorq %rax, %rax
    call printf

    movq $9, %rdi # base
    movq $base, %rsi
    call print_times

    movq $new_line, %rdi
    xorq %rax, %rax
    call printf

    ret

print_times:
    decq %rdi
    cmpq $0, %rdi
    jl end_print_times

    pushq %rdi
    pushq %rsi

    movq %rsi, %rdi
    xorq %rsi, %rsi
    xorq %rax, %rax
    call printf

    popq %rsi
    popq %rdi

    jmp print_times

    end_print_times:
        ret


    .data
num_format:
    .asciz "%lld "
spacer:
    .asciz " "
background:
    .asciz "#"
backslash:
    .asciz "\\\n"
slash:
    .asciz "/"
new_line:
    .asciz "\n"
base:
    .asciz "-"
trunk:
    .asciz "| |\n"
star:
    .asciz "^\n"
