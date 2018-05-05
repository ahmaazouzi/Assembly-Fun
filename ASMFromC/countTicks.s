.data

.text
.global my_cpuid
.type my_cpuid, @function

my_cpuid:

    # Save stack, so it doesn't go missing
    push %rbp
    # Save stack pointer to defferent register
    mov %rsp, %rbp

    # Parameter is stored inside rdi
    # Compare pasrameter value with provided
    # call separate method if they match
    cmp $0, %rdi
    je param_is_0
    cmp $1, %rdi
    je param_is_1

    # Parameter is not equal to 0 or 1
    # Call rdtsc only
    param_is_else:
        rdtsc
        jmp merge_edx_eax

    # Parameter is equal to 0
    # Loop over rdtsc a few times
    param_is_0:
        
        # Move stack pointer to create space
        # For local WORD wariable
        sub $4, %rsp

        # Move 10 to desired space
        movl $10, -4(%rbp)

        loop:
            rdtsc
            # Get value stored in stack frame
            # (local variable)
            movl -4(%rbp), %ecx
            # Decremend counter
            decl %ecx
            # Move decremented value back to stack
            movl %ecx, -4(%rbp)
            # Compare counter with 0
            cmp $0, %ecx
            # If equalm, finish loop
            # Else, go to next iteration
            je merge_edx_eax
            jmp loop

    # Parameter is equal to 1
    # Empty %eax, call cpuid
    # And call rdtsc
    param_is_1:
        # Clear %eax, required by cpuid
        xor %eax, %eax
        # Get processor info
        cpuid
        # Read number of processor ticks
        # Output is stored in %edx and %eax
        rdtsc
        jmp merge_edx_eax

    # Join registers %edx and %eax
    # Into one 64bit registers
    merge_edx_eax:
        # Move 32 bytes from %edx
        # To beggining of %rdx
        shl $32, %rdx
        # Move content of %rdx to %rax
        or %rdx, %rax

    finish:
        # Restore stack pointer
        mov %rbp, %rsp
        # Restore stack
        pop %rbp
ret