.data
  # System call codes
  SYSWRITE = 1
  SYSEXIT = 60
  # System output codes
  STDOUT = 1
  # Exit code
  EXIT_SUCCESS = 0
  # Text to print and it's length
  tekst: .ascii "Hello World\n"
  tekstLength = .-tekst

.text
  # Defining an entry point for our program
  .globl _start

# Starting label calls system SYSWRITE method with parameters
# SYSWRITE(OUT identifier, text, length of text)
_start:
  # Moving SYSWRITE code to register 'RAX'
  movq $SYSWRITE, %rax
  # Moving STD OUT code to register 'RDI'
  movq $STDOUT, %rdi
  # Moving text to 'RSI'
  movq $tekst, %rsi
  # And length of the text to 'RDX'
  movq $tekstLength, %rdx
  # Performing a syscall to run method
  syscall

# Finish
_end:
  # Moving EXIT code to register 'RAX'
  mov $SYSEXIT, %rax
  # Moving EXIT STATUS code to register 'RDI'
  mov $EXIT_SUCCESS, %rdi
  # And another syscall
  syscall
