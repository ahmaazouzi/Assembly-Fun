.data
  # System call codes
  SYS_EXIT = 1
  SYS_WRITE = 4
  SYS_READ = 3
  # STD codes
  STDIN = 0
  STDOUT = 1
  # Exit code
  EXIT_SUCCES = 0
  # Distance between letters
  letterDistance = 'a' - 'A'
  # First and last letter desired in output word
  firstLetter = 'a'
  lastLetter = 'z'
  # Size of a buffer that will hold text input
  bufferSize = 2048
  # Size of user input, 0 at start
  textLength: .long 0

# Buffers to hold text and it's reversed verison
.bss
  .comm input, bufferSize
  .comm converted, bufferSize

.text
  .global _start

# Main function jumps to 1st label
_start:
  call _read_word
  call _convert_to_upper_case
  call _end

# Reads text from user
# Text is later stored in 'input' buffer
# and it's lenght is stored in 'EAX'
_read_word:
  # Code for SYSREAD
  movl $SYS_READ, %eax
  # Code for STD IN
  movl $STDIN, %ebx
  # Input buffer
  movl $input, %ecx
  # Input buffer size
  movl $bufferSize, %edx
  # SYSCALL
  int $0x80
  # Move input length to variable
  movl %eax, textLength
  # Return from call
  ret

# Contains loop that changes elements from lovercase to uppercase
# Calls '_write_leter_to_output' and '_print_converted_word'
_convert_to_upper_case:
  # Move 0 to register that will be used to index current letter
  movl $0, %edi

  _loop:
    # Compare index value with text length
    cmpl %edi, textLength
    # If equal, loop should end
    je _print_converted_word
    # Else, continue loop
    # Move single letter from 'input' buffer to register 'AL'
    movb input(, %edi, 1), %al
    # Compare value of given letter with smallest letter
    cmpb $firstLetter, %al
    # If value is below, write letter to buffer
    jb _write_leter_to_output
    # Compare value of given letter with highest letter
    cmpb $lastLetter, %al
    # If value is above, write letter to buffer
    ja _write_leter_to_output
    # If value is not between a - z, convert it
    # By subtracting letter distance
    subb $letterDistance, %al
    # And write converted letter
    jmp _write_leter_to_output

# Writes letter currently stored in 'AL' register
# To output buffer, and continues with _loop
_write_leter_to_output:
  # Copy letter to output buffer
  movb %al, converted(, %edi, 1)
  # Increase index
  incl %edi
  # Retrn to loop
  jmp _loop

# Prints word from converted buffer to STD OUT
_print_converted_word:
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  movl $converted, %ecx
  movl textLength, %edx
  int $0x80
  ret

# End program with success code
_end:
  movl $SYS_EXIT, %eax
  movl $EXIT_SUCCES, %ebx
  int $0x80
