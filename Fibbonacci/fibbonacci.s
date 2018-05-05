.data
  # System call codes
  SYS_EXIT = 1
  SYS_WRITE = 4
  SYS_READ = 3
  STDIN = 0
  STDOUT = 1
  EXIT_SUCCES = 0
  # Size of buffer holding numbers
  bufferSize = 256
  # Index of fibbonaci number
  fibIndex = 5

# Declaring buffers holding numbers a and b
# Each one storing 256 bytes
.bss
  .comm numberA, bufferSize
  .comm numberB, bufferSize

# Define start function
.text
  .globl _start

# Beggining of executable part
_start:

  # Move 255 (256 - 1)
  # to %edi
  # represents index of last byte in buffer
  movl $255, %edi
  # Move 0 and 1 (1st two fibbonacci numbers)
  # To buffers
  movb $0, numberA(, %edi, 1)
  movb $1, numberB(, %edi, 1)

  # %esi represents latest calsulated
  # of fibbonacci sequence
  movl $2, %esi

  # %ecx stores a flag, containing 0 or 1
  # on 0 adds element to A, on 1 adds element to B
  movl $0, %ecx

# Loop iterates for each required element
# Of fibbonaci sequence required to get last desired one
external_loop:
  # Increment %esi, so it stores
  # Element that will be calculated
  # In current loop iteration
  incl %esi

  # Compare %esi with desired fibbonaci number
  # If greates, end external loop
  cmp $fibIndex, %esi
  jg finish_external_loop

  # Else, continue external loop
  # Set %edi index after the
  # latest byte position in buffer
  movl $256, %edi

  # Clear carry flag
  clc
  # Push flags to stack, to avoid popping an empty
  # Stack in 1st iteration of loop
  pushf

  # Loop iterates over each byte in buffers
  internal_loop:

    # Decrement %edi to move index to latest
    # Byte in buffer
    decl %edi

    # Move one byte from each buffer
    # To registers %al and %ah
    movb numberA(, %edi, 1), %al
    movb numberB(, %edi, 1), %bl

    # Remove flags stored on stack
    popf
    # Add bytes moved from buffers to registers
    # Saving carry flag
    adc %al, %bl
    # Push carry to stack
    # To avoid losing it's content
    pushf

    # Check index declared earlier
    # If it's 0, save calculated sum to A
    # If it's 1, save it to B
    cmp $0, %ecx
    je save_to_A

    save_to_B:
      # Move byte to correct position in buffer numberB
      movb %bl, numberB(, %edi, 1)
      # Jump tovthe end of loop
      jmp return

    save_to_A:
      # Move byte to correct position in buffer numberA
      movb %bl, numberA(, %edi, 1)

    return:
      # Compare 0 with %edi
      # If equal, finish internal loop
      # Else, begin new iteration
      cmp $0, %edi
      je finish_internal_loop
      jmp internal_loop

    finish_internal_loop:
      # Changes %ecx from zero to one
      # and otherwise
      # Jumps to external loop afterwards
      cmp $0, %ecx
      je switch_to_one

      switch_to_zero:
        decl %ecx
        jmp external_loop

      switch_to_one:
        incl %ecx
        jmp external_loop

  # Finish of program
  finish_external_loop:
    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $0x80
