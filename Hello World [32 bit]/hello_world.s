.data
  # System call codes
  SYS_EXIT = 1
  SYS_WRITE = 4
  # System output codes
  STDOUT = 1
  # Exit code
  EXIT_SUCCES = 0
  # Text to print and it's length
  text: .ascii "Hello\n"
  textLength: .long .-text

.text
  # Defining an entry point for our program
  .globl _start

# Starting label calls system SYSWRITE method with parameters
# SYSWRITE(OUT identifier, text, length of text)
_start:
  # Moving SYSWRITE code to register 'EAX'
  movl $SYS_WRITE, %eax
  # Moving STD OUT code to register 'EBX'
  movl $STDOUT, %ebx
  # Moving text to 'ECX'
  movl $text, %ecx
  # And length of the text to 'EDX'
  movl textLength, %edx
  # Performing a syscall to run method
  int $0x80

# Finish
_end:
  # Moving EXIT code to register 'EAX'
  movl $SYS_EXIT, %eax
  # Moving EXIT STATUS code to register 'EBX'
  movl $EXIT_SUCCES, %ebx
  # And another syscall
  int $0x80
