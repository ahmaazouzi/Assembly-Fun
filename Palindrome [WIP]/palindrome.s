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
  # Size of a buffer that will hold text input
  bufferSize = 2048
  # Simple strings with their sizes
  palindromeConfirmed: .ascii "Wyraz jest palindromem\n"
  palindromeConfirmedSize: .int .-palindromeConfirmed
  palindromeFailed: .ascii "Wyraz nie jest palindromem\n"
  palindromeFailedSize: .int .-palindromeFailed

.bss
  .comm input, bufferSize
  .comm reversed, bufferSize

.text
  .globl _start

_start:
  jmp _read_word

_read_word:
  movl $SYS_READ, %eax
  movl $STDIN, %ebx
  movl $input, %ecx
  movl $bufferSize, %edx
  int $0x80

_print_word:
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  movl $palindromeConfirmed, %ecx
  movl $palindromeConfirmedSize, %edx
  int $0x80

_end:
  movl $SYS_EXIT, %eax
  movl $EXIT_SUCCES, %ebx
  int $0x80
